#!/usr/bin/env bash

set -euo pipefail

##### FOR TEST ONLY
#GS_VERSION=2.24.2
##### FOR TEST ONLY

GEOSERVER_URL="https://sourceforge.net/projects/geoserver/files/GeoServer"
GEOSERVER_FILENAME=geoserver-$GS_VERSION-war.zip
GEOSERVER_LINK="$GEOSERVER_URL/$GS_VERSION/$GEOSERVER_FILENAME"
GEOSERVER_WAR="geoserver.war"
DOWNLOAD_FOLDER="./downloads"
GEOSERVER_FOLDER="./geoserver"

echo " ---> Start Geoserver $GS_VERSION download"
echo " ---> Start Geoserver $GS_VERSION download"
echo " ---> Start Geoserver $GS_VERSION download"
pwd
echo " ---> Download Geoserver in $PWD/downloads/"
mkdir -p "$DOWNLOAD_FOLDER"
echo " ---> Geoserver download link: $GEOSERVER_LINK"
wget -q "$GEOSERVER_LINK" -P downloads/

echo " ---> Unzip and copy Geoserver"
echo " ------> from $PWD/$DOWNLOAD_FOLDER/$GEOSERVER_FILENAME"
echo " ------> to $PWD/data/"
unzip "$DOWNLOAD_FOLDER/$GEOSERVER_FILENAME" '*.war' -d ./

echo " ---> Unzip .war"
echo " ------> from $PWD/$GEOSERVER_WAR"
echo " ------> to $PWD/$GEOSERVER_FOLDER"
unzip "$GEOSERVER_WAR" -d "$GEOSERVER_FOLDER"

rm -rf "$DOWNLOAD_FOLDER"
rm -rf "$GEOSERVER_WAR"
rm -rf "$GEOSERVER_FOLDER/.gitignore"

echo " ---> Geoserver download completed"