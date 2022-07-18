#!/bin/sh

# TO DO: Clean up variables so naming is consistant

# sqlite variables.db "select * FROM passwords WHERE name = 'test');"

# Functions and variables
function generate_password {
    </dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12
}
# timestamp=$(date +%d-%m-%Y_%H-%M-%S)

# Set up passwords
sqlite variables.db "create table passwords (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"
sqlite variables.db "insert into passwords (name,value,comment) values ('BOOKSTACK_MYSQL_ROOT', '$(generate_password)', 'Bookstack mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('BOOKSTACK_MYSQL', '$(generate_password)', 'Bookstack mySQL password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('BORG_PASSPHRASE', '$(generate_password)', 'Borg passphrase');"
sqlite variables.db "insert into passwords (name,value,comment) values ('CODE_SERVER_PASS', '$(generate_password)', 'Code Server password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('CODE_SERVER_SUDO_PASS', '$(generate_password)', 'Code Server sudo password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('EXPORTARR_TOKEN', '$(generate_password)', 'Exportarr token');"
sqlite variables.db "insert into passwords (name,value,comment) values ('FLAME_PASS', '$(generate_password)', 'Flame password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('FLIGHTAIRMAP_INSTALL_PASS', '$(generate_password)', 'Flight Air Map installation password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('FLIGHTAIRMAP_MYSQL_PASS', '$(generate_password)', 'Flight Air Map mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('FLIGHTAIRMAP_MYSQL_ROOT', '$(generate_password)', 'Flight Air Map mySQL password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('GHOSTDB_PASS', '$(generate_password)', 'Ghost mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('GITEADB_PASS', '$(generate_password)', 'Gitea mySQL  password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('GITEADB_ROOTPASS', '$(generate_password)', Gitea mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('JOPLINDB_PASS', '$(generate_password)', 'Joplin postgres password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('KANBOARDDB_PASS', '$(generate_password)', 'Kanboard mySQL password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('KANBOARDDB_ROOT', '$(generate_password)', 'Kanboard mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('OPENRA_PASS', '$(generate_password)', 'OpenRA password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('OPENVSCODE_SERVER_PASS', '$(generate_password)', 'Open VS Code Server password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('OPENVSCODE_SERVER_SUDO_PASS', '$(generate_password)', 'Open VS Code Server sudo password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('OWNCLOUD_ADMIN_PASSWORD', '$(generate_password)', 'Owncloud admin password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('OWNCLOUD_MYSQL_PASSWORD', '$(generate_password)', 'Owncloud mySQL password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('OWNCLOUD_ROOT_PASSWORD', '$(generate_password)', 'Owncloud mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('PORTUSDB_PASS', '$(generate_password)', 'Portus mySQL  password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('PORTUS_PASS', '$(generate_password)', 'Portus password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('WORDPRESSDB_PASS', '$(generate_password)', 'Wordpress mySQL password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('WORDPRESSDB_ROOTPASS', '$(generate_password)', 'Wordpress mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('LIBRESPEEDDB_ROOT', '$(generate_password)', 'Librespeed mySQL root password');"
sqlite variables.db "insert into passwords (name,value,comment) values ('LIBRESPEEDDB_PASS', '$(generate_password)', 'Librespeed mySQL root password');"

# Set up ports
sqlite variables.db "create table ports (name TEXT PRIMARY KEY, value TEXT UNIQUE, comment TEXT);"
sqlite variables.db "insert into ports (name,value,comment) values ('ADGUARDHOMESYNC_PORT', '52467', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('DELUGE_PORT', '52458', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('EXATORRENT_PORT', '52462', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('GITEA_SSHPORT', '52461', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('JOPLINDB_PORT', '55566', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('QBITTORRENT_PORT', '52457', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('RUTORRENT_TCPPORT', '52459', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('RUTORRENT_UDPPORT', '52460', '');"
sqlite variables.db "insert into ports (name,value,comment) values ('TRANSMISSION_PORT', '52456', '');"


