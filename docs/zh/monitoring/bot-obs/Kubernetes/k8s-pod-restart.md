# Kubernetes Pod 异常重启巡检

---

## 背景

Kubernetes 帮助用户自动调度和扩展容器化应用程序，但现代 Kubernetes 环境正变得越来越复杂，当平台和应用工程师需要调查动态、容器化环境中的事件时，寻找最有意义的信号可能涉及许多试错步骤。通过智能巡检可以根据当前的搜索上下文过滤异常，从而加快事件调查、减轻工程师的压力、减少平均修复时间并改善最终用户体验。

## 前置条件

1. 在<<< custom_key.brand_name >>>中开启「 [容器数据采集 ](<<< homepage >>>/datakit/container/)」
2. 自建 [DataFlux Func <<< custom_key.brand_name >>>特别版](https://func.guance.com/#/) ，或者开通 [DataFlux Func 托管版](../../../dataflux-func/index.md)
4. 在<<< custom_key.brand_name >>>「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../../management/api-key/open-api.md)

> **注意**：如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的<<< custom_key.brand_name >>> SaaS 部署在[同一运营商同一地域](../../../plans/commercial-register.md#site)。

## 开启巡检

在自建的 DataFlux Func 中，通过「脚本市场」安装「 <<< custom_key.brand_name >>>自建巡检（K8S-Pod重启检测）」并根据提示配置<<< custom_key.brand_name >>> API Key 完成开启。 

在 DataFlux Func 脚本市场中选择需要开启的巡检场景点击安装，配置<<< custom_key.brand_name >>> API Key 和 [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) 后选择部署启动脚本即可

![image](../../img/create_checker.png)

启动脚本部署成功后，会自动创建启动脚本和自动触发配置，可以通过链接直接跳转查看对应配置。

![image](../../img/success_checker.png)

## 配置巡检

### 在<<< custom_key.brand_name >>>中配置巡检

![image](../../img/k8s-pod-restart02.png)

#### 启用/禁用

  智能巡检默认是**禁用**状态，可手动**启用**，开启后，就可以对配置好的 Kubernetes 集群中 Pod 进行巡检了。

#### 编辑

  智能巡检「Kubernetes Pod 异常重启巡检 」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击**编辑**按钮，即可对巡检模版进行编辑。

  * 筛选条件：配置需要巡检 Kubernetes 的 cluster_name（集群名称，可选，不配置时检测所有 namespace）和需要检测的 namespace （命名空间，必填）
  * 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

  配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../../img/k8s-pod-restart03.png)

  可以参考如下的 JSON 配置多个集群及命名空间信息

  ```json
   // 配置示例：namespace 可以配置多个也可以配置单个
      configs =[
          {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
          {"cluster_name": "yyy","namespace": "yyy1"}
      ]
  ```

>  **注意**：在自建的 DataFlux Func 中，编写自建巡检处理函数时也可以添加过滤条件（参考示例代码配置），要注意的是在<<< custom_key.brand_name >>> studio 中配置的参数会覆盖掉编写自建巡检处理函数时配置的参数

### 在 DataFlux Func 中配置巡检

在 DataFlux Func 中在配置好巡检所需的过滤条件之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后脚本就会正常执行了。也可以在<<< custom_key.brand_name >>>「监控 / 智能巡检」中查看或更改配置。

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_k8s_pod_restart__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_namespace(cluster_namespaces):
    '''
    过滤 host，自定义符合要求 host 的条件，匹配的返回 True，不匹配的返回 False
    return True｜False
    '''
     cluster_name = cluster_namespaces.get('cluster_name','')
     namespace = cluster_namespaces.get('namespace','')
     if cluster_name in ['xxxx']:
         return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('K8S-Pod 重启检测巡检', fixed_crontab='*/30 * * * *', timeout=900)
def run(configs=None):
    """
    可选参数：
        configs：(不配置默认检测所有，配置的情况请遵循下面的内容)
            配置需要检测的 cluster_name （集群名称，可选，不配置根据 namespace 检测）
            配置需要检测的 namespace （命名空间，必选）

    示例：namespace 可以配置多个也可以配置单个
        configs =[
            {"cluster_name": "xxx", "namespace": ["xxx1", "xxx2"]},
            {"cluster_name": "yyy","namespace": "yyy1"}
        ]

    """
    checkers = [
        k8s_pod_restart.K8SPodRestartCheck(configs=configs, filters=[filter_namespace]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



### 查看事件

  智能巡检基于<<< custom_key.brand_name >>>巡检算法，会查找当前配置的集群内是否会出现 Pod 异常重启的情况。对于异常情况，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击**查看相关事件**按钮，即可查看对应异常事件。

![image](../../img/k8s-pod-restart04.png)

### 事件详情页

  点击**事件**，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

  * 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情

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

  * 在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='*/30 * * * *', timeout=900` ，后在「管理 / 自动触发配置」中配置。

**2.Kubernetes Pod 异常重启巡检触发时可能会没有异常分析**

  在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

**3.在何种情况下会产生 Kubernetes Pod 异常重启巡检事件**

  以 cluster_name + namespace 下重启 pod 数占比数作为入口，当该指标在近 30 分钟出现升高时触发生成事件逻辑并进行根因分析

**4.在巡检过程中发现以前正常运行的脚本出现异常错误**

请在 DataFlux Func 的脚本市场中更新所引用的脚本集，可以通过[**变更日志**](https://func.guance.com/doc/script-market-guance-changelog/)来查看脚本市场的更新记录方便即时更新脚本。

**5.在升级巡检脚本过程中发现 Startup 中对应的脚本集无变化**

请先删除对应的脚本集后，再点击升级按钮配置对应<<< custom_key.brand_name >>> API key 完成升级。

**6.开启巡检后如何判断巡检是否生效**

在「管理 / 自动触发配置」中查看对应巡检状态，首先状态应为已启用，其次可以通过点击执行来验证巡检脚本是否有问题，如果出现 xxx 分钟前执行成功字样则巡检正常运行生效。

  
