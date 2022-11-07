resource "aws_instance" "Appserver1" {
  ami                    = "ami-0d5eff06f840b45e9"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnets[0]
  

  tags = {
    Name = "App Server_${availability_zone}"
  }

}

resource "aws_instance" "Appserver2" {
  ami                    = "ami-0d5eff06f840b45e9"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnets[1]

  tags = {
    Name = "App Server_${availability_zone}"
  }
}