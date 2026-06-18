"""Remove solid magenta / fuchsia background from a PNG (alpha = transparent)."""

from __future__ import annotations

import sys
from pathlib import Path

from PIL import Image


def is_bright_magenta(r: int, g: int, b: int) -> bool:
    # Pure / near fuchsia (#FF00FF and neighbours)
    d1 = ((r - 255) ** 2 + (g - 0) ** 2 + (b - 255) ** 2) ** 0.5
    d2 = ((r - 255) ** 2 + (g - 0) ** 2 + (b - 200) ** 2) ** 0.5
    if d1 < 95 or d2 < 85:
        return True
    # Vivid screen magenta / purple: high R+B, low G
    if r > 160 and b > 160 and g < 140 and (r - g) > 60 and (b - g) > 60:
        return True
    return False


def is_dark_magenta(r: int, g: int, b: int) -> bool:
    # Deep plum / wine backgrounds (~#A00048): low G, moderate R and B
    if g > 50:
        return False
    if r < 45 or b < 10:
        return False
    if (r - g) < 35 or (b - g) < 10:
        return False
    # Skip dark browns from the foreground art
    if b < 15 and g > 10:
        return False
    if g > 20 and b < g:
        return False
    return True


def is_background(r: int, g: int, b: int) -> bool:
    return is_bright_magenta(r, g, b) or is_dark_magenta(r, g, b)


def main() -> None:
    if len(sys.argv) < 3:
        print("Usage: strip_magenta_bg.py <input.png> <output.png>", file=sys.stderr)
        sys.exit(1)
    src = Path(sys.argv[1])
    dst = Path(sys.argv[2])

    img = Image.open(src).convert("RGBA")
    px = img.load()
    w, h = img.size
    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            if is_background(r, g, b):
                px[x, y] = (r, g, b, 0)
            else:
                px[x, y] = (r, g, b, 255)

    img.save(dst, optimize=True)
    print(f"Wrote {dst} ({dst.stat().st_size} bytes)")


if __name__ == "__main__":
    main()
