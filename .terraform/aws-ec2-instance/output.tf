output "name" {
  description = "Name of the EC2 instance"
  value       = aws_instance.my_ec2.tags.Name
  
}
output "instance_type" {
  description = "Type of the EC2 instance"
  value       = aws_instance.my_ec2.instance_type
}
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_ec2.id
}
output "elastic_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_eip.my_eip.public_ip
}