## Elastic load balancer + listener + security group + proxy websocket

# ELB security group

resource "aws_security_group" "rancher_elb" {
  name        = "${var.env_name}-rancher-elb"
  vpc_id      = "${aws_vpc.rancher.id}"
  description = "Rancher elb"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-rancher-elb"
  }
}

# ELB

resource "aws_elb" "rancher" {
  name            = "${var.env_name}-rancher"
  subnets         = ["${aws_subnet.pub_a.id}", "${aws_subnet.pub_b.id}"]
  security_groups = ["${aws_security_group.rancher_elb.id}"]

  listener {
    instance_port      = 8080
    instance_protocol  = "tcp"
    lb_port            = 443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${var.ssl_arn}"
  }
}

resource "aws_proxy_protocol_policy" "websockets" {
  load_balancer  = "${aws_elb.rancher.name}"
  instance_ports = ["8080"]
}
