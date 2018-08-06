#!/bin/sh

sudo apt-get update && sudo apt-get install ruby -y

sudo gem install --no-document puppet

sudo puppet apply manifest.pp
