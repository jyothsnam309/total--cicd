data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}




resource "aws_security_group" "cicd-tomcat" {
  name        = "cicd-tomcat-sg"
  description = "acess the end user "
  vpc_id      = "vpc-01a54eb210751786d"


  ingress {
    description = "connecting with enduser"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


 ingress {
    description = "connecting with enduser"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["aws_security_group.cicd-jenkins.id"]


  }




  ingress {
    description = "connecting with admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${chomp(data.http.myip.body)}/32"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "cicd-tomcat-sg"
  }
}


resource "aws_instance" "cicd-tomcat" {
  ami           = "ami-0f62d9254ca98e1aa"
  instance_type = "t2.micro"
  #vpc_id = "vpc-01a54eb210751786d"
  subnet_id              = "subnet-060549087f71cc584"
  vpc_security_group_ids = [aws_security_group.cicd-tomcat.id]
  #  key_name        = ${aws_key_pair.dev.id}
  key_name  = aws_key_pair.demo.id
  



  tags = {
    Name = "cicd-tomcat"
  }
}
