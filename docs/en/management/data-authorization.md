# Data Authorization Management
---

Guance supports authorization viewing and desensitization of data, and realizes the management of data viewing of workspace members with different permissions.


## Sensitive Field Masking

After the data collection is reported to Guance workspace, there are some sensitive information fields in some data, such as IP address and user information, which can be desensitized by configuring sensitive fields.

Note:

- Different data types, you can customize and configure sensitive fields under this data (field names are case sensitive). Data types include: Log, Base Object, Custom Object, Event, Application Performance, User Access, Security Patrol, Network, Profile.
- After the field configuration is desensitized, the string type field data returns to display "***" and the number type field data returns to display "-1".
- Configuring sensitive fields supports only members of Guance Workspace administrator and above, and standard and read-only members only support viewing configured sensitive fields.
- When sensitive fields are configured, only administrator and above members in the current workspace can view the original data, and standard and read-only members cannot view the pre-desensitization information in the corresponding viewer or chart.

### Configure Sensitive Fields

In Guance workspace, click "Management"-"Data Rights Management", and click "Configure" in "Sensitive Field Masking" to add sensitive fields.

After selecting the corresponding data type, enter the fields to be desensitized in the input box, click "Add", and click "Finish" to view the configured sensitive fields, such as "host_ip". If you need to delete a sensitive field that has been configured, click "Configure" and then click the "Delete" icon on the right side of the field again.

![](img/2.field_1.png)

After the configuration of sensitive fields is completed, you can control their effectiveness by enabling/disabling them.

![](img/2.field_2.gif)

### View Desensitization Effect


#### View Desensitization Effect in Log Explorer

After Data Authorization Management has configured the sensitive field "host_ip" for log data, the standard and read-only workspace members can only see "host_ip" after desensitization in the log explorer.

![](img/3.data_7.png)


#### View Desensitization Effect in the Scene

After Data Authorization Management has configured the sensitive field "host_ip" for log data, the standard and read-only workspace members can only see the desensitized "host_ip" in the log flow diagram of the Scenario Dashboard.

![](img/3.data_8.png)

## Data Authorization

Guance is based on the workspace, and the data in each workspace are independent of each other, which ensures the security of the data. At the same time, Guance supports the way of data authorization, authorizes the data of multiple workspaces to the current workspace, and queries and displays them through the scene dashboard and the chart components of notes. If you have multiple workspaces, configure data authorization to view data for all workspaces in one workspace.

Note: Data authorization supports multiple workspaces in one site to authorize to view data. Accounts and data between different sites are independent of each other, so it is impossible to use data authorization to view data in workspaces of different sites.

### Get Workspace ID

Before adding data authorization, you need to confirm which workspace's data is authorized to which workspace to view. Let's assume a scenario where data from Workspace A (e.g. Development ******) needs to be delegated to Workspace B (e.g. DataFlux) for viewing.

In Guance workspace B (such as DataFlux), click "Administration"-"Basic Settings"-"Workspace ID" and click "Copy" to obtain the ID of the current workspace.

![](img/9.dataauth_11.png)


### Add Data Authorization

In Guance workspace a (such as developing ******), click "Management"-"Data Rights Management", and click "Configuration" in "Data Authorization" to add data authorization.

![](img/3.data_1.png)

Paste the copied workspace ID in the input box, click Add, and click Finish.

![](img/3.data_3.png)

After the addition is complete, you can view Workspace B (e.g. DataFlux) that has been authorized to view current Workspace A (e.g. developing ******) data in the Authorization List.

![](img/3.data_1.png)

If you need to delete the data authorization, you can click "Configure", select the workspace to be deleted, and click the "Delete" icon on the right side.

![](img/3.data_2.png)


### Data Sharing Query and Analysis

After Workspace B (e.g. DataFlux) gets data authorization, you can open Scene-「[Dashboard](../scene/dashboard.md) or「[Notes](../scene/note.md)」select the Chart component, select Workspace A (e.g. Development ******) authorized to view in Workspace of Settings, and then view and analyze the data of authorized Workspace A (e.g. Development ******) through [chart query](../scene/visual-chart/chart-query.md).

![](img/9.dataauth_7.png)

**Scenario Dashboard Sample Description:**

The above three charts with data display query the data of authorized workspace a (such as development ******); The following three charts with no data presentation are querying the current workspace B (e.g. DataFlux), which shows no data because there is no data in that workspace.

![](img/9.dataauth_8.png)


### Mail Notification

When a data authorization is added, the owner and administrator of the corresponding workspace are notified of the Add Authorization email.

![](img/9.dataauth_9.png)

Delete the data authorization, and the owner and administrator of the corresponding workspace will be notified of the Delete Authorization email.

![](img/9.dataauth_10.png)

### Audit Events

Adding and deleting data authorizations will generate audit events.

![](img/9.dataauth_12.png)

In Guance workspace, click "Management"-"Basic Settings"-"Security-Operation Audit" and click "View" to view all audit events in the current workspace.

![](img/9.dataauth_11.png)





