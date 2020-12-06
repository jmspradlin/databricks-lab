# databricks-lab
This code provides a foundational Azure Databricks build using Github actions and Terraform. It is meant as a springboard for additional Databricks learning and **not** a production ready build.

What will be created:
- A new Azure Resource Group
- A random-string named storage account
- A random-string named Azure Databricks instance (Standard sku)

All resources will build in Azure eastus2 region. TF code is, for the most part, dry. 

## Checkov compliance testing
Checkov (checkov.io) is an automated compliance framework to ensure code aligns to CIS benchmarks and industry best practices. Testing occurs on all code pushes to ensure code aligns to benchmarks.