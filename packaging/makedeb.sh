#!/bin/bash

gettools="yes"
cleanup="yes"
pkgfiles=( "build" "changes" "deb" "dsc" "tar.xz" )


if [ $gettools == "yes" ]; then
    sudo apt-get update && sudo apt-get install build-essential debhelper devscripts dh-make dh-python dput gnupg
    sudo apt-get install python-all python-setuptools python3-all python3-setuptools
fi

cd ../library
debuild

for file in ${pkgfiles[@]}; do
    mv ../*.$file ../packaging
done

if [ $cleanup == "yes" ]; then
    debuild clean
    rm -R ./build
fi

exit 0
