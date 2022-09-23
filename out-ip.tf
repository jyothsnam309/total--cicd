output "tomcatip" {
  value = aws_instance.cicd-tomcat.public_ip

}

output "tomcatdns" {
  value = aws_instance.cicd-tomcat.public_dns

}

output "jnkinsip" {
  value = aws_instance.cicd-jenkins.public_ip

}

output "jenkinsdns" {
  value = aws_instance.cicd-jenkins.public_dns

}