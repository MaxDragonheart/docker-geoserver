# Geoserver-Drako 
Inspired from [geosolutions-it/docker-geoserver](https://github.com/geosolutions-it/docker-geoserver).

## Docker
Build: `docker build -t LAYER-NAME .`

Run and access to container: `docker run -it LAYER-NAME`

## Docker Compose
Build: `docker-compose -f docker-compose.yml build`

Run: `docker-compose -f docker-compose.yml up`

Run permanently: `docker-compose -f docker-compose.yml up -d`

Access to container: `docker exec -it COINTAINERID bin`

Full Docke command list [here](https://docs.docker.com/engine/reference/commandline/docker/).

## Geoserver

- [Extensions list](https://docs.geoserver.org/latest/en/user/extensions/index.html#extensions)
- [Running in a production environment](https://docs.geoserver.org/latest/en/user/production/index.html#production)
- [GeoServer data directory](https://docs.geoserver.org/latest/en/user/datadirectory/index.html#datadir)

### Install Extension
0. Put down Geoserver:

        docker-compose -f docker-compose-dev.yml down

1. Copy `.jar` into plugin's folder:

         sudo cp -R DOWNLOAD_FOLDER/* /var/lib/docker/volumes/geoserver-drako_geoserver-plugin/_data/lib

2. Change `lib` ownership:

        chown -R USERNAME:USERNAME lib/

3. Put UP Geoserver:

        sudo docker-compose -f docker-compose-dev.yml up -d

### Use earlier folder
0. Put down Geoserver:

        docker-compose -f docker-compose-dev.yml down

1. Delete `datadir`:

        rm -rf /var/lib/docker/volumes/geoserver-drako_geoserver-data/_data/datadir

2. Create `datadir`:

        mkdir datadir

3. Copy all data from earlier folder to `datadir`:

        sudo cp -r EARLIER_FOLDER_NAME/* /var/lib/docker/volumes/geoserver-drako_geoserver-data/_data/datadir
   
4. Change `datadir` ownership:

        chown -R USERNAME:USERNAME datadir/
   
5. Put UP Geoserver:

        sudo docker-compose -f docker-compose-dev.yml up -d