#!/bin/bash

while true; do
    echo $(top -b -n 1 | awk 'FNR == 3 {print "CPU: " $2 + $4 "% " }') $(df -h | awk 'FNR == 2 {print "| DISK: " $3 "/" $2 }') $(free -h | awk 'FNR == 2 {print "| RAM: " $3 "/" $2 " | "}') $(date +'%d/%m/%y %H:%M') | dwlb -status-stdin all
    sleep 1
done