# Set up subdomains
sqlite variables.db "create table subdomain (name TEXT PRIMARY KEY, value TEXT UNIQUE);"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_TWO_SUB', 'adguard2', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('AUDACITY_SUB', 'audacity', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('AUTHELIA_SUB', 'authelia', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('AUDIOBOOKSHELF_SUB', 'audiobookshelf', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BABYBUDDY_SUB', 'babybuddy', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BASEROW_BACKEND_SUB', 'baserow-backend', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BASEROW_FRONTEND_SUB', 'baserow', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BASEROW_PUB_BACKEND_SUB', 'baserow-backend-public', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BASEROW_PUB_FRONTEND_SUB', 'baserow-public', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BAZARR_SUB', 'bazarr', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BEEHIVE_SUB', 'beehive', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BEETS_SUB', 'beets', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BLENDER_SUB', 'blender', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BOOKSONIC_SUB', 'booksonic', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('BOOKSTACK_SUB', 'bookstack', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('CALIBREWEB_SUB', 'calibreweb', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('CALIBREDESK_SUB', 'calibredesk', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('CALIBRE_SUB', 'calibre', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('CALIBRE_SERVER_SUB', 'calibre-server', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('CODESERVER_SUB', 'codeserver', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('COPS_SUB', 'cops', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('DASHMACHINE_SUB', 'dashmachine', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('DELUGE_SUB', 'deluge', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('DRAWIO_SUB', 'drawio', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"
sqlite variables.db "insert into subdomain (name,value,comment) values ('ADGUARDHOME_ONE_SUB', 'adguard', '');"

# DUPLICATI_SUB=duplicati # Duplicati subdomain
# EMBYSTAT_SUB=embystat # Embystat subdomain
# EMULATORJS_BACKEND_SUB=emulatorjs-backend # EmulatorJS backend subdomain
# EMULATORJS_SUB=emulation # EmulatorJS subdomain
# EXPORTARR_SUB=exportarr # Exportarr subdomain
# EXATORRENT_SUB=exatorrent
# FLAME_SUB=flame # Flame subdomain
# FR24_SUB=fr24
# FLIGHTAIRMAP_SUB=flightairmap
# GAPS_SUB=gaps # Gaps subdomain
# GHOST_SUB=ghost # Ghost subdomain
# GITEA_SUB=gitea # Gitea subdomain
# GRAPHS1090_SUB=graphs1090
# GROCY_SUB=grocy # Grocy subdomain
# HASTEBIN_SUB=hastebin # Hastebin subdomain
# HEIMDALL_SUB=heimdall # Heimdall subdomain
# HOMER_SUB=homer # Homer subdomain
# HTPCMANAGER_SUB=htpcmanager # HTPC Manager subdomain
# HUGINN_SUB=huginn
# JACKETT_SUB=jackett # Jackett subdomain
# JOPLIN_SUB=joplin # Joplin subdomain
# KANBOARD_SUB=kanboard # Kanboard subdomain
# KOMGA_SUB=komga # Komega subdomain
# KUMA_SUB=kuma # Kuma Uptime Monitor subdomain
# LANGUAGETOOL_SUB=languagetool # Language Tool subdomain
# LAZYLIBRARIAN_SUB=librarian # Lazy Librarian subdomain
# LIBRESPEED_SUB=libreseed # Librespeed subdomain
# LIDARR_SUB=lidarr
# LINKDING_SUB=linkding # Linkding subdomain
# MAGICMIRROR_SUB=magicmirror # Magic Mirror subdomain
# MEALIE_SUB=mealie # Mealie subdomain
# MEDUSA_SUB=medusa # Medusa subdomain
# METATUBE_SUB=metatube
# METUBE_SUB=metube
# MONITORR_SUB=monitorr # Monitorr subdomain
# MOVIEMATCH_SUB=moviematch # Movie Match subdomain
# MSTREAM_SUB=mstream # MStream subdomain
# MUXIMUX_SUB=muximux # Muximux subdomain
# MYLAR_SUB=mylar # Mylar subdomain
# NETBOOT_SUB=netboot # Netboot subdomain
# NEXTCLOUD_SUB=nextcloud # Nextcloud subdomain
# OMBI_SUB=ombi # ombi subdomain
# OPENRA_SUB=openra # OpenRA subdomain
# ORGANIZR_SUB=organizr # Organizr subdomain
# OVERSEERR_SUB=overseerr # Overseer subdomain
# OWNCLOUD_SUB=owncloud # Owncloud subdomain
# PLANEFINDER_SUB=planefinder
# PLEX_SUB=plex # plex subdomain
# PIAWARE_SUB=piaware
# PODGRAB_SUB=podgrab
# PORTAINER_SUB=portainer # Portainer subdomain
# POSTERR_SUB=posterr # Posterr subdomain
# PROJECTSEND_PERSONAL_SUB=send # Project Send Personal subdomain
# PROWLARR_SUB=prowlarr # Prowlarr subdomain
# PRIVATEBIN_SUB=privatebin
# QBITTORRENT_SUB=qbittorrent # Qbittorrent subdomain
# RADARR_SUB=radarr # Radarr 
# READSB_SUB=readsb # Radarr 
# READARR_SUB=readarr # Readarr subdomain
# RUTORRENT_SUB=rutorrent # RuTorrent subdomain
# SICKCHILL_SUB=sickchill # Sickchill subdomain
# SICKGEAR_SUB=sickgear # Sickgear subdomain
# SNIPPITBOX_SUB=snippitbox # Snippit Box subdomain
# SONARR_SUB=sonarr # Sonarr subdomain
# TAISUN_SUB=taisun # taisun subdomain
# TAR1090_SUB=tar1090
# TAUTULLI_SUB=tautulli # taisun subdomain
# TORRENTMONITOR_SUB=torrentmonitor # Torrent Monitor subdomain
# TRAEFIK_SUB=traefik # traefik subdomain
# TRANSMISSION_SUB=transmission # transmission subdomain
# UBOOQUITY_ADMIN_SUB=ubooquity-admin # ubooquity admin subdomain
# UBOOQUITY_SUB=ubooquity # ubooquity subdomain
# VSCODE_SUB=vscode # Open VS Code subdomain
# WHOOGLE_SUB=whoogle # Whoogle subdomain
# WIREGUARD_SUB=wireguard # Wireguard subdomain
# WORDPRESS_SUB=wordpress # Wordpress subdomain

