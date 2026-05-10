# 05 — Build and test

## Target environment

Primary target:

- macOS on Apple Silicon
- MacBook Air M4
- 24GB unified memory

## Initial toolchain

Expected tools:

- Xcode Command Line Tools
- CMake
- Ninja
- clang/clang++
- Python 3 for helper scripts
- a unit test framework such as Catch2 or GoogleTest

Do not assume global proprietary SDKs beyond Apple's standard developer tools.

## Initial setup commands

Proposed commands once a skeleton exists:

```bash
xcode-select --install
brew install cmake ninja
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake --build build
ctest --test-dir build --output-on-failure
```

If additional dependencies are introduced, update this file and `docs/DEPENDENCIES.md`.

## Build types

Recommended:

```bash
# Debug
cmake -S . -B build/debug -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake --build build/debug
ctest --test-dir build/debug --output-on-failure

# Release
cmake -S . -B build/release -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build/release
ctest --test-dir build/release --output-on-failure
```

## Test categories

### Unit tests

- bitfields
- endian helpers
- memory read/write
- CPU decode
- CPU instruction execution
- IPC command packing/unpacking
- FS path sandboxing

### Golden tests

- tiny synthetic instruction programs
- frame hash tests
- service-call trace tests

### Manual tests

- frontend window opens
- keyboard input logs
- mouse maps to lower-screen coordinates
- two-screen layout scales correctly

## Performance benchmarks

Do not optimize until correctness exists. Later benchmarks should include:

- CPU interpreter MIPS-like internal metric
- frame pacing
- GPU command decode throughput
- host render time
- audio buffer latency
