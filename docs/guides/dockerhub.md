# Docker Hub

## Login to Docker Hub

`docker login`

## Build a Release Image

Build: `docker build --build-arg GS_VERSION=2.24.2 --build-arg GS_DEMO_DATA=False -t maxdragonheart/geoserver:dg2.24.2-r2026.1 .`

## Push the Primary Release Tag

Push: `docker push maxdragonheart/geoserver:dg2.24.2-r2026.1`

## Optional Alias Tags

Tag: `docker tag maxdragonheart/geoserver:dg2.24.2-r2026.1 maxdragonheart/geoserver:2.24.2`

Push: `docker push maxdragonheart/geoserver:2.24.2`

See `guides/release-policy.md` for the release rules and validation checklist.
