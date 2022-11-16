#!/bin/zsh

# run this script to create MacOS application using oaz engine.

echo -n "Application Name: "
read name

# create directory
mkdir ${name}
mkdir ${name}/src

# Set root CMakeList.txt
touch ${name}/CMakeLists.txt

echo \
"test ${name}\
" >> ${name}/CMakeLists.txt