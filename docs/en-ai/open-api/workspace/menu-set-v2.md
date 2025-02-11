# Feature Menu Settings (new, supports secondary menus)

---

<br />**POST /api/v1/workspace/menu_v2/set**

## Overview
Set the current workspace feature menu. This new version involves changes to secondary menus.

## Body Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:------|:-------|:----------------|
| menu | array | Y | List of configured menu items <br>Example: [{'key': 'Scene', 'isShow': True, 'children': [{'key': 'DashboardList', 'isShow': True}, {'key': 'SceneDashboardCreate', 'isShow': True}, {'key': 'LinkToTrackService', 'isShow': True}, {'key': 'RegularReportList', 'isShow': True}, {'key': 'NotesList', 'isShow': True}, {'key': 'CreateNote', 'isShow': True}, {'key': 'ViewerList', 'isShow': True}, {'key': 'BuiltInViewList', 'isShow': True}]}, {'key': 'Events', 'isShow': True, 'children': [{'key': 'KeyEventsMonitorChart', 'isShow': True}, {'key': 'KeyEventsSmartMonitor', 'isShow': True}]}, {'key': 'Incident', 'isShow': True, 'children': [{'key': 'ExceptionsTrackingConf', 'isShow': True}]}, {'key': 'Objectadmin', 'isShow': True, 'children': [{'key': 'ObjectadminHost', 'isShow': True}, {'key': 'ObjectadminHostTopology', 'isShow': True}, {'key': 'ObjectadminDocker', 'isShow': True}, {'key': 'ObjectadminProcesses', 'isShow': True}, {'key': 'HostNetwork', 'isShow': True}, {'key': 'ObjectadminOther', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}]}, {'key': 'Metrics', 'isShow': True, 'children': [{'key': 'MetricAnalysis', 'isShow': True}, {'key': 'MetricMap', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}]}, {'key': 'LogIndi', 'isShow': True, 'children': [{'key': 'Log', 'isShow': True}, {'key': 'LogPipelineList', 'isShow': True}, {'key': 'Indicator', 'isShow': True}, {'key': 'LogIndexList', 'isShow': True}, {'key': 'LogFilterRuleList', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}, {'key': 'LogQueryRuleList', 'isShow': True}]}, {'key': 'APM', 'isShow': True, 'children': [{'key': 'LinkToTrackService', 'isShow': True}, {'key': 'LinkToTrackServiceDirected', 'isShow': True}, {'key': 'LinkToTrackDashboard', 'isShow': True}, {'key': 'LinkToTrackLink', 'isShow': True}, {'key': 'LinkToTrackError', 'isShow': True}, {'key': 'LinkToTrackProfile', 'isShow': True}, {'key': 'ApmIndicator', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}]}, {'key': 'RUM', 'isShow': True, 'children': [{'key': 'RumList', 'isShow': True}, {'key': 'RumViewer', 'isShow': True}, {'key': 'RumDashboard', 'isShow': True}, {'key': 'RumTrack', 'isShow': True}, {'key': 'RumIndicator', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}, {'key': 'RumHosted', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}]}, {'key': 'Synthetic Tests', 'isShow': True, 'children': [{'key': 'CloudDialList', 'isShow': True}, {'key': 'CloudDialDashboard', 'isShow': True}, {'key': 'CloudDialExplorer', 'isShow': True}, {'key': 'CloudDialSelfNodeList', 'isShow': True}]}, {'key': 'Security Check', 'isShow': True, 'children': [{'key': 'SecurityExplorer', 'isShow': True}, {'key': 'SecurityDashboard', 'isShow': True}, {'key': 'SecurityIndicator', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}]}, {'key': 'GitLabCI', 'isShow': True, 'children': [{'key': 'GitLabCIExplorer', 'isShow': True}, {'key': 'GitLabCIDashboard', 'isShow': True}]}, {'key': 'Monitor', 'isShow': True, 'children': [{'key': 'CheckerRuleList', 'isShow': True}, {'key': 'SmartCheckerRuleList', 'isShow': True}, {'key': 'IntelligentInspectionList', 'isShow': True}, {'key': 'SLOList', 'isShow': True}, {'key': 'SilenceList', 'isShow': True}, {'key': 'CheckerRuleGroupList', 'isShow': True}, {'key': 'AlertToList', 'isShow': True}]}, {'key': 'Integration', 'isShow': True, 'children': [{'key': 'IntegrationList', 'isShow': True}, {'key': 'Datakit', 'isShow': True}, {'key': 'FunctionDetail', 'isShow': True}, {'key': 'DCA', 'isShow': True}, {'key': 'Mobile', 'isShow': True}]}, {'key': 'Workspace', 'isShow': True, 'children': [{'key': 'WorkspaceDetail', 'isShow': True}, {'key': 'WorkspaceAttrDetail', 'isShow': True}, {'key': 'WorkspaceFieldsList', 'isShow': True}, {'key': 'WorkspaceTagsList', 'isShow': True}, {'key': 'WorkspaceMembers', 'isShow': True}, {'key': 'WorkspaceRoles', 'isShow': True}, {'key': 'APIManage', 'isShow': True}, {'key': 'MemberInviteList', 'isShow': True}, {'key': 'WorkspaceFilterRuleList', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}, {'key': 'RegexpList', 'isShow': True}, {'key': 'CloudAccountList', 'isShow': True}, {'key': 'KeyEventsAudit', 'isShow': True}, {'key': 'EmbeddedSharing', 'isShow': True}, {'key': 'CrossNamespacedataAuth', 'isShow': True}, {'key': 'DataAuthorization', 'isShow': True}, {'key': 'DataScanerList', 'isShow': True}]}, {'key': 'Billing', 'isShow': True, 'children': []}] <br>Allow null: False <br> |

