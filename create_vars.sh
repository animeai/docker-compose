#!/bin/bash
# Set up Variables...


# Set env variables for systemd https://serverfault.com/questions/413397/how-to-set-environment-variable-in-systemd-service

# File operations
# touch /root/vars.sh  # make sure vars file exists
# touch "/root/vars.$(timestamp).bak"  # make sure backup file exists 
# cp "/root/vars.sh" > "/root/vars.$(timestamp).bak"  # backup current file
# echo "" > /root/vars.sh  # clear current file


# create volume directories

if [ ! -f /var/data/acceleratedtext/logback/transactor-logback.xml ]
then
 wget -m https://raw.githubusercontent.com/accelerated-text/accelerated-text/master/transactor-logback.xml -p /var/data/acceleratedtext/logback
 chmod 777 /var/data/acceleratedtext/logback/transactor-logback.xml
 chown root /var/data/acceleratedtext/logback/transactor-logback.xml
fi
# Get needed yml files


# create volume files
for files in /var/data/pihole-unbound/pihole2/config/hosts /var/data/pihole-unbound/pihole2/config/resolv.conf /var/data/pihole-unbound/pihole2/config/dnsmasq.conf /var/data/pihole-unbound/pihole2/config/pihole-FTL.conf /var/data/pihole-unbound/pihole1/config/hosts /var/data/pihole-unbound/pihole1/config/resolv.conf /var/data/pihole-unbound/pihole1/config/dnsmasq.conf /var/data/pihole-unbound/pihole1/config/pihole-FTL.conf /var/data/files/traefik/traefik.log /var/data/secrets/traefik_basic_auth.htpasswd 
do
if [ ! -f "$files" ] 
then
 touch $files
 chmod 777 $files
 chown root $files
fi
done


# Useful stuff for other scripts
# cat /dev/urandom | tr -dc '0-9a-zA-Z!@# $%^&*_+-' | head -c 15 | docker secret create db_password -  # Create random password and write to docker secret

# Update docker container using original settings - does this work with swarm?
# docker run --rm \
# -v /var/run/docker.sock:/var/run/docker.sock \
# containrrr/watchtower \
# --run-once nextcloud