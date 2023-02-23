# Permission List
---

Guance supports setting permissions for custom roles in the workspace to meet the permission requirements of different users.

> At present, it only supports setting function operation permissions in workspace.

## Permission List

- √: The default role indicates that this permission is supported, and the custom role indicates that this permission can be authorized for the custom role;
- ×: The default role indicates that this permission is not supported, and the custom role indicates that it is not supported to authorize this permission for the custom role.

| Function Module                       | Operation Authority                             | Owner | Administrator | Standard | Read-only | Custom Roles |
| ------------------------------ | ------------------------------------ | ------ | ------ | -------- | -------- | ---------- |
| Normal                | Default access permission        | √      | √      | √        | √        | √          |
|                                | Explorer-Shortcult Management  | √      | √      | ×        | ×        | √          |
|                                | Export management             | √      | √      | √        | ×        | √          |
| Workspace management      | API Key management       | √      | √      | ×        | ×        | ×          |
|                                | Token check                | √      | √      | ×        | ×        | ×          |
|                                | Token replace             | √      | √      | ×        | ×        | ×          |
|                                | Member management               | √      | √      | ×        | ×        | √          |
|                                | Hand over the owner        | √      | ×      | ×        | ×        | ×          |
|                                | Setting management                  | √      | √      | ×        | ×        | ×          |
|                                | Dissolve workspace               | √      | ×      | ×        | ×        | ×          |
|                                | Data storage policy management          | √      | ×      | ×        | ×        | ×          |
|                                | Workspace status management                     | √      | ×      | ×        | ×        | ×          |
| Data permission management | Confuguration management      | √      | √      | ×        | ×        | √          |
| Field management                | Field configuration management       | √      | √      | √        | ×        | √          |
| Sharing management                | Sharing configuration management            | √      | √      | ×        | ×        | √          |
| Snapshot                 | Snapshot configuration management        | √      | √      | ×        | ×        | √          |
| Billing        | Billing read-only permission  | √      | √      | ×        | ×        | √          |
|                                | Billing read-write permission | √      | ×      | ×        | ×        | ×          |
|                                | Upgrade permmision           | √      | ×      | ×        | ×        | ×          |
| Scene                    | Scene configuration management              | √      | √      | √        | ×        | √          |
|                                | Chart configuration management            | √      | √      | √        | ×        | √          |
| Event                    | Manual recovery                    | √      | √      | √        | ×        | √          |
| Infrastructure     | Infrastructure configuration management          | √      | √      | ×        | ×        | √          |
| Log                      | Log index management            | √      | √      | ×        | ×        | √          |
|                                | Outer index management    | √      | √      | ×        | ×        | √          |
|                                | Backup log management        | √      | √      | ×        | ×        | √          |
| Metrics                   | Metrics description management           | √      | √      | √        | ×        | √          |
| Pipelines            | Pipelines management       | √      | √      | √        | ×        | √          |
| Blacklist              | Blacklist management                   | √      | √      | √        | ×        | √          |
| Generating metrics      | Generating metrics configuration management         | √      | √      | √        | ×        | √          |
| APM            | Service list management          | √      | √      | √        | ×        | √          |
|                                | Associated log management                         | √      | √      | √        | ×        | √          |
| RUM              | Application configuration management           | √      | √      | √        | ×        | √          |
|                                | Tracing configuration management         | √      | √      | √        | ×        | √          |
| Synthetic tests           | Task configuration management             | √      | √      | √        | ×        | √          |
|                                | Self-built node configuration management   | √      | √      | √        | ×        | √          |
| Monitoring                  | Monitoring configuration management            | √      | √      | √        | ×        | √          |
|                                | Intelligent inspection configuration management       | √      | √      | √        | ×        | √          |
|                                | SLO configuration management           | √      | √      | √        | ×        | √          |
|                                | Mute configuration management         | √      | √      | √        | ×        | √          |
|                                | Alarm policy configuration management   | √      | √      | √        | ×        | √          |
|                                | Notification object configuration management | √      | √      | ×        | ×        | √          |


#### Permission Description Details

You can find out the specific description of the permission list through the following table.


