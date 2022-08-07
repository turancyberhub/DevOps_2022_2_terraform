module "aws_iam_user" {
    source = "/home/ec2-user/my_module"
    name = "testuser"  
    tags = {
        Name = "testuser"
    }
}