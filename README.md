# Shoot

Compositor-independant screenshot tool for Wayland with support for capturing the active output, active toplevel or a selection.

Shoot is also *fast*:
- arena allocators only
- no libwayland
- SIMD blitting
- no frees

## Building

Dependencies:
- Odin compiler
- libwebp

```sh
./build.sh
```

## Usage

The captured image is always encoded as WebP and printed to stdout.

```sh
shoot output/display/monitor
shoot toplevel/window
shoot selection "$(slurp)"
```

## Limitations

There is no protocol for capturing popups, only toplevels, meaning shoot will fail if the active window isn't a toplevel.

This will never happen, but until the ext protocol is merged for toplevel state events, I have to use a heuristic that matches ext and wlr toplevels based on their application ID and title, which can *technically* fail.
