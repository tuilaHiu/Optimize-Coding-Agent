---
name: systematic-debugging
description: Use when a bug is unclear, repeated fixes failed, reproduction is needed, or a complex integration issue requires root-cause evidence before code changes.
---

# Systematic Debugging Protocol

## Core Principle

No fixes without root-cause evidence. If the cause is unknown, investigate before changing code.

## Phase 1: Investigation

Before fix code:
- Reproduce the failure with the smallest practical command, test, or script.
- Trace where data or control flow first goes wrong.
- Check recent diffs or nearby history when useful.

## Phase 2: Hypothesis

State a testable theory:
- "I believe component X fails because input Y is invalid."
- "If true, evidence Z should show value A."

## Phase 3: Validation

Validate the theory before patching. Prefer fixes that address the cause, not only the symptom. Add guards where invalid states can cross a boundary.

## Phase 4: Implementation And Verification

1. Apply the smallest fix that addresses the root cause.
2. Re-run the reproduction.
3. Run relevant regression tests or checks.

## Anti-Patterns

Stop and investigate if the proposed fix is only:
- silencing the error
- increasing a timeout without evidence
- asking the user to retry without a local theory

## Output

When this skill is active, summarize the four phases and the evidence that supported the fix.
