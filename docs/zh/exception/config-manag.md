# 配置管理
---

## 等级定义

:material-numeric-1-circle: 观测云为异常追踪 Issue 配置了 4 种默认等级选项：P0、P1、P2 和未知。

![](img/issue-level.png)

**注意**：您最多支持添加 10 个等级。

:material-numeric-2-circle: 除默认等级之外，您可以配置自定义等级，以满足您的多种需求。

点击**添加等级**，选择等级色块、输入等级名称及其描述，即可创建成功。

![](img/issue-level.gif)

针对您可进行以下操作：

:material-numeric-1-circle-outline: 编辑：点击编辑按钮，即可修改当前自定义等级的颜色、名称及描述。

:material-numeric-2-circle-outline: 删除：点击即刻删除当前等级。

### 启用/禁用默认配置：

- 启用：若默认配置为启用状态，且当前工作空间内有新增的自定义等级，则您在创建或修改异常追踪时可选择默认和自定义等级；

- 禁用：若默认配置为禁用状态，则您在创建/修改异常追踪时仅能选择自定义等级配置。

???+ warning "禁用此选项需要注意三点："

    - 已经存在自定义等级，从而保证在创建/修改 Issue 时有可选择的等级；
    - 在监控器产生了异常事件并同步创建 Issue 异常追踪的情况下，需要将其调整为自定义等级；
    - 若工作空间内仍然存在使用默认等级的 Issue，需要将仍然处于【Open】【Pending】的 Issue 调整为自定义等级。

## 通知策略 {#notify-strategy}

面对已创建好的 Issue 及当前工作空间[日程](./calendar.md)，可在 **Issue 管理 > 配置管理 > 通知策略**进行统一管理，对 Issue 通知的内容范围和关联日程做进一步通知分配。

### 新建通知策略 {#create}

![](img/notice-create.png)

:material-numeric-1-circle-outline: 输入策略名称；

:material-numeric-2-circle-outline: 选择通知范围：主要包含以下三种：

- Issue 的新建、修改；

- Issue 升级：
    - 在具体分钟数内一直出现**未指定 Issue 负责人**的情况，则纳入当前策略的通知范围；
    - 在具体分钟数内一直出现 Issue 未被解决的情况，则纳入当前策略的通知范围；

![](img/notice-create-1.png)

- Issue 回复的新建、修改和删除。


:material-numeric-3-circle-outline: 配置相应日程：即选定当前工作空间内的日程，配合日程向外发送通知。您还可按需在此处直接[新建日程](./calendar.md#create)。

![](img/notice-create-1.gif)