# 07 — Mac playback requirements

The emulator must be playable directly on the MacBook Air M4. Do not require an iPhone controller.

## Input requirements

### Keyboard first

Default key mapping should be implemented and configurable.

```text
Circle Pad: WASD
D-Pad: Arrow keys
A: K
B: J
X: I
Y: U
L: Q
R: E
Start: Return
Select: Right Shift
Pause emulator: Space
Reset: Cmd+R or menu item
Fullscreen: Cmd+Enter or menu item
```

### Mouse/trackpad touch

The lower screen must support:

- click/tap as touch
- drag as touch move
- release as touch end
- coordinate conversion to 320x240 logical lower-screen coordinates

### Optional desktop controllers

Later, support generic HID/gamepad input through the frontend abstraction. Do not recommend or require a specific controller model.

## Display requirements

Initial layouts:

1. vertical layout: upper above lower
2. side-by-side layout
3. large upper + small lower
4. fullscreen preserving aspect ratio

Logical base sizes:

```text
Upper: 400x240
Lower: 320x240
```

Scaling rules:

- preserve aspect ratio
- prefer integer scaling when possible
- support HiDPI rendering
- support per-screen scaling later

## Performance requirements

For early development:

- correctness over FPS
- visible frame timing overlay
- logs for slow frames

For later playability:

- stable frame pacing
- shader cache
- texture cache
- audio latency controls
- release build profile

## UX requirements

The emulator should include:

- open file
- recent files
- settings
- controls
- pause/resume
- reset
- screenshot
- log file location
- save data folder location
- compatibility info
