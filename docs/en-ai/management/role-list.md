# Permission List
---

<<< custom_key.brand_name >>> supports setting permissions for custom roles within the workspace to meet different user permission requirements.

**Note**: Currently, only functional operation permissions within the workspace can be set.

## Permission List

- √: Default role indicates **support** for this permission; custom role indicates **support** for granting this permission to custom roles;      
- ×: Default role indicates **no support** for this permission; custom role indicates **no support** for granting this permission to custom roles.

| Feature Module                 | Operation Permissions                  | Owner | Administrator | Standard | Read-only | Custom Role |
| ------------------------------ | -------------------------------------- | ----- | ------------- | -------- | --------- | ----------- |
| General                       | Default Access Permissions             | √     | √            | √        | √         | √           |
|                               | Explorer - Shortcut Management         | √     | √            | ×        | ×         | √           |
|                               | Export Management                      | √     | √            | √        | ×         | √           |
| Workspace Management          | API Key Management                    | √     | √            | ×        | ×         | ×           |
|                               | Token View                            | √     | √            | ×        | ×         | ×           |
|                               | Token Replacement                     | √     | √            | ×        | ×         | ×           |
|                               | Client Token Management               | √     | √            | √        | ×         | √           |
|                               | Member Management View                | √     | √            | √        | ×         | √           |
|                               | Invite Members                        | √     | √            | √        | ×         | √           |
|                               | Member Management                     | √     | √            | ×        | ×         | √           |
|                               | Transfer Ownership                    | √     | ×            | ×        | ×         | ×           |
|                               | Settings Management                   | √     | √            | ×        | ×         | ×           |
|                               | Dissolve Workspace                    | √     | ×            | ×        | ×         | ×           |
|                               | Data Storage Policy Management        | √     | ×            | ×        | ×         | ×           |
|                               | Workspace Status Management           | √     | ×            | ×        | ×         | ×           |
| Data Permission Management    | Configuration Management              | √     | √            | ×        | ×         | √           |
| Sensitive Data Scan           | Configuration Management              | √     | √            | ×        | ×         | √           |
| Field Management              | Field Configuration Management        | √     | √            | √        | ×         | √           |
| Regular Expression            | Regular Expression Configuration Management | √     | √            | ×        | ×         | √           |
| Cloud Account Management      | Account Management                    | √     | √            | ×        | ×         | ×           |
|                               | Integration Configuration Management  | √     | √            | ×        | ×         | ×           |
| Global Tags                   | Global Tag Configuration Management   | √     | √            | ×        | ×         | √           |
| Share Management              | Share Configuration Management        | √     | √            | √        | ×         | √           |
| Snapshot                      | Create Snapshot                       | √     | √            | √        | √         | √           |
|                               | Delete Snapshot                       | √     | √            | √        | ×         | √           |
| Billing                       | Billing Read-Only Permissions         | √     | √            | ×        | ×         | √           |
|                               | Billing Read/Write Permissions        | √     | ×            | ×        | ×         | ×           |
|                               | Upgrade Permissions                   | √     | ×            | ×        | ×         | ×           |
| Scene                         | Scene Configuration Management        | √     | √            | √        | ×         | √           |
|                               | Chart Configuration Management        | √     | √            | √        | ×         | √           |
|                               | Service List Management               | √     | √            | √        | ×         | √           |
| Incident                      | Manual Recovery                       | √     | √            | √        | ×         | √           |
|                               | Event Data Query                      | √     | √            | √        | √         | √           |
| Infrastructure                | Infrastructure Configuration Management | √     | √            | ×        | ×         | √           |
|                               | Infrastructure Data Query             | √     | √            | √        | √         | √           |
| Log                           | Log Index Management                  | √     | √            | ×        | ×         | √           |
|                               | External Index Management             | √     | √            | ×        | ×         | √           |
|                               | Data Forwarding                       | √     | √            | ×        | ×         | √           |
|                               | Log Data Query                        | √     | √            | √        | √         | √           |
| Metrics                       | Metric Description Management         | √     | √            | √        | ×         | √           |
|                               | Metric Data Query                     | √     | √            | √        | √         | √           |
| APM                           | Associated Log Management             | √     | √            | √        | ×         | √           |
|                               | APM Data Query                        | √     | √            | √        | √         | √           |
|                               | Issue Auto Discovery                  | √     | √            | √        | ×         | √           |
| RUM                           | Application Configuration Management  | √     | √            | √        | ×         | √           |
|                               | Trace Configuration Management        | √     | √            | √        | ×         | √           |
|                               | RUM Data Query                        | √     | √            | √        | √         | √           |
|                               | Session Replay View                   | √     | √            | √        | √         | √           |
|                               | Issue Auto Discovery                  | √     | √            | √        | ×         | √           |
| Synthetic Tests               | Task Configuration Management         | √     | √            | √        | ×         | √           |
|                               | User-defined Node Configuration Management | √     | √            | √        | ×         | √           |
| Security Check                | Security Check Data Query             | √     | √            | √        | √         | √           |
| Monitoring                    | Monitor Configuration Management      | √     | √            | √        | ×         | √           |
|                               | External Event Reporting Management   | √     | √            | ×        | ×         | ×           |
|                               | Smart Inspection Configuration Management | √     | √            | √        | ×         | √           |
|                               | SLO Configuration Management          | √     | √            | √        | ×         | √           |
|                               | Mute Configuration Management         | √     | √            | √        | ×         | √           |
|                               | Alert Strategies Configuration Management | √     | √            | √        | ×         | √           |
|                               | Notification Targets Configuration Management | √     | √            | ×        | ×         | √           |
| Incident                      | Channel Management                    | √     | √            | √        | ×         | √           |
|                               | Channel Subscription                  | √     | √            | √        | √         | √           |
|                               | Channel View                          | √     | √            | √        | √         | √           |
|                               | Issue Management                      | √     | √            | √        | ×         | √           |
|                               | Issue View                            | √     | √            | √        | √         | √           |
|                               | Reply Management                      | √     | √            | √        | ×         | √           |
|                               | Reply View                            | √     | √            | √        | √         | √           |
|                               | Level Configuration                   | √     | √            | ×        | ×         | √           |
|                               | Notification Policies                 | √     | √            | √        | ×         | √           |
|                               | Schedule                              | √     | √            | √        | ×         | √           |
|                               | Issue Discovery                       | √     | √            | √        | ×         | √           |
| Pipelines                     | Pipelines Management                  | √     | √            | √        | ×         | √           |
| Blacklist                     | Blacklist Management                  | √     | √            | √        | ×         | √           |
| Generated Metrics             | Generated Metrics Configuration Management | √     | √            | √        | ×         | √           |
| DCA                           | DCA Configuration Management          | √     | √            | ×        | ×         | ×           |
| DataFlux Func (Automata)      | Func Enable/Configuration             | √     | ×            | ×        | ×         | ×           |
| RUM (Automata)                | RUM Enable/Configuration              | √     | ×            | ×        | ×         | ×           |
|                               | RUM Admin                             | √     | √            | ×        | ×         | ×           |
| Cloud Billing                 | Cloud Billing Data Query              | √     | √            | √        | √         | √           |
| External Data Sources         | Data Source Configuration Management | √     | √            | ×        | ×         | √           |
|                               | Data Source Query Permissions         | √     | √            | √        | √         | √           |
| Environment Variables         | Environment Variable Configuration Management | √     | √            | ×        | ×         | √           |
| Audit Logs                    | Audit Logs View                       | √     | √            | √        | √         | √           |

