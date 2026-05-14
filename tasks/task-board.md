# Task Board

This file is the supervisor-controlled task board for Gemini CLI development.

## Rules

- Give Gemini one task at a time unless using explicit worktree workers.
- Supervisor updates this file.
- Workers update only their own `tasks/agent-state/TASK-xxx.WORKING_STATE.md`.
- Full logs must be saved under `.agent-logs/<task-id>/`.
- Do not paste full logs into this file.
- Do not delete future project intent when marking tasks complete.

## Status legend

| Status | Meaning |
|---|---|
| BACKLOG | Not started |
| READY | Ready for work |
| IN_PROGRESS | Worker is active |
| BLOCKED | Needs human/supervisor decision |
| REVIEW_READY | Ready for review |
| CHANGES_REQUESTED | Needs fixes |
| DONE | Completed and reviewed |

## Global Definition of Done

A task may be marked `DONE` only when all of the following are true:

- The task-specific `Acceptance` criteria are satisfied.
- The implementation stays within the task's assigned scope.
- Relevant tests were added or updated, unless the task is documentation-only.
- Relevant tests pass locally, or the failure is explicitly documented and accepted by the Supervisor.
- Build behavior is not broken.
- No forbidden paths or out-of-scope files were modified.
- No raw logs are pasted into `docs/`, `tasks/`, or comments.
- Full logs, if needed, are saved under `.agent-logs/<task-id>/`.
- `tasks/agent-state/TASK-xxx.WORKING_STATE.md` is updated.
- Any dependency change is documented in `docs/DEPENDENCIES.md`.
- Any architecture or workflow decision is documented in `tasks/architecture/DECISIONS.md`.
- Any user-facing behavior or workflow change is reflected in `docs/`.
- Legal boundaries are respected: no ROM downloads, keys, BIOS, firmware blobs, cartridge dumping instructions, DRM circumvention, or proprietary Nintendo assets.
- Reviewer returns `APPROVE`, or the Supervisor explicitly accepts the remaining risk.

## REVIEW_READY Criteria

A worker may mark a task `REVIEW_READY` only when:

- All intended code/documentation changes for the task are complete.
- The task-specific `Acceptance` criteria appear satisfied.
- The worker has run the narrowest relevant tests or documented why no tests apply.
- Failing or skipped tests are documented in the task state file.
- `tasks/agent-state/TASK-xxx.WORKING_STATE.md` contains:
  - summary of changes
  - files touched
  - commands run
  - test results
  - known limitations
  - raw log paths
  - recommended reviewer focus
- The branch has no unrelated changes.
- The worker has run `/handoff` or produced an equivalent PR-ready handoff.

## Phase 0 Exit Criteria — repository/bootstrap quality

Phase 0 is complete when:

- CMake/Ninja build is reproducible from a clean checkout.
- At least one trivial test passes.
- Formatting configuration exists and a non-mutating format check is documented.
- Dependency documentation policy is explicit.
- Legal safety checklist exists for future loader tasks.
- Task maintenance rules are documented.
- No proprietary artifacts, ROMs, keys, firmware, BIOS blobs, or dumping instructions are added.
- All Phase 0 tasks are `DONE` or explicitly deferred by Supervisor decision.

## Phase 1 Exit Criteria — macOS frontend shell

Phase 1 is complete when:

- The macOS frontend opens a placeholder window.
- Upper and lower screen rectangles are displayed or represented.
- Keyboard/mouse input events are logged deterministically.
- Screen layout calculation is covered by tests.
- Pause, reset request, fullscreen request, and screenshot placeholder paths are reachable.
- Unsupported file types produce clear errors.
- No commercial ROM loading, key loading, encrypted loading, or download flow is introduced.

## Phase 2 Exit Criteria — CPU and memory foundations

Phase 2 is complete when:

- ARM11 CPU state, CPSR/APSR helpers, ARM/Thumb state representation, and memory regions are implemented.
- Supported synthetic instruction subsets have deterministic unit tests.
- Unsupported instructions log PC, raw instruction, mode, and reason.
- Memory access errors include address and region information when available.
- CPU golden program runner can execute bounded synthetic programs.
- All tests for CPU and memory foundations pass.

## Phase 3 Exit Criteria — HLE kernel skeleton and SVC routing

Phase 3 is complete when:

- Handles, processes, threads, scheduler state, and synchronization primitives have deterministic lifecycle tests.
- SVC dispatch routes implemented SVCs and unknown SVCs through traceable paths.
- Unsupported kernel behavior logs IDs, arguments, and reasons rather than silently succeeding.
- A synthetic kernel integration smoke test runs without real 3DS binaries.
- No service-specific or title-specific hacks are introduced.

## Phase 4 Exit Criteria — 3DSX homebrew loader

Phase 4 is complete when:

- 3DSX headers, sections, relocations, environment setup, and process creation are covered by synthetic fixture tests.
- Malformed 3DSX inputs fail deterministically with actionable errors.
- Unresolved imports and service dependencies are reported as structured unsupported features.
- A synthetic or lawful source-built homebrew path reaches an entrypoint and deterministic stop reason.
- The lawful homebrew workflow is documented without binaries, ROM sites, keys, firmware, dumping instructions, or DRM circumvention.

## Phase 5 Exit Criteria — baseline HLE services and IPC traces

Phase 5 is complete when:

- IPC pack/unpack helpers, service sessions, and baseline `srv`, `hid`, `apt`, `fs`, `gsp`, `cfg`, and `ptm` service paths are implemented or explicitly stubbed.
- Known and unknown service commands produce deterministic traces with service name, command id, decoded arguments when known, result, and status.
- A synthetic or lawful homebrew startup flow reaches service calls and records an explicit stop reason.
- Compatibility notes are updated when real lawful homebrew is tested.

## Phase 6 Exit Criteria — framebuffer and basic GPU path

Phase 6 is complete when:

- Core framebuffer state represents upper and lower screens with documented pixel format assumptions.
- GSP framebuffer registration and CPU framebuffer blit paths are testable.
- Frame hashes are deterministic and independent of host window scaling.
- Screenshot and log-location paths are reachable without user-specific paths.
- A synthetic or lawful framebuffer smoke path verifies expected pixels or frame hashes.

## Phase 7 Exit Criteria — citro2d/citro3d and PICA200 path

Phase 7 is complete when:

- PICA200 command buffer research, initial graphics IR direction, and legal boundaries are documented.
- Command buffer reading, register decoding, clear/color-fill, texture metadata, vertex metadata, simple triangle, and shader skeleton paths have synthetic tests.
- Unsupported GPU registers, commands, state, and shader opcodes remain visible in structured logs.
- Lawful citro2d/citro3d source-build workflow and expected stop reasons are documented.
- Any Metal backend decision is documented and the CPU framebuffer path remains supported.

## Phase 8 Exit Criteria — decrypted NCCH/CCI loader

Phase 8 is complete when:

- Already-decrypted NCSD/CCI, NCCH, ExeFS, and RomFS parsing behavior is documented and tested with synthetic fixtures.
- Loader hooks can identify supported synthetic, homebrew, and already-decrypted container inputs.
- Encrypted or unsupported inputs are rejected with clear errors and no key prompts.
- Loader smoke tests enumerate expected sections and stop deterministically.
- No encryption support, key handling, ROM download flow, firmware dependency, dumping guidance, or proprietary fixture is added.

