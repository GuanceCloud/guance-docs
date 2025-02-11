# Kubernetes Cluster Using ExternalName to Map DataKit Service

---

## Introduction

In a Kubernetes cluster, after deploying DataKit as a DaemonSet, if an application previously pushed trace data to the zipkin service in the istio-system namespace on port 9411, i.e., the access address was `zipkin.istio-system.svc.cluster.local:9411`.

What if you do not want to change the push address? This is where the Kubernetes ExternalName service type comes into play. By following these two steps, the application can be connected to DataKit:

- First, define a ClusterIP service type to forward port 9529 to 9411.

- Second, use an ExternalName service to map the ClusterIP service to a DNS name.

### Step 1: Define a ClusterIP Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: datakit-service-ext
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - protocol: TCP
      port: 9411
      targetPort: 9529
```

After deployment, containers within the cluster can access DataKit's port 9529 using `datakit-service-ext.datakit.svc.cluster.local:9411`.

### Step 2: Define an ExternalName Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: zipkin
  namespace: istio-system
spec:
  type: ExternalName
  externalName: datakit-service-ext.datakit.svc.cluster.local
```

After deployment, containers within the cluster can push data to DataKit using `zipkin.istio-system.svc.cluster.local:9411`.

![1647908754(1).png](../images/kubernetes-external-name-1.png)