# 磁盘使用率巡检

---

## 背景

「磁盘使用率巡检」基于磁盘异常分析检测器，定期对主机磁盘进行智能巡检，通过出现磁盘异常的主机来进行根因分析，确定对应异常时间点的磁盘挂载点和磁盘信息，分析当前工作空间主机是否存在磁盘使用率问题。

## 前置条件

1. 自建 DataFlux Func 的离线部署
2. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
3. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
4. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」「观测云算法库」「 观测云自建巡检（磁盘使用率）」
5. 在自建的 DataFlux Func 中，编写自建巡检处理函数
6. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置或编写巡检函数时在装饰器中配置

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启磁盘使用率巡检配置

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_disk_usage__main as disk_usage_check

# 账号配置
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'wsak_xxxxx'


def filter_host(host):
    '''
    过滤 host，自定义符合要求 host 的条件，匹配的返回 True，不匹配的返回 False
    return True｜False
    '''
    if host == "iZuf609uyxtf9dvivdpmi6Z":
        return True

'''
任务配置参数请使用：
@DFF.API('磁盘使用率巡检', fixed_crontab='0 * * * *', timeout=900)

fixed_crontab：固定执行频率「每小时一次」
timeout：任务执行超时时长，控制在15分钟
'''

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('磁盘使用率巡检', fixed_crontab='0 * * * *', timeout=900)
def run(configs={}):
    '''
    参数：
    configs : 配置需要检测的 host 列表（可选，不配置默认检测当前工作空间下所有主机磁盘）

    示例：
        configs = {
            "hosts": ["localhost"]
        }
    '''
    checkers = [
        disk_usage_check.DiskUsageCheck(configs=configs, filters=[filter_host]), # 这里只是示例
    ]

    Runner(checkers, debug=False).run()
```

## 开启巡检

### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../img/disk-usage01.png)


### 在观测云中配置磁盘使用率巡检

![image](../img/disk-usage02.png)

#### 启用/禁用

磁盘使用率巡检默认是「开启」状态，可手动「关闭」，开启后，将对配置好主机列表进行巡检。

#### 导出

智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

#### 编辑

智能巡检「 磁盘使用率巡检」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

* 筛选条件：配置需要巡检的主机 hosts
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/disk-usage03.png)

可以参考如下的 JSON 配置多个云账户和对应预算信息

```json
 // 配置示例：
  configs = {
        "hosts": ["localhost"]
    }
```

>  **注意**：在自建的 DataFlux Func 中，编写自建巡检处理函数时也可以添加过滤条件（参考示例代码配置），要注意的是在观测云 studio 中配置的参数会覆盖掉编写自建巡检处理函数时配置的参数

## 查看事件

本巡检会扫描最近 14 天的磁盘使用率信息，一旦出现出现未来 48 小时会超过预警值时，智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

![image](../img/disk-usage04.png)

### 事件详情页

点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
* 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

#### 基础属性

* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/disk-usage05.png)

#### 事件详情

* 事件概览：描述异常巡检事件的对象、内容等。
* 异常详情：可查看当前异常磁盘的过去 14 天的使用率。
* 异常分析：可显示异常的主机、磁盘、挂载点信息帮助分析具体问题。

![image](../img/disk-usage06.png)

#### 历史记录

支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/disk-usage07.png)

#### 关联事件

支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/disk-usage08.png)

## 常见问题

**1.磁盘使用率巡检的检测频率如何配置**

* 可以通过 DataFlux Func 中，「管理 / 自动触发配置」为检测函数设置自动触发时间建议配置每小时执行一次。
* 也可以在自建的 DataFlux Func 中，编写自建巡检处理函数时在装饰器中添加`fixed_crontab='0 * * * *', timeout=900` ，在装饰器中添加配置优先于在「管理 / 自动触发配置」中配置，二者选一即可。

**2.磁盘使用率巡检触发时可能会没有异常分析**

在出现巡检报告中没有异常分析时，请检查当前 `datakit` 的数据采集状态。

