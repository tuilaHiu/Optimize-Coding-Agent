---
name: context-maintenance
description: Use after verified changes when .project_context.md must be refreshed with updated architecture, toolchain, run/test workflow, shared module, dependency, or recent-change information.
---

# Context Maintenance

Refresh `.project_context.md` after verified changes.

## When To Run

- Run for `general_task` after successful verification.
- Run for `api_focus_task` only when verification returns `needs_project_context_update = true`.
- Do not run when verification is `partial`, `blocked`, or `failed`.

## Workflow

1. Get the verified changed file list and verifier findings.
2. Read only changed files plus directly related entrypoints or shared modules.
3. Update only impacted sections of `.project_context.md`.
4. Append a concise recent-changes summary.
5. Return a structured summary.

## Constraints

- Modify only `.project_context.md`.
- Do not update API dossier files.
- Do not perform a full repo scan unless no reliable change list is available.

## Output

Return:
- `status`
- `summary`
- `artifacts`
- `changed_files`
- `verification_result`
- `blockers`
- `follow_up_actions`
- `updated_sections`
- `context_freshness_notes`
