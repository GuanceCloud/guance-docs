---
title     : 'Prometheus Push Gateway'
summary   : 'Enable Pushgateway API to receive Prometheus Metrics data'
tags:
  - 'External Data Integration'
  - 'PROMETHEUS'
__int_icon      : 'icon/pushgateway'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.31.0](../datakit/changelog.md#cl-1.31.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

The Pushgateway collector will open the corresponding API interface to receive Prometheus Metrics data.

## Configuration  {#config}

<!-- markdownlint-disable MD046 -->

=== "HOST Deployment"

    Navigate to the `conf.d/pushgateway` directory under the DataKit installation directory, copy `pushgateway.conf.sample`, and rename it to `pushgateway.conf`. An example is as follows:

    ```toml
        
    [[inputs.pushgateway]]
      ## Prefix for the internal routes of web endpoints. Defaults to empty.
      route_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is not empty, using this as measurement set name.
      # measurement_name = "prom_pushgateway"
    
      ## If job_as_measurement is true, use the job field for the measurement name.
      ## The measurement_name configuration takes precedence.
      job_as_measurement = false
    
      ## Keep Exist Metric Name.
      ## Split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      ## If the keep_exist_metric_name is true, keep the raw value for field names.
      keep_exist_metric_name = true
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure `ENV_DATAKIT_INPUTS`](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (needs to be added to `ENV_DEFAULT_ENABLED_INPUTS` as a default collector):

    - **ENV_INPUT_PUSHGATEWAY_ROUTE_PREFIX**
    
        Configure endpoints route prefix
    
        **Field Type**: String
    
        **Collector Configuration Field**: `route_prefix`
    
        **Example**: `/v1/pushgateway`
    
    - **ENV_INPUT_PUSHGATEWAY_MEASUREMENT_NAME**
    
        Configure Measurement set name
    
        **Field Type**: String
    
        **Collector Configuration Field**: `measurement_name`
    
    - **ENV_INPUT_PUSHGATEWAY_JOB_AS_MEASUREMENT**
    
        Whether to use the job tag value as the Measurement set name
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `job_as_measurement`
    
        **Default Value**: false
    
    - **ENV_INPUT_PUSHGATEWAY_KEEP_EXIST_METRIC_NAME**
    
        Whether to retain the original Prometheus field names, see [Kubernetes Prometheus doc](kubernetes-prom.md#measurement-and-tags)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_exist_metric_name`
    
        **Default Value**: true

<!-- markdownlint-enable -->

---

## Example {#example}

The Pushgateway collector adheres to the [Prometheus Pushgateway](https://github.com/prometheus/pushgateway?tab=readme-ov-file#prometheus-pushgateway) protocol, with some adjustments made for DataKit's collection features. Currently supported functions include:

- Receiving Prometheus text data and Protobuf data
- Specifying string labels and base64 labels in URLs
- Decoding gzip data
- Specifying Measurement set name

Below is a simple example deployed in a Kubernetes cluster:

- Enable the Pushgateway collector. Here we choose to enable it via environment variables in the Datakit YAML.

```yaml
    # ..other..
    spec:
      containers:
      - name: datakit
        env:
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,container,pushgateway  # Add pushgateway to enable the collector
    - name: ENV_INPUT_PUSHGATEWAY_ROUTE_PREFIX
      value: /v1/pushgateway               # Optional, specify endpoints route prefix; target route becomes "/v1/pushgateway/metrics"
    # ..other..
```

- Create a Deployment that generates Prometheus data and sends it to the Datakit Pushgateway API.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pushgateway-client
  labels:
    app: pushgateway-client
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pushgateway-client
  template:
    metadata:
      labels:
        app: pushgateway-client
    spec:
      containers:
      - name: client
        image: pubrepo.guance.com/base/curl
        imagePullPolicy: IfNotPresent
        env:
        - name: MY_NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: MY_POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: MY_POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: PUSHGATEWAY_ENDPOINT
          value: http://datakit-service.datakit.svc:9529/v1/pushgateway/metrics/job@base64/aGVsbG8=/node/$(MY_NODE_NAME)/pod/$(MY_POD_NAME)/namespace/$(MY_POD_NAMESPACE)
          ## job@base64 specifies the format as base64, generate the value 'aGVsbG8=' using the command `echo -n hello | base64`
        args:
        - /bin/bash
        - -c
        - >
          i=100;
          while true;
          do
            ## Periodically send data to the Datakit Pushgateway API using the cURL command
            echo -e "# TYPE pushgateway_count counter\npushgateway_count{name=\"client\"} $i" | curl --data-binary @- $PUSHGATEWAY_ENDPOINT;
            i=$((i+1));
            sleep 2;
          done
```

- On the Guance page, you can see the Metrics data where the Measurement set is `pushgateway` and the field is `count`.

## Measurement Set and Tags {#measurement-and-tags}

The Pushgateway collector does not add any tags.

There are two cases for naming the Measurement set:

1. Use the `measurement_name` configuration item to specify the Measurement set name
1. Use the job tag value as the Measurement set name
1. Split the data field name with an underscore `_`, use the first field after splitting as the Measurement set name, and the remaining fields as the current Metrics name