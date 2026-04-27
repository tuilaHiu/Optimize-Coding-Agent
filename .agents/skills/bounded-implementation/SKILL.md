---
name: bounded-implementation
description: Use when implementing one assigned module, file group, feature slice, bug fix, or test change with explicit scope boundaries, allowed files, acceptance criteria, and verification steps.
---

# Bounded Implementation

Implement production-ready code for one bounded write scope.

## Required Inputs

Do not start implementation until the assignment is clear enough:
- `task_profile`
- `task_goal`
- `scope_boundaries`
- `primary_context_file`
- `allowed_files`
- `acceptance_criteria`
- `verification_steps`
- `expected_output`

Optional:
- `secondary_context_summary`
- assigned plan path
- coding rules skill such as `$coding-python` or `$coding-fe`
- dependency constraints

## Rules

- Implement only the assigned scope.
- Modify only `allowed_files` or files clearly required by the accepted scope.
- If required work falls outside scope, stop and report it under `out_of_scope_findings`.
- For `api_focus_task`, use the API dossier as primary context unless shared context is provided.
- Add or update tests when behavior changes and the repo has a clear test pattern.
- New dependencies must follow the repo's dependency manager and be explained in the output.
- Keep the implementation simple: no speculative features, no single-use abstractions, no unnecessary configurability, and no handling for impossible scenarios.
- Keep changes surgical: do not reformat, rename, rewrite comments, refactor adjacent code, or delete pre-existing dead code unless directly required.
- Remove only imports, variables, functions, files, or tests that your own change made unused or obsolete.
- If the implementation grows beyond the necessary shape, simplify it before returning.

## Workflow

1. Read the assigned scope and primary context.
2. Read secondary context only if provided.
3. Extract acceptance criteria, allowed files, and verification steps.
4. Report blockers before coding if the scope conflicts with context.
5. For bug fixes or behavior changes, add or identify a reproduction/test first when feasible.
6. Implement the smallest change that satisfies the acceptance criteria.
7. Run listed verification steps when possible.
8. Self-review for scope, style, simplicity, unrelated edits, edge cases, failure paths, and debug leftovers.

## Output

Return:
- `status`: `success` | `partial` | `blocked` | `failed`
- `summary`
- `artifacts`
- `changed_files`
- `verification_result`
- `blockers`
- `follow_up_actions`
- `implemented_scope`
- `out_of_scope_findings`
- `simplicity_review`
- `surgical_change_review`
