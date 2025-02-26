# 闲置主机巡检
---

## 背景

随着业务的增长，资源使用的量也随之增大企业数据中心会越来越大，闲置主机的巨大浪费问题也愈加显著。尤其是在企业范围内，因为需求波动和部门之间的隔离等原因，导致部分主机无法得到充分利用，形成了大量的闲置资源。这种情况会使企业的云服务成本直线上升、资源效率下降，还有可能降低安全和性能水平。

## 前置条件

1. 自建 [DataFlux Func {{{ custom_key.brand_name }}}特别版](https://func.guance.com/#/) ，或者开通 [DataFlux Func 托管版](../../dataflux-func/index.md)
3. 在{{{ custom_key.brand_name }}}「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)

> **注意**：如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的{{{ custom_key.brand_name }}} SaaS 部署在[同一运营商同一地域](../../../getting-started/necessary-for-beginners/select-site/)。

## 开启巡检

在自建的 DataFlux Func 中，通过「脚本市场」安装「 {{{ custom_key.brand_name }}}自建巡检（闲置主机巡检）」并根据提示配置{{{ custom_key.brand_name }}} API Key 完成开启。

在 DataFlux Func 脚本市场中选择需要开启的巡检场景点击安装，配置{{{ custom_key.brand_name }}} API Key 和 [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) 后选择部署启动脚本即可

![image](../img/create_checker.png)

启动脚本部署成功后，会自动创建启动脚本和自动触发配置，可以通过链接直接跳转查看对应配置。

![image](../img/success_checker.png)

## 配置巡检

### 在{{{ custom_key.brand_name }}}中配置巡检

![image](../img/idle-resources03.png)

#### 启用/禁用
闲置主机巡检默认是「开启」状态，可手动「关闭」，开启后，将对配置好的 闲置主机巡检配置列表进行巡检。

#### 编辑
智能巡检「 闲置主机巡检 」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击**编辑**按钮，即可对巡检模版进行编辑。

* 筛选条件：无需配置参数，默认会巡检整个工作空间云主机
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/idle-resources04.png)

## 查看事件
{{{ custom_key.brand_name }}}会根据当前的工作空间的主机状态进行巡检当发现有主机出现闲置时，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击**查看相关事件**按钮，即可查看对应异常事件。

![image](../img/idle-resources05.png)

### 事件详情页
点击**事件**，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情

#### 基础属性
* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/idle-resources06.png)

#### 事件详情

闲置主机巡检会检测云主机的运行状态发现其出现闲置情况时生成对应的事件报告。

* 事件概览：描述异常巡检事件的对象、内容等
* 闲置主机详情：可查看当前处于闲置状态主机的详细信息
* 进程详情：通过展示当前闲置主机的进程状态为业务诊断提供支持

![image](../img/idle-resources07.png)

#### 历史记录

支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/idle-resources08.png)

#### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/idle-resources09.png)

## 常见问题
**1.闲置主机巡检的检测频率如何配置**

* 在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='0 * * * *', timeout=900` ， 后在「管理 / 自动触发配置」中配置。

**2.闲置主机巡检触发时可能会没有异常分析**

在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

**3.在巡检过程中发现以前正常运行的脚本出现异常错误**

请在 DataFlux Func 的脚本市场中更新所引用的脚本集，可以通过[**变更日志**](https://func.guance.com/doc/script-market-guance-changelog/)来查看脚本市场的更新记录方便即时更新脚本。

**4.在升级巡检脚本过程中发现 Startup 中对应的脚本集无变化**

请先删除对应的脚本集后，再点击升级按钮配置对应{{{ custom_key.brand_name }}} API key 完成升级。

**5.开启巡检后如何判断巡检是否生效**

在「管理 / 自动触发配置」中查看对应巡检状态，首先状态应为已启用，其次可以通过点击执行来验证巡检脚本是否有问题，如果出现 xxx 分钟前执行成功字样则巡检正常运行生效。





