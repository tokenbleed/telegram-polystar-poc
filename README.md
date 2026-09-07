# Telegram 0click DoS polystar crash sticker PoC

    ./gen.sh
    -> crash_sticker.tgs  (317 bytes, gzip, deterministic)

SHA-256: 8a2993ae6d39b02690f27664b40d78ffad05f3fc690568b78c28cbdbb54d3d29

Produces a minimal valid Lottie sticker whose only anomaly is a star
polystar with a point count of 1e38:

    {"ty":"sr","sy":1,"pt":{"a":0,"k":1e38},"is":{"a":0,"k":100},"os":{"a":0,"k":200},...}

Rendering it in any Telegram Desktop family client kills the process
with SIGABRT: uncaught std::length_error from vector::reserve().

## Root cause (desktop-app/rlottie, shipped in tdesktop)

1. lottieparser.cpp:1336 - "pt" parsed as a raw float, no clamping.
2. vpath.cpp:526 - size_t(ceilf(1e38) * 2) saturates to UINT64_MAX.
3. vpath.cpp:550 - nonzero roundness (is=100/os=200) selects
   reserve(numPoints*3+2, numPoints+3), wrapping to (UINT64_MAX, 2).
4. vpath.cpp:140 - vector::reserve(2^64-1) throws std::length_error.
5. No handler on the Lottie render worker -> __cxa_throw ->
   failed_throw -> std::terminate -> abort(). Matches the production
   crash reports frame for frame, including lldb-verified identical
   __cxa_throw (0x18f9f4130) and __pthread_kill (0x18fa15650).

Tuning note: set both roundness values to 0 and the same pt instead
wraps the reserve to 1 and drops into a ~1.8e19-iteration vertex loop:
a slow freeze rather than an instant abort. is/os nonzero = instant kill.

Benign control: change "k":1e38 to "k":5, rerun the script.

## Tested platforms

- macOS 27.0 (ARM64): AyuGram Desktop 6.7.8, AyuGram Desktop 7.0.9,
  Telegram Desktop 7.2.5. All crash on render, same
  signature (SIGABRT, uncaught std::length_error, dispatch render
  worker).
- Android: AyuGram (tested on device, crashes on render).
