# Geoserver Docker Image

Current release line: `dg2.24.2-r2026.1`

This repository currently targets GeoServer `2.24.2`. Release-readiness work for the `dg2.24.2-r2026.1` line is intentionally separate from the future proposal that will jump to a newer upstream stable series.

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
- [INSPIRE](https://docs.geoserver.org/latest/en/user/extensions/inspire/index.html)

## Run project
Use `.env` to customize your version:
```
GS_VERSION=2.24.2
GS_DEMO_DATA=False
GS_INITIAL_MEMORY=2G
GS_MAXIMUM_MEMORY=6G
GS_HTTP_PORT=8600
```

Base stack: `docker compose -f staging.yml up -d --build`

NGINX stack: `docker compose -f staging-nginx.yml up -d --build`

## Release Policy

Primary release tags follow `dg<geoserver-version>-r<year>.<revision>`.

Current example:

- `dg2.24.2-r2026.1`

See `docs/guides/release-policy.md` for the release flow and validation checklist.

## Active Configuration Notes

- `files/tomcat/tomcat-users.xml` and `files/tomcat/web.xml` are active in the current image build.
- `files/geoserver/web.xml` and `files/tomcat/context.xml` are tracked but intentionally inactive in the current `2.24.2` release path.
- `files/geoserver/extensions.txt` is a reference list only. The active extension source of truth is `scripts/download-extensions.sh`.
- The current NGINX path is driven by `staging-nginx.yml` and `nginx/files/geoserver.conf`.

## Official Geoserver Documentation
- [Extensions list](https://docs.geoserver.org/latest/en/user/extensions/index.html#extensions)
- [Running in a production environment](https://docs.geoserver.org/latest/en/user/production/index.html#production)
- [GeoServer data directory](https://docs.geoserver.org/latest/en/user/datadirectory/index.html#datadir)
