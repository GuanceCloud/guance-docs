# Data Linkage Analysis

## Introduction

In today's world, ensuring the stability of business systems increasingly depends on data. When collecting these data to observe the entire system, the first requirement is to have a unified entry point to query data information and extract key useful information based on this data to build visual dashboards and monitors for observation and alerting. If these Features operate independently, there won't be any issues when used separately, but it will be inconvenient for troubleshooting problems, requiring repeated switching, searching, and viewing.

To address the above issues, <<< custom_key.brand_name >>> provides three main Features: [Dashboards], [Explorers], and [Monitors] to help you efficiently complete data queries, monitoring, and analysis. Additionally, it offers linking functionality, allowing smooth transitions between modules for comprehensive data linkage analysis and full observability of the system.

## Getting Started

This article mainly focuses on how to configure links using the three core Features: [Explorer], [Dashboard], and [Monitor] to achieve data linkage analysis:

- [Explorer]: The Explorer records all collected data. Here, you can trace the source, filter data by tags, and view detailed data;
- [Dashboard]: Composed of various visual charts, it is used to intuitively display key Metrics;
- [Monitor]: Used for monitoring data anomalies, generating alert events and sending notifications when trigger conditions are met.

## Preparation

If you haven't registered a tree-node-{"name":"datakit-daemonset.md","path":"/en/best-practices/insight/datakit-daemonset.md","type":"file","repo":"Guance Integration","birthtime":1700705887402.8657,"mtime":1700705887402.8657,"level":5,"marked":false} account or your workspace lacks data, follow these steps to complete data collection:

1. [Log in to <<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site_auth >>>/login/pwd) (If you don’t have an account, [click to register](https://<<< custom_key.studio_main_site_auth >>>/register));
2. [Install the DataKit Collector](<<< homepage >>>/datakit/datakit-install/);
3. Navigate to the Console [Integration] page to enable the corresponding data collectors.

![](../images/Integration.png)

## Scenario One: Dashboard & Explorer Association Analysis

???+ info "User Scenario Example"

    Add a chart in the dashboard to count `Web Application Errors`. Subsequently, if multiple errors occur during a specific time period, you want to quickly locate and troubleshoot these errors.

### 1. Configuring Links in Charts

1) In the dashboard, create a statistical chart and configure the query statement first:

```
R::`error`:(COUNT(`error_source`) AS `Error Count`) { `app_id` = '#{appid}' and `env` = '#{env}' and `version` = '#{version}' }
```

2) Click **Link > Add Link**, then configure the URL to which you need to navigate as well as the corresponding parameters. Taking the aforementioned DQL as an example, after discovering errors, we need to jump to the Explorer to filter out error data, so we must pass the values of `app_id`, `env`, and `version` to the Explorer for filtering.

???+ warning

    If you're unsure how to input the target page link and parameter format, you can copy and paste the corresponding URL of the target page and adjust it accordingly!

    Also, if the copied link contains URLEncode encoding, it will automatically decode it for you upon pasting, making the URL more readable.

![](../images/link.png)

After completing the link configuration, save the chart.

#### Link Configuration Explanation

The platform has built-in some links that allow users to quickly add them; simply click on the address input box to view them. These links only retain the basic URL of the target page without including time, query, etc., parameters. You can manually add them according to actual needs.

**Parameter Addition Methods**

There are two supported ways to configure link parameters:

1) Manually append parameters directly after the URL in the input box;

2) Click **Add Parameter** to configure it. The configured parameters will be automatically appended to the URL above, keeping the parameters consistent both up and down.

    - When configuring parameters, the system presets some commonly used keys that you can directly select from, each key accompanied by its corresponding explanation and example. Besides the system-preset parameters, you can also manually input any key/value pair to configure the link.

![](../images/configure.png)

**Passing Parameter Values Using Template Variables**

Links support the use of template variables to pass data information. We will automatically display all currently available template variables, allowing users to directly copy and use them.

