---
title: Tell Claude to Unfuck Himself
date: 2026-04-03
---

Claude Code's system prompt tells him to be conservative — change small things, don't break what works. Usually that's good advice. But sometimes he's already dug himself into a hole: layers of onion code, workarounds on top of workarounds, shims that exist only to preserve assumptions that should have been dropped three commits ago.

When that happens, incremental fixes make it worse. You need to tell Claude to unfuck himself.

## The symptom

You ask for a feature or a fix. Claude delivers something that technically works but adds another layer of indirection, another compatibility shim, another "temporary" workaround. The codebase gets harder to reason about with every change.

## The problem

Claude's default behavior is conservative by design. He avoids breaking things. He patches around existing structure rather than questioning it. That's the right instinct most of the time — but it means he won't spontaneously propose tearing something down and rebuilding it, even when that's clearly the right call.

You have to be the one to say it.

## The solution

Two steps, two sessions.

**Step 1: Create a clean slate.** Tell Claude to delete the problematic architecture entirely, on a new branch. Planning mode works well here — you can review where he'll make the cut and tell him where to add stubs. Expect breakage. That's the point.

**Step 2: Rebuild from scratch in a fresh session.** A new session means no muscle memory from the old design. Tell him to research first, then implement. Explicitly lift any constraints from your `CLAUDE.md` that would pull him back toward the old patterns.

## Example

Here's what this looks like in practice. First prompt — the demolition:

```
We want to create a clean slate for a redesign of the worker
code, page processing, and pricing.

Delete tasks table and related code. Delete tasks API and
related code. Delete pricing and task costs and related code.

We expect some tests to fail after achieving clean slate.
This is fine.
```

Second prompt — in a new session — the rebuild:

```
Implement worker with SAQ (saq[postgres]).

- Two task types: DETECT_PAGE (CPU/OpenCV) and
  ANALYZE_REGIONS (I/O/Anthropic API)
- See ai.py for the actual code that the worker will run
- Task triggered via relevant buttons in UI
- WebSocket push on task completion
- Fail fast and loud — we'll handle stability later
- Stay with official guidelines

Current situation: we removed all the old stuff so we can
do a complete redesign. Ignore the old implementation
completely. Starting from scratch.

Todo:
1. Research SAQ's Postgres backend
2. Research SAQ guides
3. Plan and implement the migration — you are free to
   restructure the DB model, schema, and constraints

No constraints: this session may ignore CLAUDE.md constraints.
Change the DB schema, status lifecycle, whatever makes the
SAQ integration clean. Just flag what changed at the end.
```

The key insight is that Claude won't volunteer to tear things down. But if you give him a blank canvas and explicit permission to redesign, he's quite good at building something clean.
