#!/usr/bin/env bash

echo " ---> Start download extensions"

mkdir downloads/

echo " ---> Put extensions list from data/extensions.txt in downloads/"
wget -i data/extensions.txt -P downloads/

echo " ---> Unzip downloaded extensions from downloads/ to data/plugins"
for zipfiles in /downloads/*.zip; do unzip "$zipfiles" '*.jar' -d data/plugins; done

#for i in /downloads/*.jar; do cp $i geoserver/geoserver-plugins; done

rm data/extensions.txt
rm -rf downloads/

echo " ---> Extensions download completed"