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



# Set ${PATH} to `rustup' when installed.
if assert_command_exists rustup; then
  export PATH="/opt/homebrew/opt/rustup/bin:${PATH}"
fi

# Set ${PATH} to `cargo' when installed.
if assert_command_exists cargo; then
  export PATH="${HOME}/.cargo/bin/:${PATH}"
fi

alias rc="rustc -O"
alias rd="rustc -g"
