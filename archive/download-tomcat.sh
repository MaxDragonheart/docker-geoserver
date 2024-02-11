#!/usr/bin/env bash

##### FOR TEST ONLY
TOMCAT_MAJOR=9
TOMCAT_MINOR=0
TOMCAT_PATCH=84
##### FOR TEST ONLY

TOMCAT_VERSION=$TOMCAT_MAJOR.$TOMCAT_MINOR.$TOMCAT_PATCH
TOMCAT_FILE="apache-tomcat-${TOMCAT_VERSION}.tar.gz"
DOWNLOAD_FOLDER="./tomcat"
TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/${TOMCAT_FILE}"

echo " ---> Start Tomcat v.$TOMCAT_VERSION download..."

echo " ---> Start start download from $TOMCAT_LINK"

wget "$TOMCAT_LINK"
mkdir "$DOWNLOAD_FOLDER"
tar xzvf "$TOMCAT_FILE" -C "$DOWNLOAD_FOLDER" --strip-components=1

rm -rf "$TOMCAT_FILE"

echo " ---> Tomcat v.$TOMCAT_VERSION download completed"