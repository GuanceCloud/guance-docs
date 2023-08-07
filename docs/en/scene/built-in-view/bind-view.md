# Bind Inner Dashboards
---

## Overview

Guance supports custom binding of inner dashboards (user views) to explorers. By associating binding of inner dashboards with link services, applications, log sources, projects or other custom fields, explorers that match the field values can view the newly bound inner dashboards via the side-sliding detail page.

**Note:** Explorers that support custom binding of inner dashboards include Custom Explorers, Infrastructure, Logs, Traces, Services, RUM, Security Check and Synthetic Tests.


## Setup

In **Inner View > User View**, you can create a binding relationship between the user view and the explorer by the field **Bind**.

### Create

In the **Inner Dashboards > User View > New User View > Bind** of Guance Workspace, you can bind the inner dashboards to the explorer based on the `key` and `value` in the `link service`, `app_id`, `source`, `project`, `label` or custom input. 

Fuzzy matching of values is supported.

![](../img/4.view_7.png)

**Note:** To ensure data consistency, you need to **add at least one field under the specified object category as the binding relationship** for this inner dashboards when creating the binding relationship between user view and explorer, and the system will automatically synchronize inner dashboards based on this binding relationship.

### View in the Explorer

Once you have configured the binding relationship, you can go to the explorer side-slide details page of the matching binding field value to view this inner dashboards.

![](../img/4.view_8.png)


### Delete

If you need to delete the bound inner dashboards in the explorer details, select and clear the fields in **Bind**, and click **Confirm**.


---

## Field Description

When binding fields in the inner dashboards, in addition to the following **fixed fields** data range, you can aslo **define the existing fields (`key`) and field values (`value`)** in the input space to generate binding relationships.

| <div style="width: 50px"> Field </div> | Data Range | Numerical Range |
| --- | --- |--- |
| `service`<br /> | `Service` value in Tracing (RUM).| ``*``: Indicate matching all services;<br />``value``: Indicate that only the corresponding `service` is matched, including single-value matching, multi-value matching, fuzzy matching and other methods.|
| `app_id`<br /> | `App_id` value in Rum. | ``*``: Indicate matching all applications;<br />``value``: Indicate that only the corresponding application is matched, including single-value matching, multi-value matching, fuzzy matching and other methods.|
| `source`<br /> | `Source` value in Logging data. | ``*``Indicate matching all log sources;<br />``value``：Indicate that only the corresponding log `source` is matched, including single-value matching, multi-value matching, fuzzy matching and other methods.|
| `project`<br /> | `Project` value in Infrastructure. | ``*``Indicate matching all items;<br />``value``：Indicate that only the corresponding item is matched, including single-value matching, multi-value matching, fuzzy matching and other methods.|
| `label` | `Label` value in Infrastructure. | ``*``Indicate matching all items<br />``value``: Indicate that only the corresponding `label` is matched, including single-value matching, multi-value matching, fuzzy matching and other methods. |

<font color=coral>Display logic on the Explorer details page after binding:</font>

:material-numeric-1-circle-outline: The value of the bound field supports **`*`, single value, multiple value and fuzzy match**：

- If `*` is selected for value, e.g. if `Service:*` is configured: all explorer detail pages with Service field in the list are bound to this inner dashboards;
- If single value is selected for value, e.g. if `Service:value1` is configured, all explorer detail pages with `service=value1` in the list will be bound to this inner dashboards;
- If multiple values is selected for value, e.g. if `Service:value1,value2` is configured, all the explorer detail pages with `service=value1` or `service=value2` in the list data will be bound to this inner dashboards; if there are multiple `key:value`, such as `Service:value1` and `source:value2`, all the explorer detail pages with `service=value1` or `source=value2` in the list data are bound to this inner dashboards;
- If `wildcard` is selected for the value, `*Service:` is displayed, e.g. if `*service:*sql` is configured, all explorer detail pages with `Service=fields` ending in `sql` (e.g., `service=mysql`; `service=pymysql`) in the list are bound to this inner dashboards.

:material-numeric-2-circle-outline: Binding field display order: `service` > `app_id` > `source` > `project` > `label`, the order of the same field does not do special treatment.

- If `service = ${value}`, `source = ${value}`, `project = ${value}` match the same inner dashboards, only this inner dashboards will be displayed in the explorer details page;
- If `service = ${value}`, `source = ${value}`, `project = ${value}` match different inner dashboards, the corresponding inner dashboards are displayed in the explorer details page in the order of Service > Source > Project.

:material-numeric-3-circle-outline: In the inner view bound to the Explorer details page, the default display time range is "last 15 minutes", and the time of obtaining the current data record is marked and displayed in the diagram.

### Examples 

#### Fixed Fields

Here is an example of binding the **User View > CPU Monitor View** to an explorer that matches all items.

i. Enter the view name and select `project:*` in **Bind**.

<img src="../../img/4.view_5.png" width="60%" >

ii. View the inner dashboards of the binding on the infrastructure host details page, provided that the host has the "project" tab.

![](../img/4.view_bang_4.png)

iii. View the inner dashboards of the binding in the log explorer details page, provided the host has the "project" tab.

![](../img/4.view_bang_5.png)


#### Custom Key and Value

The following is an example of binding the **User View > Network Monitor View** to the host explorer details page with the host name guance.local.

#### 1.Create binding relationships

In Guance Workspace **Scene > Inner dashboards > User View**, select **Bind** under **Setting**, then you can create a binding relationship between the current inner dashboards and the host of guance.local with "host:guance.local" as the binding field. local.

**Note: When selecting a binding field (Custom Key and Value), you need to make sure that the field can be matched exactly with the explorer object in the current workspace that supports the configuration of inner dashboards. If the value entered for Key and Value is not available in the workspace, the explorer cannot be matched.**

![](../img/4.view_10.png)


#### 2.View inner dashboards of binding in the explorer details

The current binding relationship is "host:guance.local", you can go to the custom explorer, infrastructure, log, link, service, user access, security check, availability explorer that matches the "host:guance.local" field and see the details page of the successful binding **Network Monitoring View**.

(The following figure shows the host explorer details of host:guance.local as an example）
![](../img/4.view_11.png)

