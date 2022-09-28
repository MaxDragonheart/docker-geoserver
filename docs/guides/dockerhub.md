# Docker Hub
## Login to Docker Hub

`docker login`

## Push new images

Build: `docker build -t maxdragonheart/geoserver:<TAG> .`

Push: `docker push maxdragonheart/geoserver:<TAG>`

## Rename image's TAG to latest

Rename: `docker tag maxdragonheart/geoserver:<TAG> maxdragonheart/geoserver:latest`

Push: `docker push maxdragonheart/geoserver:latest`
