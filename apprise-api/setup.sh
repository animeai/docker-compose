#!/bin/sh
# Functions
function fail {
 printf '%s\n' "$1" >&2 ## Send message to stderr.
 exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

# Prevent sudo and root
if [ $UID = 0 ] ; then # double []?
 fail "Please dont use the sudo command with this script"
fi

# Variables
database="../variables.db" # Set the database path
settings="settings" # Set the main settings table
check=$(sqlite $database "SELECT * FROM sqlite_master WHERE type = 'table'";)
app="apprise-api"
ports="ports"

# Check this has not been run before
if [[ "$check" == *"$app"* ]]; then
 fail "$app table in variables.db exists - this installer should only be run once."
fi

# Gather data from database
USER_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'USER_ID'";)
TIMEZONE=$(sqlite $database "SELECT * FROM $settings WHERE name = 'TIMEZONE'";)
RESTART_POLICY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'RESTART_POLICY'";)
getports=$(sqlite $database "SELECT * FROM $ports ORDER BY port ASC";)
if [[ -z ${getports[@]} ]]; then
 fail "No ports mapped, set up traefik first!"
fi

# Ask questions
APPRISE_API_PORT=$(whiptail --inputbox --title "API Port" "Set the port to call the Apprise API on \nCurrently used ports: \n${getports[*]}" 20 60 "8000" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
  if [ -z "$APPRISE_API_PORT" ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    if [[ "${getports[*]}" =~ "$APPRISE_API_PORT" ]]; then
    fail "Port already in use!"
    fi
  fi
else
echo "User cancelled"
fi

# Final check
if whiptail --title "Continue?" --yesno "Do you wish to use these settings: \n RESTART_POLICY: $RESTART_POLICY \n USER_ID: $USER_ID \n GROUP_ID: $GROUP_ID \n TIMEZONE: $TIMEZONE \n API PORT: $APPRISE_API_PORT" 20 60 ; then
 echo "Selected yes, continuing"
else
 fail "User opted not to continue. Exiting"
fi

# Set as installed
sqlite $database "create table $app (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"

# As there is no custom data, insert placeholder into database (This only happens when the docker service is not a webapp)
sqlite $database "insert into $app (name,value,comment) values ('NO_CUSTOM_VARIABLES', 'NO_CUSTOM_VARIABLES', 'There are no custom variables for $app');"
sqlite variables.db "insert into ports (port,name,comment) values ('$APPRISE_API_PORT', '$app', 'Apprise API port');" 

# Replace the variables
cp "./docker-compose.yml" "./docker-compose-final.yml"
sed -i "s/RESTART_POLICY/$RESTART_POLICY/g" "docker-compose-final.yml"
sed -i "s/USER_ID/$USER_ID/g" "docker-compose-final.yml"
sed -i "s/GROUP_ID/$GROUP_ID/g" "docker-compose-final.yml"
sed -i "s/TIMEZONE/$TIMEZONE/g" "docker-compose-final.yml"
sed -i "s/APPRISE_API_PORT/$APPRISE_API_PORT/g" "docker-compose-final.yml"

# Copy to final location
mkdir "/etc/docker/compose/$app"
cp "./docker-compose-final.yml" "/etc/docker/compose/$app/docker-compose.yml"

if whiptail --title "Run now?" --yesno "Do you wish to start this service now?" 20 60 ; then
 systemctl start docker-compose@$app
else
 fail "Run manually with 'systemctl start docker-compose@$app' when ready"
fi