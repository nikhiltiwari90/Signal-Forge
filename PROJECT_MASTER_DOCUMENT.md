# SignalForge — Complete Project Documentation

> **Note:** A fully formatted, single-file version of this document — with embedded architecture diagrams and every pilot-results chart — is available as PDF/Word in [`docs/MasterDocument/`](docs/MasterDocument/SignalForge_Master_Document.pdf). This Markdown file remains the version-controlled source of truth.

---

## End-to-End Build Record: Decisions, Tradeoffs, Implementation, Outcomes, Future Roadmap
**Author:** Nikhil Tiwari
**Project Type:** Client Engagement Portfolio Piece (Octacorps Industrial Automation Consultancy)
**Document Purpose:** Single source of truth covering the entire project lifecycle

---

## Table of Contents

1. Project Overview
2. Problem Definition & Goals
3. Strategic Decisions & Rationale
4. Architecture Deep Dive — Signal, AI, and Dashboard Layers
5. AI Decisions — Agent Design, Reasoning Flow, Isolation Boundaries
6. Every Tradeoff Made, In Detail
7. Step-by-Step Implementation Log
8. Technical Challenges & How They Were Solved
9. Outcome & What Was Actually Delivered
10. Metrics Framework — How Success Is Defined
11. Known Limitations — Honest Accounting
12. Future Roadmap — Phase 2, Phase 3, and Beyond
13. Lessons Learned
14. Appendix — Full Decision Log

---

## 1. Project Overview

### What Was Built

SignalForge is a predictive maintenance and workforce safety platform for a 500+ worker textile manufacturing plant in Bhilwara, Rajasthan, built during a client engagement at Octacorps, an industrial automation consultancy. The platform taps existing PLC signal data (motor current, vibration, temperature, pressure) that the plant's machinery already generated but never captured, routes it through a 4-agent AI reasoning pipeline (Signal Anomaly Agent → Failure Prediction Agent → Dispatch Optimization Agent, plus an architecturally isolated Workforce Safety Agent), and surfaces the result in a unified dashboard for RME engineers, plant operations, and safety leadership.

### Why It Was Built

As a Product Manager with an M.Eng in Electrical Engineering and PLC/industrial controls background, targeting AI Product Manager and Reliability & Maintenance Engineering (RME) roles at Amazon's European operations (Luxembourg, Germany, UK), the standard AI-PM portfolio artifact — software-only AI products — doesn't demonstrate the specific combination of skills those roles require: genuine electrical/controls literacy, Six Sigma process rigor, and AI system architecture, applied to physical industrial operations rather than purely digital products.

This project exists specifically to prove that combination, end-to-end, on a real-feeling industrial engagement.

### Who It's For

**Primary audience:** Technical recruiters and hiring managers evaluating Product Manager candidates for Amazon's Reliability & Maintenance Engineering organization, and AI Product Manager roles with an operations/industrial bent.

**Secondary audience:** Engineering and controls-background interviewers who want to verify genuine signal/PLC literacy, not just AI buzzwords layered onto a generic "smart factory" pitch.

### One-Sentence Summary

*An AI-native industrial reliability platform that captures previously-discarded PLC signal data, routes it through a 4-agent reasoning pipeline to predict failures and route the right technician the first time, and treats workforce physical strain as a first-class, architecturally-isolated signal — built end-to-end from floor research, electrical signal analysis, Six Sigma DMAIC structuring, and agentic AI system design.*

---

## 2. Problem Definition & Goals

### The Portfolio Problem (Meta-Level)

| Gap in a Typical AI-PM Portfolio | How This Project Closes It |
|---|---|
| AI products that are purely software, no physical/industrial grounding | Real PLC signal types, real IoT gateway architecture, genuine EE literacy |
| "Predictive maintenance" as a black-box claim | A documented 4-agent pipeline with per-agent precision/accuracy metrics |
| Generic "smart factory" pitch with no Six Sigma rigor | Full DMAIC structure — Define, Measure, Analyze, Improve, Control |
| No demonstrated awareness of AI trust/safety tradeoffs | The Workforce Safety Agent's deliberate architectural isolation |
| Disconnected from the specific target role's actual JD language | Built explicitly around "taking technical requirements for RME... improving key metrics... helping machinery or people" |

