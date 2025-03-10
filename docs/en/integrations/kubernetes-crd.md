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

This document describes how to create a Datakit resource and configure extended collectors in a Kubernetes cluster.

### Add Authorization {#authorization}

If you are using an upgraded version of DataKit, you need to add authorization under the `apiVersion: rbac.authorization.k8s.io/v1` item in `datakit.yaml`, i.e., copy the following lines and add them to the end:

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

Write the following content into a YAML configuration, for example *datakit-crd.yaml*, where the meaning of each field is as follows:

- `k8sNamespace`: Specifies the namespace, which helps locate a set of Pods in conjunction with deployment. This is a required field.
- `k8sDaemonSet`: Specifies the DaemonSet name, which helps locate a set of Pods in conjunction with the namespace.
- `k8sDeployment`: Specifies the deployment name, which helps locate a set of Pods in conjunction with the namespace.
- `inputConf`: Collector configuration file, based on namespace and deployment to find the corresponding Pod, replace the wildcard information of the Pod, then run the collector according to the content of `inputConf`. The following wildcards are supported:
    - `$IP`: Internal IP of the Pod
    - `$NAMESPACE`: Namespace of the Pod
    - `$PODNAME`: Name of the Pod
    - `$NODENAME`: Name of the current node

Execute the command `kubectl apply -f datakit-crd.yaml`.

<!-- markdownlint-disable MD046 -->
???+ attention

    - DaemonSet and Deployment are two different Kubernetes resources, but here, `k8sDaemonSet` and `k8sDeployment` can coexist. That is, in the same Namespace, Pods created by DaemonSet and Pods created by Deployment share the same CRD configuration. However, this is not recommended because fields like `source` are used to identify data sources, and mixing them can lead to unclear data boundaries. It is suggested that only one of `k8sDaemonSet` or `k8sDeployment` exists in a single CRD configuration.

    - Datakit only collects Pods that reside on the same node as it does, performing local collection without crossing nodes.
<!-- markdownlint-enable -->

## Example {#example}

A complete example is provided below, including:

- Creating CRD Datakit
- Testing namespaces and Datakit instance objects
- Configuring the Prom collector (`inputConf`)

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

Here we use the DataKit CRD to extend the collection of Ingress metrics, i.e., collecting Ingress metrics through the prom collector.

#### Prerequisites {#nginx-requirements}

- [DaemonSet DataKit](../datakit/datakit-daemonset-deploy.md) has been deployed.
- If the `Deployment` name is `ingress-nginx-controller`, the YAML configuration would be as follows:

  ```yaml
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

- Create the Datakit resource

For detailed Prometheus configuration, refer to [this link](kubernetes-prom.md)

Execute the following `yaml`:

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

- Check the metrics collection status

Log in to the `Datakit pod` and execute the following command:

```bash
datakit monitor
```

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-crd-ingress.png){ width="800" }
  <figcaption> Ingress Data Collection </figcaption>
</figure>

You can also log in to the [Guance platform](https://www.guance.com/){:target="_blank"}, go to 【Metrics】-【Explorer】to view the metrics data.