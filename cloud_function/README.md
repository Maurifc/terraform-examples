# Google Cloud Function Terraform Project

## Overview
This Terraform project sets up a Google Cloud Function that is triggered by file uploads to a Cloud Storage bucket. The project includes the necessary infrastructure components such as storage buckets, service accounts, and IAM permissions.

---

## Features

1. **Cloud Function**
   - Runtime: Python 3.12
   - Memory: 128MB
   - Trigger: Cloud Storage events (object.finalize)
   - Environment variables configured for source code tracking

2. **Storage Buckets**
   - Function source code bucket: Stores the function's deployment package
   - Demo bucket: Receives user uploads and triggers the function

3. **Service Account**
   - Dedicated service account for the Cloud Function
   - Configured with necessary Storage Object Viewer permissions

## Prerequisites

1. **Google Cloud Platform Account**
   - Active GCP project with billing enabled
   - Necessary APIs enabled (Cloud Functions, Cloud Storage)

2. **Local Environment**
   - Terraform installed (latest version recommended)
   - Google Cloud SDK installed and configured
   - Authentication configured (`gcloud auth application-default login`)

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
cd terraform-examples/cloud_function
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

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Plan the Deployment
```bash
terraform plan -var-file my.tfvars
```

### 5. Apply the Configuration
```bash
terraform apply -var-file my.tfvars
```

---
## Outputs
After applying the configuration, the following outputs will be provided:

1. **source_code_bucket**:
   - The source code bucket for the functions

2. **event_bucket**:
   - Public and private IP addresses.
   - Connection name for Cloud SQL.
   - 
3. **cloud_function**:
   - Function's name, region, runtime and entrypoint

---

## Usage
1.The Cloud Function will be triggered automatically when files are uploaded to the demo bucket.
2.Function source code should be placed in the source-code/ directory.
3.The function uses the entry point main.

---

## Security Features
- Uniform bucket-level access enabled for all storage buckets
- Dedicated service account with minimal required permissions

---

## Cleanup
To remove all resources created by this project:

```bash
terraform destroy
```

---

## Notes
- The function's source code is automatically zipped and uploaded to the source code bucket
- Random suffixes are added to bucket names to ensure global uniqueness

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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_demo_function"></a> [demo\_function](#module\_demo\_function) | ./cloud_function_module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | A unique name for the function | `string` | `"demo-function"` | no |
| <a name="input_project"></a> [project](#input\_project) | Default ProjectID | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Default region | `string` | `"us-east1"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Default zone | `string` | `"us-east1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_function"></a> [cloud\_function](#output\_cloud\_function) | n/a |
| <a name="output_event_bucket"></a> [event\_bucket](#output\_event\_bucket) | The event bucket for the function |
| <a name="output_source_code_bucket"></a> [source\_code\_bucket](#output\_source\_code\_bucket) | The source code bucket for the functions |
<!-- END_TF_DOCS -->