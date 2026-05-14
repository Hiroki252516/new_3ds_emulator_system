# GEMINI.md — Gemini CLI operating instructions for threebrew

## Role

You are Gemini CLI working on `threebrew`, a long-running Nintendo 3DS emulator project for macOS Apple Silicon.

You do not know prior chat history. Treat these files as the source of truth:

1. `AGENTS.md`
2. `docs/00_PROJECT_BRIEF.md`
3. `docs/01_LEGAL_AND_LICENSE_BOUNDARIES.md`
4. `docs/02_ARCHITECTURE.md`
5. `docs/03_ROADMAP.md`
6. `docs/04_CODEX_WORKFLOW.md`
7. `docs/05_BUILD_AND_TEST.md`
8. `docs/06_RESEARCH_MAP.md`
9. `docs/07_MAC_PLAYBACK_REQUIREMENTS.md`
10. `docs/08_IMPLEMENTATION_SPEC.md`
11. `docs/09_COMPATIBILITY_POLICY.md`
12. `docs/DEPENDENCIES.md`
13. `tasks/task-board.md`
14. `tasks/architecture/DECISIONS.md`
15. the current task state file under `tasks/agent-state/`

If any of these documents conflict, follow this priority order:

1. legal and license boundaries
2. human instruction in the current session
3. `GEMINI.md`
4. `AGENTS.md`
5. project docs under `docs/`
6. task state under `tasks/`

## Project summary

`threebrew` is a clean-room-ish, educational, general-purpose Nintendo 3DS emulator for macOS Apple Silicon.

Primary target:

- MacBook Air M4
- 24GB unified memory
- current macOS on Apple Silicon
- direct Mac play
- keyboard + mouse/trackpad first
- optional standard HID/gamepad support later
- no iPhone-as-controller requirement

The first milestone is not commercial game compatibility. The first milestone is a reproducible local emulator skeleton that builds on Apple Silicon macOS, opens a desktop window, displays upper/lower screen regions, accepts keyboard and mouse/touch input, has structured logging, and passes deterministic CPU/memory tests.

## Non-negotiable legal boundaries

Never add, request, document, automate, or facilitate:

- ROM downloading
- links to ROM sites
- Nintendo keys
- boot ROMs
- BIOS or firmware blobs
- copyrighted Nintendo assets
- DRM circumvention instructions
- cartridge dumping instructions
- encrypted game loading as an early feature
- code that assumes bundled proprietary Nintendo files

Allowed development inputs:

- self-authored unit tests
- synthetic fixtures
- public-domain or permissively licensed test data
- homebrew built from source
- user-provided, lawfully obtained, already-decrypted CCI/NCCH files only after the loader architecture exists

If any task appears to require proprietary files, keys, firmware, BIOS, copyrighted assets, dumping guidance, or DRM circumvention, stop and ask the human.

## Reference policy

You may study public documentation and open-source emulator architecture for learning, but do not copy implementation code unless the task explicitly authorizes vendoring/forking and the license impact is documented.

Reference projects are for understanding only:

- Azahar / Citra-family projects
- Panda3DS
- 3dbrew
- devkitPro / libctru / citro2d / citro3d
- homebrew examples with compatible licenses

When using public reference material, summarize concepts in your own words and implement independently.

## Engineering priorities

1. Correctness and debuggability before speed.
2. Tests before compatibility hacks.
3. Homebrew before commercial software.
4. Generic 3DS infrastructure before title-specific fixes.
5. Structured logs for unsupported CPU instructions, SVCs, IPC commands, services, FS operations, GPU commands, and audio commands.
6. Deterministic tests and deterministic errors.
7. Clear module boundaries between emulator core and macOS frontend.
8. Internal graphics IR before binding too tightly to Metal.
9. Never silently ignore unsupported behavior.

## Expected repository layout

Product/system documentation lives under:

- `docs/`

AI task management lives under:

- `tasks/task-board.md`
- `tasks/agent-state/`
- `tasks/architecture/DECISIONS.md`

Gemini CLI behavior lives under:

- `.gemini/settings.json`
- `.gemini/agents/`
- `.gemini/commands/`
- `.gemini/hooks/`

Raw logs live under:

- `.agent-logs/<task-id>/`

Do not paste raw logs into `docs/`, `tasks/`, or the chat context.

## Task workflow

For every task:

