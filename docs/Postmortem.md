# Postmortem
## SignalForge — 90-Day Pilot Retrospective
**Author:** Nikhil Tiwari, Product Manager

---

## What Worked

The combination of floor presence and data analysis was the single biggest driver of a credible requirements document. Pure data analysis would have surfaced the dispatch mismatch problem (FR-3) but never the associate strain issue (FR-4) — that came entirely from being physically present and earning enough trust in informal conversations for supervisors and workers to mention something they'd never have put in a formal report.

The hard constraint on associate strain data (never used for individual performance evaluation) was essential and correctly prioritised from day one — without it, the data collection effort would likely have failed on trust grounds before it produced any value.

## What I'd Do Differently

**Structured failure-mode capture rate landed at 79%, short of the 85% target.** In retrospect, the 90-second logging constraint, while well-intentioned, was still occasionally too slow during the most chaotic breakdown moments — exactly when technicians are most rushed and most likely to skip structured logging in favour of just fixing the machine. A faster, more constrained logging format (e.g., a 3-tap categorical selection rather than any free text) might have closed this gap.

**The predictive alerting model's data dependency was underestimated initially.** Rule-based fallback alerting had to be built faster than planned because historical data density for 2 of the 3 equipment categories was lower than assumed during scoping.

## What This Engagement Taught Me

Requirements gathering is not a one-time data-collection exercise — it's an ongoing trust-building process, especially when the requirement touches something workers have never been asked about (associate strain). The most valuable insight in this entire project came from a finding nobody explicitly requested, which reinforced that floor presence and genuine listening matter as much as structured interview protocols.

---

*Postmortem authored by Nikhil Tiwari · Personal reflection · Octacorps Industrial Automation Consultancy*
