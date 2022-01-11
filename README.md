# Geoserver-Drako

## Docker
Build: `docker build -t LAYER-NAME .`

Run and access to container: `docker run -it LAYER-NAME`

## Docker Compose
Build: `docker-compose -f docker-compose.yml build`

Run: `docker-compose -f docker-compose.yml up`

Run permanently: `docker-compose -f docker-compose.yml up -d`

Access to container: `docker exec -it COINTAINERID bin`

Full Docker command list [here](https://docs.docker.com/engine/reference/commandline/docker/).

## Geoserver

### Credentials

Username: `admin`

Password: `geoserver`

### Useful extensions

- [GDAL](https://docs.geoserver.org/stable/en/user/data/raster/gdal.html)
- [Importer](https://docs.geoserver.org/latest/en/user/extensions/importer/index.html)
- [JP2K Plugin](https://docs.geoserver.org/latest/en/user/extensions/jp2k/index.html)
- [Monitoring](https://docs.geoserver.org/latest/en/user/extensions/jp2k/index.html)
- [Cross-layer filtering](https://docs.geoserver.org/latest/en/user/extensions/querylayer/index.html)
- [Vector Tiles](https://docs.geoserver.org/latest/en/user/extensions/vectortiles/index.html)
- [Web Coverage Service 2.0 Earth Observation extensions](https://docs.geoserver.org/latest/en/user/extensions/wcs20eo/index.html)
- [WMTS Multidimensional](https://docs.geoserver.org/latest/en/user/extensions/wmts-multidimensional/install.html)
- [INSPIRE](https://docs.geoserver.org/stable/en/user/extensions/inspire/index.html)

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

        rm -rf /var/lib/docker/volumes/geoserver-drako_geoserver/_data/data

2. Create `datadir`:

        mkdir data

3. Copy all data from earlier folder to `datadir`:

        cp -r EARLIER_FOLDER_NAME/* /var/lib/docker/volumes/geoserver-drako_geoserver/_data/data
   
4. Change `datadir` ownership:

        chown -R USERNAME:USERNAME datadir/
   
5. Put UP Geoserver:

        sudo docker-compose -f docker-compose-dev.yml up -d

### Links
- [Extensions list](https://docs.geoserver.org/latest/en/user/extensions/index.html#extensions)
- [Running in a production environment](https://docs.geoserver.org/latest/en/user/production/index.html#production)
- [GeoServer data directory](https://docs.geoserver.org/latest/en/user/datadirectory/index.html#datadir)

## NGINX

If Apache2 is up, it's necessary to put it down.
Check Apache2 status: `sudo systemctl status apache2`
Stop Apache2: `sudo systemctl stop apache2`


### Create an SSL certificate with Certbot

Enter to the image that use nginx:

    docker exec -it <nginx_img_id> bin/bash

Make certificate:

    certbot --nginx -d domain.com -d www.domain.com