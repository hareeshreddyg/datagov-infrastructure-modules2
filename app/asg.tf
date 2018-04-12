### web autoscaling group ###
resource "aws_autoscaling_group" "web_asg" {
  name                        = "asg-${aws_launch_configuration.web_lc.name}"
  launch_configuration        = "${aws_launch_configuration.web_lc.name}"
  min_size                    = "${var.asg_web_mix_size}"
  max_size                    = "${var.asg_web_max_size}"
  desired_capacity            = "${var.asg_web_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.public_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "catalog-web"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_autoscaling_group.solr_asg"]
  
}

### harvester autoscaling group ###
resource "aws_autoscaling_group" "harvester_asg" {
  name                        = "asg-${aws_launch_configuration.harvester_lc.name}"
  launch_configuration        = "${aws_launch_configuration.harvester_lc.name}"
  min_size                    = "${var.asg_harvester_mix_size}"
  max_size                    = "${var.asg_harvester_max_size}"
  desired_capacity            = "${var.asg_harvester_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "catalog-harvester"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_autoscaling_group.solr_asg"]

}

### solr autoscaling group ###
resource "aws_autoscaling_group" "solr_asg" {
  name                        = "asg-${aws_launch_configuration.solr_lc.name}"
  launch_configuration        = "${aws_launch_configuration.solr_lc.name}"
  min_size                    = "${var.asg_solr_mix_size}"
  max_size                    = "${var.asg_solr_max_size}"
  desired_capacity            = "${var.asg_solr_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]
  target_group_arns           = [ "${aws_alb_target_group.solr_tg.arn}" ]

  tags = [
    {
      key                 = "Name"
      value               = "catalog-solr"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}

### inventory autoscaling group ###
resource "aws_autoscaling_group" "inventory_asg" {
  name                        = "asg-${aws_launch_configuration.inventory_lc.name}"
  launch_configuration        = "${aws_launch_configuration.inventory_lc.name}"
  min_size                    = "${var.asg_inventory_mix_size}"
  max_size                    = "${var.asg_inventory_max_size}"
  desired_capacity            = "${var.asg_inventory_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "inventory-web"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}

### crm autoscaling group ###
resource "aws_autoscaling_group" "crm_asg" {
  name                        = "asg-${aws_launch_configuration.crm_lc.name}"
  launch_configuration        = "${aws_launch_configuration.crm_lc.name}"
  min_size                    = "${var.asg_crm_mix_size}"
  max_size                    = "${var.asg_crm_max_size}"
  desired_capacity            = "${var.asg_crm_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "crm-web"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}

### dashboard autoscaling group ###
resource "aws_autoscaling_group" "dashboard_asg" {
  name                        = "asg-${aws_launch_configuration.dashboard_lc.name}"
  launch_configuration        = "${aws_launch_configuration.dashboard_lc.name}"
  min_size                    = "${var.asg_dashboard_mix_size}"
  max_size                    = "${var.asg_dashboard_max_size}"
  desired_capacity            = "${var.asg_dashboard_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "dashboard-web"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
### wordpress autoscaling group ###
resource "aws_autoscaling_group" "wordpress_asg" {
  name                        = "asg-${aws_launch_configuration.wordpress_lc.name}"
  launch_configuration        = "${aws_launch_configuration.wordpress_lc.name}"
  min_size                    = "${var.asg_wordpress_mix_size}"
  max_size                    = "${var.asg_wordpress_max_size}"
  desired_capacity            = "${var.asg_wordpress_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "wordpress-web"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}

### static autoscaling group ###
resource "aws_autoscaling_group" "static_asg" {
  name                        = "asg-${aws_launch_configuration.static_lc.name}"
  launch_configuration        = "${aws_launch_configuration.static_lc.name}"
  min_size                    = "${var.asg_static_mix_size}"
  max_size                    = "${var.asg_static_max_size}"
  desired_capacity            = "${var.asg_static_desired_capacity}"
  vpc_zone_identifier         = [ "${data.terraform_remote_state.vpc.private_subnets}" ]

  tags = [
    {
      key                 = "Name"
      value               = "jekyll-web"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
