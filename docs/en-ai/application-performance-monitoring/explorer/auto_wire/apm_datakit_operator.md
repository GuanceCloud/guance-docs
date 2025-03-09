# Install Datakit Operator
---

## Concepts

| Field    | Description        |
| ----------- | ---------- |
| `namespaces`, `selectors`    | `enabled_namespaces` and `enabled_labelselectors` are specific to ddtrace. They are arrays of objects that require specifying `namespace` and `language`. The relationship between the arrays is "OR". Currently, only `java` is supported.<br />If a Pod matches both `enabled_namespaces` and `enabled_labelselectors`, the configuration in `enabled_labelselectors` takes precedence.        |


## Enable DDTrace Collector

Edit the datakit.yaml file and append DDTrace to the list of default enabled collectors.

```
 - name: ENV_DEFAULT_ENABLED_INPUTS
   value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
```

Restart the application:

```
kubectl apply -f datakit.yaml
```

## Install DataKit Operator

The Datakit Operator automates the deployment of applications and services, automatically injects the DDTrace SDK, and monitors them when they start.


Click to download the latest `datakit-operator.yaml` file:

```
$ kubectl create namespace datakit
$ wget https://<<< custom_key.static_domain >>>/datakit-operator/datakit-operator.yaml
```

### Update Configuration File

The Datakit Operator configuration is in JSON format and is stored as a ConfigMap in Kubernetes, loaded into the container as environment variables.


```
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": { 
           "enabled_namespaces":     [],
           "enabled_labelselectors": [],
           "images": {
                "java_agent_image":   "pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.30.1-guance"
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
                "logfwd_image": "pubrepo.guance.com/datakit/logfwd:1.28.1"
            }
        }
    }
}
```

Configuration parameters:

1. `service`: Service name;
2. `env`: Environment information for the application service;
3. Custom DataKit listening address; if not set, it follows the default address;
4. Collect Profiling data: When enabled, you can see more runtime information about the application;
5. Configure `namespaces`;
6. Configure `selectors`.

### Execute Installation Command

```
kubectl apply -f datakit-operator.yaml
```


## Restart Application

After installation is complete, restart the application Pod.