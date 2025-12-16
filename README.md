# Overview
A small toolkit of coding rules and workflow helpers that makes your coding agent better.


## Logging and Shared Folder
- All agents write execution notes under `.agent-execution/`, one subfolder per task, so progress and handoffs stay traceable.
- Keep using `AGENTS.md` for Python coding rules; it is the single source of truth for style and standards.

## Prompts and Workflow
- `repo-reader`: scans the repo and produces a detailed project overview (goal, tech stack, tree structure, key files) that other agents can read first.
- `planning-agent`: acts as PM; breaks an incoming task into module-sized steps with brief instructions.
- `coding-module-agent`: implements each planned module exactly as specified by the planning-agent document.
- `repo-updater`: after work completes, refreshes the project overview produced by `repo-reader` to reflect the new state.
- Workflow order: run `repo-reader` → run `planning-agent` → assign each plan item to its own `coding-module-agent` → finish by running `repo-updater`.

## .agent-execution Tree
```
.agent-execution/
├─ project_context.md          # Repo-wide context produced by repo-reader (authoritative snapshot)
└─ {task_name}/                # One folder per task (snake_case from planning-agent)
   ├─ document/                # Planning files (planning-agent ONLY writes here)
   │  ├─ 00_overall_plan.md
   │  ├─ 01_{module}__owner_{agent}.md
   │  └─ 02_{module}__owner_{agent}.md
   ├─ log/                     # Append-only execution logs
   │  ├─ planning_agent/
   │  │  └─ execution_planning_agent.md
   │  ├─ execution__01_{module}__owner_{agent}.md
   │  └─ execution__02_{module}__owner_{agent}.md
   └─ artifacts/               # Optional: test reports, temp outputs (not for plans)
```
- Only `repo-reader` writes `project_context.md`.
- Only `planning-agent` writes inside `document/`.
- Coding agents append their work to `log/execution__{plan_file}.md` derived from their assigned plan filename.
- Keep logs append-only; never overwrite prior entries.
