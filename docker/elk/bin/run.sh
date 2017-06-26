#!/bin/bash

echo 'Start SSH Tunnel'
if [[ $SSH_TUNNEL_HOST ]]; then
	echo 'Start SSH tunneling'
	autossh -M0 -N \
	-o "ExitOnForwardFailure yes" \
	-o "ServerAliveInterval 15" \
    -o "ServerAliveCountMax 4" \
    -o "ControlPath none" \
    -o "UserKnownHostsFile=/dev/null" \
    -o StrictHostKeyChecking=no \
	-p $SSH_TUNNEL_PORT \
	-L $SSH_TUNNEL_MYSQL_LOCAL_PORT:$SSH_TUNNEL_MYSQL_REMOTE_HOST:$SSH_TUNNEL_MYSQL_REMOTE_PORT \
	$SSH_TUNNEL_USER@$SSH_TUNNEL_HOST &
fi

echo 'Start Logstash'
/opt/logstash/bin/logstash -f /opt/logstash/config/custom/