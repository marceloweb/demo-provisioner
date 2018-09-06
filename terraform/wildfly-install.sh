#!/bin/bash

sudo apt-get update -y
sudo apt-get install openjdk-8-jdk -y

cd /tmp
sudo wget http://apt.puppet.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get -y install puppet-common
sudo apt-get -y install nginx
sudo /etc/init.d/nginx start
