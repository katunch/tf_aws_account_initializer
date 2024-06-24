output "name_servers" {
  value       = aws_route53_zone.zone.name_servers
  description = "The name servers of the hosted zone"
}

output "route53_hosted_zone_id" {
  value       = aws_route53_zone.zone.zone_id
  description = "The ID of the hosted zone"
}

output "state_bucket" {
  value       = aws_s3_bucket.state_bucket.bucket
  description = "The name of the state bucket"
}

output "state_lock_table" {
  value       = aws_dynamodb_table.state_lock.name
  description = "The name of the state lock table"
}