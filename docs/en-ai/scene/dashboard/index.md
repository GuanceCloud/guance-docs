# Dashboard
---

**Dashboard** displays related visual reports on the same interface, building data insights through multi-dimensional data analysis. You can start constructing visualization scenarios by creating a new blank dashboard or importing custom templates, and comprehensively monitor data metrics from different sources using methods such as adding charts, time controls, keyword searches, and label filters.

## Create a New Dashboard

You can create a dashboard in three ways.

:material-numeric-1-circle: Directly create a [Blank Dashboard](#blank);

:material-numeric-2-circle: Import a [Custom Template](#custom);

:material-numeric-3-circle: Choose a view from the [Built-in Template Library](#view).

### Blank Dashboard {#blank}

![](../img/8.dashboard_1.png)

1. Define the name of the current dashboard;
2. Define the identifier ID for this dashboard;
3. Optionally input a description for this dashboard;
4. Select [Labels](../../management/global-label.md) to facilitate subsequent group management;
5. Choose the [Visibility Scope](#range) for the current dashboard;
6. Click confirm to create successfully.

#### Identifier ID

Guance defines this ID as `identifier`, used to ensure the uniqueness of the dashboard or view.

##### Use Cases

It can be used to configure chart [jump links](../visual-chart/chart-link.md), thus achieving unique positioning.

Use Case :material-numeric-1-circle-outline:: Define the dashboard's identifier ID as `abc`. In the final exported [JSON file](./config_list.md#options), the parameter is: `"identifier": "abc"`

<img src="../img/identifier.png" width="60%" >

Use Case :material-numeric-2-circle-outline:: When configuring jump links for charts, add the dashboard link with the identifier ID `abc` as:

```
/scene/dashboard/dashboardDetail?identifier=abc
```

Apart from dashboards, views are also applicable:

```
// The type field optional values: inner (user view), sys (system view). Default is inner if not specified:
/scene/builtinview/detail?identifier=abc&type=sys // System View
/scene/builtinview/detail?identifier=abc&type=inner // User View
/scene/builtinview/detail?identifier=abc // User View
```


#### Visibility Scope {#range}

The visibility scope of the dashboard includes:

- Public: Dashboards open to all members within the workspace.
- Private: Dashboards visible only to the creator, other members (including Owners) do not have viewing permissions.
- Custom: To restrict visibility among members, click to select the objects that have operation and view permissions.


**Note**:

1. Non-public dashboards shared via links are invisible to non-creators.
2. This switch only controls the public/private status of the current dashboard and does not affect other rules.



### Custom Template {#custom}

![](../img/1.dashboard_2.png)

1. Define the name of the current dashboard;
2. Define the identifier ID for this dashboard;
3. Optionally input a description for this dashboard;
4. Upload a custom view template JSON file;
5. Select [Labels](../../management/global-label.md) to facilitate subsequent group management;
6. Choose the [Visibility Scope](#range) for the current dashboard;
7. Click confirm to create successfully.

### Built-in Template Library {#view}

![](../img/3.dashboard_2.png)

Ready-to-use, including [System Views](../built-in-view/index.md#system) and [User Views](../built-in-view/index.md#user).

1. The dashboard name defaults to the name of the currently selected view, which can be changed as needed;
2. Define the identifier ID for this dashboard;
3. Optionally input a description for this dashboard;
4. Select [Labels](../management/global-label.md) to facilitate subsequent group management;
5. Choose the [Visibility Scope](#range) for the current dashboard;
6. Click confirm to create successfully.