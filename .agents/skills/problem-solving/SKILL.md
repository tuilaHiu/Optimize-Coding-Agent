---
name: problem-solving
description: Use when a technical decision feels stuck, circular, over-complicated, or architecturally risky and needs a structured mental model before planning or implementation.
---

# Problem-Solving Techniques

Use at least one model before planning or implementation.

## Inversion

Ask:
- What would make this system fail?
- What is the most fragile part of the current proposal?

Use this to expose hidden dependencies and risks.

## Scale Test

Stress the proposal:
- What changes at 1000x scale?
- What remains necessary at zero or one user?
- What if this takes 1 ms? What if it takes 24 hours?

Use this to reveal architectural flaws.

## Simplification Cascade

Look for one simplification that removes multiple moving parts:
- If logic appears in three places, find the right single abstraction.
- If a module is deleted, identify the smallest thing that actually breaks.

Use this to avoid unnecessary design.

## First Principles

Break the problem into constraints:
- memory
- network
- CPU
- data shape
- correctness
- operational risk

Then choose the simplest approach that satisfies those constraints.
