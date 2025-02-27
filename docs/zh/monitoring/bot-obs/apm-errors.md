# 服务端应用错误巡检

---

## 背景

当服务端出现运行错误时，我们需要提早发现及时预警来让开发运维进行排错，及时确认错误是否对应用有潜在影响。服务端应用错误巡检事件上报的内容是提醒开发运维在过去一小时里应用出现了新的错误并定位到具体的出错的地方将关联的诊断线索一起提供给用户。

## 前置条件

1. {{{ custom_key.brand_name }}}「[应用性能监测](../../application-performance-monitoring/collection/index)」已经存在接入的应用
2. 自建 [DataFlux Func {{{ custom_key.brand_name }}}特别版](https://func.guance.com/#/) ，或者开通 [DataFlux Func 托管版](../../dataflux-func/index.md)
4. 在{{{ custom_key.brand_name }}}「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)

> **注意**：如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的{{{ custom_key.brand_name }}} SaaS 部署在[同一运营商同一地域](../../../getting-started/necessary-for-beginners/select-site/)。

## 开启巡检

在自建的 DataFlux Func 中，通过「脚本市场」安装「 {{{ custom_key.brand_name }}}自建巡检（APM 错误）」并根据提示配置{{{ custom_key.brand_name }}} API Key 完成开启。

在 DataFlux Func 脚本市场中选择需要开启的巡检场景点击安装，配置{{{ custom_key.brand_name }}} API Key 和 [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) 后选择部署启动脚本即可

![image](../img/create_checker.png)

启动脚本部署成功后，会自动创建启动脚本和自动触发配置，可以通过链接直接跳转查看对应配置。

![image](../img/success_checker.png)

## 配置巡检

在{{{ custom_key.brand_name }}} studio 监控-智能巡检模块中或 DataFlux Func 自动创建的启动脚本中配置想要过滤的巡检条件即可，可以参考下面两种配置方式

### 在{{{ custom_key.brand_name }}}中配置巡检

![image](../img/apm-errors02.png)

#### 启用/禁用

内存泄漏巡检默认是「开启」状态，可手动「关闭」，开启后，将对配置好的服务列表进行巡检。



#### 编辑

智能巡检「 服务端应用错误巡检 」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击**编辑**按钮，即可对巡检模版进行编辑。

* 筛选条件：配置需要检测的 app_name 列表（可选，不配置默认检测所有 app_name）
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/apm-errors03.png)

可以参考如下的配置多个项目、环境、版本和服务的信息

```json
 // 配置示例：
    configs 配置实例：
        project1:service1:env1:version1
        project2:service2:env2:version2
```

>  **注意**：在自建的 DataFlux Func 中，编写自建巡检处理函数时也可以添加过滤条件（参考示例代码配置），要注意的是在{{{ custom_key.brand_name }}} studio 中配置的参数会覆盖掉编写自建巡检处理函数时配置的参数

### 在 DataFlux Func 中配置巡检

在 DataFlux Func 中在配置好巡检所需的过滤条件之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后脚本就会正常执行了。也可以在{{{ custom_key.brand_name }}}「监控 / 智能巡检」中查看或更改配置。

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_apm_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    project = data['project']
    service_sub = data['service_sub']
    '''
    过滤 service_sub，自定义符合 service_sub 的条件，匹配的返回 True，不匹配的返回 False
    return True｜False
    '''
    if service_sub in ['xxx-xxx-auth:dev:1.0']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('APM 新增错误类型', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    可选参数：
        configs :
            可以指定多个 service（通过换行拼接），不指定则检测所有 service。
            每个 service 由服务所属项目 (project), 服务（service）、环境（env）、版本（version）通过 ":" 拼接而成，例："project1:service:env:version"
    示例：
        configs 配置实例：
            project1:service1:env1:version1
            project2:service2:env2:version2
    """
    checkers = [
        main.ApmErrorCheck(configs=configs, filters=[filter_project_servcie_sub]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



## 查看事件

本巡检会扫描最近 1 小时的新增应用错误信息，一旦出现未发生的新错误，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击**查看相关事件**按钮，即可查看对应异常事件。

![image](../img/apm-errors04.png)

### 事件详情页

点击**事件**，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情

#### 基础属性

* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/apm-errors05.png)

#### 事件详情

* 事件概览：描述异常巡检事件的对象、内容等。
* 错误分布：可查看当前异常应用过去 1 小时出现的错误数变化情况。
* 错误详情：可显示异常应用的新增错误详情及具体错误计数，可以点击具体的错误信息、错误类型、错误堆栈跳转到错误详情页进行查看

![image](../img/apm-errors06.png)

![image](../img/apm-errors07.png)

#### 历史记录

支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/apm-errors08.png)

#### 关联事件

支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/apm-errors09.png)

## 常见问题

**1.服务端应用错误巡检的检测频率如何配置**

* 在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='0 * * * *', timeout=1800` ，后在「管理 / 自动触发配置」中配置。

**2.服务端应用错误巡检触发时可能会没有异常分析**

在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

**3.在何种情况下会产生服务端应用错误巡检事件**

服务端应用错误巡检会扫描最近 1 小时的新增应用错误信息，一旦出现未发生的新错误类型，智能巡检会生成相应的事件。

**4.在巡检过程中发现以前正常运行的脚本出现异常错误**

请在 DataFlux Func 的脚本市场中更新所引用的脚本集，可以通过[**变更日志**](https://func.guance.com/doc/script-market-guance-changelog/)来查看脚本市场的更新记录方便即时更新脚本。

**5.在升级巡检脚本过程中发现 Startup 中对应的脚本集无变化**

请先删除对应的脚本集后，再点击升级按钮配置对应{{{ custom_key.brand_name }}} API key 完成升级。

**6.开启巡检后如何判断巡检是否生效**

在「管理 / 自动触发配置」中查看对应巡检状态，首先状态应为已启用，其次可以通过点击执行来验证巡检脚本是否有问题，如果出现 xxx 分钟前执行成功字样则巡检正常运行生效。
