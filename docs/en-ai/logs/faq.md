# Frequently Asked Questions

:material-chat-question: How do you confirm successful authorization on Alibaba Cloud Market when binding SLS Logstore indexes?

You can click **Go to RAM Console** on the authorization request page;

![](img/index-4.png)

In **Roles**, you can view the roles that have been authorized; in **Authorization**, you can view the authorized entities and permission policies.

![](img/index-role.png)

![](img/index-auth.png)

---

:material-chat-question: Why, after entering the Alibaba Cloud account ID, are Project and Logstore not automatically retrieved when binding SLS Logstore indexes?

**Only if your Alibaba Cloud account has activated the SLS log service and completed authorization** will Project and Logstore be automatically retrieved.

**Note**: Projects with the prefix `/guance-wksp-` will be automatically filtered out and not listed; if a Project does not have any associated Logstores, it will not be automatically retrieved.

---

:material-chat-question: After authorizing indexes from Workspace 1 to Workspace 2, how do you revoke this authorization?

Revoking index authorization falls into two scenarios:

:material-numeric-1-circle: Authorization scope is limited to log data only

If only logs are authorized, you can directly click **Delete** in the authorization list to revoke all index item authorizations for "Workspace 2".

![](img/cross-workspace-index-3.png)

:material-numeric-2-circle: Authorization scope includes other data types

If the authorization scope includes data types other than logs, you can click **Edit** to remove log items from the authorization scope.

**Note**:

- After removing logs from the data scope, the log index input field will also be disabled.
- Once indexes are deleted, it means the authorization of log data is revoked. This implies that all log data from "Workspace 1" will not be accessible by "Workspace 2", and "Workspace 2" will not be able to select "Workspace 1" when choosing workspaces in the log Explorer.

![](img/cross-workspace-index-4.png)

---

:material-chat-question: The operation of authorizing indexes is normal, but the authorized workspace's log Explorer cannot query this index.

1. Go to **Authorized Workspace > Logs > Indexes** and confirm whether the index status is normal or if it has been deleted.

2. Enter the authorized workspace, click **Management > Cross-Workspace Authorization**, and check if the index authorization is normal.

**Note**: Deleted indexes cannot be referenced in cross-workspace queries.

---

:material-chat-question: How do you query external log indexes from other workspaces?

1. You need to clarify that external indexes are bound from [external sources (SLS Logstore, Elasticsearch, OpenSearch)](./multi-index/index.md) to the Guance platform.

2. Therefore, to use which external index, simply bind it to your current workspace. When using it, select the default current workspace in the log Explorer and choose the corresponding external index for querying.