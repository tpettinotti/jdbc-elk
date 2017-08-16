#!/bin/bash
mkdir -p /opt/logstash/config/custom/

for file in /queries/*.sql; do
	filename=$(basename "$file")
    touch /etc/logstash/conf.d/${filename%.*}.conf
    /root/app/template.sh $file $(echo ${filename%.*}| cut -d'-' -f 1) > /opt/logstash/config/custom/${filename%.*}.conf
	echo "[added] ${filename} "
done