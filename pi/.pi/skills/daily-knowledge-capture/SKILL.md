---
name: daily-knowledge-capture
description: Summarizes a day of assistant conversations and work into repo docs. Use when turning chat transcripts, session exports, or notes into a concise markdown knowledge note.
---

# Daily Knowledge Capture

Use this skill when the user wants to turn a day’s conversations with the assistant into durable repo docs.

## Goal

Create one concise markdown note per day that captures:
- what was learned
- decisions made
- useful commands/snippets
- follow-ups / open questions
- repo paths touched or worth revisiting

## Workflow

1. Gather the source material for the day.
   - Prefer exported chat/session transcripts.
   - If the user did not provide source material, ask for it.
2. Deduplicate repeated points across conversations.
3. Extract only durable knowledge; skip filler and raw back-and-forth unless it contains useful context.
4. Write a markdown note in the repo’s user namespace folder, following the existing repo convention.
   - Default location: `<user-namespace>/retrospective/daily/YYYY-MM-DD.md`
5. If a note for that date already exists, update it instead of creating a duplicate.
6. Keep the note short and scannable.

## Suggested note format

```markdown
---
date: 2026-06-08
sources:
  - pi session export
  - chat transcript
---

# Daily note — 2026-06-08

## Summary
- ...

## What I learned
- ...

## Decisions
- ...

## Useful snippets / commands
- ...

## Follow-ups
- ...

## Open questions
- ...
```

## Rules

- Prefer markdown over prose dumps.
- Do not paste full transcripts unless explicitly asked.
- Flag uncertainty clearly.
- If the day spans multiple topics, group by theme.
- Preserve repo-specific paths, commands, and names exactly.
- If the user asks for automation next, suggest a small script or scheduler wrapper; this skill itself only performs the summarization and doc creation step.
