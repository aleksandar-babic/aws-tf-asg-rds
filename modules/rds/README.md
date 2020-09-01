## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocated\_storage | The allocated storage in gigabytes. | `string` | `"30"` | no |
| available\_subnets | List of Subnet IDs where RDS should be available. | `list(string)` | n/a | yes |
| backup\_retention\_period | The days to retain backups for. | `number` | `1` | no |
| backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window. | `string` | `"03:10-05:10"` | no |
| db\_name | The DB name to create. | `string` | n/a | yes |
| db\_password\_length | Lenght of the random password that will be generated for the DB. | `number` | `24` | no |
| db\_port | The port on which the DB accepts connections. | `string` | `"3306"` | no |
| db\_username | Username for the master DB user. | `string` | n/a | yes |
| engine\_version | Version of the MySQL engine to use. | `string` | n/a | yes |
| env | Name of the environment resources are deployed to. (ex. my-super-project-dev). | `string` | n/a | yes |
| instance\_class | Instance class used for the RDS. | `string` | n/a | yes |
| maintenance\_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'. | `string` | `"Mon:00:00-Mon:03:00"` | no |
| multi\_az | Specifies if the RDS instance is multi-AZ. | `bool` | `false` | no |
| trusted\_sgs | List of the SGs that RDS will trust to. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db\_ip | Database IP address. |
| ssm\_db\_password | Name of the SSM parameter for database user password. |

