# 功能菜单设置(new, 支持二级菜单)

---

<br />**POST /api/v1/workspace/menu_v2/set**

## 概述
设置当前工作空间功能菜单, 新版本涉及二级菜单的变更




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| menu | array | Y | 配置的菜单栏列表<br>例子: [{'key': 'Scene', 'isShow': True, 'children': [{'key': 'DashboardList', 'isShow': True}, {'key': 'SceneDashboardCreate', 'isShow': True}, {'key': 'LinkToTrackService', 'isShow': True}, {'key': 'RegularReportList', 'isShow': True}, {'key': 'NotesList', 'isShow': True}, {'key': 'CreateNote', 'isShow': True}, {'key': 'ViewerList', 'isShow': True}, {'key': 'BuiltInViewList', 'isShow': True}]}, {'key': 'Events', 'isShow': True, 'children': [{'key': 'KeyEventsMonitorChart', 'isShow': True}, {'key': 'KeyEventsSmartMonitor', 'isShow': True}]}, {'key': 'ExceptionsTracking', 'isShow': True, 'children': [{'key': 'ExceptionsTrackingConf', 'isShow': True}]}, {'key': 'Objectadmin', 'isShow': True, 'children': [{'key': 'ObjectadminHost', 'isShow': True}, {'key': 'ObjectadminHostTopology', 'isShow': True}, {'key': 'ObjectadminDocker', 'isShow': True}, {'key': 'ObjectadminProcesses', 'isShow': True}, {'key': 'HostNetwork', 'isShow': True}, {'key': 'ObjectadminOther', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}]}, {'key': 'MetricQuery', 'isShow': True, 'children': [{'key': 'MetricAnalysis', 'isShow': True}, {'key': 'MetricMap', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}]}, {'key': 'LogIndi', 'isShow': True, 'children': [{'key': 'Log', 'isShow': True}, {'key': 'LogPipelineList', 'isShow': True}, {'key': 'Indicator', 'isShow': True}, {'key': 'LogIndexList', 'isShow': True}, {'key': 'LogFilterRuleList', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}, {'key': 'LogQueryRuleList', 'isShow': True}]}, {'key': 'Tracing', 'isShow': True, 'children': [{'key': 'LinkToTrackService', 'isShow': True}, {'key': 'LinkToTrackServiceDirected', 'isShow': True}, {'key': 'LinkToTrackDashboard', 'isShow': True}, {'key': 'LinkToTrackLink', 'isShow': True}, {'key': 'LinkToTrackError', 'isShow': True}, {'key': 'LinkToTrackProfile', 'isShow': True}, {'key': 'ApmIndicator', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}]}, {'key': 'Rum', 'isShow': True, 'children': [{'key': 'RumList', 'isShow': True}, {'key': 'RumViewer', 'isShow': True}, {'key': 'RumDashboard', 'isShow': True}, {'key': 'RumTrack', 'isShow': True}, {'key': 'RumIndicator', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}, {'key': 'RumHosted', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}]}, {'key': 'CloudDial', 'isShow': True, 'children': [{'key': 'CloudDialList', 'isShow': True}, {'key': 'CloudDialDashboard', 'isShow': True}, {'key': 'CloudDialExplorer', 'isShow': True}, {'key': 'CloudDialSelfNodeList', 'isShow': True}]}, {'key': 'Security', 'isShow': True, 'children': [{'key': 'SecurityExplorer', 'isShow': True}, {'key': 'SecurityDashboard', 'isShow': True}, {'key': 'SecurityIndicator', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}]}, {'key': 'GitLabCI', 'isShow': True, 'children': [{'key': 'GitLabCIExplorer', 'isShow': True}, {'key': 'GitLabCIDashboard', 'isShow': True}]}, {'key': 'Monitor', 'isShow': True, 'children': [{'key': 'CheckerRuleList', 'isShow': True}, {'key': 'SmartCheckerRuleList', 'isShow': True}, {'key': 'IntelligentInspectionList', 'isShow': True}, {'key': 'SLOList', 'isShow': True}, {'key': 'SilenceList', 'isShow': True}, {'key': 'CheckerRuleGroupList', 'isShow': True}, {'key': 'AlertToList', 'isShow': True}]}, {'key': 'Integration', 'isShow': True, 'children': [{'key': 'IntegrationList', 'isShow': True}, {'key': 'Datakit', 'isShow': True}, {'key': 'FunctionDetail', 'isShow': True}, {'key': 'DCA', 'isShow': True}, {'key': 'Mobile', 'isShow': True}]}, {'key': 'Workspace', 'isShow': True, 'children': [{'key': 'WorkspaceDetail', 'isShow': True}, {'key': 'WorkspaceAttrDetail', 'isShow': True}, {'key': 'WorkspaceFieldsList', 'isShow': True}, {'key': 'WorkspaceTagsList', 'isShow': True}, {'key': 'WorkspaceMembers', 'isShow': True}, {'key': 'WorkspaceRoles', 'isShow': True}, {'key': 'APIManage', 'isShow': True}, {'key': 'MemberInviteList', 'isShow': True}, {'key': 'WorkspaceFilterRuleList', 'isShow': True}, {'key': 'WorkspacePipelineList', 'isShow': True}, {'key': 'LogBackupExplorer', 'isShow': True}, {'key': 'RegexpList', 'isShow': True}, {'key': 'CloudAccountList', 'isShow': True}, {'key': 'KeyEventsAudit', 'isShow': True}, {'key': 'EmbeddedSharing', 'isShow': True}, {'key': 'CrossNamespacedataAuth', 'isShow': True}, {'key': 'DataAuthorization', 'isShow': True}, {'key': 'DataScanerList', 'isShow': True}]}, {'key': 'Billing', 'isShow': True, 'children': []}] <br>允许为空: False <br> |

