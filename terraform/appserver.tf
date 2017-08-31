
data "aws_ami" "appserver_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["appserver-artifact-${var.as_artifacts_version}"]
  }

}


resource "aws_elb" "appserver-elb" {
  name               = "appserver-elb-${var.env}"
#  availability_zones = ["us-west-2a", "us-west-2c"]
  internal           = false
  subnets	     = "${var.elb_subnets}"
  security_groups    = "${var.security_groups}"

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


#  listener {
#    instance_port      = 8000
#    instance_protocol  = "http"
#    lb_port            = 443
#    lb_protocol        = "https"
#    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}

resource "aws_launch_configuration" "appserver-lc" {
  name	= "appsever-${var.env}-lc"
  image_id = "${data.aws_ami.appserver_ami.id}"
  instance_type = "t2.micro"
  key_name = "${var.keypair_name}"
  security_groups = "${var.security_groups}"
  associate_public_ip_address = false
  user_data = "${file("userdata.sh")}"
}

resource "aws_autoscaling_group" "appserver-asg" {
  availability_zones = "${var.avl_zones}"
  name		     = "appserver-${var.env}-asg-group"
  max_size	     = 4
  min_size	     = 2
  default_cooldown   = 120
  launch_configuration = "${aws_launch_configuration.appserver-lc.name}"
  health_check_type = "EC2"
  vpc_zone_identifier = "${var.instance_subnets}"
  force_delete = "false"
  tags		      = [{
			  key = "Name"
			  value = "${format("appserver-%s", var.env)}"
 			  propagate_at_launch = true
		        },
			 {
			  key = "Environment"
			  value = "${var.env}"
			  propagate_at_launch = true
			 }]
  load_balancers     = ["${aws_elb.appserver-elb.name}"]

}
