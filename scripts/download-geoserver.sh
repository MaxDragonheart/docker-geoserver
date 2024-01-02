#!/usr/bin/env bash

##### FOR TEST ONLY
#GS_VERSION=2.20.4
#GS_DEMO_DATA=True
##### FOR TEST ONLY

GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip"
GEOSERVER_WAR=geoserver.war
GEOSERVER_FOLDER=./geoserver

echo " ---> Start download of Geoserver $GS_VERSION"
pwd
echo " ---> Download Geoserver in $PWD/downloads/"
mkdir downloads/
echo " ---> Geoserver download link: $GEOSERVER_LINK"
wget "$GEOSERVER_LINK" -P downloads/

echo " ---> Unzip and copy Geoserver"
echo " ------> from $PWD/downloads/geoserver-$GS_VERSION-war.zip"
echo " ------> to $PWD/data/"
unzip downloads/geoserver-"$GS_VERSION"-war.zip '*.war' -d ./

echo " ---> Unzip .war"
echo " ------> from $PWD/$GEOSERVER_WAR"
echo " ------> to $PWD/$GEOSERVER_FOLDER"
unzip "$GEOSERVER_WAR" -d "$GEOSERVER_FOLDER"

echo " ---> Deletion of:"
echo " ------> $PWD/downloads/"
echo " ------> $PWD/$GEOSERVER_WAR"
rm -rf downloads/
rm -rf "$GEOSERVER_WAR"
rm -rf./geoserver/.gitignore

echo " ---> Geoserver download completed"