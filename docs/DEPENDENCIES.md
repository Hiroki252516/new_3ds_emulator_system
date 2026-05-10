# Dependencies

Do not add dependencies without documenting them here.

## Current required dependencies

None yet. This file should be updated by Codex as soon as a build skeleton chooses a unit test framework, frontend library, or renderer support library.

## Candidate dependencies to evaluate

| Dependency | Purpose | License to verify | Required? | Notes |
|---|---|---|---|---|
| CMake | build system | BSD-style | yes | Expected project build system |
| Ninja | build backend | Apache 2.0 | yes | Fast local builds |
| SDL3 or GLFW | window/input | verify exact license | maybe | Pick one, document rationale |
| Catch2 or GoogleTest | unit tests | verify exact license | maybe | Pick one |
| Metal-cpp / Objective-C++ | renderer | Apple terms / headers | later | Native macOS renderer |
| Dynarmic | ARM JIT | 0BSD | later | Do not start with JIT |
