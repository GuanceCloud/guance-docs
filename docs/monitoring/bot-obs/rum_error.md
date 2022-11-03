# 前端应用日志错误巡检
---

## 背景

前端错误日志巡检 会帮助发现前端应用过去一小时内新出现的错误消息(聚类之后的Error Message),帮助开发和运维及时修复代码, 避免随着时间的积累对客户体验产生持续性伤害

## 前置条件

1. 在观测云「用户访问监测」已经存在接入的应用
2. 自建 DataFlux Func 的离线部署
3. 开启自建 DataFlux Func 的[脚本市场](https://func.guance.com/doc/script-market-basic-usage/)
4. 在观测云「管理 / API Key 管理」中创建用于进行操作的 [API Key](../../management/api-key/open-api.md)
5. 在自建的 DataFlux Func 中，通过「脚本市场」安装「观测云自建巡检 Core 核心包」「观测云算法库」「观测云自建巡检（rum）」
6. 在自建的 DataFlux Func 中，编写自建巡检处理函数
7. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置

## 配置巡检

在自建 DataFlux Func 创建新的脚本集开启云账户账单巡检配置

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_rum__main as main

# 观测云空间 API_KEY 配置(用户自行配置)
API_KEY_ID  = 'xxxxx'
API_KEY     = 'xxxx'

# RUM 错误类型自建巡检配置 用户无需修改
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('RUM-错误类型自建巡检')
def run(configs={}):
    """
    参数：
        configs：配置需要检测的 app_name 列表（可选，不配置默认检测所有 app_name）

        配置示例：
        configs = {
            "app_names": ["app_name_1", "app_name_2"]  # 应用名称列表
        }
    """
    checkers = [
 		# 配置 RUM 错误巡检
        main.RUMErrorCheck(configs=configs),
    ]

    Runner(checkers, debug=False).run()
```
## 开启巡检
### 在观测云中注册检测项

在 DataFlux Func 中在配置好巡检之后可以通过直接再页面中选择 `run()` 方法进行点击运行进行测试，在点击发布之后就可以在观测云「监控 / 智能巡检」中查看并进行配置

![image](../img/rum_error01.png)


### 在观测云中配置前端错误巡检

![image](../img/rum_error03.png)

#### 启用/禁用
智能巡检默认是「禁用」状态，可手动「启用」，开启后，将对配置好的前端应用列表进行巡检。

#### 导出
智能巡检支持“导出 JSON 配置”。在智能巡检列表右侧的操作菜单下，点击「导出」按钮，即可导出当前巡检的 JSON 代码，导出文件名格式：智能巡检名称.json 。

#### 编辑
智能巡检「 前端错误巡检」支持用户手动添加筛选条件，在智能巡检列表右侧的操作菜单下，点击「编辑」按钮，即可对巡检模版进行编辑。

* 筛选条件：配置前端应用 app_id
* 告警通知：支持选择和编辑告警策略，包括需要通知的事件等级、通知对象、以及告警沉默周期等

配置入口参数点击编辑后在参数配置中填写对应的检测对象点击保存开始巡检：

![image](../img/rum_error02.png)

可以参考如下的 JSON 配置多个云账户和对应预算信息

```json
 // 配置示例：
    configs = {
        "app_ids": ["app_id_1", "app_id_2"]  # 应用id
    }
```

## 查看事件
观测云会将所有浏览器客户端的错误信息进行自动聚类, 本巡检将会比较过去一小时与过去 12 小时所有错误信息, 一旦出现从没有出现过的错误就进行告警, 智能巡检会生成相应的事件，在智能巡检列表右侧的操作菜单下，点击「查看相关事件」按钮，即可查看对应异常事件。

![image](../img/rum_error04.png)

### 事件详情页
点击「事件」，可查看智能巡检事件的详情页，包括事件状态、异常发生的时间、异常名称、基础属性、事件详情、告警通知、历史记录和关联事件。

* 点击详情页右上角的「查看监控器配置」小图标，支持查看和编辑当前智能巡检的配置详情
* 点击详情页右上角的「导出事件 JSON」小图标，支持导出事件的详情内容

#### 基础属性
* 检测维度：基于智能巡检配置的筛选条件，支持将检测维度 `key/value` 复制、添加到筛选、以及查看相关日志、容器、进程、安全巡检、链路、用户访问监测、可用性监测以及 CI 等数据
* 扩展属性：选择扩展属性后支持以 `key/value` 的形式复制、正向/反向筛选

![image](../img/rum_error05.png)

#### 事件详情
* 事件概览：描述异常巡检事件的对象、内容等
* 前端错误趋势：可查看当前前端应用过去一小时的出错统计
* 新错误详情：查看详细的出错时间, 错误信息, 错误类型, 错误堆栈, 错误条数; 点击错误信息, 错误类型 会进入相应的数据查看器; 点击错误堆栈, 会进入具体的错误堆栈详情页.

![image](../img/rum_error06.png)
![image](../img/rum_error09.png)

#### 历史记录
支持查看检测对象、异常/恢复时间和持续时长。

![image](../img/rum_error07.png)

#### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。

![image](../img/rum_error08.png)

## 常见问题
**1.前端应用日志错误巡检的检测频率如何配置**

在 DataFlux Func 中，通过「管理 / 自动触发配置」为检测函数设置自动触发时间建议配置每小时执行一次








