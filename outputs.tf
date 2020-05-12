// Output Variables/Values definition file
// Postgres RDS Output

output "id" {
  value       = aws_db_instance.postgresql.id
  description = "The database instance ID"
}

output "rds_password" {
  value       = aws_db_instance.postgresql.password
  description = "The password set at provision time,~> ALTER USER WITH ENCRYPTED PASSWORD '<new>'; after provision time"
}

output "hostname" {
  value       = aws_db_instance.postgresql.address
  description = "Public DNS name of database instance"
}

output "ip" {
  value       = aws_instance.app_instance.public_ip
  description = "Public DNS name and port separated by a colon"
}

output "ec2_ip" {
  value = aws_eip.app.public_ip
}