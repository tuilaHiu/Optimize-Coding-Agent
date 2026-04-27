---
name: codex-coding-workflow
description: Use when coordinating a coding task in this repo, especially implementation, refactor, debugging, review, API work, multi-step planning, helper delegation, verification gates, or context document maintenance.
---

# Codex Coding Workflow

This is the primary reusable workflow for coding work in this repo. It replaces the old prompt-file runtime.

## Core Role

Keep one user-facing conversation. Own:
- clarifying the user's goal, constraints, and success criteria
- classifying the task
- loading or refreshing the right context
- planning enough to make implementation safe
- delegating bounded helper work when appropriate and allowed
- requiring verification before completion
- refreshing context documents after verified changes

For tiny, low-risk edits, direct implementation is acceptable. For complex, noisy, or parallelizable work, use helper agents or helper skills.

## Behavioral Guardrails

- Think before coding: state key assumptions, ambiguity, and tradeoffs before implementation.
- Simplicity first: choose the minimum implementation that satisfies the success criteria.
- Surgical changes: keep every changed line tied to the request; do not perform drive-by cleanup.
- Goal-driven execution: turn vague requests into explicit acceptance criteria and verification steps.
- Push back when a smaller or safer approach better satisfies the user's goal.

## Task Profiles

Classify every coding task:

- `general_task`: spans modules, changes shared behavior, touches infra/auth/middleware/config/dependencies, or needs broad repo context.
  - Primary context: `.project_context.md`
- `api_focus_task`: centered on one API or endpoint's contract, handler, validation, service flow, tests, or performance.
  - Primary context: `.api_context/{api_slug}.md`
  - Use only a concise repo summary when shared architecture matters.

If the task is ambiguous after reading available context, ask the user before planning.

## Workflow

1. Clarify the real goal, constraints, in/out of scope, and done condition.
2. Classify as `general_task` or `api_focus_task`.
3. Load or refresh context:
   - For `general_task`, use `$repo-context` when `.project_context.md` is missing or stale.
   - For `api_focus_task`, resolve `api_slug` and use `$api-dossier` when the dossier is missing or stale.
4. Plan the minimum decision-complete implementation:
   - list assumptions that affect behavior
   - name tradeoffs when there is more than one reasonable approach
   - give each implementation step a verification check
5. Implement:
   - Use `$bounded-implementation` or the `coding_module` custom agent for bounded write scopes.
   - Spawn parallel helpers only when the user asked for agent delegation or runtime policy permits it, and write scopes are disjoint or read-only.
6. Verify with `$verification-gate` or the `verifier` custom agent.
7. Maintain context:
   - For verified `general_task` changes, use `$context-maintenance`.
   - For verified `api_focus_task` changes, refresh the API dossier with `$api-dossier`.
   - Update `.project_context.md` for API work only when verification identifies cross-cutting impact.

## Delegation Contract

When assigning helper work, provide:
- `task_profile`
- `task_goal`
- `scope_boundaries`
- `primary_context_file`
- `secondary_context_summary`
- `allowed_files`
- `acceptance_criteria`
- `verification_steps`
- `expected_output`
- `simplicity_constraints`
- `surgical_change_constraints`

Expect helper output with:
- `status`: `success` | `partial` | `blocked` | `failed`
- `summary`
- `artifacts`
- `changed_files`
- `verification_result`
- `blockers`
- `follow_up_actions`

## Context Discipline

Keep the main thread focused on decisions and outcomes. Prefer concise helper summaries over raw logs, stack traces, or full diffs.
