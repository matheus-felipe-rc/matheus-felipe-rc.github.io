resource "aws_key_pair" "deployer"{
    key_name = "Nome da chave"
    public_key = "${file("Diretório da chave pública (.pub)")}"
}
