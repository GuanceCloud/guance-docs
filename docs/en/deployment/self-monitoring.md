# Enable Observability for Deployment Edition

## Overview

The purpose of this document is to assist private deployment edition users in implementing observability for the deployment edition, thereby enhancing the overall reliability of <<< custom_key.brand_name >>> services. This document describes two classic observability patterns and how to deploy **Datakit data collection, log slicing, APM, Synthetic Tests, RUM**, etc., in a Kubernetes environment. Additionally, we provide one-click import template files for **infrastructure and middleware observability** and **application service observability** to facilitate better monitoring of your own environment.

## Observability Patterns for Deployment Edition

=== "Self-Observation Mode"

    In this mode, the system observes itself. In other words, it sends data to its own space. This means that if the environment goes down, it cannot observe its own information data and further troubleshooting becomes impossible. The advantage of this solution is ease of deployment. The disadvantage is that data is continuously generated, leading to self-iteration, resulting in an endless loop, and when the cluster crashes, it cannot observe its own issues.

=== "One-to-Many Unified Observation Mode"

    In this mode, multiple <<< custom_key.brand_name >>> instances send data to the same node. Advantage: It avoids creating a data transmission loop and allows real-time monitoring of the cluster's status.
    
    ![guance2](img/self-guance2.jpg)

## Infrastructure and Middleware Observability

???+ warning "Note"
     Enabling infrastructure and middleware observability can meet basic needs for observing the state of middleware and infrastructure. For more detailed application service observation, refer to **Application Service Observability** below.

### Configuring Data Collection

1) [Download datakit.yaml](datakit.yaml)

???+ warning "Note"
     Note: The default configurations for middleware in DataKit are already set up; minor modifications can be made before use.

2) Modify the `DaemonSet` template file in datakit.yaml

```yaml
   - name: ENV_DATAWAY
     value: https://openway.guance.com?token=tkn_a624xxxxxxxxxxxxxxxxxxxxxxxx74 ## Replace with the actual DataWay URL
   - name: ENV_GLOBAL_TAGS
     value: host=__datakit_hostname,host_ip=__datakit_ip,guance_site=guance,cluster_name_k8s=guance # Adjust panel variables as needed
   - name: ENV_GLOBAL_ELECTION_TAGS
     value: guance_site=guance,cluster_name_k8s=guance     # Adjust according to your panel variables
   image: pubrepo.jiagouyun.com/datakit/datakit:1.65.2     ## Update to the latest image version
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
          # Configure multiple dbs; if dbs are configured, they will be included in the collection list. If dbs=[] or not configured, all non-empty dbs in Redis will be collected
          # dbs=[]
          # username = "<USERNAME>"
           password = "Test1234"                                        ## Modify the Redis password
          ......
          
    openes.conf: |-
        [[inputs.elasticsearch]]
          ## Elasticsearch server configuration
          # Supports Basic authentication:
          # servers = ["http://user:pass@localhost:9200"]
          servers = ["http://guance:123.com@opensearch-cluster-client.middleware:9200"]   ## Modify username, password, etc.
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

4) Configure DataKit's own log collection function

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

5) Mount operations

```yaml
        - mountPath: /usr/local/datakit/conf.d/db/mysql.conf
          name: datakit-conf
          subPath: mysql.conf
          readOnly: false
