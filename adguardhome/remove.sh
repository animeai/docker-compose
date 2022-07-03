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
database="../variables.db"  # Set the database path
settings="settings"  # Set the main settings table
check=$(sqlite $database "SELECT * FROM sqlite_master WHERE type = 'table'";)
app=adguardhome
ports="ports"
name="AdGuard Home"

if whiptail --title "Delete ALL data for $name Home?" --yesno "Running this script will delete all stored data for $name. Please select Yes to continue, or No to cancel." 20 60 ; then
    echo "Selected yes, continuing"
else
    fail "User cancelled"
fi

# Linting
export $database
export $settings
export $check
export $app
export $ports
export $name