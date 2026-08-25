#!/usr/bin/env python3
"""Claude Code sub-agent status rows.

Runs as `subagentStatusLine`: reads `{"tasks": [...], "columns": N, ...}` on
stdin and prints one `{"id": ..., "content": ...}` JSON line per task, which
replaces that agent's row in the agent panel. Each task carries its own
`model`, `effort`, `contextWindowSize` and `tokenCount`, which is the only
place Claude Code exposes a sub-agent's model: the main status line payload
always reports the main loop model, even while a sub-agent is focused.

`touch ~/.claude/subagent-statusline-debug` to dump the next payload to
`~/.claude/subagent-statusline-debug.json`.
"""

from __future__ import annotations

import json
import os
import sys
import time

DEBUG_TRIGGER = os.path.expanduser("~/.claude/subagent-statusline-debug")

RESET = "\033[0m"
DIM = "\033[2m"
BOLD = "\033[1m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
RED = "\033[31m"
MAGENTA = "\033[35m"


def paint(text: str, *codes: str) -> str:
    return "".join(codes) + text + RESET


def human(n: float) -> str:
    if n < 1000:
        return f"{int(n)}"
    if n < 10_000:
        return f"{n / 1000:.1f}k"
    if n < 1_000_000:
        return f"{n / 1000:.0f}k"
    return f"{n / 1_000_000:.1f}M"


def elapsed(start_ms: float | None) -> str | None:
    if not start_ms:
        return None
    secs = int(time.time() - start_ms / 1000)
    if secs < 60:
        return f"{secs}s"
    return f"{secs // 60}m{secs % 60:02d}s"


def row(task: dict) -> str:
    bits = []
    label = task.get("name") or task.get("label") or task.get("description") or ""
    if label:
        bits.append(label)
    if task.get("model"):
        model = paint(task["model"], BOLD, MAGENTA)
        effort = (task.get("effort") or "").strip()
        if effort and effort != "medium":
            model += " " + paint(effort, DIM)
        bits.append(model)
    used, size = task.get("tokenCount") or 0, task.get("contextWindowSize")
    if used and size:
        pct = 100.0 * used / size
        color = GREEN if pct < 60 else YELLOW if pct < 85 else RED
        bits.append(f"{paint('ctx', DIM)} {paint(human(used), color)}")
    age = elapsed(task.get("startTime"))
    if age:
        bits.append(paint(age, DIM))
    return paint(" | ", DIM).join(bits)


def main() -> None:
    try:
        data = json.load(sys.stdin)
    except (ValueError, OSError):
        return
    if os.path.exists(DEBUG_TRIGGER):
        try:
            with open(DEBUG_TRIGGER + ".json", "w") as fh:
                json.dump(data, fh, indent=2, sort_keys=True)
            os.unlink(DEBUG_TRIGGER)
        except OSError:
            pass
    for task in data.get("tasks") or []:
        if not task.get("id"):
            continue
        print(json.dumps({"id": task["id"], "content": row(task)}))


if __name__ == "__main__":
    main()