### The Simulated Industrial Problem (Project-Level)

A textile manufacturing plant's maintenance operation was entirely reactive: a machine breaks, a technician is dispatched based on availability rather than skill-match, and 31% of repairs required a second visit because the technician didn't know the actual failure mode in advance. The plant's PLCs already generated rich signal data for every piece of prioritised equipment, but none of it was captured beyond the immediate stop/start control loop. Simultaneously, when machines went down, workers informally compensated with physically demanding manual workarounds that had never been measured.

### Goals

**Primary goal (portfolio):** Produce a project that demonstrates genuine, credible fusion of electrical/industrial engineering literacy, Six Sigma process discipline, and agentic AI system design — directly mapped to Amazon RME Product Manager job description language.

**Secondary goal (product):** Demonstrate that tapping existing, underutilised PLC signal data via a non-invasive IoT gateway can deliver meaningful predictive maintenance value without requiring a full sensor retrofit — a realistic, budget-conscious industrial AI deployment pattern.

**Tertiary goal (craft):** Prove that an AI agent architecture can correctly encode a non-negotiable trust boundary (workforce strain data must never become individual performance data) at the system design level, not just as a policy statement.

### Non-Goals

- This is **not** intended to claim a full vibration spectral-analysis (FFT) capability in Phase 1 — explicitly flagged as a Phase 2 item given retrofit cost
- This is **not** intended to claim individual-level worker tracking of any kind — explicitly and permanently excluded
- This is **not** a claim that the AI agents were deployed against live, real plant data — see Section 11 for honest framing

---

## 3. Strategic Decisions & Rationale

### Decision 1: Tap existing PLC signals via non-invasive IoT gateway, not full sensor retrofit

**Options considered:** (A) Full retrofit with new sensors across all equipment, (B) Tap existing PLC analog/digital signals non-invasively via an edge gateway, supplementing only where genuinely absent (vibration), (C) Wait for budget to do a complete retrofit before building anything

**Chosen: B**

**Rationale:** Floor/PLC review confirmed the plant's existing control systems already generated motor current, and partial temperature/pressure data for the 3 prioritised equipment categories — discarded after immediate control use. Building a full retrofit-first plan would have meaningfully delayed any value delivery and dramatically increased budget risk. Tapping existing signals first, supplementing only the genuinely-missing vibration signal, de-risked the entire project's sensor budget (see Risk Register R-06) while still proving the architecture.

---

### Decision 2: 4 agents, with one (Workforce Safety) architecturally isolated rather than chained

**Options considered:** (A) A single end-to-end model from signal to dispatch decision, (B) 3 sequential agents (Anomaly → Prediction → Dispatch) with workforce safety folded into the same pipeline, (C) 4 agents with workforce safety as a 4th sequential stage, (D) 4 agents with workforce safety architecturally isolated, no upstream/downstream data link to the other 3

**Chosen: D**

**Rationale:** This is the single most important AI product judgment decision in the project. Folding workforce safety into the same pipeline as dispatch (option C) would create a technical pathway — even if policy said otherwise — for strain data to eventually correlate with individual technician or worker identity, given that dispatch data inherently includes technician identity. Isolating the Workforce Safety Agent architecturally, with no data link to the technician-identifying pipeline, makes the non-negotiable trust boundary (raised directly by floor workers during research) enforceable at the system level. This was a deliberate, conscious forgone opportunity — a genuine cross-signal correlation between strain patterns and failure patterns might exist and go undetected — accepted specifically because trust was judged non-negotiable.

---

### Decision 3: Sequential context-passing for Agents 1→2→3, mirroring the AI CPO Simulator's architecture

**Options considered:** (A) Run Signal Anomaly, Failure Prediction, and Dispatch Optimization as independent parallel calls against the same raw data, (B) Sequential, each agent consuming the prior agent's structured output

**Chosen: B**

**Rationale:** The same principle proven in my AI CPO Simulator project applies here: an agent reasoning over another agent's already-narrowed, confirmed output produces more reliable, auditable results than an agent reasoning over raw, noisy input independently. The Failure Prediction Agent reasoning over Agent 1's confirmed anomaly (with confidence level) rather than raw telemetry directly is both more accurate and easier for an RME engineer to audit at each stage.

