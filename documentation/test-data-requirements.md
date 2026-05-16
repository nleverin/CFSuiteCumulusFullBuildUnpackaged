# Test Data Requirements

Living tracker for the data prerequisites of each automated CFSuite robot test under [`robot/tests/requests/`](../robot/tests/requests/).

**Workflow when adding a new test:**
1. Identify what data the test relies on (accounts, cases, settings, record types, etc.).
2. Add a row to the per-test table below with its requirements + source.
3. If a new requirement isn't covered by existing fixtures, extend `ensure_sr_baseline.py` or `ensure_rates_baseline.py` (or note as a manual-setup gap).
4. Build the test. If a requirement is missing at runtime, the test should fail fast with a clear remediation instruction (we already pattern this in `Ensure SR Baseline`).

## Data sources

| Source | Provides | Where |
|---|---|---|
| **`ensure_sr_baseline.py`** | 3 Person Accounts (Hammy, Hilda, Horatio Hampster) + admin Role check + community user check | [scripts/automatedTestTooling/ensure_sr_baseline.py](../scripts/automatedTestTooling/ensure_sr_baseline.py) |
| **`ensure_rates_baseline.py`** | SR baseline + 5 Properties + 7 Property_Customer relationships | [scripts/automatedTestTooling/ensure_rates_baseline.py](../scripts/automatedTestTooling/ensure_rates_baseline.py) |
| **Managed package (`cfsuite1__`)** | Record types (Standard_Request, Display_Category, Case_Assignment, etc.); request categories (Animals > Dog > etc.); validation rules; triggers; out-of-box Case Assignment Request Flow records | Comes with package install |
| **Per-test fallback** | `Get Existing Case Or Create Fallback` creates a throwaway Case if no case exists | [robot/tests/resources/test_data.robot](../robot/tests/resources/test_data.robot) |
| **Manual org setup** | Admin user has a UserRoleId; community users enabled per Person Account; community published; named credentials | One-time per org by an admin; the fixtures detect these and fail fast with instructions |

## Per-test requirements

Status legend: `OK` = data available in target orgs; `gap` = needs new fixture work or manual setup; `manual` = relies on one-time org setup.

### Self-contained tests (creates + deletes its own records)

These don't depend on any fixture data — they each insert a Case via API and clean up after themselves.

| Test | Notes |
|---|---|
| CFSUITE-SR-010 | Calculate Due Date — API-only field update |
| CFSUITE-SR-013 | Flag Emergency — flips `Is_Hazard__c` on a new case |
| CFSUITE-SR-014 | Due Date Visible on detail page (UI screenshot only) |
| CFSUITE-SR-015 | Update SLA + Due Date together |
| CFSUITE-SR-036 | Original / Revised Due Date + narrative |
| CFSUITE-SR-038 | Status change → CaseHistory row queryable |
| CFSUITE-SR-039 | Close Reason = Duplicate Request |
| CFSUITE-SR-040 | Close Reason = 'Other' + free text |
| CFSUITE-SR-045 | Completion comment on close |
| CFSUITE-SR-046 | Insert Task with WhatId=case Id |
| CFSUITE-SR-047 | On Hold and Close reasons via 'Other' |
| CFSUITE-SR-050 | Path component renders status stages |
| CFSUITE-SR-064 | Three feedback sub-types tagged via cfReq_Category |
| CFSUITE-SR-065 | Complaint child case via ParentId |
| CFSUITE-SR-067 | Complaint close with Completion_Comment |
| CFSUITE-SR-068 | Confidential=Yes on a complaint-flavoured case |

### Tests with explicit data dependencies

| Test | Required data | Source | Status |
|---|---|---|---|
| CFSUITE-SR-001 | Request categories Animals > Dog > Keeping Excess Dogs; map iframe GIS config | mgd-pkg metadata + org config | OK (matches in dev_namespaced_1) |
| CFSUITE-SR-002 | Display_Category record type on Request Flow | mgd-pkg | OK |
| CFSUITE-SR-003 | Any Person Account | ensure_sr_baseline | OK |
| CFSUITE-SR-009 | At least one Case_Assignment Request Flow with assignment config (Department / Team / SLA) | mgd-pkg seed data | OK in dev_namespaced_1 (20 records) |
| CFSUITE-SR-011 | An existing Case (fallback creates) | per-test fallback | OK |
| CFSUITE-SR-012 | An existing Case (fallback creates) | per-test fallback | OK |
| CFSUITE-SR-034 | Case with Status='Assess and Assign' + linked Request Flow + Case_Assignment record matching Category Journey; any active internal user | mgd-pkg + a real assess-and-assign case + user retrofit (no hardcoded admin name) | **gap**: no fixture for an "assess-and-assign" case yet |
| CFSUITE-SR-035 | Hammy + Hilda Person Accounts | ensure_sr_baseline | OK |
| CFSUITE-SR-043 | Hammy account; sets + restores `Customer_Alert` + `Alert_Code` on it | ensure_sr_baseline + in-test save/restore | OK |
| CFSUITE-SR-062 | Category_Journey record type | mgd-pkg | OK |
| CFSUITE-SR-081 | Hammy account + active community user for Hammy | ensure_sr_baseline + manual community-user enablement | manual |
| CFSUITE-SR-086 | Hammy account + active community user for Hammy | ensure_sr_baseline + manual community-user enablement | manual |
| CFSUITE-SR-089 | An existing Case (fallback creates) | per-test fallback | OK |

## Open data gaps

These are requirements observed but not yet automated. Listed in order of impact:

1. **"Assess and Assign" case for CFSUITE-SR-034.** Currently the test queries for any case with `Status='Assess and Assign'`; if none exists it fails. The case must also have a `CFSuite_Request_Flow__c` link AND there must be a matching `Case_Assignment` Request Flow under the same Category Journey. A fixture that seeds one such case would make this test stand-alone. **Action:** extend `ensure_sr_baseline.py` (or new `ensure_sr_assess_assign_case.py`) to create a case matching this pattern using a known Category Journey.

2. **Community users on `Release_156v4`** (or any sandbox we onboard). Three accounts need their community users enabled via the UI before SR-081 / SR-086 can run. The fixture reports the gap; the actual fix is manual (license + profile assignment). **Action:** none feasible from automation today; document in the org onboarding playbook.

3. **Configurable request categories on a non-default record type for SR-001.** The Animals > Dog > Keeping Excess Dogs categories come with the managed package and are present in `dev_namespaced_1`. They should also be present in any cfsuite1-installed org. **Action:** none unless we hit an org without them.

4. **Sample Knowledge Articles for SR-008 / SR-022 (deferred).** When we revisit the deferred tests around Knowledge article display, we'll need at least one published Knowledge article mapped to a Request Flow category. **Action:** defer until those tests are picked up.

## Per-batch data add summary

As we extend the test suite, this table captures the *new* data adds each batch introduced.

| Batch | New data requirements introduced | Fixture impact |
|---|---|---|
| Pre-existing (REQ-* legacy) | 3 Person Accounts, 5 Properties, community users | initial `ensure_sr_baseline.py` and `ensure_rates_baseline.py` |
| Batch B (close-out) | none — all self-contained | none |
| Batch C (case details) | Hammy alert fields (set + restore in-test) | none — handled in-test |
| Batch D (categories/routing) | Display_Category + Category_Journey record types (mgd-pkg); Case_Assignment record with assignment data (mgd-pkg seed) | none — mgd-pkg provides |
| Batch E (complaints) | none — all self-contained | none |

Add a row each batch.
