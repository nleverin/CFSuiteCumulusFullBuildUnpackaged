"""Ensure the Service Requests & Case Management test baseline exists in
a target org (scratch or sandbox).

Baseline contents:
- 3 Person Accounts: Hammy Hampster, Hilda Hampster, Horatio Hampster.

Read-only checks (reported as gaps, fixable only manually):
- Admin user has a UserRoleId.
- Each baseline Person Account has an active community user.

Write-mode behaviour:
- Scratch orgs:   writes by default.
- Sandboxes etc.: dry-run by default; pass --write to actually insert.

Usage:
    python scripts/automatedTestTooling/ensure_sr_baseline.py --org dev_namespaced_1
    python scripts/automatedTestTooling/ensure_sr_baseline.py --org Release_156v4 --write
    python scripts/automatedTestTooling/ensure_sr_baseline.py --org dev_namespaced_1 --dry-run
"""
from __future__ import annotations

import argparse
import sys
from dataclasses import dataclass

from cumulusci.cli.runtime import CliRuntime
from cumulusci.salesforce_api.utils import get_simple_salesforce_connection


@dataclass(frozen=True)
class PersonAccount:
    """Defines one Person Account fixture row."""
    first_name: str
    last_name: str
    person_email: str
    authority_id: str = ""

    @property
    def display_name(self) -> str:
        return f"{self.first_name} {self.last_name}"


# Matches the existing CCI dataset in datasets/automatedTestingData/data.sql
BASELINE_PERSON_ACCOUNTS = [
    PersonAccount("Hammy",   "Hampster", "hammy.hampster@test.example.com",  authority_id="302300"),
    PersonAccount("Hilda",   "Hampster", "hilda.hampster@test.example.com"),
    PersonAccount("Horatio", "Hampster", "horatio.hampster@test.example.com"),
]


def get_salesforce_client(org_alias: str):
    """Return (sf_client, org_config) for the named cci org."""
    runtime = CliRuntime()
    name, org_config = runtime.get_org(org_alias)
    sf = get_simple_salesforce_connection(runtime.project_config, org_config)
    return sf, org_config


def is_scratch_org(org_config) -> bool:
    """True for scratch orgs; False for sandboxes / connected orgs."""
    return bool(getattr(org_config, "scratch", False))


def query_one(sf, soql: str) -> dict | None:
    res = sf.query(soql)
    return res["records"][0] if res["totalSize"] else None


def query_all(sf, soql: str) -> list[dict]:
    return sf.query(soql)["records"]


def find_person_account_record_type_id(sf) -> str:
    row = query_one(
        sf,
        "SELECT Id FROM RecordType "
        "WHERE SobjectType = 'Account' AND IsPersonType = TRUE LIMIT 1",
    )
    if row is None:
        raise SystemExit("FATAL: no Person Account RecordType found in target org.")
    return row["Id"]


def find_existing_baseline_accounts(sf) -> dict[str, dict]:
    """Return {display_name: account_record} for the 3 baseline accounts that exist."""
    names = "', '".join(p.display_name for p in BASELINE_PERSON_ACCOUNTS)
    rows = query_all(
        sf,
        f"SELECT Id, Name, PersonContactId "
        f"FROM Account WHERE IsPersonAccount = TRUE "
        f"AND Name IN ('{names}')",
    )
    return {row["Name"]: row for row in rows}


def insert_person_account(sf, pa: PersonAccount, record_type_id: str) -> str:
    payload = {
        "FirstName":              pa.first_name,
        "LastName":               pa.last_name,
        "PersonEmail":            pa.person_email,
        "RecordTypeId":           record_type_id,
        "cfsuite1__Rates_notice_notifications__c": "No Notifications",
    }
    if pa.authority_id:
        payload["cfsuite1__Authority_ID__c"] = pa.authority_id
    result = sf.Account.create(payload)
    if not result.get("success"):
        raise RuntimeError(f"Account insert failed for {pa.display_name}: {result}")
    return result["id"]


def check_admin_role(sf, admin_username: str) -> tuple[bool, str]:
    row = query_one(
        sf,
        f"SELECT Id, UserRoleId FROM User WHERE Username = '{admin_username}' LIMIT 1",
    )
    if row is None:
        return False, f"Admin user '{admin_username}' not found"
    if row.get("UserRoleId"):
        return True, f"Admin has UserRoleId {row['UserRoleId']}"
    return False, (
        f"Admin '{admin_username}' has no UserRoleId. "
        f"Fix manually: Setup > Users > Edit > set a Role (any active role)."
    )


