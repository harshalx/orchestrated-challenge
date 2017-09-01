
variable "aws_access_key" {
	default=""
}

variable "aws_secret_key" {
	default=""
}

variable "aws_region" {
	default = "us-west-2"
}

variable "ws_artifacts_version" {
	default="1.0"
}

variable "as_artifacts_version" {
        default="1.0"
}

variable "keypair_name" {
	default = "hv"
}

variable "desired_capacity" {
	default = "3"
}

variable "elb_subnets" {
#	default = ["subnet-92ebe3db", "subnet-141cea72"]
#	default = ["subnet-1ac5c96e"]
#	default = ["subnet-1ccc397b", "subnet-460c0330"] 
	default = ["subnet-33bb6d55", "subnet-d787e68c"]
}

variable "instance_subnets" {
#	default = ["subnet-cdebe384", "subnet-0b40736f"]
#	default = ["subnet-92ebe3db", "subnet-141cea72"]
#	default = ["subnet-1ac5c96e"]
#	default = ["subnet-1ccc397b", "subnet-460c0330"]
	default = ["subnet-33bb6d55", "subnet-d787e68c"]
}


variable "avl_zones" {
	default = ["us-west-2a", "us-west-2c"]
#	default = ["us-west-2a"]
}

variable "security_groups" {
#	default = ["sg-0df79575"]
#	default = ["sg-23737d5a", "sg-c24431bb"]
#	default = ["sg-467b553c"]
	default = ["sg-b16e49cb"]
}
