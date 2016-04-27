#!/bin/bash

# Define error handling function
handle_error()
{
  echo "[`date +'%Y-%m-%d %H:%M:%S'`] ERROR: $1" >&2
  exit 1
}

echo "[`date +'%Y-%m-%d %H:%M:%S'`] Check prerequisites..."

echo "[`date +'%Y-%m-%d %H:%M:%S'`] mysql"
mysql --help 1>/dev/null 2>/dev/null || handle_error "Please install mysql (sudo apt-get install mysql-server)!"

echo "[`date +'%Y-%m-%d %H:%M:%S'`] git"
git help 1>/dev/null 2>/dev/null || handle_error "Please install git (sudo apt-get install git)!"


echo "[`date +'%Y-%m-%d %H:%M:%S'`] Options..."
read -p "MySQL root password [$MYSQL_ROOT_PASSWORD] ?" MYSQL_ROOT_PASSWORD
if [ $DEFAULT_MYSQL_CREATE_SAMPLE = "" ] ; then
  DEFAULT_MYSQL_CREATE_SAMPLE=y
fi
read -p "Create sample data [$DEFAULT_MYSQL_CREATE_SAMPLE] ?" MYSQL_CREATE_SAMPLE
if [ $MYSQL_CREATE_SAMPLE = "" ] ; then
  MYSQL_CREATE_SAMPLE=$DEFAULT_MYSQL_CREATE_SAMPLE
fi
if [ $MYSQL_CREATE_SAMPLE = "Y" ] ; then
  MYSQL_CREATE_SAMPLE=y
fi

echo "[`date +'%Y-%m-%d %H:%M:%S'`] Installing nodejs (refer to https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)"

sudo apt-get install curl || handle_error "Can't instal curl!"
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - || handle_error "Can't install nodejs!"
sudo apt-get install -y nodejs || handle_error "Can't install nodejs!"

echo "[`date +'%Y-%m-%d %H:%M:%S'`] Installing node modules..."

for module in express mysql ejs serve-favicon morgan cookie-parser body-parser debug async request apac
do
  echo "[`date +'%Y-%m-%d %H:%M:%S'`] Installing module $module..."
  npm install $module || handle_error "Can't instal $module!"
done

echo "[`date +'%Y-%m-%d %H:%M:%S'`] Creating database (empty)..."
mysql --default-character-set=utf8 --user=root --password="$MYSQL_ROOT_PASSWORD" < db/create_database.sql

if [ $MYSQL_CREATE_SAMPLE = "y" ] ; then
  mysql --default-character-set=utf8 --user=root --password="$MYSQL_ROOT_PASSWORD" < db/insert_sample_data.sql
fi
