// Variables for RDS Deployment

variable "profile" {}
variable "AWS_REGION" {
  type        = string
  default     = "eu-west-3"
  description = "Default deployment region"
}

variable "AWS_AVAILABILITY_ZONES" {
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
  description = "Default deployment region's Availability Zone"
}

variable "TAG" {
  type        = string
  default     = "postgres"
  description = "Default Tag"
}

variable "ENV" {
  type        = string
  default     = "dev"
  description = "Environment name"
}

variable "IP_RANGE" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The default VPC's ip range"
}