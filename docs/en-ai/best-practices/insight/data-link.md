# Data Correlation Analysis Links

## Introduction

In today's environment, ensuring the stability of business systems increasingly relies on data. When collecting this data to observe the entire system, the first requirement is to have a unified entry point for querying data information. Based on this data, key useful information can be extracted to build visual dashboards and monitors for observation and alerting. If these functional modules operate independently, they may work fine separately, but when troubleshooting issues, it becomes inconvenient as one needs to switch, search, and view repeatedly.

To address the above challenges, Guance provides three major functions: [Dashboards], [Explorer], and [Monitors] to help you efficiently complete data queries, monitoring, and analysis. Additionally, it offers linking capabilities that allow smooth transitions between modules, enabling comprehensive data correlation analysis and full observability of the system.

## Getting Started

This article primarily focuses on how to configure links for data correlation analysis using the three main features: [Explorer], [Dashboards], and [Monitors]:

- **Explorer**: The Explorer records all collected data. Here, you can trace back and filter data based on tags to view detailed information.
- **Dashboards**: Composed of various visual charts, used to intuitively display critical performance metrics.
- **Monitors**: Used for monitoring data anomalies; if monitoring conditions are met, it generates alert events and sends notifications.

## Prerequisites

If you haven't registered a tree-node-{"name":"datakit-daemonset.md","path":"/zh/best-practices/insight/datakit-daemonset.md","type":"file","repo":"Guance Integration","birthtime":1700705887402.8657,"mtime":1700705887402.8657,"level":5,"marked":false} account or your workspace lacks data, follow these steps to complete data collection:

1. [Log in to the Guance Console](https://auth.guance.com/login/pwd) (if you don’t have an account, [click here to register](https://auth.guance.com/register));
2. [Install the DataKit Collector](https://docs.guance.com/datakit/datakit-install/);
3. Go to the console's [Integration] page to enable the corresponding data collectors.

![](../images/Integration.png)

## Scenario One: Dashboard & Explorer Correlation Analysis

???+ info "User Scenario Example"

    Add a chart to the dashboard to track `Web Application Error Counts`. Later, if multiple errors occur during a certain period, you want to quickly locate and investigate these errors.

### 1. Configuring Links in Charts

1) Create a statistical chart in the dashboard and configure the query statement first:

```
R::`error`:(COUNT(`error_source`) AS `Error Count`) { `app_id` = '#{appid}' and `env` = '#{env}' and `version` = '#{version}' }
```

2) Click **Link > Add Link**, then configure the URL to navigate to and the corresponding parameters. For example, after detecting errors, we need to jump to the Explorer to filter out error data, so we pass the values of `app_id`, `env`, and `version` to the Explorer for filtering.

???+ warning

    If you are unsure how to input the target page’s link and parameter format, you can copy and paste the corresponding URL from the target page and adjust it accordingly!

    Additionally, if the copied link contains URLEncode encoding, it will automatically decode it upon pasting, making the URL more readable.

![](../images/link.png)

After configuring the link, save the chart.

#### Link Configuration Explanation

The platform has some built-in links that support quick addition. Simply click on the address input box to view them. These links only retain the base URL of the target page without time, query, etc., parameters. You can manually add parameters based on actual needs.

**Parameter Addition Methods**

There are two ways to configure link parameters:

1) Directly append parameters by writing them after the URL in the input box;
2) Click **Add Parameter** to configure; configured parameters will be automatically appended to the URL, and upper and lower parameters will always remain consistent;

    - When configuring parameters, the system presets some common keys that you can directly select. Each key has a corresponding explanation and example. Besides the preset parameters, you can manually input any key/value pairs to configure the link.

![](../images/configure.png)

**Using Template Variables to Pass Parameter Values**

Links support using template variables to pass data information. We automatically display available template variables, which you can directly copy and use.

