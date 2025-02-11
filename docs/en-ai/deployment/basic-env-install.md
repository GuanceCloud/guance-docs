# Infrastructure Deployment

## Infrastructure Planning {#basic-planning}

| **Resource Catalog** | **Description** | **Applicable Scenario** | **Supported Architecture** |
| :------------------------------------: | :------------------: | :----------------------: | :----------: |
| [`Cloud Resource Catalog`](cloud-required.md) | Installation using cloud products | Suitable for production use | amd64/arm64 |
| [`Self-built Infrastructure Resource Catalog`](offline-required.md) | Installation on cloud servers or virtual machines | Suitable for production use | amd64/arm64 |

## Infrastructure Deployment {#basic-install}

Currently, the following deployment methods are supported:

| Deployment Environment | Deployment Documentation | **Description** | **Applicable Scenario** | **Supported Architecture** |
| :------------------------------------: | :------------------: | :----------------------: | :----------: | -------------------------------------- |
| `Cloud Infrastructure Deployment` | 1. [`Alibaba Cloud Deployment`](cloud-deployment-manual.md) | Initialization of infrastructure using cloud products | Suitable for production use | amd64 / arm64 |
| `Self-built Infrastructure Deployment` | 1. [`Manual Self-built Infrastructure Deployment`](offline-deployment-manual.md) | Installation on cloud servers or virtual machines, supporting both online and offline deployment | Suitable for production use | amd64 / arm64 |
| `Offline Environment Deployment` | 1. [`Offline Environment Infrastructure Deployment`](Started.md) | Installation on cloud servers or virtual machines, supporting pure offline deployment in environments without external network access | Suitable for production use | amd64 |