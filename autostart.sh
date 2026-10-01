#!/usr/bin/env bash

pgrep dunst || /usr/bin/dunst &

bash /home/hugo/.scripts/dwlbar.sh
