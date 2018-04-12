# web launch configuration
data "aws_ami" "catalog_web" {
  most_recent = true

filter {
    name   = "name"
    values = ["catalog-web*"]
  }

  owners = ["587807691409"]

}

data "template_file" "web_user_data" {
  template = "${file("${path.module}/templates/configure_web.tpl")}"
  vars {
    db_user = "${data.terraform_remote_state.db.db_username}"
    db_pass = "${data.terraform_remote_state.db.db_password}"
    db_server = "${data.terraform_remote_state.db.db_server}"
    db_database = "${data.terraform_remote_state.db.db_name}"
    solr_server = "${aws_alb.solr_alb.dns_name}"
  }
}

resource "aws_launch_configuration" "web_lc" {
  name_prefix                 = "catalog-web-tf-"
  image_id                    = "${data.aws_ami.catalog_web.id}"
  instance_type               = "${var.web_lc_instance_type}"
  associate_public_ip_address = true
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.web-sg.id}", "${aws_security_group.ssh-sg.id}" ]
  user_data                   = "${data.template_file.web_user_data.rendered}" 

  lifecycle {
    create_before_destroy = true
  }

}

# harvester launch configuration
data "aws_ami" "catalog_harvester" {
  most_recent = true

  filter {
    name   = "name"
    values = ["catalog-harvester*"]
  }

  owners = ["587807691409"]
}

data "template_file" "harvester_user_data" {
  template = "${file("${path.module}/templates/configure_harvester.tpl")}"
  vars {
    db_user = "${data.terraform_remote_state.db.db_username}"
    db_pass = "${data.terraform_remote_state.db.db_password}"
    db_server = "${data.terraform_remote_state.db.db_server}"
    db_database = "${data.terraform_remote_state.db.db_name}"
    solr_server = "${aws_alb.solr_alb.dns_name}"
  }
}

resource "aws_launch_configuration" "harvester_lc" {
  name_prefix                 = "catalog-harvester-tf-"
  image_id                    = "${data.aws_ami.catalog_harvester.id}"
  instance_type               = "${var.harvester_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.harvester-sg.id}", "${aws_security_group.ssh-sg.id}" ]
  user_data                   = "${data.template_file.harvester_user_data.rendered}" 


  lifecycle {
    create_before_destroy = true
  }
}

# solr launch configuration
data "aws_ami" "solr" {
  most_recent = true

  filter {
    name   = "name"
    values = ["solr*"]
  }

  owners = ["587807691409"]
}

data "template_file" "solr_user_data" {
  template = "${file("${path.module}/templates/create_core.tpl")}"
  vars {
    app = "catalog"
  }
}

resource "aws_launch_configuration" "solr_lc" {
  name_prefix                 = "solr-solr-tf-"
  image_id                    = "${data.aws_ami.solr.id}"
  instance_type               = "${var.solr_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.solr-sg.id}", "${aws_security_group.ssh-sg.id}" ]
  user_data                   = "${data.template_file.solr_user_data.rendered}" 

  lifecycle {
    create_before_destroy = true
  }
}

# inventory launch configuration
data "aws_ami" "inventory" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "inventory_lc" {
  name_prefix                 = "inventory-web-"
  image_id                    = "${data.aws_ami.inventory.id}"
  instance_type               = "${var.inventory_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.inventory-sg.id}", "${aws_security_group.ssh-sg.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}

# crm launch configuration
data "aws_ami" "crm" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "crm_lc" {
  name_prefix                 = "crm-web-"
  image_id                    = "${data.aws_ami.crm.id}"
  instance_type               = "${var.crm_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.crm-sg.id}", "${aws_security_group.ssh-sg.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}

# dashboard launch configuration
data "aws_ami" "dashboard" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "dashboard_lc" {
  name_prefix                 = "dashboard-web-"
  image_id                    = "${data.aws_ami.dashboard.id}"
  instance_type               = "${var.dashboard_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.dashboard-sg.id}", "${aws_security_group.ssh-sg.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}
# wordpress launch configuration
data "aws_ami" "wordpress" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "wordpress_lc" {
  name_prefix                 = "wordpress-web-"
  image_id                    = "${data.aws_ami.wordpress.id}"
  instance_type               = "${var.wordpress_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.wordpress-sg.id}", "${aws_security_group.ssh-sg.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}

# static launch configuration
data "aws_ami" "static" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "static_lc" {
  name_prefix                 = "static-web-"
  image_id                    = "${data.aws_ami.static.id}"
  instance_type               = "${var.static_lc_instance_type}"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  security_groups             = [ "${aws_security_group.static-sg.id}", "${aws_security_group.ssh-sg.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}
