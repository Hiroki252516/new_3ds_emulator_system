# 03 — Roadmap

This roadmap assumes a single developer plus Codex assistance, targeting correctness first.

## Project Completion Criteria

The first public-quality development milestone of `threebrew` is complete when all of the following are true:

- The emulator builds reproducibly on the target macOS Apple Silicon environment.
- Core emulator code and the macOS frontend remain separated according to `docs/02_ARCHITECTURE.md`.
- Synthetic CPU, memory, loader, HLE service, framebuffer, and input tests pass.
- A lawful homebrew 3DSX program built from source can be loaded far enough to reach a deterministic stop reason, visible trace, or basic output path.
- Unsupported CPU instructions, SVCs, IPC commands, services, FS operations, GPU commands, and audio operations produce structured logs rather than silent failures.
- No ROM downloads, Nintendo keys, BIOS, firmware blobs, cartridge dumping instructions, DRM circumvention, or proprietary Nintendo assets are required or documented.
- Dependencies are documented in `docs/DEPENDENCIES.md`.
- Compatibility results, if any real lawful homebrew is tested, are recorded according to `docs/09_COMPATIBILITY_POLICY.md`.
- CI or documented local verification passes.

Project completion is milestone-based. This first milestone does not mean full commercial title compatibility.

## Phase 0 — Repository and project skeleton

Goal: buildable repository with docs and CI-ready structure.

Deliverables:

- CMake project
- `src/` and `tests/` structure
- formatting config
- logging module
- basic unit test framework
- documentation stubs
- `docs/DEPENDENCIES.md`

Acceptance criteria:

- `cmake -S . -B build -G Ninja`
- `cmake --build build`
- `ctest --test-dir build`
- all pass on macOS Apple Silicon

## Phase 1 — macOS frontend shell

Goal: desktop play shell with no emulation yet.

Deliverables:

- app/window opens
- upper/lower screen regions visible
- keyboard input state
- mouse/touch mapping for lower screen
- frame timing loop
- screenshot/log capture placeholders

Acceptance criteria:

- window renders two rectangles
- input events appear in logs
- lower-screen coordinate conversion tested

## Phase 2 — CPU and memory foundations

Goal: deterministic CPU tests.

Deliverables:

- ARM11 register model
- memory bus
- read/write helpers
- minimal ARM decoder
- minimal Thumb decoder
- basic instruction tests

Acceptance criteria:

- unit tests pass for selected MOV/ADD/SUB/LDR/STR/B/BL/BX patterns
- invalid instruction paths log clearly

## Phase 3 — HLE kernel skeleton

Goal: enough kernel infrastructure for homebrew experiments.

Deliverables:

- handles
- thread/process abstractions
- SVC dispatcher
- events/mutex placeholders
- scheduler skeleton
- traceable unimplemented SVC handling

Acceptance criteria:

- synthetic program can issue a fake SVC
- dispatcher routes and logs it
- tests cover handle lifecycle

## Phase 4 — 3DSX homebrew loader

Goal: load and start simple homebrew.

Deliverables:

- 3DSX parser
- memory placement
- entrypoint setup
- minimal environment
- libctru startup investigation notes

Acceptance criteria:

- simple homebrew or synthetic 3DSX reaches entrypoint
- unsupported imports are logged deterministically

## Phase 5 — service layer baseline

Goal: homebrew can call basic services.

Deliverables:

- service manager `srv`
- minimal `hid`
- minimal `apt`
- minimal `fs`
- minimal `gsp`
- IPC command decoder

Acceptance criteria:

- service calls are decoded in logs
- homebrew input test reaches expected service calls
- unknown commands are reported with service/cmd id

## Phase 6 — framebuffer and basic GPU path

Goal: show simple framebuffer output.

Deliverables:

- GSP registration path
- framebuffer memory interpretation
- upper/lower screen copy to frontend
- simple display timing

Acceptance criteria:

- a framebuffer test displays expected colors
- frame hashes are testable

## Phase 7 — citro2d/citro3d homebrew path

Goal: begin GPU command decoding.

Deliverables:

- PICA200 command buffer reader
- texture command subset
- vertex command subset
- primitive draw subset
- host rendering backend placeholder/Metal path

Acceptance criteria:

- simple triangle homebrew renders approximately
- unsupported GPU commands are logged

## Phase 8 — decrypted NCCH/CCI loader

Goal: parse already-decrypted commercial-style containers.

Deliverables:

- NCSD/CCI parser
- NCCH parser
- ExeFS loader
- RomFS reader
- title metadata extraction
- no encryption/key support

Acceptance criteria:

- parser tests with synthetic fixtures
- loader can enumerate sections of a decrypted test container
- no proprietary files are needed

## Phase 9 — FS/save/extdata

Goal: stable file-system abstractions.

Deliverables:

- RomFS archive
- save data archive
- extdata archive
- SDMC archive
- host folder mapping
- flush and durability tests

Acceptance criteria:

- round-trip save tests pass
- paths are sandboxed
- file errors are deterministic

## Phase 10 — audio HLE

Goal: basic sound without blocking game progress.

Deliverables:

- DSP command stubs
- buffer queue
- mixer
- timing model
- frontend audio output

Acceptance criteria:

- audio test emits sound
- no runaway buffer growth
- audio stubs do not silently ignore commands

## Phase 11 — compatibility expansion

Goal: multiple homebrew and lawful decrypted test titles.

Deliverables:

- compatibility list format
- boot trace capture
- frame hash capture
- regression harness
- performance metrics

Acceptance criteria:

- compatibility status can be reproduced from logs
- regressions are visible in CI/manual test output

## Phase 12 — performance

Only after correctness:

- consider Dynarmic integration
- shader cache
- texture cache
- Metal optimization
- frame pacing
- async compilation