# Set up secret data
# "CLOUDFLARE_API_EMAIL=username@outlook.com" >> /root/vars.sh  # cloudflare email
# "CLOUDFLARE_API_KEY=cloudflarekey"  # cloudflare api key
# "DOMAIN=test.co.uk" >> /root/vars.sh  # default domain
# "EMAIL=username@outlook.com" >> /root/vars.sh  # default email
# "PLEX_TOKEN=plextoken" >> /root/vars.sh  # Set your plex token for connectivity
# "PLEX_CLAIM=plexclaim" >> /root/vars.sh 
# "PROJECTSEND_WORK_DOMAIN=files.domain.co.uk" >> /root/vars.sh  # Work project send domain (single variable, include subdomain)
# "RADARR_TOKEN=12345" >> /root/vars.sh  # Set your Radarr token for connectivity
# "TRAEFIK_BASIC_AUTH=/var/data/secrets/traefik_basic_auth.htpasswd" >> /root/vars.sh  # traefik basic auth file

# Static IPs and Network
# "ETHERNET_PORT=eth0" >> /root/vars.sh 
# "ADGUARDHOME_ONE_IP=192.168.1.200" >> /root/vars.sh 
# "ADGUARDHOME_TWO_IP=192.168.1.201" >> /root/vars.sh 
# "NETBOOTXYZ_IP=192.168.1.199" >> /root/vars.sh 
# "PIHOLE_ONE_IP=192.168.1.202" >> /root/vars.sh 
# "PIHOLE_TWO_IP=192.168.1.203" >> /root/vars.sh 
# "PIHOLEUNBOUND_IP=192.168.1.204" >> /root/vars.sh 
# "PORTUS_IP=192.168.1.198" >> /root/vars.sh 

# Shared Vars
# "TIMEZONE=Europe/London" >> /root/vars.sh 
# "TZ=Europe/London" >> /root/vars.sh  # clean up dupe later
# "PUID=0" >> /root/vars.sh
# "PGID=0" >> /root/vars.sh
# "RESTART_POLICY=unless-stopped" >> /root/vars.sh 

