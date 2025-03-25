# Enable observability for Deployment Plan

## Overview

The purpose of this document is to assist private Deployment Plan users in how to implement observability for the Deployment Plan, thereby enhancing the overall reliability of <<< custom_key.brand_name >>> services. This article discusses two classic observability patterns, as well as how to deploy **Datakit data collection, logs and slicing, APM, Synthetic Tests, RUM** in a Kubernetes environment. Additionally, we provide one-click import template files for **infrastructure and MIDDLEWARE observability** and **application service observability**, making it easier for everyone to observe their own environment.


=== "Self-observability Mode"

    This mode refers to self-observation. In other words, it means sending data to your own space. This implies that if the environment goes down, you will also be unable to observe your information data, and further troubleshooting will not be possible. The advantage of this solution is: easy deployment. The disadvantage is: data is continuously generated, leading to self-iteration of data, causing a continuous loop, and when the cluster crashes, you cannot observe its own issues.



=== "One-to-many Unified Observability Mode"

    This mode refers to multiple <<< custom_key.brand_name >>> instances sending data to the same node. Advantages: no data transmission closed-loop situation occurs, and real-time monitoring of the cluster's status is possible.
    
    ![guance2](img/self-guance2.jpg)


## Infrastructure and MIDDLEWARE Observability

???+ warning "Note"
     Enabling infrastructure and MIDDLEWARE observability can meet basic needs for observing the state of MIDDLEWARE and infrastructure. If more detailed observation of application services is desired, refer to the following **Application Service Observability**.

### Configure Data Collection

1) [Download datakit.yaml](datakit.yaml)

???+ warning "Note"
     Note: All default configurations for DataKit are already configured, requiring minor adjustments before use.

2) Modify the `DaemonSet` template file in datakit.yaml

```yaml
   - name: ENV_DATAWAY
     value: https://openway.<<< custom_key.brand_main_domain >>>?token=tkn_a624xxxxxxxxxxxxxxxxxxxxxxxx74 ## Enter the actual dataway address here
   - name: ENV_GLOBAL_TAGS
     value: host=__datakit_hostname,host_ip=__datakit_ip,guance_site=guance,cluster_name_k8s=guance # Modify panel variables according to your actual situation
   - name: ENV_GLOBAL_ELECTION_TAGS
     value: guance_site=guance,cluster_name_k8s=guance     # Modify according to your actual panel variable situation
   image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit:1.65.2     ## Update to the latest image version
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
          host = "xxxxxxxxxxxxxxx"      ## Modify the corresponding MySQL connection address
          user = "ste3"                 ## Modify the MySQL username
          pass = "Test1234"             ## Modify the MySQL password
          ......
          
    redis.conf: |-
        [[inputs.redis]]
          host = "r-xxxxxxxxx.redis.rds.ops.ste3.com"            ## Modify Redis connection address
          port = 6379                                                   
          # unix_socket_path = "/var/run/redis/redis.sock"
          # Configure multiple dbs; if dbs=[] or not configured, all non-empty dbs in Redis will be collected
          # dbs=[]
          # username = "<USERNAME>"
           password = "Test1234"                                        ## Modify Redis password
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

4) Configure the log collection function of the DataKit collector itself

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


5) Mount Operations

```yaml
        - mountPath: /usr/local/datakit/conf.d/db/mysql.conf
          name: datakit-conf
          subPath: mysql.conf
          readOnly: false
