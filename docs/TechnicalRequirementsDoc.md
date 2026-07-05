# Technical Requirements Document
## Predictive Maintenance & Workforce Safety System — SignalForge
**Client:** Textile Manufacturing Plant, Bhilwara, Rajasthan (confidential)
**Engagement:** Octacorps Industrial Automation Consultancy
**Author:** Nikhil Tiwari, Product Manager
**Document Status:** Final — Approved for Engineering Handoff
**Date:** 2024

---

## 1. Purpose of This Document

This document translates floor research, stakeholder interviews, and historical maintenance data into a structured set of technical requirements for a Predictive Maintenance & Dispatch system. It is written for Octacorps' engineering team to build against, and for plant operations leadership to validate scope and priority before development begins.

This is the core deliverable of the requirements-gathering phase of the engagement — the document that translates "what RME engineers and floor workers actually need" into "what engineering needs to build."

---

## 2. Background & Problem Statement

### 2.1 Current State

The plant's maintenance operation is **reactive**. A breakdown occurs, a floor supervisor radios the maintenance office, a technician is dispatched based on availability rather than skill-match, and the technician often arrives without knowing the specific failure mode — leading to repeat trips for missing tools or parts.

### 2.2 Quantified Problem (from historical data analysis)

| Metric | Current State (Baseline) |
|---|---|
| Average Mean Time To Repair (MTTR) | 94 minutes |
| First-Time-Fix Rate | 47% (technician resolves issue on first dispatch) |
| Unplanned downtime hours per month (plant-wide) | ~340 hours |
| Estimated production value lost per downtime hour | ASSUMPTION: ₹18,000–₹26,000/hour (based on line throughput value) |
| Manual workaround incidents during downtime (observed) | Frequent — not previously tracked systematically |

### 2.3 Floor-Observed Problem (from direct observation + interviews)

During structured floor time across three shifts, the following pattern was directly observed and confirmed by supervisors:

- When conveyor or automated feed systems fail, workers manually carry fabric rolls (observed weight range 15–25kg) over distances normally covered by the conveyor
- This workaround is informal, unmeasured, and was confirmed by 6 of 7 interviewed supervisors as a "normal" response to downtime
- No existing system flags when this workaround is happening, how long it persists, or which workers are repeatedly exposed to it

---

## 3. Stakeholders Consulted

| Role | Number Consulted | What They Provided |
|---|---|---|
| RME Engineers | 4 | Failure mode knowledge, technician skill-mapping needs, sensor/data feasibility |
| Maintenance Technicians | 9 | Real dispatch pain points, tool/part availability issues, repair sequence detail |
| Line Supervisors | 7 | Downtime workaround patterns, worker safety concerns, production impact |
| Floor Workers (informal) | ~15 | Direct experience of manual workaround physical strain |
| Plant Operations Leadership | 2 | Business priority, budget constraint context, success definition |

---

## 4. Functional Requirements

### FR-1: Failure Mode Data Capture

**Requirement:** The system MUST capture structured failure mode data at the point of every repair — equipment ID, failure category, root cause (where determinable), parts used, and repair duration.

**Source of requirement:** RME engineers explicitly stated that without structured failure mode history, no predictive model could ever be trained — historical data was inconsistent free-text notes, not structured fields.

**Acceptance Criteria:**
- Every dispatched repair generates a structured record with the fields above
- Technicians can log this via mobile device in under 90 seconds (validated against technician interview feedback that anything longer "won't get used")

---

### FR-2: Predictive Failure Alerting

**Requirement:** The system MUST analyse equipment sensor data (where available) and historical failure patterns to generate an early-warning alert before failure occurs, for equipment categories with sufficient historical data density.

**Source of requirement:** RME engineers identified 3 equipment categories (main line conveyors, automated loom feeders, dyeing process pumps) as having both (a) high failure frequency and (b) feasible sensor retrofit options.