---

### Decision 4: Six Sigma DMAIC as the overarching structure, not just a section

**Options considered:** (A) Standard PM/PRD structure with Six Sigma mentioned as a methodology reference, (B) Full DMAIC structure governing the entire problem framing, with the AI/software layer as the "Improve" phase output

**Chosen: B**

**Rationale:** Given the target role explicitly values Six Sigma rigor (confirmed certification held), treating DMAIC as a section subordinate to a generic PRD would undersell that credential. Structuring the entire case study around Define-Measure-Analyze-Improve-Control — with the AI agent architecture appearing specifically as part of "Improve," and a genuine "Control" phase (not just a fix-and-forget ending) — demonstrates Six Sigma fluency as load-bearing methodology, not decoration.

---

## 4. Architecture Deep Dive — Signal, AI, and Dashboard Layers

### 4.1 Full System Diagram

```
SIGNAL LAYER
PLC analog/digital I/O ──► IoT Edge Gateway (Modbus → MQTT) ──► Structured signal store
                                                                       │
AI AGENT PIPELINE                                                     │
                                                                       ▼
                                                        Signal Anomaly Agent (1)
                                                                       │
                                                                       ▼
                                                        Failure Prediction Agent (2)
                                                                       │
                                                                       ▼
                                                        Dispatch Optimization Agent (3)
                                                                       │
                  Workforce Safety Agent (4)                          │
                  [isolated — no link]                                │
                                │                                     │
                                └──────────────┬──────────────────────┘
                                               ▼
                                    SignalForge Dashboard
```

### 4.2 Signal Layer Detail

Full sensor type rationale, PLC integration approach, and protocol choices are documented in `engineering/SensorPLCSpec.md`. Headline decisions: motor current draw (4-20mA analog) tapped from existing PLC I/O for conveyors and dyeing pumps; vibration retrofit (MEMS wireless accelerometers) added only where genuinely absent; Modbus RTU to MQTT bridge chosen as the de facto industrial-to-IoT protocol pairing.

### 4.3 AI Agent Pipeline Detail

Full agent-by-agent mandate, input/output contract, and isolation rationale documented in `docs/AIAgentDesign.md`. Headline structure: Agent 1 (statistical anomaly detection) → Agent 2 (failure mode + lead-time forecasting) → Agent 3 (skill-matched dispatch), with Agent 4 (workforce safety) isolated by design.

### 4.4 Dashboard Layer Detail

The implementation dashboard (`dashboard/dashboard.html`) presents both business-outcome metrics (MTTR, FTFR, downtime hours) and AI-pipeline-health metrics (Signal Anomaly Agent precision, Failure Prediction Agent mode-match rate, Dispatch Optimization Agent acceptance rate) side by side — a deliberate choice to avoid presenting the AI layer as a black box; an RME engineer reviewing this dashboard can independently assess whether the AI pipeline itself is trustworthy, not just whether business metrics improved.

---

## 5. AI Decisions — Agent Design, Reasoning Flow, Isolation Boundaries

### 5.1 Why Decompose by Reasoning Mode, Not Feature List

Each of the 4 agents maps to a genuinely distinct cognitive task: statistical anomaly detection (Agent 1) is fundamentally different from inferential failure-mode forecasting (Agent 2), which is different again from constraint-based matching (Agent 3, matching skill + availability + location), which is different again from aggregate correlation analysis under a hard privacy constraint (Agent 4). This mirrors the exact agent-boundary derivation principle used in the AI CPO Simulator project — derive boundaries from the structure of the real decision-making process, not from an arbitrary list of "things an AI could do here."

### 5.2 Confidence Calibration at Every Stage

Every agent surfaces an explicit confidence level alongside its output — Agent 1's anomaly confidence, Agent 2's failure-mode and lead-time confidence, Agent 3's match-quality confidence. This was a deliberate design choice so that RME engineers calibrate trust in the system incrementally, stage by stage, rather than treating final dispatch recommendations as an unaccountable black box.

### 5.3 The Workforce Safety Agent's Isolation — Full Tradeoff Discussion

