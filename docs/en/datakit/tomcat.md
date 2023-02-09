
# Tomcat
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Collect tomcat metrics

## Preconditions {#requrements}

Download [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war){:target="_blank"}, rename it to jolokia.war, and place it in tomcat's webapps directory. You can also get the jolokia war package from the data directory under the Datakit installation directory. Edit tomcat-users.xml in tomcat's conf directory and add the user whose role is jolokia.

Take apache-tomcat-9. 0.45 as an example (the username and password of the jolokia user in the example must be modified) :

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

Go to http://localhost:8080/jolokia to see if the configuration was successful.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/tomcat` directory under the DataKit installation directory, copy `tomcat.conf.sample` and name it `tomcat.conf`. Examples are as follows:
    
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

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurement {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.tomcat.tags]`:

``` toml
 [inputs.tomcat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





**###** **`tomcat_global_request_processor`**



\-  tag




| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Protocol handler name.|



\- metric list




| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytesReceived`|Amount of data received, in bytes.|int|count|
|`bytesSent`|Amount of data sent, in bytes.|int|count|
|`errorCount`|Number of errors.|int|count|
|`processingTime`|Total time to process the requests.|int|-|
|`requestCount`|Number of requests processed.|int|count|







**###** **`tomcat_jsp_monitor`**



\-  tag




| Tag | Descrition |
|  ----  | --------|
|`J2EEApplication`|J2EE Application.|
|`J2EEServer`|J2EE Servers.|
|`WebModule`|Web Module.|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|



\- metric list




| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`jspCount`|The number of JSPs that have been loaded into a webapp.|int|count|
|`jspReloadCount`|The number of JSPs that have been reloaded.|int|count|
|`jspUnloadCount`|The number of JSPs that have been unloaded.|int|count|







**###** **`tomcat_thread_pool`**



\-  tag




| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Protocol handler name.|



\- metric list




| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`currentThreadCount`|CurrentThreadCount.|int|count|
|`currentThreadsBusy`|CurrentThreadsBusy.|int|count|
|`maxThreads`|MaxThreads.|int|count|







**###** **`tomcat_servlet`**



\-  tag




| Tag | Descrition |
|  ----  | --------|
|`J2EEApplication`|J2EE Application.|
|`J2EEServer`|J2EE Server.|
|`WebModule`|Web Module.|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Name|



\- metric list




| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`errorCount`|Error count.|int|count|
|`processingTime`|Total execution time of the servlet's service method.|int|-|
|`requestCount`|Number of requests processed by this wrapper.|int|count|







**###** **`tomcat_cache`**



\-  tag




| Tag | Descrition |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`tomcat_context`|Tomcat context.|
|`tomcat_host`|Tomcat host.|



\- metric list




| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hitCount`|The number of requests for resources that were served from the cache.|int|count|
|`lookupCount`|The number of requests for resources.|int|count|





## Log Collection {#logging}

???+ attention

    Log collection only supports log collection on installed DataKit hosts.

To collect Tomcat logs, open `files` n Tomcat.conf and write to the absolute path of the Tomcat log file. For example:
``` toml
  [inputs.tomcat.log]
    files = ["/path_to_tomcat/logs/*"]
```

After log collection is turned on, logs with `tomcat` as the log `source` will be generated by default.

**Field Description**

* Access Log

Log sample:

```
0:0:0:0:0:0:0:1 - admin [24/Feb/2015:15:57:10 +0530] "GET /manager/images/tomcat.gif HTTP/1.1" 200 2066
```

The list of cut fields is as follows:

| Field Name       | Field Value                     | Description                           |
| ---          | ---                        | ---                            |
| time         | 1424773630000000000        | Time when the log was generated                 |
| status       | OK                         | Log level                       |
| client_ip    | 0:0:0:0:0:0:0:1            | Mobile  ip                      |
| http_auth    | admin                      | Authorized users authenticated by HTTP Basic |
| http_method  | GET                        | HTTP methods                      |
| http_url     | /manager/images/tomcat.gif | Client request address                 |
| http_version | 1.1                        | HTTP Protocol Version                  |
| status_code  | 200                        | HTTP status code                    |
| bytes        | 2066                       | Number of bytes of HTTP response body        |

* Cataline / Host-manager / Localhost / Manager Log

log example:

```
06-Sep-2021 22:33:30.513 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
```

the list of cut fields is as follows:

| Field Name        | Field Value                                                | Description                 |
| ---           | ---                                                   | ---                  |
| time          | 1630938810513000000                                   | Time when the log was generated       |
| status        | INFO                                                  | Log level             |
| thread_name   | main                                                  | Thread name               |
| report_source | org.apache.catalina.startup.VersionLoggerListener.log | ClassName.MethodName |
| msg           | Command line argument: -Xmx256m                       | Message                 |
