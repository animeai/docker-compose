#!/bin/bash
#Set up Variables...
timestamp=$(date +%d-%m-%Y_%H-%M-%S)

#Set env variables for systemd https://serverfault.com/questions/413397/how-to-set-environment-variable-in-systemd-service

#File operations
touch /root/vars.sh #make sure vars file exists
touch /root/vars.$(timestamp).bak #make sure backup file exists 
cp /root/vars.sh > /root/vars.$(timestamp).bak #backup current file
echo "" > /root/vars.sh # clear current file

#Secret Data
echo "CLOUDFLARE_API_EMAIL=username@outlook.com" >> /root/vars.sh #cloudflare email
echo "CLOUDFLARE_API_KEY=cloudflarekey" #cloudflare api key
echo "DOMAIN=test.co.uk" >> /root/vars.sh #default domain
echo "EMAIL=username@outlook.com" >> /root/vars.sh #default email
echo "PLEX_TOKEN=plextoken" >> /root/vars.sh #Set your plex token for connectivity
echo "PROJECTSEND_WORK_DOMAIN=files.domain.co.uk" >> /root/vars.sh #Work project send domain (single variable, include subdomain)
echo "RADARR_TOKEN=12345" >> /root/vars.sh #Set your Radarr token for connectivity
echo "TRAEFIK_BASIC_AUTH=/var/data/secrets/traefik_basic_auth.htpasswd" >> /root/vars.sh #traefik basic auth file

#Static IPs and Network
echo "ETHERNET_PORT=eth0" >> /root/vars.sh 
echo "GATEWAY_IP=192.168.1.1" >> /root/vars.sh 
echo "SUBNET_IP=192.168.1.1/24" >> /root/vars.sh 
echo "SUBNET_RANGE=192.168.1.192/28" >> /root/vars.sh  #192.168.1.192 to 192.168.1.206
echo "ADGUARDHOME_ONE_IP=192.168.1.200" >> /root/vars.sh 
echo "ADGUARDHOME_TWO_IP=192.168.1.201" >> /root/vars.sh 
echo "NETBOOTXYZ_IP=192.168.1.199" >> /root/vars.sh 
echo "PIHOLE_ONE_IP=192.168.1.202" >> /root/vars.sh 
echo "PIHOLE_TWO_IP=192.168.1.203" >> /root/vars.sh 
echo "PIHOLEUNBOUND_IP=192.168.1.204" >> /root/vars.sh 
echo "PORTUS_IP=192.168.1.198" >> /root/vars.sh 

#Shared Vars
echo "TIMEZONE=Europe/London" >> /root/vars.sh 
echo "TZ=Europe/London" >> /root/vars.sh #clean up dupe later
echo "PUID=0" >> /root/vars.sh
echo "PGID=0" >> /root/vars.sh
echo "RESTART_POLICY=unless-stopped" >> /root/vars.sh 

#adsb Shared
echo "LAT=50.00000000000000" >> /root/vars.sh 
echo "LONG=-0.2000000000000000" >> /root/vars.sh 
echo "ALT=33m" >> /root/vars.sh 
echo "ALT_FT=130" >> /root/vars.sh 
echo "BINGKEY=bingkey" >> /root/vars.sh 
echo "SQUAWK_COUNTRY=UK" >> /root/vars.sh 

#adsb keys, settings, and names
echo "ADSBEXCHANGE_SITENAME=ADS-B Exchange Site Name" >> /root/vars.sh 
echo "ADSBEXCHANGE_UUID=uuid" >> /root/vars.sh 
echo "ADSBEXCHANGE_REDUCE_INTERVAL=5" >> /root/vars.sh 
echo "ADSBHUB_CLIENTKEY=clientkey" >> /root/vars.sh 
echo "FLIGHTAIRMAP_USERNAME=user" >> /root/vars.sh 
echo "FLIGHTAIRMAP_PASS=pass" >> /root/vars.sh 
echo "FR24_KEY=fr24key" >> /root/vars.sh 
echo "FR24_MLAT=yes" >> /root/vars.sh 
echo "OPENSKY_USERNAME=user" >> /root/vars.sh 
echo "OPENSKY_SERIAL=serial" >> /root/vars.sh 
echo "RADARBOX_SHARING_KEY=sharingkey" >> /root/vars.sh 
echo "PLANEFINDER_SHARECODE=sharecode" >> /root/vars.sh 
echo "PIAWARE_FEEDERID=feederid" >> /root/vars.sh 
echo "VIRTUALRADARSERVER_USERNAME=user" >> /root/vars.sh 
echo "VIRTUALRADARSERVER_PASS=pass" >> /root/vars.sh 

