resource "aws_instance" "workspace" {
    count = terraform.workspace == "default" ? 1 : 0
    ami = data.aws_ami.amazon-2.id
    instance_type = lookup(var.instance_type,terraform.workspace)
    tags = {
        Name = "my_instance-${terraform.workspace}"
    }
}

data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

variable "instance_type" {
    type = map
    default = {
        default = "t2.micro"
        prod = "t2.large"
        dev = "t2.nano"
        staging = "t2.small"
    }
}