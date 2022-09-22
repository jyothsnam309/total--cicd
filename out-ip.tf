output "appdip" {
  value = aws_instance.cicd-app.public_ip

}

output "appdns" {
  value = aws_instance.cicd-app.public_dns

}

output "cicdip" {
  value = aws_instance.cicd-demo.public_ip

}

output "cicddns" {
  value = aws_instance.cicd-demo.public_dns

}