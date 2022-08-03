#Target group
resource "aws_lb_target_group" "terraform_tg" {
  name     = "terraform-tg"
  port     = var.ports[0]
  protocol = var.alb_protocol
  vpc_id   = aws_vpc.terraform_vpc.id
}

#Target group attachment (attaching our ec2 instance to target group)

resource "aws_lb_target_group_attachment" "terraform_ec2_attachment" {
  target_group_arn = aws_lb_target_group.terraform_tg.arn
  target_id        = aws_instance.database.id
  port             = 80
}