**Acceptance Criteria:**
- Alerts generated at least 4 hours before predicted failure for in-scope equipment categories
- Alert includes predicted failure mode and recommended technician skill-match

---

### FR-3: Skill-Matched Technician Dispatch

**Requirement:** The system MUST recommend technician dispatch based on matching the predicted or reported failure mode against each technician's logged skill and repair history, not simple availability.

**Source of requirement:** 9 of 9 technicians interviewed cited "wrong technician sent for the job" as a top-3 frustration; this was independently confirmed in dispatch log analysis showing 31% of repairs required a second technician visit.

**Acceptance Criteria:**
- Dispatch recommendation includes top 2 skill-matched available technicians
- First-Time-Fix Rate target: improve from 47% baseline to 70%+ within 90 days of rollout

---

### FR-4: Associate Strain Exposure Flagging

**Requirement:** The system MUST flag and log periods where equipment downtime correlates with a known manual workaround pattern (e.g., conveyor down on a line with no alternate automated transport), and track which shift/work area is most frequently exposed.

**Source of requirement:** Directly derived from floor observation — this requirement did not exist in any prior system or request; it was synthesised from supervisor interviews and direct floor observation, not from a pre-existing stakeholder ask. This is the requirement I personally identified and pushed to include in scope.

**Acceptance Criteria:**
- System logs estimated manual workaround duration per downtime event for in-scope equipment
- Weekly report flags work areas/shifts with highest cumulative workaround exposure
- This data is explicitly NOT used for individual worker performance evaluation — flagged as a hard constraint in Section 6

---

### FR-5: Maintenance Dashboard for RME Engineers

**Requirement:** The system MUST provide a dashboard showing real-time equipment health status, active alerts, technician dispatch status, and trailing reliability metrics (MTBF, MTTR, FTFR).

**Source of requirement:** RME engineers and plant operations leadership both requested a single source of truth — currently this data is split across paper logs, a basic spreadsheet, and verbal handoffs between shifts.

**Acceptance Criteria:**
- Dashboard refreshes at least every 15 minutes
- Accessible on shared floor terminals and supervisor mobile devices

---

## 5. Non-Functional Requirements

| Requirement | Detail |
|---|---|
| Reliability | Dashboard and alerting system itself must have >99% uptime — a maintenance system that's down is a credibility failure |
| Usability | Technician-facing mobile logging must work for users with varying smartphone literacy — large touch targets, minimal text entry |
| Data retention | Failure mode history retained minimum 24 months to support predictive model training |
| Language | All technician-facing interfaces in Hindi and English, given floor workforce composition |
| Connectivity | Plant floor has inconsistent WiFi in some zones (confirmed during floor walks) — mobile logging must support offline capture with sync-on-reconnect |

---

## 6. Constraints & Explicit Exclusions

- **Hard constraint:** Associate strain/workaround data (FR-4) must never be used in individual performance reviews or disciplinary action. This was a non-negotiable condition raised by floor workers and supervisors during interviews, and is treated as a design constraint, not a nice-to-have.
- **Out of scope (Phase 1):** Full sensor retrofit across all equipment — only the 3 prioritised categories from FR-2 are in scope for the pilot
- **Out of scope (Phase 1):** Automated parts ordering/inventory integration — flagged as a Phase 2 candidate

---

## 7. Open Questions for Engineering

1. Can the 3 prioritised equipment categories support retargetable IoT sensors within the existing budget, or does this require a phased sensor rollout?
2. What is the minimum historical data volume needed before the predictive alerting model (FR-2) produces reliable signal, and what's the interim fallback (rule-based alerting) during that data-collection period?
3. Is offline-first mobile logging (NFR — Connectivity) feasible within the existing technician device fleet, or does this require new hardware?

---

*Technical Requirements Document authored by Nikhil Tiwari, based on direct floor research and structured stakeholder interviews · Octacorps Industrial Automation Consultancy · Confidential*