## Phase 9 Exit Criteria — FS/save/extdata

Phase 9 is complete when:

- Virtual archive interfaces and RomFS, SDMC, save data, and extdata backends have deterministic tests.
- Host path sandboxing prevents traversal and avoids hard-coded local paths.
- FS service archive integration and file/directory handle lifecycles are tested.
- Durability tests cover write, close, reopen, flush, and failure paths using isolated temp directories.
- Frontend save-folder access stays under the configured user-data root.

## Phase 10 Exit Criteria — audio HLE

Phase 10 is complete when:

- DSP/audio research, command logging, buffer queue, mixer, timing model, and frontend output behavior are documented or implemented according to task scope.
- Audio unit tests use synthetic sample data and do not require speakers or proprietary samples.
- Unsupported DSP commands, invalid buffers, underruns, and overruns produce structured logs and deterministic errors.
- Synthetic audio smoke tests verify output data or counters.
- Manual lawful-homebrew audio test guidance references the compatibility policy.

## Phase 11 Exit Criteria — compatibility harness and reporting

Phase 11 is complete when:

- Compatibility templates and records follow `docs/09_COMPATIBILITY_POLICY.md`.
- Boot traces, frame hashes, service traces, GPU/audio traces, validators, and summary reports work with synthetic or lawful test inputs.
- Compatibility claims include commit, host, content type, status, renderer/audio/input notes, logs, and known regressions.
- Unsupported commercial compatibility claims are removed or downgraded.
- Legal boundaries remain explicit in compatibility workflow docs.

## Phase 12 Exit Criteria — performance and optional JIT

Phase 12 is complete when:

- Profiling counters and benchmark harnesses provide reproducible synthetic baselines without changing deterministic behavior.
- Frame pacing, texture cache, shader cache, and Metal renderer work preserve reference-path correctness and documented fallbacks.
- Dynarmic or any JIT work remains optional, license-reviewed, and gated by a human decision before integration.
- Performance docs distinguish measured bottlenecks from guesses.
- Phase completion does not require commercial title compatibility or JIT integration.

## Active tasks

| ID | Status | Branch/worktree | State file | Owner | Notes |
|---|---|---|---|---|---|
| T000 | READY | T000-init-skeleton | tasks/agent-state/T000.WORKING_STATE.md | worker-bootstrap | Initial skeleton |





# gemini cli task queue

Give Codex one task at a time. Do not ask it to implement the full emulator at once.

## T000 — Initialize repository skeleton

Prompt:

```text
Read AGENTS.md and docs. Create the initial C++20 CMake/Ninja repository skeleton for threebrew. Add README, src/common types/log/result stubs, tests directory, clang-format config, and docs/DEPENDENCIES.md updates if you choose a test framework. Do not add emulator functionality beyond stubs. Add build instructions and run the build/tests if possible.
```

Acceptance:

- CMake config exists
- project builds
- one trivial test passes
- docs updated

## T010 — Logging and result types

Prompt:

```text
Implement a small structured logging module and result/error type for emulator subsystems. Add tests for log formatting or result behavior where practical. Keep dependencies minimal.
```

## T020 — Memory bus skeleton

Prompt:

```text
Implement src/core/memory with byte-addressed memory, little-endian read/write helpers, and deterministic out-of-bounds errors. Add unit tests for read8/read16/read32/write8/write16/write32 and boundary cases.
```

## T030 — ARM11 CPU state and synthetic interpreter step

Prompt:

```text
Implement ARM11 CPU state with registers r0-r15 and CPSR. Add a minimal instruction execution path for synthetic tests. Start with MOV immediate and ADD immediate if practical. Add tests. Do not attempt full ARM decode yet.
```

## T040 — Desktop frontend placeholder

Prompt:

```text
Add a macOS desktop frontend placeholder using the selected window library. It should open a window with upper and lower screen rectangles and log keyboard/mouse events. Implement lower-screen coordinate conversion tests.
```

## T050 — Input abstraction

Prompt:

```text
Create an input abstraction for 3DS buttons, circle pad, d-pad, and touchscreen. Implement default Mac keyboard/mouse mapping from docs/07_MAC_PLAYBACK_REQUIREMENTS.md. Add tests for mapping logic.
```

## T060 — IPC and service manager skeleton

Prompt:

```text
Implement a minimal HLE service manager skeleton with service registration, sessions/handles placeholders, and structured logging of unsupported service commands. Add tests.
```

## T070 — SVC dispatcher skeleton

Prompt:

```text
Implement a minimal SVC dispatcher that can route SVC ids to named handlers and report unimplemented SVCs. Add tests for known and unknown ids.
```

## T080 — 3DSX loader research note

Prompt:

```text
Write docs/research/3dsx_loader.md after researching public 3DSX/homebrew loading references. Do not implement yet. Include proposed data structures, risks, and tests.
```

## T090 — 3DSX loader minimal parser

Prompt:

```text
Implement a minimal 3DSX parser based on the accepted research note. Use synthetic fixtures only. Add parser tests. Do not use proprietary content.
```

## T100 — libctru hello-world test plan

Prompt:

```text
Create a plan for building or sourcing a simple lawful homebrew test program from source using devkitPro/libctru examples. Do not include binaries. Document exact steps and how the emulator will load it.
```

## Phase 0 continuation — repository/bootstrap quality

These tasks harden the initial repository so long-running Codex work remains reproducible.

## T110 — Build presets and developer workflow

Docs to read:

- `docs/05_BUILD_AND_TEST.md`
- `docs/DEPENDENCIES.md`

Prompt:

```text
Add CMake presets or documented equivalent commands for debug and release builds. Keep the build CMake/Ninja based. Update docs/05_BUILD_AND_TEST.md if commands change. Run configure, build, and tests if possible.
```

Acceptance:

- Debug and release build commands are documented
- Existing tests still pass
- No user-specific absolute paths are introduced

## T120 — Formatting configuration and check target

Prompt:

```text
Add or refine clang-format configuration and a non-mutating format check command or CMake target. Do not reformat unrelated code unless required. Document how Codex should run the check.
```

Acceptance:

- Formatting rules exist
- A check command is documented
- Running the check does not require proprietary tools

## T130 — clang-tidy evaluation

Prompt:

```text
Evaluate clang-tidy for this C++20 project. If practical, add an opt-in target or documented command. If not practical yet, document blockers. Do not make clang-tidy mandatory until the skeleton is stable.
```

Acceptance:

- Decision is recorded in docs
- Any new dependency or tool assumption is documented
- Existing build behavior is unchanged by default

## T140 — Deterministic test fixture helpers

Prompt:

```text
Create a small tests fixture helper layer for byte buffers, temporary directories, and golden text comparison. Use only synthetic data. Add tests for the helpers.
```

Acceptance:

- Fixture helpers are deterministic
- Temporary files are isolated under test-owned directories
- No proprietary artifacts are added

## T150 — Trace capture test helper

Prompt:

```text
Add a test helper that captures structured logs/traces in memory so CPU, SVC, IPC, GPU, and audio tests can assert unsupported behavior later.
```

Acceptance:

- Tests can capture log records without scraping stdout
- Unsupported behavior can be asserted by subsystem, id, and result
- Existing logging output still works

## T160 — Dependency policy check

Prompt:

```text
Add a lightweight documentation check, script, or checklist that ensures new dependencies are recorded in docs/DEPENDENCIES.md before use. Keep it simple and non-invasive.
```