???- info "What are Template Variables?"

    <Template Variables> are used to pass dynamic parameter values. For example, in a line chart query with `by host`, each click selects a specific host, so the host value is not fixed. To dynamically pass parameters, you need to use template variables. Template variables pass corresponding values based on the selected host.

    Currently, there are three types of template variables: [Time Variables], [Tag Variables], and [View Variables].

    | Variable Type | Variable | Description |
    | --- | --- | --- |
    | Time Variable | #{TR} | The current chart query time range. If the current query time is `Last 1 Hour`, then:<br />Template variable: `&time=#{TR}` equals `&time=1h` |
    | Tag Variable | #{T} | All grouping tag sets from the current chart query. If the current query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host','os'`<br />Query results: host=abc, os=linux, then:<br />Template variable: `&query=#{T}` equals `&query=host:abc os:linux` |
    |  | #{T.name} | A specific tag value from the current chart query, where name can be replaced by any tagKey.<br />Assuming the current query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />Query results: host=abc, os=linux, then:<br />- Template variable `#{T.host} = abc`<br />- `&query=hostname:#{T.host}` equals `&query=hostname:abc` |
    | View Variable | #{V} | All view variables in the current dashboard<br />Assume the current dashboard view variables are:<br />version=V1.7.0 and region=cn-hangzhou<br />Template variable `&query=#{V}` equals `&query=version:V1.7.0 region:cn-hangzhou` |
    |  | #{V.name} | A specific view variable value in the current dashboard, where name can be replaced by any variable name.<br />Assume the current dashboard view variable version=V1.7.0, then:<br />- Template variable `#{V.version} = V1.7.0`<br />- `&query=version:{V.version}` equals `&query=version:V1.7.0` |

**Link Opening Methods**

Configured links support three opening methods: [Open in New Tab], [Open in Current Tab], and [Open in Sidebar].

### 2. Correlated Data Analysis

Next, let's demonstrate how to perform data correlation queries using chart links in the [Web Application Overview] dashboard.

As shown in the figure below, view variables have selected a specific `Application` and `Environment`, revealing 2 error data points. Next, we find these 2 errors:

Click the chart to bring up the dropdown menu and select **Link > Jump to Error Explorer**. This opens the corresponding Explorer page, passing the query time range and all filtering conditions to find these 2 error records. This achieves one-click correlation queries. You can then view detailed information about these errors to identify their causes.

![](../images/correlation_analysis.gif)

## Scenario Two: Monitor & Explorer Correlation Analysis

???+ info "User Scenario Example"

    Create a monitor to detect whether services experience 5xx errors. Upon detection, immediately trigger an alert notification and quickly locate and investigate these errors.

### 1. Configuring Links in Monitors

1) Create an **APM Metric Detection** monitor and configure the `Detection Metrics` and `Trigger Conditions`.

![](../images/monitor.png)

2) Insert the necessary links into the **Event Content**. The text content entered here should **use Markdown syntax**. According to the user scenario, when a service experiences a 5xx error, it triggers an alert, so we insert a link to jump to the [Trace Explorer] and filter out error traces.

- First, configure parameters like `service` and `http_status_code` in the link to apply the filters in the Explorer.
- Since the monitor configuration uses a detection interval of [Last 15 Minutes], the query time range in the Explorer should match (i.e., the event notification time as the end time, and 15 minutes before as the start time).

![](../images/monitor2.png)

After completing all configurations, save the monitor.

#### Link Configuration Explanation

You can insert any link in the event content, such as Explorer, Dashboards, external links, etc., depending on the usage scenario.

For example, if the detection interval is [15 Minutes], and the detection metric query is:

```
T::RE(`.*`):(COUNT_DISTINCT(`trace_id`)) {`http_status_code` >= '500'} BY `service`
```

Then the added link will automatically include the following two parameters:

1) Filter condition parameters: `&query=http_status_code:>=500 service:{service}` (the groupings after `BY` are filled in as template variables)
2) Time parameters: Using the event generation time as the end time, and 15 minutes before as the start time, example: `&time={{ date * 1000 - 900000}},{{date * 1000}}` (this uses template variable arithmetic)

### Template Variable Explanation

Event content supports using template variables to pass data information. The system automatically displays available template variables, and you just need to click the `{{` button or manually type `{{` to invoke the variable list.

???- note "What are Template Variables?"

    <Template Variables> are used to pass dynamic parameter values. In configuring the monitor event title and content, besides fixed text, you can use fields from the event to render the text. There are two types of template variables in monitoring:

    1) Fixed attribute variables: e.g.,<br /> {df_status} (event status), {df_monitor_checker_name} (monitor name), {df_workspace_name} (workspace name), {Result} (value detected at event generation), etc.
    2) Detection dimension variables: e.g., if the detection metric query includes `by 'host','service'`, then you can use template variables {host}, {service} to render the detected objects.

    > For more details, see [Monitor Template Variables](../monitoring/event-template.md).

![](../images/template_link.gif)

### 2. Correlated Data Analysis

Continuing from the previous monitor configuration, the triggered alert events will display the configured notification content, including a [Jump Link]. Clicking this link allows you to view the corresponding error trace data. From there, you can analyze the cause of the error in detail, combining trace details, associated logs, network conditions, etc.

![](../images/event_analysis.gif)