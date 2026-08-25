#!/usr/bin/env python3
"""Claude Code status line.

Reads the status line JSON payload on stdin and prints a single line.

The interesting part is the cache percentage: Claude Code hands us
``context_window.current_usage`` for the most recent assistant turn, which
carries ``cache_read_input_tokens`` and ``cache_creation_input_tokens``. Cache
reads are the cheap path; cache *creation* means prompt tokens had to be
written into the cache afresh, either because they are newly appended or
because something earlier in the prefix changed and forced a re-upload. A
healthy long session sits near 100%. A run of turns well below that means
something near the front of the prompt is churning (a file re-read into
context, a tool list changing, an edited CLAUDE.md, ...).

`touch ~/.claude/statusline-debug` to dump the next payload verbatim to
`~/.claude/statusline-debug.json`, which is the only practical way to see what
a given Claude Code version actually hands the status line.
"""

from __future__ import annotations

import json
import os
import subprocess
import sys
import time
from datetime import datetime

DEBUG_TRIGGER = os.path.expanduser("~/.claude/statusline-debug")

# Prompt cache entries expire this long after the request that wrote them, so
# an idle stretch approaching it means the next turn re-uploads the whole
# prefix. Claude Code asks for the 1h tier; it falls back to 5m under usage
# overage, which the payload gives no way to detect.
CACHE_TTL = 3600

RESET = "\033[0m"
DIM = "\033[2m"
BOLD = "\033[1m"
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
BLUE = "\033[34m"
MAGENTA = "\033[35m"
CYAN = "\033[36m"


def paint(text: str, *codes: str) -> str:
    return "".join(codes) + text + RESET


def human(n: float) -> str:
    """Format a token count compactly: 812, 1.4k, 558k, 1.2M."""
    if n < 1000:
        return f"{int(n)}"
    if n < 10_000:
        return f"{n / 1000:.1f}k"
    if n < 1_000_000:
        return f"{n / 1000:.0f}k"
    return f"{n / 1_000_000:.1f}M"


# --- cwd ------------------------------------------------------------------


def _elide(parts: list[str], keep: int = 2) -> str:
    if parts and parts[0] == "":  # absolute path: fold the root into the head
        parts = ["/" + parts[1]] + parts[2:] if len(parts) > 1 else ["/"]
    if len(parts) <= keep + 1:
        return "/".join(parts)
    return "/".join([parts[0], "..."] + parts[-keep:])


def shorten_path(path: str, project_dir: str | None) -> str:
    """Render cwd as `project/sub/dir`, falling back to `~/.../a/b`.

    Sessions started from $HOME report project_dir=$HOME, which would make the
    project-relative form longer than the plain one, hence the guard.
    """
    home = os.path.expanduser("~")
    root = (project_dir or "").rstrip("/")
    if root not in ("", home, "/") and (path == root or path.startswith(root + "/")):
        rest = path[len(root) :].strip("/")
        return _elide([os.path.basename(root)] + (rest.split("/") if rest else []))
    if path == home or path.startswith(home + "/"):
        path = "~" + path[len(home) :]
    return _elide(path.split("/"))


def _git(cwd: str, *args: str) -> str | None:
    try:
        out = subprocess.run(
            ["git", "-C", cwd, *args], capture_output=True, text=True, timeout=1
        )
    except (OSError, subprocess.SubprocessError):
        return None
    return out.stdout.strip() or None if out.returncode == 0 else None


def git_branch(cwd: str) -> str | None:
    branch = _git(cwd, "rev-parse", "--abbrev-ref", "HEAD")
    if branch == "HEAD":  # detached
        return _git(cwd, "rev-parse", "--short", "HEAD")
    return branch


# --- segments -------------------------------------------------------------


def seg_model(data: dict) -> str | None:
    model = data.get("model") or {}
    name = model.get("id") or model.get("display_name")
    if not name:
        return None
    bits = [paint(name, BOLD, MAGENTA)]
    effort = ((data.get("effort") or {}).get("level") or "").strip()
    if effort and effort != "medium":
        bits.append(paint(effort, DIM))
    if data.get("fast_mode"):
        bits.append(paint("fast", YELLOW))
    if (data.get("thinking") or {}).get("enabled"):
        bits.append(paint("think", DIM))
    return " ".join(bits)


