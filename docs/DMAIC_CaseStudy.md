# Six Sigma DMAIC Case Study
## Reactive-to-Predictive Maintenance Transformation
**Client:** Textile Manufacturing Plant, Bhilwara, Rajasthan
**Author:** Nikhil Tiwari, Product Manager (Six Sigma Certified)
**Engagement:** Octacorps Industrial Automation Consultancy

---

## Project Charter

| Field | Detail |
|---|---|
| Project Title | Reactive-to-Predictive Maintenance & Workforce Safety Transformation |
| Business Case | Unplanned downtime and inefficient technician dispatch are costing an estimated ₹61–88 lakh/month in lost production value, while undocumented manual workarounds expose floor workers to elevated physical strain risk |
| Problem Statement | Maintenance is reactive, technician dispatch is skill-mismatched 31% of the time, and equipment downtime correlates with unmeasured worker safety risk |
| Goal Statement | Reduce MTTR by 35%, increase First-Time-Fix Rate from 47% to 70%+, and establish baseline visibility into associate strain exposure — within 90 days of pilot rollout |
| Scope | 3 prioritised equipment categories (main conveyors, automated loom feeders, dyeing process pumps), single plant site |
| Project Sponsor | Plant Operations Leadership (client-side) |
| Six Sigma Belt Level Applied | Green Belt methodology |

---

## DEFINE

### Critical to Quality (CTQ) Characteristics

| CTQ | Customer (Internal) | Requirement |
|---|---|---|
| Repair speed | RME Engineers, Plant Ops | Lower MTTR |
| Dispatch accuracy | Technicians | Right skill, right tools, first time |
| Worker safety | Floor Workers, Supervisors | Reduced unmeasured manual strain exposure |
| Data usability | RME Engineers | Single source of truth, not fragmented logs |

### Voice of the Customer (VOC) — Synthesised from Floor Interviews

> "I get sent to a jam on Line 4 and find out it's actually a motor fault. I don't carry motor tools. Now I have to walk back." — Maintenance Technician

> "When the conveyor goes down on the dyeing line, the girls just start carrying the rolls by hand. Nobody's said it's a problem, but it's not nothing." — Line Supervisor

> "We write it all down on paper. By the time someone looks at the pattern, it's three weeks old." — RME Engineer

---

## MEASURE

### Baseline Data Collection Plan

| Data Source | Collection Method | Duration |
|---|---|---|
| Maintenance dispatch logs | Existing paper/spreadsheet records, digitised for analysis | 6 months historical |
| Floor observation | Direct shift walks, 3 shifts covered | 2 weeks structured observation |
| Stakeholder interviews | Structured + informal interviews | 22 individuals across roles |
| Downtime workaround incidents | New observation protocol, since no prior tracking existed | 2 weeks |

### Baseline Sigma Performance

```
First-Time-Fix Rate (Baseline):     47%
Defects (repeat dispatch):          53%   ← "defect" = repeat visit required
Opportunities per unit:             1     (each dispatch is one opportunity to fix correctly)

DPMO (Defects Per Million Opportunities) = 530,000
Approximate baseline Sigma Level ≈ 1.6σ

(For reference: 1.6σ ≈ 53% defect rate, consistent with the 47% FTFR baseline
— this is a LOW baseline sigma level, indicating significant improvement
headroom, which is typical and expected for a process that has never been
formally measured before.)
```

### Measurement System Validation

A key MEASURE-phase finding: **no consistent definition of "repair complete" existed** prior to this engagement. Some technicians logged a repair as complete when the machine restarted; others waited to confirm sustained operation. This was flagged as a measurement system inconsistency and standardised as part of FR-1 in the Technical Requirements Document — a temporary fix (a 15-minute sustained-operation check) was proposed before the full system existed, to make the baseline data trustworthy going forward.

---

## ANALYZE

### Root Cause Analysis — Why First-Time-Fix Rate Is Only 47%

**5-Whys:**

1. **Why** do 31% of repairs need a second technician visit? → Because the technician arrives without knowing the actual failure mode.
2. **Why** don't they know the failure mode in advance? → Because dispatch is based on availability, not on any diagnostic signal from the equipment.
3. **Why** is there no diagnostic signal? → Because failure mode data has never been captured in structured form — only inconsistent free-text paper notes.
4. **Why** was it never captured in structured form? → Because no system existed that made structured capture easy enough for technicians to actually use during a live repair.
5. **Why** did no such system exist? → Because maintenance technology investment had historically focused on production-line automation, not on the maintenance function itself — a recognised, common industrial pattern where production gets investment priority over the function that keeps production running.

