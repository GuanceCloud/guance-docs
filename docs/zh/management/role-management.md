# 角色管理
---

若您需要对企业中的员工设置不同的观测云访问权限，以达到不同员工之间的权限隔离，您可以使用观测云的角色管理功能。角色管理为用户提供一个直观的权限管理入口，支持自由调整不同角色对应的权限范围，支持为用户创建新的角色，并为角色赋予权限范围，满足不同用户的权限需要。

## 角色

### 默认角色

观测云默认提供四种成员角色，分别为“拥有者”、“管理员”、“标准成员”和“只读成员”，默认角色不可删除和修改。

| **角色** | **说明**                                                     |
| -------- | ------------------------------------------------------------ |
| 拥有者（Owner） | 当前工作空间的拥有者，拥有最高操作权限，可以指定当前空间“管理员”并进行任意的空间配置管理，包括升级空间付费计划、解散当前空间。<br />**注意：**<br /><li>工作空间创建者默认为“拥有者”<br /><li>一个工作空间只能有一个“拥有者”<br /><li> “拥有者”不可退出工作空间<br /><li> “拥有者”可以将权限转让给空间成员，成功转让后原“拥有者”降级为“管理员”<br /><li>若当前“拥有者”已不在工作空间，最早的管理员升级为“拥有者”<br /> |
| 管理员（Administrator） | 当前工作空间的管理者，可以设置用户权限为“只读成员”或“标准成员”，对工作空间具有写入权限，但不支持调整存储策略和删除指标集 |
| 标准成员（Standard） | 对工作空间具有写入权限                 |
| 只读成员（Read-only） | 仅能够对工作空间的数据进行查看，无写入权限 |

### 自定义角色

除了默认角色以外，观测云支持在角色管理创建新的角色，并为角色赋予权限范围，满足不同用户的权限需要。

在观测云工作空间「管理」-「成员管理」-「角色管理」，即可创建一个新的角色。

> 自定义角色仅“拥有者”、“管理员”可创建。

![](img/8.member_6.png)

#### 修改/删除自定义角色

在角色管理，点击自定义角色右侧的「编辑」按钮，即可调整角色的权限。点击「删除」按钮，若该角色和成员账号无关联，即可删除。

![](img/8.member_4.png)

#### 自定义角色详情页

在角色管理，点击任意自定义角色，即可查看该角色详情信息，包括角色名称、创建/更新时间、创建人/更新人、描述以及角色权限，支持点击角色右侧的「编辑」按钮修改角色权限。

![](img/8.member_13.1.png)

### 提权为管理员 {#upgrade}

- 商业版工作空间成员升级到 “管理员” 的时候，会同时给观测云费用中心发送一条验证信息：
    - 若费用中心「接受」该验证，则该成员权限变更为“管理员”；
    - 若费用中心「拒绝」该验证，则该成员提权失败，继续保持原有的角色权限；
    - 若费用中心一直未审核，可为成员修改为其他角色，修改成功后提权管理员审核申请失效。
- 体验版工作空间成员可直接提权管理员，无需到观测云费用中心审核。

#### 商业版提权为管理员示例

在观测云工作空间「管理」-「成员管理」，选择需要升到管理员的成员，点击右侧“编辑”按钮，在弹出的对话框中，“权限”选择为“管理员”，点击“确定”。

> 观测云仅支持“拥有者”、“管理员”为当前工作空间成员赋予“管理员”权限。

![](img/1.limit_2.png)

提示权限验证：

