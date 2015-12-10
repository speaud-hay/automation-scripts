<<README

@title 				Deployment Automation
@version			
@author 			Speaud
@description		...
@instructions		...

README

#!/bin/bash
clear

# script instruction indicator
sii="\e[1;32;44m --> \033[0m"


### base vars
#
#

	# user
		
		DEPLOY_USER=$(whoami)

	# date
	
		DEPLOY_DATE=date

	# get the repo info
	
		printf "$sii Enter the name of the repo: "
		read DEPLOY_REPO
		
		if [[ $repo =~ ^(https\:\/\/github\.com\/[HayGroup]+\/)([A-Za-z]*|[0-9]*)(\.git) ]];
			then
			REPO_NAME=${BASH_REMATCH[2]}
		fi

	# confirm
	
		printf "$sii The repo you wish to deploy is $REPO_NAME. Is this correct (y/n)? "
		read REPO_CONFIRM


### prepare repo for deployment
#

	# connect to server

	# create backup of current working instance


### deploy
#

	# repo: job mapping

	# repo: activate admin

	# repo: hay101a

### clean up
#

	# log deployment

	# send notification emails