Acceptance:

- Dependency documentation expectations are explicit
- The check does not require network access
- The policy matches docs/01_LEGAL_AND_LICENSE_BOUNDARIES.md

## T170 — Legal safety checklist for loader tasks

Docs to read:

- `docs/01_LEGAL_AND_LICENSE_BOUNDARIES.md`
- `docs/06_RESEARCH_MAP.md`

Prompt:

```text
Add a short docs checklist for future loader and compatibility tasks. It must explicitly prohibit ROM downloads, keys, firmware, BIOS blobs, cartridge dumping instructions, and encrypted loading work unless a future human decision changes scope.
```

Acceptance:

- Checklist is linked or referenced from the task queue
- No prohibited instructions or links are added
- Already-decrypted user-provided content policy is preserved

## T180 — Emulator configuration skeleton

Prompt:

```text
Add a minimal configuration model for emulator settings such as window layout, input mapping, log level, and user data directories. Implement parsing only if a simple dependency-free format is available; otherwise keep it in-memory and document the future file format.
```

Acceptance:

- Defaults match docs/07_MAC_PLAYBACK_REQUIREMENTS.md
- Tests cover default values
- No user-specific local paths are hard-coded

## T190 — Task queue maintenance rule

Prompt:

```text
Add a short rule to tasks/task-board.md explaining how future gemini cli tasks should mark completed work, split tasks that are too large, and add follow-up tasks without deleting project intent.
```

Acceptance:

- Future task maintenance is documented
- The rule keeps tasks one-at-a-time and reviewable
- Existing task numbering remains understandable

## Phase 1 — macOS frontend shell

## T200 — Frontend frame timing loop

Docs to read:

- `docs/07_MAC_PLAYBACK_REQUIREMENTS.md`
- `docs/02_ARCHITECTURE.md`

Prompt:

```text
Implement a deterministic frontend frame timing loop around the placeholder window. Log frame number, elapsed time, and slow-frame warnings. Keep emulation core coupling minimal.
```

Acceptance:

- Window remains responsive
- Frame timing is visible in logs or overlay
- Manual test instructions are documented

## T210 — Screen layout scaler

Prompt:

```text
Implement screen layout calculation for vertical layout using 400x240 upper and 320x240 lower logical sizes. Prefer integer scaling when possible and preserve aspect ratio.
```

Acceptance:

- Unit tests cover several host window sizes
- Upper and lower rectangles never overlap
- Lower-screen touch conversion uses the computed layout

## T220 — Side-by-side and large-upper layouts

Prompt:

```text
Add side-by-side and large-upper layout modes to the frontend layout calculator. Keep the default vertical. Add tests for aspect ratio and bounds.
```

Acceptance:

- Three layout modes are selectable through configuration or code path
- Tests cover desktop-sized and small windows
- No text or overlay depends on fixed pixel positions

## T230 — Pause, reset, and fullscreen input commands

Prompt:

```text
Implement frontend-level commands for pause/resume, reset request, and fullscreen toggle using docs/07_MAC_PLAYBACK_REQUIREMENTS.md mappings. These may be logged placeholders until core reset exists.
```

Acceptance:

- Space toggles pause
- Cmd+R or menu-equivalent path requests reset
- Cmd+Enter or menu-equivalent path requests fullscreen
- Commands are logged deterministically

## T240 — Screenshot placeholder

Prompt:

```text
Add a screenshot command path that captures the current two-screen frontend image or writes a clearly marked placeholder if rendering is not ready. Use a safe user-data or test output location.
```

Acceptance:

- Screenshot action is reachable
- Output path is logged
- No user-specific path is hard-coded

## T250 — Recent file and open file UI skeleton

Prompt:

```text
Add frontend/application skeleton code for open-file and recent-file entries without implementing commercial loading. Filter or label supported early file types as synthetic/homebrew only.
```

Acceptance:

- UI or command hooks exist
- Unsupported file types produce clear errors
- No ROM download, key, or encrypted loading flow is introduced

## Phase 2 — CPU and memory foundations

## T300 — ARM decoder scaffold

Docs to read:

- `docs/02_ARCHITECTURE.md`
- `docs/03_ROADMAP.md`

Prompt:

```text
Create an ARM instruction decoder scaffold that classifies a tiny supported subset and reports unsupported instructions with PC and raw instruction. Do not copy decoder code from reference emulators.
```

Acceptance:

- MOV/ADD synthetic instructions still work
- Unsupported ARM instructions produce structured logs
- Decoder tests cover supported and unsupported encodings

## T310 — Thumb decoder scaffold

Prompt:

```text
Create a Thumb instruction decoder scaffold for a tiny supported subset. Unsupported Thumb instructions must log PC and raw halfword.
```

Acceptance:

- Thumb mode can be represented in CPU state
- Decoder tests cover at least one supported and one unsupported Thumb pattern
- Unsupported behavior is deterministic

## T320 — CPSR/APSR flag helpers

Prompt:

```text
Implement helpers for N, Z, C, V, T, and mode bits in CPSR/APSR. Add tests for flag set/get and arithmetic flag updates.
```

Acceptance:

- Flag helpers avoid magic bit manipulation at call sites
- ADD/SUB flag behavior has unit tests for simple cases
- Existing CPU tests pass

## T330 — ARM MOV/MVN immediate family

Prompt:

```text
Expand ARM interpreter support for MOV and MVN immediate forms needed by synthetic tests. Include optional flag update behavior when encoded.
```

Acceptance:

- Unit tests cover MOV, MVN, and flag-setting variants
- Unsupported variants still log clearly
- PC advancement is tested

## T340 — ARM ADD/SUB immediate/register subset

Prompt:

```text
Implement a small ARM ADD/SUB immediate and register subset. Focus on correctness for tests, flag behavior, and deterministic unsupported paths.
```

Acceptance:

- Tests cover carry, borrow, zero, negative, and overflow cases
- Unsupported shifts or encodings log as unimplemented
- No performance shortcuts obscure traceability

## T350 — ARM LDR/STR word subset

Prompt:

```text
Implement ARM LDR/STR word subset for simple immediate offsets against the memory bus. Respect little-endian memory helpers and deterministic fault reporting.
```

Acceptance:

- Tests cover load, store, offset, and out-of-bounds behavior
- Memory faults are surfaced as emulator errors
- Unsupported addressing modes log clearly

## T360 — ARM branch subset

Prompt:

```text
Implement ARM B and BL for synthetic tests. Include PC/link register behavior and trace logs.
```

Acceptance:

- Tests cover forward and backward branches
- BL writes LR as expected by the chosen interpreter convention
- Invalid or unsupported condition handling remains explicit

## T370 — BX and ARM/Thumb state transition

Prompt:

```text
Implement BX for switching between ARM and Thumb state in synthetic tests. Keep behavior minimal and well-tested.
```

Acceptance:

- Tests cover ARM-to-Thumb and Thumb-to-ARM transitions
- Misaligned or unsupported targets report deterministic errors
- CPU traces include state changes

## T380 — Virtual memory regions and permissions

Prompt:

```text
Extend the memory system from a flat byte buffer to named mapped regions with read/write/execute permissions. Keep the simple API usable for tests.
```

Acceptance:

- Tests cover valid access, unmapped access, and permission failures
- Error messages include address and region when available
- Existing flat-memory tests are migrated or preserved

## T390 — CPU golden program runner

