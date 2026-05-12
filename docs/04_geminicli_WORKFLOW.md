# 04 — Codex workflow

## How Codex should work

Codex should treat this as a long-running engineering project. Do not attempt to implement the whole emulator in one task.

For every task:

1. Read `AGENTS.md`.
2. Read the relevant docs.
3. Create a concise plan.
4. Implement a minimal slice.
5. Add tests.
6. Run available commands.
7. Update docs if needed.
8. Report limitations.

## Task sizing

A good Codex task should fit one of these patterns:

- add one module skeleton
- implement one small CPU instruction family
- add one parser and tests
- add one service command and tests
- add one frontend input behavior
- improve one error message family
- add one documentation page

Bad task:

- "implement GPU"
- "make commercial games playable"
- "finish emulator"
- "copy Citra"
- "support all services"

## Required final response format

After each task, Codex should respond with:

```text
Summary:
- ...

Files changed:
- ...

Tests run:
- ...

Known limitations:
- ...

Next recommended task:
- ...
```

## Planning standard

For difficult tasks, Codex should write a plan first, then implement. Plans should include:

- affected modules
- new files
- tests
- assumptions
- non-goals

## Prohibited shortcuts

- no proprietary assets
- no ROM/key instructions
- no silent stubs
- no title-specific hacks unless explicitly approved
- no huge vendor drops
- no unlicensed code copying
- no "works on my machine" claims without commands

## Documentation updates

Whenever Codex changes architecture or behavior, update one of:

- `docs/02_ARCHITECTURE.md`
- `docs/03_ROADMAP.md`
- `docs/05_BUILD_AND_TEST.md`
- `docs/DEPENDENCIES.md`
- `tasks/task-board.md`

## Compatibility notes

When any software is tested, record:

```text
Software name:
Type: homebrew / synthetic / decrypted user-provided content
Commit/version:
Status:
Last tested:
Host hardware:
Relevant logs:
Known issues:
```
