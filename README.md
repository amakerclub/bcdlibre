# bibliopuce

Small library software (borrowing and returning books management)

Logiciel de gestion d'une petite bibliothèque (gestion d'emprunt de livres)


## Install Bibliopuce

### On Debian 8 Jessie

* Update system
  ```sudo apt-get update
  sudo apt-get upgrade
  ```
  
* Install nodejs (refer to https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
  ```sudo apt-get install curl
  curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```

* Install mysql
  ```sudo apt-get install mysql-server
  # Change mysql root password
  mysql --user=root --execute="SET PASSWORD FOR 'root'@'localhost' = PASSWORD('***THEROOTPASSWORD****');"
  ```

* Install git
  sudo apt-get install git

* Create dedicated user login
  adduser bibliopuce

* Get source code
  su - bibliopuce
  git clone git://github.com/e-dot/bibliopuce.git

* Install node modules: express, mysql
  su - bibliopuce
  cd bibliopuce
  npm install express
  npm install mysql
  npm install ejs
  npm install serve-favicon
  npm install morgan
  npm install cookie-parser
  npm install body-parser
  npm install debug

* Create database (empty)
  su - bibliopuce
  cd bibliopuce
  mysql --user=root --password=***THEROOTPASSWORD**** < db/create_database.sql

## Start Bibliopuce

* In production mode:
```
  cd ...\bibliopuce
  npm start
```
* In debug mode:
```
  cd ...\bibliopuce
  set DEBUG=bibliopuce:* & npm start
```
