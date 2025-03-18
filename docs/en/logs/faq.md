# FAQs


:material-chat-question: How do I confirm successful authorization in the Alibaba Cloud marketplace when binding an SLS Logstore index?

You can click **RAM Console** on the authorization request page;

![](img/index-4.png)

Under **Roles**, you can view the roles that have been authorized; under **Authorization**, you can view the authorized entities and permission policies.

![](img/index-role.png)

![](img/index-auth.png)

---

:material-chat-question: Why can't I automatically retrieve Project and Logstore after entering the Alibaba Cloud account ID when binding an SLS Logstore index?

**Only if your Alibaba Cloud account has activated SLS Log Service and completed authorization** will it automatically retrieve Project and Logstore.

**Note**: Projects with the prefix `/guance-wksp-` are automatically filtered out and not listed; if your Project does not contain any Logstores, they will not be automatically retrieved.

---

:material-chat-question: After authorizing an index from Workspace 1 to Workspace 2, how do I revoke the authorization?

Revoking index authorization falls into two scenarios:

:material-numeric-1-circle: Authorization scope includes only log data

If only logs are authorized, you can directly click **Delete** in the authorization list to revoke all index item authorizations for "Workspace 2".

![](img/cross-workspace-index-3.png)

:material-numeric-2-circle: Authorization scope includes other data types

If the authorization scope includes data types other than logs, you can click **Edit** to remove the log items from the authorization scope.

**Note**:

- After removing logs from the data scope, the log index input field will also be disabled.
- After deleting the index, it means revoking the authorization of log data. This implies that all log data from "Workspace 1" will not be accessible in "Workspace 2", and "Workspace 2" will not be able to select "Workspace 1" when choosing a workspace in the log Explorer.

![](img/cross-workspace-index-4.png)

---

:material-chat-question: The operation of authorizing the index is normal, but the index cannot be queried in the log Explorer of the authorized workspace.

1. Go to **Authorized Workspace > Logs > Index**, confirm whether this index status is normal or has been deleted.

2. Enter the authorized workspace, click **Manage > Cross-Workspace Authorization**, and check if the index authorization is normal.

**Note**: Deleted indexes cannot be referenced in cross-workspace queries.

---

:material-chat-question: How do I query external log indexes from other workspaces?

1. Clarify that external indexes are bound from [external sources (SLS Logstore, Elasticsearch, OpenSearch)](./multi-index/index.md) to the <<< custom_key.brand_name >>> platform.

2. Therefore, to use any external index, bind it directly to the current workspace. When using it, choose the default current workspace in the log Explorer and select the corresponding external index for querying.