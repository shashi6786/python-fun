#!/bin/bash

commit_message_check (){
    echo " Entering checker......."
      # Get the current branch and apply it to a variable
      currentbranch=`git branch | grep \* | cut -d ' ' -f2`

      # Gets the commits for the current branch and outputs to file
      git log $currentbranch --pretty=format:"%H" > shafile.txt

      # gets the git commit message based on the sha
      gitmessage=`git log --format=%B -n 1 "$i"`
      gitmessage= $1
      echo "commit text is : " $gitmessage

      # Checks gitmessage for string feat, fix, docs and breaking, if the messagecheck var is empty if fails
      messagecheck=`echo $gitmessage | grep "^US[0-9]\{5\}\b"`
      if [ -z "$messagecheck" ]
      then 
            echo "The commit message failed "
            echo "Please review the following : "
            echo " #### "
            echo "Your commit message must begin with one of the following"
            echo "[BUGFIX]"
            echo " #### "
            echo $gitmessage
            #rm shafile.txt >/dev/null 2>&1
            set -o errexit
      else
            echo "$messagecheck"
            echo "commit message passed"
      fi  
      #rm shafile.txt  >/dev/null 2>&1
}

# Calling the function
commit_message_check 