# 检测规则
---

<<< custom_key.brand_name >>>支持十几种监控检测规则，覆盖不同数据范围。

## 规则类型 {#type}

<font size=2>

| <div style="width: 170px">规则名称</div> | <div style="width: 120px">数据范围</div> | 基本描述 |
| --- | --- | --- |
| [阈值检测](./threshold-detection.md) | 全部 | 基于设置的阈值对指标数据进行异常检测。 |
| [突变检测](./mutation-detection.md) | 指标(M) | 基于历史数据对指标的突发反常表现进行异常检测，多适用于业务数据、时问窗短的场景。 |
| [区间检测](./interval-detection.md) | 指标(M) | 基于动态阈值范围对指标的异常数据点进行检测，多适用于趋势稳定时间线。 |
| [区间检测 V2](./interval-detection-v2.md) | 指标(M) | 基于动态阈值范围对指标的异常数据点进行检测，多适用于趋势稳定时间线 |
| [离群检测](./outlier-detection.md) | 指标(M) | 检测特定分组下检测对象的指标/统计数据是否存在离群偏差情况。 |
| [日志检测](./log-detection.md) | 日志(L) | 基于日志数据进行业务应用的异常检测。 |
| [进程异常检测](./processes-detection.md) | 进程对象(O::`host_processes`) | 定时检测进程数据，了解进程异常情况。 |
| [基础设施存活检测 V2](./infrastructure-detection.md) | 对象(O) | 基于基础设施对象数据，设置存活条件，监控基础设施的稳定性。 |
| [应用性能指标检测](./application-performance-detection.md) | 链路(T) | 基于应用性能监测数据，设置阈值规则，检测异常情况。 |
| [用户访问指标检测](./real-user-detection.md) | 用户访问数据(R) | 基于用户访问监测数据，设置阈值规则，检测异常情况。 |
| [组合检测](./composite-detection.md) | 全部 | 将多个监控器的结果通过表达式组合成一个监控器，基于组合后的结果进行告警。 |
| [安全巡检异常检测](./security_checker.md) | 安全巡检(S) | 基于安全巡检产生的数据进行异常检测，可以有效感知主机健康状态。 |
| [可用性数据检测](./usability-detection.md) | 可用性数据(L::`类型`) | 基于可用性监测数据，设置阈值规则，检测异常情况。 |
| [网络数据检测](./network-detection.md) | 网络(N) | 基于网络数据，设置阈值规则，检测网络性能的稳定性。 |
| [外部事件检测](./third-party-event-detection.md) | 其他 | 通过指定 URL 地址，将第三方系统产生的异常事件或记录以 POST 请求方式发送到 HTTP 服务器后生成<<< custom_key.brand_name >>>的事件数据。 |

</font>

## 规则配置

### 检测配置 {detection-config}

