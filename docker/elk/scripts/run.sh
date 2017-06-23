#!/bin/bash
mkdir -p /opt/logstash/config/custom/ --verbose

for file in /root/statements/*.sql; do
	echo $file
	filename=$(basename "$file")
    /root/template.sh $CONNEXION_STRING $CONNEXION_USER $CONNEXION_PWD $file ${filename%.*} > /opt/logstash/config/custom/${filename%.*}.conf
done

cd /opt/logstash
./bin/logstash -f ./config/custom/
