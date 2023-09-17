### bootstrap.sh ---                                -*- mode: shell-script;  -*-

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

#  This project has as goal to be the lightest GNU/bash configuration.
#  For that purpose, we externalize as many as possible scripts and
#  plugins as independant pieces of softwares
#  (may they be dash/python/ruby/etc scripts
#       or      c/c++/haskell/go/rust/etc compiled softwares).

### Code:



# Stop here when executing non-interactive scripts.
# Continue in any GNU/Bash shell.
case $- in
  *i*) ;;
    *) return;;
esac



# For now, let's continue to use distant libraries since we do not relaunch
# shells 100 times per day.
# NOTE: However, be ready to move these to local if it causes to much problems.
source /dev/stdin <<<"$(curl -sLJ https://gist.githubusercontent.com/damienpichard/ebb22985000ec8e08c3296483f38229d/raw/assert.sh)"
source /dev/stdin <<<"$(curl -sLJ https://gist.githubusercontent.com/damienpichard/fc1f226f23c7a5a8afecbdaa4b94c5c5/raw/colors.sh)"
source /dev/stdin <<<"$(curl -sLJ https://gist.githubusercontent.com/damienpichard/5b7222651145769c8dc1f45111c7af8f/raw/helpers.sh)"



# HACK: https://unix.stackexchange.com/a/285928
# Check if GNU/Bash version is >= $BASH_MINIMUM_VERSION.
if assert_string_neq "$(printf '%s\n' "${BASH_MINIMUM_VERSION}" "${BASH_VERSION}" | sort -V | head -n1)" "${BASH_MINIMUM_VERSION}"
then
    print_error "your are currently using GNU/Bash ${BASH_VERSION%.*}."
    print_error "unfortunately, this dotfile configuration requires GNU/Bash $BASH_MINIMUM_VERSION or above."
    print_error "consider to update GNU/Bash before using this configuration."
    return 1
fi



# Check if plugins exist and load them.
# NOTE: This configuration tends to rely on and invite the user to create his
#       own external tools.  Therefore, there will be not much plugins.
for plugin in ${SH_PLUGINS[*]}
do
    if assert_file_exists "$SH_DIR/custom/plugins/${plugin}/${plugin}.plugin.bash"
    then
        source "$SH_DIR/custom/plugins/${plugin}/${plugin}.plugin.bash"
    elif assert_file_exists "$SH_DIR/plugins/${plugin}/${plugin}.plugin.bash"
    then
        source "$SH_DIR/plugins/${plugin}/${plugin}.plugin.bash"
    else
        print_warning "no such plugin: '${plugin}'"
    fi
done



# Load all the *.bash configuration file in utils/
for util in $SH_DIR/utils/*.util.bash
do
    if assert_file_exists "${util}"
    then
        source "${util}"
    fi
done
