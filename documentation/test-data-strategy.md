# Test Data Strategy

**Status:** plan only — no code yet. Drafted 2026-05-12.

## Goals

1. The whole automated suite can run against **any CFSuite org** (scratch or sandbox) without per-org code changes.
2. Required data is **verified-or-created** before tests start. Idempotent: re-running the same prep is a no-op.
3. **Per-area baselines** — the SR suite needs less data than the Rates suite, so loading the rates fixture on an SR-only run is wasted work.
4. Tests own the records they create *during* the test (cleanup at end). The baseline owns the records that exist *before* the test starts.

## Target environments

The fixture is **environment-agnostic** — any scratch org or sandbox imported into cci can be a valid target. Specifically known today:

| Alias | Type | Status | Notes |
|---|---|---|---|
| `dev_namespaced_1` | Scratch org (cci) | Working today | Used for the 2026-05-09 SR batch. |
| `Release_156v4` | Sandbox | Auth'd in `sf` (user `nathan@ennovative.com.au.156v4`), **not yet imported into cci** | Run `cci org import Release_156v4 Release_156v4` before targeting. |
| *any other scratch / sandbox* | either | Onboarded by `cci org import` / `cci org scratch` | Same fixture should work without changes. |

## Per-area baselines

| Area | Suite | Baseline contents |
|---|---|---|
| **SR** (Service Requests & Case Management) | `robot/tests/requests/` | 3 Person Accounts: Hammy, Hilda, Horatio Hampster. **No properties.** |
| **Rates** | `robot/tests/rates/` | Everything in SR baseline **plus** 5 Properties, 7 Property_Customer relationships, per-property quarterly balances, request flow records. Settings rows (CFSuiteRatesSettings / CFSuiteSettings) are *not* loaded by the fixture — environment-specific, must already exist. |

Both baselines share the 3 Person Accounts. The rates baseline is a strict superset.

## Per-test data dependencies (inventory)

### `robot/tests/requests/` (CFSUITE-SR-* + CRM-CASE-equivalents)

