# 开启部署版自身的可观测

## 概述

本文档的目的在于能够帮助私有部署版用户，如何对部署版实施可观测，以提升整体{{{ custom_key.brand_name }}}服务的运行可靠性。此篇讲述了2种经典的可观测模式，以及在 Kubernetes 的环境下如何部署 **Datakit 数据采集、日志及切割、应用性能监测、可用性监测、用户访问监测** 等。此外，我们还提供了**基础设施及中间件观测** 和 **应用服务观测**的一键导入模板文件，方便大家更好的使用以便观测自身环境。



## 部署版可观测模式


=== "自观测模式"

    此模式是指，自己观测自己。换句话说，就是自己把数据打到自己的空间上。这就意味着如果环境挂掉了。那么自己也同时观测不到自己的信息数据了，并且也无法进一步排查原因。此方案优点是：部署方便。缺点是：数据是持续产生的，会产生数据自迭代，导致一直循环下去，并且集群崩溃时，无法观测到自身的问题。



=== "一对多统一观测模式"

    此模式是指，客户的多个{{{ custom_key.brand_name }}}都往同一节点去打。优点：不会造成数据传输闭环的情况，并且能够实时监测到自身集群的状态。
    
    ![guance2](img/self-guance2.jpg)


## 基础设施及中间件观测

???+ warning "注意"
     开启基础设施及中间件观测可满足基本对于中间件及基础设施的状态观测需求，如果还想要更细致的对于应用服务方面的观测可以再参考以下的**应用服务观测**。

### 配置数据采集

1）[下载datakit.yaml](datakit.yaml)

???+ warning "注意"
     注意：以上DataKit默认的配置中间件配置都已配置完毕，稍作修改即可使用。

2）修改 datakit.yaml `DaemonSet` 的模板文件

```yaml
   - name: ENV_DATAWAY
     value: https://openway.guance.com?token=tkn_a624xxxxxxxxxxxxxxxxxxxxxxxx74 ## 此处填上 dataway 真实地址
   - name: ENV_GLOBAL_TAGS
     value: host=__datakit_hostname,host_ip=__datakit_ip,guance_site=guance,cluster_name_k8s=guance # 面板变量根据自己实际情况修改
   - name: ENV_GLOBAL_ELECTION_TAGS
     value: guance_site=guance,cluster_name_k8s=guance     # 根据自己面板变量实际情况修改
   image: pubrepo.jiagouyun.com/datakit/datakit:1.65.2     ## 修改成最新镜像版本
```

3）修改 datakit.yaml 中关于`ConfigMap`的相关配置

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    mysql.conf: |-
        [[inputs.mysql]]
          host = "xxxxxxxxxxxxxxx"      ##修改对应MySQL连接地址
          user = "ste3"                 ##修改MySQL用户名
          pass = "Test1234"             ##修改MySQL密码
          ......
          
    redis.conf: |-
        [[inputs.redis]]
          host = "r-xxxxxxxxx.redis.rds.ops.ste3.com"            ## 修改Redis连接地址
          port = 6379                                                   
          # unix_socket_path = "/var/run/redis/redis.sock"
          # 配置多个db，配置了dbs，db也会放入采集列表。dbs=[]或者不配置则会采集redis中所有非空的db
          # dbs=[]
          # username = "<USERNAME>"
           password = "Test1234"                                        ## 修改Redis密码
          ......
          
    openes.conf: |-
        [[inputs.elasticsearch]]
          ## Elasticsearch服务器配置
          # 支持Basic认证:
          # servers = ["http://user:pass@localhost:9200"]
          servers = ["http://guance:123.com@opensearch-cluster-client.middleware:9200"]   ## 修改用户名、密码等
          ......
          
    influxdb.conf: |-
        [[inputs.influxdb]]
	  url = "http://localhost:8086/debug/vars"

	  ## (optional) collect interval, default is 10 seconds
	  interval = '10s'

	  ## Username and password to send using HTTP Basic Authentication.
	  # username = ""
	  # password = ""

	  ## http request & header timeout
	  timeout = "5s"

	  ## Set true to enable election
	  election = true
```

4）配置 datakit 采集器本身的日志收集功能

```yaml
  template:
    metadata:
      annotations:
        datakit/logs: |
          [
            {
              "disable": true
            }
          ]

