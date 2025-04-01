### bootstrap.sh ---                                -*- mode: shell-script;  -*-

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

## This project aims to create the lightest GNU/bash configuration by
## externalizing scripts and plugins to independent softwares.

### Code:

# Stop executing non-interactive scripts.
# Continue in any GNU/Bash shell.
case $- in
    *i*) ;;
    *) return ;;
esac

# Let’s continue using distant libraries for the time being,
# but switch to local libraries if they cause substantial issues.
source /dev/stdin <<< "$(curl -sLJ https://gist.githubusercontent.com/damienpichard/714cbe584353ba98b4cf52cef999e794/raw/assert.sh)"
source /dev/stdin <<< "$(curl -sLJ https://gist.githubusercontent.com/damienpichard/fc1f226f23c7a5a8afecbdaa4b94c5c5/raw/colors.sh)"
source /dev/stdin <<< "$(curl -sLJ https://gist.githubusercontent.com/damienpichard/5b7222651145769c8dc1f45111c7af8f/raw/helpers.sh)"

# Check if GNU/Bash version is >= ${BASH_MINIMUM_VERSION}.
if assert_bash_minimum_version_eq "${BASH_MINIMUM_VERSION}"; then
    print_error "your are currently using GNU/Bash ${BASH_VERSION%.*}"
    print_error "unfortunately, this dotfile configuration requires GNU/Bash $BASH_MINIMUM_VERSION or above"
    print_error "consider to update GNU/Bash before using this configuration"
    return 1
fi

# Load package managers.
for pkgmgr in ${SH_DIR}/pkgmgr/*.pkgmgr.bash; do
    if assert_file_exists "${pkgmgr}"; then
        source "${pkgmgr}"
    fi
done

# Check for and load available plugins.
# NOTE: This configuration heavily relies on users creating their own external tools.
#       To make this possible, we allow users to load — at their own risks — plugins
#       from GitHub.
#       Plugins then need to be specified as `github_account/plugin_name`.
for plugin in ${SH_PLUGINS[*]}; do
    if assert_file_exists "${SH_DIR}/custom/plugins/${plugin}/${plugin}.plugin.bash"; then
        source "${SH_DIR}/custom/plugins/${plugin}/${plugin}.plugin.bash"
    elif assert_file_exists "${SH_DIR}/plugins/${plugin}/${plugin}.plugin.bash"; then
        source "${SH_DIR}/plugins/${plugin}/${plugin}.plugin.bash"
    else
      plugin_name=$(echo ${plugin} | cut -f 2 -d '/')
      plugin_home=$(printf "https://github.com/%s" ${plugin})
      plugin_link=$(printf "https://github.com/%s.git" ${plugin})

      # Check if URL exists
      if $(curl --fail ${plugin_home} &>/dev/null); then
        git clone ${plugin_link} ${SH_DIR}/custom/plugins/${plugin_name}

        if assert_file_exists ${SH_DIR}/custom/plugins/${plugin_name}/${plugin_name}.plugin.bash; then
          source ${SH_DIR}/custom/plugins/${plugin_name}/${plugin_name}.plugin.bash
        else
          print_warning "unsupported plugin: '${plugin}'"
          rm -rf ${SH_DIR}/custom/plugins/${plugin_name}
        fi
      else
        print_warning "no such plugin: '${plugin}'"
      fi
    fi
done

# Load all the *.bash configuration file in utils/
for util in ${SH_DIR}/utils/*.util.bash; do
    if assert_file_exists "${util}"; then
        source "${util}"
    fi
done
