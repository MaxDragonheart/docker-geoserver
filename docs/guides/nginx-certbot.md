# NGINX-Certbot

If Apache2 is up, it's necessary to put it down.
Check Apache2 status: `sudo systemctl status apache2`
Stop Apache2: `sudo systemctl stop apache2`

## Create an SSL certificate with Certbot

Start the NGINX stack:

    docker compose -f staging-nginx.yml up -d --build

Enter the nginx service:

    docker compose -f staging-nginx.yml exec nginx bash

Make certificate:

    certbot --nginx -d domain.com -d www.domain.com

For the current `2.24.2` release path, the active reverse-proxy behavior lives in `staging-nginx.yml` and `nginx/files/geoserver.conf`. The tracked `files/geoserver/web.xml` overlay is not copied into the current image build, so this guide does not rely on repository-managed `GEOSERVER_CSRF_WHITELIST` edits.

Runtime validation on 2026-03-22 confirmed that the bundled GeoServer WAR still contains a `PROXY_BASE_URL` entry, but this repository does not currently manage that file through the tracked overlay path.

If you need custom GeoServer proxy-base or CSRF behavior beyond the current NGINX setup, handle it in a dedicated configuration proposal before release.

## Renew SSL certificate

LetsEncrypt will only allow renewal when the certificate is within 30 days of expiry. Once renewed the new certificate will be valid for 90 days from the date of renewal.

    certbot renew --nginx
