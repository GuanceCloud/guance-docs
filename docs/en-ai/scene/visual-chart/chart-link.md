# Chart Links
---

Guance supports both built-in and custom chart links, which can help you navigate from the current chart to a target page while passing data information through template variables for data interactivity.

## Variable Explanation

Guance supports four types of template variables:

- Time Variables
- Label Variables
- View Variables
- Value Variables

### Time Variables {#time}

| Variable | Description |
| --- | --- |
| #{TR} | The time range of the current chart query. For example, if the current query time is `Last 1 hour`, then:<br />Template variable: `&time=#{TR}` is equivalent to `&time=1h` |
| #{timestamp.start} | The start time of the selected data point in the current chart query. |
| #{timestamp.end} | The end time of the selected data point in the current chart query. |
| #{startTime} | If the time is not locked, it represents the start time in the time control at the top right corner of the current chart.<br />If the time is locked, it represents the start time set in the locked time settings. |
| #{endTime} | If the time is not locked, it represents the end time in the time control at the top right corner of the current chart.<br />If the time is locked, it represents the end time set in the locked time settings. |

**Note**: During actual queries, you can use the time variables `#{startTime}` and `#{endTime}`, as well as view variables as placeholders. When the chart query is actually executed, the system will replace these variables with their globally set values.

### Label Variables

| Variable | Description |
| --- | --- |
| #{T} | All group label sets of the current chart query. For example, if the current chart query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host','os'`<br />The query result is: host=abc, os=linux, then:<br />Template variable: `&query=#{T}` is equivalent to `&query=host:abc os:linux` |
| #{T.name} | The value of a specific label in the current chart query, where name can be replaced by any tagKey in the query.<br />For example, if the current chart query is:<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />The query result is: host=abc, os=linux, then:<br /><li>Template variable `#{T.host} = abc`<br /><li>`&query=hostname:#{T.host}` is equivalent to `&query=hostname:abc` |

### View Variables

| Variable | Description |
| --- | --- |
| #{V} | A collection of all view variables in the current dashboard<br />For example, if the current dashboard's view variables are:<br />version=V1.7.0 and region=cn-hangzhou<br />Template variable `&query=#{V}` is equivalent to `&query=version:V1.7.0 region:cn-hangzhou` |
| #{V.name} | The value of a specific view variable in the current dashboard, where name can be replaced by any variable name.<br />For example, if the current dashboard's view variable version=V1.7.0, then:<br /><li>Template variable `#{V.version} = V1.7.0`<br /><li>`&query=version:#{V.version}` is equivalent to `&query=version:V1.7.0` |

### Value Variables {#z-variate}

| Chart Type | <div style="width: 130px">Variable</div> | Description |
| --- | --- | --- |
| Time Series, Summary, Pie Chart, Bar Chart, Top List, Dashboard, Funnel Analysis | #{Value} | The data value variable returned by the current chart query. For example, if the current chart query is `M::cpu:(AVG(load5s))` and the result is AVG(load5s)=a, then:<br />Value variable: `&query=#{Value}` is equivalent to `&query=AVG(load5s):a` |
| Scatter Plot | #{Value.X} | The X-axis data value variable returned by the current chart query. For example, if the current chart query is:<br />`M::cpu:(AVG(load5s))`<br />And the result is: X:AVG(load5s)=abc, then:<br />Value variable: `&query=#{Value.X}` is equivalent to `&query=X:abc` |
|  | #{Value.Y} | The Y-axis data value variable returned by the current chart query.<br />For example, if the current chart query is:<br />`M::backuplog:(AVG(lru_add_cache_success_count))`<br />And the result is: Y:AVG(lru_add_cache_success_count)=dca, then:<br />Value variable `&query=Y:#{Value.Y}` is equivalent to `&query=Y:dca` |
| Bubble Chart | #{Value.X} | The X-axis data value variable returned by the current chart query. For example, if the current chart query is:<br />`T::RE(.*):(FIRST(duration)) BY service`<br />And the result is: X:first(duration)=98, then:<br />Value variable: `&query=X:#{Value.X}` is equivalent to `&query=X:98` |
|  | #{Value.Y} | The Y-axis data value variable returned by the current chart query.<br />For example, if the current chart query is:<br />`T::RE(.*):(LAST(duration)) BY service`<br />And the result is: Y:last(duration)=8500, then:<br />Value variable `&query=Y:#{Value.Y}` is equivalent to `&query=Y:8500` |
|  | #{Value.Size} | The Size data value variable returned by the current chart query.<br />For example, if the current chart query is:<br />`T::RE(.*):(MAX(duration)) BY service`<br />And the result is: Size:Max(duration)=1773, then:<br />Value variable `&query=Size:#{Value.Size}` is equivalent to `&query=Size:1773` |
| Table Chart | #{Value.column_name} | The column value variable selected in the current chart, where name can be replaced by any column variable name.<br />For example, if the current chart query is:<br />`L::RE(.*):(COUNT(*)) { index = default }`<br />And the result is: count(*)=40813, then:<br />Value variable `&query=#{Value.count(*)}` is equivalent to `&query=count(*):40813` |
| Treemap, China Map, World Map, Hexbin Map | #{Value.metric_name} | The query data value variable selected in the current chart, where name can be replaced by any column variable name.<br />For example, if the current chart query is:<br />`L::RE(.*):(MAX(response_time)) { index = default } BY country`<br />And the result is: max(response_time)=16692, then:<br />Value variable `&query=#{Value.max(response_time)}` is equivalent to `&query=max(response_time):16692` |

