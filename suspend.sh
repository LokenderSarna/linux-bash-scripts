#!/bin/bash

which pmi >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo -e "Installing powermanagement-interface package...\n"
	sudo apt-get install -yqq powermanagement-interface
fi
which powermanagement-interface >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo -e "ERROR: powermanagement-interface not installed!\n"
	exit 1
fi

pmi action suspend

echo -e "\nDone.\n"

exit 0
