# 应用性能巡检

---

## 背景

「应用性能检测」基于APM异常根因分析检测器，选择要检测的 `service` 、 `resource` 、 `project` 、 `env` 信息，定期对应用性能进行智能巡检，通过应用程序服务指标异常来自动分析该服务的上下游信息，为该应用程序确认根因异常问题。

## 前置条件

1. 在观测云「应用性能监测」已经存在接入的应用
2. 自建 DataFlux Func 的离线部署
3. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
4. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
5. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」「观测云算法库」「观测云自建巡检（APM 性能）」
6. 在自建的 DataFlux Func 中，编写自建巡检处理函数
7. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置或编写巡检函数时在装饰器中配置

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启应用性能巡检配置

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_apm__main as apm_main

# 账号配置
API_KEY_ID  = 'wsak_xxx'
API_KEY     = 'wsak_xxx'

def filter_project_servcie_sub(data):
    # {'project': None, 'service_sub': 'mysql:dev'}, {'project': None, 'service_sub': 'redis:dev'}, {'project': None, 'service_sub': 'ruoyi-gateway:dev'}, {'project': None, 'service_sub': 'ruoyi-modules-system:dev'}
    project = data['project']
    service_sub = data['service_sub']
    if service_sub in ['ruoyi-gateway:dev', 'ruoyi-modules-system:dev']:
        return True

'''
任务配置参数请使用：
@DFF.API('应用性能巡检', fixed_crontab='0 * * * *', timeout=900)

fixed_crontab：固定执行频率「每小时一次」
timeout：任务执行超时时长，控制在15分钟
'''    
   
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('应用性能巡检')
def run(configs=[]):
    '''
    参数：
    configs :
        project: 服务所属项目
        service_sub: 包括服务（service）、环境（env）、版本（version）通过 ":" 拼接而成，例："service:env:version"、"service:env"、"service:version"

    示例：
        configs = [
            {"project": "project1", "service_sub": "service1:env1:version1"},
            {"project": "project2", "service_sub": "service2:env2:version2"}
        ]
    '''
    checkers = [
        apm_main.APMCheck(configs=configs, filters=[filter_project_servcie_sub]),
    ]

    Runner(checkers, debug=False).run()
```

## 开启巡检

### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../img/apm01.png)


  ### 在观测云中配置应用性能巡检

  ![image](../img/apm02.png)

  #### 启用/禁用

  智能巡检默认是「禁用」状态，可手动「启用」，开启后，将对配置好的应用性能监测进行巡检。

  #### 导出

  智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

  #### 编辑

  智能巡检「 应用性能巡检 」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

  * 筛选条件：配置应用 project 服务所属项目、service_sub 包括服务（service）、环境（env）、版本（version）通过 ":" 拼接而成。
  * 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

  配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

  ![image](../img/apm03.png)

  可以参考如下的 JSON 配置多个云账户和对应预算信息

  ```json
   // 配置示例：
      configs = [
          {"project": "project1", "service_sub": "service1:env1:version1"},
          {"project": "project2", "service_sub": "service2:env2:version2"}
      ]
  ```

  ## 查看事件

  智能巡检基于观测云巡检算法，会查找 APM 指标中的异常情况，如 `resource` 突然发生异常。对于异常情况，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

![image](../img/apm04.png)

  ### 事件详情页

  点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

  * 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
  * 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

  #### 基础属性

  * 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
  * 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

  ![image](../img/apm05.png)

  #### 事件详情

  * 事件概览：描述异常巡检事件的对象、内容等
  * 异常详情：错误趋势：可查看当前应用近 1 个小时的性能指标
  * 异常影响：可查看当前链路的异常服务所影响到服务及资源
  * 异常链路采样：查看详细的出错时间、服务、资源、链路 ID；点击服务、资源会进入相应的数据查看器；点击链路 ID，会进入具体链路详情页。

![image](../img/apm06.png)
  ![image](../img/apm07.png)

  #### 历史记录

  支持查看检测对象、异常/恢复时间和持续时长。

 ![image](../img/apm08.png)

  #### 关联事件

  支持通过筛选字段和所选取的时间组件信息，查看关联事件。

  ![image](../img/apm09.png)

  ## 常见问题

  **1.应用性能巡检的检测频率如何配置**

  * 可以通过 DataFlux Func 中，「管理 / 自动触发配置」为检测函数设置自动触发时间建议配置每小时执行一次。
  * 也可以在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='0 * * * *', timeout=900` ，在装饰器中添加配置优先于在「管理 / 自动触发配置」中配置，二者选一即可。

  **2.应用性能巡检触发时可能会没有异常分析**

  在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

  **3.在何种情况下会产生应用性能巡检事件**

  以错误率、P90等指标作为切入口，当这指标其中有一个指标发生异常变动并产生上下游链路影响时，触发收集报警信息并进行根因分析。

  

  
