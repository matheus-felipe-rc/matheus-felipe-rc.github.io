provider "aws" {
    region = "us-east-1"
    access_key = "ASIAV4M6RWFX2CZXKGMV"
    secret_key = "djvB5ExQD1YziE4DBmBuPqalCyVPID0UpLwqA78x"
    token = "FwoGZXIvYXdzEEoaDPr2pzQVl+O5CtDrACLNARdp56SzZFVKv2mauT6+wGO3EETP/QeT5VfKeVfv2x3OylmSTgF9R6+KxOxU+C/FbxVX2TMu8mBgzRAtpZ5bz/3jVrL2lDgubXw6576blvQMxLd+g2xwhfNZspP8aMOxAkcE5+tWzX+JPhBcurfvVJiORmqAObla4q95R/tsFx3qGvTqDqZyhVq1EPSKDQjFmMTYC8YFuBBbUXnLLUGV/9HUHrD6lqUOPQ0BrJvoBD8B+GRxokXrFUNji4M01YB5tV6qa8E5XqBpIEybpNwojJTCpAYyLTv7aHKBDb0z49Jbk8Q1+RVXgOov+7U4KO7OiRYGeulwg5LAn8CLESCMUNAtAA=="
}

resource "aws_key_pair" "deployer"{
    key_name = "Serverkeys"
    public_key = "${file("D:/TCC/serverkey.pub")}"
}

resource "aws_security_group" "deployer" {
   name = "MineSecurity"
   description = "Portas_necessarias"
   
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 35353
        to_port = 35353
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 35353
        to_port = 35353
        protocol = "UDP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 25565
        to_port = 25565
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 25565
        to_port = 25565
        protocol = "UDP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }  
}

resource "aws_launch_template" "deployer" {
    name = "Auto-scale-mine"
    image_id = "ami-0cc748b249a5baf40"
    instance_type = "t2.small"
    key_name = aws_key_pair.deployer.id
    placement {
    availability_zone = "us-east-1b"
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [aws_security_group.deployer.id]
    subnet_id = "subnet-083f36a2afacff40d"  # Substitua pelo ID da Subnet desejada
  }
   instance_initiated_shutdown_behavior = "terminate"
}

resource "aws_lb_target_group" "deployer" {
 name        = "mine-targetgroup"
 port        = 25565
 protocol    = "TCP_UDP"
 vpc_id      = "vpc-0609a6250fbb85ae5"  # Substitua pelo ID da VPC desejada

 health_check {
   interval            = 30
   port                = 26656
   protocol            = "TCP"
   healthy_threshold   = 3
   unhealthy_threshold = 3
   timeout             = 5
 }
}

resource "aws_lb" "deployer" {
 name               = "mine-loadbalancer"
 internal           = false
 load_balancer_type = "network"

 subnets            = ["subnet-083f36a2afacff40d"]

 tags = {
   Name = "Mine-loadbalancer"
 }
}

resource "aws_lb_listener" "deployer" {
 load_balancer_arn = aws_lb.deployer.arn
 port              = 25565
 protocol          = "TCP_UDP"

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.deployer.id
 }
}

resource "aws_autoscaling_group" "deployer" {
   name = "Mine-autoscale"
   min_size = 0
   max_size = 2
   target_group_arns = [aws_lb_target_group.deployer.id]
   desired_capacity = 0
   launch_template {
       id = aws_launch_template.deployer.id
       version = "$Latest"
   }
   vpc_zone_identifier  = ["subnet-083f36a2afacff40d"]
}