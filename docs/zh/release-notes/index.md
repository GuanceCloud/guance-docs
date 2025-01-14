---
icon: zy/release-notes
---

# 更新日志（2025 年）

---

本文档记录观测云每次上线发布的更新内容说明。

<div class="grid cards" markdown>

- :fontawesome-regular-clipboard:{ .lg .middle }

    ***

    <table>
      <tr>
        <th><a href="https://docs.guance.com/datakit/changelog/" target="_blank">DK</a></th>
      </tr>
    </table>

    ***

    <table>
      <tr>
        <th colspan="5">SDK</th>
      </tr>
      <tr>
        <td><a href="https://docs.guance.com/real-user-monitoring/web/sdk-changelog/" target="_blank">Web</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">小程序</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## 2025 年 1 月 8 日

### OpenAPI 更新 {#openapi0108}

1. 字段管理：支持获取字段管理列表，支持[新增](../open-api/field-cfg/add.md)/[修改](../open-api/field-cfg/modify.md)/[删除](../open-api/field-cfg/delete.md)字段管理。
2. 可用性监测：支持[修改](../open-api/dialing-task/modify.md)拨测任务。
3. 异常追踪 > 日程：支持获取日程列表，支持[新建](../open-api/notification-schedule/add.md)/[修改](../open-api/notification-schedule/modify.md)/[删除](../open-api/notification-schedule/delete.md)日程。
4. 异常追踪 > 配置管理：支持获取通知策略列表，支持[新增](../open-api/issue-notification-policy/add.md)/[修改](../open-api/issue-notification-policy/modify.md)/[删除](../open-api/issue-notification-policy/delete.md)通知策略；支持获取 Issue 发现列表，支持[新建](../open-api/issue-auto-discovery/add.md)/[修改](../open-api/issue-auto-discovery/modify.md)/[启用/禁用](../open-api/issue-auto-discovery/set-disable.md)/[删除](../open-api/issue-auto-discovery/delete.md) Issue 发现配置。


### 功能更新 {#feature0108}

#### 日志

1. 日志索引优化：
    - 访问日志内置视图、日志上下文 tab 页时，将分别默认选中当前日志所在的索引、`default` 索引，两处 tab 页均支持索引的多选，同时，在开启了跨工作空间查询，并在所属菜单选取了授权工作空间后，支持在此处直接查询对应工作空间的索引数据。最终帮助用户在一个页面完整查看所关联的日志数据，优化日志查询交互。  
    - 在日志索引列出时，除 `default` 置顶展示之外，其余日志索引按照 A-Z 排序列出。
2. 日志查看器新增堆叠[查看模式](../logs/manag-explorer.md#mode)：堆叠模式下字段将会整合在同一列， 并且这些字段在单元格内部以行的形式呈现。日志信息的展示更加紧凑和清晰，方便用户快速浏览和分析。
3. 日志 Pipeline 优化：日志 Pipeline 的测试样本调整为获取日志的全部字段，并且需要以行协议格式填入。同时用户手动输入的日志也要遵循格式要求。

#### 场景

1. [表格图](../scene/visual-chart/table-chart.md)优化：
    - 多指标查询排序支持：当使用一个 DQL 进行多指标查询时，表格图现在支持进行排序。
    - 表格分页选择：新增了表格分页选择功能，用户可以根据数据量和查看需求，选择合适的分页大小。
2. 组合图表：支持调整图表的顺序。
3. 图表优化：调整了 DQL 查询组件的函数顺序，同时特别强调了 Rollup 函数的使用场景，帮助用户更好地利用 Rollup 函数进行数据聚合和分析。

#### 管理

1. 事件支持配置[数据转发](../management/backup/index.md)：支持配置事件类型的数据转发规则，将符合过滤条件的事件数据保存到观测云的对象存储及转发到外部存储，提供灵活管理事件数据的能力。

2. 工作空间新增 DataKit [环境变量](../management/env_variable.md)：工作空间支持管理 DataKit 环境变量，用户可以轻松配置和更新环境变量，实现远程同步更新 DataKit 采集配置。

3. 查询[审计事件](../management/audit-event.md)优化：新增多个字段用于记录查询信息，同时事件内容中补充了查询的时间范围，便于追踪和分析查询行为。

#### Pipeline

自动生成 Pipeline 优化：更改提示出现方式，优化产品体验。

#### AI 智能助手

AI 智能助手新增[生成图表](../guance-ai/index.md#chart)：生成图表功能基于大模型自动分析用户输入的文本数据，智能生成合适的图表，解决了手动创建图表繁琐、图表选择困难等问题。

#### 监控

[告警策略](../monitoring/alert-setting.md#member)：按照成员配置通知规则支持追加名称用于用途描述。

### 部署版更新 {#deployment0108}

1. 管理后台 > 工作空间菜单优化：
    - 工作空间列表新增主存储引擎、业务两个筛选项，支持便捷筛选工作空间；
    - 优化工作空间列表页码返回逻辑，当修改/删除某工作空间，或者修改工作空间的数据上报限制，将停留在当前页，以优化查询体验。
2. 部署版新增参数：`alertPolicyFixedNotifyTypes`，支持配置告警策略中，选择“邮件”通知方式是否显示。

### 新增集成 {#inte0108}

1. 新增 [AWS Gateway Classic ELB](/integrations/aws_elb.md)；
2. 新增 [火山引擎 TOS 对象存储](/integrations/volcengine_tos.md)；
3. 修改 AWS Classic 采集器名称；
4. 新增 [MinIO V3](/integrations/minio_v3.md)集成；
5. 更新 elasticsearch、solr、nacos、influxdb_v2、mongodb 集成（视图、文档、监控器）；
6. 更新 kubernetes 监控视图。

### Bug 修复 {#bug0108}

1. 解决了事件数据跨空间授权未生效的问题；
2. 解决了日志关联链路跳转到链路查看器携带 `trace_id` 无法查询数据的问题；
3. 解决了视图表达式查询无法进行数值填充的问题；
4. 解决了外部事件检测监控器在变更告警策略时未产生操作审计记录的问题；
5. 解决了事件显示列表的列宽无法调整的问题。