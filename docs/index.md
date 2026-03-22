# Geoserver Docker Image

[Geoserver](https://geoserver.org/) is currently released from this repository on the `2.24.2` line. The current release target is `dg2.24.2-r2026.1`.

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
Use `.env` to customize your version:
```
GS_VERSION=2.24.2
GS_DEMO_DATA=False
GS_HTTP_PORT=8600
GS_INITIAL_MEMORY=2G
GS_MAXIMUM_MEMORY=6G
```

Base stack: `docker compose -f staging.yml up -d --build`

NGINX stack: `docker compose -f staging-nginx.yml up -d --build`

## Release Readiness

- Release policy: `docs/guides/release-policy.md`
- Runtime/config surface map: `docs/guides/runtime-surfaces.md`

## Official Geoserver Documentation
- [Extensions list](https://docs.geoserver.org/latest/en/user/extensions/index.html#extensions)
- [Running in a production environment](https://docs.geoserver.org/latest/en/user/production/index.html#production)
- [GeoServer data directory](https://docs.geoserver.org/latest/en/user/datadirectory/index.html#datadir)
