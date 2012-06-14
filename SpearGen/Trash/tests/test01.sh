#!/usr/bin/bash

# DIR_PATH is used to locate the script's path.
DIR_PATH=`dirname $0`

# Include the environment variables
source $DIR_PATH/../pass_vars.sh

cd $TRANS_DIR${MY_PASS}/tests

../run.sh naive_func.mem2reg