## Built-in Links

Built-in links are the default associated links provided by Guance for charts, mainly based on the current query time range and grouping labels to help you view corresponding logs, processes, containers, and traces. Built-in links are disabled by default.

![](../img/6.link_1.png)

After enabling the display of built-in links, clicking on the chart allows you to view associated data.

- View related logs: Based on the grouping labels of the current query, associate and query relevant logs, i.e., add the current grouping labels as filter conditions, supporting navigation to the log Explorer for detailed viewing; containers, processes, and traces follow the same logic.

![](../img/6.link_3.png)

## Custom Links {#custom-link}

Custom links allow you to add custom links to charts. By entering text in the text box and configuring parameters, you can freely combine and generate the final chart association link address to view related data. Custom links are enabled by default after adding and can be directly displayed in the chart preview.

In **Dashboard**, select **Chart > Links**, enter a **Name**, and you can start adding custom links to the chart.

<img src="../../img/6.link_5.1.png" width="70%" >

### Link Address

The link address is generated based on the entered text in the text box and parameter configuration to form the final chart association link address to view related data.

#### Preset Link Explanation

When adding chart links, Guance provides preset links to help you configure the link address quickly and easily.

| Associated Data Type | Preset Link                                  |
| ------------ | -------------------------------------- |
| Logs         | `/logIndi/log/all`                                           |
| Traces       | `/tracing/link/all`                                          |
| Error Tracking | `/tracing/errorTrack`                                        |
| Profile      | `/tracing/profile`                                           |
| Containers   | `/objectadmin/docker_containers?routerTabActive=ObjectadminDocker` |
| Pods         | `/objectadmin/kubelet_pod?routerTabActive=ObjectadminDocker` |
| Processes    | `/objectadmin/host_processes?routerTabActive=ObjectadminProcesses` |
| Dashboard    | `/scene/dashboard/dashboardDetail`                           |

#### Preset Parameter Explanation {#description}

When adding chart links, based on the selected preset link, corresponding available parameters are provided to help you configure the link address quickly and easily.

| Parameter         | Description                                          |
| ------------ | -------------------------------------------- |
| time         | Time filtering, used in Explorers and Dashboards, link format follows:<br><li>Passing query time via template variables: `&time=#{TR}` <br><li>Query last 15 minutes: `&time=15m`<br><li>Set specific start and end times: `&time=1675247688602,1676457288602` |
| variable     | View variable query, generally used in dashboard views.<br/>Link format: `&variable={"host":"guance","service":"kodo"}` |
| dashboard_id | Dashboard ID, used to specify a dashboard/built-in view.<br/>Link format: `&dashboard_id=dsbd_069b2b90f562123456789123456789` |
| name         | Name, used to specify dashboard name/note name/custom Explorer name, etc.<br/>Link format: `&name=Linux Host Monitoring View` |
| query         | Label filtering or text search, generally used for data filtering in Explorers. Supports combining label filtering and text search using `space`, `AND`, `OR` (space is equivalent to AND).                                          |
| cols         | Display columns in the Explorer, generally used to specify the display columns in the Explorer. If not specified, it displays the system default.<br/>Link format: `&cols=time,host,service,message` |
| w            | Workspace ID, required when navigating across workspaces.<br/>Link format: `&w=wksp_40a73c6c2b024301a0b1d139e1234567` |

