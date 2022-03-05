# NGINX-Certbot

If Apache2 is up, it's necessary to put it down.
Check Apache2 status: `sudo systemctl status apache2`
Stop Apache2: `sudo systemctl stop apache2`


## Create an SSL certificate with Certbot

Enter to the image that use nginx:

    docker exec -it <nginx_img_id> bin/bash

Make certificate:

    certbot --nginx -d domain.com -d www.domain.com

Put down Geoserver and NGINX, then edit `WEB-INF/web.xml`. Uncomment `PROXY_BASE_URL` and add your domain: `https://example.com/geoserver`.
Uncomment `GEOSERVER_CSRF_WHITELIST` and add your domain without http: `example.com`.

Put up Geoserver and NGINX, go to `example.com`

## Renew SSL certificate

LetsEncrypt will only allow renewal when the certificate is within 30 days of expiry. Once renewed the new certificate will be valid for 90 days from the date of renewal.

    certbot renew --nginx