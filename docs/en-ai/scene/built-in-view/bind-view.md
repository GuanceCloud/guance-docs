# Bind Built-in Views
---

Guance supports custom binding of built-in views (user views) to Explorers. By associating built-in views with link services, applications, log sources, projects, or other custom fields, matching field values in the Explorer can be viewed through a side panel to see the newly bound built-in views.

**Note**: The Explorers that support custom binding of built-in views include scenario custom Explorers, infrastructure, logs, traces, services, RUM, Security Check, Synthetic Tests.


## Start Binding {#bind}

Go to **Built-in Views > User Views > Bind**:

1. Create Binding Relationships

You can bind built-in views to Explorers based on link services (`service`), applications (`app_id`), log sources (`source`), projects (`project`), labels (`label`), or custom input space `key`, `value`; fuzzy matching for `value` is supported.

![Image](../../img/4.view_7.png)

**Note**: To ensure data consistency, when creating a binding relationship between user views and Explorers, you must **add at least one field from the specified object classification as the binding relationship for this built-in view**. The system will automatically synchronize the built-in view based on this binding relationship.

2. View Bound Built-in Views in Explorer Details

After configuring the binding relationship, you can go to the side panel details page of the Explorer that matches the bound field value to view the bound built-in view.

![Image](../img/4.view_8.png)

3. Remove Bound Built-in Views from Explorer Details

If you need to remove the bound built-in view from the Explorer details, clear the field content in **Bind**, and click **Confirm**.

![Image](../../img/4.view_4.png)


## Field Description

When binding built-in views, in addition to the following **fixed fields** data ranges, users can also use **existing fields (`key`) and field values (`value`) within the custom input space** to generate binding relationships.

| **Field Name** | **Data Range** | **Adaptation Scope** | **Value Range** |
| --- | --- | --- | --- |
| `service`<br /> | `service` values in current workspace Tracing data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>RUM > Session, View<br />Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Matches all services<br />`value`: Matches only the corresponding service, supporting single-value matching, multi-value matching, fuzzy matching, etc. |
| `app_id`<br /> | `app_id` values in current workspace View data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>RUM > Session, View<br />Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Matches all applications<br />`value`: Matches only the corresponding application, supporting single-value matching, multi-value matching, fuzzy matching, etc. |
| `source`<br /> | `source` values in current workspace Logging data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Matches all log sources<br />`value`: Matches only the corresponding log source, supporting single-value matching, multi-value matching, fuzzy matching, etc. |
| `project`<br /> | `project` values in current workspace Object data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>RUM > Session, View<br />Security Check Explorer<br /><li>Synthetic Tests Explorer | `*`: Matches all projects<br />`value`: Matches only the corresponding project, supporting single-value matching, multi-value matching, fuzzy matching, etc. |
| `label` | `label` values in current workspace Object data | Infrastructure > All Explorers | `*`: Matches all projects<br />`value`: Matches only the corresponding label, supporting single-value matching, multi-value matching, fuzzy matching, etc. |

???+ abstract "Explanation of how bound fields appear in Explorer details:"

    1) The `value` of the bound field supports 4 modes: `*`, single value, multiple values, and wildcard matching.

    - If the `value` is set to `*`, such as `service:*`, all Explorer detail pages containing the `service` field will bind to this built-in view;
    - If the `value` is set to a "single value", such as `service:value1`, all Explorer detail pages containing `service=value1` will bind to this built-in view;
    - If the `value` is set to "multiple values", such as `service:value1,value2`, all Explorer detail pages containing `service=value1` or `service=value2` will bind to this built-in view; if there are multiple `key:value` pairs, such as `Service:value1`, `source:value2`, all Explorer detail pages containing `service=value1` or `source=value2` will bind to this built-in view;
    - If the `value` is set to `wildcard` matching, it will display as `*Service:`. For example, `*service:*sql` will bind to all Explorer detail pages containing `service` ending with `sql` (e.g., `service=mysql`, `service=pymysql`).

    2) Display order of bound fields: `service` > `app_id` > `source` > `project` > `label`. The order of identical fields is not specially handled.

    - If `service = ${value}`, `source = ${value}`, `project = ${value}` match the same built-in view, only this built-in view will be displayed in the Explorer detail page;
    - If `service = ${value}`, `source = ${value}`, `project = ${value}` match different built-in views, the corresponding built-in views will be displayed in the order `service` > `source` > `project`.

    3) In the Explorer detail page, the default time range for the bound built-in view is "last 15 minutes," and it will annotate the current data record time on the chart.

<!--
## <u>Example Explanation (Fixed Fields)</u>

Below is an example of binding **User View > CPU Monitoring View** to all project Explorers.

### 1. Create Binding Relationship

In the Guance workspace **Scenario > Built-in Views > User Views**, select **Bind** under settings, and you will see several field names listed in the table above. Refer to the table for specific descriptions.

![Image](../img/4.view_4.png)

Select `project:*` in **Bind**, and click **Confirm**.

![Image](../img/4.view_5.png)

### 2. View Bound Built-in Views in Explorer Details

1) View the bound built-in view in the Infrastructure Host Detail Page, provided the host has a "project" label.

![Image](../img/4.view_bang_4.png)

2) View the bound built-in view in the Log Explorer Detail Page, provided the host has a "project" label.

![Image](../img/4.view_bang_5.png)


---

## <u>Example Explanation (Custom Key, Value)</u>

Below is an example of binding **User View > Network Monitoring View** to the host explorer detail page where the hostname is `guance.local`:

### 1. Create Binding Relationship

In the Guance workspace **Scenario > Built-in Views > User Views**, select **Bind** under settings, and create a binding relationship between the current built-in view and hosts with `host:guance.local`.

**Note**: When selecting binding fields (custom Key, Value), ensure that the field can accurately match the Explorer objects that support configuring built-in views within the current workspace. If the Key, Value does not exist in the workspace, no matching Explorer will be found.

![Image](../img/4.view_10.png)

### 2. View Bound Built-in Views in Explorer Details

With the binding relationship `host:guance.local`, you can visit the custom Explorer, infrastructure, logs, traces, services, RUM, Security Check, Synthetic Tests, and view the successfully bound "Network Monitoring View" in the detail page.

The following image shows the host Explorer detail page for `host:guance.local`:

![Image](../img/4.view_11.png)

-->