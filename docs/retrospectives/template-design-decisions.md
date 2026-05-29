# Template Design Decisions

Each entry has Context, Decision, Rationale, and Consequences. Omit a section only when its content is obvious from the others. New entries go above the line.

---

## 2026-05-29: Add Reusable Engineering Skills And Optional Tools Workspace

### Context

The template now includes a broader reusable engineering surface: bug diagnosis, code quality audit, refactor discovery, refactor execution, root-level text-file defaults, and a repo-local `tools/` workspace for generic checks.

### Decision

- Added `docs/skills/bug-diagnosis-prompt.md`
- Added `docs/skills/code-quality-audit-prompt.md`
- Added `docs/skills/code-refactor-discovery-prompt.md`
- Added `docs/skills/code-refactor-prompt.md`
- Updated `docs/skills/README.md`
- Added `.editorconfig`, `.gitattributes`, and `.gitignore`
- Added `tools/` as an optional pnpm subproject for reusable repository-local utilities

### Rationale

This change was made because the template already defined a docs-driven workflow, but it lacked reusable methods for three common execution patterns that recur after routing: proving root cause, auditing changed code for real risk, and restructuring code without quietly changing behavior.

The repository also needed a small default quality baseline for copied projects. Root-level text normalization reduces avoidable diffs, while keeping Node-based utilities inside `tools/` preserves the template's cross-stack posture instead of turning the repository root into a Node-only project.

### Consequences

Copied projects can adopt a wider set of reusable engineering methods immediately, and they have a ready place to grow lightweight repo-local checks without coupling the whole template to a single runtime stack.

## 2026-05-29: Add Index Routing Audit Skill

### Context

Existing audit skills cover document quality and plan/decision auditing, but none verify that the index tree (`docs/index.md` + per-directory READMEs) actually routes readers to the right place.

### Decision

- Added `docs/skills/index-routing-audit-prompt.md`

### Rationale

This change was made because routing quality is a recurring template risk: a copied project can have the right owner docs but still fail to guide agents and maintainers to the correct next artifact.

Routing failures are often contextual: an index entry can be technically correct yet still fail a specific persona. A simple checklist misses this. The prompt uses three layers — coverage table, persona-based routing test, structural checks — so that mechanical correctness and contextual reachability are both evaluated.
