### appearance.util.bash ---                         -*- mode: shell-script; -*-

## Copyright (C) 2021-2025 Damien Pichard

## Author: damienpichard <damienpichard@tuta.com>
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

#

### Code:

if assert_true ${ENABLE_LS_COLORS}; then
    # Enable colors in `ls' output
    export LSCOLORS="ExFxBxDxCxegedabagacad"

    case $SYSTEM in
        macos)
            # On macOS, `eza` or `gls` (from `coreutils`) require loading the
            # `pkgsrc` plugin before running this script.
            if assert_command_exists eza; then
                alias ls="eza      --color=auto --icons --group-directories-first"
                alias la="eza -ahl --color=auto --icons --group-directories-first"
            elif assert_command_exists gls; then
                alias ls='gls -GhvX --group-directories-first --color=tty'
            else
                alias ls='ls -G'
            fi
            ;;

        linux)
            # On GNU/Linux, `gls` (from `coreutils`) should be installed and
            # will be default if `eza` isn’t.
            if assert_command_exists eza; then
                alias ls="eza      --color=auto --icons --group-directories-first"
                alias la="eza -ahl --color=auto --icons --group-directories-first"
            else
                alias ls='ls --color=tty'
            fi
            ;;

        freebsd)
            # On FreeBSD, `eza` or `gls` (from `coreutils`) require installation.
            if assert_command_exists eza; then
                alias ls="eza      --color=auto --icons --group-directories-first"
                alias la="eza -ahl --color=auto --icons --group-directories-first"
            elif assert_command_exists gls; then
                alias ls='gls -GhvX --group-directories-first --color=tty'
            else
                alias ls='ls -G'
            fi
            ;;

        netbsd)
            # On NetBSD, `eza` or `gls` (from `coreutils`) require installation.
            # Otherwise, don’t change anything since NetBSD `ls` lacks color support.
            if assert_command_exists eza; then
                alias ls="eza      --color=auto --icons --group-directories-first"
                alias la="eza -ahl --color=auto --icons --group-directories-first"
            elif assert_command_exists gls; then
                alias ls='gls -GhvX --group-directories-first --color=tty'
            fi
            ;;

        openbsd)
            # On OpenBSD, `eza` or `gls` (from `coreutils`) require installation.
            # Otherwise, `colorls`, which supports colors and multibyte support, will be used.
            if assert_command_exists eza; then
                alias ls="eza      --color=auto --icons --group-directories-first"
                alias la="eza -ahl --color=auto --icons --group-directories-first"
            elif assert_command_exists gls; then
                alias ls='gls -GhvX --group-directories-first --color=tty'
            elif assert_command_exists colorls; then
                alias ls='colorls -G'
            fi
            ;;
    esac
fi

if assert_true ${ENABLE_GREP_COLORS}; then
    # Enable colors in `grep`’s output.
    export GREP_COLORS='ms=01;31:mc=01;32:sl=:cx=:fn=35:ln=32:bn=32:se=36'

    # use `ripgrep` or `ggrep` as default when instaled.
    if assert_command_exists rg; then
        alias grep="rg"
    elif assert_command_exists ggrep; then
        alias grep='ggrep --color=always'
    else
        alias grep='grep --color=always'
    fi
fi
