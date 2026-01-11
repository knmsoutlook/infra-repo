variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "my_ip_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "YOUR public IP in CIDR form (e.g. 1.2.3.4/32). CHANGE THIS."
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "AbdulDevopsDemoKVP"
}

variable "github_deploy_pubkey" {
  type        = string
  description = "Public SSH key for GitHub Actions deploy"
  default     = ""
}