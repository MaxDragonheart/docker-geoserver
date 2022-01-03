# syntax=docker/dockerfile:1

# Official Ubuntu Image as Layer
FROM gisconsultant/ulgis as gis-os

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
# Update&Upgrade Ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y unzip wget systemctl

# Environment Variables
ARG GEOSERVER_VERSION=2.20.1
ARG GEOSERVER_DOWNLOAD_FOLDER=geoserver-${GEOSERVER_VERSION}
ENV GEOSERVER_VERSION=${GEOSERVER_VERSION}
ENV GEOSERVER_DOWNLOAD_FOLDER=${GEOSERVER_DOWNLOAD_FOLDER}

ARG HTTP_PORT=8080/tcp
ENV HTTP_PORT=${HTTP_PORT}

# GIS-OS as Layer
FROM gis-os as java_jdk
RUN apt-get install default-jdk -y
#CMD ["java", "-version"]

## Geoserver Web Archive Installation
## https://docs.geoserver.org/latest/en/user/installation/war.html
## JAVA JDK as Layer
ARG TOMCAT_MAJOR=9
ARG TOMCAT_VERSION=9.0.56
ARG TOMCAT_DOWNLOAD_FOLDER=tomcat-${TOMCAT_VERSION}
ARG CATALINA_HOME=/opt/tomcat
ENV TOMCAT_VERSION=${TOMCAT_VERSION}
ENV TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
ENV TOMCAT_DOWNLOAD_FOLDER=${TOMCAT_DOWNLOAD_FOLDER}
ENV CATALINA_HOME=${CATALINA_HOME}

FROM java_jdk as tomcat
RUN mkdir ${TOMCAT_DOWNLOAD_FOLDER}
RUN mkdir -p ${CATALINA_HOME}
WORKDIR ${TOMCAT_DOWNLOAD_FOLDER}
RUN wget ${TOMCAT_LINK} \
    && tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C ${CATALINA_HOME} --strip-components=1
WORKDIR /
RUN rm -rf ${TOMCAT_DOWNLOAD_FOLDER}
COPY files/context.xml /opt/tomcat/webapps/manager/META-INF
COPY files/tomcat-users.xml /opt/tomcat/conf
COPY scripts/tomcat.service /etc/systemd/system/tomcat.service

# TOMCAT as Layer
FROM tomcat as geoserver
RUN mkdir ${GEOSERVER_DOWNLOAD_FOLDER}
WORKDIR ${GEOSERVER_DOWNLOAD_FOLDER}

ARG GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip"
ENV GEOSERVER_LINK=${GEOSERVER_LINK}
RUN wget ${GEOSERVER_LINK} \
    && unzip geoserver-${GEOSERVER_VERSION}-war.zip
RUN mv geoserver.war /opt/tomcat/webapps
WORKDIR /
RUN rm -rf ${GEOSERVER_DOWNLOAD_FOLDER}
COPY files/web.xml /opt/tomcat/conf


EXPOSE ${HTTP_PORT}

#CMD ["/opt/tomcat/bin/catalina.sh", "run"]



### Geoserver Binary Installation
### JAVA JDK as Layer
#ARG GEOSERVER_HOME=/usr/share/geoserver/
#ENV GEOSERVER_HOME=${GEOSERVER_HOME}
#
#FROM java_jdk as tomcat
#RUN mkdir ${GEOSERVER_DOWNLOAD_FOLDER}
#RUN mkdir -p ${GEOSERVER_HOME}
#WORKDIR ${GEOSERVER_DOWNLOAD_FOLDER}
#ENV GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip"
#RUN wget ${GEOSERVER_LINK} \
#    && unzip geoserver-${GEOSERVER_VERSION}-bin.zip -d ${GEOSERVER_HOME}
#WORKDIR /
#RUN rm -rf ${GEOSERVER_DOWNLOAD_FOLDER}
#COPY files/web.xml /usr/share/geoserver/webapps/geoserver/WEB-INF
#
#WORKDIR /usr/share/geoserver
#
#EXPOSE ${HTTP_PORT}
#
#CMD ["/usr/share/geoserver/bin/startup.sh", "run"]
