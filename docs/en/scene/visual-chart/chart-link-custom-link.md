# Custom Links 
---

This involves adding custom links to charts. Based on input in the text box, final chart-related link addresses are freely generated through parameter configuration to view relevant data. After adding a custom link, it is displayed by default and can be shown directly in the chart preview.

## Getting Started

1. Navigate to **Dashboard > Chart > Link**;
2. Define the link **Name**;
3. Add a custom link to the chart;
4. Confirm.

<img src="../../img/custom_link.png" width="70%" >

## Link Address

The link address is generated based on text box input and parameter configuration, used to associate charts with relevant data.

### Preset Links

The system provides preset links to simplify link address configuration. Preset links help quickly associate with commonly used data types without manually entering the full path.

| Associated Data Types | Preset Links                                  |
| ------------ | -------------------------------------- |
| LOGs         | `/logIndi/log/all`                                           |
| APM          | `/tracing/link/all`                                          |
| Incident     | `/tracing/errorTrack`                                        |
| Profile      | `/tracing/profile`                                           |
| CONTAINERS   | `/objectadmin/docker_containers?routerTabActive=ObjectadminDocker` |
| Pod          | `/objectadmin/kubelet_pod?routerTabActive=ObjectadminDocker` |
| Processes    | `/objectadmin/host_processes?routerTabActive=ObjectadminProcesses` |
| Dashboard    | `/scene/dashboard/dashboardDetail`                           |


### Preset Parameters {#description}

Based on the selected preset link, the system provides corresponding parameters to simplify configuration. These parameters allow you to flexibly configure the link address according to specific needs, ensuring accurate association.


| <div style="width: 160px">Parameters<div style="width: 160px">         | Description                                          |
| ------------ | -------------------------------------------- |
| `time`         | Time filter, usable in Explorers, Dashboards.<br/>Link format:<br><li>Pass query time via template variables: `&time=#{TR}` <br><li>Query the last 15 minutes: `&time=15m`<br><li>Set specific start and end times: `&time=1675247688602,1676457288602` |
| `variable`     | View variable queries, generally used in dashboard views.<br/>Link format: `&variable={"host":"guance","service":"kodo"}` |
| `dashboard_id` | Dashboard ID, usable for specifying dashboards/built-in views.<br/>Link format: `&dashboard_id=dsbd_069b2b90f562123456789123456789` |
| `name`         | Name, usable for specifying dashboard names/note names/custom viewer names, etc.<br/>Link format: `&name=Linux Host Monitoring View` |
| `query`         | Label filtering or text search, generally used for data filtering in viewers. Supports combining label filtering and text search using `spaces`, `AND`, `OR`. <br/>:warning: Spaces are equivalent to AND.       |
| `cols`         | Viewer display columns, generally used to specify the display columns of the viewer. If not specified, the system default is displayed.<br/>Link format: `&cols=time,host,service,message` |
| `w`            | Workspace ID, must be specified when cross-workspace redirection occurs.<br/>Link format: `&w=wksp_40a73c6c2b024301a0b1d139e1234567` |

### Available Template Variables

The system defaults provide template variables available for current chart links, such as `#{TR}`, `#{T}`, `#{T.host}`, `#{V}`, `#{V.host}`, etc., which can be directly used for link configuration.

### Example Explanation

As an example, associating and viewing the CPU monitoring view of the current workspace, the configuration example is as follows:

`/scene/dashboard/dashboardDetail?dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e&name=CPU Monitoring View&w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115&time=#{TR}&variable=#{V.host}`

- Link address description:

| Link Composition       | Parameter Configuration                                         |
| ---------- | ------------------------------------------------ |
| Dashboard Address | `/scene/dashboard/dashboardDetail`               |
| Dashboard ID   | `dashboard_id=dsbd_e4313axxxxxxxxxxxxxc4198775e` |
| Dashboard Name | `name=CPU Monitoring View`                              |
| Workspace ID | `w=wksp_ed134a648xxxxxxxxxxxxx9a9c6115`          |
| Time Variable   | `time=#{TR}`                                     |
| View Variable   | `variable=#{V.host}`                             |

???+ warning "Note"

    - Variables can be entered after the URL link. If the URL link already has time variables, label variables, or view variables, modifications should be made on existing variables to avoid conflicts.
    - Multiple parameters are separated by `,`, and multiple variables are linked by `&`.
    - The link address supports using relative paths.

## Link Methods

Three methods for opening links are supported:

- New Page: Open the link in a new page;
- Current Page: Open the link in the current page;
- Slide-out Details Page: Open the link in a sliding window on the current page.

## Managing Links

The following operations are supported for chart links:

- Enable/Disable Display: Control whether associated links are displayed on the chart;  
- Edit: Modify the added link;      
- Delete: Delete the current custom link, once deleted, it cannot be recovered, please proceed with caution;       
- Restore to Default: Restore modified built-in links to their initial state. 


<img src="../../img/manag_link.png" width="70%" >