#data "http" "myip" {
#  url = "http://ipv4.icanhazip.com"
#}


resource "aws_security_group" "tomcat" {
  name        = "tomcat-sg"
  description = "Allow admin to ssh"
  vpc_id      = vpc-01a54eb210751786d


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
    Name = "stage-tomcat-sg"
  }
}




resource "aws_instance" "tomcat" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"
  vpc_id = vpc-01a54eb210751786d
  subnet_id              = subnet-060549087f71cc584
  vpc_security_group_ids = [aws_security_group.tomcat.id]
  key_name        = aws_key_pair.stage.id

   # user_data = <<-EOF
#!/bin/bash
#cd /tmp
#wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
#rpm -ivh jdk-8u131-linux-x64.rpm
#cd /opt
#wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65-windows-x64.zip
#unzip apache-tomcat-9.0.65-windows-x64.zip
#rm -f apache-tomcat-9.0.65-windows-x64.zip
#mv apache-tomcat-9.0.65 tomcat9
#cd /tomcat9
#cd bin
#ls -ltr *.sh
#chmod 755 *.sh
#./startup.sh
#ps -ef | grep tomcat




            

   
        
              
             EOF


  tags = {
    Name = "stage-tomcat"
  }
}


resource "aws_key_pair" "stage" {
  key_name   = "stage"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCiFmmvR9ycaZyq2sIWlnp5qpeBXL5ZNZ23EXfqz8Y/W5naDQfHFI2BREcPj5ug+Bz/fBDdzbmt29r8dHNXsujjIMtYnW4sGOVFXrndNOptWSb9Or6tfQ26fAmxUmEkU1GVaL3rcCS6OhOjzodVH6L3hfGMUFf6z0PaSpcZH9013dqInEQvJozFodkYsqlkhqvE33fZ0j4/pKlay7Pm81eW4gdeMXRXyXF9hzRd9hNygc8SE42uH//cxfJUwXbGnCWI8r2PYoo5FDHvIJoNnJ89ayZDVwPaTRweBR4Fjff6+awGYiddNztK/GNHjDM1hFaD21bIm6bJeZu+jAw1rn/jnE+7rIcVKkY2tussPN1JZrXdzWVV/B8F1/Oqw+TnP6oi9NmDtDf1HzP/Jpm4yiSl66rVeULSavCXDBO64itT4moI28VkFWv9xPCDTng1y5vP7O4g2a5o3QSEdWqx1VFpFF7gF+1eUa2CyU+u9aOAT4hcMmLes9xf+4lExdCszxs= DEEPALI REDDY@DESKTOP-5FCHM4B"
}  
