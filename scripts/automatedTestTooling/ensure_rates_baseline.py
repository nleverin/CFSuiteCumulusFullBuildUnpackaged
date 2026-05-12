"""Ensure the Rates test baseline exists in a target org (scratch or sandbox).

Baseline contents:
- Everything from ensure_sr_baseline.py (3 Person Accounts).
- 5 Properties:
  - 37 Goldberry Street, 1 Cadisfly Alley, 32 Courage Square,
    1 Humbdinger Avenue, 32 Develish Court.
  - Properties are matched by Name prefix (the Names in the CCI dataset
    carry an "(A)" suffix; tests reference them without).
- 7 Property_Customer relationships linking the 5 properties to the
  Hampster accounts.

Quarterly balance data is intentionally NOT set here. Tests that need a
specific scenario call `Setup Property Quarter Dates And Balances` from
playwright_common.robot (or the generic populator in RATES-000) to set
the values they need on a per-run basis.

Write-mode behaviour and CLI mirror ensure_sr_baseline.py.

Usage:
    python scripts/automatedTestTooling/ensure_rates_baseline.py --org dev_namespaced_1
    python scripts/automatedTestTooling/ensure_rates_baseline.py --org Release_156v4 --write
"""
from __future__ import annotations

import argparse
import sys
from dataclasses import dataclass

import ensure_sr_baseline as sr


@dataclass(frozen=True)
class PropertyFixture:
    name: str
    assessment_number: str
    valuation_number: str


@dataclass(frozen=True)
class PropertyCustomer:
    """One link between an Account (by Name) and a Property (by Name prefix)."""
    account_name: str
    property_name: str
    relationship_type: str
    status: str = "Active"


BASELINE_PROPERTIES = [
    PropertyFixture("37 Goldberry Street (A)",  "113256",   "100006"),
    PropertyFixture("1 Cadisfly Alley (A)",     "100025",   "100025"),
    PropertyFixture("32 Courage Square (A)",    "149412",   "100007"),
    PropertyFixture("1 Humbdinger avenue (A)",  "171338",   "12347788"),
    PropertyFixture("32 Develish Court (A)",    "345",      "345"),
]

BASELINE_PROPERTY_CUSTOMERS = [
    # Hammy is Primary on Goldberry, Cadisfly, Develish; Previous Primary on
    # Humbdinger; Secondary on Courage Square.
    PropertyCustomer("Hammy Hampster",   "37 Goldberry Street (A)", "Primary"),
    PropertyCustomer("Hammy Hampster",   "1 Cadisfly Alley (A)",    "Primary"),
    PropertyCustomer("Hammy Hampster",   "32 Courage Square (A)",   "Secondary"),
    PropertyCustomer("Hammy Hampster",   "1 Humbdinger avenue (A)", "Previous Primary"),
    PropertyCustomer("Hammy Hampster",   "32 Develish Court (A)",   "Primary"),
    # Hilda secondary on Goldberry; Horatio agent on Cadisfly.
    PropertyCustomer("Hilda Hampster",   "37 Goldberry Street (A)", "Secondary"),
    PropertyCustomer("Horatio Hampster", "1 Cadisfly Alley (A)",    "Agent"),
]


def find_properties_by_name(sf) -> dict[str, dict]:
    names = "', '".join(p.name for p in BASELINE_PROPERTIES)
    rows = sr.query_all(
        sf,
        f"SELECT Id, Name FROM cfsuite1__Property__c WHERE Name IN ('{names}')",
    )
    return {row["Name"]: row for row in rows}


def insert_property(sf, prop: PropertyFixture) -> str:
    result = sf.__getattr__("cfsuite1__Property__c").create({
        "Name": prop.name,
        "cfsuite1__Assessment_Number__c": prop.assessment_number,
        "cfsuite1__Valuation_Number__c":  prop.valuation_number,
    })
    if not result.get("success"):
        raise RuntimeError(f"Property insert failed for {prop.name}: {result}")
    return result["id"]


def find_property_customer_links(sf, account_ids: list[str], property_ids: list[str]) -> list[dict]:
    if not account_ids or not property_ids:
        return []
    acct_in  = "', '".join(account_ids)
    prop_in  = "', '".join(property_ids)
    return sr.query_all(
        sf,
        "SELECT Id, cfsuite1__Customer__c, cfsuite1__Property__c, "
        "cfsuite1__Relationship_Type__c, cfsuite1__Relationship_Status__c "
        f"FROM cfsuite1__Property_Customer__c "
        f"WHERE cfsuite1__Customer__c IN ('{acct_in}') "
        f"AND cfsuite1__Property__c IN ('{prop_in}')",
    )


