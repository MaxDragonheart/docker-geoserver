# Geoserver Docker Image

The latest version of this image use the latest stable version of Geoserver

On 01-01-2024:

- Geoserver stable version: [2.24.1](https://geoserver.org/download/)

Since 01-01-2024 the image's tag system follow the official Geoserver's versions tag.

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
- [libjpeg-turbo Map Encoder Extension](https://docs.geoserver.org/latest/en/user/extensions/libjpeg-turbo/index.html)

## Run project
Use `.env` to customize your version:
```
GS_VERSION=2.20.4
GS_DEMO_DATA=False
GS_INITIAL_MEMORY=1G
GS_MAXIMUM_MEMORY=4G
GS_HTTP_PORT=8600
```

Build for Compose: `docker compose -f docker-compose.yml up -d --build`

### Active PROXY_BASE_URL and GEOSERVER_CSRF_WHITELIST
Edit `web.xml` using the right PROXY_BASE_URL and GEOSERVER_CSRF_WHITELIST. After the edit use `docker compose -f docker_compose_file.yml restart`.

## Official Geoserver Documentation
- [Extensions list](https://docs.geoserver.org/latest/en/user/extensions/index.html#extensions)
- [Running in a production environment](https://docs.geoserver.org/latest/en/user/production/index.html#production)
- [GeoServer data directory](https://docs.geoserver.org/latest/en/user/datadirectory/index.html#datadir)
