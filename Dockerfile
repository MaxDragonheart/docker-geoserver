ARG TOMCAT_VERSION=9.0.85-jdk11-temurin-focal

FROM tomcat:$TOMCAT_VERSION AS tomcat

ENV JAVA_HOME=/opt/java/openjdk \
    CATALINA_BASE=/usr/local/tomcat \
    CATALINA_HOME=/usr/local/tomcat \
    CATALINA_TMPDIR=/usr/local/tomcat/temp

RUN rm -rf webapps
RUN mv webapps.dist webapps

RUN apt-get update -y
RUN apt-get install -y \
    unzip

FROM tomcat AS tmp_image_geoserver
ARG GS_VERSION=2.24.2

## Download Geoserver
COPY scripts/download-geoserver.sh ./download-geoserver.sh
RUN chmod +x download-geoserver.sh
RUN ./download-geoserver.sh

## Download extensions
COPY scripts/download-extensions.sh ./download-extensions.sh
RUN chmod +x download-extensions.sh
RUN ./download-extensions.sh

FROM tomcat AS geoserver

# Install GDAL stuffs
RUN apt-get install -y \
    gdal-bin \
    libgdal-java \
    libgdal-dev

ENV GEOSERVER_HOME=$CATALINA_HOME/webapps/geoserver

COPY --from=tmp_image_geoserver $CATALINA_HOME/geoserver $GEOSERVER_HOME
COPY --from=tmp_image_geoserver $CATALINA_HOME/plugins $GEOSERVER_HOME/WEB-INF/lib

WORKDIR $GEOSERVER_HOME

FROM geoserver AS geoserver-production
ARG GS_HTTP_PORT=8080
ENV GS_HTTP_PORT=$GS_HTTP_PORT

#COPY files/tomcat/context.xml $CATALINA_HOME/webapps/manager/META-INF
COPY files/tomcat/tomcat-users.xml $CATALINA_HOME/conf
COPY files/tomcat/web.xml $CATALINA_HOME/conf
#COPY files/geoserver/web.xml $CATALINA_HOME/webapps/geoserver/WEB-INF

## Global variables affecting WMS | https://docs.geoserver.org/latest/en/user/services/wms/global.html#wms-global-variables
ARG ENABLE_JSONP=true
ARG MAX_FILTER_RULES=20
ARG OPTIMIZE_LINE_WIDTH=false

ENV MAX_FILTER_RULES=$MAX_FILTER_RULES \
    OPTIMIZE_LINE_WIDTH=$OPTIMIZE_LINE_WIDTH \
    ENABLE_JSONP=$ENABLE_JSONP

## Container Considerations | https://docs.geoserver.org/stable/en/user/production/container.html#optimize-your-jvm
ARG GS_INITIAL_MEMORY=1G
ARG GS_MAXIMUM_MEMORY=4G

ENV GS_INITIAL_MEMORY=$GS_INITIAL_MEMORY \
    GS_MAXIMUM_MEMORY=$GS_MAXIMUM_MEMORY

COPY ./scripts/start-geoserver.sh ./
RUN chmod +x start-geoserver.sh

## Remove demo data
ARG GS_DEMO_DATA=False
ENV GS_DEMO_DATA=$GS_DEMO_DATA
COPY scripts/demo-data.sh ./
RUN chmod +x demo-data.sh
RUN ./demo-data.sh

EXPOSE $GS_HTTP_PORT

# FOR TEST ONLY
#ENTRYPOINT ["/bin/bash"]
CMD ["./start-geoserver.sh", "run"]