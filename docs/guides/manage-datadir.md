# Use earlier folder
0. Put down Geoserver:

        docker-compose -f docker-compose.yml down

1. Delete `datadir`:

        rm -rf /var/lib/docker/volumes/geoserver-drako_geoserver/_data/data

2. Create `datadir`:

        mkdir data

3. Copy all data from earlier folder to `datadir`:

        cp -r EARLIER_FOLDER_NAME/* /var/lib/docker/volumes/geoserver-drako_geoserver/_data/data
   
4. Change `datadir` ownership:

        chown -R USERNAME:USERNAME datadir/
   
5. Put UP Geoserver:

        docker-compose -f docker-compose.yml up -d