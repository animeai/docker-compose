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
app="replaceme"

# Check this has not been run before
# sqlite variables.db "select * FROM passwords WHERE name = 'test');"
if [[ "$check" == *"$app"* ]]; then
 fail "$app table in variables.db exists - this installer should only be run once."
fi

# Gather data from database
CLOUDFLARE_DOMAIN=$(sqlite $database "SELECT * FROM $settings WHERE name = 'CLOUDFLARE_DOMAIN'";)
USER_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'USER_ID'";)
GROUP_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'GROUP_ID'";)
TIMEZONE=$(sqlite $database "SELECT * FROM $settings WHERE name = 'TIMEZONE'";)
RESTART_POLICY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'RESTART_POLICY'";)

# Ask questions
AUDACITY_SUBDOMAIN=$(whiptail --inputbox --title "Audacity Subdomain" "Please set the subdomain to use for Audacity" 20 60 "audacity" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then
 if [ -z "$AUDACITY_SUBDOMAIN" ]; then
  fail "Entry was blank - you must set a subdomain"
 fi
else
 fail "User cancelled"
fi

# Final check
if whiptail --title "Continue?" --yesno "Do you wish to use these settings: \n AUDACITY_SUBDOMAIN: $AUDACITY_SUBDOMAIN \n DOMAIN: $CLOUDFLARE_DOMAIN \n RESTART_POLICY: $RESTART_POLICY \n USER_ID: $USER_ID \n GROUP_ID: $GROUP_ID \n TIMEZONE: $TIMEZONE " 20 60 ; then
 echo "Selected yes, continuing"
else
 fail "User opted not to continue. Exiting"
fi

# Set as installed
sqlite $database "create table $app (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"

# Insert the data
sqlite $database "insert into $app (name,value,comment) values ('AUDACITY_SUBDOMAIN', '$AUDACITY_SUBDOMAIN', 'Subdomain for $app');"

# Replace the variables
cp "./docker-compose.yml" "./docker-compose-final.yml"
sed -i "s/RESTART_POLICY/$RESTART_POLICY/g" docker-compose-final.yml
sed -i "s/USER_ID/$USER_ID/g" docker-compose-final.yml
sed -i "s/GROUP_ID/$GROUP_ID/g" docker-compose-final.yml
sed -i "s/TIMEZONE/$TIMEZONE/g" docker-compose-final.yml
sed -i "s/CLOUDFLARE_DOMAIN/$CLOUDFLARE_DOMAIN/g" docker-compose-final.yml
sed -i "s/AUDACITY_SUBDOMAIN/$AUDACITY_SUBDOMAIN/g" docker-compose-final.yml

# Copy to final location
mkdir "/etc/docker/compose/$app"
cp "./docker-compose-final.yml" "/etc/docker/compose/$app/docker-compose.yml"

if whiptail --title "Run now?" --yesno "Do you wish to start this service now?" 20 60 ; then
 systemctl start docker-compose@$app
else
 fail "Run manually with 'systemctl start docker-compose@$app' when ready" # Replace with what to do when "no" is selected.
fi