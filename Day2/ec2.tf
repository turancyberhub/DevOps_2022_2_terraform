resource "aws_instance" "database" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
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
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}