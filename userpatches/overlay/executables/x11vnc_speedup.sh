#!/bin/sh

sleep 10
xfconf-query -c xfwm4 -p /general/vblank_mode -s off
xfconf-query -c xfwm4 -p /general/use_compositing -s false
