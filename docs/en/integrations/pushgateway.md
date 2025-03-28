---
title     : 'Prometheus Push Gateway'
summary   : 'Enable Pushgateway API to receive Prometheus metric data'
tags:
  - 'THIRD PARTY'
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

The Pushgateway collector will open the corresponding API interface to receive Prometheus metric data.

## Configuration  {#config}

<!-- markdownlint-disable MD046 -->

=== "Host Deployment"

    Navigate to the `conf.d/pushgateway` directory in the DataKit installation directory, copy `pushgateway.conf.sample` and rename it to `pushgateway.conf`. The example is as follows:

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

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector configuration through the [ConfigMap method injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by setting [`ENV_DATAKIT_INPUTS`](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (needs to be added as a default collector in `ENV_DEFAULT_ENABLED_INPUTS`):

    - **ENV_INPUT_PUSHGATEWAY_ROUTE_PREFIX**
    
        Prefix for the internal routes of web endpoints.
    
        **Type**: String
    
        **input.conf**: `route_prefix`
    
        **Example**: `/v1/pushgateway`
    
    - **ENV_INPUT_PUSHGATEWAY_MEASUREMENT_NAME**
    
        Set measurement name.
    
        **Type**: String
    
        **input.conf**: `measurement_name`
    
    - **ENV_INPUT_PUSHGATEWAY_JOB_AS_MEASUREMENT**
    
        Whether to use the job field for the measurement name.
    
        **Type**: Boolean
    
        **input.conf**: `job_as_measurement`
    
        **Default**: false
    
    - **ENV_INPUT_PUSHGATEWAY_KEEP_EXIST_METRIC_NAME**
    
        Whether to keep the raw field names for Prometheus, see [Kubernetes Prometheus doc](kubernetes-prom.md#measurement-and-tags)
    
        **Type**: Boolean
    
        **input.conf**: `keep_exist_metric_name`
    
        **Default**: true

<!-- markdownlint-enable -->

---

## Example {#example}

The Pushgateway collector follows the [Prometheus Pushgateway](https://github.com/prometheus/pushgateway?tab=readme-ov-file#prometheus-pushgateway) protocol, with some adjustments for DataKit's collection features. Currently, it supports the following functions:

- Receiving Prometheus text data and Protobuf data
- Specifying string labels and base64 labels in the URL
- Decoding gzip data
- Specifying metric set names

Below is a simple example deployed in a Kubernetes cluster:

- Enable the Pushgateway collector. Here, it's enabled as an environment variable in the Datakit YAML.

```yaml
    # ..other..
    spec:
      containers:
      - name: datakit
        env:
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,container,pushgateway  # Add pushgateway to enable the collector
        - name: ENV_INPUT_PUSHGATEWAY_ROUTE_PREFIX
          value: /v1/pushgateway               # Optional, specify endpoints route prefix, the target route will become "/v1/pushgateway/metrics"
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
        image: pubrepo.<<<custom_key.brand_main_domain>>>/base/curl
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
          ## job@base64 specifies that the format is base64, use the command `echo -n hello | base64` to generate the value 'aGVsbG8='
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

- The metric set seen on the <<<custom_key.brand_name>>> page is `pushgateway`, with the field being `count`.

## Metric Sets and Tags {#measurement-and-tags}

The Pushgateway collector does not add any tags.

There are two cases for naming metric sets:

1. Use the configuration option `measurement_name` to specify the metric set name.
1. Use the job field for the measurement name.
1. Split the data field names using an underscore `_`, where the first field after splitting becomes the metric set name, and the remaining fields become the current metric name.
