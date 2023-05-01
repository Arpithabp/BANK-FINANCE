resource "aws_instance" "example" {
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name  = "project"
  vpc_security_group_ids= ["sg-0b846ff95c9978482"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("project.pem")
    host     = self.public_ip
  }
  tags = {
    Name = "deploy-server" // set a name for the instance
      }
}

