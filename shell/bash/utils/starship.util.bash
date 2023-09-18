### starship.util.bash ---                            -*- mode: shell-script; -*-

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



# Use `starship` as default shell prompt when installed.
# When `starship` is not installed, use the ultra-simple `clear` theme.
# NOTE: One can find startship configuration in `terminal/shartship`
#       and install it with `dotfiles install terminal/starship`.
if assert_true ${ENABLE_STARSHIP_PROMPT} && assert_command_exists starship
then
    eval "$(starship init bash)"
else
    source $SH_DIR/themes/clear.theme.bash
fi
