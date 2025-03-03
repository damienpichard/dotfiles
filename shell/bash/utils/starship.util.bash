### starship.util.bash ---                            -*- mode: shell-script; -*-

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

# When installed, use `starship` as the default shell prompt.
# When not installed, use the extremely simple `clear` theme.

# NOTE: One can find the startup configuration for the terminal in
# the directory `terminal/shartship`.
if assert_true ${ENABLE_STARSHIP_PROMPT} && assert_command_exists starship; then
    eval "$(starship init bash)"
else
    source $SH_DIR/themes/clear.theme.bash
fi
