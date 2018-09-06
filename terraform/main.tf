### configure the aws provider
provider "aws" {
  region = "us-east-1"
}

### declare the data source
data "aws_availability_zones" "all" {}

### declare the auto scaling groups - allows access to the list of aws asg
resource "aws_autoscaling_group" "demo" {
  launch_configuration = "${aws_launch_configuration.demo.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  min_size = 2
  max_size = 10

  load_balancers = ["${aws_elb.demo.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "terraform-asg-demo"
    propagate_at_launch = true
  }
}

### provides information about a launch configuration
resource "aws_launch_configuration" "demo" {

  image_id = "ami-66506c1c"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.demo.id}"]

  user_data = "${file("wildfly-install.sh")}"
  key_name = "demo"

  lifecycle {
    create_before_destroy = true
  }
}

### provides an elastic load balancer resource
resource "aws_elb" "demo" {
  name = "terraform-asg-demo"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }
}

### provides details about a specific security group
resource "aws_security_group" "demo" {
  name = "terraform-demo"

  # Inbound HTTP from anywhere
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
