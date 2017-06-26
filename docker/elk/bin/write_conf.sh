#!/bin/bash
mkdir -p /opt/logstash/config/custom/

for file in /root/queries/*.sql; do
	filename=$(basename "$file")
    /root/app/template.sh $CONNEXION_STRING $CONNEXION_USER $CONNEXION_PWD $file ${filename%.*} > /opt/logstash/config/custom/${filename%.*}.conf
	echo "[added] ${filename} "
done