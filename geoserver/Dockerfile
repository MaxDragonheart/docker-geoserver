# syntax=docker/dockerfile:1

## ULGIS as Layer
#FROM maxdragonheart/ulgis:latest as gis-os Switch to this with issue #37
FROM ubuntu:20.04 as base-os
RUN apt update -y && apt upgrade -y && apt -y autoremove

FROM base-os as gis-os

### In use till then will solve the issue #37 ###
# Install useful packages
RUN apt install -y \
    nano \
    unzip \
    wget \
    curl \
    aptitude
### ###

WORKDIR /
# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
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
ARG GS_HTTP_PORT=8300

ENV \
    TOMCAT_VERSION=${TOMCAT_VERSION} \
    TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    TOMCAT_DOWNLOAD_FOLDER=tomcat-${TOMCAT_VERSION} \
    CATALINA_HOME=${CATALINA_HOME} \
    GS_HTTP_PORT=${GS_HTTP_PORT}

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
FROM base-os as tmp_image
## Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
## Install useful stuffs
RUN apt install -y unzip wget

ARG GS_VERSION=2.24.1
ARG GS_DEMO_DATA=False

ENV GS_VERSION=${GS_VERSION} \
    GS_DEMO_DATA=${GS_DEMO_DATA}

## Download Geoserver
RUN mkdir -p data/geoserver
COPY scripts/download-geoserver.sh /download-geoserver.sh
RUN chmod +x download-geoserver.sh
RUN ./download-geoserver.sh

## Download extensions
RUN mkdir -p data/plugins
COPY scripts/download-extensions.sh /download-extensions.sh
RUN chmod +x download-extensions.sh
RUN ./download-extensions.sh

# Tomcat as Layer
FROM tomcat as geoserver

#ENV LIBJPEG_VERSION=3.0.1
#RUN apt install -y cmake nasm \
#    && wget https://nav.dl.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_VERSION}/libjpeg-turbo-${LIBJPEG_VERSION}.tar.gz \
#    && tar -zxf ./libjpeg-turbo-${LIBJPEG_VERSION}.tar.gz \
#    && cd libjpeg-turbo-${LIBJPEG_VERSION} && cmake -G"Unix Makefiles" && make deb \
#    && dpkg -i ./libjpeg*.deb && apt -f install \
#    && apt -y purge cmake nasm\
#    && apt clean \
#    && apt -y autoclean \
#    && apt -y autoremove \
#    && rm -rf /var/lib/apt/lists/* \
#    && rm -rf /tmp/* \
#    && rm -rf /var/tmp/* \
#    && rm -rf /usr/share/man/* \
#    && rm -rf /usr/share/doc/*
#RUN rm -rf libjpeg-turbo-${LIBJPEG_VERSION} libjpeg-turbo-${LIBJPEG_VERSION}.tar.gz

RUN mkdir ${CATALINA_HOME}/webapps/geoserver
# Copy Geoserver version and its plugins from a tmp image to main image
COPY --from=tmp_image data/geoserver ${CATALINA_HOME}/webapps/geoserver
COPY --from=tmp_image data/plugins ${CATALINA_HOME}/webapps/geoserver/WEB-INF/lib
COPY files/geoserver/web.xml ${CATALINA_HOME}/webapps/geoserver/WEB-INF

ENV GEOSERVER_HOME=${CATALINA_HOME}/webapps/geoserver

#ARG GEOSERVER_DATA_DIR=""
## Global variables affecting WMS | https://docs.geoserver.org/latest/en/user/services/wms/global.html#wms-global-variables
#ARG ENABLE_JSONP=true
ARG MAX_FILTER_RULES=20
ARG OPTIMIZE_LINE_WIDTH=false
## Proxy Base URL | https://docs.geoserver.org/latest/en/user/configuration/globalsettings.html#proxy-base-url
#ARG DALLOW_ENV_PARAMETRIZATION=false
#ARG PROXY_BASE_URL=""
## Disable the GeoServer web administration interface | https://docs.geoserver.org/latest/en/user/production/config.html#disable-the-geoserver-web-administration-interface
#ARG DISABLE_WEB_INTERFACE=false
## CSRF Protection | https://docs.geoserver.org/stable/en/user/security/webadmin/csrf.html#csrf-protection
#ARG CSRF_WHITELIST="*"

ENV MAX_FILTER_RULES=${MAX_FILTER_RULES} \
    OPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH}
#    ENABLE_JSONP=${ENABLE_JSONP}

ENV GS_OPTIONS=" \
  -XX:PerfDataSamplingInterval=500 -Dorg.geotools.referencing.forceXY=true \
  -DMAX_FILTER_RULES=${MAX_FILTER_RULES} \
  -DOPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH} \
  -Duser.timezone=UTC \
  -Dorg.geotools.shapefile.datetime=true"
#  -DENABLE_JSONP=${ENABLE_JSONP} \
#  -DNETCDF_DATA_DIR=${NETCDF_DATA_DIR} \
#  -DGRIB_CACHE_DIR=${GRIB_CACHE_DIR} \
#  -DGEOSERVER_CSRF_WHITELIST=${CSRF_WHITELIST} \
#  -DGEOSERVER_CSRF_WHITELIST=true \

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
EXPOSE ${GS_HTTP_PORT}

CMD ["/start-geoserver.sh", "run"]