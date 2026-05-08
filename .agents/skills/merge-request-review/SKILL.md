---
name: merge-request-review
description: Use when reviewing a GitLab merge request, MR branch, or current branch against a target branch with GitLab MCP, glab, or local git; prioritize bugs, regressions, security, API/data risks, missing tests, and generalized correctness.
---

# Merge Request Review

Review GitLab merge requests in a review-only stance. Do not edit files, merge, approve, post comments, or push changes unless the user explicitly asks.

## Inputs

Gather enough context before review:
- MR identifier, URL, or current branch.
- Target branch, defaulting to the MR target or `main` only when discoverable.
- Review scope: full review, security, tests, API contract, performance, frontend, backend, or re-review since last push.
- Available context: MR description, linked issue, discussions, commits, pipeline/job status, artifacts, and local diff.
- Verification allowance: whether tests, lint, typecheck, build, or local merged-result checks may be run.

If the MR, target branch, or repository cannot be identified from GitLab MCP, `glab`, git remotes, or local branches, ask the user for the missing value.

## Context Sources

Prefer the richest available source:
- GitLab MCP: use for MR metadata, discussions, projects, pipelines, jobs, issues, and comments when tools are available.
- `glab`: use for authenticated GitLab CLI access when MCP tools are unavailable or incomplete.
- Local git: use for source checkout, net diff, file inspection, blame/history when useful, and verification commands.

Use GitLab MCP or `glab` for platform state; use local files and git for code evidence.

## Safe Local Workflow

For a normal review:
1. Identify MR source branch, target branch, title, description, linked issue, and pipeline status.
2. Fetch the target branch and MR/source branch.
3. Inspect the net diff first: `git diff <target>...HEAD`.
4. Inspect commit history second: `git log --oneline <target>..HEAD`.
5. Read changed files and directly related code paths needed to validate behavior.
6. Run agreed verification commands when practical.

For re-review:
- Prefer GitLab MR diff versions or system notes when available.
- Otherwise compare the previously reviewed SHA with the current MR head.
- Review the incremental diff, then re-check the final net diff for integration risk.

For integration-sensitive changes:
- Prefer GitLab merged-result pipeline when available.
- Local fallback is a temporary merge of the MR branch into the target branch, followed by relevant verification.
- Abort the temporary merge after verification and do not leave review artifacts in the worktree.

## Review Priorities

Findings should focus on real risk:
- correctness bugs and behavior regressions
- security, auth, permission, tenant isolation, secrets, and data exposure
- data loss, migrations, persistence, transactional consistency, and rollback risk
- API contract changes, backward compatibility, validation, and error response behavior
- concurrency, async ordering, race conditions, retries, and idempotency
- performance regressions, N+1 queries, unnecessary broad scans, and memory pressure
- missing tests for changed behavior, edge cases, and regression scenarios
- generalized correctness: avoid hardcoded or narrow fixes that only pass the reported sample
- maintainability only when it affects future correctness or reviewability

Do not nitpick style, naming, formatting, or small refactors unless they create a concrete risk or clearly violate repo conventions.

## Generalized Correctness

Treat examples in the MR as symptoms, not the full problem definition.

Reject or flag changes that:
- hardcode one language, locale, status, provider response, ID, date shape, or fixture when the failure class is broader
- add a narrow branch for the reported example instead of fixing the invariant
- update tests only to match implementation details without covering adjacent cases
- silence scanner/test failures without evidence that the underlying risk is removed

Accept bounded generalization:
- identify the failure class behind the report
- encode the invariant in the smallest existing abstraction point
- verify representative cases beyond the literal examples when practical
- avoid speculative frameworks or unrelated rewrites

## Security And Scanner Artifacts

When reviewing GitLab SAST, dependency, secret, container, or code quality artifacts:
- Treat scanners as detection sources, not final judgment.
- Verify file paths, line numbers, reachability, exploitability, and business impact.
- Deduplicate findings that share one root cause.
- Rank findings by practical risk, not only scanner severity.
- Validate any LLM-generated patch as normal code; require `git apply --check` before trusting patch shape.

## Finding Format

Report findings first, ordered by severity. Each finding must include:
- `severity`: `critical`, `high`, `medium`, or `low`
- file and line reference
- concrete issue
- why it can fail in real usage
- suggested fix direction
- test or verification gap when relevant

Use `critical` only for urgent security, data loss, production outage, or irreversible corruption risks.

## Output

Return:
- `status`: `approved` | `changes_requested` | `commented` | `blocked`
- `summary`
- `findings`
- `test_gaps`
- `regression_risks`
- `security_risks`
- `generalization_result`
- `verification_commands_run`
- `blocked_reason`
- `reviewed_refs`: target branch, source/MR branch, MR head SHA when known

If there are no findings, say so clearly and list residual risk or unrun verification.
