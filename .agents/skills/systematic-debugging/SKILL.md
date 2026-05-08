---
name: systematic-debugging
description: Use when a bug is unclear, repeated fixes failed, reproduction is needed, or a complex integration issue requires root-cause evidence before code changes.
---

# Systematic Debugging Protocol

## Core Principle

No fixes without root-cause evidence. If the cause is unknown, investigate before changing code.

Debug the failure class, not only the reported sample. Treat concrete examples as entry points for discovering the invariant that broke.

## Phase 1: Investigation

Before fix code:
- Reproduce the failure with the smallest practical command, test, or script.
- Trace where data or control flow first goes wrong.
- Check recent diffs or nearby history when useful.
- Classify whether the failure is input-shape, locale/language, encoding, provider behavior, timing, permission, state, or contract drift.
- Look for neighboring examples that should follow the same invariant, including cases not named in the report.

## Phase 2: Hypothesis

State a testable theory:
- "I believe component X fails because input Y is invalid."
- "If true, evidence Z should show value A."
- Include the general rule: "This should work for all inputs with property P, not only examples A and B."

## Phase 3: Validation

Validate the theory before patching. Prefer fixes that address the cause, not only the symptom. Add guards where invalid states can cross a boundary.

Validate against representative cases from the broader class. For example, if Chinese and Korean fail because language detection/parsing assumes Latin text, also test another non-Latin or locale variant where practical.

## Phase 4: Implementation And Verification

1. Apply the smallest fix that addresses the root cause.
2. Re-run the reproduction.
3. Run relevant regression tests or checks for both the reported sample and adjacent cases in the same failure class.

## Anti-Patterns

Stop and investigate if the proposed fix is only:
- silencing the error
- increasing a timeout without evidence
- asking the user to retry without a local theory
- hardcoding the reported examples instead of fixing the violated invariant
- adding a narrow branch for one language, provider, or fixture when the same bug can appear for equivalent inputs

## Output

When this skill is active, summarize the four phases, the generalized failure class, and the evidence that supported the fix.
