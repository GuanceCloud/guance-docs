
# Profile 采集配置
---

- DataKit 版本：1.4.3
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Profile 支持采集使用 Java / Python 等不同语言环境下应用程序运行过程中的动态性能数据，帮助用户查看 CPU、内存、IO 的性能问题。

## 配置说明 {#config}

进入 DataKit 安装目录下的 `conf.d/profile` 目录，复制 `profile.conf.sample` 并命名为  `profile.conf` 。配置文件说明如下：

```shell
# {"version": "1.4.3", "desc": "do NOT edit this line"}

[[inputs.profile]]
## profile Agent endpoints register by version respectively.
## Endpoints can be skipped listen by remove them from the list.
## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
endpoints = ["/profiling/v1/input"]
```

配置完成后，重启 DataKit 。

```shell
sudo datakit service --restart
```

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.profile.tags]` 指定其它标签：

``` toml
 [inputs.profile.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `profile`



-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`container_host`|container hostname|
|`endpoint`|endpoint info|
|`env`|application environment info|
|`http_method`|http request method name|
|`http_status_code`|http response code|
|`operation`|span name|
|`project`|project name|
|`service`|service name|
|`source_type`|tracing source type|
|`span_type`|span type|
|`status`|span status|
|`version`|application version info|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`duration`|duration of span|int|μs|
|`message`|origin content of span|string|-|
|`parent_id`|parent span ID of current span|string|-|
|`pid`|application process id.|string|-|
|`priority`||int|-|
|`resource`|resource name produce current span|string|-|
|`span_id`|span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|trace id|string|-|



## 安装运行 Profiling Agent {#install}

目前支持 java 和 python 语言使用相应语言的profiling 库。

### Java {#java}

下载最新的 ddtrace agent dd-java-agent.jar

```shell
# java版本要求：java8版本需要高于8u262+，或者使用java11及以上版本
wget -O dd-java-agent.jar 'https://dtdg.co/latest-java-tracer'
```

运行 Java Code

```shell
java -javaagent:/<your-path>/dd-java-agent.jar \
-Ddd.service=profiling-demo \
-Ddd.env=dev \
-Ddd.version=1.2.3  \
-Ddd.profiling.enabled=true  \
-XX:FlightRecorderOptions=stackdepth=256 \
-Ddd.trace.agent.port=9529 \
-jar your-app.jar 
```

### Python {#python}

安装 DDTrace Python 函数库

```shell
pip install ddtrace
```

- 自动profiling

```shell
DD_PROFILING_ENABLED=true \
DD_ENV=dev \
DD_SERVICE=my-web-app \
DD_VERSION=1.0.3 \
DD_TRACE_AGENT_URL=http://127.0.0.1:9529 \
ddtrace-run python app.py
```

- 通过代码的方式开启profiling

```python
import time
import ddtrace
from ddtrace.profiling import Profiler

ddtrace.tracer.configure(
    https=False,
    hostname="localhost",
    port="9529",
)

prof = Profiler()
prof.start(True, True)


# your code here ...
#while True:
#    time.sleep(1)

```

此时运行则不需要再用 ddtrace-run 命令

```shell
DD_ENV=testing DD_SERVICE=python-profiling-manual DD_VERSION=7.8.9 python3 app.py
```

## 查看 Profile

上述程序启动后，会定期（默认 1 分钟上报一次）收集 profiling 数据并上报给 DataKit，稍等片刻后就可以在观测云工作空间看到 profiling 数据。