| File | What it needs |
|---|---|
| CFSUITE-SR-001 create_case_with_location | Configured request categories (Animals → Dog → Keeping Excess Dogs), GIS map iframe — **org config, not data** |
| CFSUITE-SR-003 create_case_from_account | Any Person Account |
| CFSUITE-SR-010 calculate_request_due_date | Self-contained |
| CFSUITE-SR-011 create_child_case | A parent Case (test creates one) + request categories |
| CFSUITE-SR-012 recategorise_case | A Case (test queries an existing one — assumes at least 1 case in org) |
| CFSUITE-SR-013 flag_request_as_emergency | Self-contained |
| CFSUITE-SR-014 due_date_visible_highlights | Self-contained |
| CFSUITE-SR-034 assign_case | **Brittle:** queries a Case with `Status='Assess and Assign'` *and* a User named `'User User'` (the scratch-org admin's default name). Won't survive on a sandbox where the admin has a different name. |
| CFSUITE-SR-035 link_interested_parties | Hammy Hampster + Hilda Hampster Person Accounts |
| CFSUITE-SR-038 track_request_history | Self-contained |
| CFSUITE-SR-081 community_follow_case | Hammy Hampster Person Account + active community user for that account |
| CFSUITE-SR-086 customer_portal_login | Hammy Hampster Person Account + active community user for that account |
| CFSUITE-SR-089 clone_case | A Case (test queries an existing one) |

### `robot/tests/rates/`

- **All 41 RATES-* and 8 CRM-CASE-* tests** depend on the Rates baseline (3 accounts + 5 properties + relationships + balances + community users + admin role).
- Property names referenced by name: at least `32 Develish Court` (most CRM-CASE-*) and `37 Goldberry Street` (CRM-CASE-10). Other property names appear in the CCI dataset but aren't directly named in tests.
- All rates community-portal tests use `Login As Community User    Hammy Hampster`.

## What CCI already gives us

[datasets/automatedTestingData/](../datasets/automatedTestingData/) is a CumulusCI dataset (`data.sql` + `mapping.yml`) that loads:
- 3 Person Accounts (Hammy, Hilda, Horatio Hampster)
- 5 Properties
- 7 Property_Customer relationships
- CFSuite_Request_Flow records (rates-related)

It explicitly **does not** load settings rows — those vary per org. Today it's loaded ad-hoc via `cci task run load_dataset -o mapping datasets/automatedTestingData/mapping.yml -o sql_path datasets/automatedTestingData/data.sql --org <alias>`.

[robot/tests/rates/RATES-000_org_setup.robot](../robot/tests/rates/RATES-000_org_setup.robot) is the existing verify-or-create test for the rates baseline. It:
- Asserts the admin user has a `UserRoleId` (fails with manual-step instructions if not).
- Asserts an active community user exists for each of Hammy / Hilda / Horatio (fails with manual-step instructions).
- Populates quarterly balance data on Properties via API where missing.

## Manual setup checklist (per new org)

These items **cannot** be automated reliably and must be done once per org by a human admin before tests will pass:

1. **Admin Role** — Setup → Users → admin user → set a UserRole (any).
2. **Community user enablement** — for each of Hammy / Hilda / Horatio:
   Account → ▾ → *Enable Customer User* → License = *Customer Community Login*, Profile = *cfsuite community login user*.
3. **Community publish** — Experience Builder → Publish.
4. **Named credentials** — for any test that hits an external API (rates module mostly).
5. **Picklist `cfsuite1__SLA__c` on the default Case record type must include `5`** (verified working on `dev_namespaced_1`).

The fixture script will *check* each of these and fail fast with the exact manual step to take, rather than try to automate them.

## Proposed implementation (when we move to code)

### Layer 1 — fixture scripts (Python, idempotent)
Location: `scripts/automatedTestTooling/`
- `ensure_sr_baseline.py --org <alias>` — verifies / creates the SR baseline (3 Person Accounts only).
- `ensure_rates_baseline.py --org <alias>` — runs the SR fixture *then* invokes `cci task run load_dataset` for the rates dataset, then verifies properties + balances.

Each script:
- Connects via CCI org config (so creds come from the cci alias, no hardcoded URLs).
- Uses the get-or-create / get-or-update pattern.
- Fails with a clear remediation instruction when the gap is a manual setup item.
- Exits 0 only when everything required is present and correct.

### Layer 2 — shared robot keywords
Location: `robot/tests/resources/test_data.robot`
- `Ensure SR Baseline` — wraps the Python fixture so a robot suite can call it from Suite Setup.
- `Ensure Rates Baseline` — same for rates.
- `Get Or Create Account By Name` — for tests that want to declare data needs inline.
- `Get Existing Case Or Skip` — for tests like CFSUITE-SR-012/089 that just need "any case" present (currently fail hard if no case exists).

### Layer 3 — retrofit tests with brittle assumptions
- **CFSUITE-SR-034** — replace `where=Name='User User'` with a query against the current org's admin user, or accept any active internal user.
- **CFSUITE-SR-012 / CFSUITE-SR-089** — replace `Salesforce Query Case ... limit=1` with the new `Get Existing Case Or Skip` (creates a throwaway case if needed).
- **CFSUITE-SR-001** — categories like "Animals → Dog → Keeping Excess Dogs" are managed-package metadata; should already exist on both envs but worth verifying as part of `ensure_sr_baseline`.

## Sandbox safety considerations

- **`CFSUITE-TEST-` prefix on every test-created record.** Cases use it on `Subject`, ad-hoc accounts (if any are ever created beyond the fixture's Hammy/Hilda/Horatio) use it on `Name`. The prefix makes test data trivially identifiable when triaging a busy sandbox.
- **Auto-detect write vs dry-run.** Fixture scripts use CumulusCI's org config to determine whether the target is a **scratch org** (writes by default) or a **sandbox/connected org** (dry-run by default — reports what's missing without inserting). An explicit `--write` flag overrides dry-run mode on a sandbox. This protects against accidental inserts into staging/UAT sandboxes when someone fat-fingers the alias.
- **Existing matches by coincidence.** If the sandbox happens to have an Account named `Hammy Hampster` from a prior demo, the fixture treats it as the test fixture (reuses it by name). Cleanup never deletes accounts — only test-created cases / interested parties / property customer relationships.
- **Cleanup boundary.** Tests delete only the IDs they themselves created (already the pattern). The fixture creates accounts / properties only if missing; it never deletes them.
- **Sandbox vs scratch divergence.** Document any sandbox-specific quirks in [memory/](../memory/) as they're discovered. Keep the fixture itself env-agnostic.

## Workflow once implemented

```powershell
# One-time per new sandbox (skip for scratch orgs created via cci)
cci org import <sf_alias> <cci_alias>

# Preview gaps (sandbox default is dry-run; scratch default is write)
python scripts/automatedTestTooling/ensure_sr_baseline.py --org <cci_alias>

# Actually create what's missing on a sandbox (opt-in)
python scripts/automatedTestTooling/ensure_sr_baseline.py --org <cci_alias> --write

# Run the SR suite
cci task run robot --org <cci_alias> --suites robot/tests/requests/
```

For rates: same shape but `ensure_rates_baseline.py` and `robot/tests/rates/`.

## Implementation phases (suggested ordering)

1. **`ensure_sr_baseline.py`** — covers the simplest baseline, 3 accounts. Validate against both `dev_namespaced_1` and `Release_156v4`.
2. **Retrofit SR-034 and SR-012/089** to remove brittle org-specific assumptions.
3. **`ensure_rates_baseline.py`** — wraps the existing CCI dataset load + balance population. Should be a thin layer over what RATES-000 already does.
4. **Layer 2 robot keywords** — once the Python fixtures are proven, expose them as robot keywords for inline use.

## Out of scope (revisit later)

- **CI integration.** Nightly / on-push automated runs against `Release_156v4` (or another sandbox). Worth doing once the four phases above are stable, but explicitly **not** in scope for this round.

## Decisions captured 2026-05-12

- **Test-record prefix:** every test-created record carries `CFSUITE-TEST-` in its identifying field (Case `Subject`, etc.).
- **Write safety:** fixture auto-detects target type via cci org config. **Scratch org → write by default**, **sandbox / connected org → dry-run by default**. Pass `--write` to override dry-run on a sandbox.
- **Target scope:** any scratch org or imported sandbox is a valid target. The fixture stays org-agnostic; no per-org hardcoding allowed in test code or scripts.
