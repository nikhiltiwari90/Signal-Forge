# Sensor & PLC Integration Specification
## SignalForge — Signal Layer Design
**Author:** Nikhil Tiwari, Product Manager (M.Eng Electrical Engineering)

---

## Purpose

This document specifies the actual electrical signal types, sensor categories, and PLC integration architecture that feed SignalForge's AI pipeline. It exists because a predictive maintenance product is only as credible as its grounding in real signal data — this is the layer that connects factory-floor electrical engineering to the AI agents described in `docs/AIAgentDesign.md`.

---

## Existing Plant Infrastructure (As Found)

The plant's 3 prioritised equipment categories already run on PLCs (Programmable Logic Controllers) handling basic stop/start and interlock logic. Critically, **the PLCs already receive most of the raw signal data SignalForge needs — it was never being captured or stored, only used transiently for immediate control logic.**

| Equipment Category | Existing PLC Function | Signal Already Present (Uncaptured) |
|---|---|---|
| Main conveyors | Start/stop, jam detection (binary) | Motor current draw (analog 4-20mA), belt speed (encoder pulse) |
| Automated loom feeders | Feed timing control | Servo motor current, feed tension (analog) |
| Dyeing process pumps | Flow on/off control | Pump motor current, discharge pressure (analog 4-20mA) |

**Key insight from floor/PLC review:** This plant did not need a full sensor retrofit to get meaningful predictive signal — it needed a way to *capture and structure data the PLCs were already generating but discarding.* This significantly de-risked the project's sensor budget (see Risk Register R-06).

---

## Signal Types Used

### 1. Motor Current Draw (4-20mA Analog Loop)

**What it tells us:** Rising current draw on a consistent load is one of the most reliable early indicators of mechanical degradation — bearing wear, misalignment, or developing friction — before an audible or visible fault appears.

**Where it's tapped:** Existing PLC analog input cards already terminate this signal for control purposes; SignalForge adds a parallel tap (non-invasive current transducer clamp) rather than rewiring the PLC's own control loop, to avoid any risk to existing safety-rated control logic.

**Why this matters for AI agent design:** This is the primary input to the **Signal Anomaly Agent** for conveyors and dyeing pumps — a gradual upward current trend against a stable historical baseline is exactly the kind of pattern an anomaly-detection layer should flag before MTBF data alone would catch it.

---

### 2. Vibration (Accelerometer, Retrofit Required)

**What it tells us:** Vibration spectra (frequency-domain analysis) is the gold-standard signal for rotating equipment — bearing faults, shaft misalignment, and imbalance each produce distinct frequency signatures.

**Where it's tapped:** This signal did **not** already exist on any of the 3 equipment categories — it requires retrofit. This was explicitly flagged in the original Technical Requirements Document's Open Questions (see `docs/TechnicalRequirementsDoc.md`, Section 7) as a budget-dependent item.

**Retrofit approach specified:** MEMS-based wireless accelerometers (battery-powered, magnetically mounted) on conveyor motor housings and loom feeder gearboxes — chosen specifically because they avoid running new wiring through an already-crowded PLC cabinet, at the cost of battery maintenance overhead (addressed in Control phase monitoring, see `docs/DMAIC_CaseStudy.md`).

---

### 3. Temperature (Thermocouple / RTD)

**What it tells us:** Motor housing and bearing temperature trending upward, independent of ambient conditions, is a secondary corroborating signal alongside current draw — useful for the Signal Anomaly Agent to reduce false-positive anomaly flags (a single signal spiking could be noise; current AND temperature rising together is a much stronger signal).

**Where it's tapped:** Dyeing process pumps already have thermocouples for process control (the dye bath temperature itself); a secondary RTD was added at the pump motor housing specifically for this project.

---

### 4. Discharge Pressure (4-20mA Analog, Dyeing Pumps Only)

**What it tells us:** A drop in discharge pressure at constant motor speed indicates impeller wear or seal degradation — a failure mode the floor research specifically flagged from technician interviews as common but historically undiagnosed until the pump fully seized.

---

## PLC-to-AI Data Pipeline (IoT Gateway Architecture)

```
PLC Layer (existing)
   │  Modbus RTU / analog I/O
   ▼
IoT Edge Gateway (new — non-invasive tap)
   │  Protocol translation: Modbus → MQTT
   │  Local buffering for offline resilience (see NFR in Technical Requirements Doc)
   ▼
Structured Failure-Mode Data Store (FR-1)
   │
   ▼
Signal Anomaly Agent → Failure Prediction Agent → Dispatch Optimization Agent
```

**Why a non-invasive edge gateway, not direct PLC reprogramming:** Modifying the existing PLC's own ladder logic to add new outputs would require re-validating the entire existing safety-rated control program — a significant scope and risk increase. Tapping the same signals via a parallel analog/Modbus read, through an independent IoT edge gateway, gets SignalForge the data it needs with zero risk to the plant's existing, already-certified control systems. This was a deliberate, conservative architectural choice given the safety-critical nature of factory floor control systems.

**Protocol choice — Modbus RTU to MQTT bridge:** Modbus RTU is the de facto standard most industrial PLCs of this era support natively; MQTT is the standard lightweight pub/sub protocol for IoT data pipelines feeding cloud/AI systems. The edge gateway's only job is translating between these two worlds.

---

## What I'd Specify Differently With More Budget

Full vibration spectral analysis (FFT-based frequency decomposition) rather than simple amplitude-threshold accelerometer readings would meaningfully improve the Failure Prediction Agent's specificity (not just "anomalous vibration" but "bearing fault signature at X Hz"). This was flagged as a Phase 2 candidate, not Phase 1 — amplitude-threshold detection was judged sufficient to validate the architecture and prove pilot value before justifying the added cost of spectral analysis hardware.

---

*Sensor & PLC specification authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
