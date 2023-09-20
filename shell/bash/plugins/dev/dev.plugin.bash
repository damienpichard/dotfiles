### dev.plugin.bash ---                              -*- mode: shell-script; -*-

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




# Add linked directory for personnal projects to PATH
export PATH="${HOME}/.local/bin:$PATH"
export PATH="${HOME}/.local/scripts:$PATH"


# Add Bash configuration for each languages plugins are available
source $SH_DIR/plugins/dev/cc.plugin.bash
source $SH_DIR/plugins/dev/java.plugin.bash
source $SH_DIR/plugins/dev/python.plugin.bash
source $SH_DIR/plugins/dev/ruby.plugin.bash
source $SH_DIR/plugins/dev/rust.plugin.bash