#Piaware settings
echo "PIAWARE_ALLOW_MLAT=yes" >> /root/vars.sh 
echo "PIAWARE_MLAT_RESULTS=yes" >> /root/vars.sh 
echo "PIAWARE_ALLOW_MODEAC=yes" >> /root/vars.sh 
echo "PIAWARE_VERBOSE_LOGGING=true" >> /root/vars.sh 


#ReadSB Settings
echo "READSB_MLAT=true" >> /root/vars.sh 
echo "READSB_DEVICE_TYPE=rtlsdr" >> /root/vars.sh 
echo "READSB_GAIN=autogain" >> /root/vars.sh 
echo "READSB_GNSS=true" >> /root/vars.sh 
echo "READSB_MAX_RANGE=500" >> /root/vars.sh 
echo "READSB_MODEAC=true" >> /root/vars.sh 
echo "READSB_NET_ENABLE=true" >> /root/vars.sh 
echo "READSB_RX_LOCATION_ACCURACY=2" >> /root/vars.sh 
echo "READSB_STATS_RANGE=true" >> /root/vars.sh 
echo "READSB_STATS_EVERY=15" >> /root/vars.sh 
echo "READSB_NET_BEAST_REDUCE_INTERVAL=1" >> /root/vars.sh 
echo "READSB_BEAST_MODEAC=true" >> /root/vars.sh 
echo "READSB_FORWARD_MLAT=true" >> /root/vars.sh 

#Misc vars
echo "BASEROW_MIGRATE=true"  >> /root/vars.sh  #Migrate Baserow on startup
echo "BASEROW_SYNC=true"  >> /root/vars.sh  #Synchronise Baserow templates on startup
echo "DRAWIO_CITY=London" >> /root/vars.sh #Set the City for DrawIO SSL
echo "DRAWIO_COUNTRY=United Kingdom" >> /root/vars.sh #Set the Country for DrawIO SSL
echo "DRAWIO_ORGNAME=Organisation" >> /root/vars.sh #Set the Organisation for DrawIO SSL
echo "DRAWIO_STATE=City of London" >> /root/vars.sh #Set the State for DrawIO SSL
echo "GITEADB_USER=gitea" >> /root/vars.sh #Set the Gitea database username
echo "JOPLINDB_DB=joplin" >> /root/vars.sh #Set the Jopline database name
echo "JOPLINDB_USER=joplin" >> /root/vars.sh #Set the Joplin database usernamne
echo "KANBOARDDB_DB=kanboarddb" >> /root/vars.sh #Set the Kanboard database name
echo "KANBOARDDB_USER=kanboarddb" >> /root/vars.sh #Set the Kanboard database username
echo "OPENRA_SERVERNAME=OpenRA Server" >> /root/vars.sh #Set the OpenRA Server Name
echo "OPENRA_SINGLE=true"  >> /root/vars.sh #Enable single player for OpenRA Server. true/false 
echo "OWNCLOUD_ADMIN_USERNAME=admin" >> /root/vars.sh #Set the owncloud username
echo "PROJECTSEND_MAX_UPLOAD=<5000>" >> /root/vars.sh 
echo "WORDPRESSDB_DB=wordpress" >> /root/vars.sh #Set the wordpress database name
echo "WORDPRESSDB_USER=wordpress" >> /root/vars.sh #Set the wordpress database user

