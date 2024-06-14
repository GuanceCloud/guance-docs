# 巧用 Issue 自动发现功能快捷响应异常
---

## Issue 自动发现

在观测云平台中，我们引入了【Issue 自动发现】功能，旨在通过应用性能监测（APM）和用户访问监测（RUM）模块检测出的错误，自动批量生成 Issue 并通知相关成员。

这一功能相较于传统的手动创建 Issue，显得更快捷、灵活，有效加速了异常问题的定位与解决。

![](img/issue-auto-generate.png)

接下来看看如何使用 Issue 自动发现的功能吧。

## 如何使用 Issue 自动发现功能

### 适用范围和权限

Issue 自动发现功能适用于：应用性能监测(APM) > 错误追踪、用户访问监测(RUM) > 错误查看器。

操作权限：Owner、Administrator、Standard、拥有【Issue 自动发现】权限的自定义角色。

### 配置【Issue 自动发现】

#### 初见：Issue 自动发现

有操作权限的成员进入APM > 错误追踪、RUM > 错误查看器两个查看器后，右上角会显示 Issue 自动发现的文字、编辑按钮和开启标识。

- 点击编辑按钮可配置 Issue 自动发现规则；
- 开关按钮控制是否开启 Issue 自动发现。

![](img/issue-auto-generate-1.png)

![](img/issue-auto-generate-2.png)


#### 编辑Issue 自动发现配置

:material-numeric-1-circle: 概念先解

点击编辑按钮，弹出配置栏，进行 Issue 自动发现规则的配置。

![](img/issue-auto-generate-3.png)


| 配置项 | 说明 |
| --- | --- |
| 数据来源 | 根据用户自动发现开启的菜单位置的不同自主填充 |
| 组合维度 | 选取规则：默认填充对应的 APM > 错误追踪 / RUM > 错误数据中的维度字段。<br />作用：基于配置的字段组合进行 Issue 的分类，错误数据中有相关的字段分组及对应的数据则会自动产生一条 Issue。 |
| 检测频率 | Issue 自动可定期检测 APM > 错误追踪/ RUM > 错误数据。<br />在此处自定义选择发现的频率。 |
| Issue 定义 | 定义自动发现生成的 Issue，Issue 创建规则可查看：[创建  Issue ](../exception/issue.md)。<br />模板变量：新增支持在 Issue 的标题、描述中使用预置的模板变量。添加模板变量后，在生成的 Issue 中即可查看此 Issue 对应事件的详情。 |

:material-numeric-2-circle: 补充说明：

分别进入APM > 错误追踪、RUM > 错误查看器两个查看器进行配置时，【组合维度】和【Issue 中模版变量】的选项有区别，但是配置逻辑不变。

1、组合维度：自动填充，填充字段项不同。

- APM 组合维度：

![](img/issue-auto-generate-4.png)

- RUM 组合维度：

![](img/issue-auto-generate-5.png)

2、模版变量：Issue 的标题、描述支持模板变量，APM / RUM 可选变量类目不同。

![](img/issue-auto-generate-6.png)


:material-numeric-3-circle: 配置完成 Issue 自动发现规则，点击“保存”。


![](img/issue-auto-generate-7.png)

:material-numeric-4-circle: 开启 Issue 自动发现按钮。

![](img/issue-auto-generate-8.png)


### 使用 Issue 自动发现功能生成 Issue 并查看

#### Issue 投递

配置好Issue 自动发现规则并开启此功能后，系统将自动按照配置的检测频率进行错误发现并生成 Issue，生成的 Issue 会投递到配置的频道下。

![](img/issue-auto-generate-9.png)


#### Issue 展示

通过【Issue 自动发现】创建的异常追踪 Issue 会以[组合维度]作为唯一的 ID，若历史已经存在了相同组合维度的 Issue，则不会创建一个新的 Issue 而是通过将内容追加到历史 Issue 回复区域做更新。一般情况下可以通过 “新问题”、“重复问题”、“回归问题” 的特殊标记来识别状态。

自动发现的 Issue 卡片特别元素介绍：

![](img/issue-auto-generate-10.png)


- 创建人：显示为【Issue 自动发现】，标明其自动生成的属性。

- 组合维度：新增组合维度分组信息，展示在 Issue 卡片页面和详情页。

- 特殊标记：自动发现的 Issue 一般情况下会存在 “新问题”、“重复问题”、“回归问题” 3 种不同的特殊标记。

    - 新问题：若历史 Issue 不存在有相同组合维度，则创建 Issue 并在右侧标记“新问题”；  

    - 重复问题：若历史 Issue 已经存在有相同组合维度且状态为 Open 或者 Pending，即为问题重复出现，历史Issue右侧标记为“重复问题”；  
    
    - 回归问题：若历史 Issue 已经存在有相同组合维度且状态为 Resolved，即为问题已解决后又重现，历史 Issue 右侧标记为“回归问题”。

![](img/issue-auto-1.png)

除以上的特别字段和元素外，其他的标题、内容、等级、状态、回复等逻辑与常规 Issue 一致。

## 常见问题

:material-chat-question: 点击 Issue 自动发现启用按钮不生效。

若您是首次使用此功能，还未编辑自动发现配置的话，不支持直接启用。可先点击 Issue 自动发现编辑按钮，配置自动发现规则后再进行启用。

![](img/issue-auto-generate-11.png)

:material-chat-question: 进入 APM > 错误追踪、RUM > 错误查看器看不到这个功能。

此功能的权限范围为：Owner、Administrator、Standard、自定义角色（创建时配置了【Issue 自动发现】权限）。

因此请先进入**管理 > 成员管理**菜单下确认自己的角色，若为自定义角色，请确认已经授予了此项权限。

![](img/issue-auto-generate-12.png)