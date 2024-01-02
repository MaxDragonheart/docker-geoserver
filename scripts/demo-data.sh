#!/usr/bin/env bash
echo " ---> Remove demo data"

#GEOSERVER_HOME=/usr/local/tomcat/webapps/geoserver

if [ "$GS_DEMO_DATA" = False ];
then

  rm -rf $GEOSERVER_HOME/data/data/
  rm -rf $GEOSERVER_HOME/data/layergroups/
  rm -rf $GEOSERVER_HOME/data/palettes/
  rm -rf $GEOSERVER_HOME/data/styles/
  rm -rf $GEOSERVER_HOME/data/workspaces/

  mkdir $GEOSERVER_HOME/data/data/
  mkdir $GEOSERVER_HOME/data/layergroups/
  mkdir $GEOSERVER_HOME/data/palettes/
  mkdir $GEOSERVER_HOME/data/styles/
  mkdir $GEOSERVER_HOME/data/workspaces/
fi

echo " ---> Remove demo data completed"