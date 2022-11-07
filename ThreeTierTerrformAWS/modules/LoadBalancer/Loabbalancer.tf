resource "aws_lb" "external-elb" {
  name               = "ELB-WEB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups_web # allow internet traffic
  subnets            = [var.subnets_web[0],var.subnets_web[1]] # designates subnets
}

resource "aws_lb_target_group" "external-elb" {
  name     = "WebTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "external-elb1" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = var.target_id_web[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "external-elb2" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = var.target_id_web[1].id
  port             = 80
}

resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external-elb.arn
  }
}

resource "aws_lb" "internal_elb" {
  name               = "APP-LB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_groups_app # 
  subnets            = [var.subnets_app[0],var.subnets_app[1]] # 
}

resource "aws_lb_target_group" "internal-elb" {
  name     = "AppTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "internal-elb1" {
  target_group_arn = aws_lb_target_group.internal-elb.arn
  target_id        = var.target_id_app[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "internal-elb2" {
  target_group_arn = aws_lb_target_group.internal-elb.arn
  target_id        = var.target_id_app[1].id
  port             = 80
}

resource "aws_lb_listener" "internal-elb" {
  load_balancer_arn = aws_lb.internal-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal-elb.arn
  }
}