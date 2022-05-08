#!/bin/bash
#Set up Variables
timestamp=$(date +%d-%m-%Y_%H-%M-%S)

#File operations
touch /root/vars.sh #make sure vars file exists
touch /root/vars.$(timestamp).bak #make sure backup file exists 
cp /root/vars.sh > /root/vars.$(timestamp).bak #backup current file
echo "" > /root/vars.sh # clear current file

#Secret Data
echo "CLOUDFLARE_API_EMAIL=nathankeir@outlook.com" >> /root/vars.sh #cloudflare email
echo "CLOUDFLARE_API_KEY=af0f951432378e02926dc361ee8e88b35be8b" #cloudflare api key
echo "DOMAIN=prombot.co.uk" >> /root/vars.sh #default domain
echo "EMAIL=nathankeir@outlook.com" >> /root/vars.sh #default email
echo "PLEX_TOKEN=plextoken" >> /root/vars.sh #Set your plex token for connectivity
echo "PROJECTSEND_WORK_DOMAIN=files.myqms.co.uk" >> /root/vars.sh #Work project send domain (single variable, include subdomain)
echo "RADARR_TOKEN=12345" >> /root/vars.sh #Set your Radarr token for connectivity
echo "TRAEFIK_BASIC_AUTH=/var/data/secrets/traefik_basic_auth.htpasswd" >> /root/vars.sh #traefik basic auth file

#Misc vars
echo "BASEROW_MIGRATE=true" #Migrate Baserow on startup
echo "BASEROW_SYNC=true" #Synchronise Baserow templates on startup
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
echo "OPENRA_SINGLE=true" #Enable single player for OpenRA Server. true/false 
echo "OWNCLOUD_ADMIN_USERNAME=admin" >> /root/vars.sh #Set the owncloud username
echo "WORDPRESSDB_DB=wordpress" >> /root/vars.sh #Set the wordpress database name
echo "WORDPRESSDB_USER=wordpress" >> /root/vars.sh #Set the wordpress database user

#Passwords
echo "BOOKSTACK_MYSQL_ROOT=45678ultrasecure" >> /root/vars.sh #Set the mysql root password for the bookstack database
echo "BOOKSTACK_MYSQL=45678ultrasecure2" >> /root/vars.sh #Set the mysql root password for the bookstack database
echo "BORG_PASSPHRASE=34567ultrasecure" >> /root/vars.sh #Set the Borg password
echo "EXPORTARR_TOKEN=12345supersecure" >> /root/vars.sh #Set the token used to share data in exportarr example:  http://exportarr.domain.com?token=yourexportarrtokenhere
echo "FLAME_PASS=56789ultrasecure" >> /root/vars.sh #Set the Flame password
echo "GHOSTDB_PASS=78910ultrasecure" >> /root/vars.sh #Set the Ghost database password
echo "GITEADB_PASS=90123ultrasecure" >> /root/vars.sh #Set the Gitea database password
echo "GITEADB_ROOTPASS=89012ultrasecure" >> /root/vars.sh #Set the Gitea root mysql password
echo "JOPLINDB_PASS=67890ultrasecure" >> /root/vars.sh #Set the Jopline database password
echo "KANBOARDDB_PASS=34567supersecure" >> /root/vars.sh #Set the kanboard mysql database password
echo "KANBOARDDB_ROOT=23456supersecure" >> /root/vars.sh #Set the Kanboard root mysql password
echo "OPENRA_PASS=01234ultrasecure" >> /root/vars.sh #Set the OpenRA password
echo "OWNCLOUD_ADMIN_PASSWORD=12345ultrasecure" >> /root/vars.sh #Set the owncloud password
echo "OWNCLOUD_MYSQL_PASSWORD=23456ultrasecure" >> /root/vars.sh #Set the owncloud root mysql password
echo "PORTUSDB_PASS=56789supersecure"
echo "PORTUS_PASS=67890supersecure"
echo "WORDPRESSDB_PASS=45678supersecure" >> /root/vars.sh #Set the Wordpress database password

#Ports
echo "DELUGE_PORT=52458" >> /root/vars.sh #deluge data port (must be forwarded in router firewall)
echo "EXATORRENT_PORT=52462" >> /root/vars.sh #Set the ExaTorrent data port. Must be forwarded in the router.
echo "GITEA_SSHPORT=52461" >> /root/vars.sh #Set the ssh port for Gitea
echo "JOPLINDB_PORT=55566" >> /root/vars.sh #Set the JoplinDB port
echo "QBITTORRENT_PORT=52457" >> /root/vars.sh #qbittorrent data port (must be forwarded in router firewall)
echo "RUTORRENT_TCPPORT=52459" >> /root/vars.sh #Set the RuTorrent TCP Port. Must be forwarded in the router
echo "RUTORRENT_UDPPORT=52460" >> /root/vars.sh #Set the RuTorrent UDP port. Must be forwarded in the router
echo "TRANSMISSION_PORT=52456" >> /root/vars.sh #transnimssion data port (must be allowed in router firewall)

