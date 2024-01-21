#!/usr/bin/env bash

##### FOR TEST ONLY
#GS_VERSION=2.20.1
##### FOR TEST ONLY

GEOSERVER_FILENAME=geoserver-$GS_VERSION-war.zip
GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/$GS_VERSION/$GEOSERVER_FILENAME"
GEOSERVER_WAR=geoserver.war
DOWNLOAD_FOLDER=./downloads
GEOSERVER_FOLDER=./geoserver

echo " ---> Start Geoserver $GS_VERSION download"
pwd
echo " ---> Download Geoserver in $PWD/downloads/"
mkdir $DOWNLOAD_FOLDER
echo " ---> Geoserver download link: $GEOSERVER_LINK"
wget "$GEOSERVER_LINK" -P downloads/

echo " ---> Unzip and copy Geoserver"
echo " ------> from $PWD/$DOWNLOAD_FOLDER/$GEOSERVER_FILENAME"
echo " ------> to $PWD/data/"
unzip $DOWNLOAD_FOLDER/$GEOSERVER_FILENAME '*.war' -d ./

echo " ---> Unzip .war"
echo " ------> from $PWD/$GEOSERVER_WAR"
echo " ------> to $PWD/$GEOSERVER_FOLDER"
unzip "$GEOSERVER_WAR" -d "$GEOSERVER_FOLDER"

rm -rf $DOWNLOAD_FOLDER
rm -rf "$GEOSERVER_WAR"
rm -rf./geoserver/.gitignore

echo " ---> Geoserver download completed"