#Passwords
echo "BOOKSTACK_MYSQL_ROOT=45678ultrasecure" >> /root/vars.sh #Set the mysql root password for the bookstack database
echo "BOOKSTACK_MYSQL=45678ultrasecure2" >> /root/vars.sh #Set the mysql root password for the bookstack database
echo "BORG_PASSPHRASE=34567ultrasecure" >> /root/vars.sh #Set the Borg password
echo "CODE_SERVER_PASS=33245ultrasecure" >> /root/vars.sh 
echo "CODE_SERVER_SUDO_PASS=66548ultrasecure" >> /root/vars.sh 
echo "EXPORTARR_TOKEN=12345supersecure" >> /root/vars.sh #Set the token used to share data in exportarr example:  http://exportarr.domain.com?token=yourexportarrtokenhere
echo "FLAME_PASS=56789ultrasecure" >> /root/vars.sh #Set the Flame password
echo "FLIGHTAIRMAP_INSTALL_PASS=11234ultrasecure" >> /root/vars.sh 
echo "FLIGHTAIRMAP_MYSQL_PASS=11235ultrasecure" >> /root/vars.sh 
echo "FLIGHTAIRMAP_MYSQL_ROOT=11236ultrasecure" >> /root/vars.sh 
echo "GHOSTDB_PASS=78910ultrasecure" >> /root/vars.sh #Set the Ghost database password
echo "GITEADB_PASS=90123ultrasecure" >> /root/vars.sh #Set the Gitea database password
echo "GITEADB_ROOTPASS=89012ultrasecure" >> /root/vars.sh #Set the Gitea root mysql password
echo "JOPLINDB_PASS=67890ultrasecure" >> /root/vars.sh #Set the Jopline database password
echo "KANBOARDDB_PASS=34567supersecure" >> /root/vars.sh #Set the kanboard mysql database password
echo "KANBOARDDB_ROOT=23456supersecure" >> /root/vars.sh #Set the Kanboard root mysql password
echo "OPENRA_PASS=01234ultrasecure" >> /root/vars.sh #Set the OpenRA password
echo "OPENVSCODE_SERVER_PASS=654822ultrasecure" >> /root/vars.sh 
echo "OPENVSCODE_SERVER_SUDO_PASS=325412ultrasecure" >> /root/vars.sh 
echo "OWNCLOUD_ADMIN_PASSWORD=12345ultrasecure" >> /root/vars.sh #Set the owncloud password
echo "OWNCLOUD_MYSQL_PASSWORD=23456ultrasecure" >> /root/vars.sh #Set the owncloud root mysql password
echo "PORTUSDB_PASS=56789supersecure" >> /root/vars.sh 
echo "PORTUS_PASS=67890supersecure" >> /root/vars.sh 
echo "WORDPRESSDB_PASS=45678supersecure" >> /root/vars.sh #Set the Wordpress database password

#Ports
echo "ADGUARDHOMESYNC_PORT=52467" >> /root/vars.sh #adguardhome-sync port (local network only)
echo "DELUGE_PORT=52458" >> /root/vars.sh #deluge data port (must be forwarded in router firewall)
echo "EXATORRENT_PORT=52462" >> /root/vars.sh #Set the ExaTorrent data port. Must be forwarded in the router.
echo "GITEA_SSHPORT=52461" >> /root/vars.sh #Set the ssh port for Gitea
echo "JOPLINDB_PORT=55566" >> /root/vars.sh #Set the JoplinDB port
echo "QBITTORRENT_PORT=52457" >> /root/vars.sh #qbittorrent data port (must be forwarded in router firewall)
echo "RUTORRENT_TCPPORT=52459" >> /root/vars.sh #Set the RuTorrent TCP Port. Must be forwarded in the router
echo "RUTORRENT_UDPPORT=52460" >> /root/vars.sh #Set the RuTorrent UDP port. Must be forwarded in the router
echo "TRANSMISSION_PORT=52456" >> /root/vars.sh #transnimssion data port (must be allowed in router firewall)

