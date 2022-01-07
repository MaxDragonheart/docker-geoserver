#!/usr/bin/env bash

GEOSERVER_WAR=data/geoserver.war
GEOSERVER_FOLDER=data/geoserver

echo " ---> Start download of Geoserver $GEOSERVER_VERSION"

echo " ---> Download Geoserver in downloads/"
mkdir downloads/
wget "$GEOSERVER_LINK" -P downloads/

echo " ---> Unzip Geoserver from downloads/geoserver-$GEOSERVER_VERSION-war.zip to data/"
unzip downloads/geoserver-"$GEOSERVER_VERSION"-war.zip '*.war' -d data/

echo " ---> Unzip .war from $GEOSERVER_WAR to $GEOSERVER_FOLDER"
unzip "$GEOSERVER_WAR" -d "$GEOSERVER_FOLDER"

echo " ---> Delete of downloads/ and $GEOSERVER_WAR"
rm -rf downloads/
rm -rf "$GEOSERVER_WAR"

echo " ---> Geoserver download completed"
