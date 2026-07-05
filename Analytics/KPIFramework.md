# KPI Framework
## SignalForge — Reliability & Workforce Safety Metrics
**Author:** Nikhil Tiwari, Product Manager

---

## North Star Metric

### Reliable Production Hours (RPH)

**Definition:** Total scheduled production hours minus hours lost to unplanned downtime, weighted by whether the response met First-Time-Fix standard.

**Why this metric:** It connects equipment reliability directly to the business outcome (production), rather than tracking machine uptime as an abstract engineering metric disconnected from plant output.

---

## Core KPI Tree

```
NORTH STAR: Reliable Production Hours (RPH)
│
├── MACHINERY RELIABILITY
│   ├── MTBF (Mean Time Between Failure) — by equipment category
│   ├── MTTR (Mean Time To Repair) — target: -35% from 94 min baseline
│   ├── First-Time-Fix Rate (FTFR) — target: 47% → 70%+
│   └── Predictive Alert Lead Time — target: ≥4 hours pre-failure
│
├── AI AGENT PIPELINE HEALTH (new — see docs/AIAgentDesign.md)
│   ├── Signal Anomaly Agent — Precision (flagged anomalies that were real)
│   ├── Signal Anomaly Agent — False Positive Rate
│   ├── Failure Prediction Agent — Predicted vs. Actual Failure Mode Match Rate
│   ├── Failure Prediction Agent — Time-to-Failure Estimate Accuracy
│   └── Dispatch Optimization Agent — Skill-Match Acceptance Rate (did the recommended technician get sent)
│
├── TECHNICIAN EFFECTIVENESS
│   ├── Skill-Match Dispatch Accuracy
│   ├── Repeat Dispatch Rate (the "defect" in Six Sigma terms)
│   └── Average Technician Travel/Search Time
│
├── WORKFORCE SAFETY (the people half of the JD — isolated agent, see AIAgentDesign.md)
│   ├── Associate Strain Exposure Index (new metric — see below)
│   ├── Manual Workaround Incident Count (by line/shift)
│   └── Minor Injury/Strain Report Correlation with Downtime Events
│
└── DATA & SYSTEM HEALTH
    ├── Structured Failure-Mode Capture Rate (% of repairs logged properly)
    ├── Dashboard Uptime
    └── Technician Mobile Logging Compliance Rate
```

---

## Metric Definitions in Detail

### MTBF — Mean Time Between Failure
`Total Operating Time / Number of Failures` — tracked per equipment category (conveyors, loom feeders, dyeing pumps). Higher is better.

### MTTR — Mean Time To Repair
`Total Repair Time / Number of Repairs` — from dispatch to confirmed sustained operation (standardised definition from DMAIC Measure phase). Lower is better.

### First-Time-Fix Rate (FTFR)
`Repairs Resolved on First Dispatch / Total Repairs` — the primary Six Sigma "quality" metric for the maintenance process itself. Higher is better. Baseline: 47%. Target: 70%+.

### Predictive Alert Lead Time
Time between the Failure Prediction Agent's alert and the actual failure event. Target: ≥4 hours, giving technicians enough lead time to prepare the correct parts and skill before dispatch.

### Signal Anomaly Agent — Precision
`True Anomalies Confirmed / Total Anomalies Flagged` — measures whether Agent 1's anomaly flags correspond to real, confirmed issues (validated against eventual repair logs) rather than noise. Low precision here would cascade false signals through the entire pipeline.

### Failure Prediction Agent — Mode Match Rate
`Predictions Where Actual Failure Mode Matched Prediction / Total Predictions` — the core trust metric for Agent 2. Tracked separately from time-to-failure accuracy because the system can correctly predict *that* something will fail while being wrong about *what* will fail — both matter, but for different downstream reasons (dispatch routing depends specifically on correct failure mode).

### Associate Strain Exposure Index (ASEI) — Original Metric, Designed for This Engagement

**This metric did not exist before this engagement — it was designed specifically to make the "hidden factory" of manual workarounds visible.**

`ASEI = Σ (Workaround Duration × Estimated Physical Load Factor) per work area per shift`

Where Physical Load Factor is a simple 1–3 scale (light/moderate/heavy manual handling) assigned jointly with line supervisors based on the specific workaround type observed (e.g., manual fabric roll carrying = Load Factor 3).

**Explicit design constraint:** ASEI is calculated and reported at the work-area/shift level only — never at the individual worker level — per the hard constraint defined in the Technical Requirements Document (Section 6).

---

## Target Dashboard Refresh Cadence

| Metric Group | Refresh Rate | Primary Audience |
|---|---|---|
| Machinery Reliability | Real-time / 15-min refresh | RME Engineers, floor supervisors |
| Technician Effectiveness | Daily | RME Engineering Lead |
| Workforce Safety (ASEI) | Weekly trend | Plant Ops + Safety Leadership |
| Data & System Health | Daily | Octacorps technical team (system maintainers) |

---

*KPI Framework authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
