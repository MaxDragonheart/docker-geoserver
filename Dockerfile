# syntax=docker/dockerfile:1

# The official Tomcat's Docker image is based on Amazon Linux 2
FROM maxdragonheart/ulgis:latest as base-os
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
    gettext \
    systemctl  \
    xsltproc


FROM base-os as tmp_image_tomcat
## Download Tomcat
ARG TOMCAT_MAJOR=9
ARG TOMCAT_MINOR=0
ARG TOMCAT_PATCH=79


ENV TOMCAT_MAJOR=${TOMCAT_MAJOR} \
    TOMCAT_MINOR=${TOMCAT_MINOR} \
    TOMCAT_PATCH=${TOMCAT_PATCH}


COPY scripts/tomcat.sh ./tomcat.sh
RUN chmod +x tomcat.sh
RUN ./tomcat.sh


#FROM base-os as gis-os
#WORKDIR /
## Install JAVA and related stuffs
#RUN apt install -y  openjdk-11-jdk
## Install GDAL stuffs
#RUN apt install -y  \
#    libgdal-dev
#    #libgdal-java
#
#
#FROM gis-os as tomcat
#ARG GS_HTTP_PORT=8080
#ENV CATALINA_BASE=/usr/local/tomcat \
#    CATALINA_HOME=/usr/local/tomcat \
#    CATALINA_TMPDIR=/usr/local/tomcat/temp \
#    JRE_HOME=/usr \
#    CLASSPATH=/usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar \
#    CATALINA_CONF=/usr/local/tomcat/conf/ \
#    GS_HTTP_PORT=${GS_HTTP_PORT}
#
#RUN mkdir -p ${CATALINA_HOME}
#COPY --from=tmp_image_tomcat app/downloads/* ${CATALINA_HOME}

#RUN rm -rf webapps/
#RUN mv webapps.dist/ webapps/

## Install GDAL stuffs
#RUN apt install -y libgdal-dev

##COPY files/tomcat/context.xml ${CATALINA_HOME}/webapps/manager/META-INF
#COPY files/tomcat/tomcat-users.xml ${CATALINA_HOME}/conf
#COPY files/tomcat/web.xml ${CATALINA_HOME}/conf
#
#
### Image useful for stuffs collection
#FROM maxdragonheart/ulgis:latest as tmp_image
#ARG GS_VERSION=2.20.4
#
#ENV GS_VERSION=${GS_VERSION}
#
### Download Geoserver
#COPY scripts/download-geoserver.sh ./download-geoserver.sh
#RUN chmod +x download-geoserver.sh
#RUN ./download-geoserver.sh
### Download extensions
#COPY scripts/download-extensions.sh ./download-extensions.sh
#RUN chmod +x download-extensions.sh
#RUN ./download-extensions.sh
#
#
### Tomcat as Layer
#FROM tomcat as geoserver
#RUN mkdir ${CATALINA_HOME}/webapps/geoserver
### Copy Geoserver version and its plugins from a tmp image to main image
#COPY --from=tmp_image app/geoserver ${CATALINA_HOME}/webapps/geoserver
#COPY files/geoserver/web.xml ${CATALINA_HOME}/webapps/geoserver/WEB-INF
#
#ENV GEOSERVER_HOME=${CATALINA_HOME}/webapps/geoserver
#
### Remove demo data
#ARG GS_DEMO_DATA=True
#ENV GS_DEMO_DATA=${GS_DEMO_DATA}
#COPY scripts/demo-data.sh ./demo-data.sh
#RUN chmod +x demo-data.sh
#RUN ./demo-data.sh
#
### Global variables affecting WMS | https://docs.geoserver.org/latest/en/user/services/wms/global.html#wms-global-variables
#ARG ENABLE_JSONP=true
#ARG MAX_FILTER_RULES=20
#ARG OPTIMIZE_LINE_WIDTH=false
#
#ENV MAX_FILTER_RULES=${MAX_FILTER_RULES} \
#    OPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH} \
#    ENABLE_JSONP=${ENABLE_JSONP}
#
### Container Considerations | https://docs.geoserver.org/stable/en/user/production/container.html#optimize-your-jvm
#ARG GS_INITIAL_MEMORY=1G
#ARG GS_MAXIMUM_MEMORY=4G
#
#ENV GS_INITIAL_MEMORY=${GS_INITIAL_MEMORY} \
#    GS_MAXIMUM_MEMORY=${GS_MAXIMUM_MEMORY}
#
#COPY ./scripts/start-geoserver.sh ./
#RUN chmod +x start-geoserver.sh
#
#EXPOSE ${GS_HTTP_PORT}
#
#CMD ["./start-geoserver.sh", "run"]