## Detailed Permission Descriptions

You can understand the specific descriptions of the permission list through the following table:

| Feature Module                 | Operation Permissions                  | Description                                                                 |
| ------------------------------ | -------------------------------------- | --------------------------------------------------------------------------- |
| General                       | Default Access Permissions             | View and edit <<< custom_key.brand_name >>> components without explicit permission definitions, including<br><li>Dashboard, Notes, Explorer, Built-in Views: read-only permission<br/><li>Carousel Dashboard: read-only permission<br/><li>Charts: read-only permission, copy<br/><li>Dashboard, Notes, Explorer: favorite<br/><li>All personal-level shortcuts in Explorer: edit permission<br/><li>Display columns in all Explorers: configuration permission<br/><li>Creator of Dashboard, Notes, Explorer: edit permission<br/><li>APM > Service List: read-only permission<br/><li>RUM > Application Configuration: read-only permission<br/><li>RUM > Trace Configuration: read-only permission<br/><li>Synthetic Tests > Task Configuration: read-only permission<br/><li>Synthetic Tests > User-defined Node Configuration: read-only permission<br/><li>Monitors, Smart Inspections, SLOs, Mute Management, Alert Strategies, Notification Targets Configuration: read-only permission<br/><li>Pipelines Configuration: user pipeline, official pipeline read-only permission<br/><li>Blacklist Configuration: read-only permission<br/><li>Basic Workspace Information: read-only permission<br/><li>Role Management: read-only permission<br/><li>Field Management: read-only permission<br/><li>Data Permission Management: read-only permission<br/><li>Regular Expression: read-only permission<br/><li>Share Management: read-only permission<br/><li>Snapshot: read-only permission (view/copy)<br/><li>DQL Query Tool<br/><li>Integration<br/><li>Assistant<br/><li>Demo Workspace<br/><li>Ticket Management<br/><li>Workspace Notes (personal account level)<br/><li>New User Guide<br/>&nbsp; &nbsp; - Automatically pop up [New User Guide]<br/>&nbsp; &nbsp; - Avatar > View New User Guide<br/><li>Log Data Access Configuration View: read-only<br/><li>Incident: read-only channels, Issues, replies, notification policies, schedules |
|                               | Explorer > Shortcut Management         | <br/><li>Default display shortcut options management at the workspace level<br/><li>Log Explorer column configuration management |
|                               | Export Management                      | Includes:<br/><li>Explorer: export CSV file, copy as cURL<br/><li>Metric Management: export CSV file<br/><li>Event Detail Page: export JSON, PDF |
| Workspace Management          | API Key Management                    | Operations such as creating, viewing, deleting API Keys.                             |
|                               | Token View                            | Obtain the workspace's Token                                         |
|                               | Token Replacement                     | Replace the workspace's Token; must also have "Token View" permission |
|                               | Client Token Management               | Operations such as creating, deleting Client Tokens |
|                               | Member Management View                | View permissions for the following pages (read-only).<br/><li>Member Management, Member Details Page<br/><li>SSO Management, SAML Mapping|
|                               | Invite Members                        | |
|                               | Member Management                     | Operations related to workspace member management, SSO management, including<br/><li>Team Management (add, delete, modify)<br/><li>Member Information Management (delete, modify)<br/><li>Role Management (create, delete, modify)<br/><li>Invitation Records<br/><li>Batch Modify Permissions<br/><li>SSO Management<br/>&nbsp; &nbsp; - SSO Login (enable, disable, delete)<br/>&nbsp; &nbsp; - SAML Mapping (create, delete, modify, enable, disable)<br/>&nbsp; &nbsp;- Custom Mapping (create, delete, modify) |
|                               | Transfer Ownership                    | Transfer the current workspace ownership to another member                           |
|                               | Settings Management                   | Editing operations on the workspace settings page, including<br/><li>Modify workspace name<br/><li>Modify description<br/><li>Configuration migration (import, export)<br/><li>Advanced settings<br/>&nbsp; &nbsp; - Add, delete key metrics<br/>&nbsp; &nbsp; - Feature menu management<br/><li>View operation audit logs<br/><li>IP whitelist settings<br/><li>Data deletion<br/>&nbsp; &nbsp; - Manually delete data within the workspace, including<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Deleting a specific metric set data<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Resource catalog<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Individual resource catalog (resource catalog detail page)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - All resource catalogs (manage-settings-risky operations)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Resource catalogs under a specific object classification (manage-settings-risky operations)<br/><li>Enable approval join |
|                               | Dissolve Workspace                    | Dissolving the workspace, including unbinding Commercial Plan workspaces from billing center accounts and workspace deletion operations<br/><li>Dissolution entry when the workspace is locked |
|                               | Data Storage Policy Management        | <li>Modify storage policy for metric sets (Metric Management page)<br/><li>Modify general storage policy (Manage-Settings page) |
|                               | Workspace Status Management           | Operations during the locked state of the workspace<br/><li>Immediate unlock            |
| Data Permission Management    | Configuration Management              | <li>Sensitive fields: disable, enable, configure (add, delete)<br/><li>Data authorization: configure (add, delete) |
| Sensitive Data Scan           | Configuration Management              | Create, edit, enable, disable, delete |
| Field Management              | Field Configuration Management        | Create, edit, delete                                             |
| Regular Expression            | Regular Expression Configuration Management | Create, edit, clone, delete               |
| Cloud Account Management      | Account Management                    | Create, edit, delete               |
|                               | Integration Configuration Management  | Install, uninstall, modify configuration	               |
| Global Tags                   | Global Tag Configuration Management   | Create, edit, delete                                             |
| Share Management              | Share Configuration Management        | Share charts, cancel chart shares, share snapshots, cancel snapshot shares               |
| Snapshot                      | Create Snapshot                       | Creating snapshots. Includes<br/><li>Scenes: Dashboards, Notes, Explorers<br/><li>Events: Unresolved Events, Events<br/><li>Infrastructure: Hosts, Containers, Processes, Network, Custom<br/><li>Logs: All Logs, Pattern Analysis<br/><li>APM: Services, Summary, Traces, Error Tracking, Profile<br/><li>RUM: Views, Explorers, Traces<br/><li>Synthetic Tests: Summary, Explorers<br/><li>CI Visualization: Summary, Explorers<br/><li>Security Checks: Summary, Explorers |
|                               | Delete Snapshot                       | Deleting snapshots. Includes<br/><li>Scenes: Dashboards, Notes, Explorers<br/><li>Events: Unresolved Events, Events<br/><li>Infrastructure: Hosts, Containers, Processes, Network, Custom<br/><li>Logs: All Logs, Pattern Analysis<br/><li>APM: Services, Summary, Traces, Error Tracking, Profile<br/><li>RUM: Views, Explorers, Traces<br/><li>Synthetic Tests: Summary, Explorers<br/><li>CI Visualization: Summary, Explorers<br/><li>Security Checks: Summary, Explorers<br/>:warning: Read-only members can only delete snapshots they created |
| Billing                       | Billing Read-Only Permissions         | <br/><li>View current workspace usage statistics and billing costs   <br/><li>Set high consumption alerts                        |
|                               | Billing Read/Write Permissions        | Includes viewing account balance, recharging, changing settlement methods, switching billing center accounts, navigating to the billing center. Only supports actions initiated by the workspace owner |
|                               | Upgrade Permissions                   | Entry point to upgrade Free Plan to Commercial Plan, only supports actions initiated by the current workspace owner |
| Scene                         | Scene Configuration Management        | <li>Dashboard: create, delete, modify (supports exporting list data to dashboard if this permission is granted), import, export, copy, save to built-in view, set refresh frequency<br/><li>Scheduled Reports: create, modify, delete<br/><li>Carousel: create, modify, delete<br/><li>Notes: create, delete, modify (supports exporting list data to notes if this permission is granted), import, export (JSON/PDF)<br/><li>Explorer: create, delete, modify, export, import, copy<br/><li>Built-in View > System View: export, clone<br/><li>Built-in View > User View: create, delete, modify, export, clone |
|                               | Chart Configuration Management        | <li>View Variables: add, edit, delete<br/><li>Charts: add, modify, combine, clone, delete<br/><li>Chart Groups: add, modify, delete |
|                               | Service List Management               | Edit service list configuration |
| Incident                      | Manual Recovery                       | Includes manual recovery operations for unresolved events                                   |
|                               | Event Data Query                      | Query all event data within the workspace, including resolved and unresolved event data (Namespace = E or UE)    |
| Infrastructure                | Infrastructure Configuration Management | Includes editing host labels, object classifications, adding object classifications, adding tags, deleting objects |
|                               | Infrastructure Data Query             | Query all infrastructure-related data within the workspace, including hosts, containers, K8s, processes, resource catalog data, historical 48-hour data, and fourth-layer, seventh-layer network data reported to the workspace. |
| Log                           | Log Index Management                  | Read/write permissions. Includes create, delete, modify, enable, disable, drag-and-drop, operations        |
|                               | External Index Management             | Read/write permissions. Includes binding, delete, operations                                |
|                               | Data Forwarding                       | Read/write permissions. Includes create, edit, delete, enable, disable, operations                                |
|                               | Log Data Query                        | Query all log data within the current workspace, including <<< custom_key.brand_name >>> logs (L) default index, custom indexes, bound external indexes (ES, Opensearch, SLS standard logstore) data, and backup logs (BL) data.                               |
| Metrics                       | Metric Description Management         | Edit and modify metric descriptions                                             |
|                               | Metric Data Query                     | Query all metric data within the current workspace                                  |
| APM                           | Associated Log Management             | Edit log association field configurations                                         |
|                               | APM Data Query                        | Query all trace and Profile data within the current workspace                         |
|                               | Issue Auto Discovery                  | Automatically discover and generate Incident based on error tracking data according to service, version, resource, error type dimensions	                        |
| RUM                           | Application Configuration Management  | Create, modify, delete applications                                         |
|                               | Trace Configuration Management        | Create, modify, delete trace configurations                                     |
|                               | RUM Data Query                        | Query all user access data within the current workspace, including `session`, `session replay`, `view`, `resource`, `error`, `long task`, `action` data         |
|                               | Session Replay View                   | View all session replay data within the current workspace	                                     |
|                               | Issue Auto Discovery                  | Automatically discover and generate Incident based on error data according to application name, environment, version, error type dimensions	                                     |
| Synthetic Tests               | Task Configuration Management         | Create, delete, modify, enable, disable, test                           |
|                               | User-defined Node Configuration Management | Create, modify, delete, obtain configuration                                   |
| Security Check                | Security Check Data Query             | Query all security check-related data within the current workspace                         |
| Monitoring                    | Monitor Configuration Management      | Create, delete, test, modify, enable, disable, import, batch export, batch delete, alert configuration editing, create from template |
|                               | External Event Reporting Management   | View Webhook addresses generated by the [External Event Detection] monitor	                     |
|                               | Smart Inspection Configuration Management | Create, delete, test, modify, enable, disable, export                     |
|                               | SLO Configuration Management          | Create, delete, modify, enable, disable                                 |
|                               | Mute Configuration Management         | Create, delete, modify, enable, disable<br/><li>Monitoring > Mute Management<br/><li>Infrastructure > Host Detail Page > Mute Host |
|                               | Alert Strategies Configuration Management | Create, delete, alert configuration editing                                     |
|                               | Notification Targets Configuration Management | Create, delete, modify                                             |
| Incident                      | Channel Management                    | Channels: create, modify, delete; Notification targets: add, modify                         |
|                               | Channel Subscription                  | Channel subscription              |
|                               | Issue Management                      | Issue creation, modification, deletion, attachment upload              |
|                               | Level Configuration                   | Default levels: enable, disable;<br/>Custom levels: create, edit, delete              |
|                               | Notification Policies                 | Creation, modification, deletion of notification policies	              |
|                               | Schedule                              | Creation, modification, deletion of schedules	              |
|                               | Issue Discovery                       | Creation, modification, deletion, enabling, disabling of Issues	             |
| Pipelines                     | Pipelines Management                  | Read/write permissions. Includes create, modify, delete, enable, disable, import, batch export, batch delete, clone from official library<br/><li>Logs > Pipelines<br/><li>Management > Pipelines |
| Blacklist                     | Blacklist Management                  | Read/write permissions. Includes create, modify, delete, import, batch export, batch delete<br/><li>Logs > Blacklist<br/><li>Management > Blacklist |
| Generated Metrics             | Generated Metrics Configuration Management | Includes create, modify, delete, enable, disable operations<br/><li>Logs > Generated Metrics<br/><li>APM > Generated Metrics<br/><li>RUM > Generated Metrics<br/><li>Security Check > Generated Metrics |
| DCA                           | DCA Configuration Management          | Restart DataKit, collectors, pipelines, blacklist creation, deletion, modification<br/><li>Configure DCA address              |
| DataFlux Func (Automata)      | Func Enable/Configuration             | Enable application, modify domain/specification, upgrade version, reset password, deactivate application	              |
| RUM (Automata)                | RUM Enable/Configuration              | Enable application, modify service address, specification, upgrade version, deactivate application	              |
|                               | RUM Admin Permissions                 | View configuration information, modify service address, specification, version, status, configuration		              |
| External Data Sources         | Data Source Configuration Management | Create, edit, delete external data sources		              |
|                               | Data Source Query Permissions         | Query external data sources			              |
| Audit Logs                    | Audit Logs View                       | View operation audit logs				              |