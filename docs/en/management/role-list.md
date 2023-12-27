# Permission List
---

Guance supports setting permissions for custom roles in the workspace to meet the permission requirements of different users.

**Note**: At present, it only supports setting function operation permissions in workspace.

## Permission List

- √: permission supported(default role) & permission can be authorized(custom role);
- ×: permission not supported(default role) & permission can not be authorized(custom role).

| Features                       | Options Authority                             | Owner | Administrator | Standard | Read-only | Custom Roles |
| ------------------------------ | ------------------------------------ | ------ | ------ | -------- | -------- | ---------- |
| Normal                | Default access permission        | √      | √      | √        | √        | √          |
|                                | Explorer-Shortcult Management  | √      | √      | ×        | ×        | √          |
|                                | Export Management             | √      | √      | √        | ×        | √          |
| Workspace Management      | API Key Management       | √      | √      | ×        | ×        | ×          |
|                                | Token check                | √      | √      | ×        | ×        | ×          |
|                                | Token replace             | √      | √      | ×        | ×        | ×          |
|                                | Member Management               | √      | √      | ×        | ×        | √          |
|                                | Hand over the owner        | √      | ×      | ×        | ×        | ×          |
|                                | Setting Management                  | √      | √      | ×        | ×        | ×          |
|                                | Dissolve workspace               | √      | ×      | ×        | ×        | ×          |
|                                | Data storage policy Management          | √      | ×      | ×        | ×        | ×          |
|                                | Workspace status Management                     | √      | ×      | ×        | ×        | ×          |
| Data permission Management | Confuguration Management      | √      | √      | ×        | ×        | √          |
| Field Management                | Field configuration Management       | √      | √      | √        | ×        | √          |
| Sharing Management                | Sharing configuration Management            | √      | √      | ×        | ×        | √          |
| Snapshot                 | Snapshot configuration Management        | √      | √      | ×        | ×        | √          |
| Billing        | Billing read-only permission  | √      | √      | ×        | ×        | √          |
|                                | Billing read-write permission | √      | ×      | ×        | ×        | ×          |
|                                | Upgrade permmision           | √      | ×      | ×        | ×        | ×          |
| Scene                    | Scene configuration Management              | √      | √      | √        | ×        | √          |
|                                | Chart configuration Management            | √      | √      | √        | ×        | √          |
| Event                    | Manual recovery                    | √      | √      | √        | ×        | √          |
| Infrastructure     | Infrastructure configuration Management          | √      | √      | ×        | ×        | √          |
| Log                      | Log index Management            | √      | √      | ×        | ×        | √          |
|                                | Outer index Management    | √      | √      | ×        | ×        | √          |
|                                | Backup log Management        | √      | √      | ×        | ×        | √          |
| Metrics                   | Metrics description Management           | √      | √      | √        | ×        | √          |
| Pipelines            | Pipelines Management       | √      | √      | √        | ×        | √          |
| Blacklist              | Blacklist Management                   | √      | √      | √        | ×        | √          |
| Generating metrics      | Generating metrics configuration Management         | √      | √      | √        | ×        | √          |
| APM            | Service list Management          | √      | √      | √        | ×        | √          |
|                                | Associated log Management                         | √      | √      | √        | ×        | √          |
| RUM              | Application configuration Management           | √      | √      | √        | ×        | √          |
|                                | Tracing configuration Management         | √      | √      | √        | ×        | √          |
| Synthetic tests           | Task configuration Management             | √      | √      | √        | ×        | √          |
|                                | Self-built node configuration Management   | √      | √      | √        | ×        | √          |
| Monitoring                  | Monitoring configuration Management            | √      | √      | √        | ×        | √          |
|                                | Intelligent inspection configuration Management       | √      | √      | √        | ×        | √          |
|                                | SLO configuration Management           | √      | √      | √        | ×        | √          |
|                                | Mute configuration Management         | √      | √      | √        | ×        | √          |
|                                | Alarm policy configuration Management   | √      | √      | √        | ×        | √          |
|                                | Notification object configuration Management | √      | √      | ×        | ×        | √          |


### Permission Description Details

You can find out the specific description of the permission list through the following table.


