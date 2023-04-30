resource "aws_instance" "example" {
  ami           = "ami-02eb7a4783e7e9317" // set the AMI ID of the image you want to use
  instance_type = "t2.micro" // set the instance type you want to use
  key_name      = "bank.pem" // set the name of the key pair you want to use to SSH into the instance
  vpc_security_group_ids= ["sg-0fd5056ae19b64938"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("bank.pem")
    host     = self.public_ip
  }
  tags = {
    Name = "deploy-server" 
  }
}
