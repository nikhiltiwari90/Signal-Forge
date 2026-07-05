# Floor Layout & Workflow — Before vs After
## SignalForge
**Author:** Nikhil Tiwari, Product Manager

---

## Before: Reactive Workflow

```
Machine breaks
   → Floor supervisor radios maintenance office
   → Technician dispatched based on availability (not skill)
   → Technician arrives, diagnoses on-site
   → 31% of cases: wrong tools/skill — technician leaves, returns later
   → Meanwhile: workers begin manual workaround (unmeasured)
   → Repair completed: avg 94 minutes total
   → Paper log entry (free text, inconsistent)
```

## After: SignalForge-Enabled Workflow

```
PLC signal drifts from baseline
   → Signal Anomaly Agent flags deviation
   → Failure Prediction Agent estimates failure mode + lead time (avg 4.6 hrs ahead)
   → Dispatch Optimization Agent recommends skill-matched technician
   → Technician arrives prepared with correct tools/skill
   → Repair completed: avg 58 minutes total (-38%)
   → Structured digital log entry (FR-1 compliant)
   → Workforce Safety Agent independently flags any workaround period (aggregate only)
```

---

## Key Workflow Change

The before-state workflow only begins *after* a machine has already failed. The after-state workflow begins *before* failure, using the predictive lead time to convert an emergency reactive dispatch into a planned, skill-matched one — directly addressing the floor-research finding that wrong-technician dispatch was the single most cited frustration across 9 of 9 technician interviews.

---

*Design document authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
