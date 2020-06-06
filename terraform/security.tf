resource "aws_security_group" "jenkins-cicd" {
  name = "allow-all-sg"
  vpc_id = aws_vpc.cicd.id
  description = "ManagedByTerraform"
}

resource "aws_security_group_rule" "ssh" {
  type = "ingress"
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.jenkins-cicd.id
  to_port = 22
  cidr_blocks = ["0.0.0.0/0"]
  description = "ManagedByTerraform"
}

resource "aws_security_group_rule" "jenkins" {
  type = "ingress"
  from_port = 8080
  protocol = "tcp"
  security_group_id = aws_security_group.jenkins-cicd.id
  to_port = 8080
  cidr_blocks = ["0.0.0.0/0"]
  description = "ManagedByTerraform"
}

resource "aws_security_group_rule" "egress" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.jenkins-cicd.id
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "ManagedByTerraform"
}