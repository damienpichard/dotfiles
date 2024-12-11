### pkgsrc.util.bash ---                             -*- mode: shell-script; -*-

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

# Let's use `pkgsrc' as default package manager for multi-OS support.

### Code:


# `pkgsrc' can be install with the following command
#   $  dotfiles install pkgmng/pkgsrc
# the installer will take care of everything and successfully
#   install `pkgsrc' for you.
PKGSRC_PATH="${HOME}/.config/pkgsrc"


if assert_directory_exists "${PKGSRC_PATH}"; then
  PKGSRC_BIN_PATH="${PKGSRC_PATH}/bin"
  PKGSRC_SBIN_PATH="${PKGSRC_PATH}/sbin"
  PKGSRC_MAN_PATH="${PKGSRC_PATH}/man"

  # Add `pkgsrc'  paths to ${PATH} and ${MANPATH}
  export PATH="${PKGSRC_SBIN_PATH}:${PKGSRC_BIN_PATH}:${PATH}"
  export MANPATH="${PKGSRC_MAN_PATH}:${PATH}"

  # Set `pkgsrc' path to ${PKGSRCDIR} for `pkg_rolling-update'
  export PKGSRCDIR="${PKGSRC_PATH}"

  # A general purpose function for `pkgsrc'
  function pkgsrc {
    function pkgsrc_install {
      PKG_PATH="${PKGSRC_PATH}/${1}"
      if assert_directory_exists "${PKG_PATH}"; then
        bmake -C "${PKG_PATH}" install clean clean-depends distclean
      else
        print_error "no such file or directory: ${PKG_PATH}"
      fi
    }

    function pkgsrc_update {
      PKG_PATH="${PKGSRC_PATH}/${1}"
      if assert_directory_exists "${PKG_PATH}"; then
        bmake -C "${PKG_PATH}" update clean clean-depends distclean
      else
        print_error "no such file or directory: ${PKG_PATH}"
      fi
    }

    function pkgsrc_remove {
      PKG_PATH="${PKGSRC_PATH}/${1}"
      if assert_directory_exists "${PKG_PATH}"; then
        bmake -C "${PKG_PATH}" deinstall clean clean-depends distclean
      else
        print_error "no such file or directory: ${PKG_PATH}"
      fi
    }

    case "$1" in
      install|i) pkgsrc_install "$2" ;;
      update|u)  pkgsrc_update  "$2" ;;
      remove|r)  pkgsrc_remove  "$2" ;;
      upgrade|U) git -C "${PKGSRC_PATH}" fetch -p ;;
      find|f)    find ${PKGSRC_PATH} -type directory -not -path "*/work/*" -name "$2" ;;
    esac
  }
fi
