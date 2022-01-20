#!/usr/bin/env bash
echo " ---> Extensions for Geoserver's version: $GS_VERSION"

declare -a EXTENSIONS_LINK_LIST
EXTENSIONS_LINK_LIST=(
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-gdal-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-jp2k-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-monitor-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-importer-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-querylayer-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-vectortiles-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-wcs2_0-eo-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-wmts-multi-dimensional-plugin.zip"
  "http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-inspire-plugin.zip"
  )
ARRAY_LEN=${#EXTENSIONS_LINK_LIST[@]}

echo " ---> Extention to download: $ARRAY_LEN"

mkdir downloads/

for url in "${EXTENSIONS_LINK_LIST[@]}";
do
  echo " ---> Start download of $url"
  wget "$url" -P downloads/;
done

#echo " ---> Start download extensions"
#echo " ---> Put extensions list from data/extensions.txt in downloads/"
#wget -i data/extensions.txt -P downloads/
#rm data/extensions.txt

echo " ---> Unzip downloaded extensions from downloads/ to data/plugins"
for zipfiles in /downloads/*.zip;
do
  unzip "$zipfiles" '*.jar' -d data/plugins;
done

rm -rf downloads/

echo " ---> Extensions download completed"