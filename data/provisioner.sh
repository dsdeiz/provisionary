#!/usr/bin/env bash

set -e

apt-get update -y && apt-get upgrade -y
apt-get install -y git curl vim-tiny nginx \
  mariadb-server mariadb-client \
  php7.0-mbstring php7.0-gd php7.0-xml php7.0-mysql \
  php7.0-cli php7.0-fpm php7.0-curl php7.0-zip

if [[ ! -f /usr/local/bin/composer ]]; then
  curl -s -o composer-setup.php https://getcomposer.org/installer
  php composer-setup.php
  rm -f composer-setup.php
  mv composer.phar /usr/local/bin/composer
fi

composer global require -nq --no-progress drush/drush

if [[ ! -f /etc/nginx/sites-available/dynamic.conf || ! -h /etc/nginx/sites-enabled/dynamic.conf ]]; then
  curl -s -o /etc/nginx/sites-available/dynamic.conf https://raw.githubusercontent.com/timhtheos/nginx-dynamic-server-block/master/dynamic-ubuntu17.04-php7.conf
  ln -s /etc/nginx/sites-available/dynamic.conf /etc/nginx/sites-enabled/dynamic.conf
  service nginx restart
fi

echo "Set up done."
