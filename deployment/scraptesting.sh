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

### 

printf "$sii Enter the name of the repo: "
read repo
printf $repo


array=( $(echo $repo | grep -o '^https\:\/\/github\.com\/HayGroup\/[\w|\W]+\.git$') )
echo ${array[@]}


printf "..."
read kj