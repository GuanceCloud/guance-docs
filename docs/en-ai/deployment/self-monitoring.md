# Enable Observability for Deployment Plan

## Overview

The purpose of this document is to assist private Deployment Plan users in implementing observability for the deployment plan, thereby enhancing the overall reliability of Guance services. This article describes two classic observability patterns and how to deploy **DataKit data collection, logs processing, APM, Synthetic Tests, RUM** in a Kubernetes environment. Additionally, we provide one-click import template files for **infrastructure and middleware observability** and **application service observability**, making it easier to observe your own environment.

## Observability Patterns for Deployment Plan

=== "Self-Observability Mode"

    This mode refers to self-observability. In other words, it means sending data to your own workspace. This implies that if the environment goes down, you will also be unable to observe your own information and cannot further investigate the cause. The advantage of this solution is: easy deployment. The disadvantage is: data is continuously generated, leading to self-iteration of data, causing an endless loop, and when the cluster crashes, you cannot observe its issues.


=== "One-to-Many Unified Observability Mode"

    This mode refers to multiple Guance instances sending data to the same node. Advantages: it avoids creating a data transmission loop and allows real-time monitoring of the cluster's status.
    
    ![guance2](img/self-guance2.jpg)

## Infrastructure and Middleware Observability

???+ warning "Note"
     Enabling infrastructure and middleware observability can meet basic needs for observing the status of middleware and infrastructure. If more detailed observation of application services is required, refer to **Application Service Observability** below.

### Configure Data Collection

1) [Download datakit.yaml](datakit.yaml)

???+ warning "Note"
     Note: The default configuration for DataKit and middleware has been set up; minor modifications are needed before use.

2) Modify the `DaemonSet` template file in datakit.yaml

```yaml
   - name: ENV_DATAWAY
     value: https://openway.guance.com?token=tkn_a624xxxxxxxxxxxxxxxxxxxxxxxx74 ## Replace with the actual DataWay URL
   - name: ENV_INPUT_DISK_EXTRA_DEVICE
     value : 10.100.14.144:/nfsdata            ## Change to the actual NFS directory
   image: pubrepo.jiagouyun.com/datakit/datakit:1.5.6     ## Update to the latest image version
```

3) Modify the `ConfigMap` related configurations in datakit.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    mysql.conf: |-
        [[inputs.mysql]]
          host = "xxxxxxxxxxxxxxx"      ## Modify the MySQL connection address
          user = "ste3"                 ## Modify the MySQL username
          pass = "Test1234"             ## Modify the MySQL password
          ......
          
    redis.conf: |-
        [[inputs.redis]]
          host = "r-xxxxxxxxx.redis.rds.ops.ste3.com"            ## Modify the Redis connection address
          port = 6379                                                   
          # unix_socket_path = "/var/run/redis/redis.sock"
          # Configure multiple DBs; configuring dbs will include them in the collection list. Leave empty or comment out to collect all non-empty DBs in Redis
          # dbs=[]
          # username = "<USERNAME>"
           password = "Test1234"                                        ## Modify the Redis password
          ......
          
    openes.conf: |-
        [[inputs.elasticsearch]]
          ## Elasticsearch server configuration
          # Supports Basic authentication:
          # servers = ["http://user:pass@localhost:9200"]
          servers = ["http://guance:123.com@opensearch-cluster-client.middleware:9200"]   ## Modify the username, password, etc.
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

4) Configure the log collection feature of DataKit itself

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

5) Mount operation

```yaml
        - mountPath: /usr/local/datakit/conf.d/db/mysql.conf
          name: datakit-conf
          subPath: mysql.conf
          readOnly: false
```

> Note: Multiple configurations follow the same pattern. Add them sequentially.

6) Deploy DataKit after modifications

```shell
kubectl apply -f datakit.yaml
```

### Import Views and Monitor Templates

[Download infrastructure and middleware templates](easy_resource.zip)

- **Import Templates**

![allin](img/self-allin.jpg)

???+ warning "Note"
     After importing, modify the corresponding jump link configurations in **Monitoring**. Replace `dsbd_xxxx` with the appropriate dashboard ID and `wksp_xxxx` with the space ID to be monitored.

## Application Service Observability (Optional)

???+ warning "Note" 
     Enabling application service observability consumes a large amount of storage resources. Please evaluate before enabling.

### Configure Logs

???+ "Prerequisites"

     1. Install DataKit on your host machine [Install DataKit](https://docs.guance.com/datakit/datakit-install/) 
    
     2. If you are unfamiliar with Pipeline knowledge, please refer to the [Log Pipeline User Manual](../logs/manual.md)

#### Configure Log and Metrics Collection

1) Inject via `ConfigMap` + `Container Annotation` through command line

```shell
# Change log output mode
kubectl edit -n forethought-kodo cm <configmap_name>
```

2) Change the log output in the `ConfigMap` under the forethought-kodo Namespace to stdout.

3) Enable metrics collection for the services listed in the table below

| `Namespace`      | Service Name         | Enable Metrics Collection | Enable DDtrace Collection |
| ---------------- | -------------------- | -------------------------- | -------------------------- |
| forethought-core | front-backend        | No                        | Yes                        |
|                  | inner                | Yes                       | Yes                        |
|                  | management-backend   | No                        | Yes                        |
|                  | openapi              | No                        | Yes                        |
|                  | websocket            | No                        | Yes                        |
| forethought-kodo | kodo                 | Yes                       | Yes                        |
|                  | kodo-inner           | Yes                       | Yes                        |
|                  | kodo-x               | Yes                       | Yes                        |
|                  | kodo-asynq-client    | Yes                       | Yes                        |
|                  | kodo-x-backuplog     | Yes                       | Yes                        |
|                  | kodo-x-scan          | Yes                       | No                         |

