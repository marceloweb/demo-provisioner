resource "aws_instance" "java-demo" {
  ami = "ami-66506c1c"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
     script = "puppet.sh"
  }
}
