# NBA赛事信息
---


本文档主要介绍如何使用脚本市场中的「NBA赛事信息」脚本包获取NBA球队最新的赛事信息。

> 提示：请始终使用最新版DataFlux Func 进行操作。

> 提示2: 本脚本包会不断加入新功能，请随时关注本文档页。

## 1. 背景

NBA赛季一般从每年10月持续到次年6月，总共有1230场比赛，大部分篮球爱好者无法每场比赛都观看。

因此，DataFlux Func 提供NBA赛事信息脚本。用户可以从脚本市场安装相关的数据同步脚本包，进行简单的配置后，即可查看每天的NBA赛事信息。

本文假设用户已经了解并安装了相关脚本包。
有关如何在DataFlux Func 的脚本市场中安装脚本版，请参考：

- [脚本市场简介](https://docs.guance.com/dataflux-func/script-market-intro)

本文假设用户已经在DataFlux Func 中正确连接了DataKit。
有关如何在DataFlux Func 中连接DataKit，请参考：

- [连接并操作DataKit](https://docs.guance.com/dataflux-func/connect-to-datakit)

本脚本包基于「[聚合数据](https://www.juhe.cn/)」提供的API实现，
用户在使用本脚本包时，请先登录注册「聚合数据」，并获取Key后使用。

## 2. 关于本脚本包

本脚本包主要用于NBA赛事信息的获取并同步至观测云。

使用本脚本包，需要配置所关注的球队，同时为了实现钉钉通知功能，需要您配置钉钉机器人的Webhook和加签密钥，其中加签密钥是可选的，您可以在钉钉「智能群助手」-「添加机器人」中进行配置。

*注意：配置关注球队必须使用球队完整队名，使用简称，如「湖人」、「勇士」无法获得其相关赛事信息，所有球队的完整队名详见附录*

*注意：为了避免垃圾信息打扰，我们强烈推荐您使用加签密钥*

示例如下：

| 字段名           | 类型   | 是否必须 | 说明                                                                                     |
| ---------------- | ------ | -------- | ---------------------------------------------------------------------------------------- |
| key              | String | 必须     | 聚合数据API调用Key                                                                       |
| focus_team_list  | List   | 必须     | 关注球队列表，如:`['金州勇士','洛杉矶湖人','布鲁克林篮网']`                              |
| datakit_id       | String | 必须     | DataKit数据源ID                                                                          |
| measurement      | String |          | 指定写入的指标集名称，默认：`"NBA排名"`                                                  |
| dingtalk_webhook | String | 必须     | 钉钉通知API，如`https://oapi.dingtalk.com/robot/send?access_token=<token>`               |
| dingtalk_secret  | String |          | 钉钉加签密钥，如:`"SECf135eaba81d4f3442a56cfdde4e23f10cdb49fe1ee5e612b56a8ecaf13d6238b"` |

## 3. 典型代码示例

通过简单的配置和极少量代码，即可实现NBA赛事信息的同步功能。

以下典型代码示例为实现NBA赛事信息同步功能的最简单配置。

### 3.1 功能配置

```python
CONFIG = {
    'key'             : '<key>',
    'datakit_id'      : 'datakit',
    'measurement'     : 'NBA排名',
    'dingtalk_webhook': 'https://oapi.dingtalk.com/robot/send?access_token=<token>',
    'dingtalk_secret' : '<secret>',
    'focus_team'      : ['金州勇士','洛杉矶湖人','布鲁克林篮网']
}
```

### 3.2 赛事信息播报

```python
nba.config(**CONFIG)

@DFF.API('NBA赛前提醒'):
def nba_before_notice():
    return nba.before_game_notice()

@DFF.API('NBA赛后播报')
def nba_after_notice():
    return nba.after_game_notice()

@DFF.API('NBA排名播报')
def nba_rank_data():
    return nba.rank_data_notice()
```

### 3.3 NBA数据存储

```python
@DFF.API('NBA数据存储')
def nba_data_save():
    return nba.save_nba_rank_data()
```

### 3.4 NBA胜率预测

```python
@DFF.API('NBA胜率预测')
def nba_win_rate():
    return nba.win_rate_forecast()
```

*注意：胜率预测功能结合球队进攻、防守效率和综合胜率进行加权预测，同时考虑主客场和背靠背的情况，相关结果仅供参考。由于目前接口数据存在问题，进攻效率和防守效率字段返回为空，暂不建议使用该功能*

## 4. 创建自动触发配置

在完成代码编写后，发布脚本即可使用本脚本的全部功能。

之后在「管理」-「自动触发配置」中，可以为编写的脚本创建自动触发配置选项。

*注意：接口更新数据存在延迟，获取当天的比赛、排名信息建议设置自动触发配置的时间在当天14：00之后*

## X. 附录

本脚本中所涉及的相关配置项目，根据本附录查询。

### X.1 NBA球队完整队名列表

| 东部联盟                                             |                                                          |                                                          |
| ---------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- |
| 东南分区                                             | 大西洋分区                                               | 中央分区                                                 |
| [亚特兰大老鹰](https://china.nba.com/teams/#!/hawks) | [波士顿凯尔特人](https://china.nba.com/teams/#!/celtics) | [芝加哥公牛](https://china.nba.com/teams/#!/bulls)       |
| [夏洛特黄蜂](https://china.nba.com/teams/#!/hornets) | [布鲁克林篮网](https://china.nba.com/teams/#!/nets)      | [克利夫兰骑士](https://china.nba.com/teams/#!/cavaliers) |
| [迈阿密热火](https://china.nba.com/teams/#!/heat)    | [纽约尼克斯](https://china.nba.com/teams/#!/knicks)      | [底特律活塞](https://china.nba.com/teams/#!/pistons)     |
| [奥兰多魔术](https://china.nba.com/teams/#!/magic)   | [费城76人](https://china.nba.com/teams/#!/sixers)        | [印第安纳步行者](https://china.nba.com/teams/#!/pacers)  |
| [华盛顿奇才](https://china.nba.com/teams/#!/wizards) | [多伦多猛龙](https://china.nba.com/teams/#!/raptors)     | [密尔沃基雄鹿](https://china.nba.com/teams/#!/bucks)     |

| 西部联盟                                                 |                                                               |                                                        |
| -------------------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------ |
| 西南分区                                                 | 西北分区                                                      | 太平洋分区                                             |
| [达拉斯独行侠](https://china.nba.com/teams/#!/mavericks) | [丹佛掘金](https://china.nba.com/teams/#!/nuggets)            | [金州勇士](https://china.nba.com/teams/#!/warriors)    |
| [休斯顿火箭](https://china.nba.com/teams/#!/rockets)     | [明尼苏达森林狼](https://china.nba.com/teams/#!/timberwolves) | [洛杉矶快船](https://china.nba.com/teams/#!/clippers)  |
| [孟菲斯灰熊](https://china.nba.com/teams/#!/grizzlies)   | [俄克拉荷马城雷霆](https://china.nba.com/teams/#!/thunder)    | [洛杉矶湖人](https://china.nba.com/teams/#!/lakers)    |
| [新奥尔良鹈鹕](https://china.nba.com/teams/#!/pelicans)  | [波特兰开拓者](https://china.nba.com/teams/#!/blazers)        | [菲尼克斯太阳](https://china.nba.com/teams/#!/suns)    |
| [圣安东尼奥马刺](https://china.nba.com/teams/#!/spurs)   | [犹他爵士](https://china.nba.com/teams/#!/jazz)               | [萨克拉门托国王](https://china.nba.com/teams/#!/kings) |

### X.2 钉钉机器人配置说明

更多详细信息请参考钉钉机器人官方文档：

[自定义机器人接入](https://developers.dingtalk.com/document/robots/custom-robot-access?spm=ding_open_doc.document.0.0.7f875e59w0VKrH#topic-2026027)

如上述钉钉官方文档地址发生改变，可尝试使用以下关键字搜索此文档：

```
自定义机器人接入 site:developers.dingtalk.com
```

[通过百度搜索](https://www.baidu.com/s?wd=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%9C%BA%E5%99%A8%E4%BA%BA%E6%8E%A5%E5%85%A5%20site:developers.dingtalk.com)

[通过必应搜索](https://cn.bing.com/search?q=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%9C%BA%E5%99%A8%E4%BA%BA%E6%8E%A5%E5%85%A5%20site:developers.dingtalk.com)
