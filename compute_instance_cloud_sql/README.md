# Terraform Google Cloud Portfolio Project

## Overview
This Terraform project demonstrates a comprehensive setup on Google Cloud Platform (GCP), including Virtual Private Cloud (VPC) networking, Compute Engine instances, Cloud SQL databases, and associated configurations. It is designed as a portfolio project to showcase Terraform skills for managing infrastructure as code.

---

## Features

1. **Google Cloud APIs**: Enables necessary GCP APIs for the project.
2. **Compute Engine Instances**: Creates instances with static IPs, service accounts, and startup scripts.
3. **Cloud SQL Instances**: Configures PostgreSQL Cloud SQL instances with support for VPC peering, backups, and point-in-time recovery.
4. **Networking**: Sets up a custom VPC with firewall rules for SSH and other protocols.
5. **Outputs**: Provides public/private IPs and SSH connection commands for Compute Engine instances.

---

## Prerequisites

1. **Google Cloud Platform (GCP)**:
   - A GCP account and a project with billing enabled.
   - IAM permissions to manage resources (e.g., `roles/owner`).
2. **Terraform**:
   - Install Terraform version `1.10.2` or higher.
3. **GCS Backend**:
   - Create a Google Cloud Storage bucket to store Terraform state files.

---

## Before You Begin

1. **Set up Google Cloud SDK**  
   Ensure the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) is installed on your machine. Verify the installation by running:  
   ```bash
   gcloud --version
   ```

2. **Authenticate Application Default Credentials (ADC)**  
   Authenticate your local machine to interact with Google Cloud resources. Run the following command:  
   ```bash
   gcloud auth application-default login
   ```

3. **Configure GCP Project**  
   Set the active project in your `gcloud` configuration:  
   ```bash
   gcloud config set project <your-project-id>
   ```

