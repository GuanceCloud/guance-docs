# 阿里云抢占式实例存活巡检
---

## 背景

由于抢占式实例的市场价格会随供需变化而浮动，需要在创建抢占式实例时指定出价模式，当指定实例规格的实时市场价格低于出价且库存充足时，才能成功创建抢占式实例。所以说对于云资产的抢占实例巡检就显得尤为重要，通过巡检当发现抢占式实例即将被释放时，会提示当前规格的抢占实例的所有可用区的最新价格以及改抢占式实例的历史价格并给出恰当的处理意见。

## 前置条件

1. 自建  [DataFlux Func](https://func.guance.com/#/) 的离线部署
2. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
3. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
4. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」「观测云算法库」「 观测云自建巡检（阿里云抢占式实例存活检测）」
5. 在自建的 DataFlux Func 中，编写自建巡检处理函数
6. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置

> **注意：**如果考虑采用云服务器来进行 DataFlux Func 离线部署的话，请考虑跟当前使用的观测云 SaaS 部署在[同一运营商同一地域](../../../getting-started/necessary-for-beginners/select-site/)。

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启前端错误日志巡检配置

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_aliyun_spot_alive__main as spot_instance

API_KEY_ID  = 'xxxxx'
API_KEY     = 'xxxxx'

'''
任务配置参数请使用：
@DFF.API('阿里云抢占式实例存活巡检', fixed_crontab='*/2 * * * *', timeout=60)

fixed_crontab：固定执行频率「每2分钟一次」
timeout：任务执行超时时长，控制在1分钟
'''

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('阿里云抢占式实例存活巡检', fixed_crontab='*/2 * * * *', timeout=60)
def run(configs=[]):
    """
    参数：instance_type
        configs：
            配置需要检测的 instance_type （配置类型,可配置一个也可配置多个）ecs.s6-c1m1.small
            配置需要检测的 spot_with_price_limit （接受的折扣）0.12

        配置示例： 可以配置多组也可以配置单个
        configs = [{"instance_type": "xxx1","spot_with_price_limit": "xxx2"}]

    """
    checkers = [
        spot_instance.SPOTInstanceCheck(configs=configs),
    ]

    Runner(checkers, debug=False).run()
```
## 开启巡检
### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../img/spot_alive01.png)


### 在观测云中配置阿里云抢占式实例存活巡检

![image](../img/spot_alive02.png)

#### 启用/禁用
阿里云抢占式实例存活巡检默认是「开启」状态，可手动「关闭」，开启后，将对配置好的抢占式实例配置列表进行巡检。

#### 导出
智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

#### 编辑
智能巡检「 阿里云抢占式实例存活巡检」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

* 筛选条件：配置 instance_type 配置类型、spot_with_price_limit 接受的折扣
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/spot_alive03.png)

可以参考如下的 JSON 配置多个应用信息

```json
 // 配置示例： 可以配置多组也可以配置单个
    configs = [{"instance_type": "xxx1","spot_with_price_limit": "xxx2"}]
```

## 查看事件
观测云会根据当前的抢占式实例的状态进行巡检当发现快要释放的抢占式实例，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

![image](../img/spot_alive04.png)

### 事件详情页
点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
* 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

#### 基础属性
* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/spot_alive05.png)

#### 事件详情
* 事件概览：描述异常巡检事件的对象、内容等
* 抢占式实例详情：可查看当前实例的详细信息包括实例名称、ID、地域、可用区等
* 抢占式实例类型价格：查看当前规格下所有可用区的价格帮助用户进行出价
* 抢占式实例类型历史价格：可查看当前规格的抢占式实例再不同可用区的历史价格方便追踪价格变动
* 温馨建议：给出当前异常场景的操作建议

![image](../img/spot_alive06.png)

#### 历史记录
支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/spot_alive07.png)

#### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/spot_alive08.png)

## 常见问题
**1.阿里云抢占式实例存活巡检的检测频率如何配置**

* 在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='*/2 * * * *', timeout=60` ，后在「管理 / 自动触发配置」中配置。

**2.阿里云抢占式实例存活巡检触发时可能会没有异常分析**

在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

**3.在巡检过程中发现以前正常运行的脚本出现异常错误**

请在 DataFlux Func 的脚本市场中更新所引用的脚本集，可以通过[**变更日志**](https://func.guance.com/doc/script-market-guance-changelog/)来查看脚本市场的更新记录方便即时更新脚本。