Prompt:

```text
Add a small synthetic program runner for CPU golden tests. It should load bytes into memory, set an entrypoint, run a bounded number of steps, and compare final registers/traces.
```

Acceptance:

- Golden tests cover a short arithmetic/load/store/branch program
- Infinite loops are bounded by a max-step error
- Trace output is deterministic

## Phase 3 — HLE kernel skeleton

## T400 — Handle table implementation

Docs to read:

- `docs/02_ARCHITECTURE.md`
- `docs/03_ROADMAP.md`

Prompt:

```text
Implement a kernel HLE handle table with typed objects, allocation, lookup, close, and deterministic invalid-handle errors.
```

Acceptance:

- Tests cover allocation, lookup, close, reuse policy, and invalid handles
- Errors include handle value and object type when known
- No service-specific hacks are added

## T410 — Process model skeleton

Prompt:

```text
Add a minimal process model with process id, memory map reference, handle table, and entrypoint metadata. Keep it independent from 3DSX details.
```

Acceptance:

- Tests cover process creation defaults
- Process owns or references a handle table clearly
- Loader can later create a process without frontend dependencies

## T420 — Thread model skeleton

Prompt:

```text
Add a minimal thread model with thread id, CPU state, priority placeholder, status, and owning process. Do not implement real scheduling yet.
```

Acceptance:

- Tests cover thread creation and state transitions
- Thread states are explicit and logged
- No host thread dependency is required

## T430 — Cooperative scheduler skeleton

Prompt:

```text
Implement a deterministic cooperative scheduler skeleton that selects runnable HLE threads and advances one CPU step at a time.
```

Acceptance:

- Tests cover runnable, waiting, and stopped threads
- Scheduling order is deterministic
- Unsupported timing behavior is documented

## T440 — Event and mutex primitives

Prompt:

```text
Implement minimal HLE event and mutex primitives sufficient for SVC tests. Include wait/signal behavior as deterministic state changes.
```

Acceptance:

- Tests cover event signal/reset and mutex lock/unlock basics
- Waiting behavior integrates with thread state
- Unimplemented edge cases log clearly

## T450 — Semaphore and timer placeholders

Prompt:

```text
Add semaphore and timer HLE placeholders with explicit unsupported or minimal behavior. Implement only what can be tested deterministically now.
```

Acceptance:

- Objects can be created and identified through handles
- Unsupported waits/timeouts log as unimplemented
- Tests cover lifecycle behavior

## T460 — Address arbitration placeholder

Prompt:

```text
Add an address arbitration HLE placeholder with structured logging for unsupported operations. Do not fake success silently.
```

Acceptance:

- SVC path can route address arbitration calls
- Unsupported operation logs include operation id and address
- Tests assert unsupported results

## T470 — SVC create/wait/close subset

Prompt:

```text
Implement minimal SVC handlers for handle close and simple wait paths using the kernel HLE primitives. Keep unknown SVC ids explicit.
```

Acceptance:

- Tests cover known and unknown SVC dispatch
- CloseHandle behavior uses the handle table
- Wait behavior is deterministic for implemented primitives

## T480 — SVC trace golden tests

Prompt:

```text
Add golden trace tests for a synthetic program or direct dispatcher calls covering implemented and unsupported SVCs.
```

Acceptance:

- Trace records include SVC id, name, arguments, and result
- Unknown SVCs remain visible in failures
- Golden output is stable across runs

## T490 — Kernel integration smoke test

Prompt:

```text
Create a smoke test that constructs a process, thread, memory map, scheduler, and SVC dispatcher, then executes a bounded synthetic flow.
```

Acceptance:

- Test passes deterministically
- Failure logs are actionable
- No real 3DS binary is required

## Phase 4 — 3DSX homebrew loader

## T500 — 3DSX research note expansion

Docs to read:

- `docs/06_RESEARCH_MAP.md`
- `docs/01_LEGAL_AND_LICENSE_BOUNDARIES.md`

Prompt:

```text
Expand docs/research/3dsx_loader.md with relocation handling, import behavior, memory layout, and libctru startup expectations. Use public documentation and reference projects only for understanding; do not copy code.
```

Acceptance:

- Sources read are listed
- Proposed implementation and test plan are clear
- Legal boundaries are repeated for loader work

## T510 — 3DSX header and section parser expansion

Prompt:

```text
Expand the 3DSX parser to validate header fields and section sizes using synthetic fixtures. Keep malformed file errors deterministic.
```

Acceptance:

- Tests cover valid and invalid synthetic headers
- Section ranges are bounds-checked
- No real copyrighted binaries are added

## T520 — 3DSX relocation table parser

Prompt:

```text
Parse 3DSX relocation metadata into internal structures without applying relocations yet. Use synthetic fixtures only.
```

Acceptance:

- Tests cover empty, valid, and malformed relocation data
- Parsed records are inspectable
- Unsupported relocation types are logged or rejected clearly

## T530 — 3DSX relocation application

Prompt:

```text
Apply the supported subset of 3DSX relocations to an in-memory image. Keep relocation errors deterministic and well-tested.
```

Acceptance:

- Tests cover at least one successful relocation and one failure
- Relocations cannot write outside the image
- Logs include relocation type and target offset on failure

## T540 — Homebrew process creation from 3DSX

Prompt:

```text
Connect the 3DSX loader to the process model by creating a process memory layout, loading sections, applying relocations, and setting an entrypoint.
```

Acceptance:

- Synthetic 3DSX fixture creates a process
- Entrypoint and memory permissions are tested
- Unsupported imports are not silently ignored

## T550 — Minimal homebrew environment block

Prompt:

```text
Add a minimal homebrew startup environment block required by the documented 3DSX plan. Implement only fields justified by research and tests.
```

Acceptance:

- Environment layout is documented
- Tests validate placement and values
- Missing or unsupported fields are explicit

## T560 — Import and service stub reporting

Prompt:

```text
Ensure unresolved imports or service dependencies from homebrew startup are reported as structured unsupported features, not generic crashes.
```

Acceptance:

- Tests cover unresolved import reporting
- Logs identify import/module where possible
- Loader does not claim support beyond implemented behavior

## T570 — Lawful homebrew build workflow

Prompt:

```text
Document a reproducible workflow for building a tiny homebrew program from source using public devkitPro/libctru examples or project-owned code. Do not commit generated binaries.
```

Acceptance:

- Documentation includes source-based steps only
- No ROM sites, keys, firmware, or dumping instructions are included
- Output artifacts are ignored or clearly out of repo

## T580 — First 3DSX entrypoint smoke test

Prompt:

```text
Add a smoke test using a synthetic 3DSX fixture that reaches the configured entrypoint and stops at a known unsupported instruction, SVC, or import with a deterministic trace.
```

Acceptance:

- Test asserts entrypoint reached
- Stop reason is explicit
- No proprietary content is used

## T590 — Homebrew loader manual test checklist

Prompt:

```text
Add a manual test checklist for loading lawful homebrew once built from source, including expected logs and how to record compatibility status.
```

Acceptance:

- Checklist references docs/09_COMPATIBILITY_POLICY.md
- It does not ask the user to obtain copyrighted content
- It records host, commit, status, logs, and known issues

## Phase 5 — service layer baseline

## T600 — IPC command pack/unpack

Docs to read:

- `docs/02_ARCHITECTURE.md`
- `docs/06_RESEARCH_MAP.md`

