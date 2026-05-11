# Decisions

This file records important decisions made during the development of `threebrew`.

Use this for decisions that affect architecture, task structure, dependencies, legal boundaries, build strategy, or long-term maintainability.

Do not use this file for raw logs or small implementation notes.

## Status legend

| Status | Meaning |
|---|---|
| PROPOSED | Under consideration |
| ACCEPTED | Current project direction |
| SUPERSEDED | Replaced by a later decision |
| REJECTED | Considered but not adopted |

## Index

| ID | Title | Status | Date | Related tasks |
|---|---|---|---|---|
| DEC-0001 | Separate product docs from AI task management | ACCEPTED |  | all |

---

# DEC-0001: Separate product docs from AI task management

## Status

ACCEPTED

## Context

The project needs both stable product/system documentation and volatile AI task state.

Mixing these in `docs/` would make Gemini CLI read too much task noise when it only needs system requirements.

## Decision

Use:

- `docs/` for emulator/system documentation
- `tasks/` for AI task management
- `.gemini/` for Gemini CLI configuration, agents, commands, and hooks

## Consequences

Positive:

- Product documentation remains clean.
- Worker task state is isolated.
- Supervisor can read task state without polluting product docs.
- Gemini CLI sessions can preserve long-running state without relying on chat history.

Negative:

- References must consistently point to `tasks/task-board.md`.
- Existing Codex-oriented docs may need to be updated for Gemini CLI terminology.
- Workers must follow ownership rules to avoid merge conflicts in task-state files.

## Related tasks

- all
