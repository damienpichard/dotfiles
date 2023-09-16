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


BLUE="$TEXT_FORMAT_FOREGROUND_LIGHT_BLUE"
GRAY="$TEXT_FORMAT_FOREGROUND_DARK_GRAY"
RESET="$TEXT_FORMAT_RESET"

BOLD_CYAN="$TEXT_FORMAT_BOLD$TEXT_FORMAT_FOREGROUND_LIGHT_CYAN"
BOLD_MAGENTA="$TEXT_FORMAT_BOLD$TEXT_FORMAT_FOREGROUND_LIGHT_MAGENTA"
BOLD_GREEN="$TEXT_FORMAT_BOLD$TEXT_FORMAT_FOREGROUND_LIGHT_GREEN"
BOLD_RED="$TEXT_FORMAT_BOLD$TEXT_FORMAT_FOREGROUND_LIGHT_RED"

SH_THEME_PROMPT="➜ "


# https://github.com/Bash-it/bash-it/blob/master/themes/base.theme.bash
function safe_append_prompt_command {
    local prompt_re

    # Set OS dependent exact match regular expression.
    case "${OSTYPE}" in
        darwin*) prompt_re="[[:<:]]${1}[[:>:]]" ;; # macOS
        *)       prompt_re="\<${1}\>"           ;; # Linux/FreeBSD/...
    esac

    if [[ ${PROMPT_COMMAND[*]:-} =~ ${prompt_re} ]]
    then
      return
    elif [[ -z ${PROMPT_COMMAND} ]]
    then
      PROMPT_COMMAND="${1}"
    else
      PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
    fi
}


function command_prompt {

    # Store $? result before it get overrided by our functions
    result=$?

    PS1="$BLUE\W$RESET\n"

    (( $result == 0 )) && PS1+="$BOLD_GREEN$SH_THEME_PROMPT" \
                       || PS1+="$BOLD_RED$SH_THEME_PROMPT"
    PS1+="$RESET"

}


safe_append_prompt_command command_prompt
