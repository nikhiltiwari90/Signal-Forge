# System Architecture
## SignalForge — Sensor-to-Dashboard Platform Architecture
**Author:** Nikhil Tiwari, Product Manager (M.Eng Electrical Engineering)

---

## Full Architecture Overview

```
SIGNAL LAYER (see engineering/SensorPLCSpec.md)
│
PLC analog/digital I/O ──► IoT Edge Gateway (Modbus → MQTT) ──► Structured signal store
                                                                       │
AI AGENT PIPELINE (see docs/AIAgentDesign.md)                         │
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
                  [architecturally isolated —                        │
                   no upstream/downstream link]                       │
                                │                                     │
                                └──────────────┬──────────────────────┘
                                               ▼
                                    SignalForge Dashboard
                                               │
                       RME engineers · plant ops · safety leadership
```

This architecture directly implements both the Technical Requirements Document's 5 functional requirements and the 4-agent AI design — see `docs/TechnicalRequirementsDoc.md` and `docs/AIAgentDesign.md` for full detail on each component's acceptance criteria and reasoning design.

---

## Data Flow Summary

1. **Capture:** PLC signal data (motor current, vibration, temperature, pressure) and technician mobile logging both feed into a structured failure-mode data store via a non-invasive IoT edge gateway — replacing inconsistent paper notes (FR-1)
2. **Detect:** The Signal Anomaly Agent identifies statistically anomalous deviations from each machine's baseline (Agent 1)
3. **Predict:** The Failure Prediction Agent maps confirmed anomalies to predicted failure modes and time-to-failure estimates (Agent 2) — this is the predictive alerting capability specified in FR-2
4. **Dispatch:** The Dispatch Optimization Agent recommends skill-matched technicians for predicted or reported failures (Agent 3) — directly addressing FR-3
5. **Safety:** The architecturally isolated Workforce Safety Agent flags downtime periods correlating with known manual workaround patterns, tracked at work-area/shift level only (Agent 4, FR-4)
6. **Surface:** All of the above surfaces into a single SignalForge dashboard for engineers, plant operations, and safety leadership (FR-5)

---

## Key Architectural Decision: Why the Workforce Safety Agent Is Isolated

The Workforce Safety Agent (Agent 4 / FR-4) is architecturally separate from the sequential Agent 1→2→3 pipeline, not chained into it, for one critical reason: **its data must never flow into individual technician or worker performance evaluation**, per the hard constraint defined in the Technical Requirements Document and reinforced by floor worker trust concerns surfaced during stakeholder research. Keeping it as a fully isolated agent with its own access controls and aggregation rules (work-area/shift level only, never individual) makes that constraint enforceable at the architecture level, not just a policy promise. See `docs/AIAgentDesign.md` for the full tradeoff discussion.

---

## Key Architectural Decision: Why a Non-Invasive IoT Gateway, Not PLC Reprogramming

Rather than modifying the plant's existing, safety-rated PLC ladder logic to add new data outputs, SignalForge taps the same signals via a parallel, non-invasive read through an independent IoT edge gateway. This avoids re-validating the entire existing control program — a significant scope and safety-certification risk increase — in exchange for slightly more hardware (the gateway itself) at the edge. Full detail and signal-type rationale in `engineering/SensorPLCSpec.md`.

---

## Non-Functional Architecture Notes

- **Offline-first mobile capture:** Given confirmed WiFi dead zones on the plant floor, technician logging must capture locally and sync on reconnect — not assume constant connectivity
- **Bilingual interface:** Hindi and English support built into the technician-facing layer from day one, not retrofitted
- **Phased sensor rollout:** Only 3 equipment categories instrumented in Phase 1; architecture designed to extend to additional categories without a redesign
- **Edge buffering:** The IoT gateway buffers signal data locally during any connectivity loss, ensuring no signal gaps reach the AI pipeline even during plant network instability

---

*Architecture document authored by Nikhil Tiwari, translating the Technical Requirements Document and AI Agent Design into system architecture · Octacorps Industrial Automation Consultancy · Confidential*
