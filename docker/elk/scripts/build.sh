#!/usr/bin/env bash

sed -i -- "s/connexion_string/$CONNEXION_STRING/g" /root/sample.conf
sed -i -- "s/connexion_user/$CONNEXION_USER/g" /root/sample.conf
sed -i -- "s/connexion_pwd/$CONNEXION_PWD/g" /root/sample.conf