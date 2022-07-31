resource "aws_lb" "terraform_alb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraform_alb_sg.id]
  subnets            = data.aws_subnet_ids.terraform_subnets.ids

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}


#Load balancer security group

resource "aws_security_group" "terraform_alb_sg" {
  name        = "terraform__alb_sg"
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

  ingress {
    description      = "ssh from my home ip"
    from_port        = 80
    to_port          = 80
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
    Name = "terraform_alb_sg"
  }
}

# data block to collect subnet ids
data "aws_subnet_ids" "terraform_subnets" {
  vpc_id = aws_vpc.terraform_vpc.id
}

# alb listener rule to attach target group to alb

resource "aws_lb_listener" "terraform_listener" {
  load_balancer_arn = aws_lb.terraform_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform_tg.arn
  }
}