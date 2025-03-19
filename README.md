# Gadget4 on Amazon EKS

This repository contains infrastructure and deployment code to run the [Gadget4](https://github.com/weiguangcui/Gadget4) cosmological simulation code on Amazon EKS (Elastic Kubernetes Service).

## Overview

Gadget4 is a massively parallel code for N-body/hydrodynamical cosmological simulations. This project adapts Gadget4 to run efficiently on Kubernetes in the cloud, with specific optimizations for Amazon EKS.

## Features

- Infrastructure as Code using both Terraform and Pulumi
- Docker containerization of Gadget4
- Kubernetes deployment manifests for EKS
- Persistent storage with Amazon EFS
- Container registry with Amazon ECR
- Automated deployment scripts

## Prerequisites

- AWS CLI configured with appropriate permissions
- Docker installed
- kubectl installed
- Terraform or Pulumi installed (depending on your preference)

## Repository Structure

```
gadget4-eks/
├── Dockerfile                  # Docker image definition for Gadget4
├── README.md                   # This file
├── k8s/                        # Kubernetes manifests
│   ├── configmap.yaml          # Configuration for Gadget4
│   ├── job.yaml                # Job definition to run simulations
│   ├── namespace.yaml          # Namespace definition
│   ├── persistentvolumeclaim.yaml  # Storage claim for simulation data
│   └── storage-class.yaml      # EFS storage class
├── pulumi/                     # Pulumi infrastructure code
│   ├── Pulumi.yaml
│   ├── __main__.py             # Python code for Pulumi
│   └── requirements.txt        # Python dependencies
├── scripts/                    # Automation scripts
│   ├── build_and_push.sh       # Script to build and push Docker image
│   ├── deploy_to_k8s.sh        # Script to deploy to Kubernetes
│   └── deploy_pulumi.py        # Script to deploy with Pulumi
└── terraform/                  # Terraform infrastructure code
    ├── main.tf                 # Main Terraform configuration
    ├── outputs.tf              # Output definitions
    ├── providers.tf            # Provider configurations
    └── variables.tf            # Input variables
```

## Getting Started

### Using Terraform

1. Navigate to the terraform directory:
   ```bash
   cd terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Apply the Terraform configuration:
   ```bash
   terraform apply
   ```

4. Build and push the Docker image:
   ```bash
   ../scripts/build_and_push.sh
   ```

5. Deploy to Kubernetes:
   ```bash
   ../scripts/deploy_to_k8s.sh
   ```

### Using Pulumi

1. Navigate to the Pulumi directory:
   ```bash
   cd pulumi
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the deployment script:
   ```bash
   python ../scripts/deploy_pulumi.py
   ```

## Monitoring

You can monitor the job status using:

```bash
kubectl -n gadget4 get pods -w
```

And check logs using:

```bash
kubectl -n gadget4 logs -f <pod-name>
```

## Customization

- Edit `k8s/configmap.yaml` to customize Gadget4 simulation parameters
- Modify `terraform/variables.tf` or Pulumi configuration to adjust infrastructure settings

## Clean Up

### Terraform

```bash
terraform destroy
```

### Pulumi

```bash
pulumi destroy
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the same license as the original Gadget4 repository.

## Acknowledgements

- Original Gadget4 repository: [https://github.com/weiguangcui/Gadget4](https://github.com/weiguangcui/Gadget4)
- AWS EKS documentation
- Kubernetes documentation