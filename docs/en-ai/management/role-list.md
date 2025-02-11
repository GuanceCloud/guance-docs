# Permission List
---

Guance supports setting permissions for custom roles within the workspace to meet different users' permission needs.

**Note**: Currently, only the permission settings for functional operations within the workspace are supported.

## Permission List

- √: Default role indicates **support** for this permission; custom role indicates **support** for granting this permission to custom roles;
- ×: Default role indicates **no support** for this permission; custom role indicates **no support** for granting this permission to custom roles.

| Function Module                       | Operation Permissions                             | Owner | Administrator | Standard | Read-only | Custom Role |
| ------------------------------------- | ------------------------------------------------- | ----- | ------------ | -------- | --------- | ----------- |
| General                | Default Access Rights        | √      | √            | √        | √         | √           |
|                                | Explorer - Quick Filter Management  | √      | √            | ×        | ×         | √           |
|                                | Export Management             | √      | √            | √        | ×         | √           |
| Workspace Management      | API Key Management       | √      | √            | ×        | ×         | ×           |
|                                | Token View                | √      | √            | ×        | ×         | ×           |
|                                | Token Replacement             | √      | √            | ×        | ×         | ×           |
|                                | Member Management View             | √      | √            | √        | ×         | √           |
|                                | Invite Members               | √      | √            | √        | ×         | √           |
|                                | Member Management               | √      | √            | ×        | ×         | √           |
|                                | Transfer Ownership        | √      | ×            | ×        | ×         | ×           |
|                                | Settings Management                  | √      | √            | ×        | ×         | ×           |
|                                | Dissolve Workspace               | √      | ×            | ×        | ×         | ×           |
|                                | Data Storage Policy Management          | √      | ×            | ×        | ×         | ×           |
|                                | Workspace Status Management                     | √      | ×            | ×        | ×         | ×           |
| Data Permission Management | Configuration Management      | √      | √            | ×        | ×         | √           |
| Field Management                | Field Configuration Management       | √      | √            | √        | ×         | √           |
| Global Tags                | Global Tag Configuration Management       | √      | √            | ×        | ×         | √           |
| Share Management                | Share Configuration Management            | √      | √            | √        | ×         | √           |
| Snapshot                 | Create Snapshot         | √      | √            | √        | √         | √           |
|                     | Delete Snapshot | √      | √            | √        | ×         | √           |
| Paid Plan and Billing        | Paid Plan and Billing Read-only Permissions  | √      | √            | ×        | ×         | √           |
|                                | Paid Plan and Billing Read-write Permissions | √      | ×            | ×        | ×         | ×           |
|                                | Upgrade Permissions           | √      | ×            | ×        | ×         | ×           |
| Scene                    | Scene Configuration Management              | √      | √            | √        | ×         | √           |
|                                | Chart Configuration Management            | √      | √            | √        | ×         | √           |
|                                | Service List Management            | √      | √            | √        | ×         | √           |
| Event                    | Manual Recovery                    | √      | √            | √        | ×         | √           |
|                         | Event Data Query                  | √      | √            | √        | √         | √           |
| Infrastructure     | Infrastructure Configuration Management          | √      | √            | ×        | ×         | √           |
|             | Infrastructure Data Query           | √      | √            | √        | √         | √           |
| Logs                      | Log Index Management            | √      | √            | ×        | ×         | √           |
|                                | External Index Management    | √      | √            | ×        | ×         | √           |
|                                | Data Forwarding        | √      | √            | ×        | ×         | √           |
|                                 | Log Data Query        | √      | √            | √        | √         | √           |
|                                 | Log Data Access Configuration Management   | √      | √            | ×        | ×         | √           |
| Metrics                   | Metric Description Management           | √      | √            | √        | ×         | √           |
|                        | Metric Data Query            | √      | √            | √        | √         | √           |
| Incident                 | Channel Management            | √      | √            | √        | ×         | √           |
|                                | Channel Subscription    | √      | √            | √        | √         | √           |
|                                | Channel View        | √      | √            | √        | √         | √           |
|                                 | Issue Management        | √      | √            | √        | ×         | √           |
|                                 | Issue View   | √      | √            | √        | √         | √           |
|                                 | Reply Management        | √      | √            | √        | ×         | √           |
|                                 | Reply View   | √      | √            | √        | √         | √           |
|                                 | Level Configuration   | √      | √            | ×        | ×         | √           |
| Pipelines            | Pipelines Management       | √      | √            | √        | ×         | √           |
| Blacklist              | Blacklist Management                   | √      | √            | √        | ×         | √           |
| Generated Metrics      | Generated Metrics Configuration Management          | √      | √            | √        | ×         | √           |
| APM            | Associated Log Management                         | √      | √            | √        | ×         | √           |
|                       | APM Data Query          | √      | √            | √        | √         | √           |
| RUM              | Application Configuration Management           | √      | √            | √        | ×         | √           |
|                                | Trace Configuration Management         | √      | √            | √        | ×         | √           |
|                                 | User Access Data Query      | √      | √            | √        | √         | √           |
| Synthetic Tests           | Task Configuration Management             | √      | √            | √        | ×         | √           |
|                                | User-defined Node Configuration Management   | √      | √            | √        | ×         | √           |
| Security Check             | Security Check Data Query          | √      | √            | √        | √         | √           |
| Monitoring                  | Monitor Configuration Management            | √      | √            | √        | ×         | √           |
|                                | Intelligent Inspection Configuration Management       | √      | √            | √        | ×         | √           |
|                                | SLO Configuration Management           | √      | √            | √        | ×         | √           |
|                                | Mute Configuration Management          | √      | √            | √        | ×         | √           |
|                                | Alert Strategy Configuration Management   | √      | √            | √        | ×         | √           |
|                                | Notification Targets Management | √      | √            | ×        | ×         | √           |
| DataKit                         | DCA Configuration Management     | √      | √            | ×        | ×         | ×           |
| DataFlux Func (Automata)                         | Func Enable/Configuration     | √      | ×            | ×        | ×         | ×           |
| RUM (Automata)                         | RUM Enable/Configuration     | √      | ×            | ×        | ×         | ×           |
|                         | RUM Admin    | √      | √            | ×        | ×         | ×           |

