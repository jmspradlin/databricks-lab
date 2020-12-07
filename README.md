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

<img src="https://raw.githubusercontent.com/jmspradlin/databricks-lab/master/docs/secrets1.jpg" width="250"><br/><br/>

<img src="https://raw.githubusercontent.com/jmspradlin/databricks-lab/master/docs/secrets2.jpg" width="500"><br/><br/>

## Databricks deployment
Add your `SUBSCRIPTION_ID`, `TENANT_ID`, `CLIENT_ID` and `CLIENT_SECRET` to your Github secrets for the project.

The `azure-deploy.yaml` and `checkov_databricks.yaml` files will trigger on changes to the terraform directory, using the subscription ID, tenant id, client id and secret, as well as the resource group name, storage account name, and storage access key.

## Checkov compliance testing
Checkov (checkov.io) is an automated compliance framework to ensure code aligns to CIS benchmarks and industry best practices. Testing occurs on all code pushes to the `terraform` directory to ensure code aligns to benchmarks. Currently excluded are benchmarks for [Enable Requests on Storage Logging for Queue Service](https://docs.bridgecrew.io/docs/enable-requests-on-storage-logging-for-queue-service) and [Set Default Network Access Rule for Storage Accounts to Deny](https://docs.bridgecrew.io/docs/set-default-network-access-rule-for-storage-accounts-to-deny)