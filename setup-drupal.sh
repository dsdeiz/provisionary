#!/usr/bin/env bash

set -e

# Start MySQL temporarily.
/usr/sbin/mysqld &
sleep 3

# Create user and database.
mysql -e "CREATE DATABASE drupal7"
mysql -e "GRANT ALL PRIVILEGES ON drupal7.* To 'drupal7'@'localhost' IDENTIFIED BY 'drupal7'"
mysql -e "FLUSH PRIVILEGES"

~/.composer/vendor/bin/drush dl drupal-7 --destination=/var/www/sites/drupal7.dev --drupal-project-rename=www -y
~/.composer/vendor/bin/drush --root=/var/www/sites/drupal7.dev/www si --site-name="Drupal 7" --db-url="mysql://drupal7:drupal7@localhost/drupal7" minimal -y

# Shutdown MySQL.
mysqladmin shutdown