#### Available Template Variables

When adding chart links, the system defaults to providing available template variables for the currently configured chart link, which you can directly copy and apply in the link. Examples include #{TR}, #{T}, #{T.host}, #{V}, #{V.host}, etc.

#### Example Explanation

Taking linking to the current workspace CPU monitoring view as an example, the configuration is as follows:

`/scene/dashboard/dashboardDetail?dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e&name=CPU Monitoring View&w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115&time=#{TR}&variable=#{V.host}`

Link address explanation:

| Link Component       | Parameter Configuration                                         |
| ---------- | ------------------------------------------------ |
| Dashboard URL | `/scene/dashboard/dashboardDetail`               |
| Dashboard ID   | `dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e` |
| Dashboard Name | `name=CPU Monitoring View`                              |
| Workspace ID | `w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115`          |
| Time Variable   | `time=#{TR}`                                     |
| View Variable   | `variable=#{V.host}`                             |

???+ warning "Note"

    - Variables can be entered after the URL link. If the URL link already contains time variables, label variables, or view variables, modify them accordingly to avoid conflicts.
    - If a variable has multiple parameters, separate them with `,`. Use `&` to separate multiple variables.
    - Link addresses support relative path URLs.

### Link Opening Methods

Guance supports three methods to open links: **New Page**, **Current Page**, and **Slide-out Detail Page**.

- New Page: Opens the link in a new page.
- Current Page: Opens the link in the current page.
- Slide-out Detail Page: Slides out a window on the current page to open the link.

## Operation Instructions

Guance supports the following operations on chart links:

| Operation | Description |
| --- | --- |
| Enable/Disable Display | Controls whether to display associated links on the chart. |
| Edit | Allows modification of added links. |
| Delete | Deletes the current custom link. Deleted links cannot be recovered, so proceed with caution. |
| Restore to Default | Restores modified built-in links to their initial default state.

![](../img/6.link_8.png)

## Scenario Examples

**Prerequisite**: You have already created a chart in the Guance dashboard and now need to add links to the chart.

### Linking to Other Views

<div class="grid" markdown>

=== "Step One: Add Chart Link"

    In the chart link, input the name "cpu usage", add the link address based on the preset link and parameters, and choose the opening method as **Slide-out Page**.

    Alternatively, you can directly open the view you want to link to in the chart, copy the browser URL, and paste the link address, modifying the template variables as needed.

    <img src="../../img/6.link_5.1.png" width="60%" >

=== "Step Two: Open Link in Chart"

    After adding the link, click on the chart to bring up the custom link dialog box.

    ![](../img/6.link_6.png)

    Clicking the configured "cpu usage" link will slide out the linked view.

    ![](../img/6.link_7.png)

</div>

### Linking to Infrastructure

<div class="grid" markdown>

=== "Step One: Add Chart Link"

    In the chart link, input the name "Infrastructure Host Explorer", paste the copied link address from the Guance infrastructure host, and add or modify template variable parameters as needed. Choose the opening method as **Slide-out Page**.

    <img src="../../img/6.link_12.1.png" width="60%" >

=== "Step Two: Open Link in Chart"

    After adding the link, click on the chart to bring up the custom link dialog box. Clicking the configured "Infrastructure Host Explorer" link will slide out the linked content. Note that the host variable value remains consistent.

    ![](../img/2.link_11.png)

</div>

### Linking to External Help Documentation

<div class="grid" markdown>

=== "Step One: Add Chart Link"

    In the chart link, input the name "Link Help Documentation", paste the copied link address from the help manual, and choose the opening method as **Slide-out Page**.

    <img src="../../img/6.link_9.png" width="60%" >

=== "Step Two: Open Link in Chart"

    Clicking the chart will bring up the custom link dialog box. Clicking the external link will slide out the linked content. Follow the instructions in the help documentation to configure the chart.

    <img src="../../img/6.link_10.png" width="70%" >

</div>