---
name: coding-fe
description: Use when implementing or updating frontend code and needing TypeScript, component, state, styling, responsiveness, accessibility, and browser verification rules.
---

# Frontend Coding Rules

Use this skill when writing or modifying frontend code.

## TypeScript And Components

- Use strict types; avoid `any`.
- Define component props and API response types explicitly.
- Keep components modular. Split large files when a component becomes hard to scan.
- Separate data fetching/state logic from UI rendering with hooks, composables, or existing repo patterns.
- Follow repo naming conventions first; otherwise use `PascalCase` for components and `camelCase` for hooks/utils.

## Styling And UX

- Use the repo's configured styling system.
- Avoid inline styles unless values are genuinely dynamic.
- Build responsive layouts for mobile, tablet, and desktop.
- Define loading, error, and success states for async UI.
- Provide hover, focus, disabled, and keyboard-accessible states for interactive controls.
- Do not expose raw backend traces to users.

## Performance

- Debounce high-frequency search or input events when they trigger API calls.
- Memoize expensive render paths when needed, following repo conventions.

## Verification

After UI changes, verify with the best available Codex-compatible loop:
- run the relevant build, lint, typecheck, or component tests
- start the local dev server when needed
- use browser automation or screenshots when available to confirm layout and interaction states
- report clearly when visual/browser verification could not be run

## Output Expectations

Summarize:
- files changed
- UI states covered
- responsive/browser checks run
- remaining verification gaps, if any
