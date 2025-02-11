# Install DataKit Operator
---

## Concept Explanation

| Field                    | Description                                                                                                                                                                                                 |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `namespaces`, `selectors` | `enabled_namespaces` and `enabled_labelselectors` are specific to ddtrace. They are arrays of objects that require specifying `namespace` and `language`. The relationship between arrays is "OR". Currently, only `java` is supported.<br />If a Pod matches both `enabled_namespaces` and `enabled_labelselectors`, the configuration in `enabled_labelselectors` takes precedence. |

## Install DataKit Operator

**Prerequisites**: Download datakit-operator.yaml; ensure you use the latest version of the `yaml` for installation. If an `InvalidImageName` error occurs, you can manually pull the image.

```
$ kubectl create namespace datakit
$ wget https://static.guance.com/datakit-operator/datakit-operator.yaml
$ kubectl apply -f datakit-operator.yaml
$ kubectl get pod -n datakit

NAME                               READY   STATUS    RESTARTS   AGE
datakit-operator-f948897fb-5w5nm   1/1     Running   0          15s
```

## Update Configuration File

The DataKit Operator configuration is in JSON format and is stored as a separate ConfigMap in Kubernetes, loaded into the container as environment variables.


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
              "DD_TAGS": "pod_name:$(POD_NAME),pod_namespace:$(POD_NAMESPACE),host:$(NODE_NAME)",
              "DD_SERVICE": "{fieldRef:metadata.labels['service']}"
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

1. `service.name`: Service name;
2. `env`: Environment information for the application service;
3. `version`: Version number;
4. Customize DataKit listening address; if not set, it follows the default address;
5. Collect Profiling data: Enable this to see more runtime information about the application;
6. Configure `namespaces`;
7. Configure `selectors`.