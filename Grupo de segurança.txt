resource "aws_security_group" "deployer" {
   name = "Nome do grupo de segurança"
   description = "Portas_necessarias"
   
    egress {          #regras de saída
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    
    ingress {         #regras de entrada com as portas TCP e UDP das portas 35353 do multipaper, 25565 padrão do minecraft e a 22 padrão do SSH
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
