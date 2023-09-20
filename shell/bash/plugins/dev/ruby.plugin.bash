### ruby.plugin.bash ---                              -*- mode: shell-script; -*-

## copyright (c) 2021-2023  damienpichard

## author: damienpichard <damienpichard@tutanota.de>
## keywords:

## this program is free software; you can redistribute it and/or modify
## it under the terms of the gnu general public license as published by
## the free software foundation, either version 3 of the license, or
## (at your option) any later version.

## this program is distributed in the hope that it will be useful,
## but without any warranty; without even the implied warranty of
## merchantability or fitness for a particular purpose.  see the
## gnu general public license for more details.

## you should have received a copy of the gnu general public license
## along with this program.  if not, see <http://www.gnu.org/licenses/>.

### commentary:

##

### code:



if assert_eq $SYSTEM macos
then
    # Set PATH to updated ruby executable.
    export PATH="/usr/local/opt/ruby/bin:$PATH"

    # Get the version of the last updated ruby executable and use it to
    # generate the gem PATH.
    ruby_version=$(ruby -v | awk -F ' ' '{print $2}' | sed -r 's/(.*)\..*/\1\.0/')
    export PATH="/usr/local/lib/ruby/gems/${ruby_version}/bin:$PATH"
fi
