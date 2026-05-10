# 02 — Architecture

## Overview

`threebrew` should be organized as a modular emulator with a clear split between the core and the macOS frontend.

Recommended high-level tree:

```text
src/
  common/
  core/
  loader/
  hle/
  services/
  gpu/
  audio/
  fs/
  frontend/
  tools/
tests/
docs/
```

## Core modules

### `common/`

Shared utilities:

- fixed-width types
- logging
- assertions
- result/error type
- byte order helpers
- bitfield helpers
- file I/O wrappers
- tracing infrastructure

### `loader/`

Responsible for executable/container formats.

Initial order:

1. synthetic test binary loader
2. 3DSX homebrew loader
3. NCCH parser
4. ExeFS parser
5. RomFS parser
6. decrypted CCI/NCSD parser

Do not implement encrypted loading in early milestones.

### `core/arm11/`

Initial ARM11 interpreter.

Submodules:

- registers
- CPSR/APSR
- instruction decode
- ARM instruction interpreter
- Thumb instruction interpreter
- VFP/NEON stubs initially
- exception/SVC entry

Initial design goal: correctness and traceability, not speed.

### `core/memory/`

Memory system:

- virtual address mapping
- page permissions
- read8/read16/read32/read64
- write8/write16/write32/write64
- memory-mapped regions
- shared memory handles
- bounds checks
- deterministic fault reporting

### `core/kernel_hle/`

HLE kernel primitives:

- process
- thread
- scheduler
- handles
- events
- mutexes
- semaphores
- timers
- address arbitration
- SVC dispatcher

### `services/`

Horizon service layer.

Initial services:

- `srv`
- `apt`
- `fs`
- `hid`
- `gsp`
- `cfg`
- `ptm`

Later services:

- `am`
- `dsp`
- `ndm`
- `ac`
- `soc`
- `ssl`
- `y2r`
- `cam`
- `mic`
- `ir`
- `nfc`

Every service command must log:

- service name
- command id
- decoded arguments if known
- result
- whether implemented, stubbed, or unsupported

### `fs/`

Virtual file systems:

- RomFS mount
- ExeFS access
- save data archive
- extdata archive
- SDMC archive
- host path sandboxing
- safe flush semantics

### `gpu/`

PICA200 emulation.

Initial implementation stages:

1. dummy framebuffer output
2. GSP service command capture
3. GPU command buffer decoding
4. texture uploads
5. vertex buffers
6. simple triangles
7. depth/blend/stencil
8. shader instruction decoder
9. shader interpreter
10. Metal backend
11. shader cache
12. texture cache

Design principle: create an internal graphics IR before binding too tightly to Metal.

### `audio/`

Initial DSP/audio HLE:

- command queue acceptance
- buffer scheduling
- mixer
- output timing
- sample rate conversion
- underrun/overrun logging

### `frontend/macos/`

Desktop-first UI.

Required:

- two-screen layout
- keyboard mapping
- mouse/trackpad touch mapping
- pause/resume
- reset
- FPS/speed display
- log window or log file access
- configurable paths
- save folder management

Optional later:

- standard HID/gamepad support
- controller remapping UI
- screen layout presets
- performance overlays
- compatibility reports

## macOS play design

Because the target is direct Mac play, the first-class controls are:

### Keyboard default mapping

```text
3DS A      -> K
3DS B      -> J
3DS X      -> I
3DS Y      -> U
D-Pad      -> Arrow keys
Circle Pad -> WASD
L/R        -> Q/E
Start      -> Enter
Select     -> Right Shift
Home       -> F1 emulator menu, not actual HOME emulation initially
```

### Touch mapping

- lower screen receives mouse/trackpad coordinates
- click/tap = touch active
- drag = touch move
- release = touch end
- coordinates normalized to 320x240 lower-screen logical space

### Screen layout

Initial default:

```text
Upper screen: 400x240 logical
Lower screen: 320x240 logical
Layout: vertical stack
Integer scaling when possible
```

Later:

- side-by-side layout
- larger upper screen
- lower screen overlay
- fullscreen
- per-game layout profiles

## Logging

Use structured logs from the start.

Example:

```text
[CPU] pc=0x00100000 instr=0xE3A00001 op=MOV r0,#1
[SVC] id=0x32 name=SendSyncRequest handle=0x0012
[IPC] service=fs:USER cmd=OpenArchive result=0x0
[GPU] cmd=0x000F name=DrawElements status=unsupported
```

## Error handling policy

Unsupported behavior must not fail silently. Return clear `UnsupportedFeature` or `Unimplemented` errors where possible, and include a trace.
