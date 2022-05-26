#!/usr/bin/env bash
#GS_VERSION=2.20.1
GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip"
GEOSERVER_WAR=data/geoserver.war
GEOSERVER_FOLDER=data/geoserver

echo " ---> Start download of Geoserver $GS_VERSION"

echo " ---> Download Geoserver in downloads/"
mkdir downloads/
echo " ---> Geoserver download link: $GEOSERVER_LINK"
wget "$GEOSERVER_LINK" -P downloads/

echo " ---> Unzip Geoserver from downloads/geoserver-$GS_VERSION-war.zip to data/"
unzip downloads/geoserver-"$GS_VERSION"-war.zip '*.war' -d data/

echo " ---> Unzip .war from $GEOSERVER_WAR to $GEOSERVER_FOLDER"
unzip "$GEOSERVER_WAR" -d "$GEOSERVER_FOLDER"

echo " ---> Delete of downloads/ and $GEOSERVER_WAR"
rm -rf downloads/
rm -rf "$GEOSERVER_WAR"

echo " ---> Geoserver download completed"
