---
name: coding-python
description: Use when a coding worker is implementing or updating Python code and needs compact repo-first rules for code quality, testing, dependency changes, and self-review.
---

# Python Coding Rules

Use this skill when a worker is writing or modifying Python code.

This skill only defines Python implementation rules. Workflow V2 orchestration, delegation, context selection, and logging are handled by the runtime prompts such as `coding-module-agent` and `main_orchestrator`.

## Working Boundaries
- Treat this skill as the Python coding rules source for the task.
- Do not pull legacy execution or logging rules from older workflow versions.
- Stay inside the scope and allowed files provided by the worker prompt.
- Read the relevant files before editing so the change matches repo patterns.

## Core Rules

### 1. Repo First
- Follow the repo's existing structure, naming, typing, test style, and dependency conventions.
- Match the repo's formatter and linter setup before applying generic Python preferences.
- Prefer the existing project pattern over introducing a new abstraction style.

### 2. Python Style
- Use `snake_case` for functions and variables, `PascalCase` for classes, and `UPPER_CASE` for constants.
- Keep imports grouped as standard library, third-party, then local modules.
- Prefer small, explicit functions over dense logic blocks.

### 3. Typing And Documentation
- Add type hints to new or changed function arguments and return values.
- Follow the repo's existing docstring style.
- If the repo has no clear docstring convention, add docstrings only where behavior is public or non-obvious.

### 4. Errors And Safety
- Catch specific exceptions when recovery is intentional.
- Avoid bare `except:` except at a top-level boundary where the repo already expects it.
- Never hardcode secrets, tokens, or credentials.
- Use the repo's existing environment/config pattern for settings.

### 5. Data And Persistence
- Use parameterized queries instead of string-built SQL.
- If a schema change is required, add the matching migration or migration script using the repo's existing convention.
- Avoid broad or wasteful data access patterns when a narrower query is sufficient.

### 6. Tests
- If behavior changes, add or update tests.
- Prefer the closest existing test style and test location in the repo.
- If you cannot run tests, say so explicitly in the result summary.

### 7. Dependencies
- Use the repo's existing dependency manager and lock-file flow.
- If `uv.lock` exists, prefer `uv`.
- If `poetry.lock` exists, prefer `poetry`.
- If neither exists, follow the repo's actual dependency convention instead of inventing one.
- Explain any new dependency briefly in the worker output.

## Worker Self-Check
Before completing a Python implementation task, verify:
- the change stays inside the assigned scope
- the code matches existing repo patterns
- edge cases and failure paths are handled
- tests or verification steps were run when possible
- the final result can be summarized cleanly for `main_orchestrator`

## What This Skill Does Not Own
- planning the task
- deciding whether the task is `general_task` or `api_focus_task`
- choosing which context artifact to load
- execution logging format
- subagent spawning or model selection

Those concerns belong to the runtime prompts, not this skill.
