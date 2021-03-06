#!/bin/bash

# File    : cmake_project.sh
# Author  : lihan
# Version : 1.0
# Company : 
# Contact : 
# Date    : 2015-07-23 11:54:44

if [ $# -eq 0 ];then
    echo "Usage: `basename $0` {PROJECT_NAME}"
    exit 1
else
    PROJECT_NAME=$1
fi

mkdir ${PROJECT_NAME} || exit 1

cd ${PROJECT_NAME}
PROJECT_DIR=`pwd`/
PROJECT_DIR=${PROJECT_DIR//\//\\\/}

mkdir -p src/service src/core src/client src/mock src/third src/test
mkdir -p conf
mkdir -p output/bin

cp ~/.vim/templete/log4cplus/log4cplus.properties conf/
cp ~/.vim/templete/CMakeLists/CMakeLists.txt.common CMakeLists.txt
#vim -c "%s/PROJECT_XXX/${PROJECT_NAME}/g
#    | %s/PROJECT_DIR_XXX/${PROJECT_DIR}/g
#    | %s/PROJECT_ROOT_XXX/${PROJECT_DIR}/g | wqa" CMakeLists.txt
vim -c "%s/PROJECT_XXX/${PROJECT_NAME}/g
    | %s/PROJECT_DIR_XXX/${PROJECT_DIR}/g
    | wqa" CMakeLists.txt

cp ~/.scripts/run.sh .
vim -c "%s/PROJECT_XXX/${PROJECT_NAME}/g | wqa" run.sh

cp ~/.scripts/supervise output/bin/supervise.${PROJECT_NAME}-service
cp ~/.scripts/load.sh output/
touch conf/${PROJECT_NAME}.conf
vim -c "%s/PROJECT_XXX/${PROJECT_NAME}-service/g | wqa" output/load.sh

vim -c "wq" src/service_main.cpp