```


5）挂载操作

```yaml
        - mountPath: /usr/local/datakit/conf.d/db/mysql.conf
          name: datakit-conf
          subPath: mysql.conf
          readOnly: false
```

> 注意：多个配置也是一样的。依次添加下去。

6）修改后开始部署DataKit

```shell
kubectl apply -f datakit.yaml
```

### 导入视图及监控器模板

[基础设施及中间件模板下载地址](easy_resource.zip)

- **导入模板**

![allin](img/self-allin.jpg)

???+ warning "注意"
     导入后**监控**要修改相应的跳转链接配置。要把 url 中的 dsbd_xxxx 换到对应的仪表板下，wksp_xxxx 换成要监测的空间下。

## 应用服务观测（可选）

???+ warning "注意" 
     开启应用服务观测方式消耗的存储资源比较大，请评估后再开启。

### 配置日志

???+ "前置条件"

     1. 您的主机上需 [安装 DataKit](https://docs.guance.com/datakit/datakit-install/) 
    
     2. 如果您不懂相关的 Pipeline 知识，请查看[日志 Pipeline 使用手册](../logs/manual.md)

#### 配置日志和指标采集

1）命令行通过`ConfigMap`+`Container Annotation`的方式注入

```shell
# 更改日志输出模式
kubectl edit -n forethought-kodo cm <configmap_name>
```

2）把 forethought-kodo Namespace 下的`ConfigMap`，里面的日志输出改成 stdout。

3）开启下表中对应服务的指标采集

| `Namespace`      | 服务名             | 是否开启指标采集   | 是否开启 DDtrace 采集 |
| ---------------- | ------------------ | ------------------ | ------------------    |
| forethought-core | front-backend      | 否                 |  是                   |
|                  | inner              | 是                 |  是                   |
|                  | management-backend | 否                 |  是                   |
|                  | openapi            | 否                 |  是                   |
|                  | websocket          | 否                 |  是                   |
| forethought-kodo | kodo               | 是                 |  是                   |
|                  | kodo-inner         | 是                 |  是                   |
|                  | kodo-x             | 是                 |  是                   |
|                  | kodo-asynq-client  | 是                 |  是                   |
|                  | kodo-x-backuplog   | 是                 |  是                   |
|                  | kodo-x-scan        | 是                 |  否                   |

- 在对应的应用中配置`Deployment Annotations`，以下内容不用修改

```yaml
spec:
  template:
    metadata:
      annotations:
        datakit/prom.instances: |-
          [[inputs.prom]]
            ## Exporter 地址
            url = "http://$IP:9527/v1/metric?metrics_api_key=apikey_5577006791947779410"

            ## 采集器别名
           source = "kodo-prom"

            ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
            # 默认只采集 counter 和 gauge 类型的指标
            # 如果为空，则不进行过滤
            # metric_types = ["counter","gauge"]
            metric_types = []

            ## 指标名称过滤
            # 支持正则，可以配置多个，即满足其中之一即可
            # 如果为空，则不进行过滤
            # metric_name_filter = ["cpu"]

            ## 指标集名称前缀
            # 配置此项，可以给指标集名称添加前缀
            measurement_prefix = ""

            ## 指标集名称
            # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
            # 如果配置measurement_name, 则不进行指标名称的切割
            # 最终的指标集名称会添加上measurement_prefix前缀
            # measurement_name = "prom"

            ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
            interval = "10s"

            ## 过滤tags, 可配置多个tag
            # 匹配的tag将被忽略
            # tags_ignore = ["xxxx"]

            ## TLS 配置
            tls_open = false
            # tls_ca = "/tmp/ca.crt"
            # tls_cert = "/tmp/peer.crt"
            # tls_key = "/tmp/peer.key"

            ## 自定义指标集名称
            # 可以将包含前缀prefix的指标归为一类指标集
            # 自定义指标集名称配置优先measurement_name配置项
            [[inputs.prom.measurements]]
              prefix = "kodo_api_"
              name = "kodo_api"

           [[inputs.prom.measurements]]
             prefix = "kodo_workers_"
             name = "kodo_workers"

           [[inputs.prom.measurements]]
             prefix = "kodo_workspace_"
             name = "kodo_workspace"

           [[inputs.prom.measurements]]
             prefix = "kodo_dql_"
             name = "kodo_dql"

            ## 自定义Tags
            [inputs.prom.tags]
            # some_tag = "some_value"
            # more_tag = "some_other_value"
