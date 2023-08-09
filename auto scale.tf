resource "aws_autoscaling_group" "deployer" {
   name = "nome do escalonamento automatico"
   min_size = 0
   max_size = 2
   target_group_arns = [aws_lb_target_group.deployer.id] #arns do grupo destino do deployer
   desired_capacity = 0
   launch_template {
       id = aws_launch_template.deployer.id #Id do próprio launch template do deployer
       version = "$Latest"
   }
   vpc_zone_identifier  = ["subnet-083f36a2afacff40d"] #id da vpc já providenciada
}