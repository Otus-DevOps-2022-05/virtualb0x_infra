#! /bin/sh
sudo apt update && \
sudo apt install -y mongodb && \
sudo systemctl start mongod && \
sudo systemctl enable mongod && \
sudo systemctl status mongod