Prompt:

```text
Implement IPC command header pack/unpack helpers and tests. Include command id, normal parameter count, translate descriptor count, and raw words.
```

Acceptance:

- Tests cover round-trip packing and malformed headers
- IPC logs can print decoded command ids
- Helpers are independent from any one service

## T610 — Service session and port model

Prompt:

```text
Expand the service manager with named ports, sessions, and per-service command dispatch. Keep unsupported commands structured.
```

Acceptance:

- Tests cover service registration, connection, dispatch, and unknown service
- Sessions are represented by handles or handle-ready objects
- Logs include service name and command id

## T620 — srv service baseline

Prompt:

```text
Implement the minimal srv service commands needed for homebrew to request service handles, based on the research note or public docs. Stub unsupported commands explicitly.
```

Acceptance:

- Tests cover successful lookup of registered services
- Unknown service names return deterministic errors
- Logs identify srv command ids

## T630 — hid service baseline

Prompt:

```text
Implement a minimal hid service path that exposes frontend input state through a testable shared structure or command response. Focus on buttons and touch coordinates first.
```

Acceptance:

- Tests cover button state and touch state conversion
- Unsupported HID commands log clearly
- Default mappings remain documented

## T640 — apt service baseline

Prompt:

```text
Implement minimal apt service behavior required by homebrew startup, such as initialization or applet lifecycle placeholders. Avoid pretending to support full HOME menu behavior.
```

Acceptance:

- Startup-relevant commands have deterministic responses
- Unsupported lifecycle behavior logs as stubbed or unsupported
- Tests cover known and unknown commands

## T650 — fs service baseline

Prompt:

```text
Implement minimal fs service command decoding and archive placeholder behavior. Do not add save/extdata persistence yet except as explicit unsupported responses.
```

Acceptance:

- Tests cover OpenArchive-like command decoding if implemented
- Unsupported archive types include archive id in logs
- No host path escape is possible

## T660 — gsp service baseline

Prompt:

```text
Implement minimal gsp service command decoding for registration and framebuffer-related setup needed by later GPU tasks. Do not implement real GPU command execution yet.
```

Acceptance:

- Tests cover registration or command decode paths
- Unsupported GPU commands log service, command id, and arguments
- Framebuffer state can be inspected by later tasks

## T670 — cfg and ptm service baselines

Prompt:

```text
Add minimal cfg and ptm service responses for common environment queries needed by homebrew. Keep returned values documented and generic.
```

Acceptance:

- Tests cover implemented query responses
- Values do not depend on proprietary system files
- Unsupported commands are traceable

## T680 — Service trace golden tests

Prompt:

```text
Add golden trace tests for srv, hid, apt, fs, gsp, cfg, and ptm known and unknown command paths.
```

Acceptance:

- Traces include service name, command id, decoded arguments when known, result, and status
- Unknown commands are not silent
- Tests are deterministic

## T690 — Homebrew service startup smoke test

Prompt:

```text
Run a synthetic or lawful homebrew startup flow far enough to exercise service lookup and at least one baseline service. Record the expected stop reason.
```

Acceptance:

- Smoke test or documented manual test reaches service calls
- Stop reason is unsupported instruction/service/GPU path, not a crash
- Compatibility notes are updated if a real lawful homebrew is tested

## Phase 6 — framebuffer and basic GPU path

## T700 — Framebuffer model

Docs to read:

- `docs/02_ARCHITECTURE.md`
- `docs/07_MAC_PLAYBACK_REQUIREMENTS.md`

Prompt:

```text
Create a core framebuffer model for upper and lower screens with logical sizes, pixel format metadata, and CPU-readable test helpers.
```

Acceptance:

- Tests cover upper/lower dimensions and pixel writes
- Pixel format assumptions are documented
- No renderer-specific dependency leaks into core

## T710 — GSP framebuffer registration path

Prompt:

```text
Connect minimal gsp service state to the framebuffer model so guest-visible framebuffer addresses or descriptors can be recorded and inspected.
```

Acceptance:

- Tests cover registration and descriptor validation
- Invalid addresses or formats produce deterministic errors
- Logs identify framebuffer changes

## T720 — CPU framebuffer blit to frontend

Prompt:

```text
Implement a simple CPU-side path that copies upper/lower framebuffer data to the frontend renderer. Keep it correct and traceable before optimizing.
```

Acceptance:

- Manual test displays deterministic color patterns
- Unit or integration tests cover frame conversion
- Unsupported pixel formats log clearly

## T730 — Frame hash capture

Prompt:

```text
Add frame hash capture for upper and lower screens to support regression tests. Hashes must be deterministic and independent from host window scaling.
```

Acceptance:

- Tests cover known framebuffer hash values
- Hash output can be included in compatibility records
- Scaling/layout changes do not affect hashes

## T740 — Display timing placeholder

Prompt:

```text
Add a display timing placeholder that presents frames at a controlled cadence and logs missed or duplicate frames. Do not chase performance yet.
```

Acceptance:

- Frame pacing logs are visible
- Tests cover deterministic counter behavior where practical
- Slow-frame handling is documented

## T750 — Screenshot implementation

Prompt:

```text
Replace the screenshot placeholder with real capture of the logical upper/lower screens or combined layout. Use a simple documented image format or dependency with license documentation.
```

Acceptance:

- Screenshot files are produced in a safe location
- Dependency policy is followed if an image library is added
- Manual test instructions are documented

## T760 — Frontend log file access

Prompt:

```text
Add a frontend or app-level way to show or log the current log file location. This may be a menu item, overlay, or command-line output depending on frontend maturity.
```

Acceptance:

- User can discover where logs are written
- Path is configurable or under a safe default user-data directory
- No hard-coded user-specific path is used

## T770 — Framebuffer homebrew smoke path

Prompt:

```text
Use a synthetic or lawful homebrew-style test to drive framebuffer updates through the current service path and verify expected colors or frame hashes.
```

Acceptance:

- Test reaches framebuffer update path
- Expected frame hash or pixel sample is asserted
- Stop reason after the tested path is explicit

## T780 — HiDPI rendering audit

Prompt:

```text
Audit frontend rendering on HiDPI macOS. Fix coordinate conversion or scaling bugs without changing core framebuffer hashes.
```

Acceptance:

- Manual test notes include HiDPI behavior
- Touch coordinates still map to 320x240 lower-screen space
- Layout tests cover backing-scale scenarios if practical

## Phase 7 — citro2d/citro3d and PICA200 path

## T800 — PICA200 research note

Docs to read:

- `docs/06_RESEARCH_MAP.md`
- `docs/REFERENCES.md`

Prompt:

```text
Write docs/research/pica200.md describing the initial GPU command buffer architecture, register categories, shader plan, and tests. Use public docs and reference projects for understanding only.
```

Acceptance:

- Sources and license boundaries are listed
- Proposed internal graphics IR is described
- First supported command subset is identified

## T810 — GPU command buffer reader

Prompt:

```text
Implement a PICA200 command buffer reader that parses command headers and raw parameters into internal records. Do not execute commands yet.
```

Acceptance:

- Tests cover valid, empty, and malformed command buffers
- Unknown commands are preserved for logging
- Parser is independent from Metal or frontend code

## T820 — GPU register decode subset

Prompt:

```text
Decode a minimal subset of PICA200 registers needed for viewport/framebuffer/clear or simple draw setup, based on the research note.
```

