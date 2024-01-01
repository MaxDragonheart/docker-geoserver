#!/usr/bin/env bash

JAVA_COMMANDS="-XX:PerfDataSamplingInterval=500 \
  -Dorg.geotools.referencing.forceXY=true \
  -DMAX_FILTER_RULES=${MAX_FILTER_RULES} \
  -DOPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH} \
  -Duser.timezone=UTC \
  -Dorg.geotools.shapefile.datetime=true \
  -DENABLE_JSONP=${ENABLE_JSONP} \
  -Xms${GS_INITIAL_MEMORY} \
  -Xmx${GS_MAXIMUM_MEMORY} \
  -Djava.awt.headless=true -server \
  -Dfile.encoding=UTF8 \
  -Djavax.servlet.request.encoding=UTF-8 \
  -Djavax.servlet.response.encoding=UTF-8 \
  -XX:SoftRefLRUPolicyMSPerMB=36000 \
  -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 \
  -XX:ParallelGCThreads=20 \
  -XX:ConcGCThreads=5"

echo " ---> JAVA COMMANDS: ${JAVA_COMMANDS}"

export JAVA_OPTS=${JAVA_COMMANDS}

echo " ---> Start Geoserver v. $GS_VERSION on port $GS_HTTP_PORT"
echo " ---> Start Geoserver v. $GS_VERSION on port $GS_HTTP_PORT"
echo " ---> Start Geoserver v. $GS_VERSION on port $GS_HTTP_PORT"
echo " ---> Start Geoserver v. $GS_VERSION on port $GS_HTTP_PORT"
exec /opt/tomcat/bin/catalina.sh run
