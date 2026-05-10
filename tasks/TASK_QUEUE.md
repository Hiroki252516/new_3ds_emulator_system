# Codex task queue

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

## Later epics

- ARM/Thumb instruction coverage
- HLE kernel primitives
- `srv`, `apt`, `fs`, `hid`, `gsp`, `cfg`
- framebuffer path
- citro2d/citro3d examples
- PICA200 command decoder
- shader interpreter
- audio HLE
- save/extdata FS
- decrypted NCCH/CCI loader
- compatibility harness
- performance/JIT
