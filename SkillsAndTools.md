# Skills & Tools
## SignalForge — What a Real AI/IT Product Manager Uses on This Kind of Project
**Author:** Nikhil Tiwari

---

## Why This Document Exists

A portfolio project is more credible when it names the actual tools and skill disciplines a Product Manager would genuinely reach for at each phase — not a generic skills list, but tools mapped to the specific work this project required.

---

## Skills Applied, By Project Phase

### Discovery & Requirements Phase

| Skill | How It Was Applied |
|---|---|
| Stakeholder interviewing | 22 structured/informal interviews across RME engineers, technicians, supervisors, workers, leadership |
| Floor-based ethnographic observation | Direct shift shadowing to surface the workforce-strain insight no document or interview alone would have revealed |
| Requirements elicitation & documentation | Translating floor findings into a formal Technical Requirements Document with explicit acceptance criteria |
| Six Sigma DMAIC methodology | Structuring the entire problem (Define → Measure → Analyze → Improve → Control), not just the AI/software layer |
| Electrical/controls literacy (M.Eng EE) | Reviewing existing PLC I/O and signal types to scope a realistic, budget-conscious sensor strategy |

### Analysis Phase

| Skill | How It Was Applied |
|---|---|
| SQL data analysis | Historical maintenance dispatch log analysis — MTTR, FTFR baseline, skill-mismatch quantification |
| Root cause analysis (5-Whys) | Applied to both the dispatch-accuracy problem and the workforce-strain visibility gap |
| Statistical baseline definition | Establishing Six Sigma baseline sigma level from First-Time-Fix Rate data |

### AI/Product Architecture Phase

| Skill | How It Was Applied |
|---|---|
| Agentic AI system design | Designing the 4-agent reasoning pipeline, mapped to genuinely distinct cognitive/decision tasks |
| Prompt/reasoning-flow design | Defining each agent's mandate, input/output contract, and context-passing rules |
| AI product judgment & responsible AI design | The Workforce Safety Agent's architectural isolation — a deliberate trust/capability tradeoff, not a technical default |
| Systems/IoT architecture | Specifying the non-invasive PLC tap + edge gateway approach to avoid re-certifying existing safety-rated control systems |

### Delivery & Communication Phase

| Skill | How It Was Applied |
|---|---|
| Executive/dashboard communication | Building a metrics dashboard structured around DMAIC targets, not vanity metrics |
| Technical documentation for engineering handoff | Full requirements, architecture, and sensor specification documents engineering could build against |
| Risk management | Formal risk register spanning technical, adoption, and trust risks |

---

## Tools Used (Real Stack, Mapped to Actual Use)

| Tool Category | Specific Tools | Where Used in This Project |
|---|---|---|
| Requirements & documentation | Markdown-based technical specs, structured PRD format | All `docs/` artifacts |
| Data analysis | SQL (MySQL-style syntax) | `analytics/SQLQueries.sql` — MTTR, FTFR, skill-mismatch, ASEI queries |
| Process improvement framework | Six Sigma DMAIC (Green Belt methodology) | `docs/DMAIC_CaseStudy.md` |
| Dashboard & data visualization | Chart.js, HTML/CSS for standalone implementation dashboard | `dashboard/dashboard.html` |
| AI/LLM architecture | Multi-agent orchestration design (Anthropic Claude API pattern, same approach as my AI CPO Simulator project) | `docs/AIAgentDesign.md` |
| Industrial signal/IoT protocols | Modbus RTU, MQTT, 4-20mA analog signal standards, OPC-UA (referenced) | `engineering/SensorPLCSpec.md` |
| Diagramming/architecture | Structured system architecture diagrams | `engineering/SystemArchitecture.md` |
| Project tracking concepts (referenced, not literally used solo) | JIRA-style requirement IDs (FR-1 through FR-5), RICE-style prioritisation | Throughout `docs/TechnicalRequirementsDoc.md` |

---

## Why This Combination Is Rare — And Why It Matters for an Amazon RME PM Role

Most AI Product Manager portfolios show either (a) software/app-layer AI work with zero industrial/electrical grounding, or (b) industrial engineering work with no AI architecture depth. This project is deliberately built to show genuine fluency in **both**, because that combination — Six Sigma + real signal/PLC literacy + agentic AI system design + workforce safety judgment — is precisely the profile an Amazon RME Product Manager role in Operations needs, where the work spans physical machinery, real industrial protocols, and increasingly, AI-driven reliability tooling.

---

*Skills & Tools document authored by Nikhil Tiwari · Portfolio reference*
