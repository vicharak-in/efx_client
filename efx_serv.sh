#!/bin/bash

# Paths to efinity on galactos
# Kept here for redundancy and to make this script slightly more
# self-contained
export EFINITY_HOME=$HOME/hdd/shreeyash/efinity/2023.1/
export EFXPT_HOME=$EFINITY_HOME/pt
export EFXPGM_HOME=$EFINITY_HOME/pgm
export PYTHON_PATH=$EFINITY_HOME/bin
export PATH=$PYTHON_PATH:$EFINITY_HOME/scripts:$PATH

TARGET_DIR="$1"
PROJECT_NAME="$1"
OPTION_FULL_EXPORT=0
MY_NAME="$(basename "$0")"

if [ $# -lt 1 ]; then
    echo "$MY_NAME: Too few arguments"
    echo "USAGE: $MY_NAME <project_name>"
    echo "NOTE: do not give .xml extension to project name"
fi

if [ ! -d /tmp/"$TARGET_DIR" ]; then
	mkdir /tmp/"$TARGET_DIR"
fi

cd /tmp/"$TARGET_DIR" || exit 1
echo "$MY_NAME: Starting efinity process"
if efx_run.py "$PROJECT_NAME".xml; then
	echo "$MY_NAME: Completed efinity process"
else
	echo "$MY_NAME: efinity failed"
	exit 1
fi
echo "$MY_NAME: Creating tarball"
if [ $OPTION_FULL_EXPORT = 0 ]; then
	tar -cvzf "$PROJECT_NAME".tar.gz outflow
else
	tar -cvzf "$PROJECT_NAME".tar.gz outflow ip work_pnr work_syn
fi
