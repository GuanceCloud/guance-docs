---
title     : 'iLogtail'
summary   : 'iLogtail collects log information'
__int_icon: 'icon/ilogtail'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `iLogtail`
<!-- markdownlint-enable -->

## Installation Configuration{#config}

### DataKit Collector Configuration

```shell
cd /usr/local/datakit/conf.d/log
cp logstreaming.conf.sample logstreaming.conf
sysemctl restart datakit
```


### `iLogtail` Configuration

#### Download `iLogtail`

```shell
wget https://ilogtail-community-edition.oss-cn-shanghai.aliyuncs.com/latest/ilogtail-latest.linux-amd64.tar.gz
```

#### Creation configuration file

After decompression,  `ilogtail-1.7.1/user_yaml_config.d` directory creation file `file_sample.yaml`。

Configure the collection of `/usr/local/df-demo/log-demo/logs/log.log` file logs here。

```yaml
enable: true
inputs:
  - Type: file_log              
    LogPath: /usr/local/df-demo/log-demo/logs    # File path
    FilePattern: log.log     # File name   
flushers:
  - Type: flusher_stdout     
    OnlyStdout: true
  - Type: flusher_http
    RemoteURL: "http://localhost:9529/v1/write/logstreaming" 
```

#### Start `iLogtail`

```shell
cd ilogtail-1.7.1
./ilogtail
```

Manually entering logs

```shell
echo "hello" >>  /usr/local/df-demo/log-demo/logs/log.log
```

At this point, the Guance has received the logs pushed by `iLogtail`.

#### `pipeline` Configuration

The log used this time is the `JAVA` application generated log file `/usr/local/df-demo/log-demo/logs/log.log`, with different log formats. The content value in the following figure may vary, and the `pipeline` needs to be changed accordingly.

The format of the `logback.xml` output log in `Java` is as follows, and the output content corresponds to the content value in the figure above.

```txt
%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] - [%X{dd.service}][%X{dd.trace_id}][%X{dd.span_id}] - %msg%n
```

Next, write a `Pipeline` to cut the complete log content, mainly including  `host`、`host_ip`、`trace_id` Extract information from the log.


【`Logs`】->【`Pipeline`】-> Create `Pipeline`。Enter `default` as the log source, enter the parsing rules, and then save.

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

Starting the `JAVA` application to generate logs will automatically trigger the `iLogtail` log collection.

Entering the Guance Console, you can see that the logs have been collected and the `pipeline` is also taking effect normally.
