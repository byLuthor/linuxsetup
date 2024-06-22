#!/bin/bash

# Script's Custom Colors
RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

LINUXSETUPDIR="$HOME/linuxsetup"

if [[ ! -d "$LINUXSETUPDIR" ]]; then
	echo -e "${YELLOW}Creating Linux Setup Directory: $LINUXSETUPDIR${RC}"
	mkdir -p "$LINUXSETUPDIR"
	echo -e "${GREEN}Linux Setup directory created: $LINUXSETUPDIR${RC}"
fi

if [[ ! -d "$LINUXSETUPDIR/dotfiles" ]]; then
	echo -e "${YELLOW}Cloning dotfiles repository into: $LINUXSETUPDIR/dotfiles${RC}"
	git clone https://github.com/byLuthor/dotfiles.git
	if [[ $? -eq 0 ]]; then
		echo -e "${GREEN}Successfully cloned dotfiles repositoy${RC}"
	else
		echo -e "${RED}Failed to clone dotfiles repository${RC}"
		exit 1
	fi
fi


