### Introduction

This section introduces how to manage workspace index configurations in the backend administration.

### Description
Guance supports storage engines such as Opensearch, Elasticsearch, and Doris. We will explain how to manage workspace index configurations for environments configured with these storage engines.

### Default Index Configuration for New Workspaces
This applies when we initially deploy the system. For subsequently added workspaces that want to customize global workspace index configurations, you can follow this method.
In the `forethought-core` namespace, modify the `core` ConfigMap by adding the following content:
```yaml
WorkspaceDefaultesIndexSettings:
  number_of_shards: 1                       
  rollover_max_size: 30   
  number_of_replicas: 1 
  hot_retention: 24                
```

| **Configuration Item** | **Description** | **Default Value** | **Recommended Value** |
|---------|  | --- |---------|
| number_of_shards    | Number of primary shards for the index | 1 | Align with the data nodes of the Opensearch cluster; keep default for Doris |
| rollover_max_size   | Size of a single shard | 30 | 30 |
| number_of_replicas   | Whether to enable index replicas | 1 | It is recommended to enable if there is sufficient disk space |
| hot_retention | Duration for retaining hot data | 24 | Can be set to a longer retention period if there is sufficient disk space; this setting does not take effect if ES lacks a hot-warm-cold architecture |

After adding, restart all services under the `forethought-core` namespace.

### Updating Default Index Configuration for Existing Workspaces
Log in to the backend management page (you can find the backend management URL by going to the top-right corner of the launcher and copying the address corresponding to "management") using an admin user. Find the workspace whose default retention policy you want to modify, click on **Index Configuration**, enter the index page, and click **Configure** to configure indexes for different storage contents.
![config-index-1.png](img/config-index-1.png)
![config-index-2.png](img/config-index-2.png)

#### Storage Engine: Opensearch or Elasticsearch
When configuring spaces with storage engines Opensearch or Elasticsearch, the following configuration items are available:
![config-index-3.png](img/config-index-3.png)

| **Configuration Item** | **Description** | **Default Value** | **Recommended Value** |
|---------|  | --- |---------|
| Primary Shards     | Number of primary shards for the index | 1 | Align with the data nodes of the Opensearch cluster |
| Shard Size   | Size of a single shard | 30 | 30 |
| Enable Replica   | Whether to enable index replicas | No | Enabled by default with 1 replica; it is recommended to enable if there is sufficient disk space |
| Hot Data Retention Duration | Duration for retaining hot data | 0 | Keep default (this setting does not take effect if ES lacks a hot-warm-cold architecture) |
| Advanced Configuration | Advanced configurations for the index | No | Keep default |

#### Storage Engine: Doris
When configuring spaces with the Doris storage engine, the following configuration items are available:
![config-index-4.png](img/config-index-4.png)

| **Configuration Item** | **Description** | **Default Value** | **Recommended Value** |
|---------|  | --- |---------|
| Enable Replica | Whether to enable replicas | No | It is recommended to enable if there is sufficient disk space |
| Hot Data Retention Duration | Hot data is retained on disk, and data exceeding the retention duration will be migrated to object storage | 24 | Can be set to a longer retention period if there is sufficient disk space |