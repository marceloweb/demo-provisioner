provider "digitalocean" {
  token = ENV['DG_TOKEN']
}

resource "digitalocean_droplet" "java-demo" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "nyc2"
  size   = "s-1vcpu-1gb"
}
