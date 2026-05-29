# Template Design Decisions

Each entry has Context, Decision, Rationale, and Consequences. Omit a section only when its content is obvious from the others. New entries go above the line.

---

## 2026-05-29: Add Index Routing Audit Skill

### Context

Existing audit skills cover document quality and plan/decision auditing, but none verify that the index tree (`docs/index.md` + per-directory READMEs) actually routes readers to the right place.

### Decision

- Added `docs/skills/index-routing-audit-prompt.md`
- Updated `docs/skills/README.md` to register the new skill

### Rationale

Routing failures are often contextual: an index entry can be technically correct yet still fail a specific persona. A simple checklist misses this. The prompt uses three layers — coverage table, persona-based routing test, structural checks — so that mechanical correctness and contextual reachability are both evaluated.
