# 天气信息

本文档主要介绍如何使用脚本市场中的「天气信息」脚本包获取最新的天气数据、生活指数等信息。

> 提示：请始终使用最新版DataFlux Func 进行操作。

> 提示2: 本脚本包会不断加入新功能，请随时关注本文档页。

## 1. 背景

天气情况对每个人的日常生活有着重要的影响。因此，DataFlux Func 提供天气信息信息脚本。用户可以从脚本市场安装相关的数据同步脚本包，进行简单的配置后，即可查看每天的天气信息以及生活指数。

本文假设用户已经了解并安装了相关脚本包。
有关如何在DataFlux Func 的脚本市场中安装脚本版，请参考：

- [脚本市场简介](https://func.guance.com/doc/func-script-market-intro)

本文假设用户已经在DataFlux Func 中正确连接了DataKit。
有关如何在DataFlux Func 中连接DataKit，请参考：

- [连接并操作DataKit](https://func.guance.com/doc/func-connect-to-datakit)

本脚本包基于「[聚合数据](https://www.juhe.cn/)」提供的API实现，
用户在使用本脚本包时，请先登录注册「聚合数据」，并获取Key后使用。

## 2. 关于本脚本包

本脚本包主要用于天气信息的获取并同步至观测云。

使用本脚本包，需要配置所关注的城市以及关注的生活指数，以及温度骤降指数，同时为了实现钉钉通知功能，需要您配置钉钉机器人的Webhook和加签密钥，其中加签密钥是可选的，您可以在钉钉「智能群助手」-「添加机器人」中进行配置。

*注意：配置关注的生活指数必须使用完整的生活指数名称，所有生活指数详见附录*

*注意：温度骤降指数即当近期温度相对今日降低对应温度及以上时，向用户发出温度骤降提醒*

*注意：为了避免垃圾信息打扰，我们强烈推荐您使用加签密钥*

示例如下：

| 字段名                     | 类型    | 是否必须 | 说明                                                                                     |
| -------------------------- | ------- | -------- | ---------------------------------------------------------------------------------------- |
| key                        | String  | 必须     |                                                                                          |
| focus_city_list            | List    | 必须     | 关注的城市列表，如['宁波','武汉','怀化']                                                 |
| focus_life_index           | List    |          | 关注的生活指数列表，如['空调','舒适度','带伞']                                           |
| temp_sudden_drop_threshold | Integer |          | 当温度降低超过该阈值时，发出温度骤降预警                                                 |
| dingtalk_secret            | String  |          | 钉钉加签密钥，如:`"SECf135eaba81d4f3442a56cfdde4e23f10cdb49fe1ee5e612b56a8ecaf13d6238b"` |
| dingtalk_webhook           | String  | 必须     | 钉钉通知api:，如`https://oapi.dingtalk.com/robot/send?access_token=<token>`              |
| datakit_id                 | String  |          | DataKit数据源ID                                                                          |
| measurement                | String  |          | 指标集名称，如天气信息                                                                   |

## 3. 典型代码示例

通过简单的配置和极少量代码，即可实现天气信息的同步功能。

以下典型代码示例为实现天气信息同步功能的最简单配置。

### 3.1 功能配置

```python
CONFIG = {
    'key'                       : '<key>',
    'datakit_id'                : 'datakit',
    'measurement'               : 'wt_01', # 写入指标集名称
    'dingtalk_webhook'          : 'https://oapi.dingtalk.com/robot/send?access_token=<token>',
    'dingtalk_secret'           : '<secret>',
    'focus_city'                : ['宁波','武汉','怀化'],  # 查询天气的城市名称，如：北京、苏州、上海
    'TEMP_SUDDEN_DROP_THRESHOLD': 4 #温度降低超过此数字视为气温骤降
    'focus_life_index'          : ['空调','舒适度','带伞'],# 查询的生活指数信息，如：空调、带伞
}
```

### 3.2 天气信息播报

```python
weather.config(**CONFIG)

@DFF.API('天气预报')
def weather_notice():
    return weather.weather_notice()

@DFF.API('温度骤降通知')
def temp_sudden_drop_notice():
    return weather.temp_sudden_drop_notice()

@DFF.API('生活指数通知')
def life_index_notice():
    return weather.life_index_notice()
```

### 3.3 天气数据存储

```python
@DFF.API('天气数据存储')
def save_weather_data():
    return weather.save_weather_data()
```

## 4. 创建自动触发配置

在完成代码编写后，发布脚本即可使用本脚本的全部功能。

之后在「管理」-「自动触发配置」中，可以为编写的脚本创建自动触发配置选项。

## X. 附录

本脚本中所涉及的相关配置项目，根据本附录查询。

### X.1 生活指数列表

| 生活指数 |      |        |
| -------- | ---- | ------ |
| 空调     | 过敏 | 舒适度 |
| 穿衣     | 钓鱼 | 感冒   |
| 紫外线   | 洗车 | 运动   |
| 带伞     |      |        |

### X.2 钉钉机器人配置说明

更多详细信息请参考钉钉机器人官方文档：

[自定义机器人接入](https://developers.dingtalk.com/document/robots/custom-robot-access?spm=ding_open_doc.document.0.0.7f875e59w0VKrH#topic-2026027)

如上述钉钉官方文档地址发生改变，可尝试使用以下关键字搜索此文档：

```
自定义机器人接入 site:developers.dingtalk.com
```

[通过百度搜索](https://www.baidu.com/s?wd=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%9C%BA%E5%99%A8%E4%BA%BA%E6%8E%A5%E5%85%A5%20site:developers.dingtalk.com)

[通过必应搜索](https://cn.bing.com/search?q=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%9C%BA%E5%99%A8%E4%BA%BA%E6%8E%A5%E5%85%A5%20site:developers.dingtalk.com)