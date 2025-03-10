# List Permission Information

---

<br />**GET /api/v1/permission/list**

## Overview
List all permission information



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| isSupportCustomRole   | boolean  |            | Filter the list of permissions that support custom role selection <br>Example: True <br>Can be empty: False <br> |


## Additional Parameter Notes

**Parameter Description**

| Parameter Name        | Type     | Required   | Default Value | Description  |
| :-------------------- | :------- | :--------- | :------------ | :----------- |
| isSupportCustomRole   | boolean  |            |               | Filter the list of permissions that support custom role selection |

If you want to add permissions for a custom role, set `isSupportCustomRole = true` when querying all permission lists



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/permission/list?isSupportCustomRole=true' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "routine.*",
            "name": "Routine",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "routine.viewerManage",
                    "name": "Explorer - Quick Filter Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "routine.exportManage",
                    "name": "Export Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "label.*",
            "name": "Global Labels",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "label.labelCfgManage",
                    "name": "Label Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 1,
            "isSupportCustomRole": 0,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 0,
            "key": "workspace.*",
            "name": "Workspace Management",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "workspace.readMember",
                    "name": "View Member Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "workspace.inviteMembers",
                    "name": "Invite Members"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "workspace.memberManage",
                    "name": "Member Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "dataScanner.*",
            "name": "Sensitive Data Scanning",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "dataScanner.cfgManage",
                    "name": "Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "dataRightsManage.*",
            "name": "Data Permissions Management",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "dataRightsManage.workspaceConfigManage",
                    "name": "Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "field.*",
            "name": "Field Management",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "field.fieldCfgManage",
                    "name": "Field Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "reExpr.*",
            "name": "Regular Expression",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "reExpr.reExprManage",
                    "name": "Regular Expression Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "share.*",
            "name": "Sharing Management",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "share.shareManage",
                    "name": "Sharing Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "snapshot.*",
            "name": "Snapshot",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "snapshot.create",
                    "name": "Create Snapshot"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "snapshot.delete",
                    "name": "Delete Snapshot"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 1,
            "isSupportCustomRole": 0,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 0,
            "key": "billing.*",
            "name": "Billing",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "billing.billingRead",
                    "name": "Billing Read-Only Access"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "scene.*",
            "name": "Scene",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "scene.setManage",
                    "name": "Scene Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "scene.chartManage",
                    "name": "Chart Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "scene.serviceManage",
                    "name": "Service List Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "event.*",
            "name": "Event",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "event.Query",
                    "name": "Event Data Query"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "event.recover",
                    "name": "Manual Recovery"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "infrastructure.*",
            "name": "Infrastructure",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "infrastructure.Query",
                    "name": "Infrastructure Data Query"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "infrastructure.setManage",
                    "name": "Infrastructure Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "log.*",
            "name": "Log",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "log.Query",
                    "name": "Log Data Query"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "log.externalIndexManage",
                    "name": "External Index Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "log.backupLogManage",
                    "name": "Backup Log Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "log.indexManage",
                    "name": "Log Index Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "dataProcessing.dataQueryRule",
                    "name": "Log Data Access Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "metric.*",
            "name": "Metrics",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "metric.Query",
                    "name": "Metrics Data Query"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "metric.metricManage",
                    "name": "Metrics Description Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "pipeline.*",
            "name": "Pipelines",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "pipeline.pipelineManage",
                    "name": "Pipeline Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "blacklist.*",
            "name": "Blacklist",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "blacklist.Manage",
                    "name": "Blacklist Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "generateMetrics.*",
            "name": "Generated Metrics",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "generateMetrics.cfgManage",
                    "name": "Generated Metrics Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "trace.*",
            "name": "APM",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "trace.Query",
                    "name": "APM Data Query"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "trace.refLogManage",
                    "name": "Associated Log Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "trace.serviceManage",
                    "name": "Service List Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "rum.*",
            "name": "RUM PV",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "rum.Query",
                    "name": "RUM PV Data Query"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "rum.trackCfgManage",
                    "name": "Tracking Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "rum.rumCfgManage",
                    "name": "Application Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "dialTest.*",
            "name": "Synthetic Tests",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "dialTest.taskManage",
                    "name": "Task Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "dialTest.customNodeManage",
                    "name": "User-defined Node Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 1,
            "isSupportCustomRole": 0,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "monitor.*",
            "name": "Monitoring",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "monitor.cfgManage",
                    "name": "Monitor Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "monitor.obsCfgManage",
                    "name": "Security Check Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "monitor.sloCfgManage",
                    "name": "SLO Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "monitor.muteCfgManage",
                    "name": "Mute Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "monitor.alarmPolicyMange",
                    "name": "Alert Strategies Configuration Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "monitor.notifyObjCfgManage",
                    "name": "Notification Targets Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "dca.*",
            "name": "DCA",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "dca.dcaManage",
                    "name": "DCA Configuration Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 0,
            "isSupportOwner": 1,
            "isSupportReadOnly": 0,
            "isSupportWsAdmin": 1,
            "key": "anomaly.*",
            "name": "Incident",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "anomaly.issueReplyManage",
                    "name": "Reply Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 0,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "anomaly.issueLevelManage",
                    "name": "Issue Level Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "anomaly.channelManage",
                    "name": "Channel Management"
                },
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 0,
                    "isSupportWsAdmin": 1,
                    "key": "anomaly.issueManage",
                    "name": "Issue Management"
                }
            ]
        },
        {
            "desc": "",
            "disabled": 0,
            "isSupportCustomRole": 1,
            "isSupportGeneral": 1,
            "isSupportOwner": 1,
            "isSupportReadOnly": 1,
            "isSupportWsAdmin": 1,
            "key": "security.*",
            "name": "Security Check",
            "subs": [
                {
                    "desc": "",
                    "disabled": 0,
                    "isSupportCustomRole": 1,
                    "isSupportGeneral": 1,
                    "isSupportOwner": 1,
                    "isSupportReadOnly": 1,
                    "isSupportWsAdmin": 1,
                    "key": "security.Query",
                    "name": "Security Check Data Query"
                }
            ]
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "6723047324511428850"
} 
```