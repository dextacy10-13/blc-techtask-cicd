variable "domain" {
  default = ""
}

variable "subdomain" {
  default = ""
}

variable "zone_id" {
  default = ""
}

variable "stage" {
  default = "develop"
}

variable "region" {
  default = "us-east-1"
}

variable "jenkins_ami" {
  default = ""
}

variable "php_ami" {
  default = ""
}

variable "wp_php_ami" {
  default = ""
}

variable "access_cidr" {
  default = ""
}

variable "ami_key_pair_name" {}