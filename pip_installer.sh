#!/bin/bash
pip3 --version
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
apt install python3-distutils -y
python3 get-pip.py
pip3 install --upgrade pip 
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
