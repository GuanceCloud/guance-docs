# Bind Built-in Views
---

<<< custom_key.brand_name >>> supports custom binding of built-in views (user views) to Explorers. By associating built-in views with link services, applications, log sources, projects, or other custom fields, the Explorers that match the field values can display the newly bound built-in views in the side-sliding detail page.

**Note**: The Explorers that support custom binding of built-in views include scenario custom Explorers, infrastructure, logs, traces, services, user access, security checks, and synthetic tests.


## Start Binding {#bind}

Enter **Built-in Views > User Views > Bind**:

1. Create Binding Relationship

You can bind built-in views to Explorers based on link service (`service`), application (`app_id`), log source (`source`), project (`project`), label (`label`), or by entering custom `key`, `value` pairs within the input space; fuzzy matching for `value` is supported.

<img src="../../img/4.view_7.png" width="60%" >

**Note**: To ensure data consistency, when creating a binding relationship between user views and Explorers, you must **add at least one field from the specified object classification as the binding relationship for this built-in view**. The system will automatically synchronize the built-in view based on this binding relationship.

2. View Bound Built-in Views in Explorer Details

After configuring the binding relationship, you can check the bound built-in view on the side-sliding detail page of the Explorer that matches the binding field value.

![](../img/4.view_8.png)


3. Remove Bound Built-in Views from Explorer Details

If you need to remove the bound built-in view from the Explorer details, clear the field content in **Bind**, then click **Confirm**.

<img src="../../img/4.view_4.png" width="60%" >


## Field Description

When binding built-in views, in addition to the following **fixed fields**, users can also generate binding relationships using **existing fields (`key`) and field values (`value`) within the custom input space**.

| **Field Name** | **Data Scope** | **Adaptation Scope** | **Value Range** |
| --- | --- | --- | --- |
| `service`<br /> | `service` values in the current workspace Tracing data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>RUM > Session, View<br />Security Check Explorer<br /><li>Synthetic Test Explorer | `*`: Matches all services<br />`value`: Matches specific services, supporting single-value, multi-value, and fuzzy matching |
| `app_id`<br /> | `app_id` values in the current workspace View data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>RUM > Session, View<br />Security Check Explorer<br /><li>Synthetic Test Explorer | `*`: Matches all applications<br />`value`: Matches specific applications, supporting single-value, multi-value, and fuzzy matching |
| `source`<br /> | `source` values in the current workspace Logging data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>Security Check Explorer<br /><li>Synthetic Test Explorer | `*`: Matches all log sources<br />`value`: Matches specific log sources, supporting single-value, multi-value, and fuzzy matching |
| `project`<br /> | `project` values in the current workspace Object data | <li>Scenario > Custom Explorer<br /><li>Infrastructure > All Explorers<br /><li>Log Explorer<br /><li>Trace Explorer<br /><li>RUM > Session, View<br />Security Check Explorer<br /><li>Synthetic Test Explorer | `*`: Matches all projects<br />`value`: Matches specific projects, supporting single-value, multi-value, and fuzzy matching |
| `label` | `label` values in the current workspace Object data | Infrastructure > All Explorers | `*`: Matches all labels<br />`value`: Matches specific labels, supporting single-value, multi-value, and fuzzy matching |

???+ abstract "Explanation of how bound fields are displayed in Explorer details:"

    1) The `value` of bound fields supports four modes: `*`, single value, multiple values, and fuzzy matching.

    - If `value` is set to `*`, such as `service:*`, the built-in view will be bound to the details pages of all Explorers that have the `service` field;
    - If `value` is set to a "single value", such as `service:value1`, the built-in view will be bound to the details pages of all Explorers where `service=value1`;
    - If `value` is set to "multiple values", such as `service:value1,value2`, the built-in view will be bound to the details pages of all Explorers where `service=value1` or `service=value2`. If multiple `key:value` pairs are used, such as `Service:value1` and `source:value2`, the built-in view will be bound to the details pages of all Explorers where `service=value1` or `source=value2`;
    - If `value` is set to `wildcard` for fuzzy matching, it displays as `*Service:`. For example, `*service:*sql` binds the built-in view to the details pages of all Explorers where `service` ends with `sql` (e.g., `service=mysql`; `service=pymysql`).

    2) Display order of bound fields: `service` > `app_id` > `source` > `project` > `label`. The order of identical fields is not specially handled.

    - If `service = ${value}`, `source = ${value}`, and `project = ${value}` match the same built-in view, only this built-in view is displayed on the Explorer details page.
    - If `service = ${value}`, `source = ${value}`, and `project = ${value}` match different built-in views, the corresponding built-in views are displayed on the Explorer details page in the order `service` > `source` > `project`.

    3) Built-in views bound on the Explorer details page default to displaying the time range "Last 15 Minutes" and annotate the current data record's time on the chart.

<!--
## <u>Example Explanation (Fixed Fields)</u>

Below is an example of binding **User View > CPU Monitoring View** to all Explorers that match any project.

### 1. Create Binding Relationship

In <<< custom_key.brand_name >>> workspace **Scenario > Built-in Views > User Views**, under settings choose **Bind**, and you will see several field names listed in the table above. Refer to the table for more information.

![](../img/4.view_4.png)

In **Bind**, select `project:*` and click **Confirm**.

![](../img/4.view_5.png)

### 2. View Bound Built-in View in Explorer Details

1) View the bound built-in view on the infrastructure host details page, provided the host has the "project" tag.

![](../img/4.view_bang_4.png)

2) View the bound built-in view on the log Explorer details page, provided the host has the "project" tag.

![](../img/4.view_bang_5.png)


---


## <u>Example Explanation (Custom Key, Value)</u>

Below is an example of binding **User View > Network Monitoring View** to the host explorer details page for the hostname `guance.local`:

### 1. Create Binding Relationship

In <<< custom_key.brand_name >>> workspace **Scenario > Built-in Views > User Views**, under settings choose **Bind** to create a binding relationship between the current built-in view and `host` equal to `guance.local`.

**Note**: When selecting binding fields (custom Key, Value), ensure that the field can accurately match supported Explorers within the current workspace. If the Key or Value does not exist in the workspace, no match will occur.

![](../img/4.view_10.png)


### 2. View Bound Built-in View in Explorer Details

With the current binding relationship `host:guance.local`, you can visit the custom Explorer, infrastructure, log, trace, service, user access, security check, and synthetic test Explorers that match `host:guance.local` to view the successfully bound "Network Monitoring View".

The following image shows the host Explorer details for `host:guance.local`:

![](../img/4.view_11.png)

-->