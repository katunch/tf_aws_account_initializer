variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "assume_role_arn" {
  description = "The ARN of the role to assume"
  type        = string
}

variable "fqdn" {
  description = "The FQDN of the Route 53 zone"
  type        = string
}

variable "reverse_fqdn" {
  description = "The reverse FQDN of the Route 53 zone"
  type        = string
}