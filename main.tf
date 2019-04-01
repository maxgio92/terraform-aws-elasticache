locals {
  parameter_group_name = "${coalesce(var.parameter_group_name, (length(aws_elasticache_parameter_group.this.*.id) == 0 ? "" : element(concat(list(""), aws_elasticache_parameter_group.this.*.id), 1)))}"

  enable_create_parameter_group = "${var.parameter_group_name == "" ? var.create_parameter_group : 0}"
}

# -----------------------------------------------------------------------
# Cluster
# -----------------------------------------------------------------------

resource "aws_elasticache_replication_group" "this" {
  depends_on                    = ["aws_elasticache_parameter_group.this"]
  replication_group_id          = "${var.prefix_name}-cluster"
  replication_group_description = "${replace(replace(var.prefix_name, "-", " "), "_", " ")} cluster"
  automatic_failover_enabled    = true
  number_cache_clusters         = "${var.nodes_count}"
  node_type                     = "${var.node_type}"
  auto_minor_version_upgrade    = true
  engine                        = "${var.engine}"
  engine_version                = "${var.engine_version}"
  parameter_group_name          = "${local.parameter_group_name}"
  port                          = "${var.port}"
  subnet_group_name             = "${aws_elasticache_subnet_group.this.id}"
  security_group_ids            = ["${aws_security_group.this.id}"]
  apply_immediately             = "${var.apply_immediately}"
  tags                          = "${var.default_tags}"
}

# -----------------------------------------------------------------------
# Parameter group
# -----------------------------------------------------------------------

resource "aws_elasticache_parameter_group" "this" {
  count = "${local.enable_create_parameter_group}"

  name      = "${var.prefix_name}-pg"
  family    = "${var.parameter_group_family}"
  parameter = ["${var.parameters}"]
}

# -----------------------------------------------------------------------
# Subnet group
# -----------------------------------------------------------------------

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.prefix_name}-subnets"
  subnet_ids = ["${var.subnets}"]
}

# -----------------------------------------------------------------------
# Security group
# -----------------------------------------------------------------------

resource "aws_security_group" "this" {
  name   = "redis-cluster"
  vpc_id = "${var.vpc_id}"

  tags = "${var.default_tags}"
}

resource "aws_security_group_rule" "default_ingress" {
  count = "${var.allowed_security_groups_count}"

  type                     = "ingress"
  from_port                = "${var.port}"
  to_port                  = "${var.port}"
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_security_groups, count.index)}"
  security_group_id        = "${aws_security_group.this.id}"
}
