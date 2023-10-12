#!/bin/bash

export EFINITY_HOME=$HOME/hdd/shreeyash/efinity/2023.1/
export EFXPT_HOME=$EFINITY_HOME/pt
export EFXPGM_HOME=$EFINITY_HOME/pgm
export PYTHON_PATH=$EFINITY_HOME/bin
export PATH=$PYTHON_PATH:$EFINITY_HOME/scripts:$PATH

TARGET_DIR="$1"
PROJECT_NAME="$1"
OPTION_FULL_EXPORT=0
MY_NAME="$(basename $0)"
PATH_TO_SCRIPTS=$EFINITY_HOME/scripts

if [ $# < 1 ]; then
    echo "$MY_NAME: Too few arguments"
    echo "USAGE: $MY_NAME <project_name>"
    echo "NOTE: do not give .xml extension to project name"
fi

if [ ! -d /tmp/"$TARGET_DIR" ]; then
	mkdir /tmp/"$TARGET_DIR"
fi

cd /tmp/"$TARGET_DIR" || exit 1
echo "$MY_NAME: Starting efinity process"
$PATH_TO_SCRIPTS/efx_run.py "$PROJECT_NAME"
if $PATH_TO_SCRIPTS/efx_run_map.py --project_xml "$PROJECT_NAME".xml $PROJECT_NAME |
	tee -a /tmp/"$PROJECT_NAME"/outflow/"$PROJECT_NAME".log; then
	echo "$MY_NAME: Completed efinity process"
else
	echo "$MY_NAME: mapping failed"
	exit 1
fi

if $PATH_TO_SCRIPTS/efx_run_pnr.py "$PROJECT_NAME" --prj --family Trion --device T120F324 \
	--timing_model C4 --sim --output_dir outflow \
	--opt work_dir=work_pnr seed=1 placer_effort_level=2 max_threads=-1 |
	tee -a /tmp/"$PROJECT_NAME"/outflow/"$PROJECT_NAME".log; then
	echo "$MY_NAME: Completed pnr process"
else
	echo "$MY_NAME: pnr failed"
	exit 1
fi

echo "$MY_NAME: Creating tarball"
if [ $OPTION_FULL_EXPORT = 0 ]; then
	tar -cvzf "$PROJECT_NAME".tar.gz outflow
else
	tar -cvzf "$PROJECT_NAME".tar.gz outflow ip work_pnr work_syn
fi
