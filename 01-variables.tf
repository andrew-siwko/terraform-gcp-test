variable "LINODE_API_KEY" {
  description = "The key to the Linode API"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "The domain to create instance records in."
  type    = string
  default = "siwko.org"
}

variable "domain_soa_email" {
  description = "The domain manager e-mail address."
  type    = string
  default = "asiwko@siwko.org"
}

variable "project" {
  description = "The google project id."
  type    = string
  default = "helpful-weft-485019-h7"
}

variable "region" {
  description = "The google region."
  type    = string
  default = "us-central1"
}

variable "zone" {
  description = "The google zone."
  type    = string
  default = "us-central1-a"
}

variable "image" {
  description  = "The virtual machine image."
  type         = string
  default      = "rhel-cloud/rhel-9"
}

variable "admin_username" {
  description  = "the root user name"
  type         = string
  default      = "gcp-user"
}