# Codex Compatibility Notes

The active Codex runtime now lives in:

- `.agents/skills/`
- `.codex/agents/`

This `codex/` folder is retained only for compatibility notes and historical support files. Do not treat old prompt-file workflows as the runtime source of truth.

## Skill-First Mapping

- `main_orchestrator` is now `$codex-coding-workflow`.
- `repo_reader` is now `$repo-context` plus the `repo_reader` custom agent.
- `api_reader` is now `$api-dossier` plus the `api_reader` custom agent.
- `coding_module_agent` is now `$bounded-implementation` plus the `coding_module` custom agent.
- `verifier_agent` is now `$verification-gate` plus the `verifier` custom agent.
- `repo_updater` is now `$context-maintenance` plus the `repo_updater` custom agent.

## Recommended Flow

1. Start with `$codex-coding-workflow`.
2. Classify the request as `general_task` or `api_focus_task`.
3. Refresh `.project_context.md` or `.api_context/{api_slug}.md` only when needed.
4. Implement bounded scopes directly or with helper agents.
5. Verify before completion.
6. Refresh context artifacts after verified changes.
