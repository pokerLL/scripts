#!/usr/bin/bash
set -e
if [ -f ./miniconda.sh ];then
   cp ./miniconda.sh ~
else
   wget "https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-$(uname -m).sh" -O ~/miniconda.sh
fi
bash ~/miniconda.sh -b -p $HOME/miniconda
rm -rf ~/miniconda.sh
~/miniconda/bin/conda init
echo 'Successfully installed miniconda...'
echo -n 'Conda version: '
~/miniconda/bin/conda --version
echo -e '\n'
exec bash

