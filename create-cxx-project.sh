#!/bin/bash


if [[ -z $1 ]]
then
  echo "usage : create-cxx-project.sh <project_name>"
else
  PROJECT_NAME=$1
  git clone https://github.com/Remi-Laot-CreiZyz/cxx-project.git && mv cxx-project ${PROJECT_NAME} && cd ${PROJECT_NAME} && rm -Rf .git && git init && mv source/main.cpp source/${PROJECT_NAME}.cpp && sed -i "s/PROJECT_NAME     := xxxxx/PROJECT_NAME     := ${PROJECT_NAME}/g" makefile && sed -i "s/#Project XXXXX/#Project ${PROJECT_NAME}/g" README.md && mkdir include
fi

