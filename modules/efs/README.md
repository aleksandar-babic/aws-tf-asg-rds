## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| available\_subnets | List of Subnet IDs where EFS should be available | `list(string)` | n/a | yes |
| env | Name of the environment resources are deployed to. (ex. my-super-project-dev). | `string` | n/a | yes |
| trusted\_sgs | List of the SGs that EFS will trust to. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | DNS name of the EFS file system. |

