# 00 — Project brief

## Project name

`threebrew` — a general-purpose Nintendo 3DS emulator for macOS Apple Silicon.

## Owner goal

The owner wants to build a general-purpose 3DS emulator by reading open-source implementations and public documentation, while implementing the codebase independently. The first practical play environment is the owner's MacBook Air M4 with 24GB unified memory.

The owner previously considered iPhone-as-controller, but the current requirement is different:

- gameplay should happen directly on the Mac
- keyboard + mouse/trackpad must be first-class inputs
- optional desktop gamepad support can be added later
- no iPhone controller path should be required

## Scope

### In scope

- macOS Apple Silicon desktop frontend
- keyboard input
- mouse/trackpad touch emulation
- optional HID/gamepad abstraction
- 2-screen layout system
- ARM11 interpreter initially
- HLE kernel/services
- homebrew loader
- public test homebrew support
- decrypted CCI/NCCH loader later
- PICA200 GPU emulation architecture
- DSP/audio HLE architecture
- save/extdata virtual file systems
- debugging tools and compatibility logging

### Out of scope for early milestones

- encrypted game loading
- key management
- ROM download flows
- firmware/BIOS bundling
- online multiplayer
- StreetPass/SpotPass
- camera/microphone
- stereoscopic 3D
- New 3DS-only extensions
- title-specific compatibility hacks

## Success definition

The project is successful when it evolves through these reproducible milestones:

1. Builds on macOS Apple Silicon.
2. Runs deterministic CPU and memory tests.
3. Boots simple homebrew.
4. Displays framebuffer output from homebrew.
5. Supports keyboard and mouse/touch input.
6. Runs libctru/citro2d/citro3d examples.
7. Loads decrypted CCI/NCCH content without proprietary files.
8. Boots multiple commercial titles supplied lawfully by the user.
9. Reaches playable status for a growing compatibility list.

## Key principle

Build the emulator as generic infrastructure. Do not start with "make one game work." Start with CPU, memory, kernel, services, loader, GPU, audio, FS, and tests.
