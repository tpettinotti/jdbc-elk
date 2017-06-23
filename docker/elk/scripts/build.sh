#!/bin/bash
mkdir /opt/logstash/config/sql/
echo $CONNEXION_STRING
for file in ./config/statements/*.sql; do
	filename=$(basename "$file")
    /root/template.sh $CONNEXION_STRING $CONNEXION_USER $CONNEXION_PWD $file ${filename%.*} > /opt/logstash/config/sql/${filename%.*}.conf
done


