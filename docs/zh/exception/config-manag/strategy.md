# 通知策略 {#notify-strategy}

基于已创建好的 Issue 及当前工作空间[日程](../calendar.md)，可在 **异常追踪 > 配置管理 > 通知策略**进行统一管理，对 Issue 通知的内容范围和关联日程做进一步通知分配。

## 新建通知策略 {#create}

<img src="../../img/notice-create.png" width="60%" >

:material-numeric-1-circle-outline: 输入策略名称；

:material-numeric-2-circle-outline: 选择通知范围：主要包含以下四种：

- Issue 的新建、修改；

- Issue 升级；

- Issue 回复的新建、修改和删除；

- 日报总结。

:material-numeric-3-circle-outline: 配置相应日程：即选定当前工作空间内的日程，配合日程向外发送通知。您还可按需直接[新建日程](../calendar.md#create)。

<img src="../../img/notice-create-2.png" width="60%" >

### Issue 升级 {#upgrade}


为确保 Issue 能被及时通知到相关负责人，通过配置 Issue 升级，避免 Issue 无人负责或未及时解决的情况。

**规则生效前提**：仅对新创建的 Issue 生效。

<img src="../../img/notice-create-1.png" width="70%" >

1. 若在指定的分钟数内**未指定 Issue 负责人**，可设置系统发送通知提醒次数；
2. 对于**处于 `open` 状态**的 Issue：

    - 如果其持续时间超过设定的特定分钟数，可设置系统发送通知提醒次数；
    - 如果 Issue 在设定的分钟数内未流转到其他状态（如 `pending`、`resolved` 或 `closed` 等），可设置系统发送通知提醒次数。

???+ warning "注意"

    上文提到的**处于 `open` 状态**的 Issue 包含以下两种：

    - 系统将新创建的 Issue (默认状态为 `open`)；
    - 历史已经存在的 Issue 从其他状态变更为 `open`。

## 管理策略列表

在策略列表，您可进行以下操作：

1. hover 在某条策略的关联日程与关联频道，即可直接查看关联配置，点击可查看详情；
2. 点击编辑按钮，可修改该条策略的配置；
3. 点击删除按钮，可删除该策略；

### 操作审计 {#check-events}

在接收 Issue 通知时，有时会遇到通知未正常发送或针对通知策略有疑议，此时可查看当前通知策略的**操作审计**事件数据来判断该条策略的相关动向。

点击操作审计按钮，可跳转到审计页面，直接展示当前通知策略的操作审计，时间默认选中最近 1 天，您可按需更改时间范围进行查看。

### 执行日志

点击执行日志按钮，可查看当前策略的所有执行数据。

在展开的执行日志详情页中，{{{ custom_key.brand_name }}}根据日志时间、Issue 标题、通知范围和通知对象直观为您展示日志数据。列表中，系统会囊括以下几类数据：

- Issue 未指定负责人及时长；
- Issue 处理超时及时长；
- Issue 新增/编辑；
- Issue 回复的新增/编辑/删除；
- 日报总结；

在列表中，您可通过以下操作进行管理：

1. 可在搜索栏输入通知范围、关联频道、通知对象进行搜索定位；

2. 点击 :material-text-search: 即可展开详情。

    - **注意**：由于日报总结涉及到多个 Issue，所以 Issue 标题显示为 `-`。

