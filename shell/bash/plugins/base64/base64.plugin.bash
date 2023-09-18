### base64.plugin.bash ---                          -*- mode: shell-script;  -*-

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




function encode64 {
    if assert_null ${#}
    then
        cat | base64
    else
        printf '%s' ${1} | base64
    fi
}



decode64() {
    if assert_null ${#}
    then
        cat | base64 --decode
    else
        printf '%s' ${1} | base64 --decode
    fi
}