## Parameter Supplemental Explanation

### Request Parameter Explanation

| Parameter Name | Type        | Required | Description          |
| :------------- | :---------- | :------- | :------------------- |
| menu           | array[json] | Y        | Menu bar configuration |

### Internal Structure of menu

| Parameter Name | Type       | Required | Description          |
| :------------- | :--------- | :------- | :------------------- |
| key            | string     | Y        | Primary menu configuration |
| isShow         | string     | Y        | Whether to display   |
| children       | array[dict]| Y        | Secondary menu configuration |

<br/>
Example:
```json
[{"key":"Scene","isShow":true,"children":[{"key":"DashboardList","isShow":true},{"key":"SceneDashboardCreate","isShow":true},{"key":"LinkToTrackService","isShow":true},{"key":"RegularReportList","isShow":true},{"key":"NotesList","isShow":true},{"key":"CreateNote","isShow":true},{"key":"ViewerList","isShow":true},{"key":"BuiltInViewList","isShow":true}]},{"key":"Billing","isShow":true,"children":[]}]
```

### Primary Menu Item Explanation

| Key                | Description      |
| :------------------ | :--------------- |
| Scene              | Scene            |
| Events             | Events           |
| Incident           | Incident Tracking |
| Objectadmin        | Infrastructure    |
| Metrics            | Metrics          |
| LogIndi            | Logs             |
| APM                | Application Performance Monitoring |
| RUM                | User Access Monitoring |
| Synthetic Tests     | Availability Monitoring |
| Security Check      | Security Inspection |
| GitLabCI           | CI Visualization |
| Monitor            | Monitoring       |
| Integration        | Integration      |
| Workspace          | Management       |
| Billing            | Paid Plan & Billing |

### Secondary Menu Configuration Corresponding to Primary Menu Items
```json
{
  "Scene": ["DashboardList", "SceneDashboardCreate", "LinkToTrackService", "RegularReportList", "NotesList", "CreateNote", "ViewerList", "BuiltInViewList"], 
  "Events": ["KeyEventsMonitorChart", "KeyEventsSmartMonitor"], 
  "Incident": ["ExceptionsTrackingConf"], 
  "Objectadmin": ["ObjectadminHost", "ObjectadminHostTopology", "ObjectadminDocker", "ObjectadminProcesses", "HostNetwork", "ObjectadminOther", "WorkspacePipelineList"], 
  "Metrics": ["MetricAnalysis", "MetricMap", "WorkspacePipelineList"], 
  "LogIndi": ["Log", "LogPipelineList", "Indicator", "LogIndexList", "LogFilterRuleList", "LogBackupExplorer", "LogQueryRuleList"], 
  "APM": ["LinkToTrackService", "LinkToTrackServiceDirected", "LinkToTrackDashboard", "LinkToTrackLink", "LinkToTrackError", "LinkToTrackProfile", "ApmIndicator", "WorkspacePipelineList", "LogBackupExplorer"], 
  "RUM": ["RumList", "RumViewer", "RumDashboard", "RumTrack", "RumIndicator", "WorkspacePipelineList", "RumHosted", "LogBackupExplorer"], 
  "Synthetic Tests": ["CloudDialList", "CloudDialDashboard", "CloudDialExplorer", "CloudDialSelfNodeList"], 
  "Security Check": ["SecurityExplorer", "SecurityDashboard", "SecurityIndicator", "WorkspacePipelineList"], 
  "GitLabCI": ["GitLabCIExplorer", "GitLabCIDashboard"], 
  "Monitor": ["CheckerRuleList", "SmartCheckerRuleList", "IntelligentInspectionList", "SLOList", "SilenceList", "CheckerRuleGroupList", "AlertToList"], 
  "Integration": ["IntegrationList", "Datakit", "FunctionDetail", "DCA", "Mobile"], 
  "Workspace": ["WorkspaceDetail", "WorkspaceAttrDetail", "WorkspaceFieldsList", "WorkspaceTagsList", "WorkspaceMembers", "WorkspaceRoles", "APIManage", "MemberInviteList", "WorkspaceFilterRuleList", "WorkspacePipelineList", "LogBackupExplorer", "RegexpList", "CloudAccountList", "KeyEventsAudit", "EmbeddedSharing", "CrossNamespacedataAuth", "DataAuthorization", "DataScanerList"], 
  "Billing": []
}
```

