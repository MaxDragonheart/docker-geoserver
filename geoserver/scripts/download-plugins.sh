#!/usr/bin/env bash

echo "Download extensions"

mkdir downloads/

wget -i geoserver/extensions.txt -P downloads/

for zipfiles in /downloads/*.zip; do unzip "$zipfiles" '*.jar' -d geoserver/plugins; done

#for i in /downloads/*.jar; do cp $i geoserver/geoserver-plugins; done

rm -rf downloads

echo "Download completed"