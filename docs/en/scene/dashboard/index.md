# Dashboard
---

**Dashboard** displays related visual reports on the same interface, building data insight scenarios through multi-dimensional data analysis. You can start constructing visualization scenarios by creating a blank dashboard or importing custom templates, and comprehensively monitor data metrics from different sources using methods such as adding charts, time widgets, keyword searches, and label filtering.

## Create a Dashboard

You can create a dashboard in three ways.

:material-numeric-1-circle: Directly create a [blank dashboard](#blank);

:material-numeric-2-circle: Import a [custom template](#custom);

:material-numeric-3-circle: Choose a view from the [built-in template library](#view).

### Blank Dashboard {#blank}

![](../img/8.dashboard_1.png)

1. Define the name of the current dashboard;
2. Define the ID for this dashboard;
3. Optionally input a description for this dashboard;
4. Select [labels](../../management/global-label.md) to facilitate subsequent grouping management;
5. Choose the [visibility scope](#range) for the current dashboard;
6. Click confirm to successfully create it.

#### Identifier ID

<<< custom_key.brand_name >>> defines this ID as `identifier`, used to ensure the uniqueness of the dashboard or view.

##### Use Cases

It can be used to configure chart [jump links](../visual-chart/chart-link.md), thereby achieving unique positioning.

Scenario :material-numeric-1-circle-outline:：Define the identifier ID of the dashboard as `abc`. In the final exported [JSON file](./config_list.md#options), the parameter is: `"identifier": "abc"`

<img src="../img/identifier.png" width="60%" >

Scenario :material-numeric-2-circle-outline:：When configuring jump links for charts, add the link to the dashboard with the identifier ID `abc` as:

```
/scene/dashboard/dashboardDetail?identifier=abc
```

In addition to dashboards, views are also applicable:

```
// type field optional values: inner (user view), sys (system view). Defaults to inner if not specified:
/scene/builtinview/detail?identifier=abc&type=sys // system view
/scene/builtinview/detail?identifier=abc&type=inner // user view
/scene/builtinview/detail?identifier=abc // user view
```


#### Visibility Scope {#range}

The visibility scope of the dashboard includes:

- Public: A dashboard open to all members within the workspace.
- Only visible to me: A non-public dashboard that only the creator can view; other members (including Owners) do not have viewing permissions.
- Custom: If you need to restrict visibility among members, click to select the objects that have operational and viewing permissions.


**Note**:

1. Non-public dashboards shared via links are not visible to non-creators.
2. This switch only controls whether the current dashboard is public and does not affect other rules;



### Custom Template {#custom}

![](../img/1.dashboard_2.png)

1. Define the name of the current dashboard;
2. Define the ID for this dashboard;
3. Optionally input a description for this dashboard;
4. Upload a custom view template JSON file;
5. Select [labels](../../management/global-label.md) to facilitate subsequent grouping management;
6. Choose the [visibility scope](#range) for the current dashboard;
7. Click confirm to successfully create it.

### Built-in Template Library {#view}

![](../img/3.dashboard_2.png)

Ready-to-use, including [system views](../built-in-view/index.md#system) and [user views](../built-in-view/index.md#user).

1. The dashboard name defaults to the name of the currently selected view, which can be changed as needed;
2. Define the ID for this dashboard;
3. Optionally input a description for this dashboard;
4. Select [labels](../management/global-label.md) to facilitate subsequent grouping management;
5. Choose the [visibility scope](#range) for the current dashboard;
6. Click confirm to successfully create it.