# Geoserver Image Management

## Docker

Build: `docker build -t LAYER-NAME .`

Build with args: `docker build --build-arg ARG1=VALUE1 --build-arg ARG2=VALUE2 -t LAYER-NAME .`

Run and access to container: `sudo docker run -it LAYER-NAME` 

Start container: `sudo docker container run -it -d --name CONTAINER-NAME -p 8081:8080 LAYER-NAME`
