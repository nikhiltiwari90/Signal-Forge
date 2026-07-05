# SignalForge ⚡

### AI-Native Industrial Reliability & Workforce Intelligence Platform
**Sensor-to-Strategy: Predictive Maintenance, Skill-Matched Dispatch, and Workforce Safety for Industrial Manufacturing**

 Author: Nikhil Tiwari — Product Manager (M.Eng Electrical Engineering, PLC/Industrial Controls background)
 Engagement: Octacorps Industrial Automation Consultancy — Client Engagement
 Client: Large-scale textile manufacturing plant, Bhilwara, Rajasthan *(name withheld for confidentiality)*
 Scale: Single industrial site, 500+ daily workforce
 Domain: Industrial IoT · Reliability & Maintenance Engineering · Agentic AI · Workforce Safety

> Applying for an Amazon TPM or RME Program Manager role?** Sections 21–24 of the Master Document are written specifically for that review: a program charter and RACI, milestone timeline and critical-path vendor management, a technical risk register scoped to the AI system itself, per-agent latency budgets and evaluation methodology, an Amazon Leadership Principles mapping grounded in specific project moments, and a full Amazon-style narrative 6-pager. Short on time? Read Section 24 alone.



## One-Sentence Summary

> SignalForge turns raw PLC and sensor signal data from factory-floor machinery into AI-driven failure predictions, skill-matched technician dispatch, and the plant's first systematic visibility into how equipment downtime affects worker physical strain — built end-to-end from floor research, electrical signal analysis, and a 4-agent AI reasoning pipeline.

---

## Architecture at a Glance

SignalForge end-to-end system architecture: signal layer, edge gateway, AI agent pipeline, dashboard

Four-agent reasoning pipeline with Workforce Safety Agent architecturally isolated

---

## The Problem in One Paragraph

A 500+ worker textile manufacturing plant in Bhilwara was running its entire maintenance operation reactively: a machine breaks, a technician is dispatched based on availability rather than skill-match, and 31% of repairs needed a second visit because nobody knew the actual failure mode in advance. The plant had PLCs already running its conveyors, loom feeders, and dyeing pumps — generating real-time signal data (current draw, vibration, temperature) every second — but none of it was being captured, structured, or used for anything beyond the immediate stop/start logic each PLC was hard-wired for. Meanwhile, when machines went down, workers informally compensated with manual workarounds — carrying fabric rolls by hand — that nobody had ever measured.

SignalForge was built to solve both problems with one architecture: **tap the signal data the plant's existing PLCs already produce, route it through a 4-agent AI pipeline that predicts failure and routes the right technician, and treat workforce strain as a first-class signal alongside machine health — not an afterthought.**

---

## The 4-Agent AI Architecture

| # | Agent | Role | Input | Output |
|---|---|---|---|---|
| 1 | **Signal Anomaly Agent** | OT Signal Analyst | Raw PLC/sensor telemetry (current, vibration, temperature) | Flags statistically anomalous signal patterns per machine |
| 2 | **Failure Prediction Agent** | Reliability Forecaster | Anomaly flags + historical failure-mode data | Time-to-failure estimate + predicted failure mode |
| 3 | **Dispatch Optimization Agent** | Technician Router | Predicted failure mode + technician skill/availability data | Skill-matched technician recommendation |
| 4 | **Workforce Safety Agent** | Strain Correlation Analyst | Downtime event + work-area/shift context | Associate Strain Exposure Index flag (aggregate only — never individual) |

Agents 1→2→3 chain sequentially, each consuming the prior agent's structured output. Agent 4 is **architecturally isolated** — a deliberate trust-boundary decision 

---

## Pilot Results — 90 Days

First-time-fix rate weekly trend, 47% to 71%. Monthly downtime hours before vs after.

| Metric | Baseline | Target | Actual | Status |
|---|---|---|---|---|
| First-Time-Fix Rate | 47% | ≥70% | **71%** | ✅ Met |
| MTTR | 94 min | -35% | **-38%** | ✅ Met |
| Predictive alert lead time | n/a | ≥4 hrs | **4.6 hrs avg** | ✅ Met |
| Structured failure-mode capture | ~12% | ≥85% | **79%** | ⚠️ In progress |
| Strain exposure baseline | Not tracked | Establish baseline | **312 incidents logged** | ✅ Met |

