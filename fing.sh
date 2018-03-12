#!/bin/bash
FING_PATH=$HOME/fing

sudo fing -s 192.168.1.0/24
sudo fing -s 192.168.1.0/24 > $FING_PATH/fing.txt
