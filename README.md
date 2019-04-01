# terraform-aws-elasticache

Terraform module that manages AWS Elasticache cluster.

This module creates:

- Elasticache replication group
- Elasticache parameter group
- Elasticache subnet group
- Security group

This module at the moment does not support Elasticache replication group with cluster mode enabled.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_security\_groups | The security groups' IDs allowed to communicate with the cluster | list | n/a | yes |
| allowed\_security\_groups\_count | The number of security groups allowed to communicate with the cluster | string | `"1"` | no |
| apply\_immediately | Specifies whether any modifications are applied immediately,   or during the next maintenance window | string | `"false"` | no |
| create\_parameter\_group | True to create a custom parameter group | string | `"false"` | no |
| default\_tags | The default tags to apply to the resoures | map | `<map>` | no |
| engine | Name of the cache engine to be used for this cache cluster | string | n/a | yes |
| engine\_version | Version number of the cache engine to be used | string | n/a | yes |
| node\_type | The compute and memory capacity of the cluster's nodes | string | `"cache.t2.micro"` | no |
| nodes\_count | The number of cache clusters (primary and replicas nodes) | string | n/a | yes |
| parameter\_group\_family | The custom parameter group's family | string | `""` | no |
| parameter\_group\_name | The name of the parameter group to use | string | `""` | no |
| parameters | A list of parameter maps to apply to the custom parameter group | list | `<list>` | no |
| port | The port number on which each of the cache nodes will accept connections | string | `"6379"` | no |
| prefix\_name | The prefix for the name of the resources | string | `"my"` | no |
| subnets | The subnets' IDs where to create the cluster | list | n/a | yes |
| vpc\_id | The VPC ID where to create the cluster | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | The address of the endpoint for the primary node in the Redis replication group,   with cluster mode disabled |

