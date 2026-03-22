# Geoserver Extensions

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

## Install another extension

For the current `2.24.2` release path, extensions are baked into the image during build time. The active source of truth is `scripts/download-extensions.sh`.

`files/geoserver/extensions.txt` is a reference list only and is not consumed by the current build.

To add another extension:

1. Add the extension download URL to `scripts/download-extensions.sh`.
2. Rebuild the image:

        docker compose -f staging.yml build geoserver

3. Restart the stack:

        docker compose -f staging.yml up -d
