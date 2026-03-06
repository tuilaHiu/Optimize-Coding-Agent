---
name: systematic-debugging
description: Use this skill when bug fixes fail repeatedly (looping), the root cause is unclear, or when dealing with complex system integration issues. It enforces a strict 4-phase investigation protocol before allowing any code changes.
lines: 100
---

# Systematic Debugging Protocol

## Core Principle
**NO FIXES WITHOUT ROOT CAUSE EVIDENCE.**
If you are guessing, you are adding bugs.

## Phase 1: Investigation (Read-Only)
Before writing a single line of fix code:
1.  **Reproduce:** Can you make it fail reliably?
    *   *Action:* Create a minimal reproduction script/test case.
2.  **Trace:** Where exactly did the data go wrong?
    *   *Action:* Add LOGGING (print/logger) at boundaries to trace data flow.
3.  **Diff:** What changed recently?
    *   *Action:* Check git history for related files.

## Phase 2: Hypothesis Generation
Formulate a theory:
*   "I believe [Component X] is failing because [Input Y] is invalid."
*   *Verification Logic:* "If this is true, then [Log Z] should show [Value A]."

## Phase 3: Validation (The Trap Check)
*   **Defense-in-Depth:** Don't just fix the symptom. Add a guard clause.
    *   *Bad Fix:* `if x: return x.name`
    *   *Good Fix:* `if not x or not isinstance(x, User): log.error("Invalid user", x); raise ValueError(...)`

## Phase 4: Implementation & Verification
1.  Apply the fix.
2.  **Run the reproduction script** from Phase 1.
3.  **Run regression tests** to ensure no side effects.

## Anti-Patterns (STOP immediately if you do this):
*   "I'll just add a try-except block to silence the error."
*   "I'll increase the timeout and hope it works."
*   "I'll ask the user to try again."

## Output Requirement
When this skill is active, your response MUST start with:
`**DEBUGGING PROTOCOL ACTIVE**`
And strictly follow the 4 phases above in your reasoning.
