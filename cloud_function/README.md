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