- 若当前工作空间拥有者是观测云费用中心管理员，则可直接点击“前往费用中心审核”，免登录到观测云费用中心进行操作；
- 若当前工作空间拥有者不是观测云费用中心管理员，则需要通知观测云费用中心管理员 [登录费用中心](https://boss.guance.com/) 进行操作。

![](img/1.limit_3.png)

在观测云费用中心的消息中心，点击“接受”。

![](img/1.limit_4.png)

在“操作确认”对话框，点击“确定”。

![](img/1.limit_5.png)

可以看到提权申请已经被接受。

![](img/1.limit_6.png)

返回观测云工作空间成员管理，即可看到工作空间成员已经为“管理员”。

![](img/1.limit_7.png)

## 权限

观测云支持为工作空间内的自定义角色设置权限，满足不同用户的权限需求。

> 目前仅支持设置工作空间内的功能操作权限。

### 权限清单

- √：默认角色表示支持该项权限，自定义角色表示可为自定义角色授权该项权限；
- ×：默认角色表示不支持该项权限，自定义角色表示不支持为自定义角色授权该项权限。

| 功能模块                       | 操作权限                             | 拥有者 | 管理员 | 标准成员 | 只读成员 | 自定义角色 |
| ------------------------------ | ------------------------------------ | ------ | ------ | -------- | -------- | ---------- |
| 常规（routine）                | 默认访问权限（defaultAccess）        | √      | √      | √        | √        | √          |
|                                | 查看器-快捷筛选管理（viewerManage）  | √      | √      | ×        | ×        | √          |
|                                | 导出管理（exportManage）             | √      | √      | √        | ×        | √          |
| 工作空间管理（workspace）      | API Key 管理(openAPIKeyManage)       | √      | √      | ×        | ×        | ×          |
|                                | Token 查看(tokenRead)                | √      | √      | ×        | ×        | ×          |
|                                | Token 更换(tokenReplace)             | √      | √      | ×        | ×        | ×          |
|                                | 成员管理(memberManage)               | √      | √      | ×        | ×        | √          |
|                                | 移交拥有者(ownerRoleTransfer)        | √      | ×      | ×        | ×        | ×          |
|                                | 设置管理(setManage)                  | √      | √      | ×        | ×        | ×          |
|                                | 解散工作空间(dissolve)               | √      | ×      | ×        | ×        | ×          |
|                                | 数据存储策略管理(ilmManage)          | √      | ×      | ×        | ×        | ×          |
|                                | 工作空间状态管理                     | √      | ×      | ×        | ×        | ×          |
| 数据权限管理(dataRightsManage) | 配置管理(workspaceConfigManage)      | √      | √      | ×        | ×        | √          |
| 字段管理(field)                | 字段配置管理（fieldCfgManage）       | √      | √      | √        | ×        | √          |
| 分享管理(share)                | 分享配置管理(shareManage)            | √      | √      | ×        | ×        | √          |
| 快照(snapshot)                 | 快照配置管理(snapshotManage)         | √      | √      | ×        | ×        | √          |
| 付费计划与账单(billing)        | 付费计划与账单只读权限(billingRead)  | √      | √      | ×        | ×        | √          |
|                                | 付费计划与账单读写权限(billingWrite) | √      | ×      | ×        | ×        | ×          |
|                                | 升级权限(workspaceUpgrade)           | √      | ×      | ×        | ×        | ×          |
| 场景(scene)                    | 场景配置管理(setManage)              | √      | √      | √        | ×        | √          |
|                                | 图表配置管理(chartManage)            | √      | √      | √        | ×        | √          |
| 事件(event)                    | 手动恢复(recover)                    | √      | √      | √        | ×        | √          |
| 基础设施（infrastructure）     | 基础设施配置管理(setManage)          | √      | √      | ×        | ×        | √          |
| 日志(log)                      | 日志索引管理(indexManage)            | √      | √      | ×        | ×        | √          |
|                                | 外部索引管理(externalIndexManage)    | √      | √      | ×        | ×        | √          |
|                                | 备份日志管理(backupLogManage)        | √      | √      | ×        | ×        | √          |
| 指标(metric)                   | 指标描述管理(metricManage)           | √      | √      | √        | ×        | √          |
| Pipelines(pipeline)            | pipelines 管理(pipelineManage)       | √      | √      | √        | ×        | √          |
| 黑名单(blacklist)              | 黑名单管理(Manage)                   | √      | √      | √        | ×        | √          |
| 生成指标(generateMetrics)      | 生成指标配置管理(cfgManage)          | √      | √      | √        | ×        | √          |
| 应用性能监测(trace)            | 服务清单管理(serviceManage)          | √      | √      | √        | ×        | √          |
|                                | 关联日志管理                         | √      | √      | √        | ×        | √          |
| 用户访问监测(rum)              | 应用配置管理(rumCfgManage)           | √      | √      | √        | ×        | √          |
|                                | 追踪配置管理(trackCfgManage)         | √      | √      | √        | ×        | √          |
| 可用性监测(dialTest)           | 任务配置管理(taskManage)             | √      | √      | √        | ×        | √          |
|                                | 自建节点配置管理(customNodeManage)   | √      | √      | √        | ×        | √          |
| 监控(monitor)                  | 监控器配置管理(cfgManage)            | √      | √      | √        | ×        | √          |
|                                | 智能巡检配置管理(obsCfgManage)       | √      | √      | √        | ×        | √          |
|                                | SLO 配置管理(sloCfgManage)           | √      | √      | √        | ×        | √          |
|                                | 静默配置管理(muteCfgManage)          | √      | √      | √        | ×        | √          |
|                                | 告警策略配置管理(alarmPolicyMange)   | √      | √      | √        | ×        | √          |
|                                | 通知对象配置管理(notifyObjCfgManage) | √      | √      | ×        | ×        | √          |
| 新手引导(noviceGuide)          | 引导查看(guideRead)                  | √      | √      | √        | √        | √          |


#### 默认访问权限说明

默认访问权限是所有角色都默认赋予的权限，支持查看和编辑观测云未明确定义权限的功能组件。您可以通过以下表格了解具体的默认访问权限。

| 操作权限                      | 权限类型                                                     | 权限描述       |
| ----------------------------- | ------------------------------------------------------------ | -------------- |
| 默认访问权限（defaultAccess） | 只读权限 | <li>仪表板、笔记、查看器、内置视图、图表<br><li>仪表板轮播<br><li>所有查看器<br><li>应用性能监测-服务清单<br><li>用户访问监测-应用配置<br><li>用户访问监测-追踪配置<br><li>可用性监测-任务配置<br><li>可用性监测-自建节点配置<br><li>监控器、智能巡检、SLO、静默管理、告警策略、通知对象配置<br><li>Pipelines 配置：用户 pipeline、官方 pipeline <br><li>黑名单配置<br><li>工作空间基本信息<br><li>成员管理<br><li>SSO管理<br><li>角色管理<br><li>字段管理<br><li>数据权限管理<br><li>分享管理<br><li>快照       |
|                               | 编辑权限         |    <li>所有查看器个人级快捷筛选<br><li>所有查看器显示列    |
|                               | 其他 | <li>DQL 查询工具<br/><li>集成<br/><li>奥布斯小助手<br/><li>体验 Demo 工作空间<br/><li>工单管理 |
