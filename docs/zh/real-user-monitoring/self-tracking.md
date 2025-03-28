# 自建追踪
---

## 简介

<<< custom_key.brand_name >>>支持您通过**用户访问监测**新建追踪任务，对自定义的链路追踪轨迹进行实时监控。通过预先设定链路追踪轨迹，可以集中筛选链路数据，精准查询用户访问体验，及时发现漏洞、异常和风险。

## 应用支持

追踪功能目前只支持 Web、Android、iOS 应用引入。

## 新建追踪

在<<< custom_key.brand_name >>>工作空间的**用户访问监测**中，点击**应用名称**进入指定应用，即可通过**追踪**新建追踪轨迹。

进行**新建追踪**时，您需要设定名称和字段，并在生成追踪 ID 后完成引入配置。

| 字段      | 描述                          |
| ----------- | ------------------------------------ |
| 追踪名称       | 当前追踪任务的名称。支持中英文混写，支持下划线作为分隔符，不支持其他特殊字符，且最多支持 64 个字符串。  |
| 标签       | 定义链路追踪字段。支持通过下拉框选择当前应用（app_id）下的标签（key:value)，支持多选。 |
| 追踪 ID    | 有系统生成的唯一追踪 ID 标识，支持用户一键复制。 |
| 引入方式     | 生成追踪 ID 后，需要根据追踪 ID 信息在应用中引入代码。                          |


![](img/image_2.png)

## 管理追踪任务

创建追踪任务后，默认**启动**该任务，您可以在当前应用的 Session 查看器中，查看指定追踪 ID 下的性能数据；您也可以通过点击追踪**名称**查看该追踪产生的数据。同时，您可以查看或删除追踪任务。


## 自动化追踪 {#auto-tracking}

<<< custom_key.brand_name >>>支持通过**浏览器插件**的实现方式，使用浏览器记录用户访问行为，创建无代码的端到端测试。

### 步骤说明

#### 第一步：下载浏览器插件

1、若您已经接入 Web 应用，您可以直接通过 [下载浏览器插件](https://static.<<< custom_key.brand_main_domain >>>/guance-plugin/guance-rum-plugin.zip) 进行安装。

2、若您还未开始使用<<< custom_key.brand_name >>>，可以先完成以下步骤：

 - [注册<<< custom_key.brand_name >>>账号](https://<<< custom_key.brand_main_domain >>>/)；  
 - [安装 DataKit](../datakit/datakit-install.md)；  
 - [开启用户访问监测采集器](../integrations/rum.md)；  
 - [接入 Web 应用](web/app-access.md)。

#### 第二步：安装插件

1、插件下载完成后，通过浏览器访问：`chrome://extensions/`；

**注意**：自动化追踪目前支持 Chrome 和 Edge 浏览器。

2、开启**开发者模式**；

3、解压下载的浏览器插件 [guance-rum-plugin.zip](https://static.<<< custom_key.brand_main_domain >>>/guance-plugin/guance-rum-plugin.zip)；  

4、点击**加载已解压的压缩包**；

5、选择解压后的文件夹。 

![](img/8.auto-tracking_1.png)

#### 第三步：使用插件

1、右上角点击图标**扩展程序**，找到 **Guance Cloud Plugin** 打开插件；  

![](img/8.auto-tracking_2.png)

2、开启即可生成追踪 ID。

- 点击 **开启** 即可使用当前追踪 ID；  
- 点击 :octicons-sync-24: 生成新的追踪 ID；  
- 点击 :fontawesome-solid-clock-rotate-left: 图标可查看历史生成的追踪 ID；  
- 点击 **语言** 图标可查看当前语言或切换语言；  
- 点击 :octicons-question-24: 图标可查看帮助文档。

![](img/8.auto-tracking_3.png)

#### 第四步：在<<< custom_key.brand_name >>>筛选查看数据

在用户访问监测应用列表，选择已接入的 Web 应用，即可通过插件生成的追踪 ID (`track_id`) 筛选查看用户访问数据。

![](img/8.auto-tracking_4.png)