## Detailed Permission Descriptions

You can understand the specific descriptions of the permission list through the following table:

| Function Module                       | Operation Permissions                             | Description                                                         |
| ------------------------------------- | ------------------------------------------------- | ------------------------------------------------------------ |
| General                | Default Access Rights        | View and edit components in Guance that do not have explicitly defined permissions, including<br><li>Dashboard, notes, explorer, built-in views: read-only permissions<br/><li>Dashboard carousel: read-only permissions<br/><li>Charts: read-only permissions, copy<br/><li>Dashboards, notes, explorer: favorite<br/><li>All explorer-level quick filters: edit permissions<br/><li>All explorer display columns: configuration permissions<br/><li>APM - Service List: read-only permissions<br/><li>RUM - Application Configuration: read-only permissions<br/><li>RUM - Trace Configuration: read-only permissions<br/><li>Synthetic Tests - Task Configuration: read-only permissions<br/><li>Synthetic Tests - User-defined Node Configuration: read-only permissions<br/><li>Monitors, intelligent inspections, SLOs, mute management, alert strategies, notification targets configuration: read-only permissions<br/><li>Pipelines configuration: user pipelines, official pipelines read-only permissions<br/><li>Blacklist configuration: read-only permissions<br/><li>Basic workspace information: read-only permissions<br/><li>Field management: read-only permissions<br/><li>Data permission management: read-only permissions<br/><li>Share management: read-only permissions<br/><li>Snapshot: read-only permissions (view/copy)<br/><li>DQL query tool<br/><li>Integration<br/><li>Aobs assistant<br/><li>Experience Demo workspace<br/><li>Ticket management<br/><li>Workspace remarks (personal account level)<br/><li>New user guide<br/>&nbsp; &nbsp; - Automatically pop up [New User Guide]<br/>&nbsp; &nbsp; - Avatar - view new user guide<br/><li>Log data access configuration view: read-only<br/><li>Incident tracking: channel read-only, issue read-only, reply read-only |
|                                | Explorer - Quick Filter Management  | Management of default display quick filter options configured at the workspace level<br/><li>Log viewer display column configuration management |
|                                | Export Management             | Includes<br/><li>Explorer: export CSV file, copy as cURL<br/><li>Metric management: export CSV file<br/><li>Event detail page: export JSON, PDF |
| Workspace Management      | API Key Management       | Operations such as creating, viewing, deleting API Keys                             |
|                                | Token View                | Retrieve the Token for the workspace                                         |
|                                | Token Replacement             | Replace the Token for the workspace, must have "Token View" permission |
|                                 | Member Management View             | Includes read-only (view) permissions for the following pages.<br/><li>Member management, member details page<br/><li>Role management, role details page<br/><li>SSO management, SAML mapping |
|                                | Member Management               | Workspace member management and SSO management operations, including<br/><li>Team management (add, delete, modify)<br/><li>Invitation records<br/><li>Member information management (delete, modify)<br/><li>Role management (create, delete, modify)<br/><li>Batch modification of permissions<br/><li>SSO management<br/>&nbsp; &nbsp; - SSO login (enable, disable, delete)<br/>&nbsp; &nbsp; - SAML mapping (create, delete, modify, enable, disable)<br/>&nbsp; &nbsp;- Custom mapping (create, delete, modify) |
|                                | Transfer Ownership        | Transfer ownership of the current workspace to another member                           |
|                                | Settings Management                  | Editing operations on the workspace settings page, including<br/><li>Modify workspace name<br/><li>Modify description<br/><li>Configuration migration (import, export)<br/><li>Advanced settings<br/>&nbsp; &nbsp; - Add, remove key metrics<br/>&nbsp; &nbsp; - Function menu management<br/><li>View operation audit<br/><li>IP whitelist settings<br/><li>Data deletion<br/>&nbsp; &nbsp; - Manual data deletion operations within the workspace, including<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Deleting data from a specific metric set<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Resource catalog<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Single resource catalog (resource catalog detail page)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - All resource catalogs (management-settings-risky operations)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Resource catalogs under a specific object classification (management-settings-risky operations)<br/><li>Enable approval join |
|                                | Dissolve Workspace               | Dissolve the workspace, including unbinding Commercial Plan workspaces with the billing center account and deleting the workspace, etc.<br/><li>Dissolution entry under locked workspace status |
|                                | Data Storage Policy Management          | <li>Modify storage policy for metric sets (metric management page)<br/><li>Modify general storage policy (management-settings page) |
|                                | Workspace Status Management                     | Operations under locked workspace status<br/><li>Unlock immediately            |
| Data Permission Management | Configuration Management      | <li>Sensitive fields: disable, enable, configure (add, delete)<br/><li>Data authorization: configure (add, delete) |
| Field Management                | Field Configuration Management       | Create, edit, delete                                             |
| Global Tags                | Global Tag Configuration Management       | Create, edit, delete                                             |
| Share Management                | Share Configuration Management            | Share charts, cancel sharing charts, share snapshots, cancel sharing snapshots               |
| Snapshot                 | Create Snapshot         | Create snapshots. Includes<br/><li>Scenes: dashboards, notes, explorers<br/><li>Events: unrecovered events, events<br/><li>Infrastructure: hosts, containers, processes, networks, custom<br/><li>Logs: all logs, cluster analysis<br/><li>APM: services, summary, traces, error tracking, Profile<br/><li>RUM: views, explorers, traces<br/><li>Synthetic Tests: summary, explorer<br/><li>CI visualization: summary, explorer<br/><li>Security checks: summary, explorer |
| | Delete Snapshot         | Delete snapshots. Includes<br/><li>Scenes: dashboards, notes, explorers<br/><li>Events: unrecovered events, events<br/><li>Infrastructure: hosts, containers, processes, networks, custom<br/><li>Logs: all logs, cluster analysis<br/><li>APM: services, summary, traces, error tracking, Profile<br/><li>RUM: views, explorers, traces<br/><li>Synthetic Tests: summary, explorer<br/><li>CI visualization: summary, explorer<br/><li>Security checks: summary, explorer<br/>:warning: Read-only members can only delete snapshots created by their own account |
| Paid Plan and Billing        | Paid Plan and Billing Read-only Permissions  | View usage statistics and billing costs for the current workspace                           |
|                                | Paid Plan and Billing Read-write Permissions | Includes viewing account balance, recharging, changing settlement method, changing billing center accounts, navigating to the billing center. Only supports members of the current workspace owner role to view and initiate related operations |
|                                | Upgrade Permissions           | Entry point to initiate the upgrade process from Free Plan to Commercial Plan. Only supports members of the current workspace owner role to initiate |
| Scene                    | Scene Configuration Management              | <li>Dashboard: create, delete, modify (with this permission, the explorer supports exporting list data to the dashboard), import, export, copy, save to built-in views, set refresh frequency<br/><li>Scheduled reports: create, modify, delete<br/><li>Carousel: create, modify, delete<br/><li>Note: create, delete, modify (with this permission, the explorer supports exporting list data to notes), import, export (JSON/PDF)<br/><li>Explorer: create, delete, modify, export, import, copy<br/><li>Built-in views-system views: export, clone<br/><li>Built-in views-user views: create, delete, modify, export, clone |
|                                | Chart Configuration Management            | <li>Add view variables<br/><li>Edit view variables<br/><li>Delete view variables<br/><li>Add chart<br/><li>Modify chart<br/><li>Combine charts<br/><li>Clone chart<br/><li>Delete chart<br/><li>Add chart group<br/><li>Modify chart group<br/><li>Delete chart group |
|                                | Service List Management            | Edit service list configuration |
| Event                    | Manual Recovery                    | Includes manual recovery operations for unrecovered events                                   |
|                        | Event Data Query                  | Query all event data within the workspace, including all data for events and unrecovered events (Namespace = E or UE)    |
| Infrastructure     | Infrastructure Configuration Management          | Includes editing host labels, editing object classifications, adding object classifications, adding tags, deleting objects, etc. |
|             | Infrastructure Data Query           | Query all infrastructure-related data within the workspace, including host, container, K8s, process, resource catalog data, historical 48-hour data, and Layer 4, Layer 7 network data reported to the workspace. | 
| Logs                      | Log Index Management            | Read-write permissions. Includes creation, deletion, modification, enabling, disabling, dragging, and operations        |
|                                | External Index Management    | Read-write permissions. Includes binding, deletion, and operations                                |
|                                | Data Forwarding        | Read-write permissions. Includes creation, editing, deletion, enabling, disabling, and operations                                |
|                           | Log Data Query             | Query permissions for all log data within the current workspace, including Guance logs (L) default index, custom indexes, bound external indexes (ES, Opensearch, SLS standard logstore) data, and backup log (BL) data.                               |
|                            | Log Data Access Configuration Management      | Create, modify, delete rules for querying log data ranges within the workspace, supporting configuration of one, multiple, or all indexes' query ranges, and authorizing query ranges to specific roles.               |
| Metrics                   | Metric Description Management           | Edit and modify metric descriptions                                             |
|                        | Metric Data Query           | Query all metric data within the current workspace                                  |
| Pipelines            | Pipelines Management       | Read-write permissions. Includes creation, modification, deletion, enabling, disabling, importing, batch exporting, batch deletion, cloning from the official library<br/><li>Logs - pipelines<br/><li>Management - pipelines |
| Blacklist              | Blacklist Management                   | Read-write permissions. Includes creation, modification, deletion, importing, batch exporting, batch deletion<br/><li>Logs - blacklist<br/><li>Management - blacklist |
| Generated Metrics      | Generated Metrics Configuration Management          | Includes creation, modification, deletion, enabling, disabling operations<br/><li>Logs-generated metrics<br/><li>APM-generated metrics<br/><li>RUM-generated metrics<br/><li>Security check-generated metrics |
| APM            | Service List Management          | Edit service list configuration                                             |
|                                | Associated Log Management                         | Edit log association field configuration                                         |
|                       | APM Data Query        | Query all trace and Profile data within the current workspace                         |
| RUM              | Application Configuration Management           | Create, modify, delete applications                                         |
|                                | Trace Configuration Management         | Create, modify, delete trace configurations                                     |
|                              | User Access Data Query           | Query all user access data within the current workspace, including session, session replay, view, resource, error, long task, action, etc. data         |
| Synthetic Tests           | Task Configuration Management             | Create, delete, modify, enable, disable, test                           |
|                                | User-defined Node Configuration Management   | Create, modify, delete, get configuration                                   |
| Security Check             | Security Check Data Query          | Query all security check-related data within the current workspace                         |
| Incident             | Channel Management          | Channels: create, modify, delete; notification targets: add, modify                         |
|              | Channel Subscription         | Subscribe to channels              |
|              | Issue Management         | Create, modify, delete issues, upload attachments              |
|              | Level Configuration         | Default levels: enable, disable;<br/>Custom levels: create, edit, delete              |
| Monitoring                  | Monitor Configuration Management            | Create, delete, test, modify, enable, disable, import, batch export, batch delete, edit alert configurations, create from templates |
|                                | Intelligent Inspection Configuration Management       | Create, delete, test, modify, enable, disable, export                     |
|                                | SLO Configuration Management           | Create, delete, modify, enable, disable                                 |
|                                | Mute Configuration Management          | Create, delete, modify, enable, disable<br/><li>Monitoring-mute management<br/><li>Infrastructure-host details page-mute host |
|                                | Alert Strategy Configuration Management   | Create, delete, edit alert configurations                                     |
|                                | Notification Targets Management | Create, delete, modify                                             |
| DataKit                       | DCA Configuration Management    | Restart DataKit, create/delete/modify collectors, pipelines              |
| DataFlux Func (Automata)                       | Func Enable/Configuration    | Enable application, modify domain/specifications, upgrade version, reset password, deactivate application	              |
| RUM (Automata)                       | RUM Enable/Configuration  | Enable application, modify service address/specifications, upgrade version, deactivate application	              |
|                       | RUM Admin Permissions | View configuration information, modify service address/specifications/version/status/configuration		              |