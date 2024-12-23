# 自定义前端语言

---

本文档旨在指导如何通过调整服务配置，实现前端多语言的国际化支持。

## 配置步骤

1. 在前端容器 `front-webclient` 中，配置存储映射路径：

   ```plaintext
   /config/cloudcare-forethought-webclient/lang.js -> lang.js
   ```

2. 将以下内容保存为 `lang.js` 文件。

3. 根据文件内容的格式，修改相应文本：
   - 如果需要自定义文本内容，请替换相应的 `key` 值。
   - 如果某些 `key` 无需修改，可直接删除。
   - 注意：`key` 是固定的，不能修改。

---

## 配置示例

以下是 `lang.js` 文件的内容模板：

```js
window.GC_GLOBAL_LOCAL = {
  // 英文配置
  en: {
    'left_menu.scene.create_dashboard': 'test',
  },

  // 简体中文配置
  'zh-CN': {
    // 场景相关
    'left_menu.scene.label': '场景',
    'left_menu.scene.dashboard': '仪表板',
    'left_menu.scene.create_dashboard': '创建仪表板',
    'left_menu.scene.service_manage': '服务管理',
    'left_menu.scene.regular_report': '定时报告',
    'left_menu.scene.note': '笔记',
    'left_menu.scene.create_note': '创建笔记',
    'g.viewers': '查看器',
    'left_menu.scene.built_in_view': '内置视图',

    // 事件相关
    'left_menu.event.label': '事件',
    'left_menu.event.smart_monitor': '智能监控',
    'left_menu.common.help_doc': '帮助文档',

    // 异常追踪
    'left_menu.exception_tracking.label': '异常追踪',
    'g.analysis_dashboard': '分析看板',
    'exceptions.schedule': '日程',
    'left_menu.exception_tracking.conf': '配置管理',

    // 基础设施
    'left_menu.object_admin.label': '基础设施',
    'left_menu.object_admin.host': '主机',
    'left_menu.object_admin.host_topology': '主机蜂窝图',
    'left_menu.object_admin.docker_containers': '容器',
    'left_menu.object_admin.host_processes': '进程',
    'left_menu.object_admin.network': '网络',
    'left_menu.object_admin.others': '资源目录',
    'g.custom_object': '资源目录',
    'r.object_others': '资源目录',
    'left_menu.manage.pipeline': 'Pipelines',

    // 指标相关
    'left_menu.metric.label': '指标',
    'left_menu.metric.metric_analysis': '指标分析',
    'left_menu.metric.metric_map': '指标管理',
    'r.log_query_rule_list': '数据访问',

    // 日志相关
    'left_menu.log.label': '日志',
    'left_menu.log.error_track': '错误追踪',
    'left_menu.common.indicator': '生成指标',
    'left_menu.log.log_index': '索引',
    'left_menu.log.black_list': '黑名单',
    'left_menu.log.backup_log': '数据转发',
    'left_menu.log.query_rule': '数据访问',

    // 应用性能监测
    'left_menu.apm.label': '应用性能监测',
    'left_menu.apm.service': '服务',
    'left_menu.apm.add_service': '添加服务',
    'left_menu.apm.service_topology': '服务拓扑',
    'left_menu.common.overview': '概览',
    'left_menu.apm.link': '链路',
    'left_menu.apm.error_track': '错误追踪',
    'r.profile': 'Profiling',

    // 云账单
    'left_menu.cloudbilling.label': '云账单',
    'left_menu.cloudbilling.overview': '概览',

    // 用户访问监测
    'left_menu.rum.label': '用户访问监测',
    'left_menu.rum.rum_list': '应用列表',
    'g.analysis_dashboard': '分析看板',
    'rum.heatmap': '热图',
    'rum.tracking': '追踪',
    'left_menu.integration.rum_headless': 'RUM Headless',

    // 可用性监测
    'left_menu.cloud_dial.label': '可用性监测',
    'left_menu.cloud_dial.task': '任务',
    'left_menu.cloud_dial.self_node_manage': '自建节点管理',

    // 安全巡检
    'left_menu.security.label': '安全巡检',

    // CI 可视化
    'r.ci': 'CI 可视化',

    // 监控相关
    'left_menu.monitor.label': '监控',
    'left_menu.monitor.checker': '监控器',
    'left_menu.monitor.smart_checker': '智能监控',
    'left_menu.monitor.intelligent_inspection': '智能巡检',
    'r.slo_list': 'SLO',
    'left_menu.monitor.silence_manage': '静默管理',
    'left_menu.monitor.alert_policy_manage': '告警策略管理',
    'left_menu.monitor.notification_manage': '通知对象管理',

    // 集成相关
    'left_menu.integration.label': '集成',
    'r.datakit': 'Datakit',
    'left_menu.integration.func_expand': '扩展',
    'left_menu.integration.external_data_source': '外部数据源',
    'r.dca': 'DCA',
    'left_menu.integration.mobile': '移动端',

    // 管理相关
    'left_menu.manage.label': '管理',
    'left_menu.manage.system_settings': '系统设置',
    'left_menu.manage.settings': '空间设置',
    'left_menu.manage.user_settings': '个人设置',
    'left_menu.manage.workspace_attr': '属性声明',
    'left_menu.manage.field_manage': '字段管理',
    'left_menu.manage.tag_list': '全局标签',
    'left_menu.manage.env_list': '环境变量',
    'left_menu.manage.access_authentication': '访问认证',
    'left_menu.manage.members_manage': '成员管理',
    'left_menu.manage.roles_manage': '角色管理',
    'left_menu.manage.api_key_manage': 'API Key 管理',
    'left_menu.manage.client_token_manage': 'Client Token 管理',
    'left_menu.manage.invite_list': '邀请记录',
    'left_menu.manage.data_operate': '数据处理',
    'left_menu.manage.black_list': '黑名单',
    'left_menu.manage.regexp': '正则表达式',
    'left_menu.manage.audit': '安全 & 审计',
    'left_menu.manage.cloud_account_manage': '云账号管理',
    'h.action_audit': '审计事件',
    'left_menu.manage.share_manage': '分享管理',
    'left_menu.manage.cross_namespace_auth': '跨空间授权',
    'left_menu.manage.data_compliance': '数据合规',
    'left_menu.manage.sensitive_data_desensitization': '敏感数据脱敏',
    'r.sensitive_data': '敏感数据扫描',

    // 使用统计
    'left_menu.billing.label': '使用统计',
  },
}
```

---

如果需要进一步扩展或优化，可以随时补充内容或调整格式！
