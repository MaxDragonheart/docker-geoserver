# syntax=docker/dockerfile:1

## ULGIS as Layer
#FROM maxdragonheart/ulgis:latest as gis-os Switch to this with issue #37
FROM ubuntu:20.04 as base-os
RUN apt update -y && apt upgrade -y && apt -y autoremove
# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Install useful packages
RUN apt install -y \
    nano \
    unzip \
    wget \
    curl \
    aptitude \
    openssl \
    gettext

ARG GS_VERSION=2.20.4
ARG GS_DEMO_DATA=False

ENV GS_VERSION=${GS_VERSION} \
    GS_DEMO_DATA=${GS_DEMO_DATA}

FROM base-os as gis-os

WORKDIR /

# Install JAVA and related stuffs
RUN apt install -y  openjdk-11-jdk
# Install GDAL stuffs
RUN apt install -y  \
    libgdal-dev \
    libgdal-java
# Install useful stuffs
RUN apt install -y \
    systemctl  \
    xsltproc

# GIS-OS as Layer
FROM gis-os as tomcat
## Geoserver Web Archive Installation
## https://docs.geoserver.org/latest/en/user/installation/war.html
## Environment Variables
ARG TOMCAT_MAJOR=9
ARG TOMCAT_MINOR=0
ARG TOMCAT_PATCH=84
ARG TOMCAT_VERSION=${TOMCAT_MAJOR}.${TOMCAT_MINOR}.${TOMCAT_PATCH}
ARG CATALINA_HOME=/opt/tomcat
# ARG GS_HTTP_PORT=8300

ENV \
    TOMCAT_VERSION=${TOMCAT_VERSION} \
    TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    TOMCAT_DOWNLOAD_FOLDER=tomcat-${TOMCAT_VERSION} \
    CATALINA_HOME=${CATALINA_HOME}
#    GS_HTTP_PORT=${GS_HTTP_PORT}

RUN mkdir -p ${CATALINA_HOME}

RUN mkdir ${TOMCAT_DOWNLOAD_FOLDER}
WORKDIR ${TOMCAT_DOWNLOAD_FOLDER}
RUN echo ${TOMCAT_LINK}
RUN wget ${TOMCAT_LINK} \
    && tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C ${CATALINA_HOME} --strip-components=1
WORKDIR ../
RUN rm -rf ${TOMCAT_DOWNLOAD_FOLDER}
#COPY files/tomcat/context.xml ${CATALINA_HOME}/webapps/manager/META-INF
COPY files/tomcat/tomcat-users.xml ${CATALINA_HOME}/conf
COPY files/tomcat/web.xml ${CATALINA_HOME}/conf

# Image useful for stuffs collection
FROM base-os as tmp_image_geoserver
## Download Geoserver
RUN mkdir -p data/geoserver
COPY scripts/download-geoserver.sh /download-geoserver.sh
RUN chmod +x download-geoserver.sh
RUN ./download-geoserver.sh


FROM base-os as tmp_image_extensions
## Download extensions
RUN mkdir -p data/plugins
COPY scripts/download-extensions.sh /download-extensions.sh
RUN chmod +x download-extensions.sh
RUN ./download-extensions.sh

# Tomcat as Layer
FROM tomcat as geoserver

RUN mkdir ${CATALINA_HOME}/webapps/geoserver
# Copy Geoserver version and its plugins from a tmp image to main image
COPY --from=tmp_image_geoserver data/geoserver ${CATALINA_HOME}/webapps/geoserver
COPY --from=tmp_image_extensions data/plugins ${CATALINA_HOME}/webapps/geoserver/WEB-INF/lib
COPY files/geoserver/web.xml ${CATALINA_HOME}/webapps/geoserver/WEB-INF

ENV GEOSERVER_HOME=${CATALINA_HOME}/webapps/geoserver

## Global variables affecting WMS | https://docs.geoserver.org/latest/en/user/services/wms/global.html#wms-global-variables
ARG ENABLE_JSONP=true
ARG MAX_FILTER_RULES=20
ARG OPTIMIZE_LINE_WIDTH=false

ENV MAX_FILTER_RULES=${MAX_FILTER_RULES} \
    OPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH} \
    ENABLE_JSONP=${ENABLE_JSONP}

ENV GS_OPTIONS=" \
  -XX:PerfDataSamplingInterval=500 -Dorg.geotools.referencing.forceXY=true \
  -DMAX_FILTER_RULES=${MAX_FILTER_RULES} \
  -DOPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH} \
  -Duser.timezone=UTC \
  -Dorg.geotools.shapefile.datetime=true \
  -DENABLE_JSONP=${ENABLE_JSONP}"

## Container Considerations | https://docs.geoserver.org/stable/en/user/production/container.html#optimize-your-jvm
ARG GS_INITIAL_MEMORY=1G
ARG GS_MAXIMUM_MEMORY=4G

ENV GS_INITIAL_MEMORY=${GS_INITIAL_MEMORY} \
    GS_MAXIMUM_MEMORY=${GS_MAXIMUM_MEMORY}

ENV JAVA_OPTS="-Xms${GS_INITIAL_MEMORY} -Xmx${GS_MAXIMUM_MEMORY} \
  -Djava.awt.headless=true -server \
  -Dfile.encoding=UTF8 \
  -Djavax.servlet.request.encoding=UTF-8 \
  -Djavax.servlet.response.encoding=UTF-8 \
  -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=20 -XX:ConcGCThreads=5 \
  ${GS_OPTIONS}"

COPY ./scripts/start-geoserver.sh ./
RUN chmod +x start-geoserver.sh

WORKDIR ${GEOSERVER_HOME}
EXPOSE 8080

CMD ["/start-geoserver.sh", "run"]