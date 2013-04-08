#!/bin/bash 

clean_plugins=1
build_plugins=1
while getopts "nd" opt; 
do	
	case $opt in
	d)	build_plugins=0;;
	n)	clean_plugins=0;;
	\?) echo "$(tput bold)Usage: $0 [-d] [-n]" >&2
		echo ""$(tput sgr0)
		echo "Options:"
		echo "-d		Just delete targets"
		echo "-n		Do not delete targets before compiling"
		exit 1;;
	esac
done
shift $((OPTIND-1))


if [ $clean_plugins -eq 1 ]; then
	echo "Cleaning targets"
	build_dir="build"
	if [ -d $build_dir ]; then
		rm -rf $build_dir
	else
		echo "Targets are already clean"
	fi
fi

if [ $build_plugins -eq 1 ]; then
	echo "Compiling targets"
	mkdir -p build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=~/local ..
	make
	make install
fi
