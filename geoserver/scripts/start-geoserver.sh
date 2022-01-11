#!/usr/bin/env bash

echo " ---> JAVA_OPTS= $JAVA_OPTS"

export JAVA_OPTS="$JAVA_OPTS"

echo " ---> Start Geoserver $GEOSERVER_VERSION"
exec /opt/tomcat/bin/catalina.sh run
