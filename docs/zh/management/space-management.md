# 空间管理
---


## 创建工作空间

注册完“观测云”账号以后，系统会默认为您创建一个工作空间，并赋予“拥有者”权限。如需要创建其他工作空间，您可以在 “观测云” 工作台点击 「当前空间」-「创建工作空间」。

![](img/Creating.a.workspace.png)

输入工作空间名称和描述，选择企业团队，即可创建一个新的工作空间。

![](img/workspace_1.png)

## 切换工作空间

登录“观测云”工作空间后，您可以通过点击 「当前空间」切换至其他工作空间。


## 查看工作空间基本设置 

进入「管理」-「基本设置」，在基本设置中可查看当前“观测云”版本、安全操作审计等信息，拥有者和管理员还可修改空间名称、备注、配置迁移、设置作战室关键指标、查看操作审计、设置 IP 白名单、更换数据存储策略、删除指标集、删除自定义对象等操作。

![](img/6.space_1.1.png)

![](img/6.space_2.png)

### 更换Token

“观测云” 支持当前空间拥有者和管理员复制/变更空间内的Token，并自定义当前Token的失效时间。进入「管理」-「基本设置」-「更换Token」，选择失效时间并确认「更换」后，“观测云”会自动生成新的Token，旧的Token会在指定时间内失效。

注意：

- 更换Token会触发「操作事件」和「通知」，详情可参考「[操作审计](../management/operation-audit.md)」「[通知](../management/system-notification.md)」
- 更换Token后，原有Token会在指定时间内失效。失效时间包括：立即失效、10分钟、6小时、12小时、24小时。立即失效一般用于 Token 泄露，选择立即失效后，原有 Token 将立刻停止数据上报，若设置了异常检测，则无法触发事件及告警通知，直至在 DataKit 采集器的`datakit.conf`中把原有 Token 修改成新生成的 Token 。关于`datakit.conf` 文件的存储目录，可参考文档 [DataKit 使用入门](../datakit/datakit-conf.md) 。

![](img/datakit.png)

### 一键导入导出 {#export-import}

“观测云” 支持拥有者和管理员一键导入、导出当前工作空间内的仪表板、自定义查看器、监控器的配置文件，进入「管理」-「基本设置」，在「配置迁移」选择导出或导入操作。

![](img/1-space-management-2.png)

**注意**：当前工作空间支持导入其他工作空间的仪表板、自定义查看器、监控器等 JSON 配置。


### IP 白名单

“观测云” 支持为工作空间配置 IP 白名单来限制来访用户。开启 IP 白名单后，仅白名单中的 IP 来源可以正常登录，其他来源请求均会被拒绝访问。

IP 白名单仅支持管理员及拥有者可以设置，同时「拥有者」不受 IP 白名单访问限制。

IP白名单书写规范如下：

- 多个 IP 需换行，每行只允许填写一个 IP 或网段，最多可添加 1000 个
- 指定 IP 地址：192.168.0.1  ，表示允许 192.168.0.1 的 IP 地址访问
- 指定 IP 段：192.168.0.0/24 ，表示允许 192.168.0.1 到 192.168.0.255 的 IP 地址访问。
- 所有 IP 地址：0.0.0.0/0

![](img/6.space_ip_1.png)

### 变更数据存储策略

“观测云” 支持拥有者和管理员变更空间内的数据存储策略，进入「管理」-「基本设置」，点击「变更」后，选择所需的数据存储时长，点击「确定」即可变更当前工作空间内的数据存储时长。更多说明可参考文档 [数据存储策略](../billing/billing-method/data-storage.md) 。


### 删除指标集

“观测云” 支持拥有者和管理员删除空间内的指标集，进入「管理」-「基本设置」，点击「删除指标集」后，输入查询并选择指标集名称（支持模糊匹配），点击「确定」后进入删除队列等待删除。

**注意：**

1. 只允许空间拥有者和管理员进行此操作；

1. 指标集一经删除，无法恢复，请谨慎操作

1. 删除指标集时，会产生系统通知事件，如用户创建了删除指标集任务、删除指标集任务执行成功、删除指标集任务执行失败等。

  

![](img/11.metric_1.png)


## 删除自定义对象

观测云支持拥有者和管理员删除指定自定义对象分类以及所有自定义对象，进入「管理」-「基本设置」，点击「删除自定义对象」后，选择删除自定义对象的方式，即可删除对应的对象数据。

● 指定自定义对象分类：仅删除所选对象分类下的数据，不会删除索引
● 所有自定义对象：删除所有自定义对象数据及索引

![](img/7.custom_cloud_3.png)

## 退出当前工作空间

用户可主动退出工作空间，点击左侧「账号」-「设置」-「空间管理」，选择想要退出的空间，点击右上角的「下拉选项」-「退出」即可。

![](img/5.workspace_8.png)


## 修改当前工作空间

“观测云” 付费版支持修改工作空间，点击左侧「账号」-「设置」-「空间管理」，选择想要修改的空间，点击右上角的「下拉选项」-「修改」即可。

**注意：**

1. 只允许空间拥有者和管理员进行此操作；
1. 仅通过个人注册或在 “观测云” 创建的工作空间可进行修改，通过管理后台创建的工作空间无修改按钮。
1. 支持修改企业/团队名称、所属行业和所属地区。

![](img/5.workspace_7.png)

## 解散当前工作空间

“观测云” 免费版支持解散工作空间，点击左侧「账号」-「设置」-「空间管理」，选择想要解散的空间，点击右上角的「下拉选项」-「解散」即可。

**注意：**

1. 只允许空间拥有者和管理员进行此操作；
2. 解散工作空间前需先清空空间成员、异常检测规则
3. 空间一经解散，数据将无法恢复，请谨慎操作

![](img/5.workspace_6.png)


