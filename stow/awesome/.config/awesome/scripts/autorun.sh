#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run volumeicon
run blueman-applet
run nm-applet
# run picom
