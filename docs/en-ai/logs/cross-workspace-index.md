# Cross-Workspace Index Query
---

???+ warning "Note"

    To centrally manage, search, and analyze various [logs](./explorer.md), Guance can collect log data and unify it in the Guance workspace. Through the log Explorer, users can view and search all logs within the workspace, enabling comprehensive log data analysis.

    Additionally, the Guance platform provides [index](./multi-index/index.md) functionality. This defines classification rules for log data, allowing users to save and retrieve logs through different indexes and apply data storage policies as needed, effectively controlling storage costs.

## Why Is Cross-Workspace Index Retrieval Necessary?

:material-numeric-1-circle: Feature Characteristics:

From the previous section, it is clear that both logs and indexes are associated with the **specific workspace** they belong to. Logs are **stored within the workspace**, and indexes are **special classification and storage rules created for the logs within that space**.

:material-numeric-2-circle: Business Challenges:

To meet requirements such as cost allocation for each team or control of data resource permissions, enterprises often create multiple workspaces on Guance for data management. While this model achieves data management by department, it is not conducive to global data analysis.

:material-numeric-3-circle: Necessity of Cross-Workspace Index Retrieval:

To enable global data analysis under distributed data management, Guance provides cross-workspace query functionality, which allows access to log data from other workspaces.

Specifically, since logs are categorized by index, granting index data from "Workspace 1" to "Workspace 2" enables the log Explorer in "Workspace 2" to access the indexes from "Workspace 1," thereby viewing the corresponding log data under those indexes.

This feature overcomes the limitations of log data storage locations, significantly improving the efficiency of data analysis and incident localization.

![](img/cross-workspace-index-6.png)

## Getting Started

> Scenario Example: If index data from "Workspace 1" is granted to "Workspace 2," for "Workspace 2," the available indexes fall into two categories:

- [Original indexes of the current workspace](#original);
- [Indexes authorized from other workspaces](#others).

### Querying Original Indexes of the Current Workspace {#original}

Enter the log Explorer of "Workspace 2." The "Workspace" dropdown in the top-left corner defaults to the current workspace.

The quick filter on the left lists all available original indexes of the current workspace, including: default index, log index, and external index.

**Note**: External indexes are single-select only.

<img src="../img/cross-workspace-index.png" width="70%" >

### Querying Indexes Authorized from Other Workspaces {#others}

> To allow "Workspace 2" to use indexes from "Workspace 1," cross-workspace index authorization involves two steps:

1. Authorize specific log items and indexes in the workspace to be shared (e.g., "Workspace 1");
2. Enter the authorized workspace (e.g., "Workspace 2") and select the indexes to apply.

> For detailed operation instructions, refer to [Cross-Workspace Authorization](../management/data-authorization.md#site).

Once these two steps are completed, "Workspace 1" has granted index access to "Workspace 2." Now enter the authorized workspace---**"Workspace 2" > Log Explorer**.

#### Selecting a Workspace

Click the **Workspace** dropdown to view all selectable workspaces. This supports single or multi-selection.

???+ warning "Note"

    1. The list of selectable workspaces only includes those that meet three conditions: belonging to the same cluster; having completed authorization operations; and including log data in the authorized data scope.
    2. Selecting a single workspace will display its name directly in the workspace bar. When selecting multiple workspaces, it will show "n items selected," and you can view specific options by clicking.

![](img/cross-workspace-index-1.png)

#### Selecting an Index

After selecting a workspace, the indexes within that workspace will be listed in the **Quick Filter** area:

???+ warning "Note"

    1. External indexes do not support cross-workspace queries. They are only available when selecting the current workspace. If another workspace is selected, external indexes will not be usable.
    2. By default, log indexes select `default`. When multiple workspaces are selected, all default indexes from multiple workspaces will be grouped under the same `default` index.
    3. Only indexes within the authorized range will be listed for cross-workspace authorized indexes.

### Analyzing Log Data

**Note**: Cross-workspace index queries **only affect the channels through which log data is obtained**; other log analysis functions **remain unaffected**.

After selecting the workspace and indexes in the log Explorer, you can continue using the existing features of the log Explorer, such as search, quick filters, status chart displays, and analysis.

### Deleting an Index

If deleting the index `whytest` in Workspace 1, which has been authorized to other spaces, a confirmation prompt will appear when attempting to delete it. Click **Confirm** to proceed with the deletion.

Once confirmed, this change will immediately affect "Workspace 2," making the corresponding index unavailable.

![](img/cross-workspace-index-2.png)