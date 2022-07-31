provider "aws" {
  region     = "us-east-1"
  access_key = "<please add your own access key here>"
  secret_key = "<please add your own secret key here>"
}


## reference terrafor resource method
## resource_type + "." + resource_name + "." + attribute

resource "aws_eip" "lb" {
  instance = aws_instance.database.id
  vpc      = true
  tags = {
    Name = "test_ip"
  }
}


##security group

resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.terraform_vpc.id

# inbound = ingress
  ingress {
    description      = "ssh from my home ip"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
#outbound = egress
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_sg"
  }
}

resource "aws_instance" "database" {
  ami           = var.ami["us-east-1"]
  instance_type = var.instance_types[4]
  vpc_security_group_ids = [aws_security_group.terraform_sg.id]
  subnet_id = aws_subnet.terraform_subnet_1.id
  tags = {
    Name = "test"
  }
}

variable "instance_types" {
  type    = list(any)
  default = []
}

variable "ami" {
  type = map
  default = {
    us-east-1 = "ami-0cff7528ff583bf9a"
    us-east-2 = "ami-02d1e544b84bf7502"
    us-west-1 = "ami-0d9858aa3c6322f73"
    us-west-2 = "ami-098e42ae54c764c35"
  }
}
