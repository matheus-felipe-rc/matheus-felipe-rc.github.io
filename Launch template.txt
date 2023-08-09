resource "aws_launch_template" "deployer" {
    name = "Nome do modelo de lançamento"
    image_id = "ID da imagem AMI criada"
    instance_type = "t2.small" # Tipo da máquina
    key_name = aws_key_pair.deployer.id
    placement {
    availability_zone = "us-east-1b" #Zona de disponibilidade
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [aws_security_group.deployer.id]
    subnet_id = "subnet-083f36a2afacff40d"  # Substitua pelo ID da Subnet desejada
  }
   instance_initiated_shutdown_behavior = "terminate" #Comportamento padrão da máquina ao parar de se utilizar
}