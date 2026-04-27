---
name: repo-context
description: Use when creating, refreshing, or consulting the repository-wide context file .project_context.md for broad coding, architecture, setup, or workflow tasks.
---

# Repo Context

Create or refresh `.project_context.md` as the repo-wide working context.

## Inputs

Use the provided task contract when available:
- `task_profile`
- `task_goal`
- `scope_boundaries`
- `primary_context_file`
- `allowed_files`
- `acceptance_criteria`
- `verification_steps`
- `expected_output`

## Workflow

1. Identify the tech stack from project files.
2. Identify dependency management, runtime, linting, formatting, type checking, testing, CI/CD, migrations, env config, and task runners.
3. Map the directory structure and key folders.
4. Trace entrypoints and core request/data flow.
5. Create or refresh `.project_context.md`.
6. Return a concise structured summary to the orchestrating thread.

## Constraints

- Modify only `.project_context.md`.
- Do not create task folders.
- Prefer targeted analysis over unnecessary repo-wide detail.

## `.project_context.md` Structure

```md
# Project Context Documentation

## 1. Project Overview
- Purpose:
- Primary users:
- Main features:

## 2. Tech Stack
- Language:
- Framework:
- Database:
- Key libraries:

## 3. Repo Toolchain
- Dependency manager:
- Runtime / containerization:
- Linting and formatting:
- Type checking:
- Testing:
- CI/CD:
- DB migrations:
- Task runner:
- Env config:

## 4. Directory Structure
- Tree depth 3-4
- Key folders explained

## 5. Architecture and Data Flow
- High-level text diagram
- Request/data flow steps
- Key modules

## 6. How to Run and Test
- Local run commands
- Test commands

## 7. Recent Changes
- Summary of files changed since last update
```

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
