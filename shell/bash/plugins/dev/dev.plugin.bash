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
local_path="${HOME}/.local"
local_bin_path="${local_path}/bin"  # binaries
local_scr_path="${local_path}/scr"  # scripts

if ! assert_directory_exists "${local_bin_path}"
then
    mkdir -p "${local_bin_path}"
fi
if ! assert_directory_exists "${local_scr_path}"
then
    mkdir -p "${local_scr_path}"
fi

export PATH="${local_bin_path}:$PATH"
export PATH="${local_scr_path}:$PATH"


# Add Bash configuration for each languages plugins are available
source $SH_DIR/plugins/dev/cc.plugin.bash
source $SH_DIR/plugins/dev/java.plugin.bash
source $SH_DIR/plugins/dev/python.plugin.bash
source $SH_DIR/plugins/dev/ruby.plugin.bash
source $SH_DIR/plugins/dev/rust.plugin.bash
