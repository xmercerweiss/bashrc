#!/bin/bash

# Augmented Shell Commands
alias shared="gcc -fpic -shared"
alias deb="sudo dpkg --install"
alias get="sudo apt install"
alias py="sudo python3"
alias up="sudo apt update && sudo apt upgrade"
alias l="ls -lAhX --color=always --group-directories-first"

cx () {
	cd $1 && (clear; l)
}

kot () {
    kotlinc $1 2> /dev/null && java MainKt
}

mcx () {
    mkdir $1 && cx $1
}

clib () {
	sudo echo -n
	cwd=$(pwd)
	read -p "WARNING: This command is destructive. Proceed? [y/N] " yn
	if [[ "${yn,,}" != "y" ]]; then return 0; fi
	if [[ $cwd == "/" ]]; then 
		echo "CANNOT execute function in root directory."
		return 0
	fi
	sudo rm -f main.c 2> /dev/null
	sudo mv *.h $C_HEADERS 2> /dev/null
	sudo mv *.c$ $C_LIBS/src 2> /dev/null
	sudo mv *.so $C_LIBS/objs 2> /dev/null
	sudo mv *.a $C_LIBS/objs 2> /dev/null
	cd ..
	sudo rm -rf $cwd
}

cproj () {
	mkdir $1
	cd $1
	header_name="$1.h"
	source_name="$1.c"
	
	# Creating custom .h file
	sed -e "s/PROJECT/${1^^}/" ~/.CTemplates/HEADER > $header_name
	# Creating custom .c files
	sed -e "s/PROJECT/$1/" ~/.CTemplates/SOURCE > $source_name
	sed -e "s/PROJECT/$1/" ~/.CTemplates/MAIN > main.c
	# Creating custom Makefile
	sed -e "s/PROJECT/$1/" ~/.CTemplates/MAKEFILE > Makefile

	clear
	l
}

foreach () {
	while read -r line
		do $* "$line"
	done
}

forfile () {
	while read -r line
		do $* ./"$line"
	done
}

timeclock () {
	python3 $PROJECTS/Timeclock/main.py $*
}

blocksite () {
	cmd="echo '127.0.0.1 ${1}' >> /etc/hosts"
	sudo sh -c "$cmd"
	resolvectl flush-caches	
}

clibinstall () {
	sudo cp ./*.h $C_HEADERS 2> /dev/null
	sudo cp ./*.c $C_LIBS/src 2> /dev/null
	sudo cp ./*.a $C_LIBS/objs 2> /dev/null
	sudo cp ./*.so $C_LIBS/objs 2> /dev/null
}

# Jump to Directory
alias shortcuts="cx /usr/share/applications"
alias home="cx ~"

# Jump to File
alias al="vim ~/.bash_aliases"
alias rc="vim ~/.bashrc"

