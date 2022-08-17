#!/bin/bash
if [ $cm -lt 1 ]
then
 echo Not Enough Arguement!
 exit;
fi
git add .
git commit -m "$cm"
git checkout master
git pull
git merge chyl
git push
git checkout chyl
git merge master