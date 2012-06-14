#!/usr/bin/bash

# DIR_PATH is used to locate the script's path.
DIR_PATH=`dirname $0`

# Include the environment variables
source $DIR_PATH/../symexec/passes/env_vars.sh

# Name and parameters of this pass.
MY_PASS=TestInit
MY_OPT=test_init
SO_FILE=${LIB_DIR}LLVMTestInit.so