#!/bin/sh

sudo apt-get update
echo "sleep 3m for install updates"; sleep 5m; echo "start install ruby"
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-get install -y ruby-full ruby-bundler build-essential
