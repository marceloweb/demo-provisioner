variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

variable "wildfly-version" {
	default = "9.0.1.Final"
}

variable "url" {
	default = "https://download.jboss.org/wildfly/9.0.1.Final/wildfly-9.0.1.Final.zip"
}