**True root cause:** Absence of structured failure-mode data capture, which cascades into both poor predictive capability and poor technician-skill matching.

### Root Cause Analysis — Why Worker Strain Exposure Is Unmeasured

1. **Why** is associate strain exposure during downtime unmeasured? → Because no one has ever been asked to measure it.
2. **Why** has no one been asked? → Because the manual workaround is viewed as a temporary, informal coping behaviour, not a process step.
3. **Why** is it viewed that way? → Because it isn't part of any official SOP — it emerged organically as a worker-level adaptation to downtime.
4. **Why** does this matter for Six Sigma scope? → Because unofficial workarounds that compensate for process failure are a classic Six Sigma "hidden factory" — work that happens but is invisible to management metrics.

**True root cause:** A hidden, unofficial compensating process (manual fabric carrying) exists specifically because the official process (conveyor-based transport) fails, and this hidden process was never instrumented because it was never formally acknowledged.

---

## IMPROVE

### Proposed Solution (Translated Into Technical Requirements — see TechnicalRequirementsDoc.md)

| Root Cause | Improvement Action |
|---|---|
| No structured failure-mode data | FR-1: Structured failure mode capture at point of repair |
| No predictive signal | FR-2: Predictive failure alerting for 3 prioritised equipment categories |
| Availability-based (not skill-based) dispatch | FR-3: Skill-matched technician dispatch |
| Hidden/unmeasured worker strain | FR-4: Associate strain exposure flagging — explicitly NOT for performance evaluation |
| Fragmented data visibility | FR-5: Unified SignalForge dashboard |

### Pilot Design

- **Pilot scope:** 3 equipment categories, single plant
- **Pilot duration:** 90 days post-rollout
- **Success threshold:** First-Time-Fix Rate ≥ 70%, MTTR reduction ≥ 35%, and at least baseline visibility established for associate strain exposure (no specific target — Phase 1 goal is measurement, not yet optimisation)

---

## CONTROL

### Sustaining the Gains — Control Plan

| Control Mechanism | Detail |
|---|---|
| Standardised "repair complete" definition | Built into FR-1 structured capture — removes the measurement inconsistency found in MEASURE phase |
| Weekly SignalForge Dashboard review | Plant ops + RME engineering leadership review trailing MTBF/MTTR/FTFR weekly, not just at project close |
| Associate Strain Index monitoring | Monthly trend review — explicitly framed as a process health indicator, never an individual worker metric, reviewed by safety/ops leadership only |
| Technician skill-log maintenance | RME engineers update technician skill profiles quarterly as training progresses, keeping FR-3 dispatch matching accurate |
| Model retraining cadence | Predictive alerting model (FR-2) retrained quarterly as new structured failure data accumulates |

### Control Chart Concept (Post-Pilot Monitoring)

```
First-Time-Fix Rate — Weekly Tracking (Concept)

100% |                                          ___UCL (target zone)
     |                                    ___---
 70% |  ─────────────────────────────────         ← Target threshold
     |              ___---
     |        ___---
 47% |___---                                       ← Baseline
     |
     +----+----+----+----+----+----+----+----+----
       Wk1  Wk2  Wk3  Wk4  Wk5  Wk6  Wk7  Wk8  Wk9

Illustrative trend showing expected gradual FTFR improvement as structured
data accumulates and dispatch matching improves — actual control chart
would be built from live pilot data, not projected in advance.
```

---

## DMAIC Summary Table

| Phase | Key Output |
|---|---|
| Define | Project charter, CTQs, VOC from 22 stakeholders |
| Measure | 6-month baseline data, 2-week structured floor observation, baseline sigma ≈1.6σ |
| Analyze | Two root causes: missing structured failure data; hidden/unmeasured worker strain workaround |
| Improve | 5 functional requirements translated into a formal Technical Requirements Document |
| Control | Standardised metrics definitions, weekly dashboard review cadence, quarterly model retraining |

---

*DMAIC case study authored by Nikhil Tiwari · Six Sigma Green Belt methodology applied · Octacorps Industrial Automation Consultancy · Confidential*
