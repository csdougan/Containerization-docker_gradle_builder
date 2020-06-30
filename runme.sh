#!/bin/bash
if [[ $GITURL == "" ]]; then
	echo "Container must be run by passing GITURL variable (i.e. docker run -e GITURL=http://someurl.git gradle_builder)."
else
	echo "URL passed was $GITURL "
	mkdir -p /tmp/files
	mkdir -p /tmp/gitrepo
	cd /tmp/gitrepo
	rm -rf *
	git clone $GITURL
	repodir=$(ls)
	if [[ $? -eq 0 ]]; then
		cd $repodir
		gradle build
	else
		echo "Something has gone wrong"
		exit 1
	fi
        if [[ -e ./build/libs/${repodir}.ear ]]; then
	  cp ./build/libs/${repodir}.ear /tmp/files
        else
          echo "Built file not found!.    Looking for ./build/libs/${repodir}.ear"
          exit 1
        fi	  
fi
