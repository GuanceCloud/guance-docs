# DataKit 作为本地获取数据的 API 服务器
---

# 概述
当用户同时需要采集大量不同技术栈的指标、日志或者链路数据时或者希望在其他平台或应用中使用 DataKit 所采集并上报的数据时，Datakit 为用户提供了命令行交互模式的快速数据查询的“DQL查询”又提供了以 API 的形式去使用 DataKit 所收集到的数据的 “DataKit API”。

本指南为您介绍 DataKit 所提供的 “DQL查询”和 "DataKit API" 的使用。

# 前置条件
您需要先创建一个 [观测云账号](https://www.guance.com)，并在您的主机上 [安装 DataKit](../../datakit/datakit-install.md) 。
# 交互模型数据查询 “DQL查询”
DataKit 支持以交互式方式执行 DQL 查询，在交互模式下，DataKit 自带语句补全功能：
```shell
datakit --dql     # 或者 datakit -Q
dql > cpu limit 1
-----------------[1.cpu ]-----------------
            cpu 'cpu-total'
           host'tan-air.local'
           time2022-01-13 16:06:03 +0800 CST
      usage_irq 0
      usage_idle 56.928839
      usage_nice 0
      usage_user 19.825218
    usage_guest 0
    usage_steal 0
    usage_total 43.071161
    usage_iowait 0
    usage_system 23.245943
  usage_softirq 0
usage_guest_nice 0
---------
1 rows, cost 13.55119ms
```
## 单次执行 DQL 查询
DataKit 支持运行单条 DQL 语句的查询功能：
```shell
# 单次执行一条查询语句
datakit --run-dql 'cpu limit 1'


# 将执行结果写入 CSV 文件
datakit --run-dql 'O::HOST:(os, message)' --csv="path/to/your.csv"


# 强制覆盖已有 CSV 文件
datakit --run-dql 'O::HOST:(os, message)' --csv /path/to/xxx.csv --force


# 将结果写入 CSV 的同时，在终端也显示查询结果
datakit --run-dql 'O::HOST:(os, message)' --csv="path/to/your.csv" --vvv
```
导出的 CSV 文件样式示例：
```shell
name,active,available,available_percent,free,host,time
mem,2016870400,2079637504,24.210166931152344,80498688,achen.local,1635242524385
mem,2007961600,2032476160,23.661136627197266,30900224,achen.local,1635242534385
mem,2014437376,2077097984,24.18060302734375,73502720,achen.local,1635242544382
```
## DQL查询结果JSON化
DQL的查询结果可以直接以 JSON 形式输出结果，但 JSON 模式下，不会输出一些统计信息，如返回行数、时间消耗等（以保证 JSON 可直接解析）
```shell
datakit --run-dql 'O::HOST:(os, message)' --json
datakit -Q --json


# 如果字段值是 JSON 字符串，则自动做 JSON 美化（注意：JSON 模式下（即 --json），`--auto-json` 选项无效）
datakit --run-dql 'O::HOST:(os, message)' --auto-json
-----------------[ r1.HOST.s1 ]-----------------
message ----- json -----  # JSON 开始处有明显标志，此处 message 为字段名
{
  "host":{
   "meta":{
     "host_name":"www",
  ....                   # 此处省略长文本
  "config":{
   "ip":"10.100.64.120",
   "enable_dca": false,
   "http_listen":"localhost:9529",
   "api_token":"tkn_f2b9920f05d84d6bb5b14d9d39db1dd3"
  }
}
----- end of json -----   # JSON 结束处有明显标志
    os 'darwin'
   time2022-01-13 16:56:22 +0800 CST
---------
8 rows, 1 series, cost 4ms
```

## 查询特定工作空间的数据
DQL查询可以通过指定不同的 Token 来查询其它工作空间的数据：
```shell
datakit --run-dql 'O::HOST:(os, message)' --token <your-token>
datakit -Q --token <your-token>
```
# DataKit API
DataKit 以 JSON 数据类型为返回结果的，Http API 的数据提供能力，目前支持的 API 包括
## 写入数据
`http://{DatakitIP}/v1/write/:category `
category支持：日志数据、指标数据、对象数据、自定义对象数据、RUM数据等
## 检测 Datakit 运行
`http://{DatakitIP}/v1/ping`
## 查看采集器错误
`http://{DatakitIP}/v1/lasterror `
## 查看工作空间信息
`http://{DatakitIP}/v1/workspace`
## 数据查询
`http://{DatakitIP}/v1/query/raw `
## 创建或更新对象的 labels 
`http://{DatakitIP}/v1/object/labels  |  POST `
## 删除对象的 labels 
`http://{DatakitIP}/v1/object/labels  | DELETE`


