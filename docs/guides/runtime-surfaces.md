# Runtime Surfaces

This guide defines which tracked files are active in the current `2.24.2` release path and which ones are reference-only.

## Active in the Current Build

| Path | Status | Purpose |
| --- | --- | --- |
| `Dockerfile` | Active | Main image build and runtime assembly |
| `scripts/download-geoserver.sh` | Active | Downloads the GeoServer WAR for `GS_VERSION` |
| `scripts/download-extensions.sh` | Active | Downloads the extension JAR set used by the image |
| `scripts/start-geoserver.sh` | Active | Exports `JAVA_OPTS` and starts Tomcat |
| `scripts/demo-data.sh` | Active | Removes bundled demo content when disabled |
| `files/tomcat/tomcat-users.xml` | Active | Provides Tomcat manager credentials |
| `files/tomcat/web.xml` | Active | Overrides Tomcat web configuration |
| `staging.yml` | Active | Base GeoServer Compose stack |
| `staging-nginx.yml` | Active | GeoServer plus NGINX Compose stack |
| `nginx/files/geoserver.conf` | Active | Reverse proxy configuration for `/geoserver` |

## Tracked but Intentionally Inactive

| Path | Status | Current meaning |
| --- | --- | --- |
| `files/geoserver/web.xml` | Inactive | Tracked reference file; not copied by the current Docker build |
| `files/tomcat/context.xml` | Inactive | Tracked reference file; not copied by the current Docker build |
| `files/geoserver/extensions.txt` | Reference only | Useful extension list, but not consumed by the current build |
| `archive/download-tomcat.sh` | Archived helper | Historical helper, not part of the current image flow |

## CSRF and Proxy Notes

- The current `2.24.2` release path does **not** ship the tracked `files/geoserver/web.xml` overlay.
- Runtime validation on 2026-03-22 confirmed that the bundled GeoServer WAR still contains a `PROXY_BASE_URL` entry in `WEB-INF/web.xml`.
- The current NGINX path is implemented through `staging-nginx.yml` and `nginx/files/geoserver.conf`.
- Runtime validation did **not** confirm repository-managed `GEOSERVER_CSRF_WHITELIST` wiring in the current build path.
- If custom GeoServer proxy-base or CSRF behavior must be restored, handle it in a dedicated proposal instead of editing release docs ad hoc.
