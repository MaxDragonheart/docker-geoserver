# Geoserver Docker Image

Geoserver's version 2.20.1, that runs on port 8300 as default with minimum 2GB and maximum 4GB  of RAM.

Version tagged `low_cost_server` has minimum 512MB and maximum 2GB  of RAM.

## Credentials

Username: `admin`

Password: `geoserver`

## Pre-installed extensions

- [GDAL](https://docs.geoserver.org/stable/en/user/data/raster/gdal.html)
- [Importer](https://docs.geoserver.org/latest/en/user/extensions/importer/index.html)
- [JP2K Plugin](https://docs.geoserver.org/latest/en/user/extensions/jp2k/index.html)
- [Monitoring](https://docs.geoserver.org/latest/en/user/extensions/jp2k/index.html)
- [Cross-layer filtering](https://docs.geoserver.org/latest/en/user/extensions/querylayer/index.html)
- [Vector Tiles](https://docs.geoserver.org/latest/en/user/extensions/vectortiles/index.html)
- [Web Coverage Service 2.0 Earth Observation extensions](https://docs.geoserver.org/latest/en/user/extensions/wcs20eo/index.html)
- [WMTS Multidimensional](https://docs.geoserver.org/latest/en/user/extensions/wmts-multidimensional/install.html)
- [INSPIRE](https://docs.geoserver.org/stable/en/user/extensions/inspire/index.html)

## Run project
Build: `docker-compose -f docker-compose.yml up -d --build`

## Links
- [Extensions list](https://docs.geoserver.org/latest/en/user/extensions/index.html#extensions)
- [Running in a production environment](https://docs.geoserver.org/latest/en/user/production/index.html#production)
- [GeoServer data directory](https://docs.geoserver.org/latest/en/user/datadirectory/index.html#datadir)
