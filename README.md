# databricks-lab
This code provides a foundational Azure Databricks build using Github actions and Terraform. It is meant as a springboard for additional Databricks learning and **not** a production ready build.

What will be created:
- A new Azure Resource Group
- A random-string named storage account
- A random-string named Azure Databricks instance (Standard sku)

All resources will build in Azure eastus2 region. TF code is, for the most part, dry. 

## Getting Started
### State file creation
Create a remote backend state file with the `state` directory. The state for the storage account this creates will remain local due to .gitignore properties.

Create a local `tfvars` file and populate with `tenant_id`, `subscription_id`, and `client_id` for your environment.

```
tenant_id       = "00000000-0000-0000-0000-000000000000"
subscription_id = "00000000-0000-0000-0000-000000000000"
client_id       = "00000000-0000-0000-0000-000000000000"
```

From the `state` directory, initialize the terraform code.

```
terraform init
```

Run `terraform plan` specifying your tfvars file and client secret. **Never store client secrets in committed or local code**

```
terraform plan -var-file=nonprod.tfvars -var='client_secret=********'
```

One the storage account is created, the SA name and Resource Group, along with the primary access key will be output. Save each to a secret titled `STORAGE_ACCOUNT_NAME`, `RESOURCE_GROUP_NAME` and `ACCESS_KEY` respectively.

![Terraform Output](https://raw.githubusercontent.com/jmspradlin/databricks-lab/master/docs/secrets1.jpg)

![Github Secrets](https://raw.githubusercontent.com/jmspradlin/databricks-lab/master/docs/secrets2.jpg)

## Checkov compliance testing
Checkov (checkov.io) is an automated compliance framework to ensure code aligns to CIS benchmarks and industry best practices. Testing occurs on all code pushes to ensure code aligns to benchmarks.

