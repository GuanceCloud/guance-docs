---
title     : 'iLogtail'
summary   : 'iLogtail 采集日志信息'
__int_icon: 'icon/ilogtail'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `iLogtail`
<!-- markdownlint-enable -->

## 安装配置 {#config}

### DataKit 开启采集器

```shell
cd /usr/local/datakit/conf.d/log
cp logstreaming.conf.sample logstreaming.conf
sysemctl restart datakit
```


### `iLogtail` 配置

#### 下载 `iLogtail`

```shell
wget https://ilogtail-community-edition.oss-cn-shanghai.aliyuncs.com/latest/ilogtail-latest.linux-amd64.tar.gz
```

#### 创建配置文件
解压后在 `ilogtail-1.7.1/user_yaml_config.d` 目录创建文件 `file_sample.yaml`。

这里配置采集 `/usr/local/df-demo/log-demo/logs/log.log` 文件日志。

```yaml
enable: true
inputs:
  - Type: file_log              
    LogPath: /usr/local/df-demo/log-demo/logs    # 文件路径
    FilePattern: log.log     # 文件名   
flushers:
  - Type: flusher_stdout     
    OnlyStdout: true
  - Type: flusher_http
    RemoteURL: "http://localhost:9529/v1/write/logstreaming" 
```

#### 启动 `iLogtail`

```shell
cd ilogtail-1.7.1
./ilogtail
```

手动输入日志

```shell
echo "hello" >>  /usr/local/df-demo/log-demo/logs/log.log
```

此时<<< custom_key.brand_name >>>已经收到 `iLogtail` 推送的日志。

#### `pipeline` 配置

本次使用的日志是 `JAVA` 应用生成的日志文件`/usr/local/df-demo/log-demo/logs/log.log`，日志格式不同，下图中 content 的值会存在差异，`pipeline` 也要做相应改变。

`Java` 中 `logback.xml` 输出日志的格式如下，输出内容对应上图中的 content 的值。

```txt
%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] - [%X{dd.service}][%X{dd.trace_id}][%X{dd.span_id}] - %msg%n
```

下面编写 `Pipeline` 对完整的日志内容进行切割，主要把 `host`、`host_ip`、`trace_id` 等信息从日志中提取出来。

【`日志`】->【`文本处理(Pipeline)`】-> 新建 `Pipeline`。日志来源输入“default”，输入解析规则然后保存。

```python
json_data = load_json(_)
contents = json_data["contents"]
tags = json_data["tags"]
content = contents["content"]
grok(content, "%{TIMESTAMP_ISO8601:time}%{SPACE}\\[%{NOTSPACE:thread_name}\\]%{SPACE}%{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name}%{SPACE}%{SPACE}-%{SPACE}\\[%{NOTSPACE:method_name},%{NUMBER:line}\\]%{SPACE}-%{SPACE}\\[%{DATA:service_name}\\]\\[%{DATA:trace_id}\\]\\[%{DATA:span_id}\\]%{SPACE}-%{SPACE}%{GREEDYDATA:msg}")
add_key(message, content)
add_key(host_ip, tags["host.ip"])
add_key(host, tags["host.name"])
add_key(filepath, tags["log.file.path"])

```

启动`JAVA`应用生成日志，会自动触发 `iLogtail`日志采集。

进入<<< custom_key.brand_name >>>，可以看到日志已经收集，`pipeline`也正常生效。
