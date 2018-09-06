#!/bin/bash

make_build_dir()
{
    buildPath=$1
    rebuild=$2

    if [ -d "$buildPath" ] && [ "$rebuild" = rebuild ]
    then
	rm -rf "$buildPath"
    fi

    if [ ! -d "$buildPath" ]
    then
	mkdir -p "$buildPath"
    fi
}

if [ "$1" = dependencies ]
then
    # ./run.sh dependencies
    sudo apt-get install build-essential
    sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
    sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

elif [ $1 = opencv3_2 ]
then
    # ./run.sh opencv3_2 norebuild
    buildPath=build3_2
    rebuild=$2
    make_build_dir $buildPath $rebuild
    cd $buildPath

    proxychains cmake \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=/home/shhs/env/opencv3_2_sys \
		.. | tee "${1}.log"

    make -j8

    make install

fi    
