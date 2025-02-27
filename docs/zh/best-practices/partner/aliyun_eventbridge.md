# 阿里云事件总线 EventBridge 最佳实践

---

本文介绍如何把阿里云事件总线 EventBridge 的内容接入<<< custom_key.brand_name >>>平台，通过<<< custom_key.brand_name >>>强大的统一汇聚能力轻松获取阿里云事件，实时追踪最新的数据信息。



## 背景信息 

事件总线 EventBridge 是阿里云提供的一款无服务器事件总线服务，支持阿里云服务、自定义应用、SaaS 应用以标准化、中心化的方式接入，并能够以标准化的 CloudEvents 1.0 协议在这些应用之间路由事件，帮助您轻松构建松耦合、分布式的事件驱动架构。但是对于多云环境，甚至传统 IDC + 云服务的组合架构下，客户更希望能够把云事件、指标、日志、链路等统一汇总，综合调度。<<< custom_key.brand_name >>>平台提供了这样的能力。



## 前提条件

您已完成以下操作：

- 安装 DataKit，具体操作，参考 <[主机安装 DataKit](../../datakit/datakit-install.md)>
- 开启阿里云事件总线 EventBridge (目前公测期间免费使用)
- 服务器安全组放行 9529 端口



## 适用场景

通过事件总线内置的 HTTP 服务的方式，把事件信息推送至<<< custom_key.brand_name >>>。

#### 步骤一：修改 DataKit 监听端口

1、修改服务器 DataKit 主配置文件 `/usr/local/datakit/conf.d/datakit.conf`

```shell
[http_api]
  listen = "0.0.0.0:9529"
```

2、重新启动 DataKit
```shell
systemctl restart datakit
```
#### 步骤二：创建事件总线规则

1、登录 [阿里云事件总线控制台](https://eventbridge.console.aliyun.com/overview)

2、选择「事件总线」-「default」-「事件规则」

![image.png](../images/aliyun-eventbridge-1.png)

3、创建规则，配置基本信息，输入名称和描述，然后单击 「下一步」

![image.png](../images/aliyun-eventbridge-2.png)

4、配置事件模式，选择「阿里云官方事件源」，选择想要的「事件源」和「事件类型」

![image.png](../images/aliyun-eventbridge-3.png)

5、选择完成后，可以通过事件模式调试进行测试，然后单击 「下一步」

![image.png](../images/aliyun-eventbridge-4.png)

6、配置事件目标，选择「服务类型」为 `HTTP`，「URL」为 `DataKit 日志 API 地址`，「Body 」为 `模板`

![image.png](../images/aliyun-eventbridge-5.png)

7、当「Body」为 `模板`时，需要定义模板里的变量和自定义模板 [阿里云模板说明](https://help.aliyun.com/document_detail/181429.html#section-tdd-mia-lol)

- 变量：通过 JSONPath 从云事件原始数据中提取参数，使用 "$." 
- 模板：通过 "${}" 进行变量的引用，格式必须符合 [DataKit API 规范](../../datakit/apis.md#api-logging-example)

![image.png](../images/aliyun-eventbridge-6.png)

8、「网络类型」选择 `公网`，然后单击 「确认」

![image.png](../images/aliyun-eventbridge-7.png)

9、登录<<< custom_key.brand_name >>>，点击「日志」模块查看对应生成的事件

- measurement：数据来源
- message：日志内容
- fields：扩展字段

![image.png](../images/aliyun-eventbridge-8.png)

#### 数据验证

- 事件追踪 > 事件详情，查看云事件原始数据

![image.png](../images/aliyun-eventbridge-9.png)

![image.png](../images/aliyun-eventbridge-10.png)

- 事件追踪 > 事件轨迹，查看事件是否正常投递

![image.png](../images/aliyun-eventbridge-11.png)

![image.png](../images/aliyun-eventbridge-12.png)

- 服务器 `/var/log/datakit/gin.log` 查看数据接收情况

![image.png](../images/aliyun-eventbridge-13.png)

## 相关文档

<[阿里云 EventBridge 事件总线产品简介](https://help.aliyun.com/document_detail/163239.html)>

<[<<< custom_key.brand_name >>> DataKit API 开发文档](../../datakit/apis.md)>