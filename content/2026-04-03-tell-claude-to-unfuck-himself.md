---
title: Tell Claude to Unfuck Himself
date: 2026-04-03
---

## Claude Fucked Himself Into a Corner

**Symptom:** He adds layers of onion code and workarounds.

**Problem:** The system prompt tells him to be conservative and only change some small things at a time. It's hard to compel him to do a fresh architecture that breaks old assumptions and requirements.

**Solution:**

- Tell him to remove the problematic architecture entirely on a new branch.
    - Planning mode works well here, because you can review where it will make the cut, and tell him where to add stubs.
- Implement from scratch in a new session.
    - Tell him to research explicitly.


## Example

First, create a clean slate:

```
we want to create a clean slate for a redesign of the worker code and the page processing and the pricing.

delete tasks table and related code. delete tasks api and related code. delete pricing and task costs and related code.

we expect some tests to fail after achieving clean slate. This is fine.
```

Followed by re-implementing the feature from scratch in a new session:

```
implement worker with **SAQ (`saq[postgres]`)**

- Two task types: `DETECT_PAGE` (CPU/OpenCV) and `ANALYZE_REGIONS` (I/O/Anthropic API)
- see ai.py for the actual code that the worker will run to complete the tasks.
- Task triggered via relevant buttons in UI (should be mocked currently)
- WebSocket push on task completion
- FailFast and Loud. We'll take care about stability in a later step
- stay with  official guidelines

current situation: we removed all the old stuff so we can do a complete redesign now. Please ignore the old implementation completely. We are starting from scratch here.

todo:

1. Research SAQ's Postgres backend
2. Research SAQ guides.
3. Plan and implement the migration. You are free to restructure the DB model, schema, constraints as you sees fit

### No constraints

The session may ignore CLAUDE.md constraints. It may change the DB schema, status lifecycle,  — whatever makes the SAQ integration clean. Just flag what changed at the end.
```
