### man.plugin.bash ---                              -*- mode: shell-script; -*-

## Copyright (C) 2021-2023  damienpichard

## Author: damienpichard <damienpichard@tutanota.de>
## Keywords:

## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

### Commentary:

##

### Code:

export MANPATH="/usr/local/pkg/man:$MANPATH"


alias man=colorize-man-pages
function colorize-man-pages {
    env \
        LESS_TERMCAP_mb=$(printf $TEXT_FORMAT_NOESC_BOLD$TEXT_FORMAT_NOESC_FOREGROUND_BLUE) \
        LESS_TERMCAP_md=$(printf $TEXT_FORMAT_NOESC_FOREGROUND_BLUE) \
        LESS_TERMCAP_me=$(printf $TEXT_FORMAT_NOESC_RESET) \
        LESS_TERMCAP_se=$(printf $TEXT_FORMAT_NOESC_RESET) \
        LESS_TERMCAP_so=$(printf $TEXT_FORMAT_NOESC_BACKGROUND_LIGHT_GRAY$TEXT_FORMAT_NOESC_FOREGROUND_BLACK) \
        LESS_TERMCAP_ue=$(printf $TEXT_FORMAT_NOESC_RESET) \
        LESS_TERMCAP_us=$(printf $TEXT_FORMAT_NOESC_BOLD$TEXT_FORMAT_NOESC_FOREGROUND_RED) \
        PAGER="less" \
        _NROFF_U=1 \
        man "$@"
}
