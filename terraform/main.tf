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
  vpc_security_group_ids = [aws_security_group.jenkins-cicd.id]
  subnet_id              = aws_subnet.subnet.id
}

// usually would use var.stage to have a single instance per workspace e.g php-${var.stage}
// rather than duplicate the instances below

resource "aws_instance" "php_staging" {
  ami           = var.php_ami
  instance_type = "t2.micro"
  key_name      = var.ami_key_pair_name

  tags = {
    Name               = "php_staging"
    ManagedByTerraform = true
  }
  vpc_security_group_ids = [aws_security_group.php-cicd.id]
  subnet_id              = aws_subnet.subnet.id
}

resource "aws_instance" "php_production" {
  ami           = var.php_ami
  instance_type = "t2.micro"
  key_name      = var.ami_key_pair_name

  tags = {
    Name               = "php_production"
    ManagedByTerraform = true
  }
  vpc_security_group_ids = [aws_security_group.php-cicd.id]
  subnet_id              = aws_subnet.subnet.id
}

// wordpress frontend
resource "aws_instance" "wp_php_develop" {
  ami           = var.wp_php_ami
  instance_type = "t2.micro"
  key_name      = var.ami_key_pair_name

  tags = {
    Name               = "wp_php_develop"
    ManagedByTerraform = true
  }
  vpc_security_group_ids = [aws_security_group.php-cicd.id]
  subnet_id              = aws_subnet.subnet.id
}

resource "aws_instance" "wp_php_staging" {
  ami           = var.wp_php_ami
  instance_type = "t2.micro"
  key_name      = var.ami_key_pair_name

  tags = {
    Name               = "wp_php_staging"
    ManagedByTerraform = true
  }
  vpc_security_group_ids = [aws_security_group.php-cicd.id]
  subnet_id              = aws_subnet.subnet.id
}

resource "aws_instance" "wp_php_production" {
  ami           = var.wp_php_ami
  instance_type = "t2.micro"
  key_name      = var.ami_key_pair_name

  tags = {
    Name               = "wp_php_develop"
    ManagedByTerraform = true
  }
  vpc_security_group_ids = [aws_security_group.php-cicd.id]
  subnet_id              = aws_subnet.subnet.id
}