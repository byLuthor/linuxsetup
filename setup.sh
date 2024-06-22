#!/bin/bash

# Script's Custom Colors
RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

LINUXSETUPDIR="$HOME/linuxsetup"

sys_upgrade() {
	APT_SOURCES_FILE="/etc/apt/sources.list"

	echo -e "${YELLOW}Initializing...${RC}"

	# Check if file exists
	if [ -f "$APT_SOURCES_FILE" ]; then
		echo -e "${GREEN}Opening file for modification: $APT_SOURCES_FILE"
		
		if command -v nvim &> /dev/null; then
			nvim "$APT_SOURCES_FILE"
		else
			nano "$APT_SOURCES_FILE"
		fi

		echo -e "${GREEN}File modification completed.${RC}"

	else
		echo -e "${RED}Error: File $APT_SOURCES_FILE does not exist.${RC}"
		exit 1
	fi

	sudo apt update && sudo apt upgrade

	if [[ $? -eq 0 ]]; then
		echo -e "${GREEN}PHASE 1 Complete.${RC}"
	else
		echo -e "${RED}Failed to upgrade system.${RC}"
		exit 1
	fi

}

conf_environment() {
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
}

# Display the menu
show_menu() {
	echo -e "${YELLOW}Select a Setup Phase:${RC}"
	echo "1) Modify APT sources & upgrade system"
	echo "2) Install dependencies & setup environment"
	echo "3) Exit"
}

# Main script loop
while true; do
	show_menu
	read -p "Enter your choice [1-4]: " choice

	case $choice in
		1)
			sys_upgrade
			break
			;;
		*)
			echo -e "${RED}Invalid choice. Please enter a number between 1 and 3.${RC}"
			;;
	esac

	echo "Press Enter to continue..."
	read
done



