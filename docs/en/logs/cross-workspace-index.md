# Cross-Workspace Index Query
---

???+ warning "Note Before Starting"

    To centrally manage, retrieve, and analyze various types of [logs](./explorer.md), Guance can collect logs and unify the log data reporting to the Guance workspace through log collection. By using the log explorer, you can view and search all log content within the workspace, achieving a more comprehensive log data analysis.

    Additionally, the Guance platform provides an [index](./multi-index.md) feature. It defines categorization rules for log data, allowing users to save and access logs through different indexes and implement data storage strategies as needed, effectively controlling storage costs.

## Why Is Cross-Workspace Index Query Necessary?

:material-numeric-1-circle: Features:

From the previous text, it is not difficult to obtain the attributive characteristics of indexes and logs: both logs and indexes are in relation to the **workspace they belong to**. Logs are **stored within the workspace**, and indexes are **special categorization and storage rules created for log data within that workspace**.

:material-numeric-2-circle: Challenges:

Enterprises often create multiple workspaces in Guance for data management due to the needs of cost accounting for various teams or control over data resource permissions. Although this model achieves a scenario where departments manage their data separately, it is not conducive to global data analysis.

:material-numeric-3-circle: Necessity:

Based on the need for global data analysis under data management, Guance provides the functionality to query across workspaces, allowing access to log data from other spaces.

Specifically, since logs are categorized by index, after authorizing the index data of "Workspace 1" to "Workspace 2," you can obtain the index of "Workspace 1" in the log explorer of "Workspace 2," thus being able to view the log data under the corresponding index.

This feature breaks through the limitations of log data storage locations and greatly improves the efficiency of data analysis and fault location.

![](img/cross-workspace-index-6.png)

## Get Started

> Use case: If the index data of "Workspace 1" is authorized to "Workspace 2," for "Workspace 2," the available indexes are divided into two categories:

- [Indexes originally in the current workspace](#original);
- [Indexes authorized by other workspaces](#others).

### Query Original Indexes of the Current Workspace {#original}

Enter the log explorer of "Workspace 2," and the "Workspace bar" in the upper left corner defaults to the current workspace.

The quick filter on the left lists all available original indexes of this workspace, which are: default index, log index, external index.

**Note**: The external index is a single selection.

<img src="../img/cross-workspace-index.png" width="70%" >

### Query Indexes Authorized by Other Workspaces {#others}

> If "Workspace 2" needs to use the index data of "Workspace 1," to perform cross-workspace index authorization, it is divided into two steps:

1. In the workspace that needs to perform the authorization (Workspace 1), authorize the corresponding log items and indexes;
2. Enter the workspace that has been authorized (Workspace 2) and select the index item for application.

> For more operational details, see [Cross-Workspace Authorization](../management/data-authorization.md#site).

Once the above two steps are completed, the index authorization of "Workspace 1" to "Workspace 2" has been completed. At this point, enter the authorized workspace---**"Workspace 2" > Log Explorer**.

#### Selecting the Workspace

Click the **Workspace** dropdown box to view all available workspaces. This supports single/multiple selection.

???+ warning "Note"

    1. The list of available workspaces here only includes workspaces that meet three conditions: belong to the same cluster; have completed the authorization operation; the authorized data scope includes log data.
    2. Selecting a single space will directly display the name of the selected workspace in the workspace bar; when selecting multiple workspaces, it will be displayed as: n items selected, click to view specific options.


<img src="../img/cross-workspace-index-1.png" width="70%" >

#### Select the Index

After selecting the workspace, the indexes under that workspace will be synchronized and listed in the **Quick Filter**:

???+ warning "Note"

    1. External indexes do not support cross-workspace queries. Only when selecting the current workspace can the external index be used. If other workspaces are selected, the external index will not be available.
    2. The log index defaults to `default`, and when selecting multiple workspaces, all default indexes under multiple spaces will be grouped under the same `default` index.
    3. The indexes authorized by cross-workspace are only synchronized and listed within the scope of the authorization.

### Analyze Log Data

**Note**: Cross-workspace index queries **only affect the channel of log data acquisition**, other log analysis functions **are not affected**.

After selecting the workspace and index in the log explorer, you can normally use the original functions of the log explorer, such as search, quick filter, status diagram display, and analysis, etc.

### Delete an Index

If you delete the index `whytest` under "Workspace 1," since this index has been authorized to other spaces, a confirmation prompt will appear when deleting, click **OK** to delete the index.

Once the deletion is confirmed, this change will immediately affect "Workspace 2," and the corresponding index will not be available.

![](img/cross-workspace-index-2.png)

## FAQ

:material-chat-question: After the index of "Workspace 1" is authorized to "Workspace 2," how to cancel the authorization?

Revoking the authorization of the index is divided into the following two cases:

:material-numeric-1-circle: The scope of authorization only includes log data

If only logs are authorized, you can directly click **Delete** in the authorization list to revoke all index item authorizations for "Workspace 2."

![](img/cross-workspace-index-3.png)

:material-numeric-2-circle: The scope of authorization includes other data types

If the scope of authorization includes other data types in addition to logs, you can click **Edit** to remove the log item from the authorization scope.

**Note**:

- After deleting logs from the data scope, the log index input field will also be synchronized and closed.
- After the index is deleted, it is equivalent to deleting the authorization of log data. This means that all log data of "Workspace 1" and "Workspace 2" will not be interconnected, and the log explorer of "Workspace 2" will not be able to select "Workspace 1" when selecting the workspace.

![](img/cross-workspace-index-4.png)


:material-chat-question: How can I query the external index of other workspaces?

First, it needs to be defined that external indexes are bound to the Guance platform from [external channels (SLS Logstore, Elasticsearch, OpenSearch)](./multi-index.md).

So, if you need to use any external index, just bind this external index directly to this workspace. When using it, select the default current workspace in the log explorer and select the corresponding external index for the query.