Acceptance:

- Tests cover known and unknown register ids
- Logs include register id and decoded name when known
- Unsupported registers remain visible

## T830 — GPU clear/color fill subset

Prompt:

```text
Implement a minimal GPU clear or color-fill command path that can update the core framebuffer through decoded commands.
```

Acceptance:

- Synthetic command buffer updates expected pixels
- Frame hash tests cover the result
- Unsupported state logs clearly

## T840 — Texture upload metadata subset

Prompt:

```text
Parse and store texture upload metadata for a small supported format subset. Do not implement broad texture sampling yet.
```

Acceptance:

- Tests cover texture descriptor parsing
- Unsupported formats produce deterministic errors
- Texture memory bounds are checked

## T850 — Vertex buffer metadata subset

Prompt:

```text
Parse and store vertex buffer metadata for a minimal simple-triangle path. Keep attribute formats limited and explicit.
```

Acceptance:

- Tests cover descriptor parsing and bounds errors
- Unsupported attribute formats log clearly
- No host renderer dependency is introduced

## T860 — Software simple triangle path

Prompt:

```text
Implement a minimal software simple-triangle path or internal draw IR interpreter sufficient for a synthetic triangle test. Prioritize correctness over speed.
```

Acceptance:

- Synthetic triangle produces deterministic framebuffer output
- Frame hash or pixel sample test exists
- Unsupported blend/depth/stencil state logs clearly

## T870 — Shader instruction decoder skeleton

Prompt:

```text
Add a shader instruction decoder skeleton for the PICA200 shader subset planned in docs/research/pica200.md. Do not implement full shader execution yet.
```

Acceptance:

- Tests cover at least one decoded instruction and one unknown instruction
- Decoder output is inspectable
- Unknown shader instructions log raw bits

## T880 — Shader interpreter minimal subset

Prompt:

```text
Implement the smallest shader interpreter subset needed by the synthetic simple-triangle path. Keep all unsupported opcodes explicit.
```

Acceptance:

- Tests cover the implemented shader operations
- Unsupported opcodes include program counter and raw instruction
- Simple-triangle path uses the interpreter if applicable

## T890 — citro2d/citro3d lawful example plan

Prompt:

```text
Document how to build and test simple citro2d/citro3d examples from source for future compatibility testing. Do not commit built binaries.
```

Acceptance:

- Source-based workflow is documented
- No copyrighted content, keys, firmware, or dumping instructions are included
- Expected emulator logs and stop reasons are described

## T900 — Metal backend evaluation checkpoint

Prompt:

```text
Evaluate whether to add a Metal backend now that the CPU framebuffer and simple GPU path exist. Document dependency/licensing implications and propose the first Metal-backed slice, but do not rewrite the renderer yet unless the task explicitly approves it.
```

Acceptance:

- Decision note is added to docs
- Metal dependency and build impact are documented
- CPU framebuffer path remains supported

## Phase 8 — decrypted NCCH/CCI loader

## T910 — NCCH/CCI legal and format research note

Docs to read:

- `docs/01_LEGAL_AND_LICENSE_BOUNDARIES.md`
- `docs/06_RESEARCH_MAP.md`

Prompt:

```text
Write docs/research/decrypted_ncch_cci.md covering already-decrypted NCSD/CCI, NCCH, ExeFS, and RomFS parsing. Explicitly exclude encryption, keys, firmware, BIOS, ROM downloads, and dumping instructions.
```

Acceptance:

- The note is implementation-oriented
- Legal exclusions are explicit
- Synthetic fixture strategy is described

## T920 — NCSD/CCI parser skeleton

Prompt:

```text
Implement a parser skeleton for already-decrypted NCSD/CCI container headers using synthetic fixtures only. It must enumerate partitions without loading content yet.
```

Acceptance:

- Tests cover valid and malformed synthetic headers
- Partition offsets and sizes are bounds-checked
- No encryption or key handling code is added

## T930 — NCCH parser skeleton

Prompt:

```text
Implement an NCCH parser skeleton for already-decrypted content using synthetic fixtures. Parse header metadata needed to locate ExeFS and RomFS.
```

Acceptance:

- Tests cover ExeFS/RomFS offset extraction
- Malformed headers fail deterministically
- No proprietary fixtures are added

## T940 — ExeFS parser

Prompt:

```text
Implement an ExeFS parser for synthetic already-decrypted fixtures. Enumerate files and expose code/icon/banner entries as data ranges only.
```

Acceptance:

- Tests cover file table parsing and bounds errors
- Parser does not require proprietary assets
- Unsupported compression or encryption is explicit

## T950 — RomFS parser

Prompt:

```text
Implement a RomFS parser for synthetic fixtures with directory and file lookup. Keep path handling deterministic and safe.
```

Acceptance:

- Tests cover directory traversal, file reads, and missing paths
- Path normalization prevents escape-like behavior
- Malformed metadata fails clearly

## T960 — Decrypted title metadata extraction

Prompt:

```text
Extract generic title metadata available from parsed already-decrypted containers without relying on copyrighted assets. Avoid displaying proprietary icon/banner content unless supplied lawfully by the user at runtime.
```

Acceptance:

- Synthetic metadata tests pass
- Missing metadata is handled gracefully
- Compatibility records can reference extracted identifiers

## T970 — Loader process creation from ExeFS

Prompt:

```text
Connect the already-decrypted NCCH/ExeFS parser to process creation for synthetic fixtures. Load code into memory and set an entrypoint where format support allows.
```

Acceptance:

- Synthetic fixture creates a process
- Memory placement and permissions are tested
- Unsupported executable formats report clear errors

## T980 — Container loader CLI/front-end hook

Prompt:

```text
Add an application hook that can identify supported synthetic/homebrew/decrypted container inputs and route them to the correct loader. Unsupported or encrypted inputs must produce explicit errors.
```

Acceptance:

- File identification is tested with synthetic fixtures
- Encrypted content is rejected without key prompts
- Error messages do not instruct users how to obtain or decrypt content

## T990 — Decrypted loader smoke test

Prompt:

```text
Add a smoke test for a synthetic already-decrypted NCCH/CCI-style fixture that enumerates sections and reaches the expected loader stop point.
```

Acceptance:

- Test uses synthetic data only
- Section enumeration is asserted
- Stop reason is explicit and deterministic

## Phase 9 — FS/save/extdata

## T1000 — Filesystem architecture research note

Docs to read:

- `docs/02_ARCHITECTURE.md`
- `docs/06_RESEARCH_MAP.md`

Prompt:

```text
Write docs/research/filesystem.md covering RomFS, ExeFS, save data, extdata, SDMC, host path sandboxing, and flush semantics. Use public docs and reference projects only for understanding.
```

Acceptance:

- Archive responsibilities are separated
- Host sandbox policy is explicit
- Test plan covers path safety and persistence

## T1010 — Virtual archive interface

Prompt:

```text
Implement a virtual archive interface for open/read/write/list operations with deterministic error types. Do not implement all archive backends yet.
```

Acceptance:

- Tests cover interface behavior through a fake archive
- Errors include archive and path context
- API can represent read-only and writable archives

## T1020 — RomFS archive backend

Prompt:

```text
Implement a RomFS archive backend using the RomFS parser. It should be read-only and deterministic.
```

Acceptance:

- Tests cover file reads and directory listing
- Writes fail with clear read-only errors
- Synthetic RomFS fixtures only

