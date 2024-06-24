variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "default"
}

variable "assume_role_arn" {
  description = "The ARN of the role to assume"
  type        = string
  nullable    = true
  default     = null
}

variable "fqdn" {
  description = "The FQDN of the Route 53 zone"
  type        = string
}

variable "reverse_fqdn" {
  description = "The reverse FQDN of the Route 53 zone"
  type        = string
}

variable "aws_default_tags" {
  type        = map(string)
  default     = {}
  description = "The default tags to apply to all resources"
}