# Binding Built-in Views
---

## Introduction

"Guance" supports custom binding of built-in views (user views) to explorers. By associating binding of built-in views with link services, applications, log sources, projects, or other custom fields, explorers that match the field values can view the newly bound built-in views via the side-sliding detail page.

???+ note

    Explorers that support custom binding of built-in views include scenario custom explorers, infrastructure, logs, links, services, user access, security patrol, and availability.


## Step by step instructions

In 「Built-in View」 - 「User View」, you can create a binding relationship between the user view and the explorer by "Binding Field".

### 1.Creating Binding Relationships

In the 「Built-in View」 - 「User View」 of Guance Workspace, select "Bindings" under "Settings", you can bind the built-in view to the explorer based on the key and value in the link service, app_id, source, project, label, or custom input space. project, label, or custom input space. Fuzzy matching of values is supported.

![](../img/4.view_7.png)

Note: To ensure data consistency, when creating the binding relationship between user view and explorer, you need to **add at least one field under the specified object category as the binding relationship** for this built-in view, and the system will automatically synchronize the built-in view based on this binding relationship.

### 2.View the built-in view of the binding in the explorer details

Once you have configured the binding relationship, you can go to the explorer side-slide details page of the matching binding field value to view this built-in view.

![](../img/4.view_8.png)


### 3.Delete the bound built-in view of the explorer details

If you need to delete the bound built-in views in the explorer details, select "Bind" under Settings, clear the fields in "Bind", and click "OK" to delete the bound built-in views in the explorer details.

![](../img/4.view_4.png)


---

## Field Description

When binding fields in the built-in view, in addition to the following **fixed fields** data range, it also supports the user to **define the existing fields (Key) and field values (Value)** in the input space to generate binding relationships.

| **Field Name** | **Data Range** | **Scope of Adaptation** | **Numerical range** |
| --- | --- | --- | --- |
| `service`<br />(Link Services) | Service values in the current workspace Tracing (user performance monitoring) data | Scene - Custom Explorer<br />Infrastructure - All Explorers<br />Log Explorer<br />Link explorer<br />User Access-session、view Explorers<br />Safety patrol explorer<br />Availability explorer | ``*``：Indicates matching all services<br />``value``：Indicates that only the corresponding service is matched, and supports single-value matching, multi-value matching, fuzzy matching and other methods |
| `app_id`<br />(Applications) | The app_id value in the current workspace Rum-View (user access monitoring) data | Scene - Custom Explorer<br />Infrastructure - All Explorers<br />Log Explorer<br />Link explorer<br />User Access-session、view Explorers<br />Safety patrol explorer<br />Availability explorer | ``*``：Indicates matching all applications<br />``value``：Indicates that only the corresponding application is matched, and supports single-value matching, multi-value matching, fuzzy matching and other methods |
| `source`<br />(Log source) | The source value in the current workspace Logging（Log）data | Scene - Custom Explorer<br />Infrastructure - All Explorers<br />Log Explorer<br />Link explorer<br />Safety patrol explorer<br />Availability explorer | ``*``：Indicates matching all log sources<br />``value``：Indicates that only the corresponding log source is matched, and supports single-value matching, multi-value matching, fuzzy matching and other methods |
| `project`<br />(Projects) | The project value in the current workspace's Object (infrastructure) data | Scene - Custom Explorer<br />Infrastructure - All Explorers<br />Log Explorer<br />Link explorer<br />User Access-session、view Explorers<br />Safety patrol explorer<br />Availability explorer | ``*``：means match all items<br />``value``：Indicates that only the corresponding item is matched, and supports single-value matching, multi-value matching, fuzzy matching and other methods |
| `label` | The label value in the current workspace's Object (infrastructure) data | Infrastructure - All Explorers | ``*``：means match all items<br />``value``：It supports single-value matching, multi-value matching, fuzzy matching and other methods. |

**Description of the display logic on the explorer details page after binding the fields：**<br />1）The value of the bound field supports `*`, single value, multiple value, and fuzzy match 4 modes.

- If `*` is selected for value, e.g. `Service:*` is configured: all explorer detail pages with Service field in the list are bound to this built-in view
- If value is selected as "single value", e.g. if `Service:value1` is configured, all explorer detail pages with service=value1 in the list will be bound to this built-in view
- If value value is selected as "multiple values", such as configure `Service:value1,value2`, all the explorer detail pages with service=value1 or service=value2 in the list data will be bound to this built-in view; if there are multiple key: value, such as `Service:value1` , `source:value2` , all the explorer detail pages with service=value1 or source=value2 in the list data are bound to this built-in view.
- If `wildcard` is selected for the value, `*Service:` is displayed, e.g., if `*service:*sql` is configured: all explorer detail pages with Service=fields ending in `sql` (e.g., service=mysql; service=pymysql) in the list are bound to this built-in view

2）Binding field display order: service>app_id>source>project>label, the order of the same field does not do special treatment.

- If service = ${value}, source = ${value}, project = ${value} match the same built-in view, only this built-in view will be displayed in the explorer details page
- If service = ${value}, source = ${value}, project = ${value} match different built-in views, the corresponding built-in views are displayed in the explorer details page in the order Service>Source>Project
3）If service = ${value}, source = ${value}, project = ${value} match different built-in views, the corresponding built-in views are displayed in the explorer details page in the order Service>Source>Project
---

## Example description (fixed field)

Here is an example of binding the "User View - CPU Monitor View" to a explorer that matches all items.

### 1.Creating Binding Relationships

In the Guance Workspace 「Scene」 - 「Built-in View」 - 「User View」, select "Bindings" under Settings, you can see several field names listed in the table above, please refer to the table above for details.<br />![](../img/4.view_4.png)<br />Select `project:*` in "Bindings" and click "OK"。<br />![](../img/4.view_5.png)

### 2.View the built-in view of the binding in the explorer details
1）View the built-in view of the binding on the infrastructure host details page, provided that the host has the "project" tab.<br />![](../img/4.view_bang_4.png)<br />2）View the built-in view of the binding in the log explorer details page, provided the host has the "project" tab.<br />![](../img/4.view_bang_5.png)


---


## Example description (Custom Key, Value)

The following is an example of binding the "User View - Network Monitor View" to the host explorer details page with the host name guance.local.

### 1.Creating Binding Relationships

In Guance Workspace 「 Scene」 - 「Built-in View」 - 「User View」, select "Bind" under Settings, then you can create a binding relationship between the current built-in view and the host of guance.local with "host:guance.local" as the binding field. local.

**Note: When selecting a binding field (Custom Key, Value), you need to make sure that the field can be matched exactly with the explorer object in the current workspace that supports the configuration of built-in views. If the value entered for Key, Value is not available in the workspace, the explorer cannot be matched**

![](../img/4.view_10.png)


### 2.View the built-in view of the binding in the explorer details

The current binding relationship is "host:guance.local", you can go to the custom explorer, infrastructure, log, link, service, user access, security patrol, availability explorer that matches the "host:guance.local" field and see the details page of the successful binding "Network Monitoring View".

(The following figure shows the host explorer details of host:guance.local as an example）
![](../img/4.view_11.png)

