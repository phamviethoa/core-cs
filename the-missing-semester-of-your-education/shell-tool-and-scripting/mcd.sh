#!/usr/bin/zsh

mcd () {
  # $1 is the first argument of the mcd function
  mkdir -p "$1"
  cd "$1"
}