## T1030 — SDMC host sandbox backend

Prompt:

```text
Implement an SDMC-like host folder backend with strict sandboxing under a configured user-data directory. Do not allow absolute guest paths to escape.
```

Acceptance:

- Tests cover normal paths, traversal attempts, and missing files
- Writes remain inside the sandbox
- Host paths are not hard-coded

## T1040 — Save data archive backend

Prompt:

```text
Implement a basic save data archive backend using the host sandbox. Include create, read, write, delete, and flush behavior for files.
```

Acceptance:

- Round-trip save tests pass
- Flush behavior is documented and tested where practical
- Failures are deterministic

## T1050 — Extdata archive backend

Prompt:

```text
Implement a basic extdata archive backend similar to save data but separated by title/test identifier. Keep layout generic.
```

Acceptance:

- Tests cover title/test identifier separation
- Path sandboxing matches SDMC/save behavior
- Missing extdata is handled gracefully

## T1060 — FS service archive integration

Prompt:

```text
Connect fs service archive commands to the virtual archive layer for implemented archive types. Unsupported archive ids must remain explicit.
```

Acceptance:

- Tests cover opening implemented and unsupported archives
- Service logs include archive id and path
- Host sandboxing remains enforced

## T1070 — File handle lifecycle

Prompt:

```text
Implement file and directory handle lifecycle through the kernel handle table for fs service operations.
```

Acceptance:

- Tests cover open/read/write/close and invalid handles
- Directory iteration is deterministic
- Handle leaks are detectable in tests

## T1080 — Filesystem durability tests

Prompt:

```text
Add durability-style tests for save/extdata writes, close, reopen, flush, and error paths using temporary directories.
```

Acceptance:

- Tests use isolated temp directories
- Data persists across archive reopen within the test
- Partial failure behavior is documented

## T1090 — Save folder frontend access

Prompt:

```text
Add a frontend/app-level command or log entry that shows the save data folder location for the current content or test profile.
```

Acceptance:

- User can discover save folder location
- Path is under configured user-data root
- No proprietary content assumptions are added

## Phase 10 — audio HLE

## T1100 — Audio HLE research note

Docs to read:

- `docs/02_ARCHITECTURE.md`
- `docs/06_RESEARCH_MAP.md`

Prompt:

```text
Write docs/research/audio_hle.md covering DSP service expectations, command queues, buffer scheduling, sample formats, mixer plan, timing, and frontend output options.
```

Acceptance:

- Sources and license boundaries are listed
- Initial command subset is identified
- Test strategy avoids proprietary samples

## T1110 — DSP service command logging baseline

Prompt:

```text
Add a minimal dsp service baseline that decodes/logs known command ids and returns explicit unsupported results for unimplemented behavior.
```

Acceptance:

- Tests cover known and unknown command logging
- No command is silently ignored
- Service manager can register dsp

## T1120 — Audio buffer queue model

Prompt:

```text
Implement a core audio buffer queue model with enqueue, consume, underrun, and overrun reporting. Use synthetic sample data in tests.
```

Acceptance:

- Tests cover enqueue/consume order
- Underrun and overrun are logged
- Queue bounds are deterministic

## T1130 — Simple mixer

Prompt:

```text
Implement a simple mixer for a minimal PCM format subset. Prioritize deterministic output and tests over performance.
```

Acceptance:

- Tests cover mono/stereo or the chosen initial channel format
- Clipping or conversion behavior is documented
- Unsupported formats report clear errors

## T1140 — Audio timing model

Prompt:

```text
Add an audio timing model that consumes buffers according to sample rate and emulator time counters. Keep it deterministic for tests.
```

Acceptance:

- Tests cover consumption over simulated time
- Drift or underrun logs are generated
- No host audio dependency is required for unit tests

## T1150 — Frontend audio output placeholder

Prompt:

```text
Connect the mixer to a frontend audio output placeholder or real backend if an existing frontend dependency supports it. Document any new dependency or backend behavior.
```

Acceptance:

- Audio path can be enabled or disabled
- Unit tests do not require host audio hardware
- Manual test instructions are documented

## T1160 — DSP buffer command subset

Prompt:

```text
Implement the smallest DSP command subset needed to feed the audio buffer queue from service calls. Unsupported commands must remain visible.
```

Acceptance:

- Tests cover command-to-buffer behavior
- Invalid buffers fail deterministically
- Logs include command id and buffer metadata

## T1170 — Audio smoke test

Prompt:

```text
Add a synthetic audio smoke test that enqueues a simple waveform, advances timing, and verifies deterministic mixed output or buffer consumption.
```

Acceptance:

- Test does not require speakers
- Output or counters are asserted
- Underrun/overrun behavior is covered

## T1180 — Audio manual test checklist

Prompt:

```text
Add a manual checklist for testing audio with lawful homebrew once available, including expected logs, latency notes, and compatibility record fields.
```

Acceptance:

- Checklist references docs/09_COMPATIBILITY_POLICY.md
- No proprietary content instructions are included
- Known limitations are explicit

## T1190 — Audio error and trace audit

Prompt:

```text
Audit audio and dsp paths so every unsupported command, invalid buffer, underrun, and overrun has structured logging and deterministic errors.
```

Acceptance:

- Trace tests cover representative failures
- Logs include enough context to debug
- No silent stubs remain in audio paths

## Phase 11 — compatibility harness and reporting

## T1200 — Compatibility directory and template

Docs to read:

- `docs/09_COMPATIBILITY_POLICY.md`

Prompt:

```text
Add a compatibility records directory with a README and template matching docs/09_COMPATIBILITY_POLICY.md. Include examples only for synthetic or project-owned tests.
```

Acceptance:

- Template includes status, commit, host, renderer, audio, input, logs, and known regressions
- No commercial title claims are made without test data
- Policy against false compatibility claims is linked

## T1210 — Boot trace capture command

Prompt:

```text
Add a command-line or test harness mode that boots a supported input for a bounded number of steps and writes a structured boot trace.
```

Acceptance:

- Step bound prevents infinite runs
- Trace includes CPU/SVC/IPC/service/GPU/audio events where available
- Unsupported input errors are clear and lawful

## T1220 — Frame hash regression harness

Prompt:

```text
Add a regression harness that can compare expected frame hashes for synthetic or lawful test content. Keep expected data small and reviewable.
```

Acceptance:

- Synthetic frame hash regression test passes
- Hash mismatches produce useful output
- Host window scaling does not affect results

## T1230 — Service trace regression harness

Prompt:

```text
Add a regression harness for expected service-call traces from synthetic or lawful homebrew-style tests.
```

Acceptance:

- Known service trace can be compared deterministically
- Unknown extra calls are visible in diffs
- Sensitive or proprietary data is not recorded

## T1240 — GPU/audio trace regression harness

Prompt:

```text
Extend regression capture to GPU and audio trace categories so future compatibility work can identify behavioral changes.
```

Acceptance:

- GPU and audio trace categories can be enabled independently
- Golden tests remain deterministic
- Trace output is concise enough for review

## T1250 — Manual compatibility workflow

Prompt:

```text
Document the manual workflow for testing lawful homebrew and user-provided already-decrypted content, collecting logs/screenshots/frame hashes, and updating compatibility records.
```

Acceptance:

- Workflow avoids ROM/key/firmware/dumping instructions
- It requires commit, host, content type, and logs
- Status labels match docs/09_COMPATIBILITY_POLICY.md

