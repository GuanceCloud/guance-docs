# Install Helm
---


## Enable DDTrace Collector

Edit the `datakit.yaml` file and append `ddtrace` to the default enabled collectors configuration.

```
 - name: ENV_DEFAULT_ENABLED_INPUTS
   value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
```

After configuration is complete, restart DataKit:

```
kubectl apply -f datakit.yam
```


## Helm Install DataKit Operator

**Prerequisites**: Kubernetes >= 1.14, Helm >= 3.0+.

```
$ helm install datakit-operator datakit-operator \
     --repo  https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/datakit-operator \
     -n datakit --create-namespace
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

Parameter configurations:

1. `service`: Service name;
2. `env`: Application service environment information;
3. Custom DataKit listener address; if not set, it will follow the default address;
4. Set sampling rate: After enabling, this can reduce the actual amount of generated data; the number range is from 0.0(0%) ~ 1.0(100%);
5. Collect Profiling data: After enabling, more runtime information about the application can be seen;
6. Enable JVM Metrics collection: Requires simultaneous activation of the [statsd collector](../../../integrations/jvm.md).


### Execute Installation Command

```
kubectl apply -f datakit-operator.yaml
```


## Restart Application


After installation is complete, simply restart the application Pod.