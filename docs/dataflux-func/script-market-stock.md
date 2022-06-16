# 股票数据同步
---


本文档主要介绍如何使用脚本市场中「股票数据同步」脚本包同步股票的相关数据。

> 提示：请始终使用最新版DataFlux Func 进行操作。

> 提示2: 本脚本包会不断加入新功能，请随时关注本文档页。

## 1. 背景

在使用观测云的过程中，云平台的一些数据可能无法通过DataKit 直接采集。

因此，DataFlux Func 提供了与各云平台对应的数据同步脚本包。用户可以从脚本市场安装相关的数据同步脚本包，进行简单的配置后，即可同步云平台的数据。

本文假设用户已经了解并安装了相关脚本包。
有关如何在DataFlux Func 的脚本市场中安装脚本版，请参考：

- [脚本市场基本操作](/dataflux-func/script-market-basic-usage)

本文假设用户已经在DataFlux Func 中正确连接了DataKit。
有关如何在DataFlux Func 中连接DataKit，请参考：

- [连接并操作DataKit](/dataflux-func/connect-to-datakit)

## 2. 关于本脚本包

本脚本包主要用于股票数据的获取并同步至观测云。

使用本脚本包，在通知方面可能需要钉钉机器人对应权限的Webhook和加签密钥。您可在钉钉「智能机器人」中创建，并获取Webhook和加签密钥。

配置所需的所有权限如下：

| 钉钉产品             | 类型          | 是否必须 | 示例                                                                          |
| -------------------- | ------------- | -------- | ----------------------------------------------------------------------------- |
| stock_code_list      | List          |          | `['<股票代码1示例：sh0000001>', '<股票代码2示例：sz0000001>']`                |
| stock_threshold_up   | Float/Integer |          | `<股票上涨超过多少提醒>`                                                      |
| stock_threshold_down | Float/Integer |          | `<股票下跌超过多少提醒>`                                                      |
| datakit_id           | String        | 必须     | DataKit数据源ID                                                               |
| measurement          | String        |          | 指定写入的指标集名称，默认：`"股票数据"`                                      |
| dingtalk_webhook     | String        |          | `https://oapi.dingtalk.com/robot/send?access_token=<您对应的钉钉机器人token>` |
| dingtalk_secret      | String        |          | `<您的钉钉机器人密钥>`                                                        |

## 3. 典型代码示例

通过简单的配置和极少量代码，即可实现相关数据的同步功能。

### 3.1 股票数据同步使用示例(dataflux_stock__sync_stock_example)

以下典型代码示例为实现同步功能的最简单配置，填写好必要的「CONFIG」信息后，创建自动触发配置，用户可在观测云上查看各类数据各类时间段的折线图。

```python
import  dataflux_stock__sync as sync
import  dataflux_stock__reminder as reminder

CONFIG = {
    'datakit_id'          : '<希望写入Datakit的ID>',
    'measurement'         : '<希望写入的指标集，可选>',
    'dingtalk_webhook'    : '<钉钉机器人Webhook>',
    'dingtalk_secret'     : '<钉钉机器人加签密钥>',
    'stock_code_list'     : ['<股票代码1示例：sh0000001>', '<股票代码2示例：sz0000001>'],
    'stock_threshold_up'  : '<股票上涨超过多少提醒>',
    'stock_threshold_down': '<股票下跌超过多少提醒>'
}

sync.config(**CONFIG)

@DFF.API('主函数')
def starter():
    sync.sync_stock()
```

### 3.2 超过阈值提醒使用示例(`dataflux_stock__sync_stock_example`)

以下典型代码示例为实现超过阈值提醒功能，填写好必要的「CONFIG」信息后，创建自动触发配置，用户配置的钉钉机器人等第三方通知软件中收到超过阈值提示，例如：2021-11-16 14:03:58股票上证指数上涨了2.087%

```python
import  dataflux_stock__sync as sync
import  dataflux_stock__reminder as reminder

CONFIG = {
    'datakit_id' : '<希望写入Datakit的ID>',
    'measurement' : '<希望写入的指标集，可选>',
    'dingtalk_webhook' : '<钉钉机器人Webhook>',
    'dingtalk_secret' : '<钉钉机器人加签密钥>',
    'stock_code_list' : ['<股票代码1示例：sh0000001>', '<股票代码2示例：sz0000001>'],
    'stock_threshold_up' : '<股票上涨超过多少提醒>',
    'stock_threshold_down' : '<股票下跌超过多少提醒>'
}

sync.config(**CONFIG)

@DFF.API('提示功能')
def func_remind():
    reminder.threshold_alert()
```

```python
@DFF.API('指定股票涨跌超过阈值提示')
def threshold_alert():
    stock_data = common.get_stock_data(C['stock_code_list'])
    # 获取静态下标
    stock_info_basic = common.get_stock_info_map(common.STOCK_INFO)
    stock_name_loc = stock_info_basic.get('stockName')['loc']
    stock_month = stock_info_basic.get('stockMonth')['loc']
    stock_time = stock_info_basic.get('stockTime')['loc']

    # 获取动态下标
    incre_per_loc = common.get_stock_info_map(common.get_stock_info_dynamic()).get('increPer')['loc']

    for stock in stock_data:
        stock_name = stock_data[stock][stock_name_loc]
        now_percent = float(stock_data[stock][incre_per_loc])
        time = str(stock_data[stock][stock_month]) + " " + str(stock_data[stock][stock_time])

        # 获取缓存值
        cache_key = 'dataflux_stock:increPer'
        cache_percent = DFF.CACHE.get(cache_key, scope=stock_name)
        pre_precent = float(cache_percent) if cache_percent else 0

        if now_percent >= C['stock_threshold_up'] and now_percent > pre_precent:
            common.send_dingtalk(dingtalk_text('上涨', stock_name, now_percent, time))
            DFF.CACHE.set(cache_key, now_percent, expire=3600, scope=stock_name)
        elif now_percent <= C['stock_threshold_down'] and now_percent < pre_precent:
            common.send_dingtalk(dingtalk_text('下跌', stock_name, now_percent, time))
            DFF.CACHE.set(cache_key, now_percent, expire=3600, scope=stock_name)
```

## 4. 创建自动触发配置

根据3. 配置完所有信息后，就可以使用脚本的核心功能。本脚本还带有「指定股票涨跌超过阈值提示」的功能

用户可以在DataFlux func的上方导航栏中选择「管理」进入后选择「自动触发配置」，点击「新建」，执行函数中选择「<用户自定脚本名> / 用户使用脚本 / 提示功能」，其他无需填写，只需在下面勾选用户所需提醒的时间即可。

## X. 附录

本脚本中所涉及的相关配置项目，根据本附录查询。

### X.1 可用的股票代码

上海证券交易所请以`sh`开头

深圳证券交易所请以`sz`开头

北京证券交易所请以`bj`开头

详情股票代码请参考相关文档
