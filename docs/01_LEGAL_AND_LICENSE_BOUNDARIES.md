# 01 — Legal and license boundaries

This document is part of the project requirements. Codex must follow it.

## Purpose

The project is an emulator research and interoperability project. It must not include or facilitate piracy.

## Content policy for this repository

The repository must not contain:

- commercial ROMs
- game dumps
- title keys
- boot ROMs
- firmware images
- BIOS blobs
- Nintendo copyrighted assets
- cartridge dumping instructions
- links to ROM sites
- automated downloaders for copyrighted content
- bypass instructions for encryption or access controls

## Supported input policy

The emulator should initially support:

- project-owned synthetic test programs
- homebrew built from source
- public-domain or permissively licensed test artifacts
- user-provided already-decrypted CCI/NCCH files, only after the loader architecture exists

## Explicit engineering constraint

The emulator must not require Nintendo-owned firmware, BIOS, keys, or files to build, test, or run its early milestones.

If a future compatibility issue appears to require proprietary files, Codex must:

1. stop
2. document the issue
3. propose an HLE alternative
4. ask for human decision before proceeding

## OSS license boundaries

Reference projects may be read for learning, but direct code copying is prohibited unless explicitly authorized.

### Known reference project licenses / constraints to review

- Azahar: GPL-2.0
- Panda3DS: GPLv3 according to its public FAQ/repository references
- Dynarmic: 0BSD
- devkitPro libraries: review each repository license before vendoring or linking
- 3dbrew: documentation reference, not a code dependency

## License decision process

Before adding a dependency:

1. identify exact dependency and version
2. identify license
3. state why it is needed
4. state whether it is build-time, test-time, or runtime
5. state whether it will be linked, vendored, or only used as a tool
6. update `docs/DEPENDENCIES.md`

If license impact is unclear, do not add the dependency.

## README language

The project README must include language equivalent to:

> This project does not include Nintendo firmware, keys, BIOS, games, or copyrighted assets. It is intended for emulator research, homebrew, and lawful interoperability. Users are responsible for providing their own legally obtained content.
