### passwd.plugin.bash ---                          -*- mode: shell-script;  -*-

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

## Adapted from:
## https://blog.sleeplessbeastie.eu/2016/04/11/how-to-generate-random-password-using-command-line/

### Code:


function genpass {
  # Generate ONE single password of length ${1} containing
  #   - uppercase letters
  #   - lowercase letters
  #   - numbers
  #   - symbols

  if assert_pos $1; then
    if assert_command_exists pwgen; then
      echo $(pwgen -cnsy -N 1 $1)
    elif assert_command_exists apg; then
      echo $(apg -m $1 -x 1 -M SNCL -a 1 -n 1);
    else
      echo $(head /dev/urandom | LC_CTYPE=C tr -dc '[:graph:]' | fold -w$1 | sed '$d' | shuf -n1);
    fi
  fi
}



function colpass {
    # Generate a password of length ${1} or 16 by default.
    new_password=$(genpass ${1:-16})

    # Colorize the newly generated password.
    colorized_password=""
    while read -n1 character; do
      case $character in
        [0-9]) colorized_password+="${TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_BLUE}${character}";;
        [a-z]) colorized_password+="${TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_RED}${character}";;
        [A-Z]) colorized_password+="${TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_GREEN}${character}";;
        *)     colorized_password+="${TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_YELLOW}${character}";;
      esac
    done < <(echo -n "${new_password}");

    # Print the password.
    # NOTE: Don't forget to reset the escape sequences to avoid color mess.
    echo -e "${colorized_password}${TEXT_FORMAT_NOESC_RESET}"
}
