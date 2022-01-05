# syntax=docker/dockerfile:1

# Official Geosolutions/Geoserver Image as Layer
FROM geosolutionsit/geoserver as geoserver

ENV TOMCAT_CONF=/usr/local/tomcat/conf

COPY files/web.xml $TOMCAT_CONF

#CMD ["pwd"]

# Important folder
# webapps/geoserver/WEB-INF <-- si mettono i plugins
# webapps/geoserver/data <-- si mettono i dati cartografici e degli utenti
