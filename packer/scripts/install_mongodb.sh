#!/bin/sh

#wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
#echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list


### Install mongodb from yandex repo
#
sleep 60
sudo apt install -y mongodb
sleep 60
### Start mongodb.service and make it run on restart
#
sudo systemctl start mongodb
sudo systemctl enable mongodb
