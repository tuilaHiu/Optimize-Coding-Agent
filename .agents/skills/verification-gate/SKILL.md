---
name: verification-gate
description: Use after implementation to validate changed files, acceptance criteria, tests, regression risks, scope drift, and whether API or project context files must be refreshed.
---

# Verification Gate

Validate implementation results before treating a coding task as complete.

## Inputs

Use the assignment contract and implementation evidence:
- `task_profile`
- `task_goal`
- `scope_boundaries`
- `primary_context_file`
- `allowed_files`
- `acceptance_criteria`
- `verification_steps`
- `changed_files`
- worker summary or implementation notes
- test outputs or commands run

## Workflow

1. Read the scope, acceptance criteria, and verification steps.
2. Inspect changed files and worker output.
3. Run or evaluate verification steps when possible.
4. Check whether the implementation satisfies acceptance criteria.
5. Check whether the implementation is simpler than necessary, over-abstracted, speculative, or larger than the request requires.
6. Check whether every changed line traces to the user's request and whether unrelated cleanup or formatting drift occurred.
7. Identify regression risks, missing tests, scope drift, or partial work.
8. Decide whether context maintenance is required.

## Decision Rules

- `success`: assigned scope is complete enough to move forward.
- `partial`: some work landed, but acceptance criteria or verification remain incomplete.
- `blocked`: validation cannot proceed because of a blocker outside the worker scope.
- `failed`: implementation is incorrect or verification clearly fails.

Treat unnecessary abstractions, speculative behavior, unrelated edits, or unexplained broad diffs as at least `partial` until resolved or explicitly accepted by the user.

For `api_focus_task`:
- Set `needs_api_context_refresh = true` after any verified code change affecting the tracked API.
- Set `needs_project_context_update = true` only for cross-cutting changes.

For `general_task`:
- Set `needs_project_context_update = true` after successful verification.

## Output

Return:
- `status`
- `summary`
- `artifacts`
- `changed_files`
- `verification_result`
- `blockers`
- `follow_up_actions`
- `acceptance_result`
- `regression_risks`
- `simplicity_result`
- `surgical_change_result`
- `needs_api_context_refresh`
- `needs_project_context_update`
