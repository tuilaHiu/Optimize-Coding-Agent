---
name: api-dossier
description: Use when creating or refreshing a focused .api_context/{api_slug}.md dossier for one API, endpoint, route group, request/response contract, validation path, handler, service flow, or API-specific tests.
---

# API Dossier

Create or refresh one focused API context file: `.api_context/{api_slug}.md`.

Use `snake_case` for `api_slug` and reuse the same file for follow-up work on the same API.

The dossier is working context for humans and agents. Optimize for fast reading: concise prose, tables, workflow diagrams, and stable section order.

## Modes

- `capture`: create a dossier when it is missing or too incomplete to use.
- `refresh`: update an existing dossier after implementation has been verified.

## Scope

Inspect only what is needed for the target API:
- routes
- controller or handler
- service layer
- schemas, DTOs, serializers, validators
- auth and permission checks
- API-specific tests
- external integrations used by the API

Avoid full repo scans unless the API cannot be traced otherwise.

## Human-Readable Format

Use this style:
- Start with a short "At a glance" summary.
- Prefer tables for routes, files, contracts, dependencies, risks, and verification.
- Include a Mermaid `flowchart TD` for the happy-path request flow when the API has more than one meaningful step.
- Keep paragraphs short. Avoid dumping raw code, long schemas, or full stack traces.
- Use `Unknown` instead of guessing when a field cannot be verified.
- Put detailed notes after the quick reference sections, not before them.

## Required Sections

The API dossier must contain:
- At a Glance
- API Identity
- Endpoint Map
- Workflow
- Relevant Files
- Request Contract
- Response Contract
- Auth and Permissions
- Dependencies and External Services
- Known Constraints and Risks
- Verification Commands
- Open Improvement Opportunities
- Decision Log
- Last Verified

Use `references/api_context_template.md` when a full template is useful.

## Cross-Cutting Detection

Set `cross_cutting_impact = true` when the API work affects:
- shared auth or permission flow
- shared middleware, interceptors, or global error handling
- shared schema, model, or base DTO used beyond the target API
- shared service or utility used by multiple APIs
- repo-level config, env setup, dependencies, or run/test workflow
- architecture or module boundaries that matter outside the target API

Set `cross_cutting_impact = false` for endpoint-local handler, service, validation, response, or test changes.

## Output

Return:
- `status`
- `summary`
- `artifacts`
- `changed_files`
- `verification_result`
- `blockers`
- `follow_up_actions`
- `api_slug`
- `context_file`
- `cross_cutting_impact`
