#!/usr/bin/env bash
set -e
set -o errexit

aptGet install apache2

# sudo ufw allow 'OpenSSH'
# sudo ufw allow 'Apache Secure'

sudo a2enmod ssl
sudo a2enmod http2
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_http2
sudo a2enmod proxy_wstunnel
sudo a2enmod headers
sudo a2enmod brotli

echo "Protocols h2 http/1.1" | sudo tee --append /etc/apache2/apache2.conf

sudo service apache2 restart