Note:
<br/>
1. If not configured, the front-end will treat it as a new menu and open it by default.
<br/>
2. The configured menu in the management backend affects the final display effect of the space configuration.

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/menu_v2/set' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"menu":[{"key":"Scene","value":1},{"key":"Events","value":1},{"key":"Incident","value":1},{"key":"Objectadmin","value":1},{"key":"Metrics","value":1},{"key":"LogIndi","value":1},{"key":"APM","value":1},{"key":"RUM","value":1},{"key":"Synthetic Tests","value":1},{"key":"Security Check","value":1},{"key":"GitLabCI","value":1},{"key":"Monitor","value":1},{"key":"Integration","value":1},{"key":"Workspace","value":1},{"key":"Billing","value":1}]}' \
```

## Response
```shell
{
    "code": 200,
    "content": {
        "config": [
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "DashboardList"
                    },
                    {
                        "isShow": true,
                        "key": "SceneDashboardCreate"
                    },
                    {
                        "isShow": true,
                        "key": "LinkToTrackService"
                    },
                    {
                        "isShow": true,
                        "key": "RegularReportList"
                    },
                    {
                        "isShow": true,
                        "key": "NotesList"
                    },
                    {
                        "isShow": true,
                        "key": "CreateNote"
                    },
                    {
                        "isShow": true,
                        "key": "ViewerList"
                    },
                    {
                        "isShow": true,
                        "key": "BuiltInViewList"
                    }
                ],
                "isShow": true,
                "key": "Scene"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "KeyEventsMonitorChart"
                    },
                    {
                        "isShow": true,
                        "key": "KeyEventsSmartMonitor"
                    }
                ],
                "isShow": true,
                "key": "Events"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "ExceptionsTrackingConf"
                    }
                ],
                "isShow": true,
                "key": "Incident"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "ObjectadminHost"
                    },
                    {
                        "isShow": true,
                        "key": "ObjectadminHostTopology"
                    },
                    {
                        "isShow": true,
                        "key": "ObjectadminDocker"
                    },
                    {
                        "isShow": true,
                        "key": "ObjectadminProcesses"
                    },
                    {
                        "isShow": true,
                        "key": "HostNetwork"
                    },
                    {
                        "isShow": true,
                        "key": "ObjectadminOther"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspacePipelineList"
                    }
                ],
                "isShow": true,
                "key": "Objectadmin"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "MetricAnalysis"
                    },
                    {
                        "isShow": true,
                        "key": "MetricMap"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspacePipelineList"
                    }
                ],
                "isShow": true,
                "key": "Metrics"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "Log"
                    },
                    {
                        "isShow": true,
                        "key": "LogPipelineList"
                    },
                    {
                        "isShow": true,
                        "key": "Indicator"
                    },
                    {
                        "isShow": true,
                        "key": "LogIndexList"
                    },
                    {
                        "isShow": true,
                        "key": "LogFilterRuleList"
                    },
                    {
                        "isShow": true,
                        "key": "LogBackupExplorer"
                    },
                    {
                        "isShow": true,
                        "key": "LogQueryRuleList"
                    }
                ],
                "isShow": true,
                "key": "LogIndi"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "LinkToTrackService"
                    },
                    {
                        "isShow": true,
                        "key": "LinkToTrackServiceDirected"
                    },
                    {
                        "isShow": true,
                        "key": "LinkToTrackDashboard"
                    },
                    {
                        "isShow": true,
                        "key": "LinkToTrackLink"
                    },
                    {
                        "isShow": true,
                        "key": "LinkToTrackError"
                    },
                    {
                        "isShow": true,
                        "key": "LinkToTrackProfile"
                    },
                    {
                        "isShow": true,
                        "key": "ApmIndicator"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspacePipelineList"
                    },
                    {
                        "isShow": true,
                        "key": "LogBackupExplorer"
                    }
                ],
                "isShow": true,
                "key": "APM"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "RumList"
                    },
                    {
                        "isShow": true,
                        "key": "RumViewer"
                    },
                    {
                        "isShow": true,
                        "key": "RumDashboard"
                    },
                    {
                        "isShow": true,
                        "key": "RumTrack"
                    },
                    {
                        "isShow": true,
                        "key": "RumIndicator"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspacePipelineList"
                    },
                    {
                        "isShow": true,
                        "key": "RumHosted"
                    },
                    {
                        "isShow": true,
                        "key": "LogBackupExplorer"
                    }
                ],
                "isShow": true,
                "key": "RUM"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "CloudDialList"
                    },
                    {
                        "isShow": true,
                        "key": "CloudDialDashboard"
                    },
                    {
                        "isShow": true,
                        "key": "CloudDialExplorer"
                    },
                    {
                        "isShow": true,
                        "key": "CloudDialSelfNodeList"
                    }
                ],
                "isShow": true,
                "key": "Synthetic Tests"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "SecurityExplorer"
                    },
                    {
                        "isShow": true,
                        "key": "SecurityDashboard"
                    },
                    {
                        "isShow": true,
                        "key": "SecurityIndicator"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspacePipelineList"
                    }
                ],
                "isShow": true,
                "key": "Security Check"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "GitLabCIExplorer"
                    },
                    {
                        "isShow": true,
                        "key": "GitLabCIDashboard"
                    }
                ],
                "isShow": true,
                "key": "GitLabCI"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "CheckerRuleList"
                    },
                    {
                        "isShow": true,
                        "key": "SmartCheckerRuleList"
                    },
                    {
                        "isShow": true,
                        "key": "IntelligentInspectionList"
                    },
                    {
                        "isShow": true,
                        "key": "SLOList"
                    },
                    {
                        "isShow": true,
                        "key": "SilenceList"
                    },
                    {
                        "isShow": true,
                        "key": "CheckerRuleGroupList"
                    },
                    {
                        "isShow": true,
                        "key": "AlertToList"
                    }
                ],
                "isShow": true,
                "key": "Monitor"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "IntegrationList"
                    },
                    {
                        "isShow": true,
                        "key": "Datakit"
                    },
                    {
                        "isShow": true,
                        "key": "FunctionDetail"
                    },
                    {
                        "isShow": true,
                        "key": "DCA"
                    },
                    {
                        "isShow": true,
                        "key": "Mobile"
                    }
                ],
                "isShow": true,
                "key": "Integration"
            },
            {
                "children": [
                    {
                        "isShow": true,
                        "key": "WorkspaceDetail"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspaceAttrDetail"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspaceFieldsList"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspaceTagsList"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspaceMembers"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspaceRoles"
                    },
                    {
                        "isShow": true,
                        "key": "APIManage"
                    },
                    {
                        "isShow": true,
                        "key": "MemberInviteList"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspaceFilterRuleList"
                    },
                    {
                        "isShow": true,
                        "key": "WorkspacePipelineList"
                    },
                    {
                        "isShow": true,
                        "key": "LogBackupExplorer"
                    },
                    {
                        "isShow": true,
                        "key": "RegexpList"
                    },
                    {
                        "isShow": true,
                        "key": "CloudAccountList"
                    },
                    {
                        "isShow": true,
                        "key": "KeyEventsAudit"
                    },
                    {
                        "isShow": true,
                        "key": "EmbeddedSharing"
                    },
                    {
                        "isShow": true,
                        "key": "CrossNamespacedataAuth"
                    },
                    {
                        "isShow": true,
                        "key": "DataAuthorization"
                    },
                    {
                        "isShow": true,
                        "key": "DataScanerList"
                    }
                ],
                "isShow": true,
                "key": "Workspace"
            },
            {
                "children": [],
                "isShow": true,
                "key": "Billing"
            }
        ],
        "createAt": 1719899295,
        "creator": "wsak_xxxx32",
        "declaration": {
            "business": "",
            "organization": "default_private_organization"
        },
        "deleteAt": -1,
        "id": 32,
        "keyCode": "WsMenuCfg",
        "status": 0,
        "updateAt": 1719899295,
        "updator": "wsak_xxxx32",
        "uuid": "ctcf_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-368326CE-C832-431B-ACB9-663FC37B792C"
} 
```