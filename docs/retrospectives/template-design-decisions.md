# Template Design Decisions

Each entry has Context, Decision, Rationale, and Consequences. Omit a section only when its content is obvious from the others. New entries go above the line.

---

## 2026-06-02: Strengthen Mandatory Log Recording Rules

### Context

The template had `docs/logs/` and `00-log-writing-guide.md`, but AGENTS.md only said "Keep logs short, dated, and append-only" without a mandatory trigger. In practice (nop-chaos-flux), the AI never wrote logs because no condition forced it. nop-chaos-flux had to add its own "Docs Maintenance" section with explicit mandatory triggers, a verification checklist, and a full-green baseline recording rule.

### Decision

- Updated AGENTS.md Operating Rule 7: added mandatory trigger "After completing any significant code change, you MUST update the daily dev log"
- Added `Docs Maintenance` section to AGENTS.md with two mandatory items (log update + owner doc update) and a full-green baseline recording rule
- Expanded `docs/logs/00-log-writing-guide.md` from a 19-line skeleton to a full guide with Purpose, Rules (6 items), Path Convention, Entry Format example, and step-by-step Adding A New Entry instructions
- Added log directory initialization step to `START-HERE-after-copy.md` Required checklist

### Rationale

Without a mandatory trigger and concrete format guide, the log rule was invisible to AI agents. The template had the directory structure and a placeholder guide, but neither AGENTS.md nor the guide told agents when or how to write entries. nop-chaos-flux proved that a "Docs Maintenance" section with MUST-level triggers and a full-green recording rule makes log recording actually happen.

### Consequences

Copied projects will have enforceable log rules from the start. The expanded `00-log-writing-guide.md` provides enough format detail that agents can write well-structured entries without guessing. The START-HERE checklist ensures the log directory structure is ready before the first coding session.

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
