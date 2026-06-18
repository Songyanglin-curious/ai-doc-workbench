# Roadmap Authoring Guide

## Purpose

This guide defines what `docs/backlog/implementation-roadmap.md` is, how to write it, and when to update it. The roadmap is optional. Use it only when a project is large enough that a flat backlog table no longer shows global progress.

## What a Roadmap Is

A roadmap is a coarse-grained phase index and global status surface. Its core use:

1. After reading the roadmap, an AI or maintainer knows which capabilities are not started (`todo`), already planned (`planned`), or completed (`done`), without re-walking every doc and the codebase.
2. It records each phase's dependencies, owner doc, and reusable framework/platform capabilities.
3. It is the entry point for choosing the next work item.

## What a Roadmap Is NOT

- Not an execution plan. No implementation steps, checkboxes, or closure criteria.
- Not a design doc. It references owner docs; it does not restate business rules.
- Not the backlog. The roadmap is the orchestration layer; backlog items reference roadmap phases.

## Status Tracking

Each phase has one status:

| Status | Meaning | Action |
| --- | --- | --- |
| `todo` | Not started, no plan | Candidate for the next plan |
| `planned` | Has an execution plan | Waiting for implementation |
| `done` | Completed and passed closure audit | Update owner docs and logs |

Status transitions are driven by the plan lifecycle (see `docs/plans/00-plan-authoring-and-execution-guide.md`):

- After draft review passes: `todo` -> `planned`
- After closure audit passes: `planned` -> `done`. Do NOT mark `done` before closure audit passes.

## Structure

A roadmap usually contains, in order:

1. Header — last-updated date, source docs
2. Purpose — what this file is (fixed text, referencing this guide)
3. Phase Status — the only dynamic status block
4. Framework / Platform Reuse — capabilities already provided by the stack, so the team does not rebuild them
5. Current Baseline — short summary of what exists and the main gaps
6. Phases table — global phase index (Phase / Status / Owner Doc / Dependencies / Reuse / Plan link)
7. Phase Details — short delivery scope per phase (no checkboxes)
8. Dependency Graph — Mermaid flow
9. Cross-Cutting — cross-phase concerns
10. Rule — authoring and update rules

Omit sections that do not apply (for example, an artifact/entity coverage map only when it adds value).

## Writing Rules

1. Keep it coarse-grained. Phase Details are short lists, not implementation steps.
2. Annotate framework/platform reuse explicitly to avoid rebuilding existing capabilities.
3. Keep status accurate. Stale status is worse than no status.
4. Keep dependencies consistent between the table and the graph; the table wins on conflict.
5. Do not duplicate owner-doc content. Phase Details list delivery scope only.

## Update Triggers

All status changes are driven by the plan lifecycle:

| Event | Update | Precondition |
| --- | --- | --- |
| Draft review passes | Phase `todo` -> `planned` | Plan passed independent draft review |
| Closure audit passes | Phase `planned` -> `done` | Must wait for closure audit to pass |
| Closure reveals new reuse opportunity | Update the Reuse section and the phase | Plan closed |
| New or adjusted owner doc | Check impact on Phase Details | — |

## Anti-Patterns

- Writing the roadmap as a detailed implementation plan
- Restating owner-doc business rules in the roadmap
- Letting status go stale
- Marking `done` before closure audit passes
- Not annotating existing framework/platform capabilities, causing redundant rebuilds