4. **Enable Billing**  
   Ensure billing is enabled for your Google Cloud project. Visit the [Billing section](https://console.cloud.google.com/billing) in the Google Cloud Console.

5. **Enable APIs**  
   Confirm that the necessary APIs (e.g., Compute Engine, Cloud SQL) are enabled in your project:  
   ```bash
   gcloud services enable compute.googleapis.com sqladmin.googleapis.com
   ```

6. **Install Terraform**  
   Install Terraform (v1.10.2 or later) from the [official Terraform website](https://developer.hashicorp.com/terraform/downloads). Verify the installation:  
   ```bash
   terraform version
   ```

7. **Set up GCS Backend for State Storage**  
   Create a Google Cloud Storage bucket to store Terraform state files. For example:  
   ```bash
   gcloud storage buckets create gs://test-1231231
   ```

   Enable *object versioning*
   ```bash
   gcloud storage buckets update gs://test-1231231 --versioning
   ```

---

## Setup and Deployment

### 1. Clone the Repository
```bash
git clone git@github.com:Maurifc/terraform-examples.git
cd terraform-examples/compute_instance_cloud_sql
```

### 2. Configure Variables
Make a copy of the `tfvars-sample` file or provide input variables during execution.
```bash
cp tfvars-sample my.tfvars
```

Below are the key variables you should set:

| Variable            | Description                      | Default Value         |
|---------------------|----------------------------------|-----------------------|
| `project`           | GCP Project ID                  | NA      |
| `region`            | Default region for resources     | `us-east1`            |
| `zone`              | Default zone for resources       | `us-east1-c`          |

Example `tfvars-sample`:
```hcl
project = "my-project"
region = us-east1
zone = us-east1-c

#----------------------------------------------------------------------------
# COMPUTE ENGINE
#----------------------------------------------------------------------------

instance_name  = "gitlab-vm"
machine_type   = "e2-micro" # free tier suitable
disk_size_gb   = "20"
network_tags   = ["gitlab"]
startup_script = "apt update && apt install -y nginx"
firewall_allow_tcp_ports = [
  "80",
  "443"
]

#----------------------------------------------------------------------------
# CLOUD SQL
#----------------------------------------------------------------------------

cloud_sql_instance_name  = "instance"
database_version         = "POSTGRES_15"
tier                     = "db-f1-micro"
enable_private_network   = false
enable_ha                = false
enforce_complex_password = true

project = "portal-ses"
```

### 3. Configure the GCP provider
  Set the backend bucket accordingly to the bucket you've created before
  ```yaml
    backend "gcs" {
      bucket = "tf-backend-f234e66ff568087c"
      prefix = "my-project/state/"
    }
  ```

### 4. Initialize Terraform
```bash
terraform init
```

### 5. Plan the Deployment
```bash
terraform plan -var-file my.tfvars
```

### 6. Apply the Configuration
```bash
terraform apply -var-file my.tfvars
```

---

## Outputs
After applying the configuration, the following outputs will be provided:

1. **Compute Engine Instances**:
   - Public and private IP addresses.
   - SSH connection command.

2. **Cloud SQL Instances**:
   - Public and private IP addresses.
   - Connection name for Cloud SQL.

---

## Cleanup
To delete all resources created by this project:
```bash
terraform destroy
```
Ensure no critical data exists in the resources before destruction.

---

## Notes
- For security, always store sensitive variables (e.g., service account keys) securely and avoid hardcoding them.

---

## Learn More
- [Terraform Documentation](https://www.terraform.io/docs)
- [Google Cloud Provider for Terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.10.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 6.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_sql"></a> [cloud\_sql](#module\_cloud\_sql) | ./module_cloud_sql | n/a |
| <a name="module_compute_engine_instance"></a> [compute\_engine\_instance](#module\_compute\_engine\_instance) | ./module_compute_engine | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_service.apis](https://registry.terraform.io/providers/hashicorp/google/6.13.0/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_sql_instance_name"></a> [cloud\_sql\_instance\_name](#input\_cloud\_sql\_instance\_name) | Name of the instance | `any` | n/a | yes |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | Database version | `any` | n/a | yes |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Root disk size in GB | `any` | n/a | yes |
| <a name="input_enable_apis"></a> [enable\_apis](#input\_enable\_apis) | APIs to enable on the project | `list` | <pre>[<br/>  "compute.googleapis.com",<br/>  "servicenetworking.googleapis.com"<br/>]</pre> | no |
| <a name="input_enable_ha"></a> [enable\_ha](#input\_enable\_ha) | Enable high availability for the instance | `bool` | `false` | no |
| <a name="input_enable_private_network"></a> [enable\_private\_network](#input\_enable\_private\_network) | Whether to enable private network or not | `bool` | `false` | no |
| <a name="input_enforce_complex_password"></a> [enforce\_complex\_password](#input\_enforce\_complex\_password) | Whether to enforce the complexity of the password | `bool` | `false` | no |
| <a name="input_firewall_allow_tcp_ports"></a> [firewall\_allow\_tcp\_ports](#input\_firewall\_allow\_tcp\_ports) | List of allowed ports to be reached from the internet. TAKE CARE! | `any` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name for the compute instance | `string` | `"demo-instance"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine size for the instance | `any` | n/a | yes |
| <a name="input_network_tags"></a> [network\_tags](#input\_network\_tags) | Network tag to be added. Optional. | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Default ProjectID | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Default region | `string` | `"us-east1"` | no |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | Bootstrap script | `any` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier (size) of the instance | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | `"my-custom-vpc"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Default zone | `string` | `"us-east1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_sql_instance_connection_name"></a> [cloud\_sql\_instance\_connection\_name](#output\_cloud\_sql\_instance\_connection\_name) | Instance connection name |
| <a name="output_cloud_sql_instance_name"></a> [cloud\_sql\_instance\_name](#output\_cloud\_sql\_instance\_name) | Instance name |
| <a name="output_cloud_sql_instance_private_ip"></a> [cloud\_sql\_instance\_private\_ip](#output\_cloud\_sql\_instance\_private\_ip) | Instance private ip |
| <a name="output_cloud_sql_instance_public_ip"></a> [cloud\_sql\_instance\_public\_ip](#output\_cloud\_sql\_instance\_public\_ip) | Instance public ip |
| <a name="output_compute_instance_name"></a> [compute\_instance\_name](#output\_compute\_instance\_name) | Instance name |
| <a name="output_compute_instance_private_ip"></a> [compute\_instance\_private\_ip](#output\_compute\_instance\_private\_ip) | Instance private ip |
| <a name="output_compute_instance_public_ip"></a> [compute\_instance\_public\_ip](#output\_compute\_instance\_public\_ip) | Instance public ip |
| <a name="output_compute_instance_ssh_command"></a> [compute\_instance\_ssh\_command](#output\_compute\_instance\_ssh\_command) | Instance ssh connect |
| <a name="output_compute_instance_vpc"></a> [compute\_instance\_vpc](#output\_compute\_instance\_vpc) | Instance vpc |
<!-- END_TF_DOCS -->