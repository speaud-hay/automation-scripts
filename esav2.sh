<<README

@title 				Environment Setup Automation
@version			2.0
@author 			Speaud
@description		This creates and sets up a local environment for a given repo.

README

#!/bin/bash
clear

printf "\e[1;37;44mEnvironment Setup Automation v2.0\t\n---------------------------------------\t\n@author\t\tSpeaud\t\t\t\n@license\tThe MIT License (MIT)\t\n\n\033[0m"

# script instruction indicator
sii="\e[1;37;44m >> \033[0m"

#####
## prereqs
#####

printf "$sii Do you want to check the status of global dependencies (y/n)? "
read GDS

# set up global dependencies ( node, npm, grunt )
if [ "$GDS" == "y" ]
	then 

		if [ `uname` == "Darwin" ] # ios setup
			then 
			
			printf "$sii Looks like you are using a mac. Is this correct (y/n)?"
			read OSC
			
			if [ "$OSC" == "y" ] # ios dependencies setup
				then
				
				if [ `node -v` != NULL ] # node setup
					then
					
					printf "$sii You already have node installed. Do you want to update it to the latest stable version (y/n)?"
					read NU
					
					if [ "$NU" == "y" ] # node setup - update node
						then
						
						if [ `brew -v` == NULL ]
							then
							
							# install homebrew
							printf "$sii We have to install homebrew first"
							ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"							
						
						fi
						
						brew update
						brew upgrade node
						npm install -g npm
						
					fi

					
				else
				
					# install homebrew
					ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
					
					# install node
					brew install node	
					
					# install npm and grunt globally
					sudo npm install && sudo npm install grunt
					printf "$sii Stage Complete: All global dependencies installed."
					
				fi	

			fi


		
		fi # / ios setup

fi # / global dependencies update

#####
##	setting up the environment
#####

printf "$sii Enter HTTPS of repo to clone: "
read REPO

printf "$sii \t@note the Launcher repo will automatically be included\n"

printf "$sii Enter the name of the new directory to be created: "
read FOLDER

printf "$sii Running...\n\n"

mkdir $FOLDER
cd $FOLDER
	
git clone https://github.com/HayGroup/Launcher.git && git clone $REPO
	
cd Launcher/
npm install && npm install grunt && bower install
npm install lodash --save && npm cache clear
grunt

echo "$sii Complete!"
