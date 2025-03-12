# 阿里云资产巡检
---

## 背景

为<<< custom_key.brand_name >>>提供额外的数据接入能力，方便用户对云厂商的产品性能状态有更多的了解。

## 前置条件

1. 自建 [DataFlux Func <<< custom_key.brand_name >>>特别版](https://<<< custom_key.func_domain >>>/#/) ，或者开通 [DataFlux Func 托管版](../../dataflux-func/index.md)
3. 在<<< custom_key.brand_name >>>「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
5. 开启对应需要检测的「<<< custom_key.brand_name >>>自建巡检（阿里云）」中对象的[采集器(如: 阿里云 ECS)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-ecs/)
7. 在自建的 DataFlux Func 中，编写自建巡检处理函数

> **注意**：如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的<<< custom_key.brand_name >>> SaaS 部署在[同一运营商同一地域](../../../getting-started/necessary-for-beginners/select-site/)。

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启云账户实例维度账单巡检配置，新建脚本集之后，在创建巡检脚本时选择对应的脚本模板保存，在生成的新脚本文件中根据需要更改即可。

![image](../img/cloudasset11.png)

## 开启巡检

### 在<<< custom_key.brand_name >>>中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在<<< custom_key.brand_name >>>「监控 / 智能巡检」中查看并进行配置

### 在<<< custom_key.brand_name >>>中配置阿里云资产巡检

![image](../img/cloudasset01.png)

#### 启用/禁用

智能巡检「阿里云资产巡检」默认是**启动**状态，可手动「关闭」，开启后，将对配置好的云账户进行巡检。

#### 编辑

智能巡检「阿里云资产巡检」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击**编辑**按钮，即可对巡检模版进行编辑。

* 筛选条件：该巡检不需要配置参数
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/cloudasset02.png)

## 查看事件

智能巡检基于<<< custom_key.brand_name >>>智能算法，会查找云资产指标中的异常情况，如云资产指标突然发生异常。对于异常情况，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击**查看相关事件**按钮，即可查看对应异常事件。

![image](../img/cloudasset03.png)

当配置好相应的自建巡检后，巡检会根据配置在发现异常后生成事件来配合我们来排查错误信息

### 事件详情页
点击**事件**，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情

![image](../img/cloudasset04.png)

#### 基础属性

* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/cloudasset05.png)

#### 事件详情

- 事件概览：描述异常巡检事件的对象、内容等，不同的采集器可能事件详情有所区别

#### 历史记录
支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/cloudasset06.png)

#### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/cloudasset07.png)


## 常见问题
**1.阿里云资产巡检的检测频率如何配置**

在 DataFlux Func 中，通过「管理 / 自动触发配置」为检测函数设置自动触发时间建议配置巡检间隔不要过短会引起任务堆积, 建议配置半小时为宜

**2.阿里云资产巡检收集的相关指标集怎么看**

可以参考阿里云集成文档中[（如: 阿里云 ECS）](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-ecs/)的上报数据格式中的指标集进行数据查看

**3.在巡检过程中发现以前正常运行的脚本出现异常错误**

请在 DataFlux Func 的脚本市场中更新所引用的脚本集，可以通过[**变更日志**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/)来查看脚本市场的更新记录方便即时更新脚本。







