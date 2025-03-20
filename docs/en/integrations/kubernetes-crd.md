---
title     : 'Kubernetes CRD'
summary   : 'Create Datakit CRD to collect'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

:material-kubernetes:

---

[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

## Introduction {#intro}

**This feature is deprecated in Datakit 1.63.0.**

This document describes how to create a Datakit resource in the Kubernetes cluster and configure the extended collector.

### Add Authorization {#authorization}

If it's an upgraded version of DataKit, you need to add authorization under the `apiVersion: rbac.authorization.k8s.io/v1` item in the `datakit.yaml`, i.e., copy the following lines and add them to the end:

```yaml
- apiGroups:
  - guance.com
  resources:
  - datakits
  verbs:
  - get
  - list
```

### Create v1beta1 DataKit Instance and DataKit Object {#create}

Write the following content into the yaml configuration, for example *datakit-crd.yaml*. The meaning of each field is as follows:

- `k8sNamespace`: Specifies the namespace, used with deployment to locate a set of Pods; this is a required field.
- `k8sDaemonSet`: Specifies the DaemonSet name, used with the namespace to locate a set of Pods.
- `k8sDeployment`: Specifies the deployment name, used with the namespace to locate a set of Pods.
- `inputConf`: Collector configuration file, which finds the corresponding Pod based on the namespace and deployment, replaces the Pod wildcard information, and then runs the collector according to the inputConf content. It supports the following wildcards:
    - `$IP`: Internal network IP of the Pod.
    - `$NAMESPACE`: Namespace of the Pod.
    - `$PODNAME`: Name of the Pod.
    - `$NODENAME`: Name of the current node.

Execute the command `kubectl apply -f datakit-crd.yaml`.

<!-- markdownlint-disable MD046 -->
???+ attention

    - DaemonSet and Deployment are two different Kubernetes resources, but here, both `k8sDaemonSet` and `k8sDeployment` can coexist. That is, in the same Namespace, the Pods created by DaemonSet and the Pods created by Deployment share the same CRD configuration. However, this is not recommended because fields like `source` are used in specific configurations to identify data sources, and mixing them will make the data boundaries unclear. It is suggested that in the same CRD configuration, only one of `k8sDaemonSet` and `k8sDeployment` exists.

    - Datakit only collects Pods that are on the same node, belonging to nearby collection, and does not cross nodes for collection.
<!-- markdownlint-enable -->

## Example {#example}

The complete example is as follows, including:

- Create CRD Datakit
- Test namespaces and Datakit instance objects used
- Configure Prom collector (`inputConf`)

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: datakits.guance.com
spec:
  group: guance.com
  versions:
  - name: v1beta1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              instances:
                type: array
                items:
                  type: object
                  properties:
                    k8sNamespace:
                      type: string
                    k8sDaemonSet:
                      type: string
                    k8sDeployment:
                      type: string
                    datakit/logs:
                      type: string
                    inputConf:
                      type: string
  scope: Namespaced
  names:
    plural: datakits
    singular: datakit
    kind: Datakit
    shortNames:
    - dk
---
apiVersion: v1
kind: Namespace
metadata:
  name: datakit-crd
---
apiVersion: "guance.com/v1beta1"
kind: Datakit
metadata:
  name: my-test-crd-object
  namespace: datakit-crd
spec:
  instances:
    - k8sNamespace: "testing-namespace"
      k8sDaemonSet: "testing-daemonset"
      inputConf: |
        [inputs.prom]
          url="http://prom"
```

### NGINX Ingress Configuration Example {#example-nginx}

Here we use the DataKit CRD extension to collect Ingress metrics, i.e., collecting Ingress metrics through the prom collector.

#### Prerequisites {#nginx-requirements}

- [DaemonSet DataKit](../datakit/datakit-daemonset-deploy.md) has been deployed.
- If the `Deployment` name is `ingress-nginx-controller`, then the yaml configuration is as follows:

  ``` yaml
  ...
  spec:
    selector:
      matchLabels:
        app.kubernetes.io/component: controller
    template:
      metadata:
        creationTimestamp: null
        labels:
          app: ingress-nginx-controller  # This is just an example name
  ...
  ```

#### Configuration Steps {#nginx-steps}

- First, create the Datakit CustomResourceDefinition

Execute the following creation command:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: datakits.guance.com
spec:
  group: guance.com
  versions:
    - name: v1beta1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                instances:
                  type: array
                  items:
                    type: object
                    properties:
                      k8sNamespace:
                        type: string
                      k8sDeployment:
                        type: string
                      datakit/logs:
                        type: string
                      inputConf:
                        type: string
  scope: Namespaced
  names:
    plural: datakits
    singular: datakit
    kind: Datakit
    shortNames:
    - dk
EOF
```

Check the deployment status:

```bash
kubectl get crds | grep guance.com

datakits.guance.com   2022-08-18T10:44:09Z
```

- Create Datakit Resource

For detailed Prometheus configuration, refer to [link](kubernetes-prom.md)

Execute the following `yaml` :

```yaml
apiVersion: guance.com/v1beta1
kind: DataKit
metadata:
  name: prom-ingress
  namespace: datakit
spec:
  instances:
    - k8sNamespace: ingress-nginx
      k8sDeployment: ingress-nginx-controller
      inputConf: |-
        [[inputs.prom]]
          url = "http://$IP:10254/metrics"
          source = "prom-ingress"
          metric_types = ["counter", "gauge", "histogram"]
          measurement_name = "prom_ingress"
          interval = "60s"
          tags_ignore = ["build","le","method","release","repository"]
          metric_name_filter = ["nginx_process_cpu_seconds_total","nginx_process_resident_memory_bytes","request_size_sum","response_size_sum","requests","success","config_last_reload_successful"]
        [[inputs.prom.measurements]]
          prefix = "nginx_ingress_controller_"
          name = "prom_ingress"
        [inputs.prom.tags]
          namespace = "$NAMESPACE"
```

> !!! Note that `namespace` can be customized, while `k8sDeployment` and `k8sNamespace` must be accurate.

Check the deployment status:

```bash
$ kubectl get dk -n datakit
NAME           AGE
prom-ingress   18m
```

- Check Metrics Collection Status

Log into the `Datakit pod` and execute the following command:

```bash
datakit monitor
```

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-crd-ingress.png){ width="800" }
  <figcaption> Ingress Data Collection </figcaption>
</figure>

You can also log into the [Guance Platform](https://www.guance.com/){:target="_blank"}, go to 【Metrics】-【Explorer】to view the metrics data.