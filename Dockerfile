ARG TOMCAT_VERSION=9.0-jdk11-temurin-focal

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
ARG GS_VERSION=2.24.1

## Download Geoserver
COPY scripts/download-geoserver.sh ./download-geoserver.sh
RUN chmod +x download-geoserver.sh
RUN ./download-geoserver.sh
## Download extensions
COPY scripts/download-extensions.sh ./download-extensions.sh
RUN chmod +x download-extensions.sh
RUN ./download-extensions.sh

FROM tomcat as geoserver
ARG GS_HTTP_PORT=8080

# Install GDAL stuffs
RUN apt-get install -y \
    gdal-bin \
    libgdal-dev \
    libgdal-java

ENV GEOSERVER_HOME=$CATALINA_HOME/webapps/geoserver \
    GS_HTTP_PORT=${GS_HTTP_PORT}

COPY --from=tmp_image_geoserver $CATALINA_HOME/geoserver $GEOSERVER_HOME
COPY --from=tmp_image_geoserver $CATALINA_HOME/plugins $GEOSERVER_HOME/WEB-INF/lib

WORKDIR $GEOSERVER_HOME

## Global variables affecting WMS | https://docs.geoserver.org/latest/en/user/services/wms/global.html#wms-global-variables
ARG ENABLE_JSONP=true
ARG MAX_FILTER_RULES=20
ARG OPTIMIZE_LINE_WIDTH=false

ENV MAX_FILTER_RULES=${MAX_FILTER_RULES} \
    OPTIMIZE_LINE_WIDTH=${OPTIMIZE_LINE_WIDTH} \
    ENABLE_JSONP=${ENABLE_JSONP}

## Container Considerations | https://docs.geoserver.org/stable/en/user/production/container.html#optimize-your-jvm
ARG GS_INITIAL_MEMORY=1G
ARG GS_MAXIMUM_MEMORY=4G

ENV GS_INITIAL_MEMORY=${GS_INITIAL_MEMORY} \
    GS_MAXIMUM_MEMORY=${GS_MAXIMUM_MEMORY}

COPY ./scripts/start-geoserver.sh ./
RUN chmod +x start-geoserver.sh

EXPOSE ${GS_HTTP_PORT}

## Remove demo data
ARG GS_DEMO_DATA=True
ENV GS_DEMO_DATA=${GS_DEMO_DATA}
COPY scripts/demo-data.sh ./
RUN chmod +x demo-data.sh
RUN ./demo-data.sh

#ENTRYPOINT ["/bin/bash"]
CMD ["./start-geoserver.sh", "run"]

#FROM tomcat AS geoserver
#
#ARG GS_VERSION=2.24.1
#ENV GEOSERVER_ZIP=geoserver-$GS_VERSION-war.zip
#ENV GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/$GS_VERSION/$GEOSERVER_ZIP"
#
#RUN echo " ---> Start Geoserver $GS_VERSION download in $CATALINA_TMPDIR"
#RUN wget "$GEOSERVER_LINK" -P "$CATALINA_TMPDIR"
#
#RUN echo " ---> Unzip and copy Geoserver"
#RUN unzip $CATALINA_TMPDIR/$GEOSERVER_ZIP '*.war' -d $CATALINA_TMPDIR
#RUN unzip $CATALINA_TMPDIR/geoserver.war -d $CATALINA_TMPDIR/geoserver
#
#RUN echo " ---> Install Geoserver $GS_VERSION in $CATALINA_TMPDIR"
#RUN rm -rf $CATALINA_TMPDIR/$GEOSERVER_ZIP $CATALINA_TMPDIR/geoserver.war
#RUN rm -rf $CATALINA_TMPDIR/geoserver/.gitignore
#RUN mv $CATALINA_TMPDIR/geoserver $CATALINA_HOME/webapps
#RUN rm -rf $CATALINA_TMPDIR/geoserver


#
#EXPOSE 8080