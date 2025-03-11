### homebrew.pkgmgr.bash ---                         -*- mode: shell-script; -*-

## Copyright (C) 2021-2025  Damien Pichard

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

if assert_eq $SYSTEM macos; then
    HOMEBREW_BIN_PATH="/opt/homebrew/bin"
    HOMEBREW_SBIN_PATH="/opt/homebrew/sbin"
    HOMEBREW_MAN_PATH="/opt/homebrew/share/man"
    HOMEBREW_CACHE_PATH="${HOME}/Library/Caches/Homebrew"
    HOMEBREW_BIN="${HOMEBREW_BIN_PATH}/brew"

    if assert_file_exists ${HOMEBREW_BIN}; then
        if assert_eq ${MACOS_PACKAGE_MANAGER} homebrew; then
            # Add Homebrew paths to $PATH and $MANPATH
            export PATH="${HOMEBREW_BIN_PATH}:${HOMEBREW_SBIN_PATH}:${PATH}"
            export MANPATH="${HOMEBREW_MAN_PATH}:${MANPATH}"

            # Add some useful shortcuts as aliases
            alias buuc="brew update && brew upgrade && brew cleanup"
            alias brrc="rm -rf ${HOMEBREW_CACHE}"
        elif assert_true ${ENABLE_HOMEBREW_CASK}; then
            alias brew="${HOMEBREW_BIN}"
        fi
    fi
fi
