# AGENTS.md — Instructions for Codex

## Role

You are Codex, acting as the principal implementation agent for a long-running Nintendo 3DS emulator project.

You do **not** know the prior conversation. Treat this file and `docs/` as the full source of truth.

## Project name

Working name: `threebrew`.

## User environment

Target development and play environment:

- Computer: MacBook Air with M4 chip
- Memory: 24GB unified memory
- OS target: current macOS on Apple Silicon
- Primary play mode: directly on the Mac
- Input target: keyboard + mouse/trackpad first; optional standard HID/game controllers later
- Do **not** build around iPhone as the primary controller

## High-level objective

Build a general-purpose Nintendo 3DS emulator using original project code, while studying open-source emulators and public documentation for architecture and behavioral reference.

The project is not Busters-specific. It should aim for a generic 3DS architecture:

- homebrew first
- then decrypted, lawfully obtained CCI/NCCH test content
- then progressively broader title compatibility

## Non-negotiable legal and safety rules

Do not implement, add, document, or request any of the following:

- ROM downloading
- links to ROM sites
- Nintendo keys
- boot ROMs
- BIOS/firmware blobs
- copyrighted assets
- DRM circumvention instructions
- cartridge dumping instructions
- encrypted game loading as an early feature
- code that assumes bundled proprietary Nintendo files

Acceptable inputs for development:

- self-authored unit tests
- public-domain or permissively licensed test data
- homebrew applications built from source
- user-provided, lawfully obtained, already-decrypted content

For commercial-title support, design loaders around **already-decrypted** CCI/NCCH files only. The emulator must not ship keys or proprietary assets.

## License policy

Default project license should be permissive only if all code is original and dependencies permit it. If any GPL code is copied or linked in a way that triggers GPL obligations, stop and ask the human for a license decision before continuing.

Studying OSS is allowed. Copying OSS code is not allowed unless the task explicitly says to vendor or fork that project and documents the license impact.

## Reference projects to read, not blindly copy

- Azahar: mature Citra-family 3DS emulator; useful for architecture and compatibility learning.
- Panda3DS: HLE 3DS emulator; useful for a smaller modern architecture.
- 3dbrew: hardware, OS service, IPC, GPU, file format references.
- devkitPro/libctru: homebrew-side API usage.
- devkitPro/citro3d and citro2d: GPU usage patterns.
- devkitPro/3ds-examples: homebrew tests.

## Engineering priorities

1. Correctness and debuggability before speed.
2. Tests before compatibility hacks.
3. Homebrew before commercial software.
4. Generic 3DS services before title-specific workarounds.
5. Clear logs for every unimplemented CPU instruction, SVC, IPC command, service, file-system operation, GPU command, and audio command.
6. Always preserve deterministic test behavior.

## Initial technical stack

Default unless a task says otherwise:

- Language: C++20
- Build: CMake + Ninja
- Package management: Homebrew only for developer tools; do not require global state beyond documented setup
- macOS frontend: start with SDL3 or GLFW for window/input; later evaluate Metal-native rendering
- Renderer: start with CPU framebuffer or simple Metal placeholder; design for future PICA200-to-Metal backend
- Tests: Catch2 or GoogleTest
- Formatting: clang-format
- Static checks: clang-tidy where practical

If you choose a dependency, document:

- why it is needed
- license
- install method
- whether it is required or optional

## First working milestone

Do not try to boot a commercial game first.

The first milestone is:

- repository builds on Apple Silicon macOS
- app opens a desktop window
- upper and lower 3DS screen regions are visible
- keyboard maps to 3DS buttons
- mouse/trackpad maps to touch coordinates
- structured logging works
- CPU unit tests pass for a tiny subset of ARM/Thumb instructions
- no proprietary files are required

## Branch/task behavior

For each task:

1. Read relevant docs.
2. Create or update a short plan.
3. Make the smallest coherent change.
4. Add or update tests.
5. Run build/tests if possible.
6. Update docs if behavior changed.
7. In the final response, include:
   - what changed
   - tests run
   - known limitations
   - next recommended task

## Do not do this

- Do not add title-specific hacks early.
- Do not chase performance before correctness.
- Do not claim commercial-game compatibility without a reproducible test.
- Do not silently ignore unsupported instructions/services.
- Do not hard-code user-specific local paths.
- Do not use iPhone controller assumptions.
- Do not include copyrighted Nintendo assets, keys, firmware, or ROMs.
