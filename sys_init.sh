#!/bin/bash

if [ -f /_init.sh ] || [-f /_alias.sh ]; then
   echo "Exit(already inited)..."
   exit 0
fi

sudo ln /_alias.sh ./_alias.sh
sudo ln /_init.sh ./_init.sh
sudo ln /.scripts_config ./.scripts_config
