#!/bin/sh
# Functions
function fail {
    printf '%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

# Prevent sudo and root
if [ $UID = 0 ] ; then  # double []?
  fail "Please dont use the sudo command with this script"
fi

# Variables
database="../variables.db"  # Set the database path
settings="settings"  # Set the main settings table
check=$(sqlite $database "SELECT * FROM sqlite_master WHERE type = 'table'";)
app=adguardhome

# Check this has not been run before
# sqlite variables.db "select * FROM passwords WHERE name = 'test');"
if [[ "$check" == *"adguardhome"* ]]; then
 fail "adguardhome table in variables.db exists - this installer should only be run once."
fi

# Gather data if required
MAIN_NETWORK_ADAPTER=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MAIN_NETWORK_ADAPTER'";)
GATEWAY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'GATEWAY'";)
MAIN_SUBNET=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MAIN_SUBNET'";)
ALLOCATE_SUBNET=$(sqlite $database "SELECT * FROM $settings WHERE name = 'ALLOCATE_SUBNET'";)
DOMAIN=$(sqlite $database "SELECT * FROM $settings WHERE name = 'DOMAIN'";)
USER_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'USER_ID'";)
GROUP_ID=$(sqlite $database "SELECT * FROM $settings WHERE name = 'GROUP_ID'";)
TIMEZONE=$(sqlite $database "SELECT * FROM $settings WHERE name = 'TIMEZONE'";)

# Ask questions
SUBDOMAIN_ONE=$(whiptail --inputbox --title "Subdomain One" "Please set the first subdomain to use for adguardhome" 20 60 "adguardhome" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $SUBDOMAIN_ONE ]; then
  fail "Entry was blank - you must set a subdomain"
  fi
else
fail "User cancelled"
fi
SUBDOMAIN_TWO=$(whiptail --inputbox --title "Subdomain Two" "Please set the second subdomain to use for adguardhome" 20 60 "adguardhome2" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $SUBDOMAIN_TWO ]; then
  fail "Entry was blank - you must set a subdomain"
  fi
else
fail "User cancelled"
fi
IP_ONE=$(whiptail --inputbox --title "IP for adguard home server 1" "Please set IP to use for adguardhome \nIt must be in the $ALLOCATE_SUBNET range" 20 60 "192.168.1.200" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $IP_ONE ]; then
  fail "Entry was blank - you must set an IP"
  fi
else
fail "User cancelled"
fi
IP_TWO=$(whiptail --inputbox --title "IP for adguard home server 2" "Please set the second subdomain to use for adguardhome" 20 60 "adguardhome2" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $IP_TWO ]; then
  fail "Entry was blank - you must set an IP"
  fi
else
fail "User cancelled"
fi

# Final check
if whiptail --title "Continue?" --yesno "Do you wish to use these settings: \n  MAIN_NETWORK_ADAPTER: $MAIN_NETWORK_ADAPTER \n  MAIN_SUBNET: $MAIN_SUBNET \n   GATEWAY: $GATEWAY \n  ALLOCATE_SUBNET: $ALLOCATE_SUBNET \n SUBDOMAIN_ONE: $SUBDOMAIN_ONE \n  SUBDOMAIN_TWO: $SUBDOMAIN_TWO \n  IP_ONE: $IP_ONE \n  IP_TWO: $IP_TWO \n DOMAIN: $DOMAIN \n  RESTART_POLICY: $RESTART_POLICY \n  USERID: $USERID \n  GROUPID: $GROUPID \n  TIMEZONE: $TIMEZONE " 20 60 ; then
    echo "Selected yes"  # Replace with what to do when "yes" is selected.
else
    fail "Selected no"   # Replace with what to do when "no" is selected.
fi
# Set as installed
sqlite $database "create table $app (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"

# Insert the data
sqlite $database "insert into $app (name,value,comment) values ('SUBDOMAIN_ONE', '$SUBDOMAIN_ONE', 'Subdomain for adguard-one');"
sqlite $database "insert into $app (name,value,comment) values ('SUBDOMAIN_TWO', '$SUBDOMAIN_TWO', 'Subdomain for adguard-two');"
sqlite $database "insert into $app (name,value,comment) values ('IP_ONE', '$IP_ONE', 'adguard-one internal IP');"
sqlite $database "insert into $app (name,value,comment) values ('IP_TWO', '$IP_TWO', 'adguard-two internal IP');"

# Replace the variables
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
sed -i 's/USERID/$USERID/g' docker-compose-final.yml
sed -i 's/GROUPID/$GROUPID/g' docker-compose-final.yml
sed -i 's/TIMEZONE/$TIMEZONE/g' docker-compose-final.yml
mkdir /etc/docker/compose/adguardhome
cp docker-compose-final.yml /etc/docker/compose/adguardhome/docker-compose.yml

if whiptail --title "Run now?" --yesno "Do you wish to start this service now?" 20 60 ; then
  systemctl start docker-compose@adguardhome
else
    fail "Run manually with 'systemctl start docker-compose@adguardhome' when ready"   # Replace with what to do when "no" is selected.
fi