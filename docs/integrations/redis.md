
# Redis
---

操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64

## 视图预览

### 场景视图

Redis 观测场景主要展示了 Redis 的错误信息，性能信息，持久化信息等。

![image](imgs/input-redis-1.png)

## 安装部署

Redis 指标采集器，采集以下数据：

- 开启 AOF 数据持久化，会收集相关指标
- RDB 数据持久化指标
- Slowlog 监控指标
- bigkey scan 监控
- 主从replication

说明：示例 Redis 版本为：Redis 6.2.3 (CentOS)，各个不同版本指标可能存在差异

### 前置条件

- Redis 版本 v5.0+

在采集主从架构下数据时，请配置从节点的主机信息进行数据采集，可以得到主从相关的指标信息。

### 配置实施

#### 指标采集 (必选)

1、 开启 DataKit Redis 插件，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/db/
cp redis.conf.sample redis.conf
```

2、 修改 `redis.conf` 配置文件

```bash
vi redis.conf
```
参数说明

- host：要采集的redis 的地址
- port：要采集的redis 的端口
- db：要采集的redis 的数据库
- password：要采集的redis 的密码
- connect_timeout：链接超时时间
- service：配置服务名称
- interval：采集指标频率
- keys：要采集的 key 可以多选
- slow_log：开启慢日志
- slowlog-max-len：配置慢日志大小
- command_stats：获取 info 命令的结果转换成指标

```yaml
[[inputs.redis]]
    host = "localhost"
    port = 6379
    # unix_socket_path = "/var/run/redis/redis.sock"
    db = 0
    # password = "<PASSWORD>"

    ## @param connect_timeout - number - optional - default: 10s
    # connect_timeout = "10s"

    ## @param service - string - optional
    # service = "<SERVICE>"

    ## @param interval - number - optional - default: 15
    interval = "15s"

    ## @param keys - list of strings - optional
    ## The length is 1 for strings.
    ## The length is zero for keys that have a type other than list, set, hash, or sorted set.
    #
    # keys = ["KEY_1", "KEY_PATTERN"]

    ## @param warn_on_missing_keys - boolean - optional - default: true
    ## If you provide a list of 'keys', set this to true to have the Agent log a warning
    ## when keys are missing.
    #
    # warn_on_missing_keys = true

    ## @param slow_log - boolean - optional - default: false
    slow_log = true

    ## @param slowlog-max-len - integer - optional - default: 128
    slowlog-max-len = 128

    ## @param command_stats - boolean - optional - default: false
    ## Collect INFO COMMANDSTATS output as metrics.
    # command_stats = false

```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、 Redis 指标采集验证 `/usr/local/datakit/datakit -M |egrep "最近采集|redis"`

![image](imgs/input-redis-2.png)

5、 指标预览

![image](imgs/input-redis-3.png)

#### 日志采集 (非必选)

1、 修改 `redis.conf` 配置文件

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- ignore：要过滤的文件名
- pipeline：日志切割文件(内置)，实际文件路径 /usr/local/datakit/pipeline/redis.p
- character_encoding：日志编码格式
- match：开启多行日志收集
- 相关文档 <[DataFlux pipeline 文本数据处理](../datakit/pipeline.md)>

```
[inputs.redis.log]
    ## required, glob logfiles
    #files = ["/var/log/redis/*.log"]

    ## glob filteer
    #ignore = [""]

    ## grok pipeline script path
    #pipeline = "redis.p"

    ## optional encodings:
    ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
    #character_encoding = ""

    ## The pattern should be a regexp. Note the use of '''this regexp'''
    ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
		#match = '''^\S.*'''
```

2、 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

3、 Redis 日志采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|redis_log"

![image](imgs/input-redis-4.png)

4、 日志预览

![image](imgs/input-redis-5.png)

5、 日志 pipeline 功能切割字段说明
- Redis 通用日志切割
原始日志为

```
122:M 14 May 2019 19:11:40.164 * Background saving terminated with success
```

切割后的字段列表如下：

| 字段名 | 字段值 | 说明 |
| --- | --- | --- |
| `pid` | `122` | 进程id |
| `role` | `M` | 角色 |
| `serverity` | `*` | 服务 |
| `statu` | `notice` | 日志级别 |
| `msg` | `Background saving terminated with success` | 日志内容 |
| `time` | `1557861100164000000` | 纳秒时间戳（作为行协议时间） |

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Redis 指标都会带有 service = "redis" 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/insight/tag.md)>

```
# 示例
[inputs.redis.tags]
		service = "redis"
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

重启 Datakit

```
systemctl restart datakit
```
## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Redis 监控视图>

## 检测库

<监控 - 监控器 - 从模板新建 - Redis 检测库>

| 序号 | 规则名称 | 触发条件 | 级别 | 检测频率 |
| --- | --- | --- | --- | --- |
| 1 | Redis 等待阻塞命令的客户端连接数异常增加 | 客户端连接数 > 0 | 紧急 | 1m |

## [指标详解](../datakit/redis#metric)


## 最佳实践

[<Redis 可观测最佳实践>](../best-practices/monitoring/redis)

## 故障排查

<[无数据上报排查](../datakit/why-no-data.md)>