| Function Module                       | Operation Permission                             | Description                                                         |
| ------------------------------ | ------------------------------------ | ------------------------------------------------------------ |
| Normal                | Default access rights        | View and edit components of Guance that do not have explicitly defined permissions, including<br><li>Dashboard, notes, explorer, inner dashboard: read-only permission<br/><li>Dashboard carousel: read-only permission<br/><li>Chart: Read-only and copy permissions<br/><li>Dashboard, notes, explorer: favorites<br/><li>All explorers: read-only permission<br/><li>All explorers personal shortcut filter: edit permission<br/><li>All explorer display columns: configure permissions<br/><li>APM-service listing: read-only permission<br/><li>RUM configuration: read-only permission<br/><li>RUM-tracing configuration: read-only permission<br/><li>Synthetic tests-task configuration: read-only permission<br/><li>Synthetic tests-Self-built node configuration: read-only permission<br/><li>Monitor, intelligent inspection, SLO, mute management, alarm policy and notification object configuration: read-only permission<br/><li>Pipelines configuration: user pipeline, official pipeline read-only permission<br/><li>Blacklist configuration: read-only permission<br/><li>Workspace info: read-only permission<br/><li>Member management: read-only permission<br/><li>SSO management: read-only permission<br/><li>Role management: read-only permission<br/><li>Field management: read-only permission<br/><li>Data permission management: read-only permission<br/><li>Sharing management: read-only permission<br/><li>Snapshot management: read-only permission(view/check)<br/><li>DQL query tool<br/><li>Integration<br/><li>Observer helper<br/><li>Experience Demo workspace<br/><li>Work order management<br/><li>Workspace notes (personal account level)<br/><li>Beginners' guide<br/>&nbsp; &nbsp; - Automatically pop up Beginners' Guide<br/>&nbsp; &nbsp; - Profile-view Beginners' Guide |
|                                | Explorer-quick filter management  | Default display shortcut filter option management for workspace level configuration<br/><li>Log explorer display column configuration management |
|                                | Export management             | Including:<br/><li>Explorer: export CSV file<br/><li>Metric management: export CSV file<br/><li>Event details page: export JSON, PDF |
| Workspace management      | API Key management       | Creat, view and delete API Key                             |
|                                | Token view                | Get the Token of workspace                                         |
|                                | Token replace             | Change the Token of workspace. To have this permission, you must also have the Token View permission. |
|                                | Member management               | Operations related to workspace member management and SSO management, including:<br/><li>Invite members<br/><li>Member group management (add, delete and modify)<br/><li>Member information management (delete and modify)<br/><li>Role management (new, delete and modify)<br/><li>Batch modify permissions<br/><li>SSO management<br/>&nbsp; &nbsp; - SSO login (enable, disable and delete)<br/>&nbsp; &nbsp; - SAML mapping (create, delete, modify, enable and disable) |
|                                | Hand over the owner        | Transfer the current workspace owner to another member                           |
|                                | Setup management                  | Editing operations in workspace settings page, including:<br/><li>Workspace name modification<br/><li>Description modification<br/><li>Configure migration (import and export)<br/><li>Advanced settings<br/>&nbsp; &nbsp; - Add and delete key metrics<br/>&nbsp; &nbsp; - Function menu management<br/><li>Operational audition<br/><li>IP white list settings<br/><li>Data delete<br/>&nbsp; &nbsp; - Manually delete data operations in the workspace, including:<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Delete a measurement data<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Except for custom objects<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Single custom object (custom object details page)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - All custom objects (Management > Settings > Dangerous Operations)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Custom objects under an object classificatio (Management > Settings > Dangerous Operations) |
|                                | Dissolve workspace               | Dissolve workspace, including unbinding the commercial workspace from expense center account and deleting the workspace<br/><li>Dismissal entry in workspace locked state |
|                                | Data storage policy management          | <li>Measurement storage policy modification metric management page<br/><li>General storage policy modification (Management > Settings) |
|                                | Workspace state management                     | Containing some actions when the workspace is locked<br/><li>Unlock immediately            |
| Data rights management | Configuration management      | <li>Sensitive Fields: disable, enable and configure (add and delete)<br/><li>Data Authorization: configuration (add and remove) |
| Field management                | Field configuration management       | create, edit and delete                                             |
| Sharing management                | Sharing configuration management            | Chart sharing, chart unsharing, snapshot sharing, snapshot unsharing               |
| Snapshot                 | Snapshot configuration management          | Create and delete snapshots. Including:<br/><li>Scenarios: dashboard, notes, explorer<br/><li>Event: uncovered event, event<br/><li>Infrastructure: host, container, process, network, custom<br/><li>Log: all logs, cluster analysis<br/><li>APM:services, overview, links, error tracking, Profile<br/><li>RUM: view, explorer, tracing<br/><li>RUM: overview and explorer<br/><li>CI visibility: overview and explorer<br/><li>Security check: overview and explorer |
| Billing        | Billing read-only permission  | Current workspace usage statistics and billing expense view                           |
|                                | Billing read and write permission | It includes account balance viewing, recharging, changing settlement method, changing expense center account number and jumping to expense center. It only supports current workspace owner role members to view and initiate related operations. |
|                                | Upgrade permissions           | Upgradation from experience plan to commercial plan of the process initiation portal only supports initiation by members of the current workspace owner role. |
| Scene                    | Scene configuration management              | <li>Dashboard: create, delete, modify (with this permission, explorer supports exporting list data to the dashboard), import, export, copy, save to inner dashboard and set refresh frequency<br/><li>Carousel: create, modify and delete<br/><li>Notes: create, delete, modify (with this permission, the viewer supports exporting list data to notes), import, export (JSON/PDF)<br/><li>Explorer: create, delete, modify, export, import, copy<br/><li>Inner dashboard-system view: export and copy<br/><li>Inner Dashboard > User View: create, delete, modify, export, copy |
|                                | Chart configuration management            | <li>Add view variables<br/><li>Edit view variables<br/><li>Delete view variables<br/><li>Add charts<br/><li>Modify charts<br/><li>Combination chart<br/><li>Copy charts<br/><li>Delete charts<br/><li>Add chart grouping<br/><li>Modify chart grouping<br/><li>Delete chart grouping |
| Events                    | Manual recovery                    | Manual recovery action with unrecovered events                                   |
| Infrastructure     | Infrastructure configuration management          | Including the host editing Label, editing object classification, adding object classification, adding labels, deleting objects and other operations |
| Log                      | Log index management            | Read and write permissions. Operations include create, delete, modify, enable, disable, drag and drop.        |
|                                | External index management    | Read and write permissions. Operations include binding and deletion.                              |
|                                | Backup log management        | Read and write permissions. Operations include create and delete.                                |
| Metrics                   | Metric description management           | Edit and modify metric description                                             |
| Pipelines            | pipelines management       | Read and write permissions. Operations include create, modify, delete, enable, disable, import, batch export, batch delete, copy from official library.<br/><li>Log - pipelines<br/><li>Management > pipelines |
| Blacklist              | Blacklist management                   | Read and write permissions. Operations include create, modify, delete, import, batch export, batch delete<br/><li>Log - blacklist<br/><li>Management - blacklist |
| Generating metrics      | Generating metrics configuration management          | Operations include create, modify, delete, enable, disable<br/><li>Log-generating metrics<br/><li>APM-generating metrics<br/><li>RUM-generating metrics<br/><li>Security check-generating metrics |
| APM            | Service inventory management          | Edit service manifest configuration                                             |
|                                | Association log management                         | Edit log associated field configuration                                         |
| RUM              | Application configuration management           | Create, modify, delete applications                                         |
|                                | Tracking configuration management         | Create, modify, delete tracking configuration                                     |
| Synthetic tests           | Task configuration management             | Create, delete, modify, enable, disable, test                           |
|                                | Self-built node configuration management   | Create, modify, delete, get configuration                                   |
| Monitoring                  | Monitor configuration management            | Create, delete, test, modify, enable, disable, import, batch export, batch delete, alarm configuration edit, create from template |
|                                | Intelligent inspection configuration management       | Create, delete, test, modify, enable, disable, export                     |
|                                | SLO configuration management           | Create, delete, modify, enable, disable                                 |
|                                | Mute configuration management          | Create, delete, modify, enable, disable<br/><li>Monitoring-mute management<br/><li>infrastructure > Host Detail Page > Mute Host |
|                                | Alarm policy configuration management   | Create, delete, edit alarm configuration                                      |
|                                | Notification object configuration management | Create, delete, modify                                             |