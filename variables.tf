# Engine 

variable "engine" {
  description = <<EOF
  Name of the cache engine to be used for this cache cluster
  EOF
}

variable "engine_version" {
  description = <<EOF
  Version number of the cache engine to be used
  EOF
}

# Network

variable "vpc_id" {
  description = "The VPC ID where to create the cluster"
}

variable "subnets" {
  type        = "list"
  description = "The subnets' IDs where to create the cluster"
}

variable "allowed_security_groups_count" {
  default     = 1
  description = "The number of security groups allowed to communicate with the cluster"
}

variable "allowed_security_groups" {
  type        = "list"
  description = "The security groups' IDs allowed to communicate with the cluster"
}

variable "port" {
  default = "6379"

  description = <<EOF
  The port number on which each of the cache nodes will accept connections
  EOF
}

# Size

variable "node_type" {
  default = "cache.t2.micro"

  description = <<EOF
  The compute and memory capacity of the cluster's nodes
  EOF
}

variable "nodes_count" {
  description = <<EOF
  The number of cache clusters (primary and replicas nodes)
  EOF
}

variable "apply_immediately" {
  default = false

  description = <<EOF
  Specifies whether any modifications are applied immediately,
  or during the next maintenance window
  EOF
}

# Parameter group

variable "parameter_group_name" {
  description = "The name of the parameter group to use"
  default     = ""
}

variable "create_parameter_group" {
  description = "True to create a custom parameter group"
  default     = false
}

variable "parameter_group_family" {
  description = "The custom parameter group's family"
  default     = ""
}

variable "parameters" {
  description = "A list of parameter maps to apply to the custom parameter group"
  default     = []
}

# Resource naming

variable "prefix_name" {
  description = "The prefix for the name of the resources"
  default     = "my"
}

variable "default_tags" {
  type        = "map"
  description = "The default tags to apply to the resoures"

  default = {
    Terraform = "true"
  }
}
