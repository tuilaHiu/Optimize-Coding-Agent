---
name: coding-python
description: Use when implementing or updating Python code and needing repo-first rules for code quality, typing, testing, dependency changes, and self-review.
---

# Python Coding Rules

Use this skill when writing or modifying Python code.

Workflow orchestration, context selection, delegation, and verification are owned by workflow skills and custom agents such as `$codex-coding-workflow`, `$bounded-implementation`, and `$verification-gate`.

## Working Boundaries

- Stay inside the assigned scope and allowed files.
- Read relevant files before editing so the change matches repo patterns.
- Prefer existing project conventions over generic Python preferences.

## Core Rules

### Repo First
- Follow the repo's structure, naming, typing, test style, and dependency conventions.
- Match the repo formatter and linter setup.
- Add abstractions only when they remove real complexity or match an established pattern.

### Python Style
- Use `snake_case` for functions and variables, `PascalCase` for classes, and `UPPER_CASE` for constants.
- Group imports as standard library, third-party, then local modules.
- Prefer small, explicit functions over dense logic blocks.

### Typing And Documentation
- Add type hints to new or changed function arguments and return values.
- Follow the repo's docstring style.
- If no clear style exists, add docstrings only for public or non-obvious behavior.

### Errors And Safety
- Catch specific exceptions when recovery is intentional.
- Avoid bare `except:` except at repo-established top-level boundaries.
- Never hardcode secrets, tokens, or credentials.
- Use the repo's existing environment/config pattern.

### Generalized Correctness
- Treat reported examples as symptoms of a broader failure class, not as the full problem definition.
- Avoid hardcoded fixes for one language, provider response, ID, status string, timestamp shape, or test fixture unless the business rule is explicitly that narrow.
- Prefer data-driven parsing, standards-aware libraries, normalized inputs, capability checks, or existing locale/config abstractions over enumerating only the currently failing cases.
- When fixing behavior reported for a few cases, identify the invariant that should hold for all equivalent cases and implement against that invariant.
- Keep the generalization bounded to the proven failure class; do not introduce speculative frameworks, broad rewrites, or unrelated configurability.

### Data And Persistence
- Use parameterized queries instead of string-built SQL.
- If a schema change is required, add the matching migration using repo conventions.
- Avoid broad data access when a narrower query is sufficient.

### Tests And Dependencies
- Add or update tests when behavior changes.
- Prefer the closest existing test style and location.
- If tests cannot run, say so explicitly.
- Use the repo's dependency manager and lock-file flow.
- Explain any new dependency in the worker output.

## Self-Check

Before completion, verify:
- scope and allowed files were respected
- code matches repo patterns
- the fix handles the broader failure class behind the reported examples
- no new hardcoded special cases were added unless they are explicit product rules
- edge cases and failure paths are handled
- tests or verification steps were run when possible
- final output is easy for the orchestrating thread to synthesize
