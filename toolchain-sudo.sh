#!/bin/bash
# toolchain-sudo.sh by Dan Peori (danpeori@oopo.net)

 if [[ $UID != 0 ]]; then
   echo "Please run this script with sudo"
   exit 1
 fi

 # TODO: Add checks to require gnu sed, make, and gcc
 
 INSTALLDIR=/usr/local/pspdev
 
 ## Enter the psptoolchain directory.
 cd "`dirname $0`" || { echo "ERROR: Could not enter the psptoolchain directory."; exit 1; }

 ## Set up the environment.
 export PSPDEV=$INSTALLDIR
 export PATH=`pwd`/gnubin:$PATH:$PSPDEV/bin

 ## Run the toolchain script.
 ./toolchain.sh $@ || { echo "ERROR: Could not run the toolchain script."; exit 1; }
