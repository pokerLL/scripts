#!/bin/bash

if [ -f /_init.sh || -f /_alias.sh  ]; then
   echo "Exit..Already init..."
   exit 0
fi

sudo cp ./_alias.sh /
sudo cp ./_init.sh /
sudo cp ./.scripts_config /
