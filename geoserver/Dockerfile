# syntax=docker/dockerfile:1

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
ARG HTTP_PORT

ENV \
    TOMCAT_VERSION=${TOMCAT_VERSION} \
    TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    TOMCAT_DOWNLOAD_FOLDER=tomcat-${TOMCAT_VERSION} \
    CATALINA_HOME=${CATALINA_HOME} \
    HTTP_PORT=${HTTP_PORT}

FROM gis-os as tomcat
RUN mkdir -p ${CATALINA_HOME}

RUN mkdir ${TOMCAT_DOWNLOAD_FOLDER}
WORKDIR ${TOMCAT_DOWNLOAD_FOLDER}
RUN wget ${TOMCAT_LINK} \
    && tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C ${CATALINA_HOME} --strip-components=1
WORKDIR /
RUN rm -rf ${TOMCAT_DOWNLOAD_FOLDER}
#COPY files/tomcat/context.xml ${CATALINA_HOME}/webapps/manager/META-INF
COPY files/tomcat/tomcat-users.xml ${CATALINA_HOME}/conf
COPY files/tomcat/web.xml ${CATALINA_HOME}/conf

# Image useful for stuffs collection
FROM ubuntu:20.04 as tmp_image
## Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
## Update&Upgrade Ubuntu and install useful stuffs
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y unzip wget

ARG GEOSERVER_VERSION

ENV GEOSERVER_VERSION=${GEOSERVER_VERSION}

### Download Geoserver
RUN mkdir -p data/geoserver
COPY scripts/download-geoserver.sh /download-geoserver.sh
RUN chmod +x download-geoserver.sh
RUN ./download-geoserver.sh
## Remove default datadir with demo data
RUN rm -rf /data/geoserver/data
### and copy empty datadir
#COPY ./data /data/geoserver/data

## Download extensions
RUN mkdir -p data/plugins
#COPY files/geoserver/extensions.txt data/
COPY scripts/download-extensions.sh /download-extensions.sh
RUN chmod +x download-extensions.sh
RUN ./download-extensions.sh

# Tomcat as Layer
FROM tomcat as geoserver
ENV LIBJPEG_VERSION=2.0.6
RUN apt-get install -y libgdal-java cmake nasm \
    && wget https://nav.dl.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_VERSION}/libjpeg-turbo-${LIBJPEG_VERSION}.tar.gz \
    && tar -zxf ./libjpeg-turbo-${LIBJPEG_VERSION}.tar.gz \
    && cd libjpeg-turbo-${LIBJPEG_VERSION} && cmake -G"Unix Makefiles" && make deb \
    && dpkg -i ./libjpeg*.deb && apt-get -f install \
    && apt-get -y purge cmake nasm\
    && apt-get clean \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/doc/*

RUN mkdir ${CATALINA_HOME}/webapps/geoserver
COPY --from=tmp_image data/geoserver ${CATALINA_HOME}/webapps/geoserver
COPY --from=tmp_image data/plugins ${CATALINA_HOME}/webapps/geoserver/WEB-INF/lib
COPY files/geoserver/web.xml ${CATALINA_HOME}/webapps/geoserver/WEB-INF

#ARG GEOSERVER_DATA_DIR=""
### Global variables affecting WMS | https://docs.geoserver.org/latest/en/user/services/wms/global.html#wms-global-variables
#ARG ENABLE_JSONP=true
#ARG MAX_FILTER_RULES=20
#ARG OPTIMIZE_LINE_WIDTH=false
### Proxy Base URL | https://docs.geoserver.org/latest/en/user/configuration/globalsettings.html#proxy-base-url
#ARG DALLOW_ENV_PARAMETRIZATION=false
#ARG PROXY_BASE_URL=""
### Disable the GeoServer web administration interface | https://docs.geoserver.org/latest/en/user/production/config.html#disable-the-geoserver-web-administration-interface
#ARG DISABLE_WEB_INTERFACE=false
### CSRF Protection | https://docs.geoserver.org/stable/en/user/security/webadmin/csrf.html#csrf-protection
#ARG CSRF_WHITELIST="*"

ENV GEOSERVER_OPTS=" \
  -Duser.timezone=UTC \
  -Dorg.geotools.shapefile.datetime=true"
#  -DGEOSERVER_LOG_LOCATION=${GEOSERVER_LOG_LOCATION} \
#  -DGEOWEBCACHE_CONFIG_DIR=${GEOWEBCACHE_CONFIG_DIR} \
#  -DGEOWEBCACHE_CACHE_DIR=${GEOWEBCACHE_CACHE_DIR} \
#  -DNETCDF_DATA_DIR=${NETCDF_DATA_DIR} \
#  -DGRIB_CACHE_DIR=${GRIB_CACHE_DIR} \

## Container Considerations | https://docs.geoserver.org/stable/en/user/production/container.html#optimize-your-jvm
ENV INITIAL_MEMORY=1G
ENV MAXIMUM_MEMORY=4G

ENV JAVA_OPTS="-Xms${INITIAL_MEMORY} -Xmx${MAXIMUM_MEMORY} \
  -Djava.awt.headless=true -server \
  -Dfile.encoding=UTF8 \
  -Djavax.servlet.request.encoding=UTF-8 \
  -Djavax.servlet.response.encoding=UTF-8 \
  -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=20 -XX:ConcGCThreads=5 \
  ${GEOSERVER_OPTS}"

COPY ./scripts/start-geoserver.sh ./
RUN chmod +x start-geoserver.sh
## Decomment to test bash file. Make sure to comment all after RUN /start-geoserver.sh
#RUN /start-geoserver.sh

WORKDIR ${CATALINA_HOME}
EXPOSE ${HTTP_PORT}

CMD ["/start-geoserver.sh", "run"]

