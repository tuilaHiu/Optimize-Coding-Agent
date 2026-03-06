---
name: problem-solving
description: Apply this skill when stuck in complex technical decisions, facing circular logic, or when a solution feels over-complicated. It provides mental models like Inversion, Scale Testing, and Simplification Cascades to find elegant solutions.
---

# Problem-Solving Techniques

Use these mental models when a task feels "stuck," "too complex," or "circular."

## 1. Inversion Exercise (The "Flip")
Instead of asking "How do I make this work?", ask:
- **"What would make this system fail guaranteed?"**
- **"What is the most fragile part of my current proposal?"**
*Purpose: Identify hidden dependencies and risks before they become bugs.*

## 2. Scale Game (Stress Test)
Take your current solution and imagine it at extremes:
- **1000x Scale:** "What if we have 1M requests per second instead of 10?"
- **Zero Scale:** "Is this component even needed for a single user?"
- **Instant vs. Year:** "What if this job takes 1ms? What if it takes 24 hours?"
*Purpose: Expose architectural flaws that are invisible at normal scale.*

## 3. Simplification Cascades
Find one core insight that eliminates multiple components.
- **Rule of 3:** If you see the same logic in 3 places, find the single abstraction.
- **The "Delete" First:** "If I delete this module, what is the *minimal* thing that actually breaks?"
*Purpose: Honor the KISS principle by removing code instead of adding special cases.*

## 4. First Principles Thinking
Break the problem down to its basic truths.
- Stop saying "We usually do it this way."
- Ask "What are the fundamental constraints (Memory, Network, CPU, Logic) that actually matter here?"

## Skill Trigger Requirement
When this skill is active, you MUST analyze the current problem using at least ONE of the mental models above before proceeding with a plan or implementation. Mention the chosen model in your reasoning.
