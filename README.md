# Optimize Coding Agent

Skill-first Codex workflow kit for coding agents.

## Coding Workflow v3

Workflow v3 builds on v2 and makes the runtime more native to Codex:

- Moves the runtime source of truth from prompt files to repo-scoped skills in `.agents/skills/`.
- Adds project custom agents in `.codex/agents/` for helper roles such as implementation, verification, API reading, and repo context updates.
- Keeps one main user-facing workflow: `$codex-coding-workflow`.
- Keeps context focused with two task profiles:
  - `general_task` uses `.project_context.md`
  - `api_focus_task` uses `.api_context/{api_slug}.md`
- Adds stricter guardrails for assumptions, simplicity, surgical diffs, and verification.

## Karpathy-Inspired Rules

v3 applies the coding-agent guidelines from [`forrestchang/andrej-karpathy-skills`](https://github.com/forrestchang/andrej-karpathy-skills) by embedding the four principles into `AGENTS.md`, `$codex-coding-workflow`, `$bounded-implementation`, and `$verification-gate`.

- **Think Before Coding:** state assumptions, ambiguity, and tradeoffs before implementation.
- **Simplicity First:** choose the minimum implementation that satisfies the success criteria.
- **Surgical Changes:** every changed line should trace to the user's request; no drive-by cleanup.
- **Goal-Driven Execution:** convert vague requests into explicit acceptance criteria and verification steps.

The verifier also checks for overengineering, speculative behavior, unrelated edits, broad diffs, and missing tests before a task is treated as complete.

## Runtime Layout

- `.agents/skills/`: Codex skills and workflow rules. This is the runtime source of truth.
- `.codex/agents/`: custom helper agents with role, model, and reasoning defaults.
- `codex/`: compatibility notes and support docs.
- `gemini/`: separate Gemini material kept unchanged.

Main skills:

- `$codex-coding-workflow`: orchestrates coding tasks.
- `$repo-context`: creates or refreshes `.project_context.md`.
- `$api-dossier`: creates or refreshes `.api_context/{api_slug}.md`.
- `$bounded-implementation`: implements one bounded scope.
- `$verification-gate`: verifies implementation, review output, and context refresh needs.
- `$context-maintenance`: updates `.project_context.md` after verified changes.
- `$coding-python`: Python-specific coding rules.

Main custom agents:

- `coding_module`: implementation worker, currently configured for `gpt-5.5`.
- `verifier`: review/verification worker, currently configured for `gpt-5.5`.
- `repo_reader`, `api_reader`, `repo_updater`: focused context helpers, currently configured for `gpt-5.4-mini`.

## Install

### Option A: Use In This Repo

No copy step is needed when you run Codex from this repository. The repo already contains:

- `.agents/skills/`
- `.codex/agents/`
- `codex/AGENTS.md`

Start Codex in the repo root and invoke `$codex-coding-workflow` for non-trivial coding tasks.

### Option B: Install Into Another Repo

Copy the workflow files into the target repository root:

```bash
cp -R .agents /path/to/target-repo/
mkdir -p /path/to/target-repo/.codex
cp -R .codex/agents /path/to/target-repo/.codex/
mkdir -p /path/to/target-repo/codex
cp codex/AGENTS.md /path/to/target-repo/codex/AGENTS.md
```

Then open Codex from `/path/to/target-repo` and use `$codex-coding-workflow`.

### Option C: Install Globally

Copy selected skills and custom agents into your home config:

```bash
mkdir -p "$HOME/.agents/skills" "$HOME/.codex/agents"
cp -R .agents/skills/* "$HOME/.agents/skills/"
cp .codex/agents/*.toml "$HOME/.codex/agents/"
```

Use global install when you want the workflow available across many repositories. Keep project-specific rules in each repo's `AGENTS.md` or `codex/AGENTS.md`.

## How To Use

For non-trivial coding work, invoke the main workflow:

```md
$codex-coding-workflow

<your task>
```

The workflow will:

1. clarify goal, assumptions, constraints, and success criteria
2. classify the task as `general_task` or `api_focus_task`
3. load or refresh the right context artifact
4. plan the minimum safe implementation
5. implement directly or delegate to `coding_module`
6. verify with `$verification-gate` or `verifier`
7. refresh context docs after verified changes

Small, obvious edits can be handled directly without the full workflow.

## Example: Python Coding Task

```md
$codex-coding-workflow

Implement Python validation for uploaded invoice files.

Success criteria:
- reject unsupported file extensions
- reject files larger than the existing configured limit
- preserve the current API response shape
- add or update tests for valid and invalid inputs
- keep the diff scoped to the upload validation path
```

Expected behavior:

- `$codex-coding-workflow` classifies the task.
- `$repo-context` or `$api-dossier` is used only if context is missing or stale.
- `$coding-python` guides Python style, typing, tests, and dependency handling.
- `$bounded-implementation` or `coding_module` implements the bounded change.
- `$verification-gate` checks tests, scope, simplicity, surgical changes, and regression risk.

## Example: Merge Request Review

```md
$codex-coding-workflow

Review the current branch against `main`.

Requirements:
- review only, do not edit files
- inspect `main...HEAD`
- prioritize bugs, regressions, security issues, data loss, and missing tests
- report findings first with severity and file/line references
- if there are no findings, say so and list residual risk or test gaps
```

Expected behavior:

- The workflow treats this as review-only and does not use `$bounded-implementation`.
- `verifier` or `$verification-gate` inspects changed files, acceptance criteria, tests, and regression risk.
- Output starts with findings, ordered by severity.
- Context files are not updated unless a later verified implementation changes repo behavior.

## Personal Reuse

For shared personal defaults, use the global install. For team or project-specific behavior, prefer committing `.agents/skills/`, `.codex/agents/`, and `codex/AGENTS.md` in the project repository.
