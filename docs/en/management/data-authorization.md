# Data Rights Management

---

Guance supports authorization viewing and desensitization of data and realizes the management of data viewing of workspace members with different permissions.


## Data Masking {#data-mask}

After the data is collected and reported to the Guance workspace, there are certain sensitive information fields in some of the data, such as IP addresses and user information. For these information, you can perform data desensitization by configuring sensitive fields.

???+ warning

    - Different data types can have their sensitive fields customized (field names are case-sensitive). The data types include: Logs, Infrastructure, Custom Object, Event, Application Performance, User Access, Security Check, Network, Profile.
    - After configuring field desensitization, the data of string type fields will be displayed as "***".
    - Only the selected member roles that have been designated to view the original data can see the desensitized information. Other members will not be able to view the sensitive information in the corresponding explorer or chart.

### Add Rule

Click **Management > Data Rights Management > Data Masking**, click **Add Rule** to start adding sensitive fields.

Enter the name of the current desensitization rule, select the corresponding data type, and enter the fields that need to be desensitized.

![](img/2.field_1.png)

To configure desensitization for field values using regular expressions, you can write regular expressions based on the syntax rules. Currently, you can choose from the [template library](../dql/regex.md) or provide custom input. Click on **Preview**, enter the original text, and click on **Confirm** to see the desensitized result.

As shown in the image, Guance will match the results based on the regular expression on the left and desensitize the matched results with `***`.

<img src="../img/token-mask.png" width="70%" >

You can configure sensitive data masking rules **based on role level** by selecting the roles that need to be distributed. Multiple selections are supported.

Click on **Confirm** to view the configured sensitive fields, such as `host_ip`.

<!--
### View Desensitization Effect


#### View Desensitization Effect in Log Explorer

After **Data Authorization Management** has configured the sensitive field "host_ip" for log data, the standard and read-only workspace members can only see "host_ip" after desensitization in the log explorer.

![](img/3.data_7.png)


#### View Desensitization Effect in the Scene

After **Data Authorization Management** has configured the sensitive field "host_ip" for log data, the standard and read-only workspace members can only see the desensitized "host_ip" in the log flow diagram of the **Scene > Dashboard**.

![](img/3.data_8.png)
-->

### Rule List

![](img/2.field_2.png)

- Search: In the search bar on the right side of the page, you can directly enter the rule name for searching.
- Edit: Click to modify the current rule.
- Delete: If you don't need the current rule, click to delete it.
- Batch operations: In the rule list, you can enable, disable, or delete specific rules in bulk.

## Data Authorization {#data-authorization}

Guance organizes data based on workspaces, with each workspace containing independent data to ensure data security. Additionally, Guance supports cross-workspace data authorization, **allowing data from multiple workspaces to be authorized and accessed in the current workspace** for querying and display purposes using dashboard and chart components. If you have multiple workspaces, after configuring data authorization, you can view data from all workspaces in one workspace.

Furthermore, considering that users may have multiple workspaces in different sites of Guance, in order to meet the user's need to query data from all workspaces in one workspace, Guance supports **authorization for querying cross-workspace data within the same site**.

### Add Authorization {#site}

Enter **Management > Data Rights Management > Data Authorization > Shared**, click on **Add Authorization**:

![](img/management-data-1.png)

:material-numeric-1-circle-outline: Select the site:

The following site options are provided by default: CN1 (Hangzhou), CN2 (Ningxia), CN3 (Zhangjiakou), CN4 (Guangzhou), CN5 (Century Interconnect), CN6 (Hong Kong), US1 (Oregon), EU1 (Frankfurt), AP1 (Singapore).

You can also support manual input configuration (SaaS version only), in the format of the corresponding site's domain name address, for example: https://cn3-auth.guance.com/. To ensure the authorization takes effect, please enter a site URL that can be accessed publicly.

:material-numeric-2-circle-outline: Enter the workspace ID:

Let's assume a case where we need to authorize the data from workspace A to be viewed by workspace B (e.g. DataFlux).

In the Guance workspace B (e.g. DataFlux), click **Management > Settings > Workspace ID**, click **Copy** to obtain its ID.

<img src="../img/9.dataauth_11.png" width="70%" >

:material-numeric-3-circle-outline: Select the role: You can select any role in the current workspace except for "Owner". When the authorized workspace views the data, the data access permissions will be assigned based on the selected role's scope.

For example, if workspace A has Role 1 and Role 2, and you authorize workspace B with the data viewing permissions of workspace A and specify the permissions scope under Role 1 and Role 2, then when members of workspace B query data from workspace A, the data listing and desensitization will be performed based on the data access scope assigned to these two roles in workspace A.


After adding, you can view the authorized workspace B (e.g. DataFlux) that has permission to view the data of the current workspace A in the Authorization List.

![](img/3.data_1.png)

If you need to revoke the data authorization for a certain workspace, you can click **Delete** on the right or select **Bulk Delete**.

![](img/3.data_2.png)


### Data Linkage

After workspace B (e.g. DataFlux) is granted data authorization, you can open **Scenes > [Dashboard](../scene/dashboard.md)** or **[Note](../scene/note.md)**, select a chart component, and in the **Advanced Settings > Data Authorize**, choose the authorized workspace A (e.g. Development-----), and then you can use **[Chart Query](../scene/visual-chart/chart-query.md)** to view and analyze the data of the authorized workspace A (e.g. Development-----).

![](img/9.dataauth_7.png)


### Mail Notification

When data authorization is added or deleted, the owners and administrators of the corresponding workspace will receive email notifications.

<!--
![](img/9.dataauth_9.png)

Delete the data authorization, and the owner and administrator of the corresponding workspace will be notified of the **Delete Authorization Email**.

![](img/9.dataauth_10.png)
-->

### Audit Events

Both adding and deleting data will generate audit events. To view all the audit events for the current workspace, go to **Management > Basic Settings > Security > Operation Audit** and click **View** for all audit events in the current workspace.






