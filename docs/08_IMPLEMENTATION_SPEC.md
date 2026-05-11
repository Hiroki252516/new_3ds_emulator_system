# 08 — Initial implementation spec

This is the first implementation target coding agent should build toward.

## Executable name

`threebrew`

## Initial modules

```text
src/common/log.hpp
src/common/log.cpp
src/common/result.hpp
src/common/types.hpp
src/frontend/window.hpp
src/frontend/window.cpp
src/frontend/input.hpp
src/frontend/input.cpp
src/core/memory/memory.hpp
src/core/memory/memory.cpp
src/core/arm11/cpu.hpp
src/core/arm11/cpu.cpp
src/main.cpp
tests/test_memory.cpp
tests/test_arm11_basic.cpp
```

## Logging

Implement levels:

- trace
- debug
- info
- warn
- error

Initial output:

- stdout
- optional file later

## Memory API

Initial API sketch:

```cpp
class Memory {
public:
    explicit Memory(std::size_t size);
    std::uint8_t read8(std::uint32_t addr) const;
    std::uint16_t read16(std::uint32_t addr) const;
    std::uint32_t read32(std::uint32_t addr) const;
    void write8(std::uint32_t addr, std::uint8_t value);
    void write16(std::uint32_t addr, std::uint16_t value);
    void write32(std::uint32_t addr, std::uint32_t value);
};
```

All out-of-bounds accesses must be deterministic errors.

## CPU API

Initial API sketch:

```cpp
struct CpuState {
    std::uint32_t r[16]{};
    std::uint32_t cpsr{};
};

class Arm11Cpu {
public:
    explicit Arm11Cpu(Memory& memory);
    CpuState& state();
    const CpuState& state() const;
    void reset(std::uint32_t entry);
    void step();
};
```

Initial supported instructions may be tiny and synthetic. Tests are more important than coverage.

## Frontend

Initial window should show:

- upper screen rectangle
- lower screen rectangle
- input overlay text
- frame counter

If SDL/GLFW is added, document it in `docs/DEPENDENCIES.md`.

## Definition of done for first PR

- project builds
- tests run
- basic memory tests pass
- basic CPU synthetic tests pass
- frontend can be compiled, even if feature-gated
- docs updated
