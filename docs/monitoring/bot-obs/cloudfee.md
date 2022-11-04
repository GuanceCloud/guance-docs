# 云账户账单巡检集成文档
---

## 背景

云账户账单巡检帮助用户管理云服务的预算预警、异常费用预警、预测费用情况并为用户提供可视化能力，支持多维度可视化云服务资源的消费情况。

## 前置条件

1. 进行自建 DataFlux Func 的离线部署
2. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
3. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
4. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」、「观测云算法库」、「观测云自建巡检（账单）」
5. 在脚本市场中安装开启[「观测云集成（华为云-账单采集）」](https://func.guance.com/doc/script-market-guance-aliyun-billing/)、[「观测云集成（阿里云-账单采集）」](https://func.guance.com/doc/script-market-guance-huaweicloud-billing/)、[「观测云集成（腾讯云-账单采集）」](https://func.guance.com/doc/script-market-guance-tencentcloud-billing/) 并且收集数据天数超过 15 天
6. 在自建的 DataFlux Func 中，编写自建巡检处理函数
7. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启云账户账单巡检配置

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_billing__main as main

# 观测云空间 API_KEY 配置(用户自行配置)
API_KEY_ID  = 'xxxxx'
API_KEY     = 'xxxx'

# 云账单配置 用户无需修改
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('云账户账单巡检')
def run(configs=None):
    '''
    configs : 列表类型
    configs = [
        {
            "account_id": "10000000",    # 账户 ID
            "budget": 20000,             # 账单预算 数值类型
            "cloud_provider": "aliyun"   # 云厂商名称 可选参数 aliyun，huaweicloud，tencentcloud
        },
        ...
    ]
    '''
    # 云账单检测器配置
    checkers = [
        main.CloudChecker(configs=configs),
    ]

    # 执行云资产检测器
    Runner(checkers, debug=False).run()
```
## 开启巡检

### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../img/cloudfee01.png)


### 在观测云中配置云账户账单巡检

![image](../img/cloudfee04.png)

#### 启用/禁用

智能巡检「应用性能检测」默认是「禁用」状态，可手动「启用」，开启后，将对配置好的云账户进行巡检。

#### 导出

智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

#### 编辑

智能巡检「云账户账单巡检」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

* 筛选条件：配置对应云厂商、云账户、当月账户预算信息
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/cloudfee05.png)

可以参考如下的 JSON 配置多个云账户和对应预算信息

```json
[
  {
    "account_id"    : "wsak_3132xxxxxxxxxxx",
    "cloud_provider": "aliyun",
    "budget"        : 10000
	},
  {
    "account_id"    : "wsak_3132xxxxxxxxxxx",
    "cloud_provider": "aliyun",
    "budget"        : 100011
	},
  {
    "account_id"    : "wsak_3132xxxxxxxxxxx",
    "cloud_provider": "aliyun",
    "budget"        : 9999
	}
]
```

## 查看事件
智能巡检基于观测云智能算法，会查找云资产费用、预算指标中的异常情况，如云资产费用突然然发生异常。对于异常情况，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

当配置好相应的云厂商云账户和当月预算后，云账户账单巡检会根据配置在发现异常后生成两种类型事件来配合我们来排查错误信息

![image](../img/cloudfee06.svg)

### 事件详情页
点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
* 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

#### 基础属性

* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/cloudfee07.png)

#### 事件详情

- 事件概览：描述异常巡检事件的对象、内容等
- 成本分析：可查看当前异常云账户的近 30 天的消费趋势
	- 异常区间：智能巡检数据中的异常开始时间到结束时间

- 消费金额排名：查看当前云账户产品费用排名
- 费用预测：预测云账户当月剩余日期的消费金额
	- 置信区间：预测趋势线的准确范围

- 月度预算：当前账户费用占月度预算的情况

##### 云账户费用超出预算

![image](../img/cloudfee08.png)

##### 云账户费用异常增长

![image](../img/cloudfee09.png)

#### 历史记录
支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/cloudfee10.png)

#### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/cloudfee11.png)
#### 视图链接
可以通过事件列表中的云账单费用监控视图查看对应异常信息的更细粒度的信息, 和可能影响的因素
![image](../img/cloudfee12.png)

## 常见问题
**1.云账户账单巡检的检测频率如何配置**

在 DataFlux Func 中，通过「管理 / 自动触发配置」为检测函数设置自动触发时间建议配置每天执行一次，因为云账单相关数据是每天收集一次前一天的产品费用

**2.云账户账单巡检收集的相关指标集怎么看**

指标集： `cloud_bill` 

**3.在何种情况下会产生云账户账单巡检事件**

以指定云厂商产品费用总和作为入口，当该费用信息出现显著变化时或总费用的预算超出配置的预算时触发生成事件逻辑进行根因分析，产生巡检事件。

* 跟踪阈值：如当期费用同比环比 > 100%
* 跟踪预算：当月费用总和 > 设定预算





