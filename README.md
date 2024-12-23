# Azure Infrastructure with Terraform

This repository contains Terraform configurations for deploying and managing Azure infrastructure following 2024 best practices. The infrastructure includes virtual machines for different application tiers (web, application, and database) with appropriate networking and security configurations.

## Architecture Overview

The infrastructure is organized into three distinct tiers:
- Web Tier: Houses REST API and UI servers
- Application Tier: Contains Kafka, RabbitMQ, Channel, and Hub services
- Database Tier: Manages MongoDB read and write nodes

Each tier is deployed in its own subnet with specific security rules and configurations tailored to its requirements.

## Prerequisites

Before you begin, ensure you have the following installed:
- Terraform (1.5.0 or newer)
- Go (1.22 or newer) for running tests
- Azure CLI (2.0.79 or newer)
- Access to an Azure subscription

## Project Structure

```
.
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   └── backend.tf
│   └── prod/
└── modules/
    ├── vm/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── network/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Features

- Modular design for reusability and maintainability
- Secure network configuration with separate subnets for each tier
- Managed disks for all virtual machines
- System-assigned managed identities
- Network security groups with tier-specific rules
- Azure Key Vault integration for secret management
- Comprehensive tagging system
- Automated testing with Terratest

## Getting Started

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Login to Azure:
```bash
az login
```

3. Initialize Terraform:
```bash
cd environments/dev
terraform init
```

4. Review and apply the configuration:
```bash
terraform plan
terraform apply
```

## Testing

The project includes automated tests using Terratest. To run the tests:

```bash
cd test
go mod init terraform-test
go mod tidy
go test -v
```

## Module Configuration

### VM Module
The VM module creates Azure virtual machines with the following features:
- RedHat Linux 8.6 base image
- Managed system identity
- Data disk attachment
- Network interface with dynamic IP
- NSG with role-specific rules

### Network Module
The network module sets up:
- Virtual network with separate subnets
- Network security groups
- Key Vault for secret management
- Subnet delegation and service endpoints

## Best Practices Implemented

- Resource naming follows Azure naming conventions
- Infrastructure is environment-segregated
- All resources are properly tagged
- Secrets are managed through Key Vault
- Network security follows defense-in-depth principles
- Uses for_each for resource creation
- Implements systematic error handling

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

This project follows the latest Terraform and Azure best practices as of 2024, incorporating security and performance optimizations.