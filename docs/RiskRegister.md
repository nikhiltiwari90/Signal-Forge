# Risk Register
## SignalForge — Project & Operational Risks
**Author:** Nikhil Tiwari, Product Manager

---

| ID | Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|---|
| R-01 | Technicians don't adopt mobile logging consistently | High | High | FR-1 90-second logging constraint, validated directly against technician feedback before being finalised |
| R-02 | Predictive model lacks sufficient historical data density at launch | High | Medium | Rule-based fallback alerting during data-collection period; flagged as open question to engineering |
| R-03 | Associate strain data misused for individual performance evaluation, breaking worker trust | Medium | High | Hard constraint in Technical Requirements Document Section 6 — work-area/shift level only, never individual; explicitly raised by workers during research |
| R-04 | Plant WiFi dead zones cause data loss during mobile logging | Confirmed (observed) | Medium | Offline-first mobile capture with sync-on-reconnect specified as a non-functional requirement |
| R-05 | RME engineers resist a new system after years of being told "better data is coming" with no delivery | Medium | High | Engineers were directly consulted in requirements process, not handed a finished spec — used as a trust-building mechanism |
| R-06 | Sensor retrofit budget insufficient for all 3 prioritised equipment categories | Medium | Medium | Flagged as open question for engineering; phased sensor rollout proposed as contingency |
| R-07 | Hindi/English language gap reduces technician interface usability | Medium | Medium | Bilingual interface specified as a non-functional requirement based on floor workforce composition |
| R-08 | Pilot success doesn't generalize beyond the 3 prioritised equipment categories | Medium | Medium | Explicitly scoped as Phase 1; full-plant rollout treated as a separate future decision, not assumed |

---

*Risk register authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