def seg_dir(data: dict) -> str | None:
    ws = data.get("workspace") or {}
    cwd = ws.get("current_dir") or data.get("cwd")
    if not cwd:
        return None
    out = paint(shorten_path(cwd, ws.get("project_dir")), CYAN)
    wt = data.get("worktree") or {}
    branch = wt.get("branch") or git_branch(cwd)
    if branch:
        out += " " + paint(f"@{branch}", DIM)
    if wt.get("name"):
        out += " " + paint(f"[wt:{wt['name']}]", YELLOW)
    if (data.get("pr") or {}).get("number"):
        out += " " + paint(f"#{data['pr']['number']}", BLUE)
    return out


def seg_context(data: dict) -> str | None:
    ctx = data.get("context_window") or {}
    used, size = ctx.get("total_input_tokens"), ctx.get("context_window_size")
    if not used or not size:
        return None
    pct = 100.0 * used / size
    color = GREEN if pct < 60 else YELLOW if pct < 85 else RED
    return f"{paint('ctx', DIM)} {paint(human(used), color)}"


def seg_cache(data: dict) -> str | None:
    """Share of this turn's prompt that was served from cache."""
    usage = (data.get("context_window") or {}).get("current_usage") or {}
    read = usage.get("cache_read_input_tokens") or 0
    created = usage.get("cache_creation_input_tokens") or 0
    if read + created <= 0:
        return None
    pct = 100.0 * read / (read + created)
    color = GREEN if pct >= 95 else YELLOW if pct >= 80 else RED
    return f"{paint('cache', DIM)} {paint(f'{pct:.1f}%', color)}"


def last_entry_time(path: str) -> float | None:
    """When the newest transcript entry was written, in epoch seconds.

    Not the file's mtime: Claude Code rewrites the transcript well after the
    last entry was appended, so on an idle session the mtime can run over an
    hour ahead of the newest timestamp inside it. Scan the tail instead,
    widening once in case a single large entry fills the first window.
    """
    try:
        size = os.path.getsize(path)
    except OSError:
        return None
    for window in (65536, 1 << 20):
        try:
            with open(path, "rb") as fh:
                fh.seek(max(0, size - window))
                lines = fh.read().split(b"\n")
        except OSError:
            return None
        if size > window:
            del lines[0]  # partial, its start lies before the window
        for raw in reversed(lines):
            try:
                return datetime.fromisoformat(json.loads(raw)["timestamp"]).timestamp()
            except (ValueError, TypeError, KeyError):
                continue
        if size <= window:
            break
    return None


def seg_idle(data: dict) -> str | None:
    """Age of the newest transcript entry, as a proxy for cache entry age.

    Every request appends to the transcript and refreshes the cache TTL, so
    the newest entry dates the cache entry currently in play.
    """
    path = data.get("transcript_path")
    stamp = last_entry_time(path) if path else None
    if stamp is None:
        return None
    age = time.time() - stamp
    frac = age / CACHE_TTL
    color = DIM if frac < 0.5 else YELLOW if frac < 0.8 else RED
    minutes = int(age // 60)
    text = f"{minutes // 60}h{minutes % 60:02d}m" if minutes >= 60 else f"{minutes}m"
    return f"{paint('idle', DIM)} {paint(text if minutes else '<1m', color)}"


def main() -> None:
    try:
        data = json.load(sys.stdin)
    except (ValueError, OSError):
        data = {}

    if os.path.exists(DEBUG_TRIGGER):
        try:
            with open(DEBUG_TRIGGER + ".json", "w") as fh:
                json.dump(data, fh, indent=2, sort_keys=True)
            os.unlink(DEBUG_TRIGGER)
        except OSError:
            pass

    segments = (
        seg_model(data),
        seg_dir(data),
        seg_context(data),
        seg_cache(data),
        seg_idle(data),
    )
    print(paint(" | ", DIM).join(s for s in segments if s))


if __name__ == "__main__":
    main()
