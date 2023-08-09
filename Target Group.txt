resource "aws_lb_target_group" "deployer" {
 name        = "Nome do grupo destino"
 port        = 25565                    #Porta padrão utilizada pelo minecraft
 protocol    = "TCP_UDP"                #Protocolos
 vpc_id      = "vpc-0609a6250fbb85ae5"  # Substitua pelo ID da VPC disponibilizada

 health_check {
   interval            = 30
   port                = 26656
   protocol            = "TCP"
   healthy_threshold   = 3
   unhealthy_threshold = 3
   timeout             = 5
 }
}