#!/bin/bash
clear

# header and title
printf "\e[1;32;44mEnvironment Setup Automation v1.0\t\n---------------------------------------\t\n@author\t\tSpeaud\t\t\t\n@license\tThe MIT License (MIT)\t\n\n\033[0m"

# script instruction indicator
sii="\e[1;32;44m ===> \033[0m"


printf "$sii Enter HTTPS of Repo to Clone: "
read REPO

printf "$sii Enter New Folder Name: "
read FOLDER

printf "$sii Running...\n\n"

mkdir $FOLDER
cd $FOLDER

git clone https://github.com/HayGroup/Launcher.git && git clone $REPO

cd Launcher/
npm install && npm install grunt && bower install
npm install lodash --save && npm cache clear
grunt

echo "$sii Complete"