| Function Module                       | Operation Permission                             | Description                                                         |
| ------------------------------ | ------------------------------------ | ------------------------------------------------------------ |
| Normal                | Default access rights        | View and edit components of Guance that do not have explicitly defined permissions, including<br><li>Dashboard, notes, explorer, inner dashboard: read-only permission<br/><li>Dashboard carousel: read-only permission<br/><li>Chart: Read-only and copy permissions<br/><li>Dashboard, notes, explorer: favorites<br/><li>All explorers: read-only permission<br/><li>All explorers personal shortcut filter: edit permission<br/><li>All explorer display columns: configure permissions<br/><li>APM-service listing: read-only permission<br/><li>RUM configuration: read-only permission<br/><li>RUM-tracing configuration: read-only permission<br/><li>Synthetic tests-task configuration: read-only permission<br/><li>Synthetic tests-Self-built node configuration: read-only permission<br/><li>Monitor, intelligent inspection, SLO, mute Management, alarm policy and notification object configuration: read-only permission<br/><li>Pipelines configuration: user pipeline, official pipeline read-only permission<br/><li>Blacklist configuration: read-only permission<br/><li>Workspace info: read-only permission<br/><li>Member Management: read-only permission<br/><li>SSO Management: read-only permission<br/><li>Role Management: read-only permission<br/><li>Field Management: read-only permission<br/><li>Data permission Management: read-only permission<br/><li>Sharing Management: read-only permission<br/><li>Snapshot Management: read-only permission(view/check)<br/><li>DQL query tool<br/><li>Integration<br/><li>Observer helper<br/><li>Experience Demo workspace<br/><li>Work order Management<br/><li>Workspace notes (personal account level)<br/><li>Beginners' guide<br/>&nbsp; &nbsp; - Automatically pop up Beginners' Guide<br/>&nbsp; &nbsp; - Profile-view Beginners' Guide |
|                                | Explorer-quick filter Management  | Default display shortcut filter option Management for workspace level configuration<br/><li>Log explorer display column configuration Management |
|                                | Export Management             | Including:<br/><li>Explorer: export CSV file<br/><li>Metric Management: export CSV file<br/><li>Event details page: export JSON, PDF |
| Workspace Management      | API Key Management       | Creat, view and delete API Key                             |
|                                | Token view                | Get the Token of workspace                                         |
|                                | Token replace             | Change the Token of workspace. To have this permission, you must also have the Token View permission. |
|                                | Member Management               | Operations related to workspace member Management and SSO Management, including:<br/><li>Invite members<br/><li>Member group Management (add, delete and modify)<br/><li>Member information Management (delete and modify)<br/><li>Role Management (new, delete and modify)<br/><li>Batch modify permissions<br/><li>SSO Management<br/>&nbsp; &nbsp; - SSO login (enable, disable and delete)<br/>&nbsp; &nbsp; - SAML mapping (create, delete, modify, enable and disable) |
|                                | Hand over the owner        | Transfer the current workspace owner to another member                           |
|                                | Setup Management                  | Editing operations in workspace settings page, including:<br/><li>Workspace name modification<br/><li>Description modification<br/><li>Configure migration (import and export)<br/><li>Advanced settings<br/>&nbsp; &nbsp; - Add and delete key metrics<br/>&nbsp; &nbsp; - Function menu Management<br/><li>Operational audition<br/><li>IP white list settings<br/><li>Data delete<br/>&nbsp; &nbsp; - Manually delete data operations in the workspace, including:<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Delete a measurement data<br/>&nbsp; &nbsp; &nbsp; &nbsp; - Except for custom objects<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Single custom object (custom object details page)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - All custom objects (Management > Settings > Dangerous Operations)<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - Custom objects under an object classificatio (Management > Settings > Dangerous Operations) |
|                                | Dissolve workspace               | Dissolve workspace, including unbinding the commercial workspace from expense center account and deleting the workspace<br/><li>Dismissal entry in workspace locked state |
|                                | Data storage policy Management          | <li>Measurement storage policy modification metric Management page<br/><li>General storage policy modification (Management > Settings) |
|                                | Workspace state Management                     | Containing some actions when the workspace is locked<br/><li>Unlock immediately            |
| Data rights Management | Configuration Management      | <li>Sensitive Fields: disable, enable and configure (add and delete)<br/><li>Data Authorization: configuration (add and remove) |
| Field Management                | Field configuration Management       | create, edit and delete                                             |
| Sharing Management                | Sharing configuration Management            | Chart sharing, chart unsharing, snapshot sharing, snapshot unsharing               |
| Snapshot                 | Snapshot configuration Management          | Create and delete snapshots. Including:<br/><li>Scenarios: dashboard, notes, explorer<br/><li>Event: uncovered event, event<br/><li>Infrastructure: host, container, process, network, custom<br/><li>Log: all logs, cluster analysis<br/><li>APM:services, overview, links, error tracking, Profile<br/><li>RUM: view, explorer, tracing<br/><li>RUM: overview and explorer<br/><li>CI visibility: overview and explorer<br/><li>Security check: overview and explorer |
| Billing        | Billing read-only permission  | Current workspace usage statistics and billing expense view                           |
|                                | Billing read and write permission | It includes account balance viewing, recharging, changing settlement method, changing expense center account number and jumping to expense center. It only supports current workspace owner role members to view and initiate related operations. |
|                                | Upgrade permissions           | Upgradation from experience plan to commercial plan of the process initiation portal only supports initiation by members of the current workspace owner role. |
| Scene                    | Scene configuration Management              | <li>Dashboard: create, delete, modify (with this permission, explorer supports exporting list data to the dashboard), import, export, copy, save to inner dashboard and set refresh frequency<br/><li>Carousel: create, modify and delete<br/><li>Notes: create, delete, modify (with this permission, the viewer supports exporting list data to notes), import, export (JSON/PDF)<br/><li>Explorer: create, delete, modify, export, import, copy<br/><li>Inner dashboard-system view: export and copy<br/><li>Inner Dashboard > User View: create, delete, modify, export, copy |
|                                | Chart configuration Management            | <li>Add view variables<br/><li>Edit view variables<br/><li>Delete view variables<br/><li>Add charts<br/><li>Modify charts<br/><li>Combination chart<br/><li>Copy charts<br/><li>Delete charts<br/><li>Add chart grouping<br/><li>Modify chart grouping<br/><li>Delete chart grouping |
| Events                    | Manual recovery                    | Manual recovery action with unrecovered events                                   |
| Infrastructure     | Infrastructure configuration Management          | Including the host editing Label, editing object classification, adding object classification, adding labels, deleting objects and other operations |
| Log                      | Log index Management            | Read and write permissions. Operations include create, delete, modify, enable, disable, drag and drop.        |
|                                | External index Management    | Read and write permissions. Operations include binding and deletion.                              |
|                                | Backup log Management        | Read and write permissions. Operations include create and delete.                                |
| Metrics                   | Metric description Management           | Edit and modify metric description                                             |
| Pipelines            | pipelines Management       | Read and write permissions. Operations include create, modify, delete, enable, disable, import, batch export, batch delete, copy from official library.<br/><li>Log - pipelines<br/><li>Management > pipelines |
| Blacklist              | Blacklist Management                   | Read and write permissions. Operations include create, modify, delete, import, batch export, batch delete<br/><li>Log - blacklist<br/><li>Management - blacklist |
| Generating metrics      | Generating metrics configuration Management          | Operations include create, modify, delete, enable, disable<br/><li>Log-generating metrics<br/><li>APM-generating metrics<br/><li>RUM-generating metrics<br/><li>Security check-generating metrics |
| APM            | Service inventory Management          | Edit service manifest configuration                                             |
|                                | Association log Management                         | Edit log associated field configuration                                         |
| RUM              | Application configuration Management           | Create, modify, delete applications                                         |
|                                | Tracking configuration Management         | Create, modify, delete tracking configuration                                     |
| Synthetic tests           | Task configuration Management             | Create, delete, modify, enable, disable, test                           |
|                                | Self-built node configuration Management   | Create, modify, delete, get configuration                                   |
| Monitoring                  | Monitor configuration Management            | Create, delete, test, modify, enable, disable, import, batch export, batch delete, alarm configuration edit, create from template |
|                                | Intelligent inspection configuration Management       | Create, delete, test, modify, enable, disable, export                     |
|                                | SLO configuration Management           | Create, delete, modify, enable, disable                                 |
|                                | Mute configuration Management          | Create, delete, modify, enable, disable<br/><li>Monitoring-mute Management<br/><li>infrastructure > Host Detail Page > Mute Host |
|                                | Alarm policy configuration Management   | Create, delete, edit alarm configuration                                      |
|                                | Notification object configuration Management | Create, delete, modify                                             |