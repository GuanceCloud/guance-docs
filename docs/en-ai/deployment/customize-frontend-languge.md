# Custom Frontend Language

---

This document aims to guide how to achieve multi-language internationalization support for the frontend by adjusting service configurations.

## Configuration Steps

1. In the frontend container `front-webclient`, configure the storage mapping path:

   ```plaintext
   /config/cloudcare-forethought-webclient/lang.js -> lang.js
   ```

2. Save the following content as a `lang.js` file.

3. Modify the corresponding text according to the format of the file content:
   - If you need to customize the text content, replace the corresponding `key` value.
   - If some `key` values do not need to be modified, they can be directly deleted.
   - Note: The `key` is fixed and cannot be modified.

---

## Configuration Example

The following is a content template for the `lang.js` file:

```js
window.GC_GLOBAL_LOCAL = {
  // English configuration
  en: {
    'left_menu.scene.create_dashboard': 'test',
  },

  // Simplified Chinese configuration
  'zh-CN': {
    // Scene related
    'left_menu.scene.label': 'Scene',
    'left_menu.scene.dashboard': 'Dashboard',
    'left_menu.scene.create_dashboard': 'Create Dashboard',
    'left_menu.scene.service_manage': 'Service Management',
    'left_menu.scene.regular_report': 'Scheduled Report',
    'left_menu.scene.note': 'Note',
    'left_menu.scene.create_note': 'Create Note',
    'g.viewers': 'Explorer',
    'left_menu.scene.built_in_view': 'Built-in View',

    // Event related
    'left_menu.event.label': 'Event',
    'left_menu.event.smart_monitor': 'Smart Monitoring',
    'left_menu.common.help_doc': 'Help Documentation',

    // Incident
    'left_menu.exception_tracking.label': 'Incident',
    'g.analysis_dashboard': 'Analysis Board',
    'exceptions.schedule': 'Schedule',
    'left_menu.exception_tracking.conf': 'Configuration Management',

    // Infrastructure
    'left_menu.object_admin.label': 'Infrastructure',
    'left_menu.object_admin.host': 'Host',
    'left_menu.object_admin.host_topology': 'Host Topology',
    'left_menu.object_admin.docker_containers': 'Containers',
    'left_menu.object_admin.host_processes': 'Processes',
    'left_menu.object_admin.network': 'Network',
    'left_menu.object_admin.others': 'Resource Catalog',
    'g.custom_object': 'Resource Catalog',
    'r.object_others': 'Resource Catalog',
    'left_menu.manage.pipeline': 'Pipelines',

    // Metrics related
    'left_menu.metric.label': 'Metrics',
    'left_menu.metric.metric_analysis': 'Metrics Analysis',
    'left_menu.metric.metric_map': 'Metrics Management',
    'r.log_query_rule_list': 'Data Access',

    // Log related
    'left_menu.log.label': 'Log',
    'left_menu.log.error_track': 'Error Tracking',
    'left_menu.common.indicator': 'Generate Metrics',
    'left_menu.log.log_index': 'Index',
    'left_menu.log.black_list': 'Blacklist',
    'left_menu.log.backup_log': 'Data Forwarding',
    'left_menu.log.query_rule': 'Data Access',

    // APM
    'left_menu.apm.label': 'APM',
    'left_menu.apm.service': 'Service',
    'left_menu.apm.add_service': 'Add Service',
    'left_menu.apm.service_topology': 'Service Map',
    'left_menu.common.overview': 'Summary',
    'left_menu.apm.link': 'Link',
    'left_menu.apm.error_track': 'Error Tracking',
    'r.profile': 'Profiling',

    // Cloud Billing
    'left_menu.cloudbilling.label': 'Cloud Billing',
    'left_menu.cloudbilling.overview': 'Summary',

    // RUM
    'left_menu.rum.label': 'RUM',
    'left_menu.rum.rum_list': 'Application List',
    'g.analysis_dashboard': 'Analysis Board',
    'rum.heatmap': 'Heatmap',
    'rum.tracking': 'Tracking',
    'left_menu.integration.rum_headless': 'RUM Headless',

    // Synthetic Tests
    'left_menu.cloud_dial.label': 'Synthetic Tests',
    'left_menu.cloud_dial.task': 'Task',
    'left_menu.cloud_dial.self_node_manage': 'User-defined Node Management',

    // Security Check
    'left_menu.security.label': 'Security Check',

    // CI Visualization
    'r.ci': 'CI Visualization',

    // Monitoring related
    'left_menu.monitor.label': 'Monitoring',
    'left_menu.monitor.checker': 'Checker',
    'left_menu.monitor.smart_checker': 'Smart Monitoring',
    'left_menu.monitor.intelligent_inspection': 'Intelligent Inspection',
    'r.slo_list': 'SLO',
    'left_menu.monitor.silence_manage': 'Mute Management',
    'left_menu.monitor.alert_policy_manage': 'Alert Strategies',
    'left_menu.monitor.notification_manage': 'Notification Targets',

    // Integration related
    'left_menu.integration.label': 'Integration',
    'r.datakit': 'Datakit',
    'left_menu.integration.func_expand': 'Extension',
    'left_menu.integration.external_data_source': 'External Data Source',
    'r.dca': 'DCA',
    'left_menu.integration.mobile': 'Mobile',

    // Management related
    'left_menu.manage.label': 'Management',
    'left_menu.manage.system_settings': 'System Settings',
    'left_menu.manage.settings': 'Workspace Settings',
    'left_menu.manage.user_settings': 'User Settings',
    'left_menu.manage.workspace_attr': 'Attribute Claims',
    'left_menu.manage.field_manage': 'Field Management',
    'left_menu.manage.tag_list': 'Global Tags',
    'left_menu.manage.env_list': 'Environment Variables',
    'left_menu.manage.access_authentication': 'Access Authentication',
    'left_menu.manage.members_manage': 'Member Management',
    'left_menu.manage.roles_manage': 'Role Management',
    'left_menu.manage.api_key_manage': 'API Key Management',
    'left_menu.manage.client_token_manage': 'Client Token Management',
    'left_menu.manage.invite_list': 'Invite Records',
    'left_menu.manage.data_operate': 'Data Processing',
    'left_menu.manage.black_list': 'Blacklist',
    'left_menu.manage.regexp': 'Regular Expression',
    'left_menu.manage.audit': 'Security & Audit',
    'left_menu.manage.cloud_account_manage': 'Cloud Account Management',
    'h.action_audit': 'Audit Events',
    'left_menu.manage.share_manage': 'Share Management',
    'left_menu.manage.cross_namespace_auth': 'Cross Workspace Authorization',
    'left_menu.manage.data_compliance': 'Data Compliance',
    'left_menu.manage.sensitive_data_desensitization': 'Sensitive Data Masking',
    'r.sensitive_data': 'Sensitive Data Scan',

    // Usage Statistics
    'left_menu.billing.label': 'Usage Statistics',
  },
}
```

---

If further expansion or optimization is needed, feel free to add content or adjust the format at any time!