# adsb Variables
# "LAT=50.00000000000000" >> /root/vars.sh 
# "LONG=-0.2000000000000000" >> /root/vars.sh 
# "ALT=33m" >> /root/vars.sh 
# "ALT_FT=130" >> /root/vars.sh 
# "BINGKEY=bingkey" >> /root/vars.sh 
# "SQUAWK_COUNTRY=UK" >> /root/vars.sh 
# "ADSBEXCHANGE_SITENAME=ADS-B Exchange Site Name" >> /root/vars.sh 
# "ADSBEXCHANGE_UUID=uuid" >> /root/vars.sh 
# "ADSBEXCHANGE_REDUCE_INTERVAL=5" >> /root/vars.sh 
# "ADSBHUB_CLIENTKEY=clientkey" >> /root/vars.sh 
# "FLIGHTAIRMAP_USERNAME=user" >> /root/vars.sh 
# "FLIGHTAIRMAP_PASS=pass" >> /root/vars.sh 
# "FR24_KEY=fr24key" >> /root/vars.sh 
# "FR24_MLAT=yes" >> /root/vars.sh 
# "OPENSKY_USERNAME=user" >> /root/vars.sh 
# "OPENSKY_SERIAL=serial" >> /root/vars.sh 
# "RADARBOX_SHARING_KEY=sharingkey" >> /root/vars.sh 
# "PLANEFINDER_SHARECODE=sharecode" >> /root/vars.sh 
# "PIAWARE_FEEDERID=feederid" >> /root/vars.sh 
# "VIRTUALRADARSERVER_USERNAME=user" >> /root/vars.sh 
# "VIRTUALRADARSERVER_PASS=pass" >> /root/vars.sh 
# "PIAWARE_ALLOW_MLAT=yes" >> /root/vars.sh 
# "PIAWARE_MLAT_RESULTS=yes" >> /root/vars.sh 
# "PIAWARE_ALLOW_MODEAC=yes" >> /root/vars.sh 
# "PIAWARE_VERBOSE_LOGGING=true" >> /root/vars.sh 
# "READSB_MLAT=true" >> /root/vars.sh 
# "READSB_DEVICE_TYPE=rtlsdr" >> /root/vars.sh 
# "READSB_GAIN=autogain" >> /root/vars.sh 
# "READSB_GNSS=true" >> /root/vars.sh 
# "READSB_MAX_RANGE=500" >> /root/vars.sh 
# "READSB_MODEAC=true" >> /root/vars.sh 
# "READSB_NET_ENABLE=true" >> /root/vars.sh 
# "READSB_RX_LOCATION_ACCURACY=2" >> /root/vars.sh 
# "READSB_STATS_RANGE=true" >> /root/vars.sh 
# "READSB_STATS_EVERY=15" >> /root/vars.sh 
# "READSB_NET_BEAST_REDUCE_INTERVAL=1" >> /root/vars.sh 
# "READSB_BEAST_MODEAC=true" >> /root/vars.sh 
# "READSB_FORWARD_MLAT=true" >> /root/vars.sh 

# Misc variables
# "BASEROW_MIGRATE=true" >> /root/vars.sh  # Migrate Baserow on startup
# "BASEROW_SYNC=true" >> /root/vars.sh  # Synchronise Baserow templates on startup
# "BLENDER_KEYBOARD=en-uk-qwerty" >> /root/vars.sh
# "DRAWIO_CITY=London" >> /root/vars.sh  # Set the City for DrawIO SSL
# "DRAWIO_COUNTRY=United Kingdom" >> /root/vars.sh  # Set the Country for DrawIO SSL
# "DRAWIO_ORGNAME=Organisation" >> /root/vars.sh  # Set the Organisation for DrawIO SSL
# "DRAWIO_STATE=City of London" >> /root/vars.sh  # Set the State for DrawIO SSL
# "GITEADB_USER=gitea" >> /root/vars.sh  # Set the Gitea database username
# "JOPLINDB_DB=joplin" >> /root/vars.sh  # Set the Jopline database name
# "JOPLINDB_USER=joplin" >> /root/vars.sh  # Set the Joplin database usernamne
# "KANBOARDDB_DB=kanboarddb" >> /root/vars.sh  # Set the Kanboard database name
# "KANBOARDDB_USER=kanboarddb" >> /root/vars.sh  # Set the Kanboard database username
# "OPENRA_SERVERNAME=OpenRA Server" >> /root/vars.sh  # Set the OpenRA Server Name
# "OPENRA_SINGLE=true" >> /root/vars.sh  # Enable single player for OpenRA Server. true/false 
# "OWNCLOUD_ADMIN_USERNAME=admin" >> /root/vars.sh  # Set the owncloud username
# "PROJECTSEND_MAX_UPLOAD=<5000>" >> /root/vars.sh 
# "WORDPRESSDB_DB=wordpress" >> /root/vars.sh  # Set the wordpress database name
# "WORDPRESSDB_USER=wordpress" >> /root/vars.sh  # Set the wordpress database user
# "LIBRESPEEDDB_DB=lazylibrarian"
# "LIBRESPEEDDB_USER=lazylibrarian"

# Set up paths


