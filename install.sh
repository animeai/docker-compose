#!/bin/sh
# Functions
function fail {
    printf '%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

# Check this hasn't been run before
DATABASE="./variables.db"
 if [ -f "$DATABASE" ] 
 then
  fail "variables.db exists - this should only be run once! If you are trying to upgrade, use upgrade.sh to back up the existing database, create a new one with default values and then insert any stored values from the old database"
 fi

# Ensure whiptail is installed
whiptail-install=$(dpkg -s ncurses-examples | grep Status)
if [[ $whiptail-install == *"installed"* ]]; then
  echo "whiptail is installed, continuing"
else
  apt install whiptail -y
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
net-tools-install==$(dpkg -s ncurses-examples | grep Status)

apt install net-tools docker docker-compose -y

# Find variables
gateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')

# Set up database with defaults
sqlite variables.db "create table settings (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"
# sqlite variables.db "insert into settings (name,value,comment) values ('', '', '');"
sqlite variables.db "insert into settings (name,value,comment) values ('ANIME_DIRECTORY', '/mnt/anime', 'The location to store anime');"
sqlite variables.db "insert into settings (name,value,comment) values ('AUDIOBOOKS_DIRECTORY', '/mnt/audiobooks', 'The location to store audiobooks');"
sqlite variables.db "insert into settings (name,value,comment) values ('BACKUPS_DIRECTORY', '/mnt/backups', 'The location to store general backups');"
sqlite variables.db "insert into settings (name,value,comment) values ('CODE_DIRECTORY', '/mnt/code', 'The directory to store code and projects');"
sqlite variables.db "insert into settings (name,value,comment) values ('COMICS_DIRECTORY', '/mnt/comics', 'The directory to store comics');"
sqlite variables.db "insert into settings (name,value,comment) values ('DOWNLOADS_DIRECTORY', '/mnt/downloads', 'the location to store downloads');"
sqlite variables.db "insert into settings (name,value,comment) values ('EBOOKS_DIRECTORY', '/mnt/ebooks', 'The location to store ebooks');"
sqlite variables.db "insert into settings (name,value,comment) values ('EMULATION_DIRECTORY', '/mnt/emulation', 'The location to store roms');"
sqlite variables.db "insert into settings (name,value,comment) values ('HOME_DIRECTORY', '$HOME', 'The location to store ebooks');"
sqlite variables.db "insert into settings (name,value,comment) values ('ISO_DIRECTORY', '/mnt/iso', 'The location to store operating system ISO files');"
sqlite variables.db "insert into settings (name,value,comment) values ('MANGA_DIRECTORY', '/mnt/manga', 'The location to store manga');"
sqlite variables.db "insert into settings (name,value,comment) values ('MOVIES_DIRECTORY', '/mnt/movies', 'The location to store movies');"
sqlite variables.db "insert into settings (name,value,comment) values ('PLAYLISTS_DIRECTORY', '/mnt/playlists', 'The location to store playlists');"
sqlite variables.db "insert into settings (name,value,comment) values ('PODCASTS_DIRECTORY', '/mnt/podcasts', 'The location to store podcasts');"
sqlite variables.db "insert into settings (name,value,comment) values ('RAW_DIRECTORY', '/mnt/raw', 'The location to store RAWs');"
sqlite variables.db "insert into settings (name,value,comment) values ('TORRENTWATCH_DIRECTORY', '/mnt/torrentwatch', 'The location to place .torrent files for download');"

# Set up shared variables
sqlite variables.db "create table shared (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"
# sqlite variables.db "insert into shared (name,value,comment) values ('', '', '');"
sqlite variables.db "insert into shared (name,value,comment) values ('GATEWAY_IP', '$gateway', 'Gateway IP for the local network');"
echo 
# "GATEWAY_IP=192.168.1.1" >> /root/vars.sh 
# "SUBNET_IP=192.168.1.1/24" >> /root/vars.sh 
# "SUBNET_RANGE=192.168.1.192/28" >> /root/vars.sh  # 192.168.1.192 to 192.168.1.206


# dir_array+=("/mnt/borgmatic/" "/mnt/borgmatic/target" "/mnt/borgmatic/config" "/mnt/borgmatic/config2" "/mnt/borgmatic/ssh" "/mnt/borgmatic/cache" "/mnt/borgmatic/source")
# dir_array+=("/mnt/exatorrent")
# dir_array+=("/mnt/owncloud")
# dir_array+=("/mnt/plex/" "/mnt/plex/config")
# dir_array+=("/mnt/projectsend" "/mnt/projectsend/data" "/var/data/projectsend" "/var/data/projectsend/config")
# dir_array+=("/mnt/duplicati" "/mnt/duplicati/source" "/var/data/duplicati" "/var/data/duplicati/config")
# dir_array+=("/mnt/nextcloud" "/var/data/nextcloud" "/var/data/nextcloud/config")
# dir_array+=("/mnt/rsnapshot" "/var/data/rsnapshot" "/mnt/snapshots" "/mnt/external" "/var/data/rsnapshot/config")