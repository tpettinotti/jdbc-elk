#!/bin/bash

: ${SSH_TUNNEL_PORT:=22}
: ${SSH_TUNNEL_MYSQL_LOCAL_PORT:=1234}
: ${SSH_TUNNEL_MYSQL_REMOTE_HOST:=127.0.0.1}
: ${SSH_TUNNEL_MYSQL_REMOTE_PORT:=3306}

echo 'Start SSH Tunnel'
if [[ $SSH_TUNNEL_HOST ]]; then
	echo 'Start SSH tunneling : '
    echo 'autossh -M0 -N -o "ExitOnForwardFailure yes" -o "ServerAliveInterval 15" -o "ServerAliveCountMax 4" -o "ControlPath none" -o "UserKnownHostsFile=/dev/null" -o StrictHostKeyChecking=no -p $SSH_TUNNEL_PORT -L $SSH_TUNNEL_MYSQL_LOCAL_PORT:$SSH_TUNNEL_MYSQL_REMOTE_HOST:$SSH_TUNNEL_MYSQL_REMOTE_PORT $SSH_TUNNEL_USER@$SSH_TUNNEL_HOST'

	autossh -M0 -N \
	-o "ExitOnForwardFailure yes" \
	-o "ServerAliveInterval 15" \
    -o "ServerAliveCountMax 4" \
    -o "ControlPath none" \
    -o "UserKnownHostsFile=/dev/null" \
    -o StrictHostKeyChecking=no \
	-p $SSH_TUNNEL_PORT \
	-L $SSH_TUNNEL_MYSQL_LOCAL_PORT:$SSH_TUNNEL_MYSQL_REMOTE_HOST:$SSH_TUNNEL_MYSQL_REMOTE_PORT \
	$SSH_TUNNEL_USER@$SSH_TUNNEL_HOST
fi

echo 'Start Logstash'
/opt/logstash/bin/logstash -f /opt/logstash/config/custom/