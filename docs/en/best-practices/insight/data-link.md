# Data Correlation Analysis Links

## Preface

In today's environment, ensuring the stability of business systems increasingly relies on data. When collecting and observing data across the entire system, it is essential to have a unified entry point for querying data information and extracting key useful insights to build visual dashboards and monitors for observation and alerts. If these feature modules operate independently, they may not cause issues when used separately, but troubleshooting can become inconvenient, requiring repeated switching, searching, and viewing.

To address these challenges, <<< custom_key.brand_name >>> offers three main features: [Dashboards], [Explorer], and [Monitors], helping you efficiently complete data queries, monitoring, and analysis. Additionally, it provides linking functionality to seamlessly navigate between modules, enabling comprehensive data correlation analysis and full observability of the system.

## Getting Started

This article focuses on configuring links within the [Explorer], [Dashboards], and [Monitors] to achieve data correlation analysis:

- **[Explorer]**: The Explorer records all collected data, allowing you to trace back and filter data based on tags to view detailed information.
- **[Dashboards]**: Composed of various visual charts, dashboards intuitively display critical performance metrics.
- **[Monitors]**: Used to monitor data anomalies, triggering alert events and sending notifications when monitoring conditions are met.

## Prerequisites

If you haven't registered a tree-node-{"name":"datakit-daemonset.md","path":"/zh/best-practices/insight/datakit-daemonset.md","type":"file","repo":"Guance integration","birthtime":1700705887402.8657,"mtime":1700705887402.8657,"level":5,"marked":false} account or your workspace lacks data, follow these steps to complete data collection:

1. [Log in to <<< custom_key.brand_name >>> Console](https://auth.guance.com/login/pwd) (if you don’t have an account, [register here](https://auth.guance.com/register));
2. [Install the DataKit collector](<<< homepage >>>/datakit/datakit-install/);
3. Navigate to the [Integrations] page in the console to enable the corresponding data collectors.

![](../images/Integration.png)

## Scenario One: Dashboard & Explorer Correlation Analysis

???+ info "User Scenario Example"

    Add a chart to the dashboard to count `Web application errors`. Later, if multiple errors occur during a specific period, you want to quickly find and troubleshoot these errors.

### 1. Configuring Links in Charts

1) Create a statistical chart in the dashboard and configure the query statement first:

```
R::`error`:(COUNT(`error_source`) AS `Error Count`) { `app_id` = '#{appid}' and `env` = '#{env}' and `version` = '#{version}' }
```

2) Click **Link > Add Link**, then configure the URL and parameters for the target page. Using the above DQL as an example, after discovering errors, you need to pass `app_id`, `env`, and `version` values to the Explorer for filtering.

???+ warning

    If you're unsure how to input the link and parameter format for the target page, you can copy and paste the URL from the target page and adjust it!

    Additionally, if the copied link contains URLEncode encoding, it will automatically decode it upon pasting, improving URL readability.

![](../images/link.png)

After completing the link configuration, save the chart.

#### Link Configuration Explanation

The platform has some built-in links that support quick addition. Just click the address input box to view them. These links only retain the base URL of the target page without time, query, etc., parameters. You can manually add them according to actual needs.

**Parameter Addition Methods**

There are two ways to configure link parameters:

1) Manually append parameters directly after the URL in the input box;
2) Click [Add Parameters] to configure; configured parameters will be automatically appended to the URL, ensuring consistency between upper and lower parameters;

    - When configuring parameters, the system presets some commonly used keys that can be selected directly. Each key has corresponding explanations and examples. Besides preset parameters, you can manually input any key/value pairs to configure links.

![](../images/configure.png)

**Using Template Variables to Pass Parameter Values**

Links support using template variables to pass data information. Available template variables are automatically displayed for user selection.

