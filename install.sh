#!/bin/sh
# Functions
function fail {
    printf '%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

# Check this hasn't been run before
database="./variables.db"
 if [ -f "$database" ] 
 then
  fail "variables.db exists - this should only be run once! If you are trying to upgrade, use upgrade.sh to back up the existing database, create a new one with default values and then insert any stored values from the old database"
 fi

# Ensure whiptail is installed
whiptail_install=$("dpkg -s whiptail | grep Status")
if [[ $whiptail_install == *"installed"* ]]; then
  echo "whiptail is installed, continuing"
else
  apt install whiptail -y
fi

prips_install=$("dpkg -s prips | grep Status")
if [[ $prips_install == *"installed"* ]]; then
  echo "prips is installed, continuing"
else
  apt install prips -y
fi

# Check user wants to install and is ready
if whiptail --yesno "Do you wish to install this application?" 20 60 ;then
    echo Installing...
else
    fail "User decided not to continue"
fi

echo "Setting up working directory"
mkdir /etc/docker/compose
chown "$USER":"docker" /etc/docker/compose -R


# Install packages
# Ensure net-tools is installed
net_tools_install=$("dpkg -s net-tools | grep Status")

apt install net-tools docker docker-compose -y

# Find variables
main_interface_detect=$(ip route get 8.8.8.8 | awk -- '{printf $5}')
gateway_detect=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
subnet_detect=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
current_timezone=$(cat /etc/timezone)

# Set up database with defaults
sqlite $database "create table settings (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"
# sqlite variables.db "insert into settings (name,value,comment) values ('', '', '');"

# Get username
USERNAME=$(whiptail --inputbox --title "Username" "Set the docker username" 20 60 "$USER" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $USERNAME ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('USERNAME', '$USERNAME', 'The docker username');" 
  fi
else
echo "User cancelled"
fi

# Find User ID (UID)
USERID=$(id -u $USERNAME)
sqlite $database "insert into settings (name,value,comment) values ('USERID', '$USERID', 'The docker UID');"

# Get group
GROUPNAME=$(whiptail --inputbox --title "Group" "Set the docker group" 20 60 "docker" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $GROUPNAME ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('GROUPNAME', '$GROUPNAME', 'The docker groupname');" 
  fi
else
echo "User cancelled"
fi

# Find Group ID (GID)
GROUPID=$(getent group $GROUPNAME | cut -d: -f3)
sqlite $database "insert into settings (name,value,comment) values ('GROUPID', '$GROUPID', 'The docker GID');" 

# Set timezone
TIMEZONE=$(whiptail --inputbox --title "Timezone" "Set the timezone docker should use" 20 60 "$current_timezone" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $TIMEZONE ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('TIMEZONE', '$TIMEZONE', 'The docker timezone');" 
  fi
else
echo "User cancelled"
fi


# Storage
if whiptail --title "Use default storage settings?" --yesno "Do you wish to use the default storage settings? \nThis will create any missing directories \nEverything will be placed in a subdirectory of /mnt" 20 60 ; then
sqlite $database "insert into settings (name,value,comment) values ('ANIME_DIRECTORY', '/mnt/anime', 'The location to store anime');"
sqlite $database "insert into settings (name,value,comment) values ('AUDIOBOOKS_DIRECTORY', '/mnt/audiobooks', 'The location to store audiobooks');"
sqlite $database "insert into settings (name,value,comment) values ('BACKUPS_DIRECTORY', '/mnt/backups', 'The location to store general backups');"
sqlite $database "insert into settings (name,value,comment) values ('CODE_DIRECTORY', '/mnt/code', 'The directory to store code and projects');"
sqlite $database "insert into settings (name,value,comment) values ('COMICS_DIRECTORY', '/mnt/comics', 'The directory to store comics');"
sqlite $database "insert into settings (name,value,comment) values ('DOWNLOADS_DIRECTORY', '/mnt/downloads', 'the location to store downloads');"
sqlite $database "insert into settings (name,value,comment) values ('EBOOKS_DIRECTORY', '/mnt/ebooks', 'The location to store ebooks');"
sqlite $database "insert into settings (name,value,comment) values ('EMULATION_DIRECTORY', '/mnt/emulation', 'The location to store roms');"
sqlite $database "insert into settings (name,value,comment) values ('HOME_DIRECTORY', '$HOME', 'The location to store ebooks');"
sqlite $database "insert into settings (name,value,comment) values ('ISO_DIRECTORY', '/mnt/iso', 'The location to store operating system ISO files');"
sqlite $database "insert into settings (name,value,comment) values ('MANGA_DIRECTORY', '/mnt/manga', 'The location to store manga');"
sqlite $database "insert into settings (name,value,comment) values ('MOVIES_DIRECTORY', '/mnt/movies', 'The location to store movies');"
sqlite $database "insert into settings (name,value,comment) values ('PLAYLISTS_DIRECTORY', '/mnt/playlists', 'The location to store playlists');"
sqlite $database "insert into settings (name,value,comment) values ('PODCASTS_DIRECTORY', '/mnt/podcasts', 'The location to store podcasts');"
sqlite $database "insert into settings (name,value,comment) values ('RAW_DIRECTORY', '/mnt/raw', 'The location to store RAWs');"
sqlite $database "insert into settings (name,value,comment) values ('TORRENTWATCH_DIRECTORY', '/mnt/torrentwatch', 'The location to place .torrent files for download');"
ANIME_DIRECTORY="/mnt/anime"
AUDIOBOOKS_DIRECTORY="/mnt/audiobooks"
BACKUPS_DIRECTORY="/mnt/backups"
CODE_DIRECTORY="/mnt/code"
COMICS_DIRECTORY="/mnt/comics"
DOWNLOADS_DIRECTORY="/mnt/downloads"
EBOOKS_DIRECTORY="/mnt/ebooks"
EMULATION_DIRECTORY="/mnt/emulation"
HOME_DIRECTORY=$HOME
ISO_DIRECTORY="/mnt/iso"
MANGA_DIRECTORY="/mnt/manga"
MOVIES_DIRECTORY="/mnt/movies"
PLAYLISTS_DIRECTORY="/mnt/playlists"
PODCASTS_DIRECTORY="/mnt/podcasts"
RAW_DIRECTORY="/mnt/raw"
TORRENTWATCH_DIRECTORY="/mnt/torrentwatch"
else
ANIME_DIRECTORY=$(whiptail --inputbox --title "Anime" "Set the storage location for Anime" 20 60 "/mnt/anime" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $ANIME_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('ANIME_DIRECTORY', '$ANIME_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
AUDIOBOOKS_DIRECTORY=$(whiptail --inputbox --title "Audiobooks" "Set the storage location for Audiobooks" 20 60 "/mnt/audiobooks" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $AUDIOBOOKS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('AUDIOBOOKS_DIRECTORY', '$AUDIOBOOKS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
BACKUPS_DIRECTORY=$(whiptail --inputbox --title "Backups" "Set the storage location for Backups" 20 60 "/mnt/backups" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $BACKUPS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('BACKUPS_DIRECTORY', '$BACKUPS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
CODE_DIRECTORY=$(whiptail --inputbox --title "Code" "Set the storage location for Code, Git, Projects, etc." 20 60 "/mnt/code" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $CODE_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite $database "insert into settings (name,value,comment) values ('CODE_DIRECTORY', '$CODE_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
COMICS_DIRECTORY=$(whiptail --inputbox --title "Comics" "Set the storage location for Comics" 20 60 "/mnt/comics" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $COMICS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('COMICS_DIRECTORY', '$COMICS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
DOWNLOADS_DIRECTORY=$(whiptail --inputbox --title "Downloads" "Set the storage location for Downloads" 20 60 "/mnt/downloads" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $DOWNLOADS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('DOWNLOADS_DIRECTORY', '$DOWNLOADS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
EBOOKS_DIRECTORY=$(whiptail --inputbox --title "EBooks" "Set the storage location for EBooks" 20 60 "/mnt/ebooks" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $EBOOKS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('EBOOKS_DIRECTORY', '$EBOOKS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
HOME_DIRECTORY=$(whiptail --inputbox --title "Home" "Set your home directory" 20 60 "$HOME" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $HOME_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('HOME_DIRECTORY', '$HOME_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
ISO_DIRECTORY=$(whiptail --inputbox --title "ISOs" "Set the storage location for operating system ISOs" 20 60 "/mnt/iso" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $ISO_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('ISO_DIRECTORY', '$ISO_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
MANGA_DIRECTORY=$(whiptail --inputbox --title "Manga" "Set the storage location for Manga" 20 60 "/mnt/manga" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $MANGA_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('MANGA_DIRECTORY', '$MANGA_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
MOVIES_DIRECTORY=$(whiptail --inputbox --title "Movies" "Set the storage location for Movies" 20 60 "/mnt/movies" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $MOVIES_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('MOVIES_DIRECTORY', '$MOVIES_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
PLAYLISTS_DIRECTORY=$(whiptail --inputbox --title "Playlists" "Set the storage location for Playlists" 20 60 "/mnt/playlists" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $PLAYLISTS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('PLAYLISTS_DIRECTORY', '$PLAYLISTS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
PODCASTS_DIRECTORY=$(whiptail --inputbox --title "Podcasts" "Set the storage location for Podcasts" 20 60 "/mnt/podcasts" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $PODCASTS_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('PODCASTS_DIRECTORY', '$PODCASTS_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
RAW_DIRECTORY=$(whiptail --inputbox --title "Raws" "Set the storage location for Raws" 20 60 "/mnt/raw" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $RAW_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('RAW_DIRECTORY', '$RAW_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
TORRENTWATCH_DIRECTORY=$(whiptail --inputbox --title "Torrent Watch" "Set the storage location for Torrent Watches" 20 60 "/mnt/torrentwatch" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $TORRENTWATCH_DIRECTORY ]; then
    echo "Entry was blank - please set your storage folder. You cannot leave this blank!"
  else
    sqlite variables.db "insert into settings (name,value,comment) values ('TORRENTWATCH_DIRECTORY', '$TORRENTWATCH_DIRECTORY', 'The location to store anime');" 
  fi
else
echo "User cancelled"
fi
sqlite $database "insert into settings (name,value,comment) values ('ANIME_DIRECTORY', '$ANIME_DIRECTORY', 'The location to store anime');"
sqlite $database "insert into settings (name,value,comment) values ('AUDIOBOOKS_DIRECTORY', '$AUDIOBOOKS_DIRECTORY', 'The location to store audiobooks');"
sqlite $database "insert into settings (name,value,comment) values ('BACKUPS_DIRECTORY', '$BACKUPS_DIRECTORY', 'The location to store general backups');"
sqlite $database "insert into settings (name,value,comment) values ('CODE_DIRECTORY', '$CODE_DIRECTORY', 'The directory to store code and projects');"
sqlite $database "insert into settings (name,value,comment) values ('COMICS_DIRECTORY', '$COMICS_DIRECTORY', 'The directory to store comics');"
sqlite $database "insert into settings (name,value,comment) values ('DOWNLOADS_DIRECTORY', '$DOWNLOADS_DIRECTORY', 'the location to store downloads');"
sqlite $database "insert into settings (name,value,comment) values ('EBOOKS_DIRECTORY', '$EBOOKS_DIRECTORY', 'The location to store ebooks');"
sqlite $database "insert into settings (name,value,comment) values ('EMULATION_DIRECTORY', '$EMULATION_DIRECTORY', 'The location to store roms');"
sqlite $database "insert into settings (name,value,comment) values ('HOME_DIRECTORY', '$HOME_DIRECTORY', 'The location to store ebooks');"
sqlite $database "insert into settings (name,value,comment) values ('ISO_DIRECTORY', '$ISO_DIRECTORY', 'The location to store operating system ISO files');"
sqlite $database "insert into settings (name,value,comment) values ('MANGA_DIRECTORY', '$MANGA_DIRECTORY', 'The location to store manga');"
sqlite $database "insert into settings (name,value,comment) values ('MOVIES_DIRECTORY', '$MOVIES_DIRECTORY', 'The location to store movies');"
sqlite $database "insert into settings (name,value,comment) values ('PLAYLISTS_DIRECTORY', '$PLAYLISTS_DIRECTORY', 'The location to store playlists');"
sqlite $database "insert into settings (name,value,comment) values ('PODCASTS_DIRECTORY', '$PODCASTS_DIRECTORY', 'The location to store podcasts');"
sqlite $database "insert into settings (name,value,comment) values ('RAW_DIRECTORY', '$RAW_DIRECTORY', 'The location to store RAWs');"
sqlite $database "insert into settings (name,value,comment) values ('TORRENTWATCH_DIRECTORY', '$TORRENTWATCH_DIRECTORY', 'The location to place .torrent files for download');"
fi

# Get ethernet interface name
MAIN_NETWORK_ADAPTER=$(whiptail --inputbox --title "Set the network adapter" " What is the name of your main network adapter? \n$main_interface_detect was detected automatically, ensure it is correct." 20 60 "$main_interface_detect" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $MAIN_NETWORK_ADAPTER ]; then
    fail "Entry was blank - please set your main network adapter"
  fi
else
  fail "User cancelled"
fi

# Get gateway
GATEWAY=$(whiptail --inputbox --title "Set the gateway IP" " Please set yout gateway IP \n$gateway_detect was detected automatically, ensure it is correct." 20 60 "$gateway_detect" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $GATEWAY ]; then
    fail "Entry was blank - please set your main network adapter"
  fi
else
    fail "User cancelled"
fi

# Get subnet
MAIN_SUBNET=$(whiptail --inputbox --title "Set subnet to use" " Please set the subnet for your network? \n$subnet_detect was detected automatically, ensure it is correct." 20 60 "$subnet_detect" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $MAIN_SUBNET ]; then
    fail "Entry was blank - please set your main network adapter"
  fi
else
  fail "User cancelled"
fi

# Allocate subnet IPs
ALLOCATE_SUBNET=$(whiptail --inputbox --title "Set subnet to use for IP allocation" "Please set the subnet macvlan can allocate IPs from? \n$subnet_detect was detected automatically, You could use a smaller range, e.g. \n192.168.1.192/28 will allocate IPs from 192.168.1.193 to 192.168.1.206" 20 60 "$subnet_detect" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z ALLOCATE_SUBNET ]; then
  fail "Entry was blank - please set your main network adapter"
  fi
else
fail "User cancelled"
fi

# Get domain
DOMAIN=$(whiptail --inputbox --title "Domain" "Please set the default traefik domain \nexample.com" 20 60 "example.com" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $DOMAIN ]; then
  fail "Entry was blank - please set your main network adapter"
  fi
else
fail "User cancelled"
fi

# Get restart_policy
RESTART_POLICY==$(whiptail --inputbox --title "Restart Policy" "Please set the default docker restart_policy" 20 60 "unless-stopped" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
  if [ -z $RESTART_POLICY ]; then
  fail "Entry was blank - please set your main network adapter"
  fi
else
fail "User cancelled"
fi

# Insert data
sqlite ../variables.db "insert into settings (name,value,comment) values ('MAIN_NETWORK_ADAPTER', '$MAIN_NETWORK_ADAPTER', 'The network adapter to use for private IPs with macvlan');"
sqlite ../variables.db "insert into settings (name,value,comment) values ('GATEWAY', '$GATEWAY', '');"
sqlite ../variables.db "insert into settings (name,value,comment) values ('MAIN_SUBNET', '$MAIN_SUBNET', '');"
sqlite ../variables.db "insert into settings (name,value,comment) values ('ALLOCATE_SUBNET', '$ALLOCATE_SUBNET', '');"
sqlite ../variables.db "insert into settings (name,value,comment) values ('DOMAIN', '$DOMAIN', '');"
sqlite ../variables.db "insert into settings (name,value,comment) values ('RESTART_POLICY', '$RESTART_POLICY', '');"

# Make dirs
for dir in $ANIME_DIRECTORY $AUDIOBOOKS_DIRECTORY $BACKUPS_DIRECTORY $CODE_DIRECTORY $COMICS_DIRECTORY $DOWNLOADS_DIRECTORY $EBOOKS_DIRECTORY $EMULATION_DIRECTORY $HOME_DIRECTORY $ISO_DIRECTORY $MANGA_DIRECTORY $MOVIES_DIRECTORY $PLAYLISTS_DIRECTORY $PODCASTS_DIRECTORY $RAW_DIRECTORY $TORRENTWATCH_DIRECTORY
do
if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    fail "$dir already exists but is not a directory" 1>&2
fi
done


# dir_array+=("/mnt/borgmatic/" "/mnt/borgmatic/target" "/mnt/borgmatic/config" "/mnt/borgmatic/config2" "/mnt/borgmatic/ssh" "/mnt/borgmatic/cache" "/mnt/borgmatic/source")
# dir_array+=("/mnt/exatorrent")
# dir_array+=("/mnt/owncloud")
# dir_array+=("/mnt/plex/" "/mnt/plex/config")
# dir_array+=("/mnt/projectsend" "/mnt/projectsend/data" "/var/data/projectsend" "/var/data/projectsend/config")
# dir_array+=("/mnt/duplicati" "/mnt/duplicati/source" "/var/data/duplicati" "/var/data/duplicati/config")
# dir_array+=("/mnt/nextcloud" "/var/data/nextcloud" "/var/data/nextcloud/config")
# dir_array+=("/mnt/rsnapshot" "/var/data/rsnapshot" "/mnt/snapshots" "/mnt/external" "/var/data/rsnapshot/config")