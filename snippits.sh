#!/bin/sh
###   Section A.   ###
# Functions snippits #
###                ###

### A1.
# Terminate script with nice error message. Remove comments when using.
# Example Usage: 
#                  fail "error message"
function fail {
    printf '%s\n' "$1" >&2  # Send message to stderr.
    exit "${2-1}"  # Return a code specified by $2, or 1 by default.
}

### A2.
# Generate a random 12 character password. Change "-c12" to create a longer or shorter random password. 
# Example Usage: 
#                  echo $(generate_password)
function generate_password {
    </dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12
}

### A3.
# Generate a random 8 character text string. Change "-c12" to create a longer or shorter random password. 
# Example Usage: 
#                  echo $(generate_database_name)
function generate_database_name {
    </dev/urandom tr -dc _a-z | head -c8
}

###   Section B.                      ###
# Prevent this script from ever running #
###                                   ###
fail "Error! This script should never be run alone"

###   Section C.                                     ###
# Ensure all functions are used to pass linting tests. #
###                                                  ###
# echo $generate_password

###   Section D.   ###
# sqlite snippits    #
###                ###

# D1.
# Basic table create. If DATABASE-NAME.db does not yet exist it will be created automatically.
# Customise:
#             DATABASE_NAME.db : The path to the database file to use.
#             TABLE_NAME       : The name of the table to create.
sqlite DATABASE-NAME.db "create table TABLE-NAME (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"

# D2.
# Basic table insert. Table must already exist.
# Customise:
#             DATABASE_NAME.db : The path to the database file to use.
#             TABLE_NAME       : The name of the table to use.
#             VARIABLE_NAME    : The name of the variable to create. Must be unique.
#             VALUE            : The value for the variable. Can be a function or variable itself, e.g. $generate_password
#             COMMENT          : A description of the variable.
sqlite DATABASE_NAME.db "insert into TABLE_NAME (name,value,comment) values ('VARIABLE_NAME', 'VALUE', 'COMMENT');"

# D3.
# Get data from settings
settings=settings
database=./variables.db
MAIN_NETWORK_ADAPTER=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MAIN_NETWORK_ADAPTER'";)
GATEWAY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'GATEWAY'";)
MAIN_SUBNET=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MAIN_SUBNET'";)
ALLOCATE_SUBNET=$(sqlite $database "SELECT * FROM $settings WHERE name = 'ALLOCATE_SUBNET'";)
ANIME_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'ANIME_DIRECTORY'";)
AUDIOBOOKS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'AUDIOBOOKS_DIRECTORY'";)
BACKUPS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'BACKUPS_DIRECTORY'";)
CODE_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'CODE_DIRECTORY'";)
COMICS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'COMICS_DIRECTORY'";)
DOWNLOADS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'DOWNLOADS_DIRECTORY'";)
EBOOKS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'EBOOKS_DIRECTORY'";)
EMULATION_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'EMULATION_DIRECTORY'";)
HOME_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'HOME_DIRECTORY'";)
ISO_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'ISO_DIRECTORY'";)
MANGA_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MANGA_DIRECTORY'";)
MOVIES_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'MOVIES_DIRECTORY'";)
PLAYLISTS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'PLAYLISTS_DIRECTORY'";)
PODCASTS_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'PODCASTS_DIRECTORY'";)
RAW_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'RAW_DIRECTORY'";)
TORRENTWATCH_DIRECTORY=$(sqlite $database "SELECT * FROM $settings WHERE name = 'TORRENTWATCH_DIRECTORY'";)

#Pass linting
echo "$MAIN_NETWORK_ADAPTER $GATEWAY $MAIN_SUBNET $ALLOCATE_SUBNET $ANIME_DIRECTORY $AUDIOBOOKS_DIRECTORY $BACKUPS_DIRECTORY $CODE_DIRECTORY $COMICS_DIRECTORY $DOWNLOADS_DIRECTORY $EBOOKS_DIRECTORY $EMULATION_DIRECTORY $HOME_DIRECTORY $ISO_DIRECTORY $MANGA_DIRECTORY $MOVIES_DIRECTORY $PLAYLISTS_DIRECTORY $PODCASTS_DIRECTORY $RAW_DIRECTORY $TORRENTWATCH_DIRECTORY"

###   Section E.   ###
# whiptail snippits  # 
###                ###

# E1.
# Simple yes/no question. Remove inline comments when using.
# Customise:
#             TITLE            : Title for the box.
#             20 60            : These are column measurements.
#             QUESTION         : What to ask. e.g. Do you wish to do somthing?
if whiptail --title "TITLE" --yesno "QUESTION" 20 60 ; then
    echo "Selected yes"  # Replace with what to do when "yes" is selected.
else
    fail "Selected no"   # Replace with what to do when "no" is selected.
fi

# E2.
# Input box to set a variable. Remove inline comments when using.
# Customise:
#             VARIABLE         : Name for the variable to create.
#             QUESTION         : What to ask. \n creates a new line and spaces around it may be omitted. 
#                                If not omitting the spaces, add an extra space at the start for formatting.
#             $OTHER_VARIABLE  : A pre-existing variable.
#             20 60            : These are column measurements.
#             DEFAULT_VALUE    : The default response.
#             TITLE            : Title for the box.
VARIABLE=$(whiptail --inputbox --title "TITLE" " QUESTION \n INFORMATION: \n $OTHER_VARIABLE" 20 60 "DEFAULT_VALUE" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = "0" ]; then    # Check for input or cancel.
  if [ -z "$VARIABLE" ]; then    # Check if entry was blank.
  fail "Entry was blank"        # Replace with what to do when the entry is blank.
  else
  echo "User entered $VARIABLE" # Replace with what to do with the variable, or omit.
  fi
else
fail "User canceled."           # Replace with what to do when the user cancels.
fi

### Bash
# Check if dir exists, if not create it, if it is a file throw an error
for dir in $1 $2 $3 $4
do
if [[ ! -e "$dir" ]]; then
    mkdir "$dir"
elif [[ ! -d "$dir" ]]; then
    fail "$dir already exists but is not a directory" 1>&2
fi
done