#Subdomains
echo "ADGUARDHOME_ONE_SUB=adguard" >> /root/vars.sh 
echo "ADGUARDHOME_TWO_SUB=adguard2" >> /root/vars.sh 
echo "AUTHELIA_SUB=authelia" >> /root/vars.sh #Authelia subdomain
echo "AUDIOBOOKSHELF_SUB=audiobookshelf" >> /root/vars.sh
echo "BASEROW_BACKEND_SUB=baserow-backend" >> /root/vars.sh
echo "BASEROW_FRONTEND_SUB=baserow" >> /root/vars.sh
echo "BASEROW_PUB_BACKEND_SUB=baserow-backend-public" >> /root/vars.sh
echo "BASEROW_PUB_FRONTEND_SUB=baserow-public" >> /root/vars.sh
echo "BEEHIVE_SUB=beehive" >> /root/vars.sh
echo "BETANIN_SUB=betanin" >> /root/vars.sh
echo "BOOKSONIC_SUB=booksonic" >> /root/vars.sh #Booksonic subdomain
echo "BOOKSTACK_SUB=bookstack" >> /root/vars.sh #Bookstack subdomain
echo "CALIBREWEB_SUB=calibreweb" >> /root/vars.sh #Calibre Web subdomain
echo "CALIBREDESK_SUB=calibredesk" >> /root/vars.sh #Calibre subdomain
echo "CALIBRE_SUB=calibre" >> /root/vars.sh #Calibre subdomain
echo "CALIBRE_SERVER_SUB=calibre-server" >> /root/vars.sh
echo "CODESERVER_SUB=codeserver" >> /root/vars.sh #Codeserver subdomain
echo "COPS_SUB=cops" >> /root/vars.sh #COPS subdomain
echo "DASHMACHINE_SUB=dashmachine" >> /root/vars.sh #Dash Machine subdomain
echo "DELUGE_SUB=deluge" >> /root/vars.sh #Deluge subdomain
echo "DRAWIO_SUB=drawio" >> /root/vars.sh #DrawIO subdomain
echo "DUPLICATI_SUB=duplicati" >> /root/vars.sh #Duplicati subdomain
echo "EMBYSTAT_SUB=embystat" >> /root/vars.sh #Embystat subdomain
echo "EMULATORJS_BACKEND_SUB=emulatorjs-backend" >> /root/vars.sh #EmulatorJS backend  subdomain
echo "EMULATORJS_SUB=emulation" >> /root/vars.sh #EmulatorJS subdomain
echo "EXPORTARR_SUB=exportarr" >> /root/vars.sh #Exportarr subdomain
echo "FLAME_SUB=flame" >> /root/vars.sh #Flame subdomain
echo "FR24_SUB=fr24" >> /root/vars.sh #
echo "FLIGHTAIRMAP_SUB=flightairmap" >> /root/vars.sh 
echo "GAPS_SUB=gaps" >> /root/vars.sh #Gaps subdomain
echo "GHOST_SUB=ghost" >> /root/vars.sh #Ghost subdomain
echo "GITEA_SUB=gitea" >> /root/vars.sh #Gitea subdomain
echo "GRAPHS1090_SUB=graphs1090" >> /root/vars.sh 
echo "GROCY_SUB=grocy" >> /root/vars.sh #Grocy subdomain
echo "HASTEBIN_SUB=hastebin" >> /root/vars.sh #Hastebin subdomain
echo "HEIMDALL_SUB=heimdall" >> /root/vars.sh #Heimdall subdomain
echo "HOMER_SUB=homer" >> /root/vars.sh #Homer subdomain
echo "HTPCMANAGER_SUB=htpcmanager" >> /root/vars.sh #HTPC Manager subdomain
echo "HUGINN_SUB=huginn" >> /root/vars.sh
echo "JACKETT_SUB=jackett" >> /root/vars.sh #Jackett subdomain
echo "JOPLIN_SUB=joplin" >> /root/vars.sh #Joplin subdomain
echo "KANBOARD_SUB=kanboard" >> /root/vars.sh #Kanboard subdomain
echo "KOMGA_SUB=komga" >> /root/vars.sh #Komega subdomain
echo "KUMA_SUB=kuma" >> /root/vars.sh #Kuma Uptime Monitor subdomain
echo "LANGUAGETOOL_SUB=languagetool" >> /root/vars.sh #Language Tool subdomain
echo "LAZYLIBRARIAN_SUB=librarian" >> /root/vars.sh #Lazy Librarian subdomain
echo "LIBRESPEED_SUB=libreseed" >> /root/vars.sh #Librespeed subdomain
echo "LIDARR_SUB=lidarr" >> /root/vars/sh #Lidarr subdomain
echo "LINKDING_SUB=linkding" >> /root/vars.sh #Linkding subdomain
echo "MAGICMIRROR_SUB=magicmirror" >> /root/vars.sh #Magic Mirror subdomain
echo "MEALIE_SUB=mealie" >> /root/vars.sh #Mealie subdomain
echo "MEDUSA_SUB=medusa" >> /root/vars.sh #Medusa subdomain
echo "METATUBE_SUB=metatube" >> /root/vars.sh
echo "METUBE_SUB=metube" >> /root/vars.sh
echo "MONITORR_SUB=monitorr" >> /root/vars.sh #Monitorr subdomain
echo "MOVIEMATCH_SUB=moviematch" >> /root/vars.sh #Movie Match subdomain
echo "MSTREAM_SUB=mstream" >> /root/vars.sh #MStream subdomain
echo "MUXIMUX_SUB=muximux" >> /root/vars.sh #Muximux subdomain
echo "MYLAR_SUB=mylar" >> /root/vars.sh #Mylar subdomain
echo "NETBOOT_SUB=netboot" >> /root/vars.sh #Netboot subdomain
echo "NEXTCLOUD_SUB=nextcloud" >> /root/vars.sh #Nextcloud subdomain
echo "OMBI_SUB=ombi" >> /root/vars.sh #ombi subdomain
echo "OPENRA_SUB=openra" >> /root/vars.sh #OpenRA subdomain
echo "ORGANIZR_SUB=organizr" >> /root/vars.sh #Organizr subdomain
echo "OVERSEERR_SUB=overseerr" >> /root/vars.sh #Overseer subdomain
echo "OWNCLOUD_SUB=owncloud" >> /root/vars.sh #Owncloud subdomain
echo "PLANEFINDER_SUB=planefinder" >> /root/vars.sh 
echo "PLEX_SUB=plex" >> /root/vars.sh #plex subdomain
echo "PIAWARE_SUB=piaware" >> /root/vars.sh
echo "PODGRAB_SUB=podgrab" >> /root/vars.sh
echo "PORTAINER_SUB=portainer" >> /root/vars.sh #Portainer subdomain
echo "POSTERR_SUB=posterr" >> /root/vars.sh #Posterr subdomain
echo "PROJECTSEND_PERSONAL_SUB=send" >> /root/vars.sh #Project Send Personal subdomain
echo "PROWLARR_SUB=prowlarr" >> /root/vars.sh #Prowlarr subdomain
echo "PRIVATEBIN_SUB=privatebin" >> /root/vars.sh 
echo "QBITTORRENT_SUB=qbittorrent" >> /root/vars.sh #Qbittorrent subdomain
echo "RADARR_SUB=radarr" >> /root/vars.sh #Radarr 
echo "READSB_SUB=readsb" >> /root/vars.sh #Radarr 
echo "READARR_SUB=readarr" >> /root/vars.sh #Readarr subdomain
echo "RUTORRENT_SUB=rutorrent" >> /root/vars.sh #RuTorrent subdomain
echo "SICKCHILL_SUB=sickchill" >> /root/vars.sh #Sickchill subdomain
echo "SICKGEAR_SUB=sickgear" >> /root/vars.sh #Sickgear subdomain
echo "SNIPPITBOX_SUB=snippitbox" >> /root/vars.sh #Snippit Box subdomain
echo "SONARR_SUB=sonarr" >> /root/vars.sh #Sonarr subdomain
echo "TAISUN_SUB=taisun" >> /root/vars.sh #taisun subdomain
echo "TAR1090_SUB=tar1090" >> /root/vars.sh
echo "TAUTULLI_SUB=tautulli" >> /root/vars.sh #taisun subdomain
echo "TORRENTMONITOR_SUB=torrentmonitor" >> /root/vars.sh #Torrent Monitor subdomain
echo "TRAEFIK_SUB=traefik" >> /root/vars.sh #traefik subdomain
echo "TRANSMISSION_SUB=transmission" >> /root/vars.sh #transmission subdomain
echo "UBOOQUITY_ADMIN_SUB=ubooquity-admin" >> /root/vars.sh #ubooquity admin subdomain
echo "UBOOQUITY_SUB=ubooquity" >> /root/vars.sh #ubooquity subdomain
echo "VSCODE_SUB=vscode" >> /root/vars.sh #Open VS Code subdomain
echo "WHOOGLE_SUB=whoogle" >> /root/vars.sh #Whoogle subdomain
echo "WIREGUARD_SUB=wireguard" >> /root/vars.sh #Wireguard subdomain
echo "WORDPRESS_SUB=wordpress" >> /root/vars.sh #Wordpress subdomain

