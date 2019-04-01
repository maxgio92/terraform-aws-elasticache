output "endpoint" {
  value = "${aws_elasticache_replication_group.this.primary_endpoint_address}"

  description = <<EOF
  The address of the endpoint for the primary node in the Redis replication group,
  with cluster mode disabled
  EOF
}
