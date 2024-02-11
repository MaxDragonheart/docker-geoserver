#!/usr/bin/env bash

echo " ---> Remove demo data"

##### FOR TEST ONLY
#GS_DEMO_DATA=False
#GEOSERVER_HOME=/usr/local/tomcat/webapps/geoserver
##### FOR TEST ONLY

if [ "$GS_DEMO_DATA" = False ]; then
  if [ -d "$GEOSERVER_HOME/data/data" ]; then
    rm -rf "$GEOSERVER_HOME/data/data/"
  fi
  if [ -d "$GEOSERVER_HOME/data/layergroups" ]; then
    rm -rf "$GEOSERVER_HOME/data/layergroups/"
  fi
  if [ -d "$GEOSERVER_HOME/data/palettes" ]; then
    rm -rf "$GEOSERVER_HOME/data/palettes/"
  fi
  if [ -d "$GEOSERVER_HOME/data/styles" ]; then
    rm -rf "$GEOSERVER_HOME/data/styles/"
  fi
  if [ -d "$GEOSERVER_HOME/data/workspaces" ]; then
    rm -rf "$GEOSERVER_HOME/data/workspaces/"
  fi

  mkdir -p "$GEOSERVER_HOME/data/data/"
  mkdir -p "$GEOSERVER_HOME/data/layergroups/"
  mkdir -p "$GEOSERVER_HOME/data/palettes/"
  mkdir -p "$GEOSERVER_HOME/data/styles/"
  mkdir -p "$GEOSERVER_HOME/data/workspaces/"
fi

echo " ---> Remove demo data completed"
