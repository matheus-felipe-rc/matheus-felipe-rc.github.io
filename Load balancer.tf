resource "aws_lb" "deployer" {
 name               = "Nome do balanceador de carga"
 internal           = false #falso indicando que o balanceador de carga está escutando a internet pública
 load_balancer_type = "network" #Tipo do balanceador de carga

 subnets            = ["subnet-083f36a2afacff40d"] #id da subnet
}