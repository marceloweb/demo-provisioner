provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  
  ami = "ami-66506c1c"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}",, "${aws_security_group.ssh.id}", "${aws_security_group.all_outgoing.id}"]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y &
              apt-get install ruby -y &
              gem install --no-document puppet &
              apt-get install wildfly -y &
              service wildfly start &
              EOF

  tags {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_user" "user" {
  name = "test-user"
  path = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = "${aws_iam_user.user.name}"
  encoding   = "SSH"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 mytest@mydomain.com"
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "Allow all ssh traffic"
  vpc_id = ""

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ssh"
  }
}

resource "aws_security_group" "all_outgoing" {
  name = "all_outgoing"
  description = "Allow all outgoing traffic"
  vpc_id = ""

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

    tags {
    Name = "all_outgoing"
  }

}
