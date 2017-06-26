#!/bin/bash

#Write logstash conf
/root/app/write_conf.sh

#Start ELK
/usr/local/bin/start.sh &

#Start SSH tunneling and logstash
supervisord -n