# 服务端应用错误巡检

---

## 背景

当服务端出现运行错误时，我们需要提早发现及时预警来让开发运维进行排错，及时确认错误是否对应用有潜在影响。服务端应用错误巡检事件上报的内容是提醒开发运维在过去一小时里应用出现了新的错误并定位到具体的出错的地方将关联的诊断线索一起提供给用户。

## 前置条件

1. 在观测云「应用性能监测」已经存在接入的应用
2. 自建 [DataFlux Func](https://func.guance.com/#/) 的离线部署
3. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
4. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
5. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」「观测云算法库」「 观测云自建巡检（APM 错误）」
6. 在自建的 DataFlux Func 中，编写自建巡检处理函数
7. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置

> **注意：**如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的观测云 SaaS 部署在[同一运营商同一地域](../../../getting-started/necessary-for-beginners/select-site/)。

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启内存泄漏巡检配置

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_apm_error__main as main

# 账号配置
API_KEY_ID  = 'wsak_xxxxxx'
API_KEY     = '5K3Ixxxxxx'

# 函数 filters 参数过滤器和观测云 studio 监控\智能巡检配置中存在调用优先级，配置了函数 filters 参数过滤器后则不需要在观测云 studio 监控\智能巡检中更改检测配置了，如果两边都配置的话则优先生效脚本中 filters 参数

def filter_project_servcie_sub(data):
    # {'project': None, 'service_sub': 'mysql:dev'}, {'project': None, 'service_sub': 'redis:dev'}, {'project': None, 'service_sub': 'ruoyi-gateway:dev'}, {'project': None, 'service_sub': 'ruoyi-modules-system:dev'}
    project = data['project']
    service_sub = data['service_sub']
    if service_sub in ['ruoyi-08-auth:dev:1.0']:
        return True

'''
任务配置参数请使用：
@DFF.API('服务端应用错误巡检', fixed_crontab='0 * * * *', timeout=1800)

fixed_crontab：固定执行频率「每小时一次」
timeout：任务执行超时时长，控制在 30 分钟
'''

# 服务端应用错误巡检配置 用户无需修改
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('服务端应用错误巡检', fixed_crontab='0 * * * *', timeout=1800)
def run(configs={}):
    """
    参数：
        configs：配置需要检测的 app_name 列表（可选，不配置默认检测所有 app_name）

        配置示例：
        configs = {
            "project": ["project", "project2"]  项目
            "env"    : ["env1", "env2"]         环境
            "version": ["version1", "version2"] 版本
            "service": ["service1", "service2"] 服务
        }
    """
    checkers = [
        # APM 错误巡检
        main.ApmErrorCheck(configs=configs, filters=[filter_project_servcie_sub]),

    ]

    Runner(checkers, debug=False).run()
```

## 开启巡检

### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../img/apm-errors01.png)

### 在观测云中配置服务端应用错误巡检

![image](../img/apm-errors02.png)

#### 启用/禁用

内存泄漏巡检默认是「开启」状态，可手动「关闭」，开启后，将对配置好的服务列表进行巡检。

#### 导出

智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

#### 编辑

智能巡检「 服务端应用错误巡检 」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

* 筛选条件：配置需要检测的 app_name 列表（可选，不配置默认检测所有 app_name）
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/apm-errors03.png)

可以参考如下的 JSON 配置多个项目、环境、版本和服务的信息

```json
 // 配置示例：
    configs = {
        "project": ["project", "project2"]  项目
        "env"    : ["env1", "env2"]         环境
        "version": ["version1", "version2"] 版本
        "service": ["service1", "service2"] 服务
    }
```

>  **注意**：在自建的 DataFlux Func 中，编写自建巡检处理函数时也可以添加过滤条件（参考示例代码配置），要注意的是在观测云 studio 中配置的参数会覆盖掉编写自建巡检处理函数时配置的参数

## 查看事件

本巡检会扫描最近 1 小时的新增应用错误信息，一旦出现未发生的新错误，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

![image](../img/apm-errors04.png)

### 事件详情页

点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
* 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

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
