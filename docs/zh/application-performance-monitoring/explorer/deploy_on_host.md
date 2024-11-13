# 在主机上部署
---

## 安装 DataKit 采集器

进行系统和应用程序的链路数据分析之前，需要在每个目标主机上[部署观测云 DataKit 采集器](../../datakit/datakit-install.md)，以收集必要的链路数据。

### 选择语言

#### Java

安装依赖：

```
wget -O dd-java-agent.jar 'https://static.guance.com/dd-image/dd-java-agent.jar'
```

运行应用：

可以通过多种途径运行你的 Java Code，如 IDE，Maven，Gradle 或直接通过 `java -jar` 命令，以下通过 `java` 命令启动应用：

```
java \ 
    -javaagent:/path/to/dd-java-agent.jar \ 
    -Ddd.logs.injection=true \ 
    -Ddd.agent.host=<YOUR-DATAKIT-HOST> \ 
    -Ddd.trace.agent.port=9529 \ 
    -jar path/to/your/app.jar
```

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
5. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息；
6. 开启 JVM 指标采集：需要同步开启 [statsd 采集器](../../integrations/statsd.md)。

> 更多参数配置，参考 [这里](../../integrations/ddtrace-java.md#start-options)。

#### Python

安装依赖：

```
pip install ddtrace
```

运行应用：

可以通过多种途径运行你的 Java Code，如 IDE，Maven，Gradle 或直接通过 `java -jar` 命令，以下通过 `java` 命令启动应用：

```
DD_LOGS_INJECTION=true \ 
DD_AGENT_HOST=localhost \ 
DD_AGENT_PORT=9529 \ 
ddtrace-run python my_app.py
```

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
5. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息；
6. 开启 Python 指标采集：需要同步开启 [statsd 采集器](../../integrations/statsd.md)。

> 更多参数配置，参考 [这里](../../integrations/ddtrace-java.md#start-options)。

#### Golang

安装依赖：

```
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

运行应用：

可以通过多种途径运行你的 Java Code，如 IDE，Maven，Gradle 或直接通过 `java -jar` 命令，以下通过 `java` 命令启动应用：

```
package main 

import ( 
   "io/ioutil" 
   "os" 
   "time" 
   httptrace "gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http" 
   "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer" 
) 

func main() { 
  tracer.Start( 
  ) 
  defer tracer.Stop() 
  // Create a traced mux router
  mux := httptrace.NewServeMux()
  // Continue using the router as you normally would.
  mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    time.Sleep(time.Second)
    w.Write([]byte("Hello World!"))
  })
  if err := http.ListenAndServe(":18080", mux); err != nil {
    log.Fatal(err)
  }
}
```

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
5. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息。

> 更多参数配置，参考 [这里](../../integrations/ddtrace-java.md#start-options)。

#### Node.JS

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 请参考</font>](../../integrations/ddtrace-nodejs.md)

</div>

</font>

#### C++

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 请参考</font>](../../integrations/ddtrace-cpp.md)

</div>

</font>

#### PHP

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 请参考</font>](../../integrations/ddtrace-php.md)

</div>

</font>

