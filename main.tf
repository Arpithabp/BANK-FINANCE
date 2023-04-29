resource "aws_instance" "example" {
  ami = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.micro" 
  key_name  = "bank.pem" 
  vpc_security_group_ids= ["sg-039a2d2c31bb690d3"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("bank.pem")
    host     = self.public_ip
  }
  tags = {
    Name = "deploy-server" // set a name for the instance
  }
    provisioner "local-exec" {
         command = "echo ${aws_instance.example.public_ip} > inventory"
        
  }
}
