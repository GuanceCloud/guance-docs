# RUM Headless


RUM 用于收集网页端或移动端上报的用户访问监测数据。<<< custom_key.brand_name >>>提供 RUM 一键开通服务。开通后即可自动化安装部署在<<< custom_key.brand_name >>>的云主机中，自动完成 DataKit 安装，RUM 采集器部署等一系列操作。

???+ warning "注意"

    开通 RUM Headless 平台的前提需要联系费用中心开启白名单通道。需要联系客户经理，提供工作空间所在站点及 ID 等信息。

## 一键开通 {#steps}

在**集成 > RUM Headless**，或**集成 > 扩展 > RUM Headless**，点击进入开通流程：

![](img/headless-1.png)

???+ warning "权限与收费"

    - 一个工作空间只能开通一个，仅 **Owner** 有开通权限和配置权限；  
    - RUM Headless **按月收费**，在开通成功后一次性扣除一个月的费用，在到期日前一天自动扣除下月费用（如：04/13 开通，则 04/12 扣费，05/12 扣费，以此类推...）。


1. 点击**开通**；
2. 填写 HTTP 服务地址;
3. 选择应用所需规格；
4. 立即开通。


???+ warning "注意"

    HTTP 服务地址：即 DataKit 的 HTTP 服务地址，通过该地址接收外部数据，在接入应用时需要填写：

<img src="../img/headless-5.png" width="60%" >

自动化部署过程预计需要 10-15 分钟。开通完成后,您可以在**集成 > Func > 扩展**应用直接进入控制台。点击**配置 > 概览**，即可查看 RUM Headless 的相关信息。



## 相关配置

当 RUM Headless 开通完成后，若您需要修改配置信息，可参考以下内容。


### 修改服务地址

1. 点击**修改**；
2. 获取并填入邮箱验证码；
3. 确定，完成**身份验证**，即可修改当前 HTTP 服务地址。

???+ warning "注意"

    每日可修改 3 次服务地址。


### 修改规格

1. 点击**修改**；
2. 获取并填入邮箱验证码；
3. 确定，完成身份验证，即可修改当前规格。

???+ warning "注意"

    规格修改后当日立即生效，并按照新规格开始扣费，旧规格将直接弃用，且不会退费。

### Sourcemap 配置

Sourcemap（源代码映射）用于将生产环境中的压缩代码映射回原始的源代码。

![](img/headless-3.png)

上传文件时，选择应用类型，[配置打包完成 Sourcemap 后](../integrations/rum.md#sourcemap)，拖拽或点击上传。

在 🔍 栏下方，可查看已上传的文件名称及应用类型，您可输入文件名称搜索；点击 :fontawesome-regular-trash-can: 可删除当前文件。

???+ warning "上传须知"

    - 文件大小不能超过 500M；
    - 文件格式必须为 `.zip`；
    - 文件命名格式为 `<app_id>-<env>-<version>`，其中 `app_id` 必填，格式错误将不会生效；请确保该压缩包解压后的文件路径与 `error_stack` 中 URL 的路径一致；
    - 不能同时上传多个文件；
    - 上传同名文件会出现覆盖提示，请注意。

### 状态相关

在 RUM Headless 配置页面，您可以查看当前的应用状态。

您当前的应用可能存在五种状态：

| 状态      | 说明            |
| ----------- | ------------- |
| 开通中      | 表示处于一键开通 RUM Headless 流程中。             |
| 已开通      | 表示已完成一键开通 RUM Headless 流程。             |
| 方案变更中      | 表示正在修改服务地址或修改规格。              |
| 升级中      | 表示正在升级当前应用服务。               |
| 操作失败      | 表示在开通流程中存在操作问题，您可以**查看错误反馈**或直接[联系我们](https://<<< custom_key.brand_main_domain >>>/aboutUs/introduce#contact)。           |

### 应用到期

在应用到期扣费的前三天，系统会检测余额是否足够续费，若余额不足，系统会向工作空间 Owner 发送邮件和系统通知提醒。

如果您之前使用过 RUM Headless，在应用到期前重新开通应用，可以恢复应用的所有数据。如果逾期未续费，数据将被永久清除。系统会为您保留最近 7 天的数据。在这 7 天内，如果您选择再次开通应用，可以选择恢复所有数据或不恢复数据。

- 恢复数据：将之前保留的数据备份到新开通的 RUM 中；  
- 不恢复数据：放弃之前的所有数据，[重新开通应用](#steps)。


### 停用应用

若您需要停用当前应用服务，点击**停用应用**，完成**身份验证**，即可打开确认页面，您可以查看应用到期日。

RUM Headless 采用按月收费的模式，在费用到期前，您仍可使用 RUM 服务，还可以按需**恢复开通** RUM Headless。
    


