#! /bin/sh
sudo apt update && \
sudo apt install -y mongodb && \
sudo mv /lib/systemd/system/mongodb.service /lib/systemd/system/mongod.service \
sudo systemctl start mongod && \
sudo systemctl enable mongod && \
sudo systemctl status mongod