#Subdomains
echo "AUTHELIA_SUB=authelia" >> /root/vars.sh #Authelia subdomain
echo "BASEROW_BACKEND_SUB=baserow-backend"
echo "BASEROW_FRONTEND_SUB=baserow"
echo "BASEROW_PUB_BACKEND_SUB=baserow-backend-public"
echo "BASEROW_PUB_FRONTEND_SUB=baserow-public"
echo "BEEHIVE_SUB=beehive"
echo "BETANIN_SUB=betanin"
echo "BOOKSONIC_SUB=booksonic" >> /root/vars.sh #Booksonic subdomain
echo "BOOKSTACK_SUB=bookstack" >> /root/vars.sh #Bookstack subdomain
echo "CALIBREWEB_SUB=calibreweb" >> /root/vars.sh #Calibre Web subdomain
echo "CALIBREDESK_SUB=calibredesk" >> /root/vars.sh #Calibre subdomain
echo "CALIBRE_SUB=calibre" >> /root/vars.sh #Calibre subdomain
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
echo "GAPS_SUB=gaps" >> /root/vars.sh #Gaps subdomain
echo "GHOST_SUB=ghost" >> /root/vars.sh #Ghost subdomain
echo "GITEA_SUB=gitea" >> /root/vars.sh #Gitea subdomain
echo "GROCY_SUB=grocy" >> /root/vars.sh #Grocy subdomain
echo "HASTEBIN_SUB=hastebin" >> /root/vars.sh #Hastebin subdomain
echo "HEIMDALL_SUB=heimdall" >> /root/vars.sh #Heimdall subdomain
echo "HOMER_SUB=homer" >> /root/vars.sh #Homer subdomain
echo "HTPCMANAGER_SUB=htpcmanager" >> /root/vars.sh #HTPC Manager subdomain
echo "HUGINN_SUB=huginn"
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
echo "METATUBE_SUB=metatube"
echo "METUBE_SUB=metube"
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
echo "PLEX_SUB=plex" >> /root/vars.sh #plex subdomain
echo "PODGRAB_SUB=podgrab"
echo "PORTAINER_SUB=portainer" >> /root/vars.sh #Portainer subdomain
echo "POSTERR_SUB=posterr" >> /root/vars.sh #Posterr subdomain
echo "PROJECTSEND_PERSONAL_SUB=send" >> /root/vars.sh #Project Send Personal subdomain
echo "PROWLARR_SUB=prowlarr" >> /root/vars.sh #Prowlarr subdomain
echo "QBITTORRENT_SUB=qbittorrent" >> /root/vars.sh #Qbittorrent subdomain
echo "RADARR_SUB=radarr" >> /root/vars.sh #Radarr subdomain
echo "READARR_SUB=readarr" >> /root/vars.sh #Readarr subdomain
echo "RUTORRENT_SUB=rutorrent" >> /root/vars.sh #RuTorrent subdomain
echo "SICKCHILL_SUB=sickchill" >> /root/vars.sh #Sickchill subdomain
echo "SICKGEAR_SUB=sickgear" >> /root/vars.sh #Sickgear subdomain
echo "SNIPPITBOX_SUB=snippitbox" >> /root/vars.sh #Snippit Box subdomain
echo "SONARR_SUB=sonarr" >> /root/vars.sh #Sonarr subdomain
echo "TAISUN_SUB=taisun" >> /root/vars.sh #taisun subdomain
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
for $dir in /var/data /var/data/config /var/data/wireguard /var/data/wireguard/config /var/data/authelia /var/data/authelia/config /var/data/youtubedl /var/data/youtubedl/appdata /var/data/youtubedl/subscriptions  /var/data/youtubedl/users /mnt/youtubedl /mnt/youtubedl/video /mnt/youtubedl/audio /var/data/acceleratedtext /var/data/acceleratedtext/logback /var/data/betanin /var/data/metatube /var/data/metatube/db /var/data/betanin/data /var/data/betanin/config /var/data/portus /var/data/portus/registry /var/data/portus/data /var/data/portus/clair /var/data/portus/background /var/data/portus/webpack /var/data/linkding /var/data/linkding/data /var/data/grocy /var/data/grocy/config /var/data/kanboard /var/data/kanboard/db /var/data/kanboard/app /var/data/kanboard/plugins /var/data/kanboard/ssl /var/data/librespeed /var/data/librespeed/config /var/data/gaps /var/data/gaps/data /mnt/exatorrent /var/data/gitea /var/data/gitea/data /var/data/gitea/mysql /var/data/snippitbox /var/data/snippitbox/data /var/data/wordpress /var/data/wordpress/html /var/data/wordpress/db  /var/data/joplindb /var/data/joplindb/db /var/data/hastebin /var/data/hastebin/db /var/data/posterr/ /var/data/privatebin /var/data/privatebin/data /var/data/posterr/config /var/data/posterr/custom /var/data/homer /var/data/homer/assets /var/data/flame /var/data/flame/data /var/data/magic_mirror /var/data/magic_mirror/config /var/data/magic_mirror/modules /var/data/rutorrent /var/data/rutorrent/config /mnt/rutorrent /var/data/bookstack /var/data/bookstack/config /var/data/bookstack/dbconfig /var/data/ngrams /var/data/ngrams/data /var/data/mealie /var/data/mealie/data /mnt/borgmatic/ /mnt/borgmatic/target /mnt/borgmatic/config /mnt/borgmatic/config2 /mnt/borgmatic/ssh /mnt/borgmatic/cache /mnt/borgmatic/source /var/data/audiobookshelf /var/data/audiobookshelf/config /var/data/audiobookshelf/metadata /var/data/uptime-kuma /var/data/uptime-kuma/data /var/data/komga /var/data/komga/config /mnt/manga /mnt/comics /mnt/owncloud /var/data/authelia /var/data/authelia/config /var/data/portainer /var/data/portainer/data /var/data/deluge /var/data/deluge/config /var/data/owncloud /var/data/owncloud/mysql /var/data/owncloud/redis /var/data/cops /var/data/cops/config /mnt/code /mnt/ebooks /var/data/codeserver /var/data/codeserver/config /var/data/calibreweb /var/data/calibreweb/config /var/data/booksonic /var/data/booksonic/config /var/data/bazarr /var/data/bazarr/config /var/data/airsonic /var/data/airsonic/config /mnt/playlists /mnt/podcasts /var/data/jackett /var/data/jellyfin /var/data/jellyfin/config /var/data/jackett/config /var/data/heimdall /var/data/heimdall/config /var/data/htpcmanager /var/data/htpcmanager/config /var/data/headphones /var/data/headphones/config /var/data/emulatorjs /var/data/emulatorjs/config /var/data/embystat /var/data/embystat/config /var/data/nextcloud /var/data/nextcloud/config /mnt/comics /mnt/manga /var/data/mylar /var/data/mylar/config /var/data/files /mnt/iso /mnt/data/netbootxyz /mnt/data/netbootxyz/config /var/data/muximux/ /var/data/muximux/config /var/data/mstream /var/data/mstream/config /var/data/lidarr /var/data/lidarr/config /mnt/audiobooks /var/data/medusa /var/data/medusa/config /var/data/calibre /var/data/calibre/config /var/data/lazylibrarian /var/data/lazylibrarian/config /var/data/sonarr /var/data/sonarr/config /var/data/sickchill /var/data/sickchill/config /var/data/sickgear /var/data/sickgear/config /var/data/rsnapshot /mnt/snapshots /mnt/external /var/data/rsnapshot/config /var/data/readarr /var/data/readarr/config /mnt/projectsend /var/data/radarr /var/data/radarr/config /var/data/qbittorrent /var/data/qbittorrent/config /mnt/projectsend/data /var/data/projectsend /var/data/projectsend/config /var/data/projectsendwork /var/data/projectsendwork/config /mnt/projectsendwork /mnt/projectsendwork/data /var/data/prowlarr /var/data/prowlarr/config /var/data/overseerr /var/data/overseerr/config /var/data/files/shared /mnt/books /mnt/plex/ /var/data/organizr /var/data/organizr/config /mnt/plex/config /mnt/comics /mnt/raw /var/data/ubooquity /var/data/ubooquity/config /mnt/tv /mnt/movies /mnt/movies/anime /mnt/tv/anime /mnt/tv/shows /var/data/ombi/ /var/data/ombi/config /var/data/transmission /var/data/transmission/config /var/data/transmission/watch /mnt/downloads /var/data/secrets /var/data/tautulli /var/data/tautulli/config /var/data/files/traefik /var/data/files/traefik/rules /var/data/files/traefik/acme /mnt/emulation/ /mnt/emulation/3do/roms  /mnt/emulation/arcade/roms  /mnt/emulation/atari2600/roms  /mnt/emulation/atari7800/roms  /mnt/emulation/colecovision/roms  /mnt/emulation/doom/roms  /mnt/emulation/gb/roms  /mnt/emulation/gba/roms  /mnt/emulation/gbc/roms  /mnt/emulation/jaguar/roms  /mnt/emulation/lynx/roms  /mnt/emulation/msx/roms  /mnt/emulation/n64/roms  /mnt/emulation/nds/roms  /mnt/emulation/nes/roms  /mnt/emulation/ngp/roms  /mnt/emulation/odyssey2/roms  /mnt/emulation/pce/roms  /mnt/emulation/psx/roms  /mnt/emulation/sega32x/roms  /mnt/emulation/segaCD/roms  /mnt/emulation/segaGG/roms  /mnt/emulation/segaMD/roms  /mnt/emulation/segaMS/roms  /mnt/emulation/segaSaturn/roms  /mnt/emulation/segaSG/roms  /mnt/emulation/snes/roms  /mnt/emulation/vb/roms  /mnt/emulation/vectrex/roms  /mnt/emulation/ws/roms
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
for $file in /var/data/files/traefik/traefik.log /var/data/dashmachine /var/data/dashmachine/data /var/data/secrets/traefik_basic_auth.htpasswd 
do
if [ ! -f "$file" ] 
  touch $file
  chmod 777 $file
  chown root $file
fi
done

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