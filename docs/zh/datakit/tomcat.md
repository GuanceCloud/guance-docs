
# Tomcat
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

采集 tomcat 指标

## 前置条件 {#requrements}

- 下载 [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war){:target="_blank"}，重命名为 `jolokia.war`，并放置于 tomcat 的 webapps 目录下。也可从 DataKit 的安装目录下的 data 目录下获取 jolokia.war 包。
- 编辑 tomcat 的 conf 目录下的 `tomcat-users.xml`，增加 role 为 jolokia 的用户。

    以 `apache-tomcat-9.0.45` 为例：

    > **注意：**示例中 jolokia user 的 username 和 password 请务必修改！

    ```ssh
    $ cd apache-tomcat-9.0.45/

    $ export tomcat_dir=`pwd`

    $ wget https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war \
    -O $tomcat_dir/webapps/jolokia.war

    $ vim $tomcat_dir/conf/tomcat-users.xml

    37 <!--
    38   <role rolename="tomcat"/>
    39   <role rolename="role1"/>
    40   <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
    41   <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
    42   <user username="role1" password="<must-be-changed>" roles="role1"/>
    43 -->
    44   <role rolename="jolokia"/>
    45   <user username="jolokia_user" password="secPassWd@123" roles="jolokia"/>
    46
    47 </tomcat-users>


    $ $tomcat_dir/bin/startup.sh

    ...
    Tomcat started.
    ```

    前往 `http://localhost:8080/jolokia` 查看是否配置成功

