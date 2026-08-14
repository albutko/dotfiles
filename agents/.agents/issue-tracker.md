# Issue tracker: Linear (Deep Thought)

Issues filed by the agent skill stack live in Linear, workspace `sema4ai` (https://linear.app/sema4ai).
All operations go through the Linear MCP server (tool names below; on Claude Code they appear as `mcp__claude_ai_Linear__<name>` and may need ToolSearch to load their schemas).

Targets:

- Team: **Deep Thought** (key `DEEP`, private)
- Project: **The Ultimate Question** — https://linear.app/sema4ai/project/the-ultimate-question-3d7789b58146

Deep Thought is for skill-filed work only: wayfinder maps and their decision tickets, `/to-tickets` output, `/triage` queues.
Product work stays in the owning product teams (EPD, ENG, etc.); do not file product tickets to Deep Thought, and do not move `DEEP` tickets into product teams without being asked.

## Per-machine prerequisites

Sharing this file does not share access.
Each machine needs the Linear connector enabled for the claude.ai account (or equivalent Linear MCP access for other runtimes: https://mcp.linear.app).
No secrets belong in this file.
The Linear MCP connector cannot create or edit teams; team-level changes happen in the Linear UI.

## Conventions

- **Create**: `save_issue` with `team: "Deep Thought"`, `project: "The Ultimate Question"`, `title`, and a Markdown `description`.
- **Read**: `get_issue` with the identifier (`DEEP-12`) or URL; pass `includeRelations: true` when blocking matters.
- **List**: `list_issues` with `team`/`project` plus `label`, `parentId`, `assignee` (`"me"`, or `"null"` for unassigned), `state`, and `query` filters as needed.
- **Comment**: `save_comment` with `issueId`.
- **Label**: the `labels` array on `save_issue` **replaces the full set** — read the current labels first and resend them plus the change.
- **Close**: `save_issue` with `state: "Done"`; use `state: "Canceled"` for wontfix and out-of-scope closures.
- In anything a human reads, refer to issues by title with the URL linked; bare identifiers are for code, commits, and tool calls.

## When a skill says "publish to the issue tracker"

Create one issue per ticket with `save_issue` in dependency order (blockers first) so blocking edges can reference real identifiers, wiring edges with `blockedBy`.
Apply the `ready-for-agent` label unless instructed otherwise.

## When a skill says "fetch the relevant ticket"

`get_issue` with the identifier or linear.app URL found in the commit message, TODO comment, or branch name.

## Triage labels

The five canonical triage labels exist in the Deep Thought team under their canonical names; see `triage-labels.md` next to this file.

## Wayfinding operations

Used by `/wayfinder`. The **map** is a single issue with **child** (sub-)issues as tickets, all in Deep Thought / The Ultimate Question.

- **Map**: an issue labelled `wayfinder:map` holding the Destination / Notes / Decisions so far / Not yet specified / Out of scope body. Edit the body with `save_issue` + `patch` (anchored partial edits) rather than resending the whole description.
- **Child ticket**: `save_issue` with `parentId: <map id>` and exactly one `wayfinder:<type>` label (`research`/`prototype`/`grilling`/`task`). Once claimed, the ticket is assigned to the driving dev.
- **Blocking**: Linear's native relations — `save_issue` with `blockedBy: ["DEEP-x", ...]` (append-only; `removeBlockedBy` unwires). Read edges with `get_issue` + `includeRelations: true`. A ticket is unblocked when every blocker is closed. Never use a body-text convention; the native relation is what renders the frontier in the UI.
- **Frontier query**: `list_issues` with `parentId: <map id>` and `fields: ["title", "statusType", "assigneeId", "labels", "url", "createdAt"]`; keep issues whose `statusType` is neither `completed` nor `canceled` and that have no assignee, then check each survivor with `get_issue` + `includeRelations: true` and drop any with an open blocker. Order by `createdAt` ascending — first created wins.
- **Claim**: `save_issue` with `id: <ticket>` and `assignee: "me"` — the session's first write.
- **Resolve**: `save_comment` on the ticket with the answer, `save_issue` to `state: "Done"`, then append the context pointer (title + link + one-line gist) to the map's Decisions-so-far via `save_issue` + `patch`.
