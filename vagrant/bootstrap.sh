#!/bin/bash

sudo apt-get update -y
sudo apt-get install default-jdk -y
sudo apt-get install tar -y

cd /opt
sudo wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
sudo mv wildfly-10.0.0.Final wildfly
sudo chmod -R 755 wildfly
cd wildfly/bin

sudo ./standalone.sh
