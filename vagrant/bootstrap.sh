#!/bin/sh
set -e -x
export DEBIAN_FRONTEND=noninteractive

wget https://apt.puppetlabs.com/puppet-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb

apt-get -y update
apt-get -y install puppet-common=2.7.19-1puppetlabs1
