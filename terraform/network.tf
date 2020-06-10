
resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
  vpc      = true
  tags = {
    ManaagedByTerraform = true
  }
}

resource "aws_eip" "php_dev_eip" {
  instance = aws_instance.php_develop.id
  vpc      = true
  tags = {
    ManaagedByTerraform = true
  }
}

resource "aws_eip" "php_staging_eip" {
  instance = aws_instance.php_staging.id
  vpc      = true
  tags = {
    ManaagedByTerraform = true
  }
}

resource "aws_eip" "php_production_eip" {
  instance = aws_instance.php_production.id
  vpc      = true
  tags = {
    ManaagedByTerraform = true
  }
}


resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = "${var.subdomain}.${var.stage}"
  type    = "A"
  ttl     = "300"
  records = [
    aws_eip.jenkins_eip.public_ip
  ]
}

resource "aws_vpc" "cicd" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet" {
  cidr_block        = cidrsubnet(aws_vpc.cicd.cidr_block, 3, 1)
  vpc_id            = aws_vpc.cicd.id
  availability_zone = "${var.region}a"
  tags = {
    ManagedByTerraform = true
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.cicd.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.this.id
}