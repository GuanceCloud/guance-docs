# Permission List
---

Guance supports setting permissions for custom roles in the workspace to meet the permission requirements of different users.

**Note**: At present, it only supports setting function operation permissions in workspace.

## Permission List

- √: permission supported(default role) & permission can be authorized(custom role);
- ×: permission not supported(default role) & permission can not be authorized(custom role).

| Features                       | Options                             | Owner | Administrator | Standard | Read-only | Custom Roles |
| ------------------------------ | ------------------------------------ | ------ | ------ | -------- | -------- | ---------- |
| General                | Default access permission        | √      | √      | √        | √        | √          |
|                                | Explorer > Filter  | √      | √      | ×        | ×        | √          |
|                                | Export             | √      | √      | √        | ×        | √          |
| Workspace Management      | API Key       | √      | √      | ×        | ×        | ×          |
|                                | Token check                | √      | √      | ×        | ×        | ×          |
|                                | Token replace             | √      | √      | ×        | ×        | ×          |
|                                |View member management             | √      | √      | √        | ×        | √          |
|                                | Invite members               | √      | √      | √        | ×        | √          |
|                                | Member management               | √      | √      | ×        | ×        | √          |
|                                | Hand over the owner        | √      | ×      | ×        | ×        | ×          |
|                                | Settings                  | √      | √      | ×        | ×        | ×          |
|                                | Dissolve workspace               | √      | ×      | ×        | ×        | ×          |
|                                | Data storage storage management          | √      | ×      | ×        | ×        | ×          |
|                                | Workspace status management                     | √      | ×      | ×        | ×        | ×          |
| Data Permission Management | Confuguration      | √      | √      | ×        | ×        | √          |
| Field Management                | Confuguration       | √      | √      | √        | ×        | √          |
| Global Labels                | Confuguration       | √      | √      | ×        | ×        | √          |
| Sharing                | Confuguration            | √      | √      | √        | ×        | √          |
| Snapshot                 | Create snapshot         | √      | √      | √        | √        | √          |
|                     | Delete snapshot | √      | √      | √        | ×        | √          |
| Billing        | Read-only permission  | √      | √      | ×        | ×        | √          |
|                                | Read-write permission | √      | ×      | ×        | ×        | ×          |
|                                | Upgrade permmision           | √      | ×      | ×        | ×        | ×          |
| Scenes                    | Confuguration            | √      | √      | √        | ×        | √          |
|                                | Chart configuration            | √      | √      | √        | ×        | √          |
|                                | Service list            | √      | √      | √        | ×        | √          |
| Events                    | Manual recovery                    | √      | √      | √        | ×        | √          |
|                         |Event data query                  | √      | √      | √        | √        | √          |
| Infrastructure     | Infrastructure configuration          | √      | √      | ×        | ×        | √          |
|             |Infrastructure data query              |√      | √      | √        | √        | √          |
| Logs                      | Log index management            | √      | √      | ×        | ×        | √          |
|                                | External index management    | √      | √      | ×        | ×        | √          |
|                                | Data forward        | √      | √      | ×        | ×        | √          |
|                                 |Log data query         |√      | √      | √        | √        | √          |
|                                 |Log data access configuration   | √      | √      | ×        | ×        | √          |
| Metrics                   | Metric description management           | √      | √      | √        | ×        | √          |
|                        | Metric data query           |√      | √      | √        | √        | √          |
| Incidents                 |Channel management            |√      | √      | √        | ×        | √          |
|                                | Channel subscribe    |√      | √      | √        | √        | √          |
|                                | View channel        |√      | √      | √        | √        | √          |
|                                 |Issue management        |√      | √      | √        | ×        | √          |
|                                 |View issue   |√      | √      | √        | √        | √          |
|                                 |Reply issue        |√      | √      | √        | ×        | √          |
|                                 |View reply   |√      | √      | √        | √        | √          |
|                                 |Level configuration   |√      | √      | ×        | ×        | √          |
| Pipelines            | Pipelines management       | √      | √      | √        | ×        | √          |
| Blacklist              | Blacklist management                   | √      | √      | √        | ×        | √          |
| Generating Metrics      | Generating metrics configuration         | √      | √      | √        | ×        | √          |
| APM            | Associated log management                         | √      | √      | √        | ×        | √          |
|                                |APM data query          |√      | √      | √        | √        | √          |
| RUM              | Application configuration           | √      | √      | √        | ×        | √          |
|                                | Tracing configuration         | √      | √      | √        | ×        | √          |
|                                 |RUM data query      |√      | √      | √        | √        | √          |
| Synthetic Tests           | Task configuration             | √      | √      | √        | ×        | √          |
|                                | Self-built node configuration   | √      | √      | √        | ×        | √          |
| Security Check             | Security check data query          | √      | √      | √        | √        | √          |
| Monitoring                  | Monitoring configuration            | √      | √      | √        | ×        | √          |
|                                | Intelligent inspection configuration       | √      | √      | √        | ×        | √          |
|                                | SLO configuration           | √      | √      | √        | ×        | √          |
|                                | Mute configuration         | √      | √      | √        | ×        | √          |
|                                | Alert strategy configuration   | √      | √      | √        | ×        | √          |
|                                | Notification target configuration | √      | √      | ×        | ×        | √          |
|DataKit                         | DCA configuration     |√      | √      | ×        | ×        | ×          |
| DataFlux Func Automata                         | Func opening/configuration     |√      | ×      | ×        | ×        | ×          |
|RUM Headless                         | RUM opening/configuration     |√      | ×      | ×        | ×        | ×          |
|                         | RUM administrator    |√      | √      | ×        | ×        | ×          |