```

> Note: Multiple configurations are similar. Add them sequentially.

6) Deploy DataKit after modification

```shell
kubectl apply -f datakit.yaml
```

### Import View and Monitor Templates

[Infrastructure and Middleware Template Download Link](easy_resource.zip)

- **Import Template**

![allin](img/self-allin.jpg)

???+ warning "Note"
     After importing, modify the corresponding jump link configurations in **Monitoring**. Replace `dsbd_xxxx` with the appropriate dashboard and `wksp_xxxx` with the target workspace.

## Application Service Observability (Optional)

???+ warning "Note"
     Enabling application service observability consumes a significant amount of storage resources. Please evaluate before enabling.

### Configure Logs

???+ "Prerequisites"

     1. Install DataKit on your host [Install DataKit](<<< homepage >>>/datakit/datakit-install/) 
    
     2. If you are unfamiliar with Pipeline knowledge, please refer to the [Log Pipeline User Manual](../logs/manual.md)

#### Configure Log and Metrics Collection

1) Inject via `ConfigMap` + `Container Annotation` through command line

```shell
# Change log output mode
kubectl edit -n forethought-kodo cm <configmap_name>
```

2) Change the log output to stdout in the `ConfigMap` under the `forethought-kodo` Namespace.

3) Enable metrics collection for the services listed in the table below

| `Namespace`      | Service Name         | Enable Metrics Collection | Enable DDtrace Collection |
| ---------------- | -------------------- | ------------------------- | -------------------------- |
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

- Configure `Deployment Annotations` in the corresponding application without modifying the following content

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

            ## Metric type filtering, optional values are counter, gauge, histogram, summary
            # By default, only counter and gauge types of metrics are collected
            # If empty, no filtering is performed
            # metric_types = ["counter","gauge"]
            metric_types = []

            ## Metric name filtering
            # Supports regular expressions, multiple configurations can be made, i.e., meeting any one condition suffices
            # If empty, no filtering is performed
            # metric_name_filter = ["cpu"]

            ## Measurement name prefix
            # Configuring this item adds a prefix to the measurement name
            measurement_prefix = ""

            ## Measurement name
            # By default, the metric name is split by underscores "_", with the first field being the measurement name and the remaining fields being the current metric name
            # If `measurement_name` is configured, no splitting of the metric name will occur
            # The final measurement name will have the `measurement_prefix` added as a prefix
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
            # Can group metrics containing the prefix `prefix` into one category of measurements
            # Custom measurement name configuration takes precedence over the `measurement_name` option
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
     The above only enables log collection. To perform **log segmentation**, corresponding **Pipelines** need to be configured.


#### Use Pipeline to Segment Logs

**Import Pipeline Template with One Click from the Interface**

[Pipeline Download Link](Pipelines 模板.json)

![pipeline001](img/self-pipeline001.jpg)


   

### Configure Application Performance Monitoring

???+ "Prerequisites"

     1. Install DataKit on your host [Install DataKit](<<< homepage >>>/datakit/datakit-install/)
    
     2. Enable ddtrace collector on DataKit [Enable ddtrace collector](../integrations/ddtrace.md), inject using K8S `ConfigMap`

**Start Configuration**

- Modify the Deployment configuration under the `forethought-core` Namespace

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
        env:                     ## Enable DDtrace collection, add the following content (including services under the `forethought-kodo` Namespace)
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
     **forethought-core** Namespace has multiple services that can be enabled. If you see all default configurations in the YAML file, enable them all.

- Display on Page

![img](<<< homepage >>>/application-performance-monitoring/img/9.apm_explorer_1.png)

### Configure Availability Monitoring

1) Create a new website to monitor

  ![boce1](img/self-boce1.jpg)

2) Configure dial test tasks

  ![boce2](img/self-boce2.jpg)

???+ warning "Note"
     Modify based on the actual domain settings

| Name               | Dial Test Address                                                     | Type | Task Status | Operation                                                         |
| ------------------ | ------------------------------------------------------------ | ---- | -------- | ------------------------------------------------------------ |
| cn4-console-api    | https://cn4-console-api.guance.com                           | HTTP | Start     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-auth           | https://cn4-auth.guance.com                                  | HTTP | Start     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-openway        | https://cn4-openway.guance.com                               | HTTP | Start     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-static-res     | https://cn4-static-res.guance.com/dataflux-template/README.md | HTTP | Start     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-console        | https://cn4-console.guance.com                               | HTTP | Start     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management-api | https://cn4-management-api.guance.com                        | HTTP | Start     | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-auth           | https://cn4-auth.guance.com                                          | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-openway        | https://cn4-openway.guance.com                                       | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-static-res     | https://cn4-static-res.guance.com/dataflux-template/README.md       | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-console        | https://cn4-console.guance.com                                       | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management-api | https://cn4-management-api.guance.com                               | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management     | https://cn4-management.guance.com                                   | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |

### Configure User Access Monitoring

1) Deploy a Deployment status DataKit

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
          value: http://internal-dataway.utils:9528?token=xxxxxx    ## Replace with the actual token
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

2) Modify the `ConfigMap` configuration named config.js for the `forethought-webclient` service

???+ warning "Note"
     Replace all inner-app domain names with the actual corresponding domains.

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
    staticDatakit: 'https://static.<<< custom_key.brand_main_domain >>>',
    cloudDatawayUrl: '',
    isSaas: '1',
    showHelp: 1,
    rumEnable: 1,                                                                              ## 0 to disable, 1 to enable, enabling here
    rumDatakitUrl: "",                                                                         ## Modify to the DataKit address of the deployment
    rumApplicationId: "",                                                                      ## Modify to the actual application ID
    rumJsUrl: "https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js",
    rumDataEnv: 'prod',
   ```yaml
    rumDataEnv: 'prod',
    shrineApiUrl: '',
    upgradeUrl: '',
    rechargeUrl: '',
    paasCustomLoginInfo: []
};
```

3) Modify the `ConfigMap` configuration named `dataway-config` under the `utils` namespace

```yaml
token: xxxxxxxxxxx       ## Replace with the actual token
```

### Import View and Monitor Templates

[Application Service Monitoring Template Download Link](pro_resource.zip)

- **Import Template**

![allin](img/self-allin.jpg)

???+ warning "Note"
     After importing, modify the corresponding jump link configurations in **Monitoring**. Replace `dsbd_xxxx` with the appropriate dashboard and `wksp_xxxx` with the target workspace.

## Func Self-Observation (Optional)

### Func Task Log Data Reporting

The function execution logs and automatic trigger configurations of DataFlux Func can be directly reported to <<< custom_key.brand_name >>>. The steps are shown in the following figure:

![allin](img/self-func.png)

In <<< custom_key.brand_name >>> data reporting, fill in the DataWay/OpenWay address and Token information as follows:

```shell
https://openway.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

> *Note: If Func data reporting fails, you can refer to the [DataFlux Func Documentation](https://func.guance.com/doc/ui-guide-management-module-system-setting/){:target="_blank"}*

## Verification Methods

- Check if there is data on the dashboard in the scenario.
- Check if there is relevant DataKit host information in the infrastructure.
- Check if the metrics contain MySQL, Redis, etc., database metrics data.
- Check if there are logs and if the corresponding states have been enabled.
- Check if the APM has RUM data.

---

This completes the translation of the provided content. If you need any further assistance or additional sections translated, please let me know!