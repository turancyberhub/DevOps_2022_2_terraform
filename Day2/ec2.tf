resource "aws_instance" "database" {
  count = var.is_it_for_production == "yes" ? 3 : 1
  #       false(0) == true(1) -> false
  #       true =1    false=0
  #          true (1) == false (0) true(1) == true(1)  false(0) == false(0)
  #         Condition              true     false
  provider = aws.ohio
  ami           = var.is_it_for_production != "yes" ? data.aws_ami.amazon-2.id : data.aws_ami.latest-ubuntu.id
  instance_type = var.is_it_for_production == "yes" ? var.production_instance_type : var.non_production_instance_type
  user_data = <<EOF
#!/bin/bash
sudo su
sudo yum update -y 
sudo yum install -y httpd.service
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
echo "The page was created by the user data" > /var/www/html/index.html
sudo systemctl restart httpd.service
EOF
}

#data source to find latest AMAZON linux 2 ami id

data "aws_ami" "amazon-2" {
  provider = aws.ohio
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

# latest ubuntu instance id
data "aws_ami" "latest-ubuntu" {
most_recent = true
provider = aws.ohio
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}