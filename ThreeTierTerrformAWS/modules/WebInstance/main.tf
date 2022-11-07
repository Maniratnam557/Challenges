resource "aws_instance" "webserver1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnets[0]
  

  tags = {
    Name = "Web Server_${availability_zone}"
  }

  user_data = <<-EOF
   #!/bin/bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl enable httpd
   sudo systemctl start httpd
   echo "<html><body><div>This is a test webserver!</div></body></html>" > /var/www/html/index.html
   EOF

}

resource "aws_instance" "webserver2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnets[1]

  tags = {
    Name = "Web Server_${availability_zone}"
  }
   user_data = <<-EOF
   #!/bin/bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl enable httpd
   sudo systemctl start httpd
   echo "<html><body><div>This is a test webserver!</div></body></html>" > /var/www/html/index.html
   EOF
}