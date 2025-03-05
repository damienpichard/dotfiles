### pkgsrc.pkgmgr.bash ---                           -*- mode: shell-script; -*-

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

# The command
#     $ dotfiles install pkgmng/pkgsrc
# will install `pkgsrc` for you.
PKGSRC_PATH="${HOME}/.config/pkgsrc"

if (assert_eq $SYSTEM macos) && (assert_eq $MACOS_PACKAGE_MANAGER pkgsrc); then
    PKGSRC_BIN_PATH="${PKGSRC_PATH}/bin"
    PKGSRC_SBIN_PATH="${PKGSRC_PATH}/sbin"
    PKGSRC_MAN_PATH="${PKGSRC_PATH}/man"

    # Add `pkgsrc' paths to ${PATH} and ${MANPATH}
    export PATH="${PKGSRC_SBIN_PATH}:${PKGSRC_BIN_PATH}:${PATH}"
    export MANPATH="${PKGSRC_MAN_PATH}:${PATH}"

    # Set `pkgsrc' path to ${PKGSRCDIR} for `pkg_rolling-update'
    export PKGSRCDIR="${PKGSRC_PATH}"

    # A general purpose function for `pkgsrc'
    function pkgsrc {
        PKG_PATH="${PKGSRC_PATH}/${2}"

        function pkgsrc_install {
            if assert_directory_exists "${PKG_PATH}"; then
                bmake -C "${PKG_PATH}" install clean clean-depends distclean
            else
                print_error "no such file or directory: ${PKG_PATH}"
            fi
        }

        function pkgsrc_update {
            if assert_directory_exists "${PKG_PATH}"; then
                bmake -C "${PKG_PATH}" update clean clean-depends distclean
            else
                print_error "no such file or directory: ${PKG_PATH}"
            fi
        }

        function pkgsrc_remove {
            if assert_directory_exists "${PKG_PATH}"; then
                bmake -C "${PKG_PATH}" deinstall clean clean-depends distclean
            else
                print_error "no such file or directory: ${PKG_PATH}"
            fi
        }

        function pkgsrc_upgrade {
            git -C "${PKGSRC_PATH}" fetch -p
        }

        function pkgsrc_find {
            find ${PKGSRC_PATH} -type directory -not -path "*/work/*" -name "${1}"
        }

        case "$1" in
            f | find)    pkgsrc_find    "${2}" ;;
            u | update)  pkgsrc_update  "${2}" ;;
            r | remove)  pkgsrc_remove  "${2}" ;;
            i | install) pkgsrc_install "${2}" ;;
            U | upgrade) pkgsrc_upgrade "${2}" ;;
            *) print_error "command 'pkgsrc ${1}' does not exist" ;;
        esac
    }
fi
