<<README

@title 				Environment Setup Automation
@version			2.0
@author 			Speaud
@description		This creates and sets up a local environment for a given repo.

README

#!/bin/bash
clear

printf "\e[1;37;44mLocal Environment Setup Automation v2.0\t\n---------------------------------------\t\n@author\t\tSpeaud\t\t\t\n@license\tThe MIT License (MIT)\t\n\n\033[0m"

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
			
			printf "$sii Looks like you are using a mac. Is this correct (y/n)? "
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


		# / iOS setup
		else
		# Windows setup
			
			printf "$sii Looks like you are using a Windows based OS. Is this correct (y/n)? "
			read WOSC
			
			if [ "$WOSC" == "y" ] # windows dependencies setup
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

					# install node
					printf "$sii Node was not found. You’ll just need to grab an installer package from their website and run it.\n$sii After you're done press any key to continue."	
					read CNI
					# install npm and grunt globally
					#sudo npm install && sudo npm install grunt
					#printf "$sii Stage Complete: All global dependencies installed."
					
				fi	
			
			fi	
			
		# / Windows setup
	fi				

fi # / global dependencies update

#####
##	setting up the environment
#####

printf "$sii WARNING: The following install will take place at the root location of this file.\n"

printf "$sii Enter HTTPS of Repo to Clone: "
read REPO

printf "$sii Does this repo require the Launcher Repo (y/n)? "
read ISLAUNCH

if [ "$ISLAUNCH" == "y" ]
	then
	printf "$sii Enter Root Folder Name: "
	read FOLDER
	mkdir $FOLDER
	cd $FOLDER
	printf "$sii Installing Launcher Repo...\n"
	git clone https://github.com/HayGroup/Launcher.git
	printf "$sii Launcher installed\n"	
	cd ..
fi

printf "$sii Installing $REPO...\n\n"

git clone $REPO

printf "$sii Installing local dependicies...\n\n"

if [ "$ISLAUNCH" == "y" ]
	then
	cd Launcher/
fi

npm install && npm install grunt && bower install && npm cache clear

printf "$sii Running setup config...\n\n"

grunt

echo "$sii Complete"