#create volume directories
dir_array=("/var/data" "/var/data/config")
dir_array+=("/mnt/audiobooks" "/mnt/books" "/mnt/backups" "/mnt/downloads" "/mnt/code" "/mnt/comics" "/mnt/ebooks" "/mnt/iso" "/mnt/manga" "/mnt/movies" "/mnt/movies/anime" "/mnt/movies/english" "/mnt/playlists" "/mnt/podcasts" "/mnt/raw" "/mnt/tv" "/mnt/tv/anime" "/mnt/tv/shows")
dir_array+=("/mnt/borgmatic/" "/mnt/borgmatic/target" "/mnt/borgmatic/config" "/mnt/borgmatic/config2" "/mnt/borgmatic/ssh" "/mnt/borgmatic/cache" "/mnt/borgmatic/source")
dir_array+=("/mnt/data/netbootxyz" "/mnt/data/netbootxyz/config")
dir_array+=("/mnt/emulation/" "/mnt/emulation/3do/" "/mnt/emulation/3do/roms" "/mnt/emulation/arcade" "/mnt/emulation/arcade/roms" "/mnt/emulation/atari2600/roms" "/mnt/emulation/atari7800" "/mnt/emulation/atari7800/roms" "/mnt/emulation/colecovision" "/mnt/emulation/colecovision/roms" "/mnt/emulation/doom" "/mnt/emulation/doom/roms" "/mnt/emulation/gb/" "/mnt/emulation/gb/roms" "/mnt/emulation/gba" "/mnt/emulation/gba/roms" "/mnt/emulation/gbc" "/mnt/emulation/gbc/roms" "/mnt/emulation/jaguar" "/mnt/emulation/jaguar/roms" "/mnt/emulation/lynx/" "/mnt/emulation/lynx/roms" "/mnt/emulation/msx" "/mnt/emulation/msx/roms" "/mnt/emulation/n64" "/mnt/emulation/n64/roms" "/mnt/emulation/nds" "/mnt/emulation/nds/roms" "/mnt/emulation/nes" "/mnt/emulation/nes/roms" "/mnt/emulation/ngp" "/mnt/emulation/ngp/roms" "/mnt/emulation/odyssey2" "/mnt/emulation/odyssey2/roms" "/mnt/emulation/pce" "/mnt/emulation/pce/roms" "/mnt/emulation/psx" "/mnt/emulation/psx/roms" "/mnt/emulation/sega32x" "/mnt/emulation/sega32x/roms" "/mnt/emulation/segaCD" "/mnt/emulation/segaCD/roms" "/mnt/emulation/segaGG" "/mnt/emulation/segaGG/roms" "/mnt/emulation/segaMD" "/mnt/emulation/segaMD/roms" "/mnt/emulation/segaMS" "/mnt/emulation/segaMS/roms" "/mnt/emulation/segaSaturn" "/mnt/emulation/segaSaturn/roms" "/mnt/emulation/segaSG" "/mnt/emulation/segaSG/roms" "/mnt/emulation/snes" "/mnt/emulation/snes/roms" "/mnt/emulation/vb" "/mnt/emulation/vb/roms" "/mnt/emulation/vectrex" "/mnt/emulation/vectrex/roms" "/mnt/emulation/ws" "/mnt/emulation/ws/roms")
dir_array+=("/mnt/exatorrent")
dir_array+=("/mnt/owncloud")
dir_array+=("/mnt/plex/" "/mnt/plex/config")
dir_array+=("/mnt/projectsend" "/mnt/projectsend/data" "/var/data/projectsend" "/var/data/projectsend/config")
dir_array+=("/var/data/acceleratedtext" "/var/data/acceleratedtext/logback")
dir_array+=("/var/data/adguardhome" "/var/data/adguardhome/work" "/var/data/adguardhome/config")
dir_array+=("/var/data/adguardhome-sync" "/var/data/adguardhome-sync/config")
dir_array+=("/var/data/adguardhome2" "/var/data/adguardhome2/work" "/var/data/adguardhome2/config") 
dir_array+=("/var/data/airsonic" "/var/data/airsonic/config")
dir_array+=("/var/data/apprise-api" "/var/data/apprise-api/config")
dir_array+=("/var/data/audiobookshelf" "/var/data/audiobookshelf/config" "/var/data/audiobookshelf/metadata")
dir_array+=("/var/data/authelia" "/var/data/authelia/config")
dir_array+=("/var/data/authelia" "/var/data/authelia/config")
dir_array+=("/var/data/bazarr" "/var/data/bazarr/config")
dir_array+=("/var/data/booksonic" "/var/data/booksonic/config")
dir_array+=("/var/data/bookstack" "/var/data/bookstack/config" "/var/data/bookstack/dbconfig")
dir_array+=("/var/data/calibre" "/var/data/calibre/config")
dir_array+=("/var/data/calibreweb" "/var/data/calibreweb/config")
dir_array+=("/var/data/codeserver" "/var/data/codeserver/config")
dir_array+=("/var/data/cops" "/var/data/cops/config")
dir_array+=("/var/data/deluge" "/var/data/deluge/config")
dir_array+=("/mnt/duplicati" "/mnt/duplicati/source" "/var/data/duplicati" "/var/data/duplicati/config")
dir_array+=("/var/data/embystat" "/var/data/embystat/config")
dir_array+=("/var/data/emulatorjs" "/var/data/emulatorjs/config")
dir_array+=("/var/data/files")
dir_array+=("/var/data/files/shared")
dir_array+=("/var/data/files/traefik" "/var/data/files/traefik/rules" "/var/data/files/traefik/acme")
dir_array+=("/var/data/flame" "/var/data/flame/data")
dir_array+=("/var/data/gaps" "/var/data/gaps/data")
dir_array+=("/var/data/gitea" "/var/data/gitea/data" "/var/data/gitea/mysql")
dir_array+=("/var/data/grocy" "/var/data/grocy/config")
dir_array+=("/var/data/hastebin" "/var/data/hastebin/db")
dir_array+=("/var/data/headphones" "/var/data/headphones/config")
dir_array+=("/var/data/heimdall" "/var/data/heimdall/config")
dir_array+=("/var/data/homer" "/var/data/homer/assets")
dir_array+=("/var/data/htpcmanager" "/var/data/htpcmanager/config")
dir_array+=("/var/data/jackett" "/var/data/jackett/config")
dir_array+=("/var/data/jellyfin" "/var/data/jellyfin/config")
dir_array+=("/var/data/joplindb" "/var/data/joplindb/db")
dir_array+=("/var/data/kanboard" "/var/data/kanboard/db" "/var/data/kanboard/app" "/var/data/kanboard/plugins" "/var/data/kanboard/ssl")
dir_array+=("/var/data/komga" "/var/data/komga/config")
dir_array+=("/var/data/lazylibrarian" "/var/data/lazylibrarian/config") 
dir_array+=("/var/data/librespeed" "/var/data/librespeed/config")
dir_array+=("/var/data/lidarr" "/var/data/lidarr/config")
dir_array+=("/var/data/linkding" "/var/data/linkding/data")
dir_array+=("/var/data/magic_mirror" "/var/data/magic_mirror/config" "/var/data/magic_mirror/modules")
dir_array+=("/var/data/mealie" "/var/data/mealie/data")
dir_array+=("/var/data/medusa" "/var/data/medusa/config")
dir_array+=("/var/data/metatube" "/var/data/metatube/db")
dir_array+=("/var/data/mstream" "/var/data/mstream/config")
dir_array+=("/var/data/muximux/" "/var/data/muximux/config")
dir_array+=("/var/data/mylar" "/var/data/mylar/config")
dir_array+=("/mnt/nextcloud" "/var/data/nextcloud" "/var/data/nextcloud/config")
dir_array+=("/var/data/ngrams" "/var/data/ngrams/data")
dir_array+=("/var/data/ombi/" "/var/data/ombi/config")
dir_array+=("/var/data/organizr" "/var/data/organizr/config")
dir_array+=("/var/data/overseerr" "/var/data/overseerr/config")
dir_array+=("/var/data/owncloud" "/var/data/owncloud/mysql" "/var/data/owncloud/redis")
dir_array+=("/var/data/portainer" "/var/data/portainer/data")
dir_array+=("/var/data/portus" "/var/data/portus/registry" "/var/data/portus/data" "/var/data/portus/clair" "/var/data/portus/background" "/var/data/portus/webpack")
dir_array+=("/var/data/posterr/" "/var/data/posterr/config" "/var/data/posterr/custom")
dir_array+=("/var/data/privatebin" "/var/data/privatebin/data")
dir_array+=("/var/data/projectsendwork" "/var/data/projectsendwork/config" "/mnt/projectsendwork" "/mnt/projectsendwork/data")
dir_array+=("/var/data/prowlarr" "/var/data/prowlarr/config")
dir_array+=("/var/data/qbittorrent" "/var/data/qbittorrent/config")
dir_array+=("/var/data/radarr" "/var/data/radarr/config")
dir_array+=("/var/data/readarr" "/var/data/readarr/config")
dir_array+=("/mnt/rsnapshot" "/var/data/rsnapshot" "/mnt/snapshots" "/mnt/external" "/var/data/rsnapshot/config")
dir_array+=("/var/data/rutorrent" "/var/data/rutorrent/config" "/mnt/rutorrent")
dir_array+=("/var/data/secrets")
dir_array+=("/var/data/sickchill" "/var/data/sickchill/config")
dir_array+=("/var/data/sickgear" "/var/data/sickgear/config")
dir_array+=("/var/data/snippitbox" "/var/data/snippitbox/data")
dir_array+=("/var/data/sonarr" "/var/data/sonarr/config")
dir_array+=("/var/data/tautulli" "/var/data/tautulli/config")
dir_array+=("/var/data/transmission" "/var/data/transmission/config" "/var/data/transmission/watch")
dir_array+=("/var/data/ubooquity" "/var/data/ubooquity/config")
dir_array+=("/var/data/uptime-kuma" "/var/data/uptime-kuma/data")
dir_array+=("/var/data/wireguard" "/var/data/wireguard/config")
dir_array+=("/var/data/wordpress" "/var/data/wordpress/html" "/var/data/wordpress/db")
dir_array+=("/var/data/youtubedl" "/var/data/youtubedl/appdata" "/var/data/youtubedl/subscriptions" "/var/data/youtubedl/users" "/mnt/youtubedl" "/mnt/youtubedl/video" "/mnt/youtubedl/audio")
dir_array+=("/var/data/adsb" ("/var/data/adsb/piaware" "/var/data/adsb/piaware/cache" "/var/data/adsb/readsb" "/var/data/adsb/readsb/readsbpb_rrd" "/var/data/adsb/readsb/readsbpb_autogain" "/var/data/adsb/shared" "/var/data/adsb/shared/readsb" "/var/data/adsb/fr24" "/var/data/adsb/fr24/log" "/var/data/adsb/virtualradar" "/var/data/adsb/virtualradar/config" "/var/data/adsb/flightairmap" "/var/data/adsb/flightairmap/mysql")
dir_array+=("/var/data/pihole-unbound" "/var/data/pihole-unbound/pihole1" "/var/data/pihole-unbound/pihole1/volume" "/var/data/pihole-unbound/pihole1/config" "/var/data/pihole-unbound/pihole1/config/hosts" "/var/data/pihole-unbound/pihole2" "/var/data/pihole-unbound/pihole2/volume" "/var/data/pihole-unbound/pihole2/config")

for dir in ${dirarry[@]}
do
  if [ ! -d "$dir" ] 
  then
    mkdir $dir
    chmod -R 777 $dir
    chown -R root $dir
  fi
done

#Get needed yml files
if [ ! -f /var/data/portus/clair/clair.yml ]
then
source="      source: s/host=postgres port=5432 user=postgres password=portus sslmode=disable statement_timeout=60000"
replace="      source: host=portus-postgres port=5432 user=postgres password=$PORTUSDB_PASS sslmode=disable statement_timeout=60000"
  wget -m https://raw.githubusercontent.com/SUSE/Portus/master/examples/compose/clair/clair.yml -p /var/data/portus/clair
  chmod 777 /var/data/portus/clair/clair.yml 
  chown root /var/data/portus/clair/clair.yml 
  sed -i 's/$source/$replace/' /var/data/portus/clair/clair.yml 
fi
if [ ! -f /var/data/portus/certificate/portus.crt ]
then
  wget -m https://raw.githubusercontent.com/SUSE/Portus/master/examples/development/compose/portus.crt -p /var/data/portus/certificate
  chmod 777 /var/data/portus/certificate/portus.crt 
  chown root /var/data/portus/certificate/portus.crt
fi
if [ ! -f /var/data/acceleratedtext/logback/transactor-logback.xml ]
then
 wget -m https://raw.githubusercontent.com/accelerated-text/accelerated-text/master/transactor-logback.xml -p /var/data/acceleratedtext/logback
 chmod 777 /var/data/acceleratedtext/logback/transactor-logback.xml
 chown root /var/data/acceleratedtext/logback/transactor-logback.xml
fi

#create volume files
for $file in /var/data/pihole-unbound/pihole2/config/hosts /var/data/pihole-unbound/pihole2/config/resolv.conf /var/data/pihole-unbound/pihole2/config/dnsmasq.conf /var/data/pihole-unbound/pihole2/config/pihole-FTL.conf /var/data/pihole-unbound/pihole1/config/hosts /var/data/pihole-unbound/pihole1/config/resolv.conf /var/data/pihole-unbound/pihole1/config/dnsmasq.conf /var/data/pihole-unbound/pihole1/config/pihole-FTL.conf /var/data/files/traefik/traefik.log /var/data/dashmachine /var/data/dashmachine/data /var/data/secrets/traefik_basic_auth.htpasswd 
do
if [ ! -f "$file" ] 
  touch $file
  chmod 777 $file
  chown root $file
fi
done

#Set up Piaware
if [ ! -f /etc/modprobe.d/blacklist-rtl2832.conf ]
then 
touch /etc/modprobe.d/blacklist-rtl2832.conf
echo "blacklist rtl2832" >> /etc/modprobe.d/blacklist-rtl2832.conf
echo "blacklist dvb_usb_rtl28xxu" >> /etc/modprobe.d/blacklist-rtl2832.conf
echo "blacklist rtl2832_sdr" >> /etc/modprobe.d/blacklist-rtl2832.conf
fi


# Finish things off
chmod 600 /root/vars.sh
source /root/vars.sh #enable vars in bash

#Useful stuff for other scripts
#cat /dev/urandom | tr -dc '0-9a-zA-Z!@#$%^&*_+-' | head -c 15 | docker secret create db_password - #Create random password and write to docker secret

#Update docker container using original settings - does this work with swarm?
#docker run --rm \
#-v /var/run/docker.sock:/var/run/docker.sock \
#containrrr/watchtower \
#--run-once nextcloud