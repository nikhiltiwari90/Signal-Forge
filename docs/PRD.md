# Product Requirements Document
## SignalForge — Predictive Maintenance & Workforce Safety Platform
**Client:** Textile Manufacturing Plant, Bhilwara, Rajasthan (confidential)
**Author:** Nikhil Tiwari, Product Manager
**Engagement:** Octacorps Industrial Automation Consultancy

---

## Executive Summary

SignalForge is a predictive maintenance and workforce safety platform built for a 500+ worker textile manufacturing plant in Bhilwara. It replaces reactive, availability-based maintenance dispatch with skill-matched, data-driven dispatch, while introducing the plant's first systematic visibility into how equipment downtime affects worker physical strain. The platform was scoped through direct floor research — interviews with RME engineers, technicians, supervisors, and workers — combined with six months of historical maintenance data analysis.

---

## Problem

Maintenance at the plant was purely reactive: a machine breaks, a technician is dispatched based on who's available rather than who has the right skill, and 31% of repairs require a second visit because the technician arrives without knowing the actual failure mode. Meanwhile, when equipment goes down, workers informally compensate with manual workarounds — carrying fabric rolls by hand, for example — that nobody has measured, despite obvious physical strain implications.

## Goal

Reduce Mean Time To Repair by 35%+, raise First-Time-Fix Rate from a 47% baseline to 70%+, and establish the plant's first structured visibility into associate strain exposure during downtime — within a 90-day pilot across three prioritised equipment categories.

## Users & Personas

| Persona | Need |
|---|---|
| RME Engineer | Structured failure data to diagnose patterns, not anecdotal paper notes |
| Maintenance Technician | Know the failure mode before walking to the machine |
| Line Supervisor | Visibility into how downtime affects their workers, not just the machine |
| Plant Operations Leader | A single source of truth for reliability metrics |
| Floor Worker | Implicit beneficiary — reduced manual strain exposure, never individually tracked |

## Scope (Phase 1 Pilot)

In scope: 3 equipment categories (main conveyors, automated loom feeders, dyeing process pumps), structured failure capture, skill-matched dispatch, associate strain flagging, unified dashboard.

Out of scope: full plant-wide sensor retrofit, automated parts ordering, individual worker performance tracking (explicitly and permanently excluded).

## Success Metrics

See `analytics/KPIFramework.md` for full detail. Headline: First-Time-Fix Rate 47%→70%+, MTTR -35%, Associate Strain Exposure Index baseline established.

## Full Technical Requirements

See `docs/TechnicalRequirementsDoc.md` — the complete functional and non-functional requirements set, derived from floor research and stakeholder interviews.

---

*PRD authored by Nikhil Tiwari · Octacorps Industrial Automation Consultancy · Confidential*
