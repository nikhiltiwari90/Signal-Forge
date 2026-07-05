# AI Agent Design
## SignalForge — 4-Agent Reasoning Pipeline
**Author:** Nikhil Tiwari, Product Manager

---

## Why an Agentic Architecture, Not a Single Model

A single model asked to "predict failures and dispatch technicians from this sensor data" would conflate four genuinely different reasoning tasks: statistical anomaly detection, failure-mode forecasting, constraint-based technician matching, and workforce-safety correlation. These are different cognitive modes requiring different inputs, different confidence calibration, and different downstream consumers (an RME engineer cares about Agent 1's output very differently than plant safety leadership cares about Agent 4's).

This mirrors the exact design principle proven in my AI CPO Simulator project: **decompose by reasoning mode, derived from the structure of the real decisions the output needs to drive — not by an arbitrary feature list.**

---

## The 4 Agents in Detail

### Agent 1 — Signal Anomaly Agent

**Role:** OT Signal Analyst

**Input:** Raw time-series signal data per machine (motor current, vibration amplitude, temperature, discharge pressure where applicable) — see `engineering/SensorPLCSpec.md` for signal types per equipment category.

**Mandate:** Identify statistically anomalous deviations from each machine's own historical baseline, accounting for normal operating-condition variance (e.g., higher current draw during a heavier fabric run is not necessarily anomalous).

**Output:** A structured anomaly flag — machine ID, signal type, deviation magnitude, confidence level — passed forward as context to Agent 2.

**Why this is Agent 1, not folded into Agent 2:** Anomaly detection on raw signal noise is a fundamentally statistical task (deviation from baseline) distinct from the inferential task of mapping an anomaly to a specific failure mode. Separating them lets Agent 1 stay narrowly focused and auditable — an RME engineer can independently verify "was this really anomalous?" without needing to also evaluate a failure prediction.

---

### Agent 2 — Failure Prediction Agent

**Role:** Reliability Forecaster

**Input:** Agent 1's anomaly flags + historical structured failure-mode data (FR-1 in the Technical Requirements Document) — i.e., what failure mode has this specific anomaly signature preceded before, on this or similar machines.

**Mandate:** Produce a time-to-failure estimate and most-likely predicted failure mode, with an explicit confidence level.

**Output:** Predicted failure mode + estimated lead time before failure, passed to Agent 3.

**Why this needs Agent 1's output, not raw signal directly:** Without the anomaly-detection layer first narrowing the signal to "this specific deviation, at this confidence," the Failure Prediction Agent would be reasoning over noisy, high-volume raw telemetry — exactly the kind of task that produces unreliable, hard-to-audit predictions. Sequential context passing (the same principle as the CPO Simulator) keeps each agent's reasoning scope tight.

---

### Agent 3 — Dispatch Optimization Agent

**Role:** Technician Router

**Input:** Agent 2's predicted failure mode + technician skill/availability data (FR-3 in the Technical Requirements Document).

**Mandate:** Recommend the best-matched available technician(s) for the predicted (or reported) failure mode — directly addressing the floor research finding that 31% of repairs required a second visit due to skill mismatch.

**Output:** Ranked technician recommendation with matched skill rationale.

**Why this is separate from prediction:** Predicting *what* will fail and deciding *who* should fix it are different optimization problems — one is a forecasting task, the other is a constraint-satisfaction/matching task (skill, availability, location). Conflating them in one agent would make both harder to tune and harder to explain to a floor supervisor questioning a specific dispatch decision.

---

### Agent 4 — Workforce Safety Agent

**Role:** Strain Correlation Analyst

**Input:** Downtime event data (start/end, equipment category, work area, shift) — explicitly NOT linked to any individual worker identity.

**Mandate:** Flag correlation between downtime events and known manual-workaround patterns (FR-4 in the Technical Requirements Document), producing an aggregate Associate Strain Exposure Index at the work-area/shift level only.

**Output:** ASEI flag, aggregated — feeds the Workforce Safety panel of the dashboard, architecturally isolated from the other 3 agents' outputs per the hard constraint defined in the Technical Requirements Document Section 6.

**Why this agent is architecturally isolated, not chained after Agent 3:** Every other agent in this pipeline chains forward — Agent 1 feeds Agent 2 feeds Agent 3. Agent 4 deliberately does **not** receive or pass technician-identifying information, and its output never feeds back into the dispatch or performance-relevant agents. This isolation is not a technical limitation — it is a deliberate design choice enforcing the non-negotiable trust boundary that floor workers and supervisors raised during research (see `docs/StakeholderInterviews.md`): strain data must never become performance data.

---

## Architecture Diagram (Reasoning Flow)

```
Signal Anomaly Agent
        │  (anomaly flag + confidence)
        ▼
Failure Prediction Agent
        │  (predicted failure mode + lead time)
        ▼
Dispatch Optimization Agent
        │  (technician recommendation)
        ▼
   [ SignalForge Dashboard ]
        ▲
        │  (aggregate ASEI only — isolated, no upstream/downstream link)
Workforce Safety Agent
```

---

## Tradeoffs in This Design

| Decision | Benefit | Cost Accepted |
|---|---|---|
| 4 agents, sequential for 1→2→3 | Each stage stays auditable and independently verifiable by RME engineers | More orchestration complexity and latency than a single combined model |
| Agent 4 architecturally isolated | Enforces the non-negotiable worker-trust constraint at the system level, not just policy | Cannot exploit any genuine cross-signal correlation between strain patterns and failure patterns, even if one existed — a deliberate forgone opportunity in exchange for trust |
| Anomaly detection separated from failure prediction | Each stage is independently auditable; easier to debug false positives | Slightly higher latency than a single end-to-end model |
| Confidence levels surfaced at every stage | RME engineers can calibrate trust in the system incrementally rather than treating it as a black box | Requires UI/dashboard design effort to present confidence meaningfully, not just a final answer |

---

## What I'd Build Differently With More Time/Budget

A feedback loop where confirmed/disconfirmed predictions (did the predicted failure actually occur, on schedule) retrain Agent 2's failure-mode mapping over time. This is explicitly flagged as a Phase 2 capability — Phase 1 establishes the pipeline and baseline accuracy; closing the feedback loop is the natural next investment once sufficient confirmed/disconfirmed prediction volume exists.

---

*AI Agent Design authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
