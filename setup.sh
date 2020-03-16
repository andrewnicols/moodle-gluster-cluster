#!/bin/sh

docker-compose up -d

echo "============================================================================"
echo "= Probing Gluster peers"
echo "============================================================================"
docker-compose exec ds1 gluster peer probe ds2
docker-compose exec ds1 gluster peer probe ds3
docker-compose exec ds2 gluster peer probe ds1
echo "Done."

echo "============================================================================"
echo "= Creating Gluster Volume"
echo "============================================================================"
docker-compose exec ds1 mkdir -p /data/moodle
docker-compose exec ds2 mkdir -p /data/moodle
docker-compose exec ds3 mkdir -p /data/moodle
docker-compose exec ds1 gluster volume create moodle replica 3 ds1:/data/moodle ds2:/data/moodle ds3:/data/moodle force
docker-compose exec ds1 gluster volume start moodle

docker-compose exec ds1 mkdir -p /data/temp
docker-compose exec ds2 mkdir -p /data/temp
docker-compose exec ds3 mkdir -p /data/temp
docker-compose exec ds1 gluster volume create moodletemp replica 3 ds1:/data/temp ds2:/data/temp ds3:/data/temp force
docker-compose exec ds1 gluster volume start moodle

docker-compose exec ds1 gluster volume info
echo "Done."

echo "============================================================================"
echo "= Mounting the Gluster volume on the web server"
echo "============================================================================"
#glusterfs --volfile-server=ds1 --volfile-id=moodle /var/www/moodledata/
docker-compose exec web mkdir -p /var/www/moodletemp
docker-compose exec web glusterfs --volfile-server=ds1 --volfile-id=moodletemp /var/www/moodletemp/
echo "Done."

echo "============================================================================"
echo "= Copying files back in place"
echo "============================================================================"
docker-compose exec web cp -r /mnt/moodle /var/www/html/moodle
docker-compose exec web mkdir -p /var/www/moodledata/moodle
docker-compose exec web chown -R www-data:www-data /var/www/moodledata/moodle
docker-compose exec web cp -r /var/www/initialdata /var/www/moodledata
docker-compose exec web chown -R www-data:www-data /var/www/moodletemp

docker-compose exec web mkdir -p /var/www/local/cachedir
docker-compose exec web chown -R www-data:www-data /var/www/local/cachedir
echo "Done."
