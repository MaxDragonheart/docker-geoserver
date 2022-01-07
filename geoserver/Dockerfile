# syntax=docker/dockerfile:1

# Image useful for stuffs collection
FROM ubuntu:20.04 as tmp_image
## Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
## Update&Upgrade Ubuntu
RUN apt-get update && apt upgrade -y
## Install useful stuffs and download extensions
RUN apt-get install -y unzip wget
RUN mkdir -p geoserver/plugins
COPY ./files/extensions.txt /geoserver
WORKDIR /
COPY scripts/download-plugins.sh /download-plugins.sh
RUN chmod +x download-plugins.sh
RUN ./download-plugins.sh

# ULGIS as Layer
FROM gisconsultant/ulgis as gis-os
## Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
## Update&Upgrade and install useful stuffs
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y unzip wget systemctl default-jdk

# GIS-OS as Layer
## Geoserver Web Archive Installation
## https://docs.geoserver.org/latest/en/user/installation/war.html
## Environment Variables
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.56
ARG CATALINA_HOME=/opt/tomcat

ENV \
    TOMCAT_VERSION=${TOMCAT_VERSION} \
    TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    TOMCAT_DOWNLOAD_FOLDER=tomcat-${TOMCAT_VERSION} \
    CATALINA_HOME=${CATALINA_HOME}

FROM gis-os as tomcat
RUN mkdir ${TOMCAT_DOWNLOAD_FOLDER}
RUN mkdir -p ${CATALINA_HOME}
WORKDIR ${TOMCAT_DOWNLOAD_FOLDER}
RUN wget ${TOMCAT_LINK} \
    && tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C ${CATALINA_HOME} --strip-components=1
WORKDIR /
RUN rm -rf ${TOMCAT_DOWNLOAD_FOLDER}
COPY files/context.xml ${CATALINA_HOME}/webapps/manager/META-INF
COPY files/tomcat-users.xml ${CATALINA_HOME}/conf
COPY scripts/tomcat.service /etc/systemd/system/tomcat.service

# TOMCAT as Layer
## Environment Variables
ARG GEOSERVER_VERSION=2.20.1
ARG HTTP_PORT=8080/tcp

ENV \
    GEOSERVER_VERSION=${GEOSERVER_VERSION} \
    GEOSERVER_DOWNLOAD_FOLDER=geoserver-${GEOSERVER_VERSION} \
    HTTP_PORT=${HTTP_PORT} \
    GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip"

RUN echo "---> Geoserver Version: $GEOSERVER_VERSION"
RUN echo "---> HTTP port: $HTTP_PORT"

FROM tomcat as geoserver_tmp
RUN mkdir ${GEOSERVER_DOWNLOAD_FOLDER}
RUN mkdir ${CATALINA_HOME}/webapps/geoserver

WORKDIR ${GEOSERVER_DOWNLOAD_FOLDER}
RUN wget ${GEOSERVER_LINK} \
    && unzip geoserver-${GEOSERVER_VERSION}-war.zip '*.war' \
    && mv geoserver.war ${CATALINA_HOME}/webapps
WORKDIR /
RUN rm -rf ${GEOSERVER_DOWNLOAD_FOLDER}
COPY files/web.xml ${CATALINA_HOME}/conf
WORKDIR ${CATALINA_HOME}/webapps
RUN unzip geoserver.war -d ${CATALINA_HOME}/webapps/geoserver
RUN rm geoserver.war

COPY --from=tmp_image /geoserver/plugins ${CATALINA_HOME}/webapps/geoserver/WEB-INF/lib

EXPOSE ${HTTP_PORT}

CMD ["/opt/tomcat/bin/catalina.sh", "run"]