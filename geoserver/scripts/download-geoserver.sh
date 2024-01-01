#!/usr/bin/env bash

##### FOR TEST ONLY
#GS_VERSION=2.20.4
#GS_DEMO_DATA=True
##### FOR TEST ONLY

GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip"
GEOSERVER_WAR=data/geoserver.war
GEOSERVER_FOLDER=data/geoserver

echo " ---> Start download of Geoserver $GS_VERSION"
pwd
echo " ---> Download Geoserver in $PWD/downloads/"
mkdir downloads/
echo " ---> Geoserver download link: $GEOSERVER_LINK"
wget "$GEOSERVER_LINK" -P downloads/

echo " ---> Unzip and copy Geoserver"
echo " ------> from $PWD/downloads/geoserver-$GS_VERSION-war.zip"
echo " ------> to $PWD/data/"
unzip downloads/geoserver-"$GS_VERSION"-war.zip '*.war' -d data/

echo " ---> Unzip .war"
echo " ------> from $PWD/$GEOSERVER_WAR"
echo " ------> to $PWD/$GEOSERVER_FOLDER"
unzip "$GEOSERVER_WAR" -d "$GEOSERVER_FOLDER"

echo " ---> Deletion of:"
echo " ------> $PWD/downloads/"
echo " ------> $PWD/$GEOSERVER_WAR"
rm -rf downloads/
rm -rf "$GEOSERVER_WAR"
rm -rf data/geoserver/.gitignore

if [ "$GS_DEMO_DATA" = False ];
then
  echo " ---> Remove demo data"

  rm -rf data/geoserver/data/data/
  rm -rf data/geoserver/data/layergroups/
  rm -rf data/geoserver/data/palettes/
  rm -rf data/geoserver/data/styles/
  rm -rf data/geoserver/data/workspaces/

  mkdir data/geoserver/data/data/
  mkdir data/geoserver/data/layergroups/
  mkdir data/geoserver/data/palettes/
  mkdir data/geoserver/data/styles/
  mkdir data/geoserver/data/workspaces/
fi


echo " ---> Geoserver download completed"
