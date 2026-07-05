# Stakeholder Interviews & Floor Research Synthesis
## SignalForge — Requirements Discovery
**Author:** Nikhil Tiwari, Product Manager
**Method:** Direct floor walks across 3 shifts + structured/informal interviews with 22 individuals

---

## Research Methodology

I spent structured time directly on the plant floor — not just reviewing reports from a desk. This included:

- Shadowing maintenance technicians during live repair calls across morning, evening, and night shifts
- Observing breakdown response in real time, including how long technicians took to diagnose vs. fix
- Structured interviews with RME engineers, technicians, and line supervisors
- Informal conversations with floor workers during natural breaks, to understand the human side without making them feel evaluated
- Cross-referencing what I observed and heard against 6 months of historical maintenance dispatch logs

This combination — qualitative floor presence plus quantitative log analysis — is what let the Technical Requirements Document (see `docs/TechnicalRequirementsDoc.md`) include FR-4 (Associate Strain Exposure Flagging), a requirement that didn't exist in any prior request and that data alone would never have surfaced.

---

## Key Findings by Stakeholder Group

### RME Engineers (4 consulted)

**Top pain point:** No structured failure-mode history. All repair notes were inconsistent free-text on paper, making any kind of pattern analysis essentially impossible.

**Direct quote (paraphrased from notes):** "We've been asking for better data for two years, but nobody's ever built the tool to make logging easy. If it takes more than a minute, the techs won't do it consistently."

**This directly shaped FR-1's 90-second logging acceptance criterion.**

---

### Maintenance Technicians (9 consulted)

**Top pain point:** Wrong technician sent for the job — 9 of 9 cited this independently, and it was confirmed in the dispatch log data showing 31% of repairs needed a second visit.

**Observed during shadowing:** On one night shift, I watched a technician walk 200 metres to a conveyor jam, discover it was actually a motor fault requiring different tools, and walk back — a 22-minute round trip before the actual repair even began.

**This directly shaped FR-3's skill-matched dispatch requirement and its 70%+ First-Time-Fix target.**

---

### Line Supervisors (7 consulted)

**Top pain point:** No visibility into cumulative impact of repeated downtime on their teams — both production and worker wellbeing.

**Direct quote (paraphrased):** "When the conveyor goes down on the dyeing line, the girls just start carrying the rolls by hand. Nobody's said it's a problem, but it's not nothing."

**6 of 7 supervisors confirmed manual workarounds were a normal, unofficial response to downtime — this was the single most important finding of the entire research phase, and it came from supervisor conversations, not from any system or report.**

---

### Floor Workers (~15, informal)

Workers were understandably guarded in formal interview settings, so most insight came from informal conversation during breaks. The consistent theme: manual workarounds were accepted as "just what happens" when machines go down, not something anyone had ever asked them about directly.

**This shaped the hard constraint in Technical Requirements Document Section 6 — strain data must never be used for individual performance evaluation. Workers needed to trust that being observed wouldn't be used against them, or the whole data-collection effort would fail on legitimacy grounds alone.**

---

### Plant Operations Leadership (2 consulted)

**Top priority:** A single source of truth. Currently maintenance data was split across paper logs, a basic spreadsheet, and verbal shift handoffs — leadership had no real-time visibility into plant reliability.

**This shaped FR-5's unified dashboard requirement.**

---

## The Insight That Wasn't In Any Request

The most important finding of this research phase was not something any stakeholder explicitly asked for. It emerged from triangulating three things: (1) supervisor interviews confirming manual workarounds happen, (2) direct floor observation confirming how physically demanding those workarounds are, and (3) the complete absence of any existing system that tracked this.

**This is the core lesson I'd point to from this engagement: the most valuable requirement often isn't the one stakeholders ask for — it's the one you find by being present enough, in enough different conversations, to see the pattern they haven't named yet.**

---

*Research synthesis authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
