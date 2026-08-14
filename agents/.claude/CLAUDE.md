# Global agent config

## Agent skills

The agent skill stack (mattpocock skills in `~/.agents/skills`, symlinked per-skill into `~/.claude/skills`) reads its shared config from:

- **Issue tracker**: `~/.agents/issue-tracker.md` — Linear, private team Deep Thought (key `DEEP`), project The Ultimate Question. When the current repo has its own committed `docs/agents/issue-tracker.md`, the repo's file wins.
- **Triage labels**: `~/.agents/triage-labels.md`.
