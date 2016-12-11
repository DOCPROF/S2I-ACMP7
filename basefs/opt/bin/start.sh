#!/bin/bash

# Creates the .env file needs by Laravel using
# The environment variables set both by the system
# and the openshift application (deploy configuration)
env > /opt/app-root/src/.env

# init database
mysql_install_db 
# start mysql
mysqld --skip-grant-tables &

# Starts PHP FPM in a non-deamon mode (that is set on configuration)
php-fpm --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini

# Starts caddy as a deamon using the custom configuration file
caddy -conf /etc/caddy/caddy.conf