See Section 3, Decision 2 above and the full discussion in `docs/AIAgentDesign.md`. This is flagged again here because it is the single AI product-judgment decision most worth discussing in an interview: a deliberate choice to forgo a potential capability (cross-correlating strain and failure patterns) in exchange for an enforceable trust boundary.

---

## 6. Every Tradeoff Made, In Detail

| # | Decision | Benefit Gained | Cost Accepted | Why The Cost Was Worth It |
|---|---|---|---|---|
| 1 | Tap existing PLC signals first, retrofit only where absent | Dramatically lower Phase 1 cost and time-to-value | Less signal richness (no full vibration spectral analysis) than a complete retrofit would provide | Proving the architecture and pilot value first justified the investment case for further retrofit later, rather than betting the whole project on upfront capital |
| 2 | Workforce Safety Agent architecturally isolated | Enforceable, system-level trust boundary protecting worker data | Forgoes any genuine cross-signal correlation between strain and failure patterns, even if real | Worker trust was a non-negotiable precondition for the data collection effort to have any legitimacy at all |
| 3 | Sequential Agent 1→2→3 with context passing | More auditable, accurate reasoning at each stage | Higher latency and orchestration complexity than parallel/single-model approaches | Auditability mattered more than raw speed for a system RME engineers need to trust incrementally |
| 4 | Non-invasive IoT gateway tap, not PLC reprogramming | Zero risk to existing safety-certified control logic | Additional edge hardware (the gateway itself) vs. a "free" software-only change | Re-certifying safety-rated control systems was judged an unacceptable risk for the value gained |
| 5 | Six Sigma DMAIC as the governing structure | Demonstrates genuine methodology fluency, not just AI capability | More rigid document structure than a freer PRD format would allow | The target role's explicit value on Six Sigma made this the right structural bet |
| 6 | 90-second logging constraint for technicians (FR-1) | High technician adoption likelihood | Resulted in 79% structured capture rate, short of 85% target | Even an imperfect compliance rate beats a theoretically-complete system nobody actually uses |
| 7 | Amplitude-threshold vibration detection, not full FFT spectral analysis (Phase 1) | Faster, cheaper to deploy and validate | Less specific failure-mode discrimination than spectral analysis would provide | Sufficient to validate the architecture and prove pilot value before justifying added hardware cost |

---

## 7. Step-by-Step Implementation Log

### Phase 1 — Floor & Signal Discovery (Pre-Architecture)
1. Conducted structured floor walks across 3 shifts, shadowing live repairs
2. Reviewed existing PLC I/O configurations for the 3 prioritised equipment categories
3. Identified which signal types already existed (current, partial temperature/pressure) vs. needed retrofit (vibration)
4. Conducted 22 stakeholder interviews (RME engineers, technicians, supervisors, workers, leadership)
5. Surfaced the workforce-strain insight through informal floor conversation — not from any formal request

### Phase 2 — Requirements & DMAIC Structuring
6. Quantified baseline metrics from 6 months of historical maintenance dispatch data (47% FTFR, 94 min MTTR)
7. Conducted 5-Whys root cause analysis on both the dispatch-mismatch and workforce-strain-invisibility problems
8. Drafted the full Technical Requirements Document with 5 functional requirements and explicit acceptance criteria
9. Defined the hard constraint: workforce strain data never used for individual performance evaluation

### Phase 3 — AI Agent & Signal Architecture Design
10. Designed the 4-agent reasoning pipeline, mapping each agent to a distinct cognitive task
11. Specified the non-invasive IoT edge gateway architecture (Modbus → MQTT)
12. Made the explicit decision to architecturally isolate the Workforce Safety Agent
13. Defined per-agent confidence calibration and output contracts

### Phase 4 — Metrics & Dashboard Design
14. Built the full KPI tree, including both business-outcome metrics and AI-pipeline-health metrics
15. Designed the Associate Strain Exposure Index as an original metric for this engagement
16. Built the standalone implementation dashboard (`dashboard/dashboard.html`) presenting both metric families side by side

