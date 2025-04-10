---
title: 'Azure Storage'
tags: 
  - 'AZURE'
summary: 'Collect Azure Storage metrics data'
__int_icon: 'icon/azure_storage'
dashboard:
  - desc: 'Azure Storage monitoring view'
    path: 'dashboard/en/azure_storage'
monitor   :
  - desc  : 'Azure Storage detection library'
    path  : 'monitor/en/azure_storage'
---

Collect Azure Storage metrics data

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

1. Log in to the Func console, click on 【Script Market】, enter the official script market, and search for `guance_azure_storage`

2. After clicking 【Install】, enter the corresponding parameters: `Azure Tenant ID`, `Azure Client ID`, `Azure Client Secret Value`, `Subscriptions`

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute it once without waiting for the scheduled time. Wait a moment, and you can check the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

Collect Azure Storage metrics, and more metrics can be collected through configuration:

[Microsoft.ClassicStorage/storageAccounts supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/blobServices supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-blobservices-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/fileServices supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-fileservices-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/queueServices supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-queueservices-metrics){:target="_blank"}

[Microsoft.ClassicStorage/storageAccounts/tableServices supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-classicstorage-storageaccounts-tableservices-metrics){:target="_blank"}

Under the `Microsoft.Storage/storageAccounts` namespace, the following metrics are included:

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| `availability_average` | Availability | % |
| `egress_total` | Data egress volume | Bytes |
| `ingress_total` | Data ingress volume | Bytes |
| `success_e_2_elatency_average` | Successful E2E latency | ms |
| `success_server_latency_average` | Successful server latency | ms |
| `transactions_total` | Number of requests issued to the storage service or specific API operation | Count |
| `used_capacity_average` | Used capacity | Bytes |

Under the `Microsoft.Storage/storageAccounts/blobServices` namespace, the following metrics are included:

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| `availability_average` | Availability | % |
| `egress_total` | Data egress volume | Bytes |
| `ingress_total` | Data ingress volume | Bytes |
| `blob_capacity_average` | Blob capacity | Bytes |
| `blob_count_average` | Blob count | Count |
| `container_count_average` | Blob container count | Count |
| `index_capacity_average` | Index capacity | Bytes |
| `success_e_2_elatency_average` | Successful E2E latency | ms |
| `success_server_latency_average` | Successful server latency | ms |
| `transactions_total` | Number of requests issued to the storage service or specific API operation | Count |

Under the `Microsoft.Storage/storageAccounts/fileServices` namespace, the following metrics are included:

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| `availability_average` | Availability | % |
| `egress_total` | Data egress volume | Bytes |
| `ingress_total` | Data ingress volume | Bytes |
| `file_capacity_average` | File capacity | Bytes |
| `file_count_average` | File count | Count |
| `file_share_capacity_quota_average` | File share quota size | Bytes |
| `file_share_snapshot_count_average` | File share count | Count |
| `file_share_snapshot_size_average` | File share snapshot size | Bytes |
| `file_share_snapshot_count_average` | File share snapshot count | Count |
| `success_e_2_elatency_average` | Successful E2E latency | ms |
| `success_server_latency_average` | Successful server latency | ms |
| `transactions_total` | Number of requests issued to the storage service or specific API operation | Count |

Under the `Microsoft.Storage/storageAccounts/queueServices` namespace, the following metrics are included:

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| `availability_average` | Availability | % |
| `egress_total` | Data egress volume | Bytes |
| `ingress_total` | Data ingress volume | Bytes |
| `queue_capacity_average` | Queue capacity | Bytes |
| `queue_count_average` | Queue count | Count |
| `queue_message_count_average` | Queue message count | Count |
| `success_e_2_elatency_average` | Successful E2E latency | ms |
| `success_server_latency_average` | Successful server latency | ms |
| `transactions_total` | Number of requests issued to the storage service or specific API operation | Count |

Under the `Microsoft.Storage/storageAccounts/tableServices` namespace, the following metrics are included:

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| `availability_average` | Availability | % |
| `egress_total` | Data egress volume | Bytes |
| `ingress_total` | Data ingress volume | Bytes |
| `table_capacity_average` | Table capacity | Bytes |
| `table_count_average` | Table count | Count |
| `table_entity_count_average` | Table entity count | Count |
| `success_e_2_elatency_average` | Successful E2E latency | ms |
| `success_server_latency_average` | Successful server latency | ms |
| `transactions_total` | Number of requests issued to the storage service or specific API operation | Count |