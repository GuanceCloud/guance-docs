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

This document describes how to create a Datakit resource and configure extended collectors within a Kubernetes cluster.

### Add Authorization {#authorization}

For upgraded versions of DataKit, authorization needs to be added under the `apiVersion: rbac.authorization.k8s.io/v1` section in `datakit.yaml`. Specifically, copy and add the following lines to the end:

```yaml
- apiGroups:
  - guance.com
  resources:
  - datakits
  verbs:
  - get
  - list
```

### Create v1beta1 DataKit Instances and DataKit Resource Objects {#create}

Write the following content into a YAML configuration file, for example *datakit-crd.yaml*. The meaning of each field is as follows:

- `k8sNamespace`: Specifies the namespace, which helps locate a set of Pods in conjunction with deployment. This is a required field.
- `k8sDaemonSet`: Specifies the DaemonSet name, which helps locate a set of Pods in conjunction with the namespace.
- `k8sDeployment`: Specifies the deployment name, which helps locate a set of Pods in conjunction with the namespace.
- `inputConf`: Configuration file for the collector. Based on the namespace and deployment, it finds the corresponding Pod, replaces wildcard information in the Pod, and then runs the collector based on the content of `inputConf`. The following wildcards are supported:
    - `$IP`: Internal IP of the Pod
    - `$NAMESPACE`: Namespace of the Pod
    - `$PODNAME`: Name of the Pod
    - `$NODENAME`: Name of the current node

Execute the command `kubectl apply -f datakit-crd.yaml`.

<!-- markdownlint-disable MD046 -->
???+ attention

    - DaemonSet and Deployment are two different Kubernetes resources, but here `k8sDaemonSet` and `k8sDeployment` can coexist. In the same Namespace, Pods created by DaemonSet and Pods created by Deployment share the same CRD configuration. However, this is not recommended because fields like `source` are used to identify data sources, and mixing them can lead to unclear data boundaries. It is suggested that only one of `k8sDaemonSet` or `k8sDeployment` exists in a single CRD configuration.

    - DataKit only collects data from Pods on the same node, adhering to a proximity collection principle without crossing nodes.
<!-- markdownlint-enable -->

## Example {#example}

The complete example includes:

- Creating a CRD for DataKit
- Test namespaces and DataKit instance objects
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

Here, we use the DataKit CRD to extend the collection of Ingress metrics, i.e., collecting Ingress metrics via the prom collector.

#### Prerequisites {#nginx-requirements}

- Deployed [DaemonSet DataKit](../datakit/datakit-daemonset-deploy.md)
- If the `Deployment` name is `ingress-nginx-controller`, the YAML configuration should be as follows:

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

- First, create the DataKit CustomResourceDefinition

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

- Create the DataKit resource

Refer to the detailed Prometheus configuration [here](kubernetes-prom.md).

Execute the following YAML:

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

- Check the metric collection status

Log into the `DataKit pod` and execute the following command:

```bash
datakit monitor
```

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-crd-ingress.png){ width="800" }
  <figcaption> Ingress Data Collection </figcaption>
</figure>

You can also log into the [Guance platform](https://www.guance.com/){:target="_blank"}, go to 【Metrics】-【Explorer】to view the metric data.