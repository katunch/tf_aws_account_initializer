output "name_servers" {
  value = aws_route53_zone.zone.name_servers
}

output "state_bucket" {
  value = aws_s3_bucket.state_bucket.bucket
}

output "state_lock_table" {
  value = aws_dynamodb_table.state_lock.name
}