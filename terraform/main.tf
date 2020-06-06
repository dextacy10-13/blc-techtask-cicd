# Using multiple workspaces:
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jamesmyers"

    workspaces {
      prefix = "blctechtask-"
    }
  }
}

# The default provider configuration
provider "aws" {
  version = "2.59.0"
  region  = var.region
}

resource "aws_instance" "jenkins" {
  ami           = var.jenkins_ami
  instance_type = "t2.micro"
  key_name      = var.ami_key_pair_name

  tags = {
    Name               = "jenkins"
    ManagedByTerraform = true
  }
  security_groups = [aws_security_group.jenkins-cicd.id]
  subnet_id       = aws_subnet.subnet.id
}