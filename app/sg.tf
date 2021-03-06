# alb security group
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg-tf"
  description = "ALB security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}


# solr alb security group
resource "aws_security_group" "solr-alb-sg" {
  name        = "solr-alb-sg-tf"
  description = "SOLR ALB security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web-sg.id}", "${aws_security_group.harvester-sg.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

# web security group
resource "aws_security_group" "web-sg" {
  name        = "web-sg-tf"
  description = "Web security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-sg.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# harvester security group
resource "aws_security_group" "harvester-sg" {
  name        = "harvester-sg-tf"
  description = "Harvester security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

# solr security group
resource "aws_security_group" "solr-sg" {
  name        = "solr-sg-tf"
  description = "Solr security group test"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr-alb-sg.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

# jumpbox security group
resource "aws_security_group" "jumpbox-sg" {
  name        = "jumpbox-sg-tf"
  description = "Jumpbox security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# ssh security group
resource "aws_security_group" "ssh-sg" {
  name        = "ssh-sg-tf"
  description = "ssh security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.jumpbox-sg.id}"]
  }

}
# inventory security group
resource "aws_security_group" "inventory-sg" {
  name        = "inventory-sg-tf"
  description = "Inventory security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
# crm security group
resource "aws_security_group" "crm-sg" {
  name        = "crm-sg-tf"
  description = "CRM security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
# dashboard security group
resource "aws_security_group" "dashboard-sg" {
  name        = "dashboard-sg-tf"
  description = "Dashboard security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
# wordpress security group
resource "aws_security_group" "wordpress-sg" {
  name        = "wordpress-sg-tf"
  description = "Wordpress security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
# static security group
resource "aws_security_group" "static-sg" {
  name        = "static-sg-tf"
  description = "Static security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
