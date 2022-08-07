resource "aws_instance" "web_instance" {
    provider = aws.ohio
    ami = data.aws_ami.amazon-2.id
    instance_type = "t2.micro"
    count = 1
#    lifecycle {
#       prevent_destroy = true
#    }

    tags = {
        Name = element(var.tags, count.index)
    }
}

variable "tags" {
    type = list
    default = ["my_fist_ec2", "my_second_ec2", "my_third_ec2"]
}