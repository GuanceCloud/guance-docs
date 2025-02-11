# Workspace Management
---

Workspaces are designed for multi-user environments and can isolate data from different units.

## Create a New Workspace

In the workspace list, click **Create New Workspace** in the top-right corner.

![](img/pass-1.png)

### Workspace Information

1. Enter the workspace name;    

2. Select the workspace language;

3. Choose the workspace owner: The owner has the highest operational permissions;
4. Optionally, provide a description for the workspace.

### Primary Storage Engine

Automatically lists the data storage engines.

If you do not select a data storage engine, the data will be saved to the primary storage engine of Guance.

### Data Retention Policy

This defines the retention period for data within the current workspace. It includes **Metrics, logs (`default` index logs), data forwarding-default storage, events, APM-traces, APM-Profiles, RUM, session replays, Security Check**.

In addition to the retention periods for each data type, you can also set a custom retention period (≤ 1800 days).

???+ warning "Considerations for configuring extended retention periods:"

    1. For OpenSearch or Elasticsearch clusters configured with long-term data retention, it's important to estimate both storage space usage and the number of index shards;
    2. OpenSearch or Elasticsearch clusters have a default limit of 1000 shards per node. For example, in a 3-node cluster, the maximum number of shards should not exceed 3000;
    3. To calculate the number of shards, consider an example where a workspace's log index is configured with 2 replicas and 3 shards, with each shard having a maximum size of 30GB. If daily data volume fills approximately 2 indexes (i.e., a total of 180GB), and data retention is set to 200 days, the total number of shards would be calculated as: Index replica count * Daily index count * Shards per index * Data retention days = 2 * 2 * 3 * 200 = 2400 shards;
    4. If there are multiple workspaces, sum up the index shards across all workspaces and include other data types' index shards in your estimation.


### Others {#others}

1. Left Star Query: Determines whether the newly created workspace supports left star queries;

2. Custom Mapping Rules: Enabling this configuration allows the workspace to [customize mapping rules](./custom-mapping.md). The workspace's custom mapping rules take precedence over those set in the admin panel.

    **Note**: If there are overlapping configurations between the admin panel and the workspace's mapping rules, the member role will be a combination of roles assigned by the admin panel and the workspace.

3. Custom Log Indices: When enabled, this allows the workspace to create multiple index policies for storing logs;

4. Large Log Count Unit: Sets the counting unit for large logs, which can be split into multiple logs for billing purposes based on the set unit;

5. Query Limit: Customizes query limits for different users within the workspace to prevent performance degradation due to excessive data queries, ensuring a better user experience. After setting a query limit, any excess queries require re-querying to retrieve results.


## Manage Workspaces

### Filtering 

Quickly filter and locate workspaces using the **Primary Storage Engine** and **Business** filters.

### Search

On the workspace list page, you can view basic information about all workspaces and search by workspace name keywords.

### Index Configuration {#index}

Adjust the **Primary Shards**, **Shard Size**, and **Replica Shards** for all index templates in the current workspace.

Click the **Configure** button next to the data type to customize settings such as "Primary Shards," "Shard Size," "Hot Data Retention Period," enable/disable "Replicas," and access "Advanced Configuration."

![](img/10.admin_5.png)

Among these, under the Volcano Engine infrastructure, the storage strategies for traces, logs, and custom log indices include:

- Standard Storage: Configure hot data;
- Infrequent Access Storage: Configurable if standard storage duration is 7 days or more;
- Archive Storage: Configurable if standard storage duration is 30 days or more.

**Note**:

- Enabling replicas creates a redundant copy of the index shards by default;

- Enabling advanced configuration allows modifications to the index mapping template, including changes to tokenization parameters.

### Data Reporting Limits {#report-limit}

To meet the needs of users with the same role within a workspace, configure data reporting limits to determine if a certain type of data exceeds a threshold on a "per day" basis. Once the threshold is reached, subsequent data reports will not be written to the database and will be discarded, thus saving resource costs.

<img src="../img/report-limit-1.png" width="60%" >

As shown, you can configure limits for Metrics, network (host count), log entries, APM trace counts, APM profile counts, RUM PV counts, and Synthetic Tests.

**Note**:

- `0` means all corresponding data will be discarded without being written, indicating no upper limit;

- Metrics and network data do not have quantity limits because they are time series and network-based, only enabling or disabling data write restrictions.


### View Members

Click to enter the workspace members page to view all member details.

You can perform actions like searching, modifying roles, and deleting members.

**Note**: A workspace can only have one owner. Changing another member to owner demotes the original owner to administrator.


#### Add User

1. Click to enter the add page;
2. Select members;
3. Set role permissions;
4. Click confirm.

![](img/10.admin_1.png)

**Note**: You can add existing system members here. For new system members, they need to be added successfully on the [**User > Add User**](./user.md#add) page before returning here to proceed.

### Modify/Delete Members

Click to modify the workspace configuration or delete the workspace directly.


## Delete Workspace

After clicking to delete the workspace, users will no longer be able to log in, and data will stop being reported.

Guance will not immediately clear the data and configurations but will retain them for seven days to avoid unnecessary complications from accidental deletions.