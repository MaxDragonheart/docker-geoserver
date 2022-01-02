# Geoserver Image Management

## Docker

Build: `docker build -t LAYER-NAME .`

Run and access to container: `sudo docker run -it LAYER-NAME` 

Start container: `sudo docker container run -it -d --name CONTAINER-NAME -p 8081:8080 LAYER-NAME`

## Miscellanea

### TOMCAT

Active deamon: `systemctl daemon-reload`

Start: `systemctl start tomcat.service`

Make persistent on Ubuntu: `systemctl enable tomcat.service`

Check status: `systemctl status tomcat.service`