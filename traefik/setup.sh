#!/bin/sh
# TO DO: Is Authelia port required?
# Functions
function fail {
 printf '%s\n' "$1" >&2
 exit "${2-1}"
}

# Prevent sudo and root
if [[ $UID = 0 ]] ; then
 fail "Please dont use the sudo command with this script"
fi

# Variables
database="../variables.db"  # Set the database path
settings="settings"  # Set the main settings table
check=$(sqlite $database "SELECT * FROM sqlite_master WHERE type = 'table'";)  # Query database to see if app was installed yet
app="traefik"  # Set the app name
ports="ports"  # Set the ports table

# Check this has not been run before
if [[ "$check" == *"$app"* ]]; then
 fail "$app table in variables.db exists - this installer should only be run once."
fi

# Gather data from database
RESTART_POLICY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'RESTART_POLICY'";)
CLOUDFLARE_DOMAIN=$(sqlite $database "SELECT * FROM $settings WHERE name = 'CLOUDFLARE_DOMAIN'";)
TIMEZONE=$(sqlite $database "SELECT * FROM $settings WHERE name = 'TIMEZONE'";)
getports=$(sqlite $database "SELECT * FROM $ports ORDER BY port ASC";)
if [[ ! -z ${getports[@]} ]]; then
 fail "Ports already mapped! Traefik should be the first app to set up - Use update.sh to update your traefik install"
fi

# Ask questions
TRAEFIK_SUBDOMAIN=$(whiptail --inputbox --title "Traefik Subdomain" "Please set the subdomain to use for the Traefik management panel" 20 60 "traefik" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
 if [ -z "$TRAEFIK_SUBDOMAIN" ]; then
  fail "Entry was blank - you must set a subdomain"
 fi
else
 fail "User cancelled"
fi
AUTHELIA_SUBDOMAIN=$(whiptail --inputbox --title "Authelia Subdomain" "Please set the subdomain to use for Authelia" 20 60 "authelia" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
 if [ -z "$AUTHELIA_SUBDOMAIN" ]; then
  fail "Entry was blank - you must set a subdomain"
 fi
else
 fail "User cancelled"
fi
getports=$(sqlite $database "SELECT * FROM $ports ORDER BY port ASC";)
if [[ -z ${getports[@]} ]]; then
getports="none"
fi
if [[ "${getports[*]}" =~ "80" ]]; then
    fail "Port 80 is listed as used?!"
fi
if [[ "${getports[*]}" =~ "443" ]]; then
    fail "Port 443 is listed as used?!"
fi
TRAEFIK_PING_PORT=$(whiptail --inputbox --title "Ping Port" "Set the pingable port for Traefik \nCurrently used ports: \n${getports[@]}" 20 60 "8181" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
  if [ -z "$TRAEFIK_PING_PORT" ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    if [[ "${getports[*]}" =~ "$TRAEFIK_PING_PORT" ]]; then
    fail "Port already in use!"
  fi
else
echo "User cancelled"
fi
AUTHELIA_PORT=$(whiptail --inputbox --title "Authelia Port" "Set the internal port for Authelia \nCurrently used ports: \n${getports[@]} ( and the just set $TRAEFIK_PING_PORT)" 20 60 "8181" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
  if [ -z "$AUTHELIA_PORT" ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    if [[ "${getports[*]}" =~ "$AUTHELIA_PORT" ]]; then
    fail "Port already in use!"
  fi
else
echo "User cancelled"
fi
CLOUDFLARE_API_EMAIL=$(whiptail --inputbox --title "Cloudflare API Email" "Enter your cloudflare API email address" 20 60 "" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
  if [ -z "$CLOUDFLARE_API_EMAIL" ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  fi
else
echo "User cancelled"
fi
CLOUDFLARE_API_KEY=$(whiptail --inputbox --title "Cloudflare API Key" "Enter your cloudflare API key" 20 60 "" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
  if [ -z "$CLOUDFLARE_API_KEY" ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  fi
else
echo "User cancelled"
fi

# Set as installed
sqlite $database "create table $app (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"

# Insert the data
sqlite $database "insert into $ports (port,name,comment) values ('$AUTHELIA_PORT', '$app', 'Authelia API port');" 
sqlite $database "insert into $ports (port,name,comment) values ('$TRAEFIK_PING_PORT', '$app', 'Traefik ping port');" 
sqlite $database "insert into $app (name,value,comment) values ('CLOUDFLARE_API_EMAIL', '$CLOUDFLARE_API_EMAIL', 'Registered cloudflare email address');"
sqlite $database "insert into $app (name,value,comment) values ('CLOUDFLARE_API_KEY', '$CLOUDFLARE_API_KEY', 'API key for cloudflare');"
sqlite $database "insert into $app (name,value,comment) values ('TRAEFIK_SUBDOMAIN', '$TRAEFIK_SUBDOMAIN', 'Subdomain for Traefik control panel');"
sqlite $database "insert into $app (name,value,comment) values ('AUTHELIA_SUBDOMAIN', '$AUTHELIA_SUBDOMAIN', 'Subdomain for Authelia');"

cp "./docker-compose.yml" "./docker-compose-final.yml"
sed -i "s/RESTART_POLICY/$RESTART_POLICY/g" docker-compose-final.yml
sed -i "s/TRAEFIK_SUBDOMAIN/$TRAEFIK_SUBDOMAIN/g" docker-compose-final.yml
sed -i "s/AUTHELIA_SUBDOMAIN/$AUTHELIA_SUBDOMAIN/g" docker-compose-final.yml
sed -i "s/TRAEFIK_PING_PORT/$TRAEFIK_PING_PORT/g" docker-compose-final.yml
sed -i "s/AUTHELIA_PORT/$AUTHELIA_PORT/g" docker-compose-final.yml
sed -i "s/CLOUDFLARE_DOMAIN/$CLOUDFLARE_DOMAIN/g" docker-compose-final.yml
sed -i "s/CLOUDFLARE_API_EMAIL/$CLOUDFLARE_API_EMAIL/g" docker-compose-final.yml
sed -i "s/CLOUDFLARE_API_KEY/$CLOUDFLARE_API_KEY/g" docker-compose-final.yml
sed -i "s/TIMEZONE/$TIMEZONE/g" docker-compose-final.yml

# Copy to final location
mkdir "/etc/docker/compose/$app"
cp "./docker-compose-final.yml" "/etc/docker/compose/$app/docker-compose.yml"

if whiptail --title "Run now?" --yesno "Do you wish to start this service now?" 20 60 ; then
 systemctl start docker-compose@$app
else
 fail "Run manually with 'systemctl start docker-compose@$app' when ready"
fi