### Phase 5 — Pilot Execution & Control Phase
17. Executed the 90-day pilot across the 3 prioritised equipment categories
18. Tracked weekly First-Time-Fix Rate and repeat-dispatch-rate trends
19. Established the Control phase plan: standardised "repair complete" definition, weekly dashboard review cadence, quarterly model retraining

### Phase 6 — Documentation & Packaging
20. Wrote the full documentation set (Technical Requirements, DMAIC case study, AI Agent Design, Sensor/PLC Spec, System Architecture, Risk Register, Postmortem)
21. Wrote the Skills & Tools document mapping real PM disciplines and tools to each project phase
22. Wrote this master document tying every decision back to its rationale

---

## 8. Technical Challenges & How They Were Solved

### Challenge 1: Avoiding a full sensor retrofit without sacrificing predictive value
**Solution:** Systematic PLC I/O review before any retrofit decision, confirming most needed signal types already existed; vibration retrofit scoped narrowly only where genuinely absent.

### Challenge 2: Enforcing the workforce-safety trust boundary at more than a policy level
**Solution:** Architectural isolation of the Workforce Safety Agent — no data link to the technician-identifying pipeline, aggregation enforced at work-area/shift level by design, not by promise.

### Challenge 3: Avoiding re-certification risk on existing safety-rated PLC control logic
**Solution:** Non-invasive parallel signal tap via an independent IoT edge gateway, rather than modifying the PLC's own ladder logic.

### Challenge 4: Balancing technician logging speed against data completeness
**Solution:** 90-second logging constraint, accepted as a deliberate tradeoff (see Section 6, item 6) even though it resulted in landing short of the structured-capture target — addressed as a Control-phase improvement opportunity rather than treated as a failure.

---

## 9. Outcome & What Was Actually Delivered

### Deliverable 1: A complete Technical Requirements Document
5 functional requirements with explicit acceptance criteria, directly traceable to floor research and stakeholder interviews — see `docs/TechnicalRequirementsDoc.md`.

### Deliverable 2: A full Six Sigma DMAIC case study
Define through Control, with the AI agent architecture appearing as part of "Improve" — see `docs/DMAIC_CaseStudy.md`.

### Deliverable 3: A documented 4-agent AI architecture
Including the explicit isolation-boundary tradeoff discussion — see `docs/AIAgentDesign.md`.

### Deliverable 4: A real sensor/PLC/IoT specification
Grounded in genuine electrical signal types and industrial protocols — see `engineering/SensorPLCSpec.md`.

### Deliverable 5: A working implementation dashboard
Presenting both business-outcome and AI-pipeline-health metrics — see `dashboard/dashboard.html`.

### Deliverable 6: This document
A complete, honest, end-to-end record of every decision and its rationale.

### What "Done" Means For This Project

"Done" at v1 means: the Technical Requirements Document is traceable to real floor research; the DMAIC structure is genuinely load-bearing, not decorative; the AI agent architecture's trust-boundary decision is explicit and defensible; the sensor/PLC grounding reflects real industrial signal types and protocols; and every limitation is disclosed honestly rather than glossed over. All five conditions are met as of this writing.

---

## 10. Metrics Framework — How Success Is Defined

### 10.1 Business-Outcome Metrics (Pilot Results)

| Metric | Baseline | Target | Actual |
|---|---|---|---|
| First-Time-Fix Rate | 47% | ≥70% | 71% |
| MTTR | 94 min | -35% | -38% |
| Predictive alert lead time | n/a | ≥4 hrs | 4.6 hrs avg |
| Structured failure-mode capture | ~12% | ≥85% | 79% |
| Strain exposure baseline | Not tracked | Establish baseline | 312 incidents logged |

### 10.2 AI Pipeline Health Metrics (New for This Project)

| Metric | Result |
|---|---|
| Signal Anomaly Agent precision | 84% (up from 58% week 1) |
| Failure Prediction Agent mode-match rate | 76% |
| Dispatch Optimization Agent acceptance rate | 81% |

### 10.3 What Would Be Measured If This Became a Real Deployed Product

