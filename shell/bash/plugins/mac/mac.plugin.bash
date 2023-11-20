### mac.plugin.bash ---                              -*- mode: shell-script; -*-

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



if assert_eq $SYSTEM macos
then
    # Add Homebrew paths to $PATH and $MANPATH
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    export MANPATH="$MANPATH:/usr/local/share/man"

    ICLOUD_PATH="${HOME}/Library/Library/Mobile Documents/com~apple~CloudDocs/"

    if assert_command_exists brew
    then
        # Add some useful shortcuts as aliases
        alias buuc="brew update && brew upgrade && brew cleanup"
        alias brrc="rm -rf ~/Library/Caches/Homebrew/"
    fi


    if assert_directory_exists "/Applications/Xcode.app/"
    then
       # Add XCode toolchain manuals path to $MANPATH
       export MANPATH="$MANPATH:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man"
    fi


    # Add MacTeX utilities to $PATH when installed
    if assert_directory_exists "/Library/TeX/"
    then
        export PATH="$PATH:/Library/TeX/texbin"
    fi

    alias icloudclear="find ${ICLOUD_PATH} -type f -exec brctl evict {} \;"
fi
