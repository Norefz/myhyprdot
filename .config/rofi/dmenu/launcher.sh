#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
##Modder:norefz
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/dmenu"
theme='style-1'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
