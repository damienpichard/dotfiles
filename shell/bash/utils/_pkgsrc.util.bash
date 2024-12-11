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
  PKGSRC_MAN_PATH="${PKGSRC_PATH}/man"

  # Add `pkgsrc'  paths to ${PATH} and ${MANPATH}
  export PATH="${PKGSRC_BIN_PATH}:${PATH}"
  export MANPATH="${PKGSRC_MAN_PATH}:${PATH}"

  # Add a shortcut to find new packages to install.
  alias pkg_find="find ${PKGSRC_PATH} -type directory -not -path \"*/work/*\" -name"


  function pkg_src {
    if assert_directory_exists "${PKGSRC_PATH}/$2"
    then
      cd "${PKGSRC_PATH}/$2"
    else
      print_error "no such file or directory: ${PKGSRC_PATH}/$2"
      return
    fi

    case "$1" in
      install|i) bmake install clean clean-depends distclean ;;
      update|u)  bmake update clean clean-depends distclean ;;
    esac
  }
fi
