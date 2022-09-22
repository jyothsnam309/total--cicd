output "appdip" {
  value = aws_instance.cicd-tomcat.public_ip

}

output "appdns" {
  value = aws_instance.cicd-tomcat.public_dns

}

output "cicdip" {
  value = aws_instance.cicd-jenkins.public_ip

}

output "cicddns" {
  value = aws_instance.cicd-jenkins.public_dns

}