## 参数补充说明


**请求参数说明**

| 参数名 | type    | 必选 | 说明                     |
| :------ | :------- | :---- | :------------------------ |
| menu   | array[json]   | Y    | 菜单栏配置               |  

**menu内部结构说明**

| 参数名 | type    | 必选 | 说明                     |
| :------ | :------- | :---- | :------------------------ |
| key   | string   | Y    | 一级菜单配置               |  
| isShow   | string   | Y    | 是否展示               |  
| children   | array[dict]   | Y    | 二级菜单配置               |  

<br/>
示列:
```json
[{"key":"Scene","isShow":true,"children":[{"key":"DashboardList","isShow":true},{"key":"SceneDashboardCreate","isShow":true},{"key":"LinkToTrackService","isShow":true},{"key":"RegularReportList","isShow":true},{"key":"NotesList","isShow":true},{"key":"CreateNote","isShow":true},{"key":"ViewerList","isShow":true},{"key":"BuiltInViewList","isShow":true}]},{"key":"Billing","isShow":true,"children":[]}]
```      

**一级菜单项说明**

| key                | 说明           |
| :------------------ | :-------------- |
| Scene              | 场景           |
| Events             | 事件           |
| ExceptionsTracking | 异常追踪       |
| Objectadmin        | 基础设施       |
| MetricQuery        | 指标           |
| LogIndi            | 日志           |
| Tracing            | 应用性能监测   |
| Rum                | 用户访问监测   |
| CloudDial          | 可用性监测     |
| Security           | 安全巡检       |
| GitLabCI           | CI 可视化      |
| Monitor            | 监控           |
| Integration        | 集成           |
| Workspace          | 管理           |
| Billing            | 付费计划与账单 |

**一级菜单对应二级菜单配置如下**
```json
{"Scene": ["DashboardList", "SceneDashboardCreate", "LinkToTrackService", "RegularReportList", "NotesList", "CreateNote", "ViewerList", "BuiltInViewList"], "Events": ["KeyEventsMonitorChart", "KeyEventsSmartMonitor"], "ExceptionsTracking": ["ExceptionsTrackingConf"], "Objectadmin": ["ObjectadminHost", "ObjectadminHostTopology", "ObjectadminDocker", "ObjectadminProcesses", "HostNetwork", "ObjectadminOther", "WorkspacePipelineList"], "MetricQuery": ["MetricAnalysis", "MetricMap", "WorkspacePipelineList"], "LogIndi": ["Log", "LogPipelineList", "Indicator", "LogIndexList", "LogFilterRuleList", "LogBackupExplorer", "LogQueryRuleList"], "Tracing": ["LinkToTrackService", "LinkToTrackServiceDirected", "LinkToTrackDashboard", "LinkToTrackLink", "LinkToTrackError", "LinkToTrackProfile", "ApmIndicator", "WorkspacePipelineList", "LogBackupExplorer"], "Rum": ["RumList", "RumViewer", "RumDashboard", "RumTrack", "RumIndicator", "WorkspacePipelineList", "RumHosted", "LogBackupExplorer"], "CloudDial": ["CloudDialList", "CloudDialDashboard", "CloudDialExplorer", "CloudDialSelfNodeList"], "Security": ["SecurityExplorer", "SecurityDashboard", "SecurityIndicator", "WorkspacePipelineList"], "GitLabCI": ["GitLabCIExplorer", "GitLabCIDashboard"], "Monitor": ["CheckerRuleList", "SmartCheckerRuleList", "IntelligentInspectionList", "SLOList", "SilenceList", "CheckerRuleGroupList", "AlertToList"], "Integration": ["IntegrationList", "Datakit", "FunctionDetail", "DCA", "Mobile"], "Workspace": ["WorkspaceDetail", "WorkspaceAttrDetail", "WorkspaceFieldsList", "WorkspaceTagsList", "WorkspaceMembers", "WorkspaceRoles", "APIManage", "MemberInviteList", "WorkspaceFilterRuleList", "WorkspacePipelineList", "LogBackupExplorer", "RegexpList", "CloudAccountList", "KeyEventsAudit", "EmbeddedSharing", "CrossNamespacedataAuth", "DataAuthorization", "DataScanerList"], "Billing": []}
```

注意：
<br/>
1. 如未配置, 前端当新菜单处理, 默认打开
<br/>
2. 管理后台存在的菜单配置会影响空间配置显示的最终效果




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/menu_v2/set' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"menu":[{"key":"Scene","value":1},{"key":"Events","value":1},{"key":"ExceptionsTracking","value":1},{"key":"Objectadmin","value":1},{"key":"MetricQuery","value":1},{"key":"LogIndi","value":1},{"key":"Tracing","value":1},{"key":"Rum","value":1},{"key":"CloudDial","value":1},{"key":"Security","value":1},{"key":"GitLabCI","value":1},{"key":"Monitor","value":1},{"key":"Integration","value":1},{"key":"Workspace","value":1},{"key":"Billing","value":1}]}' \

```




## 响应
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
                "key": "ExceptionsTracking"
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
                "key": "MetricQuery"
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
                "key": "Tracing"
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
                "key": "Rum"
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
                "key": "CloudDial"
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
                "key": "Security"
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




