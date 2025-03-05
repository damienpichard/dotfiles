### macports.pkgmgr.bash ---                         -*- mode: shell-script; -*-

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

if (assert_eq $SYSTEM macos) && (assert_eq $MACOS_PACKAGE_MANAGER macports); then
    MACPORTS_BIN_PATH="/opt/local/bin"
    MACPORTS_SBIN_PATH="/opt/local/sbin"
    MACPORTS_MAN_PATH="/opt/local/share/man"

    if assert_directory_exists "${MACPORTS_BIN_PATH}"; then
        export PATH="${MACPORTS_BIN_PATH}:${MACPORTS_SBIN_PATH}:${PATH}"
        export MANPATH="${MACPORTS_MAN_PATH}:${PATH}"

        function macports {
            case "${1}" in
                    info)    port info ${2} ;;
                f | find)    port search --name --line --regex "${2}" ;;
                r | remove)  sudo port uninstall ${@:2} ;;
                u | update)  sudo port -u upgrade outdated ;;
                i | install) sudo port install ${@:2} ;;
                c | compile) sudo port -s install ${@:2} ;;
                U | upgrade) sudo port selfupdate ;;
                *) print_error "command 'macports ${1}' does not exist" ;;
            esac
        }
    fi
fi
