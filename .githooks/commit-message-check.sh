#!/bin/bash

commit_message_check (){
    echo " Entering checker..... "
      # Get the current branch and apply it to a variable
      currentbranch=`git branch | grep \* | cut -d ' ' -f2`

      # Gets the commits for the current branch and outputs to file
      git log $currentbranch --pretty=format:"%H" > shafile.txt

      # loops through the file an gets the message
      for i in `cat ./shafile.txt`;
      do 
      # gets the git commit message based on the sha
      gitmessage=`git log --format=%B -n 1 "$i"`

      # Checks gitmessage for string feat, fix, docs and breaking, if the messagecheck var is empty if fails
      messagecheck=`echo $gitmessage | grep "\[(BUGFIX|DOCS|FEATURE|TASK)\] .+$"`
      if [ -z "$messagecheck" ]
      then 
            echo "Your commit message must begin with one of the following"
            echo "[BUGFIX]"
            echo " "
      fi

      # check to see if the messagecheck var is empty
      if [ -z "$messagecheck" ]
      then  
            echo "The commit message with sha: '$i' failed "
            echo "Please review the following :"
            echo $gitmessage
            rm shafile.txt >/dev/null 2>&1
            set -o errexit
      else
            echo "$messagecheck"
            echo "'$i' commit message passed"
      fi  
      done
      rm shafile.txt  >/dev/null 2>&1
}

# Calling the function
commit_message_check 