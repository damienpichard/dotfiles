### passwd.plugin.bash ---                          -*- mode: shell-script;  -*-

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

## Adapted from:
## https://blog.sleeplessbeastie.eu/2016/04/11/how-to-generate-random-password-using-command-line/

### Code:


function generate_password {
    # Use `pwgen' or `apg' as default for better password generation.
    if assert_string_not_empty "$1" && assert_geq "$1" 0
    then
        if command_exists pwgen
        then
            # Generate ONE password containing upper and lowercase letters, numbers and symbols.
            password=$(pwgen -cnsy -N 1 $1)
        elif command_exists apg
        then
            password=$(apg -m $1 -x 1 -M SNCL -a 1 -n 1);
        else
            password=$(head /dev/urandom | LC_CTYPE=C tr -dc '[:graph:]' | fold -w$1 | sed '$d' | shuf -n1);
        fi
    fi

    echo $password
}



function colorize_password {
    # Generate and colorize a password of length ${1} or 16 by default.
    while read -n1 character
    do
      case $character in
        [0-9]) printf "$TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_BLUE%s$TEXT_FORMAT_NOESC_RESET"   "${character}"  ;;
        [a-z]) printf "$TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_RED%s$TEXT_FORMAT_NOESC_RESET"    "${character}"  ;;
        [A-Z]) printf "$TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_GREEN%s$TEXT_FORMAT_NOESC_RESET"  "${character}"  ;;
        *)     printf "$TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_YELLOW%s$TEXT_FORMAT_NOESC_RESET" "${character}"  ;;
      esac
    done < <(echo -n "$(generate_password ${1:-16})");
    echo;
}



alias passgen=colorize_password
