#!/bin/sh
# Get files
if [ ! -f /var/data/portus/clair/clair.yml ]
then
source=" source: s/host=postgres port=5432 user=postgres password=portus sslmode=disable statement_timeout=60000"
replace=" source: host=portus-postgres port=5432 user=postgres password=$PORTUSDB_PASS sslmode=disable statement_timeout=60000"
 wget -m https://raw.githubusercontent.com/SUSE/Portus/master/examples/compose/clair/clair.yml -p /var/data/portus/clair
 chmod 777 /var/data/portus/clair/clair.yml 
 chown root /var/data/portus/clair/clair.yml 
 sed -i 's/$source/$replace/' /var/data/portus/clair/clair.yml 
fi
if [ ! -f /var/data/portus/certificate/portus.crt ]
then
 wget -m https://raw.githubusercontent.com/SUSE/Portus/master/examples/development/compose/portus.crt -p /var/data/portus/certificate
 chmod 777 /var/data/portus/certificate/portus.crt 
 chown root /var/data/portus/certificate/portus.crt
fi