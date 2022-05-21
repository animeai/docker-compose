#!/bin/sh
mkdir /etc/docker/compose
chown "$USER":"docker" /etc/docker/compose -R
git clone https://github.com/animeai/docker-compose.git /etc/docker/compose