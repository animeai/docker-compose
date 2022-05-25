#!/bin/sh
# Functions
function fail {
    printf '%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

# Check if we can run an update
if [ ! -f <file> ]
then
  fail "docker-compose-final.yml does not exist. Did you mean to run setup.sh?"
fi

# Variables
database="../variables.db"  # Set the database path
settings="settings"  # Set the main settings table
app=adguardhome
# Get current timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Stop if running
systemctl stop docker-compose@adguardhome

# Get variables from database
MAIN_NETWORK_ADAPTER=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MAIN_NETWORK_ADAPTER'";)
GATEWAY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'GATEWAY'";)
MAIN_SUBNET=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MAIN_SUBNET'";)
ALLOCATE_SUBNET=$(sqlite $database "SELECT * FROM $settings WHERE name = 'ALLOCATE_SUBNET'";)
DOMAIN=$(sqlite $database "SELECT * FROM $settings WHERE name = 'DOMAIN'";)
USER_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'USER_ID'";)
GROUP_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'GROUP_ID'";)
TIMEZONE=$(sqlite $database "SELECT * FROM $settings WHERE name = 'TIMEZONE'";)
SUBDOMAIN_ONE=$(sqlite $database "SELECT * FROM $app WHERE name = 'SUBDOMAIN_ONE'";)
SUBDOMAIN_TWO=$(sqlite $database "SELECT * FROM $app WHERE name = 'SUBDOMAIN_TWO'";)
IP_ONE=$(sqlite $database "SELECT * FROM $app WHERE name = 'IP_ONE'";)
IP_TWO=$(sqlite $database "SELECT * FROM $app WHERE name = 'IP_TWO'";)

# Archive old docker-compose-final.yml
cp ./docker-compose-final.yml ./docker-compose-$timestamp.yml
mv /etc/docker/compose/adguardhome/docker-compose.yml /etc/docker/compose/adguardhome/docker-compose-$timestamp.yml 

# Replace values
cp ./docker-compose.yml ./docker-compose-final.yml
sed -i 's/MAIN_NETWORK_ADAPTER/$MAIN_NETWORK_ADAPTER/g' docker-compose-final.yml
sed -i 's/MAIN_SUBNET/$MAIN_SUBNET/g' docker-compose-final.yml
sed -i 's/GATEWAY/$GATEWAY/g' docker-compose-final.yml
sed -i 's/ALLOCATE_SUBNET/$ALLOCATE_SUBNET/g' docker-compose-final.yml
sed -i 's/SUBDOMAIN_ONE/$SUBDOMAIN_ONE/g' docker-compose-final.yml
sed -i 's/IP_ONE/$IP_ONE/g' docker-compose-final.yml
sed -i 's/SUBDOMAIN_TWO/$SUBDOMAIN_TWO/g' docker-compose-final.yml
sed -i 's/IP_TWO/$IP_TWO/g' docker-compose-final.yml
sed -i 's/DOMAIN/$DOMAIN/g' docker-compose-final.yml
sed -i 's/RESTART_POLICY/$RESTART_POLICY/g' docker-compose-final.yml

# Copy to final location
cp docker-compose-final.yml /etc/docker/compose/adguardhome/docker-compose.yml

if whiptail --title "Run now?" --yesno "Do you wish to start this service now?" 20 60 ; then
  systemctl start docker-compose@adguardhome
else
    fail "Run manually with 'systemctl start docker-compose@adguardhome' when ready"   # Replace with what to do when "no" is selected.
fi