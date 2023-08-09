resource "aws_lb_listener" "deployer" {
 load_balancer_arn = aws_lb.deployer.arn
 port              = 25565 #Porta padrão do minecraft
 protocol          = "TCP_UDP" #Protocolo utilizado

 default_action {
   type             = "forward" 
   target_group_arn = aws_lb_target_group.deployer.id #arn do grupo destino do deployer
 }
}