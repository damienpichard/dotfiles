### mac.plugin.bash ---                              -*- mode: shell-script; -*-

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

##

### Code:

if assert_eq $SYSTEM macos; then
    XCODE_PATH="/Applications/Xcode.app"
    if assert_directory_exists ${XCODE_PATH}; then
        # Add XCode toolchain manuals path to $MANPATH
        export MANPATH="${XCODE_PATH}/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:${MANPATH}"
    fi

    COMMANDLINE_TOOLS_PATH="/Library/Developer/CommandLineTools/usr/bin"
    if assert_directory_exists ${COMMANDLINE_TOOLS_PATH}; then
        export PATH="${COMMANDLINE_TOOLS_PATH}:${PATH}"
    fi

    TEX_PATH="Library/TeX/texbin"
    if assert_directory_exists ${TEX_PATH}; then
        # Add MacTeX utilities to $PATH when installed
        export PATH="${TEX_PATH}:${PATH}"
    fi

    ICLOUD_PATH="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/"
    if assert_directory_exists ${ICLOUD_PATH}; then
        # Remove / clear iCloud downloads to get more local space without deleting files.
        alias icloudclear="find '${ICLOUD_PATH}' -type f -exec brctl evict {} \;"
    fi

    function copyfonts {
        cp -rf "${HOME}/.config/pkgsrc/share/fonts/X11/TTF/" "${HOME}/Library/Fonts/"
    }

    function set_hostname {
        sudo scutil --set HostName "${1}"
        sudo scutil --set LocalHostName "${1}"
        sudo scutil --set ComputerName "${1}"
        dscacheutil -flushcache
    }
fi