针对不同[检测规则](#type)设定对应的检测频率、检测区间、检测指标等信息。

### 事件通知 {#notice}

#### 事件标题

定义告警触发条件的事件名称；可使用预置的[模板变量](../event-template.md)。

???+ warning "注意"

    最新版本中，监控器名称将由事件标题输入后同步生成。旧的监控器中可能存在监控器名称和事件标题不一致的情况，建议同步至最新。

#### 事件内容 {#content}

写入事件通知内容，满足触发条件时，系统会对外发送该部分内容。一般包含以下信息：

- Markdown 格式的正文；
- 可插入[关联链接](#links)和[模板变量](../event-template.md)；
- 基于[高级配置](#advanced-settings)添加关联日志或错误信息；
- 发送事件内容的目标通知成员。

???+ warning "注意"

    仅当启用关联异常追踪时，`@ 成员`配置才会生效并向指定成员发送此处的事件内容。


##### 关联链接 {links}

监控器会根据[检测配置](#detection-config)中的检测指标自动生成跳转链接。您可以在插入链接后调整过滤条件和时间范围。一般为固定的链接地址前缀，其中包含当前域名以及工作空间 ID；您也可以选择自定义跳转链接。

其中，若需要插入跳转到仪表板的链接，基于以上逻辑，还需补充仪表板的 ID 和名称，按需调整视图变量和时间范围。

<img src="../../img/monitor-link.png" width="70%" >

##### 自定义高级配置 {#advanced-settings}

通过高级配置，可以在事件内容中添加关联日志或错误堆栈，以便查看异常情况发生时的上下文数据。

<img src="../../img/advanced-settings.png" width="70%" >

- 添加关联日志：

查询：

如：获取一条索引为 `default` 的日志 `message`：

```
{% set dql_data = DQL("L::RE(`.*`):(`message`) { `index` = 'default' } LIMIT 1") %}
```

关联日志：



```
{{ dql_data.message | limit_lines(10) }}
```

- 添加关联错误堆栈
  
查询：

```
{% set dql_data = DQL("T::re(`.*`):(`error_message`,`error_stack`){ (`source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile']) AND (`error_stack` = exists()) } LIMIT 1") %}
```

关联错误堆栈：

```
{{ dql_data.error_message | limit_lines(10) }}

{{ dql_data.error_stack | limit_lines(10) }}
```


##### 自定义通知内容 {#custom}

默认情况下，系统会使用[事件内容](#content)作为告警通知内容。如果需要自定义实际对外发送的通知，可以选择在此处启用开关，填入通知信息。

<img src="../../img/custom-enable.png" width="70%" >

???+ warning "注意"

    不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。

#### 数据断档事件

即自定义数据断档通知内容。您可以同步配置该类事件最终对外发送时的标题、内容等信息。

若此处没有配置，最终对外发送时将自动使用官方默认的通知模版。

<img src="../../img/8.monitor_2.png" width="80%" >

#### 关联异常追踪 {#issue}

开启关联后，若该监控器下产生了异常事件，将同步创建 Issue。您可以选择针对不同的事件等级同步创建 Issue。

1. 选择事件等级；
2. 定义最终产生的 Issue 的等级；
3. 选择该类 Issue 的负责人；
4. 选定投递频道；
5. 按需选择是否在事件恢复后，同步关闭 Issue。

此处产生的 Issue 可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。



### 告警配置 {#alert}

<img src="../../img/strategy-create.png" width="60%" >

监控满足触发条件后，立即发送[告警](../alert-setting.md)消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、以及告警沉默周期。

告警策略支持单选或多选，点击策略名可展开详情页。若需修改策略点击**编辑告警策略**即可。



### 关联

支持将监控器与仪表板关联，以便快速跳转查看相关数据。
 
### 权限 {#permission}

设置监控器的操作权限后，确保不同用户根据其角色和权限级别进行符合配置的操作。


- 不开启该配置：跟随“监控器配置管理”的[默认权限](../management/role-list.md)；
- 开启该配置并选定自定义权限对象：仅创建人和被赋予权限的对象可对该监控器设置的规则进行启用/禁用、编辑、删除操作；
- 开启该配置，但并未选定自定义权限对象：则仅创建人拥有此监控器的启用/禁用、编辑、删除权限。

???+ warning "注意"

    当前工作空间的 Owner 角色不受此处操作权限配置影响。


## 恢复监控器 {#recover}

支持查看已有监控器的状态、最后更新时间、创建时间以及创建人，支持通过恢复监控器来查看监控器的历史配置，帮助您快速和团队其他成员沟通协作来更新监控器。

*<u>操作示例：</u>*

在**监控 > 监控器**，选择编辑已有的监控器，在监控器配置页面，点击右上角的 :fontawesome-brands-creative-commons-nd: 按钮，即可查看监控器的状态、最后更新时间、创建时间以及创建人。

![](../img/8.monitor_recover_1.png)

点击上图中**更新时间**右侧的 :material-text-search: 查看按钮，即可打开新的浏览器窗口查看上一版本的监控器配置；

![](../img/8.monitor_recover_1.1.png)

点击上一版本监控器右上角的**恢复此版本**，在弹出的对话框中，确认恢复，即可恢复到上一版本的监控器配置进行编辑和保存。

