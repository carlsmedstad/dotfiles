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

DEBUG_TRIGGER = os.path.expanduser("~/.claude/statusline-debug")

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
    return f"{paint('ctx', DIM)} {paint(f'{human(used)}/{human(size)}', color)}"


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

    segments = (seg_model(data), seg_dir(data), seg_context(data), seg_cache(data))
    print(paint(" | ", DIM).join(s for s in segments if s))


if __name__ == "__main__":
    main()