1. Read the relevant docs and `tasks/task-board.md`.
2. Identify the task ID.
3. Read or create `tasks/agent-state/TASK-xxx.WORKING_STATE.md`.
4. Make a concise plan before editing.
5. Make the smallest coherent change.
6. Add or update tests.
7. Run the narrowest relevant build/test command.
8. Save full logs under `.agent-logs/<task-id>/`.
9. Put only summaries and log paths in `WORKING_STATE.md`.
10. Update product docs if behavior or architecture changed.
11. Use `/checkpoint` before compression, before commit, and after tests.
12. Use `/handoff` when ready for supervisor review.

Before marking a task `REVIEW_READY` or `DONE`, check `tasks/task-board.md` for the Global Definition of Done and `REVIEW_READY` Criteria.

## Worktree and worker rules

When running in a task worktree:

- Edit only paths allowed by the task board and state file.
- Do not edit `tasks/task-board.md` unless explicitly acting as supervisor.
- Do not edit another worker's `WORKING_STATE.md`.
- Do not modify shared schemas, public APIs, build configuration, dependency lists, or lockfiles unless assigned by the task.
- Keep commits small and coherent.
- If a shared file must be changed, record the reason in the task state and ask the supervisor if the change is outside scope.

## Context hygiene

Do not paste full logs into the conversation or docs.

Use bounded command patterns:

```bash
cmake --build build 2>&1 | tee .agent-logs/<task-id>/build.log | tail -200
ctest --test-dir build --output-on-failure 2>&1 | tee .agent-logs/<task-id>/ctest.log | tail -200
```

Prefer:

- `rg` over broad `grep`
- `git diff --stat`
- `git diff --name-only`
- targeted file reads
- narrow tests before full tests
- summaries plus raw log paths

Avoid:

- `cat` on large files
- unbounded recursive grep
- full test logs in context
- reading unrelated directories
- broad `@docs/` or `@src/` injections unless truly needed

## Documentation ownership

- `docs/` contains product/system documentation.
- `tasks/task-board.md` is the supervisor task board.
- `tasks/agent-state/TASK-xxx.WORKING_STATE.md` is the worker state file.
- `tasks/architecture/DECISIONS.md` records task-relevant architecture and workflow decisions.
- Raw logs go under `.agent-logs/`, not under `docs/` or `tasks/`.

## Dependency policy

Before adding any dependency:

1. identify exact dependency and version
2. identify license
3. explain why it is needed
4. state whether it is build-time, test-time, or runtime
5. state whether it is linked, vendored, or used as a tool
6. update `docs/DEPENDENCIES.md`

If license impact is unclear, stop and ask the human.

## Build and test policy

Prefer the commands documented in `docs/05_BUILD_AND_TEST.md`.

If a build system does not yet exist, create the minimum CMake/Ninja skeleton needed for the current task. Do not introduce a large framework unless explicitly required.

Test strategy:

- CPU and memory behavior should be deterministic.
- Unsupported instructions/services should produce structured logs.
- Early tests should use synthetic fixtures and homebrew-safe artifacts.
- Do not add tests that depend on Nintendo proprietary files.

## Final response format

At the end of a task, respond with:

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
## Branch, PR, and merge policy

Each implementation task must run in its own task branch/worktree.

Branch naming:

- `TASK-xxx-short-name`

Rules:

- Do not work directly on `main`.
- Do not commit directly to `main`.
- Do not merge into `main` from a worker session.
- Each task branch must produce a PR or PR-ready handoff.
- The worker may prepare commits and a handoff, but must not self-merge.
- The Supervisor or human owner decides merge order.
- The Reviewer must review the branch before merge.
- Tests relevant to the task must pass before review-ready status.
- Full integration tests must pass before merging into `main`.
- If tests are failing, mark the task as `BLOCKED` or `CHANGES_REQUESTED`, not `REVIEW_READY`.
- If a task requires shared API, schema, build config, dependency, or lockfile changes, stop and ask the Supervisor unless that scope is explicitly assigned.
- Do not enable auto-merge unless the human explicitly asks for it.
- Prefer squash merge or merge commits according to the human's repository policy; do not choose merge strategy autonomously.

Worker responsibility:

- Implement the assigned task.
- Commit small coherent changes.
- Run narrow tests.
- Update `tasks/agent-state/TASK-xxx.WORKING_STATE.md`.
- Run `/handoff`.

Reviewer responsibility:

- Verify task scope.
- Verify tests.
- Verify legal/license boundaries.
- Verify dependency policy.
- Verify no forbidden files changed.
- Return `APPROVE`, `REQUEST_CHANGES`, or `BLOCKED`.

Supervisor responsibility:

- Decide merge order.
- Resolve cross-task conflicts.
- Ensure CI/status checks pass.
- Merge only after review approval and required checks pass.
