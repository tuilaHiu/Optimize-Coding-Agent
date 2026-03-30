# Workflow V2 Task Profiles

## Purpose
Workflow V2 uses one user-facing orchestrator and two task profiles to keep context focused while preserving a single conversation with the user.

## Task Profiles

### `general_task`
Use `general_task` when the request spans multiple modules or changes shared repo behavior.

Typical signals:
- repo-wide refactors
- cross-module features
- architecture changes
- auth, middleware, config, infra, dependency, or workflow changes
- tasks that need broad repo context before planning

Primary context:
- `.project_context.md`

### `api_focus_task`
Use `api_focus_task` when the request is primarily about one API or endpoint and can be reasoned about through a focused API dossier.

Typical signals:
- create one API
- improve one API
- adjust one endpoint's validation, handler, service flow, or tests
- tune one API's response contract, errors, or performance
- continue work on a previously tracked API such as OCR

Primary context:
- `.api_context/{api_slug}.md`

Secondary context:
- a short summary of `.project_context.md` only when needed to understand shared architecture

## Classification Rules
1. Start by identifying the main unit of change.
2. Choose `api_focus_task` when one API is clearly the center of gravity.
3. Choose `general_task` when the task changes shared behavior beyond one API or cannot be planned safely from API-local context.
4. If the request looks API-scoped but the expected change touches shared auth, middleware, config, or architecture, keep the task as `api_focus_task` and mark that `.project_context.md` must also be updated after verification.
5. If the request is ambiguous, ask the user before writing plans.

## Context Loading Order

### For `general_task`
1. Ensure `.project_context.md` exists or refresh it with `repo_reader`.
2. Brainstorm with the user.
3. Write the overall plan and module plans.
4. Coordinate coding work.
5. Run `verifier_agent`.
6. After successful verification, run `repo_updater`.

### For `api_focus_task`
1. Resolve the API slug and target endpoint if known.
2. Ensure `.api_context/{api_slug}.md` exists or refresh it with `api_reader`.
3. Load only the API context plus minimal repo context needed for shared understanding.
4. Brainstorm with the user.
5. Write the overall plan and module plans.
6. Coordinate coding work.
7. Run `verifier_agent`.
8. After successful verification, refresh `.api_context/{api_slug}.md`.
9. Update `.project_context.md` only if the verifier confirms the change is cross-cutting.

## `.project_context.md` Update Policy For API Work
Update both `.api_context/{api_slug}.md` and `.project_context.md` when the confirmed API change affects any of the following:
- shared auth or permission flow
- shared middleware, interceptors, or global error handling
- shared schema, model, or base DTO used beyond the target API
- shared service or utility used by multiple APIs
- repo-level config, env setup, dependencies, or run/test workflow
- architecture or module boundaries that matter outside the target API

Update only `.api_context/{api_slug}.md` when the work stays local to the target API, such as:
- endpoint-local validation changes
- controller or handler improvements
- service logic changes used only by that API
- response shape fixes limited to that API
- API-specific tests

## Working Rules
- `main_orchestrator` remains the only user-facing agent.
- `main_orchestrator` is conversation-only and must delegate coding, verification, and context refresh work to helper agents.
- The core helper set is `repo_reader`, `api_reader`, `coding_module_agent`, `verifier_agent`, and `repo_updater`.
- Helper invocation is automatic once the task is clear enough; the user should not need to manually trigger internal subagents.
- Helper model and reasoning choices should favor the cheapest safe profile for the current task.
- Existing helper prompts are updated to use embedded input/output contracts.
- API context files are working context for future implementation, not public product documentation.
- Runtime prompts are the source of truth. Support docs help readability but must not be the only place a critical rule lives.
