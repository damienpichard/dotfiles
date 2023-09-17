### clear.theme.bash ---                             -*- mode: shell-script; -*-

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



SH_THEME_PROMPT="➜ "



# HACK: https://github.com/Bash-it/bash-it/blob/master/themes/base.theme.bash
function safe_append_prompt_command {
    local prompt_re

    # Set OS dependent exact match regular expression.
    case $SYSTEM in
        macos) prompt_re="[[:<:]]${1}[[:>:]]" ;; # macOS
        *)     prompt_re="\<${1}\>"           ;; # Linux/FreeBSD/...
    esac

    if expr "${PROMPT_COMMAND[*]:-}" : "${prompt_re}"
    then
      return
    elif assert_string_empty "${PROMPT_COMMAND}"
    then
      PROMPT_COMMAND="${1}"
    else
      PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
    fi
}



function command_prompt {
    result=$?

    if assert_eq $result 0
    then
        PS1="${TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_BLUE}\W${TEXT_FORMAT_NOESC_RESET}\n"
        PS1+="${TEXT_FORMAT_BOLD}${TEXT_FORMAT_FOREGROUND_LIGHT_GREEN}${SH_THEME_PROMPT}${TEXT_FORMAT_NOESC_RESET} "
    else
        PS1="${TEXT_FORMAT_NOESC_FOREGROUND_LIGHT_BLUE}\W${TEXT_FORMAT_NOESC_RESET}\n"
        PS1+="${TEXT_FORMAT_BOLD}${TEXT_FORMAT_FOREGROUND_LIGHT_RED}${SH_THEME_PROMPT}${TEXT_FORMAT_NOESC_RESET} "
    fi
}



safe_append_prompt_command command_prompt
