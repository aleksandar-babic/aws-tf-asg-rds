## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cpu\_metric\_down\_threshold | CPUUtilization Auto scaling policy metric threshold to scale-down. | `string` | n/a | yes |
| cpu\_metric\_period | CPUUtilization Auto scaling policy metric period in seconds. | `string` | n/a | yes |
| cpu\_metric\_up\_threshold | CPUUtilization Auto scaling policy metric threshold to scale-up. | `string` | n/a | yes |
| db\_ip | IP of the DB. | `string` | n/a | yes |
| db\_name | Name of the DB. | `string` | n/a | yes |
| db\_username | Name of the DB user. | `string` | n/a | yes |
| desired\_capacity | Desired capacity of the ASG. | `number` | n/a | yes |
| efs\_dns\_name | DNS name of EFS that will be used to mount in ASG instance. | `string` | n/a | yes |
| efs\_mount\_point | Mount point where EFS should be mounted in ASG instance. | `string` | n/a | yes |
| elb\_security\_group\_id | ID of the ELB security group. | `string` | n/a | yes |
| env | Name of the environment resources are deployed to. (ex. my-super-project-dev). | `string` | n/a | yes |
| instance\_type | Instance type of the ASG. | `string` | n/a | yes |
| max\_size | Maximum size of the ASG. | `number` | n/a | yes |
| min\_size | Minimum size of the ASG. | `number` | n/a | yes |
| ssm\_db\_password | Name of the SSM parameter with db password. | `string` | n/a | yes |
| ssm\_region | Name of the region where SSM parameters are defined. | `string` | n/a | yes |
| subnets\_to\_use | List of Subnet IDs to use in ASG. | `list(string)` | n/a | yes |
| target\_group\_arns | List of TG ARNs to use in ASG. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| asg\_security\_group\_id | ID of the security group used in ASG. |

