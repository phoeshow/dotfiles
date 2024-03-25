import os
import subprocess
from datetime import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)


def _get_os() -> str:
    os_name = os.uname().sysname
    if os_name == "Linux":
        return "Linux"
    if os_name == 'Darwin':
        return "Mac"
    return "Other"


opts = get_options()
icon_fg = as_rgb(color_as_int(opts.color2))
icon_bg = as_rgb(color_as_int(opts.color0))
clock_color = as_rgb(color_as_int(opts.color2))
date_color = as_rgb(color_as_int(opts.color4))
SEPARATOR_SYMBOL, SOFT_SEPARATOR_SYMBOL = ("", "")
RIGHT_MARGIN = 1
REFRESH_TIME = 60
ICON = " 󰌪 "
BATTERY_ICON = {
    10: "󰁺 ",
    20: "󰁻 ",
    30: "󰁼 ",
    40: "󰁽 ",
    50: "󰁾 ",
    60: "󰁿 ",
    70: "󰂀 ",
    80: "󰂁 ",
    90: "󰂂 ",
    100: "󰁹 ",
}
BATTERY_COLOR = {
    20: as_rgb(color_as_int(opts.color1)),
    21: as_rgb(color_as_int(opts.color3)),
    70: as_rgb(color_as_int(opts.color3)),
    71: as_rgb(color_as_int(opts.color2)),
    100: as_rgb(color_as_int(opts.color2)),
}


def _draw_icon(screen: Screen, index: int) -> int:
    if index != 1:
        return 0
    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = icon_fg
    screen.cursor.bg = icon_bg
    screen.draw(ICON)
    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(ICON)
    return screen.cursor.x


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    if screen.cursor.x >= screen.columns - right_status_length:
        return screen.cursor.x
    tab_bg = screen.cursor.bg
    tab_fg = screen.cursor.fg
    default_bg = as_rgb(int(draw_data.default_bg))
    if extra_data.next_tab:
        next_tab_bg = as_rgb(draw_data.tab_bg(extra_data.next_tab))
        needs_soft_separator = next_tab_bg == tab_bg
    else:
        next_tab_bg = default_bg
        needs_soft_separator = False
    if screen.cursor.x <= len(ICON):
        screen.cursor.x = len(ICON)
    screen.draw(" ")
    screen.cursor.bg = tab_bg
    draw_title(draw_data, screen, tab, index)
    if not needs_soft_separator:
        screen.draw(" ")
        screen.cursor.fg = tab_bg
        screen.cursor.bg = next_tab_bg
        screen.draw(SEPARATOR_SYMBOL)
    else:
        prev_fg = screen.cursor.fg
        if tab_bg == tab_fg:
            screen.cursor.fg = default_bg
        elif tab_bg != default_bg:
            c1 = draw_data.inactive_bg.contrast(draw_data.default_bg)
            c2 = draw_data.inactive_bg.contrast(draw_data.inactive_fg)
            if c1 < c2:
                screen.cursor.fg = default_bg
        screen.draw(" " + SOFT_SEPARATOR_SYMBOL)
        screen.cursor.fg = prev_fg
    end = screen.cursor.x
    return end


def _draw_right_status(screen: Screen, is_last: bool, cells: list) -> int:
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.x = screen.columns - right_status_length
    screen.cursor.fg = 0
    for color, status in cells:
        screen.cursor.fg = color
        screen.draw(status)
    screen.cursor.bg = 0
    return screen.cursor.x


def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


def get_battery_cells() -> list:
    try:
        current_os = _get_os()
        percent = 0

        if current_os == 'Mac':
            result = subprocess.run(
                ["pmset", "-g", "batt"], capture_output=True, text=True)
            output = result.stdout

            # 解析输出获取电池百分比
            # -InternalBattery-0 (id=6750307)	92%; discharging; (no estimate) present: true
            for line in output.splitlines():
                if "InternalBattery" in line:
                    battery_info = line.split("\t")
                    percent = int(battery_info[1].split(';')[0].strip("%"))

        elif current_os == 'Linux':
            with open("/sys/class/power_supply/BAT0/capacity", "r") as f:
                percent = int(f.read())

        icon_color = BATTERY_COLOR[
            min(BATTERY_COLOR.keys(), key=lambda x: abs(x - percent))
        ]
        icon = BATTERY_ICON[
            min(BATTERY_ICON.keys(), key=lambda x: abs(x - percent))
        ]
        percent_cell = (icon_color, str(percent) + "%")
        icon_cell = (icon_color, icon)
        return [icon_cell, percent_cell]
    except:
        return []


timer_id = None
right_status_length = -1


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id
    global right_status_length
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)
    clock = datetime.now().strftime(" %H:%M")
    date = datetime.now().strftime(" %Y-%m-%d")
    cells = get_battery_cells()
    cells.append((clock_color, clock))
    cells.append((date_color, date))
    right_status_length = RIGHT_MARGIN
    for cell in cells:
        right_status_length += len(str(cell[1]))

    _draw_icon(screen, index)
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
        cells,
    )
    return screen.cursor.x