def check_community_user(sf, account_record: dict) -> tuple[bool, str]:
    contact_id = account_record.get("PersonContactId")
    name = account_record["Name"]
    if not contact_id:
        return False, f"{name}: account has no PersonContactId (not a Person Account?)"
    rows = query_all(
        sf,
        f"SELECT Id, Username, IsActive "
        f"FROM User WHERE ContactId = '{contact_id}' AND IsActive = TRUE LIMIT 1",
    )
    if not rows:
        return False, (
            f"{name}: no active community user. "
            f"Fix manually: open the account, dropdown > Enable Customer User "
            f"(License: Customer Community Login, Profile: 'cfsuite community login user')."
        )
    return True, f"{name}: community user {rows[0]['Username']}"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--org", required=True, help="cci org alias")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--write",   action="store_true", help="Force write mode (overrides sandbox dry-run default)")
    mode.add_argument("--dry-run", action="store_true", help="Force dry-run (overrides scratch write default)")
    args = parser.parse_args(argv)

    sf, org_config = get_salesforce_client(args.org)
    scratch = is_scratch_org(org_config)

    if args.write:
        write_mode = True
        mode_reason = "--write override"
    elif args.dry_run:
        write_mode = False
        mode_reason = "--dry-run override"
    else:
        write_mode = scratch
        mode_reason = ("scratch org -> write default" if scratch else "sandbox -> dry-run default")

    print(f"Org: {args.org}  ({'scratch' if scratch else 'sandbox/connected'})")
    print(f"Mode: {'WRITE' if write_mode else 'DRY-RUN'} ({mode_reason})\n")

    # -- Person Accounts ---------------------------------------------------
    print("== Person Accounts ==")
    existing = find_existing_baseline_accounts(sf)
    missing = [pa for pa in BASELINE_PERSON_ACCOUNTS if pa.display_name not in existing]

    for pa in BASELINE_PERSON_ACCOUNTS:
        rec = existing.get(pa.display_name)
        if rec:
            print(f"  OK    {pa.display_name}  (Id: {rec['Id']})")
        else:
            print(f"  GAP   {pa.display_name}  -- not present")

    if missing and write_mode:
        rt_id = find_person_account_record_type_id(sf)
        for pa in missing:
            try:
                acct_id = insert_person_account(sf, pa, rt_id)
                print(f"  +     Created {pa.display_name}  (Id: {acct_id})")
            except Exception as exc:
                print(f"  FAIL  Insert {pa.display_name} failed: {exc}")
        # Refresh the existing map after inserts
        existing = find_existing_baseline_accounts(sf)
    elif missing and not write_mode:
        print(f"  ({len(missing)} gap(s) NOT created -- dry-run. Pass --write to insert.)")

    # -- Admin Role check (read-only) --------------------------------------
    print("\n== Admin user role ==")
    admin_username = getattr(org_config, "username", None) or "(unknown)"
    ok, msg = check_admin_role(sf, admin_username)
    prefix = "  OK   " if ok else "  GAP  "
    print(f"{prefix}{msg}")

    # -- Community users (read-only) ---------------------------------------
    print("\n== Community users ==")
    community_gaps = 0
    for pa in BASELINE_PERSON_ACCOUNTS:
        rec = existing.get(pa.display_name)
        if rec is None:
            print(f"  SKIP  {pa.display_name} -- account not present")
            community_gaps += 1
            continue
        ok, msg = check_community_user(sf, rec)
        prefix = "  OK   " if ok else "  GAP  "
        print(f"{prefix}{msg}")
        if not ok:
            community_gaps += 1

    # -- Summary -----------------------------------------------------------
    print("\n== Summary ==")
    accounts_missing = len([pa for pa in BASELINE_PERSON_ACCOUNTS if pa.display_name not in find_existing_baseline_accounts(sf)])
    print(f"  Person Accounts missing: {accounts_missing}")
    print(f"  Community user gaps:     {community_gaps}")

    # Exit code: 0 only when everything we *can* fix automatically is in place.
    # Read-only gaps (admin role, community users) don't fail the script but
    # are surfaced to the operator.
    return 0 if accounts_missing == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
