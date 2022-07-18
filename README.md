Dockarr Composarr
===
Current version
---
Pre 0.1, not public.

Why the weird name?
---
Decided in the tradition of apps like radarr, sonarr, and a multitude of others. This is a play on "docker-compose" => "docker-composer" => "dockarr-composarr"... Sorry!

Pronounced: Dock-arrr Com-po-sarrr - talk like a pirate! 

Notes
---
Main branch is always stable and tested. New apps, code changes, etc will always be tested in a new branch. NOTE: At this moment in time, the main branch is NOT stable and is NOT tested. It will be stable/tested when V0.1 is released and the 0.1-testing branch is published as main. 

0.1-testing branch is the latest version of the code.

There are no plans to document the latest tested versions. If the "latest" tag on a docker container fails, raise an issue so it can be investigated and fixed. Major version upgrades to containers can sometimes introduce breaking changes. Docker images should be updated frequently for security patches.

Features
---
* sqlite database to store environment variables for your docker containers.
* whiptail installer to write custom .env, and set your app up as a systemd service.

Requirements
---
* Docker
* Docker-compose
* Tested on Ubuntu 22.04 but should work on any *nix system with the above

Version naming convention
---
* V0.1 early alpha - Do not expect this to be stable! Do not expect this to be fully tested! Expect to have to start from scratch when updated!
* V0.2 mostly stable beta - Final schema and V1 functionality should be in place. There is a very small potential that breaking changes may be introduced but this should not happen unless major security flaws are discovered.
* V0.2.1 bugfix or new app added etc
* V1.0 first fully tested new release. The first stable and fully tested release! Breaking changes from this point onwards will require additional code to manage existing installations.
* V1.0.1 bugfix or new app added
* V1.1 new minor functionality added
* V2.0 new milestone reached or major functionality added.

After V1.0 there will be no beta or testing releases. All testing will be done in branches as each pull request generates its own branch where the testing will occur.

Roadmap
---
V0.1 Initial release
* Finish adding .env file to all apps (0.1-testing branch) <= In progress.
* Write install.sh for all apps (0.1-testing branch) <= In progress.
* Test all docker-compose.yml to ensure the container starts (0.1-testing branch).
* Release to public when the above are completed.

V0.1.1+
* Add any new apps
* Write uninstall.sh for all apps (0.1-testing branch).
* Write update.sh for all apps (0.1-testing branch).
* Review /var/log filesystem for all apps and remove from docker-compose if this directory is not used. (0.1-testing branch).
* Investigate the use of docker secrets to store passwords and other sensitive information rather than .env files.
  * Would need testing to see if it can be automated with bash (and via php shell_exec later).
  * Would need to be implemented prior to V0.2 as this would break existing installs and require additional code to fix.
* Release as V0.2 when the above are complete.

V0.2 First "stable" and mostly tested release
* Begin to test functionality of docker containers. Begin testing for fixable bugs (i.e. config issues/errors) and refer upstream bugs to container providers.
* Add more apps (new branch to test each app). Test the app. Test install.sh, uninstall.sh, update.sh, and recover.sh for the app before pulling to main. Test functionality of docker container before pulling to main.
* Begin use of docker scan https://docs.docker.com/engine/scan/ on all selected docker images. Refer vulnerabilities to upstream provider. Select alternative provider if possible/required.
* Release as 1.0 when the above is completed.

V1.0/1.1
* Test in multiple environments (AMD64, ARMv7, ARM64, bare metal, VPS, VM) and fix issues. Flag containers as unusable if attempting to install on unsupported architecture.
* Test on multiple operating systems
  * Ubuntu 
  * Debian
  * Arch Linux
  * Fedora
  * openSUSE
  * CentOS
  * FreeBSD
* Finished testing all added apps for functionality and fixable bugs (i.e. config bugs). Refer upstream bugs to container providers.
* Add README.md to each app folder explaining variables, use and ports.
* Add a Cloudflare cname management docker container and test.
  * To test: 
    * https://hub.docker.com/r/tiredofit/traefik-cloudflare-companion
    * cloudflared to tunnel externally accessible apps.
* Add the ability to flag apps as "unsafe" meaning the user needs to click "continue" after a warning stating there are security flaws and that it should not be used in a production environment. Unsafe apps would be fine on a private home network using Cloudflare tunnels or Zerotier but risky if public facing, even higher risk with exposed and mapped ports.

