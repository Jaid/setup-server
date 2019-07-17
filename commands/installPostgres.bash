#!/usr/bin/env bash
set -e
set -o errexit

if [[ $# -eq 0 ]]; then
  echo "Password not given."
  exit 1
fi

# Based on https://tecadmin.net/install-postgresql-server-on-ubuntu/

sudo apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

if [ ! -f /etc/apt/sources.list.d/pgdg.list ]; then
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
fi

aptGet update
aptGet install postgresql postgresql-contrib

sudo ufw allow 5432

postgresUser=postgres
sudo -u $postgresUser psql -c "ALTER USER $postgresUser PASSWORD '$1';"

sudo replace "#* *listen_addresses = 'localhost'" "listen_addresses = '*'" /etc/postgresql/*/main/postgresql.conf
echo -e "local all all md5\nhost all all 0.0.0.0/0 md5\nhost all all ::/0 md5" | sudo tee /var/lib/postgresql/11/main/pg_hba.conf

sudo service postgresql restart
