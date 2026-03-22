# Restore an Earlier Data Directory

0. Put down GeoServer:

        docker compose -f staging.yml down

1. Find the current data volume mountpoint:

        docker volume inspect docker-geoserver_main_geoserver

2. Delete the current content inside the mounted volume path returned by Docker:

        rm -rf MOUNTPOINT/*

3. Copy the earlier data directory into that mountpoint:

        cp -r EARLIER_FOLDER_NAME/* MOUNTPOINT/

4. Change ownership if your local setup requires it:

        chown -R USERNAME:USERNAME MOUNTPOINT/

5. Put up GeoServer again:

        docker compose -f staging.yml up -d