V2.0+
* Add a web interface to compliment the manual CLI interface (new branch for web interface)
  * This will likely require an install.php (or similar) script for each app along with a central control panel and will be a long way in the future. Likely scheduled for V2.
  * PHP shell_exec allows bash commands to be run, and sqlite3 is well supported. The whiptail section of the intall/uninstall/update script would be replaced with a php form which on submit updates the sqlite database and creates the service files etc. This would need appropriate access control. PHP pam_auth could be used for simple authentication.
  * I would need to learn how to build docker containers (rather than just use them) before this is possible if no other developers help out.
  * Completion of this feature is the most likely trigger for a V2.0 release.
* Add the ability to include both a local (Zerotier compatible) domain as well as a Cloudflare fully qualified domain name. 
  * You can map Cloudflare DNS to local IPs so foo.bar.com points to your external IP, but local-foo.bar.com points to your internal IP. 
  * This would mess with a Cloudflare cname provisioning docker container as we would need to be able to specify which subdomains are local, and which are public. 
  * This would also mess with letsencrypt so https would either need to be wildcard, self-signed, or disabled.
  * Likely scheduled for V2/3.
* Add backup and restore for docker volumes to allow for safe upgrading of container images. Support for remote backups should be included in this feature. Likely scheduled for V2.
* Optional MySQL container to store variables
  * Likely scheduled for V2/3 if ever. This isn't intended to be a multi-use application and sqlite is only used to store variables. There is negligible benefit in using MySQL here.

Contributing
---
Feel free to clone and improve in a branch of your own. Please submit a pull request back to us to improve the app!
Guidance:
* Clone the repo and create a new branch. Name your branch appropriately i.e. "Add MyApp"
* Install stickler for code linting so you get no surprises when you submit a pull request - see https://stickler-ci.com/ for details
* Every app needs the following files (as a minimum):
  * docker-compose.yml : Please reuse code from other apps, or the template folder with comments removed.
  * install.sh : Please reuse code from other apps, or the template folder with comments removed. If you write new code for a feature, please add this to snippits.sh for easy reference.
  * update.sh : Please reuse code from other apps, or the template folder with comments removed
  * unintall.sh : Please reuse code from other apps, or the template folder with comments removed
  * .env : Two sections - "Shared" and "App specific". Please sort each section alphabetically.
  * (optinoal) Any files the container needs to run (configuration files, etc)
* With few exceptions, added apps must be under active development. Stale projects which have not been updated in years will typically not be considered.
* Docker containers should not be self written unless you intend to update them regularly with security patching. 
* Docker containers should be a maximum of 6 months old (if not self updating) to ensure the latest security patches are applied and the project is not abandoned.
* App creators own docker containers are preferred unless there is either:
  * A simpler to use, more stable, more updated 3rd party provider (i.e. linuxserver's offerings)
  * The app creator does not publish and/or update their containers
* Docker containers which do not receive regular updates and contain security flaws will be depreciated in favour of updated containers. The container used by a script may be replaced without warning if security flaws become extreme. They may also be temporarily disabled or give a warning to the user if they are unsafe (relies on future update)
* Please use ONE branch for ONE feature, or ONE new application. Only include multiple new features in a single branch and pull request if they are reliant on one another. Multiple features or new apps in a single pull request makes code review and testing more complex for me.
* If you write documentation, please spellcheck it! British English spelling is preferred, but US English is acceptable. US English spelling may be converted to British English spelling on acceptance of a pull request.   


Install and use
---
TBD - currently unfinished!

Manual use of the docker-compose.yml file should be possible but these are all untested, may contain bugs, and contain extra lines of code for finding bad container (i.e. logs stored in /var/log and not published).

(Scheduled for V0.1) Once completed initial install should be as simple as:
* git clone
* cd to directory
* "bash install.sh" and follow the whiptail instructions
* cd to "traefik" directory
* "bash install.sh" and follow the whiptail instructions

(Scheduled for V0.1) Once completed, application install should be as simple as:
* perform initial install (required once only)
* cd to app directory
* "bash install.sh" and follow the whiptail instructions

(Scheduled for V0.1) Once completed, application uninstall should be as simple as:
* cd to app directory
* "bash uninstall.sh" and follow the whiptail instructions

(Scheduled for V0.1) Once completed, update to running container and/or env variables should be as simple as:
* cd to app directory
* "bash update.sh" and follow the whiptail instructions

(Scheduled for V2.0 or earlier) Once completed, upgrading the container to the most recent "latest" tag should be as simple as:
* cd to app directory
* "bash backup.sh" and follow the whiptail instructions to back up the volume(s)
* "bash restore.sh" and follow the whiptail instructions to return to one of the saved backups

To recover any password for an app (or just show any stored variables)
* cd to app directory
* "bash recover.sh" and follow the whiptail instructions

Apps
---
TBD - see comment at the top of every docker-compose.yml file.

Licence
---
GNU GPL v3 - see LICENCE.md

&copy; animeai 2022