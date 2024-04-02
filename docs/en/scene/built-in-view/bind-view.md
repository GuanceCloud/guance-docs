# Bind Inner Views
---

Guance supports custom binding of inner views (user views) to explorers. By associating the inner view with Trace services, applications, log sources, projects, or other custom fields, explorers matching the field values can view the newly bound inner view through the sliding detail page.

**Note**: Explorers that support custom binding of inner views include scene-specific explorers, Infrastructure, Logs, Traces, Services, RUM, Security Check and Synthetic Tests.

## Step Explanation

Go to **Inner Views > User Views > Bind**:

:material-numeric-1-circle: Create binding relationship

You can bind the inner view with the explorer based on trace `service`, `app_id`, log `source`, `project`, `label` or the `key`, `value` within the custom input space; fuzzy matching of `value` is supported.

![](../img/4.view_7.png)

**Note**: To ensure data consistency, when creating a binding relationship between user views and explorers, at least one field in the specified object category must be added as the binding relationship of this inner view, and the system will automatically synchronize the inner view based on this binding relationship.

:material-numeric-2-circle: View the bound inner view in the explorer details

After configuring the binding relationship, you can go to the explorer's sliding detail page that matches the bound field value to view the inner view.

![](../img/4.view_8.png)

:material-numeric-3-circle: Delete the bound inner view in the explorer details

If you need to delete the inner view that has been bound in the explorer details, clear the field content in the **Bind** and click **Confirm**.

<img src="../../img/4.view_4.png" width="60%" >

## Field Explanation

When binding fields in the inner view, in addition to the data range of the following **fixed fields**, it also supports generating binding relationships with the existing fields(`key`), field values(`value`) in the custom input space.

| Field | Data Range |  <div style="width: 150px">Range</div> | Value Range |
| --- | --- | --- | --- |
| `service` | The `service` value in the current workspace Tracing data | <li>Scenes > Explorers<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Traces<br /><li>RUM > Session, View<br /><li>Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Represents matching all services<br />`value`: Represents only matching the corresponding service, supports single value matching, multi-value matching, fuzzy matching, etc. |
| `app_id` | The `app_id` value in the current workspace View data | <li>Scenes > Explorers<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Traces<br /><li>RUM > Session, View<br /><li>Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Represents matching all applications<br />`value`: Represents only matching the corresponding application, supports single value matching, multi-value matching, fuzzy matching, etc. |
| `source` | The `source` value in the current workspace Logging data | <li>Scenes > Explorers<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Traces<br /><li>Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Represents matching all log sources<br />`value`: Represents only matching the corresponding log source, supports single value matching, multi-value matching, fuzzy matching, etc. |
| `project` | The `project` value in the current workspace's Object data | <li>Scenes > Explorers<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Traces<br /><li>RUM > Session, View<br /><li>Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Represents matching all projects<br />`value`: Represents only matching the corresponding project, supports single value matching, multi-value matching, fuzzy matching, etc. |
| `label` | The `label` value in the current workspace's Object data | Infrastructure > All Explorers | `*`: Represents matching all projects<br />`value`: Represents only matching the corresponding label, supports single value matching, multi-value matching, fuzzy matching, etc. |

???+ abstract "Logic of binding field display in explorer details page:"

    :material-numeric-1-circle-outline: The `value` of the bound field supports 4 modes: `*`, single value, multiple values, and fuzzy matching.

    - If the `value` is set to `*`, such as `service:*`, the inner view will be bound to the details page of the explorer where the `service` field exists in any list;
    - If the `value` is set to a "single value", such as `service:value1`, the inner view will be bound to the details page of the explorer where `service=value1` exists in any list;
    - If the `value` is set to "multiple values", such as `service:value1,value2`, the inner view will be bound to the details page of the explorer where `service=value1` or `service=value2` exists in the list data; if there are multiple `key:value`, such as `service:value1` and `source:value2`, the inner view will be bound to the details page of the explorer where `service=value1` or `source=value2` exists in any list;
    - If the `value` is set to `wildcard` for fuzzy matching, then `*Service:` will be displayed. For example, if you set it to `service:*sql`, any field in the list that has `service` and ends with `sql` (for example: `service=mysql`; `service=pymysql`) will bind this inner view on the detail page of the explorer.

    :material-numeric-2-circle-outline: Order of binding field display: `service` > `app_id` > `source` > `project` > `label`, the order of the same fields is not specially treated.

    - If `service = ${value}`, `source = ${value}`, `project = ${value}` match the same inner view, only this inner view is displayed on the explorer detail page
    - If `service = ${value}`, `source = ${value}`, `project = ${value}` match different inner views, the corresponding inner views are displayed in the order of `service` > `source` > `project` on the explorer detail page

    :material-numeric-3-circle-outline: The inner view bound on the explorer details page, the default display time range is "the last 15 minutes", and the time of the current data record will be marked in the graph.

<!--
## <u>Example Explanation (Fixed Fields)</u>

The following takes binding **User View > CPU Monitoring View** to all project explorers as an example.

:material-numeric-1-circle: Create binding relationship

In the Guance workspace **Scene > Inner View > User View**, select **Bind** in the settings, you can see the several field names listed in the table above, for specific introduction please refer to the table above.<br />![](../img/4.view_4.png)<br />Select `project:*` in **Bind**, click **OK**.

![](../img/4.view_5.png)

:material-numeric-2-circle: View the bound inner view in explorer details

2) View the bound inner view on the infrastructure host detail page, the prerequisite is that the host has the "project" tag.<br />![](../img/4.view_bang_4.png)<br />2) View the bound inner view on the log explorer detail page, the prerequisite is that the host has the "project" tag.<br />![](../img/4.view_bang_5.png)

---

## <u>Example Explanation (Custom Key, Value)</u>

The following takes binding **User View > Network Monitoring View** to the host explorer detail page named `guance.local` as an example:

### 1. Create binding relationship

In the Guance workspace **Scene > Inner View > User View**, select **Bind** in the settings, you can create a binding relationship between the current inner view and `host` as `guance.local` with `host:guance.local` as the binding field.

**Note**: When selecting binding fields (custom Key, Value), you need to ensure that the field can accurately match with the explorer object that supports the configuration of the inner view in the current workspace. If the key, value input value workspace does not have, it cannot match the explorer.

![](../img/4.view_10.png)

### 2. View the bound inner view in explorer details

The current binding relationship is `host:guance.local`, you can go to the custom explorer, infrastructure, log, trace, service, rum, security check, synthetic tests explorer that matches the `host:guance.local` field, and view the successfully bound "Network Monitoring View" on the detail page.

The following takes the host explorer detail of `host:guance.local` as an example:

![](../img/4.view_11.png)

-->