#!/bin/bash

PHP_VERSION=$(php -r "echo PHP_VERSION;" | grep --only-matching --perl-regexp "\d+.\d+")

# Get the value of xdebug.client_host in xdebug.ini
OLD_IP=$(awk -F "=" '/xdebug.client_host/ {print $2}' /etc/php/$PHP_VERSION/mods-available/xdebug.ini)

# Get the new IP address (in case you have restarted the computer)
NEW_IP=$(awk '/nameserver/ {print $2}' /etc/resolv.conf)

echo "Current IP address :  " $OLD_IP
echo "New IP address :  " $NEW_IP

# Replace old IP by the new and restart php (in my case php-fpm)
sudo sed -i /etc/php/7.4/mods-available/xdebug.ini -e 's/'$OLD_IP'/'$NEW_IP'/g' && sudo service php7.4-fpm restart
