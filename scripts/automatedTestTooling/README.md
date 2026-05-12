# Automated Test Tooling

Python utilities that support the Robot Framework tests under [`robot/`](../../robot/). These are **not tests themselves** — they generate test data, run the suite, and keep the master spreadsheet in sync with the automated coverage.

All scripts assume the **project root** is the current working directory. Run them as e.g.:

```powershell
py -3.12 scripts/automatedTestTooling/update_cfsuite_automation_refs.py
```

| Script | Purpose |
|---|---|
| `ensure_sr_baseline.py` | Verifies / creates the SR test baseline (3 Person Accounts: Hammy / Hilda / Horatio Hampster). Auto-detects scratch vs sandbox via cci org config: writes on scratch by default, dry-runs on sandbox by default. `--write` and `--dry-run` flags override. |
| `ensure_rates_baseline.py` | Wraps `ensure_sr_baseline.py` and additionally ensures 5 Properties + 7 Property_Customer relationships exist. Same auto-detect / write-mode behaviour. Run this before any robot test under `robot/tests/rates/`. |
| `run_tests.py` | Runs robot tests against a chosen org and writes per-test evidence (logs, video, screenshots) to `robot/evidence/<timestamp>_<suite>_<org>/`. Supports `--suite rates|requests`, `--test <pattern>`, defaults to all suites. |
| `renumber_to_cfsuite_scheme.py` | One-shot script used 2026-05-12 to rename REQ-* tests to CFSUITE-SR-* and add the `Target Automation Reference` column. Reusable if the spreadsheet's section structure changes again. |
| `update_cfsuite_automation_refs.py` | Idempotent: auto-discovers every `CFSUITE-*.robot` file and refreshes the `Automation Reference` column in `documentation/Automated Testing CFSuite.xlsx`. No hardcoded mapping to maintain. |
| `extract_test_data.py` | Extracts a known-good slice of an org (3 person accounts, 5 properties, settings) into a CumulusCI dataset under `datasets/automatedTestingData/` so a fresh scratch org can be seeded reproducibly. |
| `populate_test_spreadsheet.py` | Reads the canonical Rates Portal Master Test Plan and regenerates the rates section of `documentation/Automated Testing.xlsx`. Currently uses absolute paths — edit the constants at top of file before running. |

## Quick start: prep an org

```powershell
# Scratch (writes by default)
py -3.12 scripts/automatedTestTooling/ensure_sr_baseline.py --org dev_namespaced_1

# Sandbox (dry-run by default; preview gaps first)
py -3.12 scripts/automatedTestTooling/ensure_sr_baseline.py --org Release_156v4
# Then actually create what's missing
py -3.12 scripts/automatedTestTooling/ensure_sr_baseline.py --org Release_156v4 --write

# For rates tests, use the rates fixture instead (it includes SR)
py -3.12 scripts/automatedTestTooling/ensure_rates_baseline.py --org <alias> [--write]
```

## Conventions

- **Robot test file naming:** `CFSUITE-{Area}-{N}` for new tests sourced from the CFSuite spreadsheet (Area = SR for Service Requests & Case Management, etc.). Numbers run sequentially within an area; the `[Documentation]` block on each test records the source `CoM-Test-XXX` row.
- **Spreadsheet:** [`documentation/Automated Testing CFSuite.xlsx`](../../documentation/Automated%20Testing%20CFSuite.xlsx) is the master. The `Automation Reference` column is populated by `update_cfsuite_automation_refs.py` — don't edit it by hand.
- **Test-record prefix:** any record created *during* a test run (Case Subject etc.) carries `CFSUITE-TEST-` so it's trivial to spot in a sandbox.
- **Sandbox safety:** the fixture scripts default to dry-run on non-scratch orgs. Pass `--write` explicitly to insert.
- **Manual setup that cannot be automated:** admin Role, community user enablement (per account), community publish, named credentials. Fixtures check these and fail with the exact manual step required.
- **Scratch artifacts:** any file in `scripts/` (any depth) starting with `_` is gitignored — fine for ad-hoc inspection, but if it's worth keeping, rename it (drop the underscore) and move it here.
