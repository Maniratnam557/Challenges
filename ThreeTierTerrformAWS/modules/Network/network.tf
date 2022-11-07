resource "aws_vpc" "app-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
        Name = var.tag_name }
}

 # aws_subnet.web-subnet["websubnet-1a"]
resource "aws_subnet" "web-subnet" {

  for_each=var.webSubnets
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}_public_${each.key}"
  }
}

 # aws_subnet.app-subnet["Appsubnet-1a"]
resource "aws_subnet" "app-subnet" {
  for_each=var.AppSubnets
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tag_name}_private_${each.key}"
  }
}


 # aws_subnet.db-subnet["Dbsubnet-1a"]
resource "aws_subnet" "dbSubnet" {
  for_each=var.DbSubnets
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  tags = {
    Name = "${var.tag_name}_private_${each.key}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app-vpc.id
}

resource "aws_route_table" "InternetRoute" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "sublink-a" {
  subnet_id      = aws_subnet.web-subnet["websubnet-1a"].id
  route_table_id = aws_route_table.InternetRoute.id
}

resource "aws_route_table_association" "sublink-b" {
  subnet_id      = aws_subnet.web-subnet["websubnet-2a"].id
  route_table_id = aws_route_table.InternetRoute.id
}

resource "aws_security_group" "ExternalWebELB-sg" {
  name        = "ExternalElb-SG"
  description = "Allow HTTP inbound traffic to External ELB"
  vpc_id      =  aws_vpc.app-vpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-SG"
  }
}

resource "aws_security_group" "webserver-sg" {
  name        = "Webserver-SG"
  description = "Allow inbound traffic from Eternal ELB to WEB LAYER"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ExternalELB-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webserver-SG"
  }
}

resource "aws_security_group" "InternalAppElb-sg" {
  name        = "InternalAppElb"
  description = "Allow HTTP inbound traffic from WEB LAYER to internal App ALB"
  vpc_id      =  aws_vpc.app-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.webserver-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "internalAppElB-SG"
  }
}

resource "aws_security_group" "appserver-sg" {
  name        = "appserver-SG"
  description = "Allow inbound traffic from INTERNAL ELB to APP SERVER INSTANCES"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.AppElb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Appserver-SG"
  }
}
# Create Database Security Group
resource "aws_security_group" "database-sg" {
  name        = "Database-SG"
  description = "Allow inbound traffic from application layer"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description     = "Allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.appserver-sg.id]
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-SG"
  }
}