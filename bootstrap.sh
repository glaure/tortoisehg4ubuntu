#!/bin/bash
#
# Copyright (c) 2021 Gunther Laure

set -e

#
# Bootstrap the build for a local tortoisehg installation
# This script has to be run as root.
#

# Assure python3 is installed and /usr/bin/python is a symlink to python3
apt install --yes python-is-python3

# Pip3 and build essentials are needed
apt install --yes python3-pip build-essential

# Install PyQt5
pip3 install pyqt5

# Install Mercurial
pip3 install mercurial==5.4

# Install Qscintilla.
pip3 install qscintilla
apt install --yes pyqt5.qsci-dev
apt install --yes python3-pyqt5.qsci

# iniparse
apt install --yes python3-iniparse

# done
echo ---------------------------
echo all prerequisites installed
echo ---------------------------