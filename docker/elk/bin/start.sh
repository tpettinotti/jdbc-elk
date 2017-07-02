#!/bin/bash

# Since the volume is mount by root, we need to give access to directory to elasticsearch user
chown -R elasticsearch:elasticsearch /var/lib/elasticsearch

#Write logstash conf
/root/app/write_conf.sh

#Start ELK
/usr/local/bin/start.sh &

# Wait for elastic search to start
sleep 10

#Start SSH tunneling and logstash
supervisord -n