## T1260 — Compatibility status validator

Prompt:

```text
Add a lightweight validator or checklist for compatibility records to ensure required fields are present and status labels are valid.
```

Acceptance:

- Valid template passes
- Missing required fields are reported
- Validator does not need network access

## T1270 — Regression summary report

Prompt:

```text
Add a command or script that summarizes boot trace, frame hash, service trace, GPU trace, and audio trace results for local review.
```

Acceptance:

- Summary is human-readable
- Failures point to relevant artifacts
- It works with synthetic tests

## T1280 — First homebrew compatibility record

Prompt:

```text
When a lawful source-built homebrew test is available, create the first compatibility record with exact source, commit, host, status, logs, and known issues. If no lawful built test is available, create a synthetic test record instead and document the blocker.
```

Acceptance:

- Record follows the template
- Claim is reproducible
- No proprietary artifact is committed

## T1290 — Compatibility audit gate

Prompt:

```text
Audit compatibility-related docs and records for unsupported claims, missing logs, or legal boundary issues. Fix documentation only; do not broaden emulator compatibility in this task.
```

Acceptance:

- No unsupported commercial compatibility claims remain
- Records include required fields
- Legal boundaries are still explicit

## Phase 12 — performance and optional JIT

## T1300 — Interpreter profiling counters

Docs to read:

- `docs/03_ROADMAP.md`
- `docs/05_BUILD_AND_TEST.md`

Prompt:

```text
Add lightweight profiling counters for interpreter steps, unsupported instruction counts, SVC counts, frame time, GPU command count, and audio buffer stats. Keep profiling optional and low-risk.
```

Acceptance:

- Counters can be enabled for debug runs
- Tests cover counter increments where practical
- Profiling does not change deterministic behavior

## T1310 — Performance benchmark harness

Prompt:

```text
Add a small benchmark harness for synthetic CPU, memory, GPU command decode, and frame hash workloads. Do not optimize yet; establish baselines.
```

Acceptance:

- Benchmarks are documented
- Results are not required for unit-test pass/fail unless stable
- No proprietary content is used

## T1320 — Frame pacing improvement pass

Prompt:

```text
Improve frame pacing using data from the timing and profiling counters. Keep correctness and deterministic tests intact.
```

Acceptance:

- Manual before/after notes are recorded
- No compatibility behavior is hidden by timing changes
- Slow-frame logs remain available

## T1330 — Texture cache design note

Prompt:

```text
Write a design note for a future texture cache, including invalidation, memory ownership, hash keys, and correctness risks. Do not implement the cache yet.
```

Acceptance:

- Design identifies correctness tests before performance claims
- GPU command/state dependencies are listed
- No host-backend lock-in is introduced

## T1340 — Texture cache minimal implementation

Prompt:

```text
Implement the smallest texture cache slice justified by the design note. Include invalidation tests and a fallback uncached path.
```

Acceptance:

- Tests cover cache hit, miss, and invalidation
- Incorrect stale data is detectable
- Uncached path remains available

## T1350 — Shader cache design note

Prompt:

```text
Write a design note for shader caching, including guest shader identity, translated representation, invalidation, disk cache policy, and debug controls. Do not implement yet.
```

Acceptance:

- Correctness risks are explicit
- Disk cache location avoids user-specific paths
- Cache can be disabled for debugging

## T1360 — Shader cache minimal implementation

Prompt:

```text
Implement a minimal in-memory shader cache for the existing shader/interpreter path. Avoid persistent disk cache until invalidation is proven.
```

Acceptance:

- Tests cover cache hit/miss and invalidation
- Debug option can disable the cache
- Shader behavior remains deterministic

## T1370 — Metal renderer first slice

Prompt:

```text
If the Metal evaluation approved it, implement the first Metal renderer slice for presenting already-produced framebuffers. Do not move PICA200 emulation wholesale to Metal yet.
```

Acceptance:

- CPU framebuffer path still works
- Metal path can be disabled
- Dependency/build docs are updated
- Manual macOS test is documented

## T1380 — Dynarmic research and license checkpoint

Docs to read:

- `docs/01_LEGAL_AND_LICENSE_BOUNDARIES.md`
- `docs/DEPENDENCIES.md`

Prompt:

```text
Research Dynarmic integration feasibility and license impact. Document architecture options, 0BSD license notes, build impact, debugging tradeoffs, and why interpreter correctness remains required. Do not integrate Dynarmic in this task.
```

Acceptance:

- License and dependency impact are documented
- Integration is explicitly optional and later
- Human decision point is recorded before implementation

## T1390 — Optional JIT integration plan

Prompt:

```text
If Dynarmic or another JIT remains acceptable after the license checkpoint, write a concrete integration plan with fallback interpreter behavior, test strategy, and debugging controls. Do not implement the JIT yet.
```

Acceptance:

- Plan includes enable/disable switch
- Interpreter remains the reference path
- Tests compare interpreter and JIT behavior for synthetic programs

## T1400 — Performance audit and next roadmap refresh

Prompt:

```text
Audit performance data, compatibility results, and remaining correctness gaps. Refresh docs/03_ROADMAP.md and tasks/task-board.md with the next set of concrete tasks based on measured bottlenecks and compatibility blockers.
```

Acceptance:

- Roadmap reflects measured facts, not guesses
- New tasks remain small and reviewable
- Legal and license constraints are preserved

## Ongoing task families

Use these whenever a feature task reveals a cross-cutting need. Do not bundle them into unrelated implementation work unless the change is tiny.

## O001 — Documentation consistency update

Prompt:

```text
After a behavior or architecture change, update the relevant docs so AGENTS.md, docs/02_ARCHITECTURE.md, docs/03_ROADMAP.md, docs/05_BUILD_AND_TEST.md, docs/DEPENDENCIES.md, and tasks/task-board.md do not drift.
```

Acceptance:

- Docs match implemented behavior
- No future feature is claimed as complete unless tested
- Legal boundaries remain intact

## O002 — Unsupported behavior logging audit

Prompt:

```text
Audit one subsystem for silent unsupported behavior. Add structured logs and tests for unimplemented CPU instructions, SVCs, IPC commands, services, FS operations, GPU commands, or audio commands.
```

Acceptance:

- At least one silent or weak error path is improved
- Tests assert the new error or trace
- Logs include subsystem, id/name, arguments where known, and result

## O003 — License checkpoint

Prompt:

```text
Before adding, vendoring, copying, or linking any new third-party dependency or reference code, document exact dependency, version, license, purpose, link/vendor/tool status, and impact. Stop and ask the human if GPL or unclear license obligations may apply.
```

Acceptance:

- docs/DEPENDENCIES.md is updated
- License risk is explicit
- No code is copied from GPL projects without approval

## O004 — Regression fixture refresh

Prompt:

```text
When behavior intentionally changes, refresh only the affected synthetic golden fixtures or compatibility expectations. Explain why the new output is correct.
```

Acceptance:

- Fixture changes are minimal
- Review notes explain expected behavior change
- No proprietary data is introduced

## O005 — Task queue split or refinement

Prompt:

```text
If a queued task is too large or outdated, split it into smaller tasks or refine its acceptance criteria before implementation. Preserve the original intent and document the reason.
```

Acceptance:

- Resulting tasks can be completed one at a time
- Numbering remains readable
- No project scope is silently removed
