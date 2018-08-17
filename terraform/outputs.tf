output "elb_dns_name" {
  value = "${aws_elb.demo.dns_name}"
}