- Configure `Deployment Annotations` in the corresponding applications without modification

```yaml
spec:
  template:
    metadata:
      annotations:
        datakit/prom.instances: |-
          [[inputs.prom]]
            ## Exporter address
            url = "http://$IP:9527/v1/metric?metrics_api_key=apikey_5577006791947779410"

            ## Collector alias
           source = "kodo-prom"

            ## Metric type filter, optional values are counter, gauge, histogram, summary
            # By default, only counter and gauge types are collected
            # If empty, no filtering is applied
            # metric_types = ["counter","gauge"]
            metric_types = []

            ## Metric name filter
            # Supports regex, can configure multiple, i.e., match any one
            # If empty, no filtering is applied
            # metric_name_filter = ["cpu"]

            ## Measurement name prefix
            # Configuring this item adds a prefix to the measurement name
            measurement_prefix = ""

            ## Measurement name
            # By default, the metric name is split by underscore "_", with the first part as the measurement name and the rest as the current metric name
            # If measurement_name is configured, no splitting occurs
            # The final measurement name will have the measurement_prefix added
            # measurement_name = "prom"

            ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
            interval = "10s"

            ## Filter tags, multiple tags can be configured
            # Matching tags will be ignored
            # tags_ignore = ["xxxx"]

            ## TLS configuration
            tls_open = false
            # tls_ca = "/tmp/ca.crt"
            # tls_cert = "/tmp/peer.crt"
            # tls_key = "/tmp/peer.key"

            ## Custom measurement names
            # Metrics with the specified prefix will be grouped into one measurement
            # Custom measurement name configuration takes precedence over measurement_name
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

            ## Custom Tags
            [inputs.prom.tags]
            # some_tag = "some_value"
            # more_tag = "some_other_value"
```

???+ warning "Note"
     The above only enables log collection. To parse the log state, you need to configure the corresponding **Pipeline**.

#### Use Pipeline to Parse Logs

=== "Method One"
    **Import Pipeline Template via Interface**

    [Download Pipeline Template](Pipelines 模板.json)
    
    ![pipeline001](img/self-pipeline001.jpg)

=== "Method Two"
    **Modify DataKit mounting and add service Annotations to enable log parsing**

    1) In the corresponding datakit.yaml, mount `<pipeline_name>.p` file to the specified directory using `ConfigMap`
    
    ```yaml
            - mountPath: /usr/local/datakit/pipeline/kodo-x.p
              name: datakit-conf
              subPath: kodo-inner.p
    ```
    
    2) Modify the corresponding service yaml file and add the following Annotations
    
      ```yaml
      spec:
        template:
          metadata:
            annotations:
              datakit/logs: |-
                [
                            {
                              "source": "kodo",             ## Displayed source on the page
                              "service": "kodo",            ## Displayed service on the page
                              "pipeline": "kodo.p"          ## Default path for pipeline file in DataKit
                            }
                          ]
      ```
    
    3) Status after enabling
    
      ![image-20221129165203967](https://docs.guance.com/logs/img/12.pipeline_4.png)

### Configure APM

???+ "Prerequisites"

     1. Install DataKit on your host machine [Install DataKit](https://docs.guance.com/datakit/datakit-install/) 
    
     2. Enable the ddtrace collector in DataKit [Enable ddtrace collector](../integrations/ddtrace.md), using K8S `ConfigMap` injection

**Start Configuration**

- Modify the Deployment configuration in the forethought-core Namespace

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
        - ddtrace-run               ## Add this line
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
        env:                     ## Enable DDtrace collection, add the following content (including services in the forethought-kodo Namespace)
        - name: DD_PATCH_MODULES
          value: redis:true,urllib3:true,httplib:true,httpx:true
        - name: DD_AGENT_PORT
          value: "9529"
        - name: DD_GEVENT_PATCH_ALL
          value: "true"
        - name: DD_SERVICE
          value: py-front-backend    ## Modify to the corresponding service name
        - name: DD_TAGS
          value: project:dataflux
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
```

???+ warning "Note"
     **forethought-core** namespace contains multiple services that can be enabled. If the YAML file has default arg configurations, all should be enabled.

- Page display

![img](https://docs.guance.com/application-performance-monitoring/img/9.apm_explorer_1.png)

### Configure Synthetic Tests

1) Create a new website to monitor

  ![boce1](img/self-boce1.jpg)

2) Configure the dial testing task

  ![boce2](img/self-boce2.jpg)

???+ warning "Note"
     Modify according to the actual domain settings

| Name               | Dial Testing Address                                                     | Type | Task Status | Action                                                         |
| ------------------ | ------------------------------------------------------------ | ---- | -------- | ------------------------------------------------------------ |
| cn4-console-api    | https://cn4-console-api.guance.com                           | HTTP | Started     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-auth           | https://cn4-auth.guance.com                                  | HTTP | Started     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-openway        | https://cn4-openway.guance.com                               | HTTP | Started     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-static-res     | https://cn4-static-res.guance.com/dataflux-template/README.md | HTTP | Started     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-console        | https://cn4-console.guance.com                               | HTTP | Started     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management-api | https://cn4-management-api.guance.com                        | HTTP | Started     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4