def insert_property_customer(sf, account_id: str, property_id: str, rel_type: str, status: str) -> str:
    result = sf.__getattr__("cfsuite1__Property_Customer__c").create({
        "cfsuite1__Customer__c":            account_id,
        "cfsuite1__Property__c":            property_id,
        "cfsuite1__Relationship_Type__c":   rel_type,
        "cfsuite1__Relationship_Status__c": status,
    })
    if not result.get("success"):
        raise RuntimeError(f"Property_Customer insert failed: {result}")
    return result["id"]


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--org", required=True, help="cci org alias")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--write",   action="store_true")
    mode.add_argument("--dry-run", action="store_true")
    args = parser.parse_args(argv)

    sf, org_config = sr.get_salesforce_client(args.org)
    scratch = sr.is_scratch_org(org_config)

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

    # -- Step 1: Person Accounts (reuse SR baseline logic) ----------------
    print("== Person Accounts ==")
    existing_accounts = sr.find_existing_baseline_accounts(sf)
    missing_accounts = [pa for pa in sr.BASELINE_PERSON_ACCOUNTS if pa.display_name not in existing_accounts]

    for pa in sr.BASELINE_PERSON_ACCOUNTS:
        rec = existing_accounts.get(pa.display_name)
        print(f"  {'OK   ' if rec else 'GAP  '}{pa.display_name}{f"  (Id: {rec['Id']})" if rec else '  -- not present'}")

    if missing_accounts and write_mode:
        rt_id = sr.find_person_account_record_type_id(sf)
        for pa in missing_accounts:
            try:
                acct_id = sr.insert_person_account(sf, pa, rt_id)
                print(f"  +    Created {pa.display_name}  (Id: {acct_id})")
            except Exception as exc:
                print(f"  FAIL Insert {pa.display_name}: {exc}")
        existing_accounts = sr.find_existing_baseline_accounts(sf)
    elif missing_accounts:
        print(f"  ({len(missing_accounts)} gap(s) NOT created -- dry-run. Pass --write to insert.)")

    account_id_by_name = {name: rec["Id"] for name, rec in existing_accounts.items()}

    # -- Step 2: Properties -----------------------------------------------
    print("\n== Properties ==")
    existing_properties = find_properties_by_name(sf)
    missing_properties = [p for p in BASELINE_PROPERTIES if p.name not in existing_properties]

    for prop in BASELINE_PROPERTIES:
        rec = existing_properties.get(prop.name)
        print(f"  {'OK   ' if rec else 'GAP  '}{prop.name}{f"  (Id: {rec['Id']})" if rec else '  -- not present'}")

    if missing_properties and write_mode:
        for prop in missing_properties:
            try:
                pid = insert_property(sf, prop)
                print(f"  +    Created {prop.name}  (Id: {pid})")
            except Exception as exc:
                print(f"  FAIL Insert {prop.name}: {exc}")
        existing_properties = find_properties_by_name(sf)
    elif missing_properties:
        print(f"  ({len(missing_properties)} gap(s) NOT created -- dry-run.)")

    property_id_by_name = {name: rec["Id"] for name, rec in existing_properties.items()}

    # -- Step 3: Property_Customer relationships --------------------------
    print("\n== Property_Customer relationships ==")
    if not (account_id_by_name and property_id_by_name):
        print("  SKIP -- accounts or properties missing; can't link.")
    else:
        existing_links = find_property_customer_links(
            sf,
            list(account_id_by_name.values()),
            list(property_id_by_name.values()),
        )
        # Index existing links by (account_id, property_id, type)
        link_keys = {
            (lk["cfsuite1__Customer__c"], lk["cfsuite1__Property__c"], lk["cfsuite1__Relationship_Type__c"])
            for lk in existing_links
        }

        for link in BASELINE_PROPERTY_CUSTOMERS:
            acct_id = account_id_by_name.get(link.account_name)
            prop_id = property_id_by_name.get(link.property_name)
            label = f"{link.account_name} -> {link.property_name} ({link.relationship_type})"
            if not acct_id or not prop_id:
                print(f"  SKIP {label}  -- account or property missing")
                continue
            key = (acct_id, prop_id, link.relationship_type)
            if key in link_keys:
                print(f"  OK   {label}")
                continue
            if write_mode:
                try:
                    pc_id = insert_property_customer(sf, acct_id, prop_id, link.relationship_type, link.status)
                    print(f"  +    Created {label}  (Id: {pc_id})")
                except Exception as exc:
                    print(f"  FAIL Create {label}: {exc}")
            else:
                print(f"  GAP  {label}  -- not present (dry-run)")

    # -- Step 4: Admin role + community users (read-only) -----------------
    print("\n== Admin role ==")
    admin_username = getattr(org_config, "username", None) or "(unknown)"
    ok, msg = sr.check_admin_role(sf, admin_username)
    print(f"  {'OK   ' if ok else 'GAP  '}{msg}")

    print("\n== Community users ==")
    refreshed_accounts = sr.find_existing_baseline_accounts(sf)
    community_gaps = 0
    for pa in sr.BASELINE_PERSON_ACCOUNTS:
        rec = refreshed_accounts.get(pa.display_name)
        if rec is None:
            print(f"  SKIP {pa.display_name} -- account not present")
            community_gaps += 1
            continue
        ok, msg = sr.check_community_user(sf, rec)
        print(f"  {'OK   ' if ok else 'GAP  '}{msg}")
        if not ok:
            community_gaps += 1

    # -- Summary -----------------------------------------------------------
    accounts_missing = len([pa for pa in sr.BASELINE_PERSON_ACCOUNTS if pa.display_name not in refreshed_accounts])
    properties_missing = len([p for p in BASELINE_PROPERTIES if p.name not in find_properties_by_name(sf)])

    print("\n== Summary ==")
    print(f"  Person Accounts missing:           {accounts_missing}")
    print(f"  Properties missing:                {properties_missing}")
    print(f"  Community user gaps (manual fix):  {community_gaps}")

    return 0 if (accounts_missing == 0 and properties_missing == 0) else 2


if __name__ == "__main__":
    sys.exit(main())
