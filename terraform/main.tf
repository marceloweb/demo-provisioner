provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "java-demo" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${var.fingerprint}"]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file("~/.ssh/id_rsa")}"
    agent = false
  }

  provisioner "remote-exec" {
     source = "manifests/wildfly.pp"
     destination = "/tmp/wildfly.pp"

     inline = [
       "#!/bin/sh",
       "apt-get update -y",
       "apt-get install openjdk-8-jdk -y",
       "cd /tmp",
       "wget http://apt.puppet.com/puppetlabs-release-pc1-xenial.deb",
       "dpkg -i puppetlabs-release-pc1-xenial.deb",
       "apt-get -y install puppet-common",
       "puppet apply"
     ]
     
  }
}

