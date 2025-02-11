# Install Helm
---

## Install the Latest Helm Repository

**Prerequisites**: Kubernetes >= 1.14, Helm >= 3.0+.

```
$ helm -n datakit get values datakit-operator -a -o yaml > values.yaml
$ helm upgrade datakit-operator datakit-operator \
    --repo https://pubrepo.guance.com/chartrepo/datakit-operator \
    -n datakit \
    -f values.yaml
```

## Update Configuration File

The DataKit Operator configuration is in JSON format and is stored as a ConfigMap in Kubernetes, loaded into the container via environment variables.

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
              "DD_TAGS": "pod_name:$(POD_NAME),pod_namespace:$(POD_NAMESPACE),host:$(NODE_NAME)"
              "DD_SERVICE": "{fieldRef:metadata.labels['service']}",
            }
        },
        "logfwd": {
            "options": {
                "reuse_exist_volume": "false"
            },
            "images": {
                "logfwd_image": "pubrepo.guance.com/datakit/logfwd:1.28.1"
            }
        },
    }
}
```

Configuration parameters:

1. `service.name`: Service name;
2. `env`: Environment information for the application service;
3. `version`: Version number;
4. Custom DataKit listening address; if not set, it will follow the default address;
5. Set sampling rate: When enabled, this can reduce the actual amount of data generated; the range is from 0.0(0%) to 1.0(100%);
6. Collect Profiling data: When enabled, more runtime information about the application can be seen;
7. Enable JVM Metrics collection: Requires enabling the [statsd collector](../../../integrations/jvm.md) simultaneously.