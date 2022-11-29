# Kubernetes Pod 异常重启巡检

---

## 背景

Kubernetes 帮助用户自动调度和扩展容器化应用程序，但现代 Kubernetes 环境正变得越来越复杂，当平台和应用工程师需要调查动态、容器化环境中的事件时，寻找最有意义的信号可能涉及许多试错步骤。通过智能巡检可以根据当前的搜索上下文过滤异常，从而加快事件调查、减轻工程师的压力、减少平均修复时间并改善最终用户体验。

## 前置条件

1. 在观测云中开启[「容器数据采集」](https://docs.guance.com/datakit/container/)
2. 自建 DataFlux Func 的离线部署
3. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
4. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
5. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」「观测云算法库」「 观测云自建巡检（K8S-Pod重启检测）」
6. 在自建的 DataFlux Func 中，编写自建巡检处理函数
7. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置或编写巡检函数时在装饰器中配置

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启 Kubernetes Pod 异常重启巡检配置

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as k8s_pod_restart


# obsserver
API_KEY_ID  = 'wsak_xxx'
API_KEY     = '5Kxxx'

def filter_namespace(cluster_namespaces):
    '''
    过滤 namespace 自定义符合要求 namespace 的条件，匹配的返回 True，不匹配的返回 False
    return True｜False
    '''

    cluster_name = cluster_namespaces.get('cluster_name','')
    namespace = cluster_namespaces.get('namespace','')
    if cluster_name in ['k8s-prod']:
        return True

'''  
任务配置参数请使用：
@DFF.API('K8S-Pod异常重启巡检', fixed_crontab='*/30 * * * *', timeout=900)

fixed_crontab：固定执行频率「每 30 分钟一次」
timeout：任务执行超时时长，控制在 15 分钟
'''    

# Kubernetes Pod 异常重启巡检配置 用户无需修改
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('K8S-Pod异常重启巡检', fixed_crontab='*/30 * * * *')
def run(configs=[]):
    """
    参数：
        configs：
            配置需要检测的 cluster_name （集群名称，可选，不配置根据 namespace 检测）
            配置需要检测的 namespace （命名空间，必选）

        配置示例： namespace 可以配置多个也可以配置单个
        configs = [
        {
            "cluster_name": "xxx",
            "namespace": ["xxx1", "xxx2"]
        },
        {
            "cluster_name": "yyy",
            "namespace": "yyy1"
        }
        ]

    """
    checkers = [
         # 配置 Kubernetes Pod 异常重启巡检
        k8s_pod_restart.K8SPodRestartCheck(configs=configs, filters=[filter_namespace]),
    ]

    Runner(checkers, debug=False).run()
```

## 开启巡检

### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../../img/k8s-pod-restart01.png)

### 在观测云中配置 Kubernetes Pod 异常重启巡检

![image](../../img/k8s-pod-restart02.png)

#### 启用/禁用

  智能巡检默认是「禁用」状态，可手动「启用」，开启后，就可以对配置好的 Kubernetes 集群中 Pod 进行巡检了。

#### 导出

  智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

#### 编辑

  智能巡检「Kubernetes Pod 异常重启巡检 」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

  * 筛选条件：配置需要巡检 Kubernetes 的 cluster_name（集群名称，可选，不配置时检测所有 namespace）和需要检测的 namespace （命名空间，必填）
  * 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

  配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../../img/k8s-pod-restart03.png)

  可以参考如下的 JSON 配置多个云账户和对应预算信息

  ```json
   // 配置示例： namespace 可以配置多个也可以配置单个
      configs =[
          {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
          {"cluster_name": "yyy","namespace": "yyy1"}
      ]
  ```

### 查看事件

  智能巡检基于观测云巡检算法，会查找当前配置的集群内是否会出现 Pod 异常重启的情况。对于异常情况，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

![image](../../img/k8s-pod-restart04.png)

### 事件详情页

  点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

  * 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
  * 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

#### 基础属性

  * 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
  * 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

  ![image](../../img/k8s-pod-restart05.png)

#### 事件详情

  * 事件概览：描述异常巡检事件的对象、内容等
  * 异常Pod：可查看当前 namespace 下异常 pod 的状态
  * container 状态：可查看详细的错误时间、容器 ID 状态、当前资源情况、容器类型；点击容器 ID 会进入具体容器详情页

![image](../../img/k8s-pod-restart06.png)
  ![image](../../img/k8s-pod-restart07.png)

#### 历史记录

  支持查看检测对象、异常/恢复时间和持续时长。

 ![image](../../img/k8s-pod-restart08.png)

#### 关联事件

  支持通过筛选字段和所选取的时间组件信息，查看关联事件。

 ![image](../../img/k8s-pod-restart09.png)



#### Kubernetes 指标

可以通过事件中的 Kubernetes 监控视图查看对应异常信息的更细粒度的信息, 和可能影响的因素

![image](../../img/k8s-pod-restart10.png)

## 常见问题

  **1.Kubernetes Pod 异常重启巡检的检测频率如何配置**

  * 可以通过 DataFlux Func 中，「管理 / 自动触发配置」为检测函数设置自动触发时间建议配置每 30 分钟执行一次。
  * 也可以在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='*/30 * * * *', timeout=900` ，在装饰器中添加配置优先于在「管理 / 自动触发配置」中配置，二者选一即可。

  **2.Kubernetes Pod 异常重启巡检触发时可能会没有异常分析**

  在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

  **3.在何种情况下会产生 Kubernetes Pod 异常重启巡检事件**

  以 cluster_name + namespace 下重启 pod 数占比数作为入口，当该指标在近 30 分钟出现升高时触发生成事件逻辑并进行根因分析

  

  
