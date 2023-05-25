
# 如何排查无数据问题

---

大家在部署完数据采集之后（通过 DataKit 或 Function 采集），有时候在观测云的页面上看不到对应的数据更新，每次排查起来都心力憔悴，为了缓解这一状况，可按照如下的一些步骤，来逐步围歼「为啥没有数据」这一问题。

## 检查 DataWay 连接是否正常 {#check-connection}

```shell
curl http[s]://your-dataway-addr:port
```

对 SAAS 而言，一般这样：

```shell
curl https://openway.guance.com
```

如果得到如下结果，则表示网络是有问题的：

```shell
curl: (6) Could not resolve host: openway.guance.com
```

如果发现如下这样的错误日志，则说明跟 DataWay 的连接出现了一些问题，可能是防火墙做了限制：

```shell
request url https://openway.guance.com/v1/write/xxx/token=tkn_xxx failed:  ... context deadline exceeded...
```

## 检查机器时间 {#check-local-time}

在 Linux/Mac 上，输入 `date` 即可查看当前系统时间：

```shell
date
Wed Jul 21 16:22:32 CST 2021
```

有些情况下，这里可能显示成这样：

```shell
Wed Jul 21 08:22:32 UTC 2021
```

这是因为，前者是中国东八区时间，后者是格林威治时间，两者相差 8 小时，但实际上，这两个时间的时间戳是一样的。

如果当前系统的时间跟你的手机时间相差甚远，特别是，它如果超前了，那么观测云上是看不到这些「将来」的数据的。

另外，如果时间滞后，你会看到一些老数据，不要以为发生了灵异事件，事实上，极有可能是 DataKit 所在机器的时间还停留在过去。

## 查看数据是否被黑名单过滤或 Pipeline 丢弃 {#filter-pl}

如果配置了[黑名单](datakit-filter.md)（如日志黑名单），新采集的数据可能会被黑名单过滤掉。

同理，如果 Pipeline 中对数据进行了一些[丢弃操作](../developers/pipeline.md#fn-drop)，那么也可能导致中心看不到这些数据。

## 查看 Monitor 页面 {#monitor}

参见[这里](datakit-monitor.md)

## 通过 DQL 查看是否有数据产生 {#dql}

在 Windows/Linux/Mac 上，这一功能均支持，其中 Windows 需在 Powershell 中执行

> Datakit [1.1.7-rc7](changelog.md#cl-1.1.7-rc7) 才支持这一功能

```shell
datakit dql
> 这里即可输入 DQL 查询语句 ...
```

对于无数据排查，建议对照着采集器文档，看对应的指标集叫什么名字，以 MySQL 采集器为例，目前文档中有如下几个指标集：

- `mysql`
- `mysql_schema`
- `mysql_innodb`
- `mysql_table_schema`
- `mysql_user_status`

如果 MySQL 这个采集器没数据，可检查 `mysql` 这个指标集是否有数据：

``` python
#
# 查看 mysql 采集器上，指定主机上（这里是 tan-air.local）的最近一条 mysql 的指标
#
M::mysql {host='tan-air.local'} order by time desc limit 1
```

查看某个主机对象是不是上报了，这里的 `tan-air.local` 就是预期的主机名：

```python
O::HOST {host='tan-air.local'}
```

查看已有的 APM（tracing）数据分类：

```python
show_tracing_service()
```

以此类推，如果数据确实上报了，那么通过 DQL 总能找到，至于前端不显示，可能是其它过滤条件给挡掉了。通过 DQL，不管是 Datakit 采集的数据，还是其它手段（如 Function）采集的数据，都可以零距离查看原式数据，特别便于 Debug。

## 查看 Datakit 程序日志是否有异常 {#check-log}

通过 Shell/Powershell 给出最近 10 个 ERROR, WARN 级别的日志

```shell
# Shell
cat /var/log/datakit/log | grep "WARN\|ERROR" | tail -n 10

# Powershell
Select-String -Path 'C:\Program Files\datakit\log' -Pattern "ERROR", "WARN"  | Select-Object Line -Last 10
```

- 如果日志中发现诸如 `Beyond...` 这样的描述，一般情况下，是因为数据量超过了免费额度。
- 如果出现一些 `ERROR/WARN` 等字样，一般情况下，都表明 DataKit 遇到了一些问题。

### 查看单个采集器的运行日志 {#check-input-log}

如果没有发现什么异常，可直接查看单个采集器的运行日志：

```shell
# shell
tail -f /var/log/datakit/log | grep "<采集器名称>" | grep "WARN\|ERROR"

# powershell
Get-Content -Path "C:\Program Files\datakit\log" -Wait | Select-String "<采集器名称>" | Select-String "ERROR", "WARN"
```

也可以去掉 `ERROR/WARN` 等过滤，直接查看对应采集器日志。如果日志不够，可将 `datakit.conf` 中的调试日志打开，查看更多日志：

```toml
# DataKit >= 1.1.8-rc0
[logging]
    ...
    level = "debug" # 将默认的 info 改为 debug
    ...

# DataKit < 1.1.8-rc0
log_level = "debug"
```

### 查看 gin.log {#check-gin-log}

对于远程给 DataKit 打数据的采集，可查看 gin.log 来查看是否有远程数据发送过来：

```shell
tail -f /var/log/datakit/gin.log
```
