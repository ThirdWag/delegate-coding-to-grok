---
name: delegate-coding-to-grok
description: Use when a non-trivial coding task (feature, refactor, multi-file change, non-trivial bugfix) needs implementing and you want to hand the coding to Grok rather than write it yourself. Covers how to spec the delegation and how to evaluate what came back before committing.
---

# Delegate Coding to Grok

## Overview

You (the orchestrator) delegate implementation to Grok, then **evaluate how well it did against the actual diff** before committing. The value is in the evaluation, not the hand-off -- a delegation you don't scrutinize is worse than writing it yourself.

**Core principle: review the diff, never the summary.** Grok's report of what it did is a claim; `git diff` is the evidence. Judge the evidence.

## When to Use

- **Use for:** non-trivial coding -- new features, refactors, multi-file changes, non-trivial bugfixes.
- **Do it yourself instead for:** trivial edits (typos, renames, one-line changes) where delegation overhead exceeds the work.
- **Investigation only (no code change):** call `/grok:rescue --read-only` directly; you don't need this evaluate-loop.

## Workflow

1. **Spec.** One task per delegation. Write tight: files in scope, files off-limits, acceptance criteria, constraints. Vague spec in -> unusable diff out.
2. **Delegate.** `/grok:rescue "<spec>"`. Use `--background` for long tasks. Parallelize independent tasks; serialize only tasks that share files.
3. **Read the actual diff** (`git diff`), not Grok's summary. Check:
   - **Spec match** -- did it do what was asked, all of it?
   - **Scope creep** -- any change or file outside the stated scope?
   - **Seams** -- edge cases where new code meets existing code.
   - **Tests** -- do they assert behavior, or just exist / assert trivially?
   - **Unsupported claims** -- anything Grok says it did that the diff doesn't show.
4. **Run the gates.** Use the repository's documented checks for the affected code: typecheck, lint, tests, build, migration checks, or other project-specific validation. Green before commit -- non-negotiable.
5. **Escalate high-stakes.** Auth, data, money, or migration diffs -> get an independent review (`codex` CLI or `/code-review`) **in parallel with your own**, before committing. Two engines, neither seeing the other's findings first.
6. **Accept or reject.**
   - **Pass** -> commit with explicit `git add <files>`; summarize the task; drop the full diff from working context.
   - **Fail** -> send a **delta spec** back to Grok describing exactly what's wrong. Do **not** fix it yourself.

## Quick Reference

| Situation | Action |
|---|---|
| Non-trivial code change | `/grok:rescue "<spec>"` -> evaluate diff |
| Long task | add `--background` |
| Investigation, no edits | `/grok:rescue --read-only` (skip this loop) |
| Auth / data / money / migration diff | + independent `codex` / `/code-review` in parallel |
| Diff is 90% right | delta spec back to Grok -- don't hand-fix |
| Gates fail | delta spec back; never commit red |

## Red Flags -- You're About to Rubber-Stamp

- Reading Grok's summary instead of running `git diff`.
- "It's basically right, I'll just fix this one line myself." -> that's a delta spec; send it back.
- Committing before typecheck and tests are green.
- Shipping a high-stakes diff on your review alone.
- Accepting new tests without checking they actually assert behavior.

## Common Mistakes

- **Over-broad spec** -- bundling several tasks into one delegation makes the diff hard to evaluate and reject cleanly. One task per call.
- **Trusting the summary** -- the most common failure. The summary can be accurate and the diff still wrong (missed edge case, extra scope). Always read the diff.
- **Hand-fixing** -- patching Grok's near-miss yourself erases the review boundary and hides the gap from Grok's next attempt. Reject with a delta spec.