## 配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/tomcat` 目录，复制 `tomcat.conf.sample` 并命名为 `tomcat.conf`。示例如下：
    
    ```toml
        
    [[inputs.tomcat]]
      ### Tomcat user(rolename="jolokia"). For example:
      # username = "jolokia_user"
      # password = "secPassWd@123"
    
      # response_timeout = "5s"
    
      urls = ["http://localhost:8080/jolokia"]
    
      ### Optional TLS config
      # tls_ca = "/var/private/ca.pem"
      # tls_cert = "/var/private/client.pem"
      # tls_key = "/var/private/client-key.pem"
      # insecure_skip_verify = false
    
      ### Monitor Interval
      # interval = "15s"
    
      # [inputs.tomcat.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "tomcat.p"
    
      [inputs.tomcat.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
      ### Tomcat metrics
      [[inputs.tomcat.metric]]
        name     = "tomcat_global_request_processor"
        mbean    = '''Catalina:name="*",type=GlobalRequestProcessor'''
        paths    = ["requestCount","bytesReceived","bytesSent","processingTime","errorCount"]
        tag_keys = ["name"]
    
      [[inputs.tomcat.metric]]
        name     = "tomcat_jsp_monitor"
        mbean    = "Catalina:J2EEApplication=*,J2EEServer=*,WebModule=*,name=jsp,type=JspMonitor"
        paths    = ["jspReloadCount","jspCount","jspUnloadCount"]
        tag_keys = ["J2EEApplication","J2EEServer","WebModule"]
    
      [[inputs.tomcat.metric]]
        name     = "tomcat_thread_pool"
        mbean    = "Catalina:name=\"*\",type=ThreadPool"
        paths    = ["maxThreads","currentThreadCount","currentThreadsBusy"]
        tag_keys = ["name"]
    
      [[inputs.tomcat.metric]]
        name     = "tomcat_servlet"
        mbean    = "Catalina:J2EEApplication=*,J2EEServer=*,WebModule=*,j2eeType=Servlet,name=*"
        paths    = ["processingTime","errorCount","requestCount"]
        tag_keys = ["name","J2EEApplication","J2EEServer","WebModule"]
    
      [[inputs.tomcat.metric]]
        name     = "tomcat_cache"
        mbean    = "Catalina:context=*,host=*,name=Cache,type=WebResourceRoot"
        paths    = ["hitCount","lookupCount"]
        tag_keys = ["context","host"]
        tag_prefix = "tomcat_"
    ```

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.tomcat.tags]` 指定其它标签：

``` toml
 [inputs.tomcat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `tomcat_global_request_processor`

-  标签


| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Protocol handler name.|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytesReceived`|Amount of data received, in bytes.|int|count|
|`bytesSent`|Amount of data sent, in bytes.|int|count|
|`errorCount`|Number of errors.|int|count|
|`processingTime`|Total time to process the requests.|int|-|
|`requestCount`|Number of requests processed.|int|count|



### `tomcat_jsp_monitor`

-  标签


| Tag | Descrition |
|  ----  | --------|
|`J2EEApplication`|J2EE Application.|
|`J2EEServer`|J2EE Servers.|
|`WebModule`|Web Module.|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`jspCount`|The number of JSPs that have been loaded into a webapp.|int|count|
|`jspReloadCount`|The number of JSPs that have been reloaded.|int|count|
|`jspUnloadCount`|The number of JSPs that have been unloaded.|int|count|



### `tomcat_thread_pool`

-  标签


| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Protocol handler name.|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`currentThreadCount`|CurrentThreadCount.|int|count|
|`currentThreadsBusy`|CurrentThreadsBusy.|int|count|
|`maxThreads`|MaxThreads.|int|count|



### `tomcat_servlet`

-  标签


| Tag | Descrition |
|  ----  | --------|
|`J2EEApplication`|J2EE Application.|
|`J2EEServer`|J2EE Server.|
|`WebModule`|Web Module.|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Name|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`errorCount`|Error count.|int|count|
|`processingTime`|Total execution time of the servlet's service method.|int|-|
|`requestCount`|Number of requests processed by this wrapper.|int|count|



### `tomcat_cache`

-  标签


| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`tomcat_context`|Tomcat context.|
|`tomcat_host`|Tomcat host.|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hitCount`|The number of requests for resources that were served from the cache.|int|count|
|`lookupCount`|The number of requests for resources.|int|count|



## 日志采集 {#logging}

???+ attention

    日志采集仅支持采集已安装 DataKit 主机上的日志

如需采集 Tomcat 的日志，可在 tomcat.conf 中 将 `files` 打开，并写入 Tomcat 日志文件的绝对路径。比如：

``` toml
  [inputs.tomcat.log]
    files = ["/path_to_tomcat/logs/*"]
```

开启日志采集以后，默认会产生日志来源（`source`）为 `tomcat` 的日志。

**字段说明**

* Access Log

日志示例：

```
0:0:0:0:0:0:0:1 - admin [24/Feb/2015:15:57:10 +0530] "GET /manager/images/tomcat.gif HTTP/1.1" 200 2066
```

切割后的字段列表如下：

| 字段名       | 字段值                     | 说明                           |
| ---          | ---                        | ---                            |
| time         | 1424773630000000000        | 日志产生的时间                 |
| status       | OK                         | 日志等级                       |
| client_ip    | 0:0:0:0:0:0:0:1            | 客户端 ip                      |
| http_auth    | admin                      | 通过 HTTP Basic 认证的授权用户 |
| http_method  | GET                        | HTTP 方法                      |
| http_url     | /manager/images/tomcat.gif | 客户端请求地址                 |
| http_version | 1.1                        | HTTP 协议版本                  |
| status_code  | 200                        | HTTP 状态码                    |
| bytes        | 2066                       | HTTP 响应 body 的字节数        |

* Cataline / Host-manager / Localhost / Manager Log

日志示例：

```
06-Sep-2021 22:33:30.513 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
```

切割后的字段列表如下：

| 字段名        | 字段值                                                | 说明                 |
| ---           | ---                                                   | ---                  |
| time          | 1630938810513000000                                   | 日志产生的时间       |
| status        | INFO                                                  | 日志等级             |
| thread_name   | main                                                  | 线程名               |
| report_source | org.apache.catalina.startup.VersionLoggerListener.log | ClassName.MethodName |
| msg           | Command line argument: -Xmx256m                       | 消息                 |
