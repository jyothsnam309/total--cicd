#data "http" "myip" {
#  url = "http://ipv4.icanhazip.com"
#}


resource "aws_security_group" "tom" {
  name        = "tom-sg"
  description = "Allow admin to ssh"
  vpc_id      = "vpc-01a54eb210751786d"


  ingress {
    description = "connecting to admins"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


ingress {
    description = "connecting from enduser"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "stage-tom-sg"
  }
}




resource "aws_instance" "tom" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"
 # vpc_id = "vpc-01a54eb210751786d"
  subnet_id              = "subnet-060549087f71cc584"
  vpc_security_group_ids = [aws_security_group.tom.id]
  key_name        = "aws_key_pair.dev.id"

  

  tags = {
    Name = "dev-tom"
  }
}


resource "aws_key_pair" "dev" {
  key_name   = "dev"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCiFmmvR9ycaZyq2sIWlnp5qpeBXL5ZNZ23EXfqz8Y/W5naDQfHFI2BREcPj5ug+Bz/fBDdzbmt29r8dHNXsujjIMtYnW4sGOVFXrndNOptWSb9Or6tfQ26fAmxUmEkU1GVaL3rcCS6OhOjzodVH6L3hfGMUFf6z0PaSpcZH9013dqInEQvJozFodkYsqlkhqvE33fZ0j4/pKlay7Pm81eW4gdeMXRXyXF9hzRd9hNygc8SE42uH//cxfJUwXbGnCWI8r2PYoo5FDHvIJoNnJ89ayZDVwPaTRweBR4Fjff6+awGYiddNztK/GNHjDM1hFaD21bIm6bJeZu+jAw1rn/jnE+7rIcVKkY2tussPN1JZrXdzWVV/B8F1/Oqw+TnP6oi9NmDtDf1HzP/Jpm4yiSl66rVeULSavCXDBO64itT4moI28VkFWv9xPCDTng1y5vP7O4g2a5o3QSEdWqx1VFpFF7gF+1eUa2CyU+u9aOAT4hcMmLes9xf+4lExdCszxs= DEEPALI REDDY@DESKTOP-5FCHM4B"
}  
