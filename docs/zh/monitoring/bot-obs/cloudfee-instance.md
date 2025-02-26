# 云账户实例维度账单巡检
---

## 背景

云账户实例维度账单巡检帮助用户管理云服务实例级别的异常费用预警、预测费用情况并为用户提供高增长、高消耗的实例提示及账单可视化能力，支持多维度可视化云服务资源的消费情况。

## 前置条件

1. 自建 [DataFlux Func {{{ custom_key.brand_name }}}特别版](https://func.guance.com/#/) ，或者开通 [DataFlux Func 托管版](../../dataflux-func/index.md)
3. 在{{{ custom_key.brand_name }}}「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)

> **注意**：如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的{{{ custom_key.brand_name }}} SaaS 部署在[同一运营商同一地域](../../../getting-started/necessary-for-beginners/select-site/)。
>
> **注意 2：**由于实例级别账单数据采用日志存储，{{{ custom_key.brand_name }}} SaaS 日志数据默认只有 15 天的存储时长为了保障巡检的准确请将日志数据存储时间调整为最长。

## 开启巡检

在自建的 DataFlux Func 中，通过「脚本市场」安装开启[「{{{ custom_key.brand_name }}}集成（华为云-账单采集-实例维度）」](https://func.guance.com/doc/script-market-guance-huaweicloud-billing-by-instance/)、[「{{{ custom_key.brand_name }}}集成（阿里云-账单采集-实例维度）」](https://func.guance.com/doc/script-market-guance-aliyun-billing/)、[「{{{ custom_key.brand_name }}}集成（腾讯云-账单采集-实例维度）」](https://func.guance.com/doc/script-market-guance-tencentcloud-billing-by-instance/) 并且收集数据天数超过 15 天，再安装「{{{ custom_key.brand_name }}}自建巡检（账单-实例维度）」并根据提示配置{{{ custom_key.brand_name }}} API Key 完成开启

在 DataFlux Func 脚本市场中选择需要开启的巡检场景点击安装，配置{{{ custom_key.brand_name }}} API Key 和 [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) 后选择部署启动脚本即可

![image](../img/create_checker.png)

启动脚本部署成功后，会自动创建启动脚本和自动触发配置，可以通过链接直接跳转查看对应配置。

![image](../img/success_checker.png)

## 配置巡检

### 在{{{ custom_key.brand_name }}}中配置巡检

![image](../img/cloudfee_instacne02.png)

#### 启用/禁用
云账户实例维度账单巡检默认是「开启」状态，可手动「关闭」，开启后，将对配置好的云账户列表进行巡检。

#### 编辑
智能巡检「 云账户实例维度账单巡检」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击**编辑**按钮，即可对巡检模版进行编辑。

* 筛选条件：配置对应云厂商、云账户信息
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/cloudfee_instacne03.png)

可以参考如下的配置多个应用信息

```json
 // 配置示例：
    configs 配置示例：
        account_id:cloud_provider
        account_id:cloud_provider
```

## 查看事件

智能巡检基于{{{ custom_key.brand_name }}}智能算法，会查找云资产费用中的异常情况，如云资产费用突然然发生异常，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击**查看相关事件**按钮，即可查看对应异常事件。

![image](../img/cloudfee_instacne04.png)

### 事件详情页
点击**事件**，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情

#### 基础属性
* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/cloudfee_instacne05.png)

#### 事件详情
* 事件概览：描述异常巡检事件的对象、内容等
* 成本分析：可查看当前异常云账户的近 30 天的消费趋势
  * 异常区间：智能巡检数据中的异常开始时间到结束时间
  
* 消费金额增幅产品排名：查看当前云账户产品费用排名
* 消费金额增幅实例排名：查看当前云账户实例费用排名
* 费用预测：预测云账户当月剩余日期的消费金额
  * 置信区间：预测趋势线的准确范围


![image](../img/cloudfee_instacne06.png)

#### 历史记录
支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/cloudfee_instacne07.png)

#### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/cloudfee_instacne08.png)

#### 视图链接

可以通过事件列表中的云账单实例费用监控视图查看对应异常信息的更细粒度的信息, 和可能影响的因素
![image](../img/cloudfee_instacne09.png)

## 常见问题

**1.云账户实例维度账单巡检的检测频率如何配置**

* 在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='0 0 * * *', timeout=900` ，后在「管理 / 自动触发配置」中配置。

**2.云账户实例维度账单巡检触发时可能会没有异常分析**

在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

**3.在巡检过程中发现以前正常运行的脚本出现异常错误**

请在 DataFlux Func 的脚本市场中更新所引用的脚本集，可以通过[**变更日志**](https://func.guance.com/doc/script-market-guance-changelog/)来查看脚本市场的更新记录方便即时更新脚本。

**4.在何种情况下会产生云账户实例维度账单巡检事件**

以指定云厂商产品费用总和作为入口，当该费用信息出现显著变化时或总费用的预算超出配置的预算时触发生成事件逻辑进行根因分析，产生巡检事件。

* 跟踪阈值：如当期费用同比环比 > 100%

**5.长时间未触发云账户实例维度账单巡检**

如果在线上视图巡检中发现了账单异常但是巡检没有发现，首先应该排查巡检开启时间是否超过 15 天，其次应该排查使用日志数据存储过期策略是否大于 15 天， 最后在 DataFlux Func 中查看是否正确得配置了自动触发任务。

**6.在升级巡检脚本过程中发现 Startup 中对应的脚本集无变化**

请先删除对应的脚本集后，再点击升级按钮配置对应{{{ custom_key.brand_name }}} API key 完成升级。

**7.开启巡检后如何判断巡检是否生效**

在「管理 / 自动触发配置」中查看对应巡检状态，首先状态应为已启用，其次可以通过点击执行来验证巡检脚本是否有问题，如果出现 xxx 分钟前执行成功字样则巡检正常运行生效。



