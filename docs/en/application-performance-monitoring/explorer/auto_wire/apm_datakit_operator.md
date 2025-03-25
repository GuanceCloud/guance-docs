# Install Datakit Operator
---

## Concepts

| Field    | Description        |
| ----------- | ---------- |
| `namespaces`, `selectors`    | `enabled_namespaces` and `enabled_labelselectors` are exclusive to ddtrace. They are arrays of objects that require specifying `namespace` and `language`. The relationship between the arrays is "OR". Currently, only the `java` language is supported.<br />If a Pod satisfies both the `enabled_namespaces` rule and the `enabled_labelselectors`, the configuration of `enabled_labelselectors` will take precedence.        |


## Enable DDTrace Collector

Modify the datakit.yaml file and append DDTrace to the default enabled collector configurations.

```
 - name: ENV_DEFAULT_ENABLED_INPUTS
   value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
```

Restart the application:

```
kubectl apply -f datakit.yam
```

## Install DataKit Operator

The Datakit Operator can automate the deployment of applications and services, automatically inject the DDTrace SDK, and monitor them when they start.


Click to download the latest `datakit-operator.yaml` file:

```
$ kubectl create namespace datakit
$ wget https://static.<<< custom_key.brand_main_domain >>>/datakit-operator/datakit-operator.yaml
```

### Update Configuration File

The Datakit Operator configuration is in JSON format, stored separately as a ConfigMap in Kubernetes, and loaded into the container via environment variables.


```
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": { 
           "enabled_namespaces":     [],
           "enabled_labelselectors": [],
           "images": {
                "java_agent_image":   "pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init:v1.30.1-guance"
            },
            "envs": {
              "DD_JMXFETCH_STATSD_HOST": "datakit-service.datakit.svc",
              "DD_JMXFETCH_STATSD_PORT": "8125",
              "POD_NAME": "{fieldRef:metadata.name}",
              "POD_NAMESPACE": "{fieldRef:metadata.namespace}",
              "NODE_NAME": "{fieldRef:spec.nodeName}",
              "DD_SERVICE": "{fieldRef:metadata.labels['app']}",
              "DD_TAGS": "pod_name:$(POD_NAME),pod_namespace:$(POD_NAMESPACE),host:$(NODE_NAME)"
            }
        },
        "logfwd": {
            "options": {
                "reuse_exist_volume": "false"
            },
            "images": {
                "logfwd_image": "pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd:1.28.1"
            }
        }
    }
}
```

Parameter configuration:

1. `service`: Service name;
2. `env`: Environmental information for the application service;
3. Custom DataKit listener address; if not set, it will follow the default address;
4. Collect Profiling data: After enabling, more runtime information about the application can be seen;
5. Configure `namespaces`;
6. Configure `selectors`.

### Execute Installation Command

```
kubectl apply -f datakit-operator.yaml
```


## Restart Application

After installation is complete, simply restart the application Pod.