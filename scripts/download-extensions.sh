#!/usr/bin/env bash

##### FOR TEST ONLY
#GS_VERSION=2.20.1
##### FOR TEST ONLY

echo " ---> Extensions for Geoserver's version: $GS_VERSION"

GEOSERVER_PLUGINS=./plugins
DOWNLOAD_FOLDER=./downloads
GEOSERVER_URL="https://sourceforge.net/projects/geoserver/files/GeoServer"

declare -a EXTENSIONS_LINK_LIST
EXTENSIONS_LINK_LIST=(
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-gdal-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-jp2k-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-monitor-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-importer-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-querylayer-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-vectortiles-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-wcs2_0-eo-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-wmts-multi-dimensional-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-inspire-plugin.zip"
   "$GEOSERVER_URL/$GS_VERSION/extensions/geoserver-$GS_VERSION-libjpeg-turbo-plugin.zip"
  )
ARRAY_LEN=${#EXTENSIONS_LINK_LIST[@]}

echo " ---> Extention to download: $ARRAY_LEN"

mkdir $DOWNLOAD_FOLDER/

echo " ---> Start download extensions"
for url in "${EXTENSIONS_LINK_LIST[@]}";
do
  echo " ------> Start download of $url"
  wget "$url" -P $DOWNLOAD_FOLDER/;
done

echo " ---> Unzip downloaded extensions from $DOWNLOAD_FOLDER to $GEOSERVER_PLUGINS"
for zipfiles in $DOWNLOAD_FOLDER/*.zip;
do
  echo " ------> Unzip $zipfiles"
  unzip "$zipfiles" '*.jar' -d "$GEOSERVER_PLUGINS";
done

rm -rf $DOWNLOAD_FOLDER/

echo " ---> Extensions download completed"