#!/bin/bash
mkdir -p /opt/logstash/config/custom/

for file in /root/statements/*.sql; do
	filename=$(basename "$file")
    /root/template.sh $CONNEXION_STRING $CONNEXION_USER $CONNEXION_PWD $file ${filename%.*} > /opt/logstash/config/custom/${filename%.*}.conf
done

cd /opt/logstash

if [[ $SSH_TUNNEL_HOST ]]; then
	echo 'Start SSH tunneling'
	ssh -p $SSH_TUNNEL_PORT $SSH_TUNNEL_USER@$SSH_TUNNEL_HOST -L $SSH_TUNNEL_MYSQL_LOCAL_PORT:$SSH_TUNNEL_MYSQL_REMOTE_HOST:$SSH_TUNNEL_MYSQL_REMOTE_PORT -N &
fi

./bin/logstash -f ./config/custom/