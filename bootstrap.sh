#!/usr/bin/env bash
apt-get update
sudo apt-get install -y python-software-properties

apt-add-repository ppa:ondrej/php
apt-get update
apt-get install -y nginx
apt-get install -y  php php7.0-fpm php7.0-pgsql php7.0-mysql

sudo service nginx start

if ! [ -L /usr/share/nginx/www ]; then
  rm -rf /usr/share/nginx/www
  ln -fs /vagrant/pages /usr/share/nginx/www
fi


if ! [ -L /etc/nginx/sites-available/ ]; then
  rm -rf /etc/nginx/sites-available/
  mkdir /etc/nginx/sites-available/
  cp -rf /vagrant/config/default /etc/nginx/sites-available/default
fi

if ! [ -L /etc/php/7.0/fpm ]; then
  rm -f /etc/php/7.0/fpm/php.ini
  cp -rf /vagrant/config/php.ini /etc/php/7.0/fpm/php.ini
fi


sudo service nginx restart

sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386] http://mirror.lstn.net/mariadb/repo/10.1/ubuntu precise main'
sudo apt-get update
sudo apt-get install -y mariadb-client mariadb-server