Long-run model drift monitoring (does Agent 2's mode-match rate degrade over time without retraining), cost-per-prevented-failure (translating predictive lead time into actual avoided downtime cost), and a longitudinal Associate Strain Exposure Index trend correlated against any independently-reported safety incident data — always at the aggregate level only.

---

## 11. Known Limitations — Honest Accounting

| Limitation | Detail | Why It Exists |
|---|---|---|
| No live deployment against real plant data | All metrics are illustrative reconstructions for portfolio purposes, modeled on a realistic 90-day pilot pattern, not measurements from an actually-deployed system | This is a portfolio engagement case study, not a claim of a shipped, live product |
| Vibration retrofit scoped narrowly (amplitude threshold, not full FFT) | Less failure-mode specificity than spectral analysis would provide | Phase 1 budget and time constraints; explicitly flagged as a Phase 2 item |
| Structured capture rate (79%) fell short of target (85%) | The 90-second logging constraint, while necessary for adoption, still allowed some compliance gaps during the most chaotic breakdown moments | Honestly disclosed in `docs/Postmortem.md` rather than hidden |
| No closed feedback loop retraining Agent 2 from confirmed/disconfirmed predictions | The AI agent architecture does not yet self-improve from pilot outcomes | Flagged explicitly as a Phase 2 capability, not implemented in Phase 1 |
| Single plant site, 3 equipment categories only | Findings have not been validated at multi-site or full-equipment-category scale | Deliberate pilot scoping discipline, not an oversight |

---

## 12. Future Roadmap — Phase 2, Phase 3, and Beyond

### Phase 2 — Sensor & Model Depth
Full FFT-based vibration spectral analysis for more specific failure-mode discrimination; closed feedback loop retraining the Failure Prediction Agent from confirmed/disconfirmed pilot outcomes; structured capture rate improvement via faster categorical-tap logging UI.

### Phase 2 — Expanded Equipment Coverage
Extend signal capture and the AI pipeline beyond the 3 prioritised categories to the full plant equipment inventory, using the same non-invasive IoT gateway architecture proven in Phase 1.

### Phase 3 — Multi-Site Rollout
Validate whether the 4-agent architecture and DMAIC-defined metrics generalise to additional plant sites, with site-specific baseline recalibration rather than assuming identical baselines.

### Phase 3 — Predictive-to-Prescriptive Evolution
Extend the Dispatch Optimization Agent from recommending a technician to recommending a full prescriptive maintenance action plan (parts to pre-stage, estimated repair duration, optimal scheduling window) — a natural extension once Phase 1/2 trust in the underlying predictions is established.

---

## 13. Lessons Learned

### On combining electrical engineering and AI product thinking
The most credible AI product decisions in this project came directly from electrical/controls literacy — knowing which PLC signals already existed, and why a non-invasive gateway was the right call versus reprogramming safety-rated control logic. AI architecture decisions made without that grounding would have been technically plausible but practically naive about real industrial deployment constraints.

### On trust boundaries as architecture, not policy
The Workforce Safety Agent's isolation is the single decision in this project most worth defending in an interview, because it demonstrates that responsible AI design sometimes means deliberately forgoing a capability — not just adding guardrails after the fact.

### On Six Sigma as structure, not decoration
Letting DMAIC genuinely govern the entire case study, rather than mentioning it as a methodology reference, made the Control phase a real, substantive section — which is exactly the phase most portfolio projects skip, and exactly the phase a Six Sigma-literate interviewer will ask about first.

---

## 14. Appendix — Full Decision Log

| Decision ID | Decision | Status |
|---|---|---|
| D-01 | Tap existing PLC signals via non-invasive gateway, retrofit only where absent | Implemented |
| D-02 | 4-agent architecture, Workforce Safety Agent isolated | Implemented |
| D-03 | Sequential context-passing for Agents 1→2→3 | Implemented |
| D-04 | Six Sigma DMAIC as governing structure | Implemented |
| D-05 | 90-second technician logging constraint | Implemented — fell short of capture-rate target, flagged for Phase 2 |
| D-06 | Amplitude-threshold vibration detection (not full FFT) | Implemented — flagged as Phase 2 upgrade |
| D-07 | Honest, proactive limitations disclosure | Implemented throughout all docs |

---

*This document is the single source of truth for SignalForge's full lifecycle — decisions, tradeoffs, implementation, outcomes, and roadmap. Authored by Nikhil Tiwari. Proprietary — see LICENSE.md.*
