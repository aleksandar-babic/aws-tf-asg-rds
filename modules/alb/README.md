## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | Name of the environment resources are deployed to. (ex. my-super-project-dev). | `string` | n/a | yes |
| subnets\_to\_use | List of Subnet IDs to use in ALB. | `list(string)` | n/a | yes |
| vpc\_id | VPC ID to use in ALB. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | DNS name of the load balancer. |
| security\_group\_id | ID of the SG that ALB uses. |
| target\_group\_arns | List of TG ARNs from the ALB. |