???- info "What are Template Variables?"

    <Template Variables> are used to pass dynamic parameter values. For example, in a line chart query with `by host`, clicking a line selects a specific host, so the host value is not fixed. To dynamically pass parameters in the link, template variables are needed. They pass corresponding values based on the selected host.

    There are three types of template variables: [Time Variables], [Tag Variables], and [View Variables].

    | Variable Type | Variable | Description |
    | --- | --- | --- |
    | Time Variable | #{TR} | The current chart query time range. If the current query time is `last hour`, then:<br />Template variable: `&time=#{TR}` is equivalent to `&time=1h` |
    | Tag Variable | #{T} | All grouping tag sets of the current chart query. If the current query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host','os'`<br />Query results: host=abc, os=linux, then:<br />Template variable: `&query=#{T}` is equivalent to `&query=host:abc os:linux` |
    |  | #{T.name} | A single tag value in the current chart query, where name can be replaced by any tagKey.<br />If the current query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />Query results: host=abc, os=linux, then:<br />- Template variable `#{T.host} = abc`<br />- `&query=hostname:#{T.host}` is equivalent to `&query=hostname:abc` |
    | View Variable | #{V} | All view variables in the current dashboard<br />If the current dashboard view variables are:<br />version=V1.7.0 and region=cn-hangzhou<br />Template variable `&query=#{V}` is equivalent to `&query=version:V1.7.0 region:cn-hangzhou` |
    |  | #{V.name} | A single view variable value in the current dashboard, where name can be replaced by any variable name.<br />If the current dashboard view variable version=V1.7.0, then:<br />- Template variable `#{V.version} = V1.7.0`<br />- `&query=version:{V.version}` is equivalent to `&query=version:V1.7.0` |

**Link Opening Methods**

Configured links support three opening methods: [Open in New Tab], [Open in Current Tab], and [Open in Side Panel].

### 2. Correlated Data Analysis

Next, using the [Web Application Overview] dashboard as an example, we'll demonstrate how to perform correlated data queries through chart links.

As shown below, the view variables select a specific `application` and `environment`, revealing 2 error records. Next, we locate these 2 errors:

Click the chart to open the dropdown menu and select **Link > Go to Error Explorer**. This opens the corresponding Explorer page with the query time range and all filtering conditions applied, locating the 2 error records. Thus, one-click correlated queries are achieved, allowing you to examine error details and identify causes.

![](../images/correlation_analysis.gif)

## Scenario Two: Monitor & Explorer Correlation Analysis

???+ info "User Scenario Example"

    Create a monitor to detect whether a service experiences 5xx errors. Upon detection, immediately trigger an alert notification and quickly find and troubleshoot these errors.

### 1. Configuring Links in Monitors

1) Create an **APM Metric Detection** monitor and configure the `Detection Metrics` and `Trigger Conditions`.

![](../images/monitor.png)

2) Insert the necessary jump links into the **Event Content**, using Markdown syntax for text content. Based on the user scenario, when a service encounters a 5xx error, triggering an alert, the inserted link jumps to the [Trace Explorer] and filters out erroneous traces.

- First, configure parameters like `service` and `http_status_code` in the link to carry over the filters to the Explorer.

- Since the monitor’s detection interval is [last 15 minutes], the query time range in the Explorer should match (i.e., the event notification time as the end time, 15 minutes before as the start time).

![](../images/monitor2.png)

After all configurations are complete, save the monitor.

#### Link Configuration Explanation

Any link can be inserted into the event content, such as Explorers, Dashboards, external links, etc., depending on the use case.

For example, if the detection interval is [15 minutes], and the detection metric query is:

```
T::RE(`.*`):(COUNT_DISTINCT(`trace_id`)) {`http_status_code` >= '500'} BY `service`
```

Then the added link automatically includes the following two parameters:

1) Filter condition parameter: `&query=http_status_code:>=500 service:{service}` (the groupings after `BY` are used as template variables)
2) Time parameter: Use the event generation time as the end time, 15 minutes before as the start time, e.g., `&time={{ date * 1000 - 900000}},{{date *  1000}}` (using template variable calculations)

### Template Variable Explanation

Event content supports using template variables to pass data information. The system automatically displays available template variables, which can be invoked by clicking the `{{` button or manually entering {{.

???- note "What are Template Variables?"

    <Template Variables> are used to pass dynamic parameter values. When configuring monitor event titles and contents, besides fixed text, you can use event fields to render dynamic text. Template variables in monitors are divided into two types:

    1) Fixed attribute variables: For example,<br /> {df_status} (event status), {df_monitor_checker_name} (monitor name), {df_workspace_name} (workspace name), {Result} (value detected at event generation), etc.
    2) Detection dimension variables: For example, if the detection metric query uses `by 'host','service'`, then you can use template variables {host}, {service} to render the detection object.

    > For more details, see [Monitor Template Variables](../monitoring/event-template.md).

![](../images/template_link.gif)

### 2. Correlated Data Analysis

Continuing from the previous monitor configuration, triggered alert events will display the configured notification content, including the [Jump Link]. Clicking this link allows you to view the corresponding error trace data. Combining trace details, associated logs, network conditions, etc., helps analyze the root cause of the error.

![](../images/event_analysis.gif)