```

???+ warning "注意"
     上面只是开启了日志采集，想要对日志的状态进行**切割**的话还需要配置相应的 **Pipeline**。
    

#### 使用 Pipeline 切割日志

**界面上一键导入 Pipeline 模板**

[Pipeline下载地址](Pipelines 模板.json)

![pipeline001](img/self-pipeline001.jpg)


   

### 配置应用性能监测

???+ "前置条件"

     1、您的主机上需 [安装 DataKit](https://docs.guance.com/datakit/datakit-install/) 
    
     2、并在 DataKit 上[开启 ddtrace 采集器](../integrations/ddtrace.md),采用K8S `ConfigMap`的方式注入

**开始配置**

- 修改 forethought-core Namespace下的 Deployment 配置

  ```shell
  kubectl edit -n <namespace> deployment <service_name>
  ```

```yaml
spec:
  template:
    spec:
      affinity: {}
      containers:
      - args:
        - ddtrace-run               ## 添加这行
        - gunicorn
        - -c
        - wsgi.py
        - web:wsgi()
        - --limit-request-line
        - "0"
        - -e
        - RUN_APP_CODE=front
        - --timeout
        - "300"
        env:                     ## 开启 DDtrace 采集，添加以下内容（包括上表中 forethought-kodo Namespace 下的服务）
        - name: DD_PATCH_MODULES
          value: redis:true,urllib3:true,httplib:true,httpx:true
        - name: DD_AGENT_PORT
          value: "9529"
        - name: DD_GEVENT_PATCH_ALL
          value: "true"
        - name: DD_SERVICE
          value: py-front-backend    ## 修改成对应服务名
        - name: DD_TAGS
          value: project:dataflux
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
```

???+ warning "注意"
     **forethought-core** namespace 下有多个服务可以开启，如果看到有 yaml 文件中 arg 默认配置的全部都要开启

- 页面显示

![img](https://docs.guance.com/application-performance-monitoring/img/9.apm_explorer_1.png)

### 配置可用性监测

1）新建一个要监测的网站

  ![boce1](img/self-boce1.jpg)

2）配置拨测任务

  ![boce2](img/self-boce2.jpg)

???+ warning "注意"
     根据实际设置的域名进行修改

| 名称               | 拨测地址                                                     | 类型 | 任务状态 | 操作                                                         |
| ------------------ | ------------------------------------------------------------ | ---- | -------- | ------------------------------------------------------------ |
| cn4-console-api    | https://cn4-console-api.guance.com                           | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-auth           | https://cn4-auth.guance.com                                  | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-openway        | https://cn4-openway.guance.com                               | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-static-res     | https://cn4-static-res.guance.com/dataflux-template/README.md | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-console        | https://cn4-console.guance.com                               | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management-api | https://cn4-management-api.guance.com                        | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management     | https://cn4-management.guance.com                            | HTTP | 启动     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |


### 配置用户访问监测

1）部署一个 Deployment 状态的 DataKit

```yaml
## deployment-datakit.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    workload.user.cattle.io/workloadselector: apps.deployment-utils-test-rum-datakit
    manager: kube-controller-manager
  name: test-rum-datakit  
  namespace: utils
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      workload.user.cattle.io/workloadselector: apps.deployment-utils-test-rum-datakit 
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      labels:
        workload.user.cattle.io/workloadselector: apps.deployment-utils-test-rum-datakit
    spec:
      affinity: {}
      containers:
      - env:
        - name: ENV_DATAWAY
          value: http://internal-dataway.utils:9528?token=xxxxxx    ## 此处的token需修改
        - name: ENV_DISABLE_404PAGE
          value: "1"
        - name: ENV_GLOBAL_TAGS
          value: project=dataflux-saas-prodution,host_ip=__datakit_ip,host=__datakit_hostname
        - name: ENV_HTTP_LISTEN
          value: 0.0.0.0:9529
        - name: ENV_IPDB
          value: iploc
        - name: ENV_RUM_ORIGIN_IP_HEADER
          value: X-Forwarded-For
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: rum
        image: pubrepo.jiagouyun.com/datakit/datakit:1.5.0
        imagePullPolicy: Always
        name: test-rum-datakit
        resources: {}
        securityContext:
          allowPrivilegeEscalation: false
          capabilities: {}
          privileged: false
          readOnlyRootFilesystem: false
          runAsNonRoot: false
        stdin: true
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        tty: true
        volumeMounts:
        - mountPath: /usr/local/datakit/data/ipdb/iploc/
          name: datakit-ipdb
      dnsPolicy: ClusterFirst
      imagePullSecrets:
      - name: registry-key
      initContainers:
      - args:
        - tar -xf /opt/iploc.tar.gz -C /usr/local/datakit/data/ipdb/iploc/
        command:
        - bash
        - -c
        image: pubrepo.jiagouyun.com/datakit/iploc:1.0
        imagePullPolicy: IfNotPresent
        name: init-volume
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /usr/local/datakit/data/ipdb/iploc/
          name: datakit-ipdb
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - emptyDir: {}
        name: datakit-ipdb