Full results, including AI-pipeline-health metrics (agent precision, mode-match rate, dispatch acceptance rate), are in [`dashboard/dashboard.html`](dashboard/dashboard.html) (interactive) and Section 11 of the Master Document.

---

## What I Actually Did

| Activity | Detail |
|---|---|
| **Floor walks** | Structured time on the production floor across multiple shifts, observing breakdown response and PLC behaviour in real time |
| **Signal/PLC review** | Reviewed existing PLC I/O configurations and identified which signal types (current, vibration, temperature) were already available vs. needed retrofit |
| **Stakeholder interviews** | 22 individuals — RME engineers, maintenance technicians, line supervisors, floor workers, plant operations leadership |
| **Data analysis** | Historical maintenance logs, breakdown timestamps, technician dispatch records, shift production data |
| **AI agent design** | Designed the 4-agent reasoning pipeline, mapping each agent to a specific stage of the sensor-to-decision chain |
| **Requirements structuring** | Synthesised floor observations, signal analysis, and AI architecture into a formal Technical Requirements Document |
| **Metrics definition** | Defined DMAIC-aligned metrics: MTBF, MTTR, First-Time-Fix Rate, Associate Strain Exposure Index, Signal-to-Alert Lead Time |

---

## Key Innovation: Machinery AND People, From the Same Signal Layer

Most predictive maintenance platforms stop at the machine. SignalForge treats the **same downtime event** as a dual signal: a machine reliability data point (feeding the Failure Prediction Agent) and a workforce safety data point (feeding the Workforce Safety Agent) — because floor research confirmed that every hour of unplanned downtime had a measurable, previously invisible human cost, not just a production cost.

---

## Repository Structure

```
signalforge/
├── README.md                          ← You are here
├── LICENSE.md                         ← © Nikhil Tiwari
├── PROJECT_MASTER_DOCUMENT.md         ← Markdown source: decisions, tradeoffs, phases, implementation log
├── SkillsAndTools.md                  ← Real PM/AI-PM tool stack used
├── docs/
│   ├── MasterDocument/
│   │   ├── SignalForge_Master_Document.pdf   ← ⭐ Complete polished record (start here)
│   │   └── SignalForge_Master_Document.docx  ← Editable Word version
│   ├── TechnicalRequirementsDoc.md    ← Core requirements artifact
│   ├── DMAIC_CaseStudy.md             ← Six Sigma DMAIC structure
│   ├── PRD.md                         ← Product requirements (PM framing)
│   ├── AIAgentDesign.md               ← 4-agent architecture, prompts, tradeoffs
│   ├── StakeholderInterviews.md       ← Floor research synthesis
│   ├── RiskRegister.md                ← Project + operational risks
│   └── Postmortem.md                  ← Honest retrospective
├── analytics/
│   ├── KPIFramework.md                ← MTBF, MTTR, FTFR, Strain Index, Signal Lead Time
│   └── SQLQueries.sql                 ← Maintenance + signal log analysis queries
├── engineering/
│   ├── SystemArchitecture.md          ← Full sensor-to-dashboard architecture
│   └── SensorPLCSpec.md               ← Sensor types, PLC integration, IoT gateway
├── design/
│   └── FloorLayoutAndWorkflow.md      ← Plant floor workflow before/after
├── assets/                            ← Architecture diagrams & pilot charts (PNG)
├── dashboard/
│   └── dashboard.html                 ← Standalone interactive implementation dashboard
└── demo/
    └── InterviewScript.md             ← How to tell this story for Amazon RME PM
```

---

## Why This Matters For an Amazon Reliability & Maintenance Engineering PM Role

| What the role needs | What SignalForge demonstrates |
|---|---|
| Taking technical requirements for RME | A complete Technical Requirements Document, built from floor + signal research |
| Improving key metrics | Six Sigma DMAIC structure with defined before/after metrics |
| Helping machinery... | AI-driven failure prediction grounded in real PLC/sensor signal types |
| or people working at warehouse | Workforce Safety Agent — explicit, architecturally separate strain tracking |
| AI/ML product judgment | A genuine 4-agent pipeline with documented tradeoffs, not a black-box claim |
| Electrical/controls fluency | Real sensor types, PLC I/O, IoT gateway architecture — not abstracted away |

---

*© 2026 Nikhil Tiwari. All rights reserved. Client name withheld for confidentiality. See [LICENSE.md](LICENSE.md). All figures are illustrative reconstructions for portfolio purposes — see the Master Document for full methodology and honest limitations disclosure.*
