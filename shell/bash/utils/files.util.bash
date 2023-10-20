### files.util.bash ---                              -*- mode: shell-script; -*-

## Copyright (C) 2020-2023  Damien Pichard

## Author: Damien Pichard <damienpichard@tutanota.de>
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

## This file is all about preserving the OS and files

### Code:



if assert_command_exists grm
then
   # Use GNU/CoreUtils `rm' by default`
   # rm {
   #     Ask for risky actions
   #     Preserve root on any device
   #     Delete recursively
   #     Delete empty directory
   # }
   alias rm="grm -I --preserve-root=all --recursive --dir"
fi

if assert_command_exists gmv
then
   # Use GNU/CoreUtils `rm' by default`
   # mv {
   #     Preserve files
   #     Move only new files
   # }
   alias mv="gmv --no-clobber --update"
fi

if assert_command_exists gcp
then
   # Use GNU/CoreUtils `cp' by default`
   # cp {
   #     Preserve files
   #     Move files recursively
   # }
   alias cp="gcp --no-clobber --recursive"
fi

if assert_command_exists gchown
then
   # Use GNU/CoreUtils `chown' by default`
   # chown {
   #     Preserve files
   # }
   alias chown="gchown --preserve-root"
fi

if assert_command_exists gchmod
then
   # Use GNU/CoreUtils `chmod' by default`
   # chmod {
   #     Preserve files
   # }
   alias chmod="gchmod --preserve-root"
fi

if assert_command_exists gchgrp
then
   # Use GNU/CoreUtils `chgrp' by default`
   # chgrp {
   #     Preserve files
   # }
   alias chgrp="gchgrp --preserve-root"
fi
