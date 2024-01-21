#!/usr/bin/env bash

##### FOR TEST ONLY
#GS_VERSION=2.20
##### FOR TEST ONLY

echo " ---> Extensions for Geoserver's version: $GS_VERSION"

GEOSERVER_PLUGINS=./plugins
DOWNLOAD_FOLDER=./downloads

declare -a EXTENSIONS_LINK_LIST
EXTENSIONS_LINK_LIST=(
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-gdal-plugin.zip"
  "https://build.geoserver.org/geoserver/${GS_VERSION}.x/ext-latest/geoserver-${GS_VERSION}-SNAPSHOT-gdal-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-jp2k-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-monitor-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-importer-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-querylayer-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-vectortiles-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-wcs2_0-eo-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-wmts-multi-dimensional-plugin.zip"
  # "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-inspire-plugin.zip"
  )
ARRAY_LEN=${#EXTENSIONS_LINK_LIST[@]}

echo " ---> Extention to download: $ARRAY_LEN"

mkdir ${DOWNLOAD_FOLDER}/

echo " ---> Start download extensions"
for url in "${EXTENSIONS_LINK_LIST[@]}";
do
  echo " ------> Start download of $url"
  wget "$url" -P ${DOWNLOAD_FOLDER}/;
done

#echo " ---> Start download extensions"
#echo " ---> Put extensions list from data/extensions.txt in downloads/"
#wget -i data/extensions.txt -P downloads/
#rm data/extensions.txt

echo " ---> Unzip downloaded extensions from ${DOWNLOAD_FOLDER} to ${GEOSERVER_PLUGINS}"
for zipfiles in ${DOWNLOAD_FOLDER}/*.zip;
do
  echo " ------> Unzip ${zipfiles}"
  unzip "$zipfiles" '*.jar' -d "${GEOSERVER_PLUGINS}";
done

# cp ${GEOSERVER_PLUGINS}/* ./geoserver/WEB-INF/lib

rm -rf ${DOWNLOAD_FOLDER}/  # ${GEOSERVER_PLUGINS}/

echo " ---> Extensions download completed"