<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.cloudsql_peering_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | Networkws that are allowed to reach the instances | `any` | n/a | yes |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | Database version | `any` | n/a | yes |
| <a name="input_enable_ha"></a> [enable\_ha](#input\_enable\_ha) | Enable high availability for the instance | `bool` | `false` | no |
| <a name="input_enable_private_network"></a> [enable\_private\_network](#input\_enable\_private\_network) | Whether to enable private network or not | `bool` | `false` | no |
| <a name="input_enforce_complex_password"></a> [enforce\_complex\_password](#input\_enforce\_complex\_password) | Whether to enforce the complexity of the password | `bool` | `false` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the instance | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Default ProjectID | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Default region | `any` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier (size) of the instance | `any` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC where the Cloud SQL Instances will be attached (Only if private network is enabled) | `any` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Default zone | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | Instance connection name |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Instance name |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Instance private ip |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Instance public ip |
<!-- END_TF_DOCS -->