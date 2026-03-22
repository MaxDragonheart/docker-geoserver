# Release Policy

This repository publishes release tags using the GeoServer version that is actually bundled in the image.

## Primary Tag Format

Use this format:

`dg<geoserver-version>-r<year>.<revision>`

Current release example:

`dg2.24.2-r2026.1`

Rules:

- `<geoserver-version>` must match `GS_VERSION`
- `<year>` is the calendar year of the release
- `<revision>` starts at `1` and increments for each additional release in the same year
- The current release line stays on GeoServer `2.24.2`; a future proposal will cover the jump to a newer upstream stable line

## Source of Truth

- `.env` defines the default `GS_VERSION` used by Compose
- `Dockerfile` defines the build-time `GS_VERSION` default
- Repository release notes and image tags must use the same primary tag

## Release Validation Checklist

1. Confirm `.env` and `Dockerfile` still target `GS_VERSION=2.24.2`.
2. Validate the Compose files:

       docker compose -f staging.yml config
       docker compose -f staging-nginx.yml config

3. Build the release image:

       docker build --build-arg GS_VERSION=2.24.2 --build-arg GS_DEMO_DATA=False -t maxdragonheart/geoserver:dg2.24.2-r2026.1 .

4. Validate the local stacks:

       docker compose -f staging.yml up -d --build
       docker compose -f staging-nginx.yml up -d --build

5. Record the validation commands and outcomes in the release proposal or release notes.
6. Push the primary tag first:

       docker push maxdragonheart/geoserver:dg2.24.2-r2026.1

## Optional Alias Tags

If aliases are published, keep them secondary to the primary tag. Example aliases:

- `2.24.2`
- `latest`
