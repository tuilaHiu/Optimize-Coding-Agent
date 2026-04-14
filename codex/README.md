# Codex CLI Folder Guide

## Overview
A small toolkit of coding rules and workflow helpers used by Codex CLI and Codex extensions.

## Update From V1 To V2
`Codex Coding Kit v2` changes the workflow from a multi-agent user flow into a single user-facing orchestrator flow.

### What changed
- `main_orchestrator` is now the primary entrypoint for user conversations.
- Planning is no longer a separate user-facing step. Brainstorming and planning now stay inside `main_orchestrator`.
- `main_orchestrator` is conversation-only. It should not code directly; it should delegate implementation and verification to helper agents.
- The core helper set is now:
  - `repo_reader`
  - `api_reader`
  - `coding_module_agent`
  - `mr_reviewer_agent`
  - `verifier_agent`
  - `repo_updater`
- Workflow V2 supports two task profiles:
  - `general_task` uses `.project_context.md`
  - `api_focus_task` uses `.api_context/{api_slug}.md`
- Merge request review reuses the same task profiles and routes read-only review through `mr_reviewer_agent`.
- Prompt files are the runtime source of truth. Support docs and templates help readability, but prompt instructions win if there is any mismatch.

### What this means in practice
- In v1, you could think in separate manual steps such as `repo_reader -> planning_agent -> coding_agent -> repo_updater`.
- In v2, you should talk to only one agent: `main_orchestrator`.
- `main_orchestrator` decides when to auto-spawn internal helpers, when to refresh context, and when verification is required before updating context files.
- Merge request review uses the final diff from `merge_base...head` as the primary review artifact; commit history is supporting context.
- API-focused work now has a dedicated dossier flow through `.api_context/{api_slug}.md`, so repeated work on one API can reuse focused context instead of loading the full repo each time.
- Helper agents should use model and reasoning settings chosen for efficiency: lightweight readers/updaters on cheaper profiles, coding workers on codex-optimized profiles, MR reviewers on stronger review profiles when risk is high, and verifier workers on stronger validation profiles when risk is high.

### Migration notes
- If you are upgrading from v1, keep using the same `codex/` folder sync flow. The new prompts will replace the old runtime behavior when synced into `~/.codex`.
- Existing support files such as `.project_context.md` remain valid.
- If you previously used a separate planning prompt manually, treat that flow as legacy. The recommended v2 flow starts at `prompts/main_orchestrator.md`.

## Copy this folder into `~/.codex`
```bash
# ensure target exists
mkdir -p ~/.codex

# sync codex into ~/.codex, overwrite matching paths, keep unrelated existing files
cd Optimize-Coding-Agent
rsync -a ./codex/ ~/.codex/
```

## Recommended V2 Flow
1. Start with `main_orchestrator`.
2. Let it classify the request as `general_task` or `api_focus_task`.
3. Let it refresh the right context through `repo_reader` or `api_reader`.
4. Let it coordinate coding work through `coding_module_agent`.
5. Let it gate completion through `verifier_agent`.
6. Let it refresh `.project_context.md` or `.api_context/{api_slug}.md` after verification.

## Merge Request Review Flow
1. Start with `main_orchestrator`.
2. Let it classify the review scope as `general_task` or `api_focus_task`.
3. Let it gather the required review package first: `base_ref`, `head_ref`, `merge_base_ref`, `changed_files`, and `final_diff_artifact`.
4. Let it refresh `.project_context.md` or `.api_context/{api_slug}.md` only for the changed scope.
5. Let it delegate read-only review to `mr_reviewer_agent`.
6. Let it base the review on the final diff from `merge_base...head`, using commit history only as supporting context.
7. If the user wants fixes after the review, start a follow-up implementation flow with `coding_module_agent` and `verifier_agent`.