```

> Note: The same applies for multiple configurations. Add them sequentially.

6) Deploy DataKit after modification

```shell
kubectl apply -f datakit.yaml
```

### Import Views and Monitor Templates

[Infrastructure and MIDDLEWARE Template Download Address](easy_resource.zip)

- **Import Template**

![allin](img/self-allin.jpg)

???+ warning "Note"
     After importing the **monitor**, modify the corresponding jump link configuration. Replace dsbd_xxxx with the corresponding dashboard and wksp_xxxx with the monitored workspace.

## Application Service Observability (Optional)

???+ warning "Note" 
     Enabling application service observability consumes a large amount of storage resources. Please evaluate before enabling.

### Configure Logs

???+ "Prerequisites"

     1. Your HOST must have [DataKit installed](<<< homepage >>>/datakit/datakit-install/) 
    
     2. If you do not understand Pipeline knowledge, please check the [Log Pipeline User Manual](../logs/manual.md)

#### Configure Log and Metric Collection

1) Inject via `ConfigMap` + `Container Annotation` through command line

```shell
# Change log output mode
kubectl edit -n forethought-kodo cm <configmap_name>
```

2) Change the log output in the `ConfigMap` under the forethought-kodo Namespace to stdout.

3) Enable metric collection for the corresponding services listed below

| `Namespace`      | Service Name       | Enable Metric Collection | Enable DDtrace Collection |
| ---------------- | ------------------ | ------------------------ | -------------------------- |
| forethought-core | front-backend      | No                       | Yes                        |
|                  | inner              | Yes                      | Yes                        |
|                  | management-backend | No                       | Yes                        |
|                  | openapi            | No                       | Yes                        |
|                  | websocket          | No                       | Yes                        |
| forethought-kodo | kodo               | Yes                      | Yes                        |
|                  | kodo-inner         | Yes                      | Yes                        |
|                  | kodo-x             | Yes                      | Yes                        |
|                  | kodo-asynq-client  | Yes                      | Yes                        |
|                  | kodo-x-backuplog   | Yes                      | Yes                        |
|                  | kodo-x-scan        | Yes                      | No                         |

- Configure `Deployment Annotations` in the corresponding applications, no changes needed below

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
            # Supports regex, multiple configurations can be set, meeting any one of them is sufficient
            # If empty, no filtering is performed
            # metric_name_filter = ["cpu"]

            ## Metric set name prefix
            # Configuring this item adds a prefix to the metric set name
            measurement_prefix = ""

            ## Metric set name
            # By default, the metric name is split by underscore "_", the first field after splitting becomes the metric set name, the remaining fields become the current metric name
            # If measurement_name is configured, the metric name will not be split
            # The final metric set name will have the measurement_prefix added as a prefix
            # measurement_name = "prom"

            ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
            interval = "10s"

            ## Filter tags, multiple tags can be configured
            # Matching tags will be ignored
            # tags_ignore = ["xxxx"]

            ## TLS Configuration
            tls_open = false
            # tls_ca = "/tmp/ca.crt"
            # tls_cert = "/tmp/peer.crt"
            # tls_key = "/tmp/peer.key"

            ## Custom metric set names
            # Metrics containing the prefix can be grouped into one metric set
            # Custom metric set name configuration takes precedence over measurement_name configuration
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
     The above only enables log collection. To perform **slicing** on the logs' status, you need to configure the corresponding **Pipeline**.
    

#### Use Pipeline to Slice Logs

**Import Pipeline template with one click on the interface**

[Pipeline Download Address](Pipelines 模板.json)

![pipeline001](img/self-pipeline001.jpg)


   

### Configure APM

???+ "Prerequisites"

     1. Your HOST must have [DataKit installed](<<< homepage >>>/datakit/datakit-install/) 
    
     2. And enable the [ddtrace collector on DataKit](../integrations/ddtrace.md), injecting it via K8S `ConfigMap`.

**Start Configuration**

- Modify the Deployment configuration under the forethought-core Namespace

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
        env:                     ## Enable DDtrace collection, add the following content (including services under the forethought-kodo Namespace in the table)
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
     There are multiple services under the **forethought-core** namespace that can be enabled. If you see all arg defaults in yaml files need to be enabled.

- Page Display

![img](<<< homepage >>>/application-performance-monitoring/img/9.apm_explorer_1.png)

### Configure Synthetic Tests

1) Create a new website to monitor

  ![boce1](img/self-boce1.jpg)

2) Configure the Synthetic Testing task

  ![boce2](img/self-boce2.jpg)

???+ warning "Note"
     Modify according to the actual domain name settings

| Name                | Synthetic Testing Address                                                       | Type | Task Status | Operation                                                         |
| ------------------- | ----------------------------------------------------------------------------- | ---- | ----------- | ----------------------------------------------------------------- |
| cn4-console-api     | https://cn4-console-api.<<< custom_key.brand_main_domain >>>                           | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-auth            | https://cn4-auth.<<< custom_key.brand_main_domain >>>                                  | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-openway         | https://cn4-openway.<<< custom_key.brand_main_domain >>>                               | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-static-res      | https://cn4-static-res.<<< custom_key.brand_main_domain >>>/dataflux-template/README.md | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-console         | https://cn4-<<< custom_key.studio_main_site >>>                               | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |
| cn4-management-api  | https://cn4-management-api.<<< custom_key.brand_main_domain >>>                        | HTTP | Start       | ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAUCAYAAAD/Rn+7AAAAAXNSR0IArs4c6QAAA59JREFUSEutll9sFFUUxr8zs/23ZKUUSjRAFAnQBU0Wuq1pin0gxqTEaOtCytqYPmiiYvyHJBiTtYI0vAASEhpCJSGVPrQqxLYKBJJCCG7dbRHbIoTQbo1arIBotEg7c+8xd+i2SzqbsLM7mcnM3NzzzW/OyT33IyQ5Sr/f6BdMLxJzKZgWgzAXoCyA1eUCiOxCmXl6OP6oxggMCRMEgxkGgFsAYkQUEcTHLpa3Ru30ZnzEH64tB+QeAKXJ4JONz4BTYPdOuLUclM3xwffQchRmz4HJAqPjtxD5qx+9f/8EAyKiMzb3VLSdT9S/D7CkO/gBM3YA0DMBp/hc0PHygudQt+gFeFxuW9nrd2+gcbgV3944J0hDqHdN2874xCnA4u6XQsS8PVWw+Pyp7Kl0MYMlY7buwa4V72N1vveBZNuvd6HhWhMEZH1vRavFYgE+1V37rIA8Ab73nuphB5cFFw48GYIvvygluaMjp9Ew2KR+s/JCRdtJQtsG3b/QdRWEx1NSSphsAcYzp+5C4o1Ha/DqYwFHklsGdqHrz8jQhVEsI393MADGl46UrGpOLlV1k2y955MHnWX7kafnOJIdHvsNgeh7YJ3WU3E4eISAWkdKiYAKTrIFWTV/LULe151KWnG10a24MjbcQv5w8BqAJU7V7iuvgjQlGoreRuUjTzuVtOI+vdqMz0c6B1WJ/wVjllO1KcDJDEpT4jPfxyguWOlU0opr+bkTu4eaxzIGaJVXSEhDomnVNvjnpgd4JNaBPTEFmKESTwFOCDR438G6hRVpZXD35cNoUSXOyCJRXSaewQmBqsK1qPe9mRZg8NwWXBmPtWSmzSQCGhKzTTeOP3MQea5cR5Cxf35F1dm3oOfq69Nu1HaLRN4xsGlJEK95axwBvhveia7b0aG+da5laW91dm1Gjgtod4FDa3Zg1bwVKUF+MXgCnww0spaTXflj5Vcnp83Cd8GPiLAtJbUkjVqtZPmfCY90Y2/Zh/DPf+KBZI/FTmH7D40QWVzf//zX02YhHu3EbtltdapZxyF1g1C3tAqveDfAk23fbkfG/sC+/mZ888sZoWXpob7q9pl2Kw7pxLDamQUpGDwhoMotJwTclIPyh4uxet5KFOYVQLCJ3+/cRHj0InpuDkCQjLCmbb4UaE9uWBPrUHK+pkTqWjUxlYJ4MTBp+Xmm5bezW2pPtiBNCVaQpmQ2pUkMQ4INYmX5KQaNotDp6KVAh63l/x/CLxkxSh9tAgAAAABJRU5ErkJggg==) |

### Configure RUM

1) Deploy a DataKit in Deployment status

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
          value: http://internal-dataway.utils:9528?token=xxxxxx    ## Modify the token here
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
        image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit:1.5.0
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
        image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/iploc:1.0
        imagePullPolicy: IfNotPresent
        name: init-volume
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /usr/local/datakit/data/iploc/
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

2) Modify the `ConfigMap` configuration named config.js for the forethought-webclient service

???+ warning "Note"
     All inner-app domain names below should be modified to the actual corresponding domain names

```shell
window.DEPLOYCONFIG = {
    cookieDomain: '.<<< custom_key.brand_main_domain >>>',
    apiUrl: 'https://cn4-console-api.<<< custom_key.brand_main_domain >>>',
    wsUrl: 'wss://.<<< custom_key.brand_main_domain >>>',
    innerAppDisabled: 0,
    innerAppLogin: 'https://cn4-auth.<<< custom_key.brand_main_domain >>>/redirectpage/login',
    innerAppRegister: 'https://cn4-auth.<<< custom_key.brand_main_domain >>>/redirectpage/register',
    innerAppProfile: 'https://cn4-auth.<<< custom_key.brand_main_domain >>>/redirectpage/profile',
    innerAppCreateworkspace: 'https://cn4-auth.<<< custom_key.brand_main_domain >>>/redirectpage/createworkspace',
    staticFileUrl: 'https://cn4-static-res.<<< custom_key.brand_main_domain >>>',
    staticDatakit: 'https://static.<<< custom_key.brand_main_domain >>>',
    cloudDatawayUrl: '',
    isSaas: '1',
    showHelp: 1,
    rumEnable: 1,                                                                              ## 0 means off, 1 means on, enable it here
    rumDatakitUrl: "",                                                                         ## Modify to the deployment datakit address
    rumApplicationId: "",                                                                      ## Modify to the actual appid
    rumJsUrl: "https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js",
    rumDataEnv: 'prod',
    shrineApiUrl: '',
    upgradeUrl: '',
    rechargeUrl: '',
    paasCustomLoginInfo: []
};
```

3) Modify the ConfigMap configuration named dataway-config under utils

```yaml
token: xxxxxxxxxxx       ## Modify to the actual token
```

### Import Views and Monitor Templates

[Application Service Monitoring Template Download Address](pro_resource.zip)

- **Import Template**

![allin](img/self-allin.jpg)

???+ warning "Note"
     After importing, modify the corresponding jump link configurations in the **monitor**. Replace dsbd_xxxx with the corresponding dashboard and wksp_xxxx with the monitored workspace.

## Func Self-Observability (Optional)

### Func Task Log Data Reporting

The function execution logs and automatic trigger configurations of DataFlux Func can be directly reported to <<< custom_key.brand_name >>>. Follow the steps shown in the figure below:

![allin](img/self-func.png)


Fill in the DataWay/OpenWay address and Token information in the <<< custom_key.brand_name >>> data reporting section, as follows:

```shell
https://openway.<<< custom_key.brand_main_domain >>>?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

> *Note: If Func data reporting fails, you can check the [DataFlux Func documentation](https://<<< custom_key.func_domain >>>/doc/ui-guide-management-module-system-setting/){:target="_blank"}*


## Verification Method

- Check if there are any data on the dashboards in the scenario
- Check if there is any related information from DataKit enabled HOSTs in the infrastructure
- Check if the metrics contain MySQL, Redis, etc., database metric data
- Check if there are any logs and if the corresponding statuses are enabled
- Check if APM has RUM data