---
apiVersion: v1
kind: Service
metadata:
  name: test-rum-datakit
  namespace: utils
spec:
  ports:
  - name: http
    port: 9529
    protocol: TCP
    targetPort: 9529
  selector:
    app: test-rum-datakit
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
```

2）修改 forethought-webclient 服务的名为 config.js  `ConfigMap`配置

???+ warning "注意"
     以下所有的关于 inner-app 的域名都修改成实际对应的域名

```shell
window.DEPLOYCONFIG = {
    cookieDomain: '.guance.com',
    apiUrl: 'https://cn4-console-api.guance.com',
    wsUrl: 'wss://.guance.com',
    innerAppDisabled: 0,
    innerAppLogin: 'https://cn4-auth.guance.com/redirectpage/login',
    innerAppRegister: 'https://cn4-auth.guance.com/redirectpage/register',
    innerAppProfile: 'https://cn4-auth.guance.com/redirectpage/profile',
    innerAppCreateworkspace: 'https://cn4-auth.guance.com/redirectpage/createworkspace',
    staticFileUrl: 'https://cn4-static-res.guance.com',
    staticDatakit: 'https://{{{ custom_key.static_domain }}}',
    cloudDatawayUrl: '',
    isSaas: '1',
    showHelp: 1,
    rumEnable: 1,                                                                              ## 0是关闭，1是开启，此处开启
    rumDatakitUrl: "",                                                                         ## 修改成deployment的datakit地址
    rumApplicationId: "",                                                                      ## 修改成实际appid
    rumJsUrl: "https://{{{ custom_key.static_domain }}}/browser-sdk/v2/dataflux-rum.js",
    rumDataEnv: 'prod',
    shrineApiUrl: '',
    upgradeUrl: '',
    rechargeUrl: '',
    paasCustomLoginInfo: []
};
```

3）修改 utils 下名为 dataway-config 的 ConfigMap 配置

```yaml
token: xxxxxxxxxxx       ## 修改成实际的token
```

### 导入视图及监控器模板

[应用服务监测模板下载地址](pro_resource.zip)

- **导入模板**

![allin](img/self-allin.jpg)

???+ warning "注意"
     导入后**监控**要修改相应的跳转链接配置。要把 url 中的 dsbd_xxxx 换到对应的仪表板下，wksp_xxxx 换成要监测的空间下。

## Func 自观测（可选）

### Func 任务日志数据上报

DataFlux Func 的函数运行日志、自动触发配置等信息可以直接上报至{{{ custom_key.brand_name }}}。步骤如下图

![allin](img/self-func.png)



在{{{ custom_key.brand_name }}}数据上报中填写 DataWay / OpenWay 地址和 Token 信息即可，格式如下：

```shell
https://openway.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

> *注意：如果Func数据上报失败，可查看 [DataFlux Func文档](https://func.guance.com/doc/ui-guide-management-module-system-setting/){:target="_blank"}*



## 验证方式

- 查看场景中的仪表板是否有数据
- 查看基础设施中是否有对应DataKit开启主机的相关信息
- 查看指标中是否含有MySQL、Redis等数据库的指标数据
- 查看日志中是否有日志并开启了相应的状态
- 查看应用性能监测是否有RUM的数据
