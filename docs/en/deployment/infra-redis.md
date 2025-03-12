# Redis Deployment


???+ warning "Note"

     Please make sure to change the Redis password


## Introduction {#intro}
|      |                                                                                                                          |
| ---------- |--------------------------------------------------------------------------------------------------------------------------|
| **Deployment Method**    | Kubernetes container deployment                                                                                                          |
| **Redis Version** | 6.0.20                                                                                                                   |       
| **Prerequisites** | [Kubernetes](infra-kubernetes.md#kubernetes-install) is deployed <br> [Kubernetes Storage](infra-kubernetes.md#kube-storage) is deployed |

## Default Configuration Information
|      |     |
| ---------- | ------- |
|   **Default Address**  | redis.middleware |
|   **Default Port**  | 6379 |
|   **Default Password**  | viFRKZiZkoPmXnyF |


## Installation {#install}

Save redis.yaml and deploy it.

???- note "redis.yaml (Click to expand)" 
    ```yaml
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: redis-config
      namespace: middleware
    data:
      redis.conf: |
        requirepass viFRKZiZkoPmXnyF
        appendonly yes
        timeout 300

    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: redis
      namespace: middleware
      labels:
        app: redis
    spec:
      selector:
        matchLabels:
          app: redis
      template:
        metadata:
          labels:
            app: redis
        spec:
          containers:
            - command:
                - redis-server
                - /usr/local/etc/redis/redis.conf
              name: redis
              image: pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/redis:6.0.20
              imagePullPolicy: IfNotPresent
              ports:
                - containerPort: 6379
                  name: redis-port
              volumeMounts:
                - name: data
                  mountPath: /data
                - name: config
                  mountPath: /usr/local/etc/redis
              resources:
                limits:
                  cpu: '4'
                  memory: 4Gi
                requests:
                  cpu: 100m
                  memory: 512Mi            
          volumes:
            - name: data
              emptyDir: {}
            - name: config
              configMap:
                name: redis-config
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: redis
      namespace: middleware
    spec:
      selector:
        app: redis
      type: NodePort
      ports:
        - name: redis-port
          protocol: TCP
          port: 6379
          targetPort: redis-port

    ```

Run the following commands to install:
```shell
kubectl create namespace middleware
kubectl apply -f redis.yaml
```

## Verify Deployment

- Check pod status

```shell
kubectl get pods -n middleware | grep redis
```


## How to Uninstall


```shell
kubectl delete -f redis.yaml
```