### Permission Description Details

You can find out the specific description of the permission list through the following table.


| Features                 | Options                            | Description                                                         |
| ------------------------------ | ------------------------------------ | ------------------------------------------------------------ |
| General                | Default access rights        | View and edit components of Guance that do not have explicitly defined permissions, including<br><li> Dashboards, Notes, Exlorers, Inner Views: Read-only permission<br/><li> Dashboard Carousel: Read-only permission<br/><li> Charts: Read-only permission, Copy<br/><li> Dashboards, Notes, Exlorers: Favorite<br/><li> All Exlorer Personal Level Quick Filters: Edit permission<br/><li> All Exlorer Display Columns: Configuration permission<br/><li> APM > Service List: Read-only permission<br/><li> RUM > Application Configuration: Read-only permission<br/><li> RUM > Trace: Read-only permission<br/><li> Synthetic Tests > Task Configuration: Read-only permission<br/><li> Synthetic Tests > Self-built Node Configuration: Read-only permission<br/><li> Monitor, Intelligent Inspection, SLO, Mute Management, Alert Strategy, Notification Target: Read-only permission<br/><li> Pipelines Configuration: User pipeline, Official pipeline read-only permission<br/><li> Blacklist Configuration: Read-only permission<br/><li> Workspace Basic Information: Read-only permission<br/><li> Field Management: Read-only permission<br/><li> Data Permission Management: Read-only permission<br/><li> Sharing: Read-only permission<br/><li> Snapshot: Read-only permission (View/Copy)<br/><li> DQL Query Tool<br/><li> Integration<br/><li> Observer Helper<br/><li> Tickets<br/><li> Workspace Remarks (Personal Account Level)<br/><li> New User Guide<br/>    - Automatically pop up New User Guide<br/>    - Avatar <br/>    - View New User Guide<br/><li> Log Data Access Configuration View: Read-only<br/><li> Incident: Channel Read-only, Issue Read-only, Reply Read-only |
|                                | Explorer > Filter  | Default display shortcut filter option management for workspace level configuration<br/><li>Log explorer display column configuration management |
|                                | Export             | Including:<br/><li>Explorer: export CSV file<br/><li>Metric management: export CSV file<br/><li>Event details page: export JSON, PDF |
| Workspace management      | API Key management       | Creat, view and delete API Key                             |
|                                | Token view                | Get the Token of workspace                                         |
|                                | Token replace             | Change the Token of workspace. To have this permission, you must also have the Token View permission. |
|                                 |View Member management           |The user has view (read-only) permissions for the following pages:<br/><li>Member management, member details pag<br/><li>Role management, role details page<br/><li>SSO management, user mapping  |
|                                | Member management               | Operations related to workspace member management and SSO management, including:<br/><li>Team management (add, delete and edit)<br/><li>Invitation history<br/><li>Member information management (delete and edit)<br/><li>Role management (create, delete and edit)<br/><li>Batch edit permissions<br/><li>SSO management<br/>&nbsp; &nbsp; - SSO login (enable, disable and delete)<br/>&nbsp; &nbsp; - SAML mapping (create, delete, edit, enable and disable)<br/>&nbsp; &nbsp; - Custom mapping(create, delete and edit) |
|                                | Hand over the Owner role       | Transfer the current workspace owner to another member                           |
|                                | Settings                  | Editing operations in workspace settings page, including:<br/><li>Workspace name<br/><li>Description<br/><li>Configure migration (import and export)<br/><li>Advanced settings<br/>&nbsp; &nbsp; - Add and delete key metrics<br/>&nbsp; &nbsp; - Function menu<br/><li>Audi<br/><li>IP white list settings<br/><li>Delete data<br/>&nbsp; &nbsp; - Manually delete data in the workspace, including:<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Delete some measurement data<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Except for custom infrastructure types<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Single custom (custom details page)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - All custom (**Management > Settings > Risky Operations**)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Custom under an object classification (**Management > Settings > Risky Operations**) |
|                                | Dissolve workspace               | Dissolve workspace, including unbinding the commercial workspace from Billing Center account and deleting the workspace<br/><li>Dismissal entry in workspace locked status |
|                                | Data storage strategy management          | <li>Measurement storage strategy modification (metric management page)<br/><li>General storage strategy modification (**Management > Settings**) |
|                                | Workspace status management                     | Containing some actions when the workspace is locked<br/><li>Unlock immediately            |
| Data permission management | Configuration management      | <li>Sensitive Fields: disable, enable and configure (add and delete)<br/><li>Data Authorization: configuration (add and remove) |
| Field management                | Field configuration management       | create, edit and delete                                             |
| Sharing                | Sharing configuration management            | Chart sharing, chart unsharing, snapshot sharing, snapshot unsharing               |
| Snapshots               | Create      | Create a new snapshot. Including<br/><li>Scenes: Dashboard, Notes, Explorer<br/><li>Events: Unresolved Events, Events<br/><li>Infrastructure: Hosts, Containers, Processes, Networks, Custom<br/><li>Logs: All Logs, Cluster Analysis<br/><li>APM: Services, Overview, Traces, Error Tracking, Profile<br/><li>RUM: Views, Explorer, Traces<br/><li>Synthetic Tests: Overview, Explorer<br/><li>CI Visibility: Overview, Explorer<br/><li>Security Check: Overview, Explorer |
| | Delete        | Delete a snapshot. Including<br/><li>Scenes: Dashboard, Notes, Explorer<br/><li>Events: Unresolved Events, Events<br/><li>Infrastructure: Hosts, Containers, Processes, Networks, Custom<br/><li>Logs: All Logs, Cluster Analysis<br/><li>APM: Services, Overview, Traces, Error Tracking, Profile<br/><li>RUM: Views, Explorer, Traces<br/><li>Synthetic Tests: Overview, Explorer<br/><li>CI Visibility: Overview, Explorer<br/><li>Security Check: Overview, Explorer<br/>:warning: Read-only members can only delete snapshots created by their own account |
| Billing        | Billing read-only permission  | Current workspace usage statistics and billing expense view                           |
|                                | Billing read and write permission | It includes account balance viewing, recharging, changing settlement method, changing Billing Center account number and jumping to Billing Center. It only supports current workspace owner role members to view and initiate related operations. |
|                                | Upgrade permissions           | Upgradation from Experience Plan to Commercial Plan of the process initiation portal only supports initiation by members of the current workspace owner role. |
| Scenes                    | Scene configuration              | <li>Dashboard: create, delete, edit (with this permission, explorer supports exporting list data to the dashboard), import, export, copy, save to inner dashboard and set refresh frequency<br/><li>Regular Report: create, delete, edit<br/><li>Carousel: create, edit and delete<br/><li>Notes: create, delete, edit (with this permission, the Exlorer supports exporting list data to notes), import, export (JSON/PDF)<br/><li>Explorer: create, delete, edit, export, import, copy<br/><li>Inner dashboard > System View: export and copy<br/><li>Inner Dashboard > User View: create, delete, edit, export, copy |
|                                | Chart configuration management            | <li>Add view variables<br/><li>Edit view variables<br/><li>Delete view variables<br/><li>Add charts<br/><li>edit charts<br/><li>Combination chart<br/><li>Copy charts<br/><li>Delete charts<br/><li>Add chart grouping<br/><li>edit chart grouping<br/><li>Delete chart grouping |
|                                | Service Management            | Edit service management configuration |
| Events                    | Manual recovery                    | Manual recovery action with unrecovered events                                   |
|                        |Event data query                  | Query all event data within the workspace, including all data for both events and unresolved events (`Namespace = E or UE`).    |
| Infrastructure     | Infrastructure configuration management          | Including the host editing Label, editing infrastructure classification, adding infrastructure classification, adding labels, deleting infrastructure and other operations |
|             |Infrastructure data query           | Query all relevant data of infrastructure in the workspace, including hosts, containers, K8s, processes, custom data, historical data for the past 48 hours, and layer 4 and layer 7 network data reported to the workspace.| 
| Logs                      | Log index            | Read and write permissions. Operations include create, delete, edit, enable, disable, drag and drop.        |
|                           |Log data query             | All log data query permissions within the current workspace, including the default index for Guance Logs (L), custom indexes, bound external indexes (ES, Opensearch, SLS standard logstore), and backup logs (BL) data.                               |
|                            |Log data access configuration      | Create, edit, and delete query scope rules for all logs within the workspace. Support configuring filtering query scopes under one, multiple, or all indexes, and grant query scopes to specific roles.               |
|                                | External index    | Read and write permissions. Operations include binding and deletion.                              |
|                                | Data forward        | Read and write permissions. Operations include create and delete.                                |
| Metrics                   | Metric description management           | Edit metric description                                             |
|                        |Metric data query           |Currently, all the query of metric data within the workspace.                                  |
| Pipelines            | pipelines management       | Read and write permissions. Operations include create, edit, delete, enable, disable, import, batch export, batch delete, copy from official library.<br/><li>Logs > Pipelines<br/><li>Management > Pipelines |
| Blacklist              | Blacklist management                   | Read and write permissions. Operations include create, edit, delete, import, batch export, batch delete<br/><li>Logs > Blacklist<br/><li>Management > Blacklist |
| Generating metrics      | Generating metrics configuration management          | Operations include create, edit, delete, enable, disable<br/><li>Log-generating metrics<br/><li>APM-generating metrics<br/><li>RUM-generating metrics<br/><li>Security check-generating metrics |
| APM            | Service inventory management          | Edit service manifest configuration                                             |
|                                | Association log management                         | Edit log associated field configuration                                         |
|                       | APM data query        | Query all links and profile data in the current workspace.                         |
| RUM              | Application configuration management           | Create, edit, delete applications                                         |
|                                | Tracking configuration management         | Create, edit, delete tracking configuration                                     |
|                              | RUM data query           |Query all RUM data in the current workspace, including session, session replay, view, resource, error, long task and action data.         |
| Synthetic tests           | Task configuration management             | Create, delete, edit, enable, disable, test                           |
|                                | Self-built node configuration management   | Create, edit, delete, get configuration                                   |
| Security Check             | Security Check data query          | Query all security check related data in the current workspace.                         |
| Incident             | Channel Management          | Channel: create, edit, delete; Notification object: add, edit                         |
|              | Channel Subscription         |    Channel Subscription              |
|              | Issue Management         |    Create, edit, delete issues, upload attachments              |
|              | Level Configuration         |    Default level: enable, disable;<br/>Custom level: create, edit, delete              |
| Monitoring                  | Monitor configuration            | Create, delete, test, edit, enable, disable, import, batch export, batch delete, alarm configuration edit, create from template |
|                                | Intelligent inspection configuration       | Create, delete, test, edit, enable, disable, export                     |
|                                | SLO configuration           | Create, delete, edit, enable, disable                                 |
|                                | Mute configuration          | Create, delete, edit, enable, disable<br/><li>Monitoring > Mute management<br/><li>Infrastructure > Host Detail Page > Mute Host |
|                                | Alert strategy configuration   | Create, delete, edit alarm configuration                                      |
|                                | Notification target configuration | Create, delete, edit                                             |
|DataKit                       | DCA Configuration Management    | Create, delete, edit DataKit restart, collector, pipeline              |
|DataFlux Func Automata(funcApp)                       | Enable/Configure Func    |  Enable application, edit domain/specifications, upgrade version, reset password, disable application	              |
|RUM Headless(rumApp)                       | Enable/Configure RUM  |  Enable application, edit service address/specifications, upgrade version, disable application	              |
|                       | RUM Administrator Permissions |  View configuration information, edit service address/specifications/version/status/configuration		              |