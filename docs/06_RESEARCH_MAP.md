# 06 — Research map

This file tells Codex where to look for architecture ideas. Do not copy code unless a task explicitly authorizes it and license implications are documented.

## Open-source emulator references

### Azahar

Use for:

- mature Citra-family architecture
- loader/service/GPU design ideas
- compatibility logging concepts
- macOS build observations

Do not copy code without a GPL decision.

### Panda3DS

Use for:

- smaller HLE emulator organization
- modern experimental implementation choices
- understanding tradeoffs in sound, UI, and compatibility

Do not copy code without a GPL decision.

## Public documentation

### 3dbrew

Use for:

- hardware map
- services
- IPC
- GPU/PICA200
- file-system services
- NCCH/CCI/RomFS/ExeFS concepts

### devkitPro/libctru

Use for:

- how homebrew calls services
- expected service usage patterns
- homebrew test construction

### devkitPro/citro2d/citro3d

Use for:

- how PICA200 is used by homebrew
- GPU state and command patterns
- simple rendering test programs

### devkitPro/3ds-examples

Use for:

- homebrew test cases
- simple input, file-system, 2D, 3D examples

## Research method

For each subsystem:

1. read 3dbrew overview
2. inspect libctru or examples to see caller expectations
3. inspect Azahar/Panda3DS for architecture comparison
4. write a design note
5. implement a minimal generic version
6. add logs and tests
7. expand only when required by tests

## Research notes template

```markdown
# Research note: <subsystem>

## Sources read

- ...

## Observed responsibilities

- ...

## Key data structures

- ...

## Commands/functions to support first

- ...

## Unknowns

- ...

## Proposed implementation

- ...

## Test plan

- ...
```
