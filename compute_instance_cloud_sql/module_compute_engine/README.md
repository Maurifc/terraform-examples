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
| [google_compute_address.public_static_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.allow_iap_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_tcp_ports](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_service_account.instance_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Root disk size in GB | `any` | n/a | yes |
| <a name="input_firewall_allow_tcp_ports"></a> [firewall\_allow\_tcp\_ports](#input\_firewall\_allow\_tcp\_ports) | List of allowed ports to be reached from the internet. TAKE CARE! | `list` | `[]` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Compute instances to create | `map` | `{}` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine size for the instance | `any` | n/a | yes |
| <a name="input_network_tags"></a> [network\_tags](#input\_network\_tags) | Network tag to be added. Optional. | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Default ProjectID | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Default region | `string` | `"us-east1"` | no |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | Bootstrap script | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `any` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Default zone | `string` | `"us-east1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Instance name |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Instance private ip |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Instance public ip |
| <a name="output_ssh_command"></a> [ssh\_command](#output\_ssh\_command) | Instance ssh connect |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Instance vpc |
| <a name="output_zone"></a> [zone](#output\_zone) | Zone of the instance |
<!-- END_TF_DOCS -->