### emacs.plugin.bash ---                             -*- mode: shell-script; -*-

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



DOOM_EMACS_PATH="${HOME}/.config/emacs/bin"
DOOM_EMACS_EXEC="${DOOM_EMACS_PATH}/doom"





if assert_eq $SYSTEM macos
then
    export PATH="/Applications/Emacs/Contents/MacOS/:$PATH"
fi



if assert_file_exists $DOOM_EMACS_EXEC
then
    export PATH="$PATH:${DOOM_EMACS_PATH}"
fi
