# Dashboard
---

**Dashboard** displays visual reports related to specific functions on the same interface, building data insight scenarios through multi-dimensional data analysis. You can start constructing visualization scenarios by creating a blank dashboard or importing a custom template, and comprehensively monitor data metrics from different sources by adding charts, time widgets, keyword searches, and label filters.

## Create Dashboard

You can create a dashboard in three ways.

:material-numeric-1-circle: Directly create [Blank Dashboard](#blank);

:material-numeric-2-circle: Import [Custom Template](#custom);

:material-numeric-3-circle: Select a view from the [Built-in Template Library](#view).

### Blank Dashboard {#blank}

![](../img/8.dashboard_1.png)

1. Define the name of the current dashboard;
2. Define the ID of this dashboard;
3. Input a description for this dashboard as needed;
4. Select [Labels](../../management/global-label.md) for easier grouping management later;
5. Choose the [Visibility Scope](#range) of the current dashboard;
6. Click confirm to successfully create it.

#### Identifier ID

<<< custom_key.brand_name >>> defines this ID as `identifier`, used to ensure the uniqueness of the dashboard or view.

##### Use Cases

It can be used to configure the chart's [Jump Link](../visual-chart/chart-link.md), thereby achieving unique positioning.

:material-numeric-1-circle-outline: Define the identifier ID of the dashboard as `abc`. In the final exported [JSON file](./config_list.md#options), the parameter is: `"identifier": "abc"`

<img src="../img/identifier.png" width="60%" >

:material-numeric-2-circle-outline: When configuring jump links for charts, add the link of the dashboard with the identifier ID `abc` as:

```
/scene/dashboard/dashboardDetail?identifier=abc
```

In addition to dashboards, views are also applicable:

```
// The type field optional values: inner (user view), sys (system view). If not passed, it defaults to inner:
/scene/builtinview/detail?identifier=abc&type=sys // System View
/scene/builtinview/detail?identifier=abc&type=inner // User View
/scene/builtinview/detail?identifier=abc // User View
```


#### Visibility Scope {#range}

The visibility scope of the dashboard includes:

- Public: Open to all members within the workspace;   
- Visible Only to Yourself: Only visible to the creator;
- Custom: Limits the visibility scope to specific members.


???+ warning "Note"

    - Non-public dashboards shared via links are invisible to non-creators;
    - This switch only controls whether the current dashboard is public or not, and does not affect other rules.



### Custom Template {#custom}

![](../img/1.dashboard_2.png)

1. Define the name of the current dashboard;
2. Define the ID of this dashboard;
3. Input a description for this dashboard as needed;
4. Upload a custom JSON view template file;
5. Select [Labels](../../management/global-label.md) for easier grouping management later;
6. Choose the [Visibility Scope](#range) of the current dashboard;
7. Click confirm to successfully create it.

### Built-in Template Library {#view}

![](../img/3.dashboard_2.png)

Ready-to-use, including [System Views](../built-in-view/index.md#system) and [User Views](../built-in-view/index.md#user).

1. The default name of the dashboard is the name of the currently selected view, which can be changed as needed;
2. Define the ID of this dashboard;
3. Input a description for this dashboard as needed;
4. Select [Labels](../management/global-label.md) for easier grouping management later;
5. Choose the [Visibility Scope](#range) of the current dashboard;
6. Click confirm to successfully create it.