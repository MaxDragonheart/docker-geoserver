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

FROM tomcat AS geoserver

ARG GS_VERSION=2.24.1
ENV GEOSERVER_ZIP=geoserver-$GS_VERSION-war.zip
ENV GEOSERVER_LINK="http://sourceforge.net/projects/geoserver/files/GeoServer/$GS_VERSION/$GEOSERVER_ZIP"

RUN echo " ---> Start Geoserver $GS_VERSION download in $CATALINA_TMPDIR"
RUN wget "$GEOSERVER_LINK" -P "$CATALINA_TMPDIR"

RUN echo " ---> Unzip and copy Geoserver"
RUN unzip $CATALINA_TMPDIR/$GEOSERVER_ZIP '*.war' -d $CATALINA_TMPDIR
RUN unzip $CATALINA_TMPDIR/geoserver.war -d $CATALINA_TMPDIR/geoserver

RUN echo " ---> Install Geoserver $GS_VERSION in $CATALINA_TMPDIR"
RUN rm -rf $CATALINA_TMPDIR/$GEOSERVER_ZIP $CATALINA_TMPDIR/geoserver.war
RUN rm -rf $CATALINA_TMPDIR/geoserver/.gitignore
RUN mv $CATALINA_TMPDIR/geoserver $CATALINA_HOME/webapps
RUN rm -rf $CATALINA_TMPDIR/geoserver

ENTRYPOINT ["/bin/bash"]

EXPOSE 8080