# Workspace Management
---

Workspaces are designed for multi-user environments and can isolate data from different units.

## Create a Workspace

In the workspace list, click **Create a Workspace** in the top-right corner.

![](img/pass-1.png)

### Workspace Information

1. Enter the workspace name;    

2. Select the workspace language;

3. Choose the workspace owner: the user with the highest operational privileges for the workspace;    
4. Optionally enter a description for the workspace.

### Primary Storage Engine

Automatically lists the data storage engines.

If you do not select a data storage engine, data will be saved to the <<< custom_key.brand_name >>> primary storage engine.

### Data Retention Policy

This sets the retention period for data in the current workspace. It includes **Metrics, Logs (`default` index logs), Data Forwarding - Default Storage, Events, APM - Trace, APM - Profile, RUM PV, Session Replay, Security Check**.

In addition to the default retention periods for each data type, you can choose to set a custom retention period (<= 1800 days).

???+ warning "Important Notes on Configuring Extended Retention Periods:"

    1. For OpenSearch or Elasticsearch clusters configured with extended data retention periods, it is important to estimate both the storage space usage and the number of index shards;
    2. The default limit for the number of shards per index in an OpenSearch or Elasticsearch cluster is 1000 shards per node. For example, in a 3-node cluster, the total number of shards should not exceed 3000;
    3. Shards calculation method: If one of your workspaces has log indexes configured with 2 replicas, 3 shards, and each shard can hold up to 30GB, and the daily data volume fills approximately 2 indexes (i.e., a total of 180GB), with a retention period of 200 days, the total number of shards generated would be calculated as follows: Number of index replicas * Daily index count * Shards per index * Data retention days = 2 * 2 * 3 * 200 = 2400 shards;
    4. If you have multiple workspaces, you need to sum up the shard counts across all workspaces and also consider the shard estimates for other data types.


### Others {#others}

<!--
6. Index Merging: Collected data creates different indexes based on data type. More indexes mean more storage space used. To save storage space, you can enable index merging for the workspace;

- When index merging is enabled, the workspace creates data indexes according to Metrics, Logs/CI Monitoring/Synthetic Tests/Security Check, Backup Logs, Events, User Access/APM (trace, profile);

*Example: Adding a workspace with index merging enabled:*

- When index merging is disabled, the workspace creates data indexes according to Metrics, Logs, Backup Logs, Events, APM, User Access, Security Check;

**Example: Adding a workspace with index merging disabled:**

![](img/10.admin_1.1.png)

???+ warning "Note"

    - If you have selected a storage type, index merging cannot be enabled;         
    - Adjusting index merging will result in the deletion of old indexes and historical data in the workspace, which cannot be recovered.
-->

1. Left Star Query: Determines whether the newly created workspace supports left star queries;

2. Custom Mapping Rules: Enabling this configuration allows the workspace to [define custom mapping rules](./custom-mapping.md). Custom mapping rules in the workspace take precedence over those in the admin backend.

    **Note**: If there are overlapping configurations between the admin backend and the workspace's mapping rules, the member roles will be a combination of those assigned by the admin backend and the workspace.

3. Custom Log Indexes: When enabled, it allows the workspace to create multiple index policies for storing logs;

4. Large Log Count Unit: Used to set the counting unit for large logs, splitting them into multiple logs for billing purposes;

5. Query Limit: Sets a customized query limit for different users' workspaces to prevent excessive data queries from affecting cluster performance and product usability. After setting the query limit, any excess queries require re-querying to obtain results.


## Manage Workspaces

### Filtering 

Quickly filter and locate workspaces using two filters: **Primary Storage Engine** and **Business**.

### Search

On the workspace list page, you can view basic information about all workspaces and search by workspace name keywords.

### Index Configuration {#index}

Adjust the **primary shards**, **shard size**, and **replica shards** for all index templates in the current workspace.

Click the **Configure** button next to the data type to customize settings such as "primary shards", "shard size", "hot data retention period", enabling/disabling "replicas", and "advanced configuration".

![](img/10.admin_5.png)

Among these, under the **Volcano Engine base**, the storage policies for traces, logs, and custom log indexes include:

- Standard Storage: Configure hot data;
- Infrequent Access Storage: Configurable if standard storage duration is 7 days or more;
- Archive Storage: Configurable if standard storage duration is 30 days or more.


**Note**:

- Enabling replicas creates a redundant copy of the index shards by default;

- Enabling advanced configuration allows modifying the index mapping template, including parameters related to tokenization.


### Data Reporting Limits {#report-limit}

To meet the needs of users within the same role in a workspace, configure data reporting limits to determine if a certain type of data triggers a threshold on a "daily" basis. Once the threshold is triggered, subsequent reported data will not be written to the database and will be discarded to save resource costs.

<img src="../img/report-limit-1.png" width="60%" >

As shown, you can configure limits for Metrics, Network (number of hosts), Log entries, APM Trace counts, APM Profile entries, RUM PV counts, and Synthetic Test frequencies.

**Note**:

- `0` indicates that all corresponding data will be discarded without being written, meaning no upper limit;

- Metrics and network data, due to their time series and network dimensions, do not have quantity limits; only data write restrictions or no restrictions apply.


### View Members

Click to enter the members page of the corresponding workspace to view all member details.

You can perform actions like searching, modifying roles, and deleting members.


**Note**: A workspace can only have one owner. Changing another member to the owner demotes the original owner to an administrator.


#### Add Users

1. Click to enter the add page;
2. Select members;
3. Set role permissions;
4. Click Confirm.

![](img/10.admin_1.png)

**Note**: You can add existing system members here. If adding a new system member, you must first add them successfully on the [**Users > Add User**](./user.md#add) page before performing this operation.


### Modify/Delete Members

Click to modify the workspace configuration or directly delete the workspace.


## Delete Workspace

After clicking to delete a workspace, users will no longer be able to log in to that workspace, and data will stop being reported.

<<< custom_key.brand_name >>> will not immediately clear the data and configurations but will retain them for seven days to avoid unnecessary issues from accidental deletions.