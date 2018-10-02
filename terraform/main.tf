provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "java-demo" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
}