???- info "What are Template Variables?"

    <Template Variables> are used to pass dynamic parameter values. For example, in line chart queries `by host`, each time you click a line, you actually select a specific host, so the value of host is not fixed. To dynamically pass parameters in the link, you need to use template variables. Template variables will pass the corresponding value based on the selected host at the time.

    Currently, 3 types of template variables are supported: [Time Variables], [Tag Variables], and [View Variables].

    | Variable Type | Variable | Description |
    | --- | --- | --- |
    | Time Variable | #{TR} | The current time range of the chart query. Assuming the current query time is `Last 1 Hour`, then:<br />Template variable: `&time=#{TR}` is equivalent to `&time=1h` |
    | Tag Variable | #{T} | The set of all grouping tags in the current chart query. Assuming the current chart query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host','os'`<br />Query results: host=abc, os=linux, then:<br />Template variable: `&query=#{T}` is equivalent to `&query=host:abc os:linux` |
    |  | #{T.name} | The value of a particular tag in the current chart query, where name can be replaced with any tagKey.<br />Assuming the current chart query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />Query results: host=abc, os=linux, then:<br />- Template variable `#{T.host} = abc`<br />- `&query=hostname:#{T.host}` is equivalent to `&query=hostname:abc` |
    | View Variable | #{V} | The set of all view variables in the current dashboard<br />Assuming the current dashboard's view variables are:<br />version=V1.7.0 and region=cn-hangzhou<br />Template variable `&query=#{V}` is equivalent to `&query=version:V1.7.0 region:cn-hangzhou` |
    |  | #{V.name} | The value of a particular view variable in the current dashboard, where name can be replaced with any variable name.<br />Assuming the current dashboard's view variable version=V1.7.0, then:<br />- Template variable `#{V.version} = V1.7.0`<br />- `&query=version:{V.version}` is equivalent to `&query=version:V1.7.0`<br /> |

**Ways to Open Links**

Configured links support three opening methods: [Open in New Tab], [Open in Current Tab], and [Open in Sidebar].

### 2. Associated Data Analysis

Next, take the [Web Application Overview] dashboard as an example to demonstrate how to perform data association queries through chart links.

As shown in the figure below, view variables have selected a certain `application` and `environment`, discovering a total of 2 error data points. Next, we find these 2 errors:

Click the chart to bring up the dropdown menu, choose **Link > Go to Error Explorer**. This will open the corresponding Explorer page, passing along the query time range and all filtering conditions, locating these 2 error records. Thus, we achieve one-click associated queries. Next, you can view the details of these errors to find the cause of the errors.

![](../images/correlation_analysis.gif)

## Scenario Two: Monitor & Explorer Association Analysis

???+ info "User Scenario Example"

    Create a monitor to detect whether the service generates 5xx errors. As soon as errors are detected, generate alert notifications and quickly identify and troubleshoot these errors.

### 1. Configuring Links in Monitors

1) Create an **Application Performance Metric Detection** monitor, configuring the `Detection Metric` and `Trigger Conditions` first.

![](../images/monitor.png)

2) Insert the necessary link into the **Event Content**, where the entered text content should <u>use Markdown syntax</u>. According to the user scenario mentioned above, when a service encounters 5xx errors, it triggers an alert. Therefore, the inserted link navigates to the [Trace Explorer] and filters out erroneous traces.

- First, you need to configure parameters such as `service` and `http_status_code` into the link so that the filters can be passed to the Explorer.

- Since the detection interval of the monitor is set to [Last 15 Minutes], the query time range in the Explorer should also match (i.e., the event notification time as the end time, and 15 minutes before as the start time).

![](../images/monitor2.png)

After all configurations are completed, save the monitor.

#### Link Configuration Explanation

Any link can be inserted into the Event Content, such as: Explorer, Dashboard, external links, etc., configured according to the use case.

For example: A detection interval of [15 Minutes], and the query for the detection metric is:

```
T::RE(`.*`):(COUNT_DISTINCT(`trace_id`)) {`http_status_code` >= '500'} BY `service`
```

Then the added link will automatically carry the following two parameters:

1) Filter condition parameter: `&query=http_status_code:>=500 service:{service}` (the groupings after 'BY' will be filled as template variables)

2) Time parameter: The event generation time as the end time, 15 minutes prior as the start time, example: `&time={{ date * 1000 - 900000}},{{date * 1000}}` (template variable calculations are applied here)

### Template Variable Explanation

Event Content supports the use of template variables to pass data information. The system will automatically display all currently available template variables, just click the `{{` button or manually type `{{` to invoke the variable list.

???- note "What are Template Variables?"

    <Template Variables> are used to pass dynamic parameter values. When configuring the event title and event content of a monitor, besides the fixed texts you write, you can use fields from the event to render the text. There are two types of template variables in monitoring:

    1) Fixed attribute variables: For example,<br /> {df_status} (status of the event), {df_monitor_checker_name} (name of the monitor), {df_workspace_name} (name of the workspace), {Result} (value detected at the time of event generation) etc.

    2) Detection dimension variables: For example, if the detection metric query uses 'by host, service', then the template variables {host}, {service} can be used to render the detection object.

    > For more information, please refer to [Monitor Template Variables](../monitoring/event-template.md).

![](../images/template_link.gif)

### 2. Associated Data Analysis

Next, taking the [Application Performance Metric Detection] monitor as an example, demonstrates how to configure links in monitors to achieve data association queries.

Following the previous monitor configuration, triggered alert events will display the configured notification content, which includes [Jump Links]. Clicking these links allows you to view the corresponding erroneous trace data. Then, you can combine trace details, related logs, network conditions, etc., across multiple dimensions to analyze the causes of errors.

![](../images/event_analysis.gif)