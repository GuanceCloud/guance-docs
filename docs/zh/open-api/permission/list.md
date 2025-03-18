# 列出权限信息

---

<br />**GET /api/v1/permission/list**

## 概述
列出所有权限信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isSupportCustomRole | boolean |  | 过滤支持自定义角色选择的权限列表<br>例子: True <br>允许为空: False <br> |

## 参数补充说明

**参数说明**

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
| isSupportCustomRole | boolean |  |  | 过滤支持自定义角色选择的权限列表 |

如果要给自定义的角色添加权限，在查询所有权限列表时请设置 isSupportCustomRole = true




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/permission/list?isSupportCustomRole=true' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
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
            "name": "常规",
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
                    "name": "查看器-快捷筛选管理"
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
                    "name": "导出管理"
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
            "name": "全局标签",
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
                    "name": "标签管理"
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
            "name": "工作空间管理",
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
                    "name": "成员管理查看"
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
                    "name": "邀请成员"
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
                    "name": "成员管理"
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
            "name": "敏感数据扫描",
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
                    "name": "配置管理"
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
            "name": "数据权限管理",
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
                    "name": "配置管理"
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
            "name": "字段管理",
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
                    "name": "字段配置管理"
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
            "name": "正则表达式",
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
                    "name": "正则表达式配置管理"
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
            "name": "分享管理",
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
                    "name": "分享配置管理"
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
            "name": "快照",
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
                    "name": "新建快照"
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
                    "name": "删除快照"
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
            "name": "付费计划与账单",
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
                    "name": "付费计划与账单只读权限"
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
            "name": "场景",
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
                    "name": "场景配置管理"
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
                    "name": "图表配置管理"
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
                    "name": "服务清单管理"
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
            "name": "事件",
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
                    "name": "事件数据查询"
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
                    "name": "手动恢复"
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
            "name": "基础设施",
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
                    "name": "基础设施数据查询"
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
                    "name": "基础设施配置管理"
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
            "name": "日志",
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
                    "name": "日志数据查询"
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
                    "name": "外部索引管理"
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
                    "name": "备份日志管理"
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
                    "name": "日志索引管理"
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
                    "name": "日志数据访问配置管理"
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
            "name": "指标",
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
                    "name": "指标数据查询"
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
                    "name": "指标描述管理"
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
                    "name": "pipelines 管理"
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
            "name": "黑名单",
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
                    "name": "黑名单管理"
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
            "name": "生成指标",
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
                    "name": "生成指标配置管理"
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
            "name": "应用性能监测",
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
                    "name": "应用性能数据查询"
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
                    "name": "关联日志管理"
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
                    "name": "服务清单管理"
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
            "name": "用户访问监测",
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
                    "name": "用户访问数据查询"
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
                    "name": "追踪配置管理"
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
                    "name": "应用配置管理"
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
            "name": "可用性监测",
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
                    "name": "任务配置管理"
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
                    "name": "自建节点配置管理"
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
            "name": "监控",
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
                    "name": "监控器配置管理"
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
                    "name": "智能巡检配置管理"
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
                    "name": "SLO 配置管理"
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
                    "name": "静默配置管理"
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
                    "name": "告警策略配置管理"
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
                    "name": "通知对象配置管理"
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
                    "name": "DCA 配置管理"
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
            "name": "异常追踪",
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
                    "name": "回复管理"
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
                    "name": "issue等级管理"
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
                    "name": "频道管理"
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
                    "name": "问题管理"
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
            "name": "安全巡检",
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
                    "name": "安全巡检数据查询"
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




