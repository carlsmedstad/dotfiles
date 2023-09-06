from typing import List, Optional

from kittens.tui.handler import result_handler

from kitty.boss import Boss


def main(args: List[str]) -> None:
    pass


@result_handler(no_ui=True)
def handle_result(
    args: List[str], data: Optional[str], target_window_id: int, boss: Boss
) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is None:
        return
    if not w.screen.is_main_linebuf() and w.title == "History":
        return w.send_text("all", b"yq")
    return w.show_scrollback()
