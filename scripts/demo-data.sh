#!/usr/bin/env bash
echo " ---> Remove demo data"

if [ "$GS_DEMO_DATA" = False ];
then

  rm -rf ./geoserver/data/data/
  rm -rf ./geoserver/data/layergroups/
  rm -rf ./geoserver/data/palettes/
  rm -rf ./geoserver/data/styles/
  rm -rf ./geoserver/data/workspaces/

  mkdir ./geoserver/data/data/
  mkdir ./geoserver/data/layergroups/
  mkdir ./geoserver/data/palettes/
  mkdir ./geoserver/data/styles/
  mkdir ./geoserver/data/workspaces/
fi

echo " ---> Remove demo data completed"