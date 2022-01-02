# syntax=docker/dockerfile:1

# Official Ubuntu Image as Layer
FROM gisconsultant/ulgis as gis-os

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
# Update&Upgrade Ubuntu
RUN apt-get update && apt-get install -y unzip wget

# Environment Variables
## Tomcat
ARG TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.14/bin/apache-tomcat-10.0.14.tar.gz"
ARG TOMCAT_VERSION=10.0.14
ARG TOMCAT_DOWNLOAD_FOLDER=tomcat-${TOMCAT_VERSION}
ENV TOMCAT_LINK=${TOMCAT_LINK}
ENV TOMCAT_VERSION=${TOMCAT_VERSION}
ENV TOMCAT_DOWNLOAD_FOLDER=${TOMCAT_DOWNLOAD_FOLDER}
## Geoserver
ARG GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/2.20.1/geoserver-2.20.1-war.zip"
ARG GEOSERVER_VERSION=2.20.1
ARG GEOSERVER_DOWNLOAD_FOLDER=geoserver-${GEOSERVER_VERSION}
ENV GEOSERVER_LINK=${GEOSERVER_LINK}
ENV GEOSERVER_VERSION=${GEOSERVER_VERSION}
ENV GEOSERVER_DOWNLOAD_FOLDER=${GEOSERVER_DOWNLOAD_FOLDER}
## Miscellanea
ARG PORT=8080/tcp
ENV PORT=${PORT}

# GIS-OS as Layer
FROM gis-os as java_jdk
RUN apt-get install default-jdk -y
#CMD ["java", "-version"]

# JAVA JDK as Layer
FROM java_jdk as tomcat
RUN useradd -m -d /opt/tomcat -U -s /bin/false tomcat
RUN mkdir ${TOMCAT_DOWNLOAD_FOLDER}
WORKDIR ${TOMCAT_DOWNLOAD_FOLDER}
RUN wget ${TOMCAT_LINK} \
    && tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat --strip-components=1 ##\
RUN chown -R tomcat:tomcat /opt/tomcat/ \
    && chmod -R u+x /opt/tomcat/bin
WORKDIR /
RUN rm -rf ${TOMCAT_DOWNLOAD_FOLDER}
#CMD ["cat", "/etc/passwd"]

# TOMCAT as Layer
FROM tomcat as geoserver
RUN mkdir ${GEOSERVER_DOWNLOAD_FOLDER}
WORKDIR ${GEOSERVER_DOWNLOAD_FOLDER}
RUN wget ${GEOSERVER_LINK} \
    && unzip geoserver-${GEOSERVER_VERSION}-war.zip \
    && cp geoserver.war /opt/tomcat/webapps
#    && cp geoserver.war /opt/tomcat/apache-tomcat-${TOMCAT_VERSION}/webapps

#FROM geoserver as geoserver_exec
#COPY geoserver.war /opt/tomcat/apache-tomcat-${TOMCAT_VERSION}/webapps
#COPY geoserver.war /opt/tomcat/apache-tomcat-${TOMCAT_VERSION}/webapps
WORKDIR /
RUN rm -rf ${GEOSERVER_DOWNLOAD_FOLDER}

COPY files/tomcat-users.xml /opt/tomcat/conf
COPY files/web.xml /opt/tomcat/conf
#COPY files/context.xml /opt/tomcat/conf
COPY scripts/tomcat.service /etc/systemd/system/tomcat.service

EXPOSE ${PORT}

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
