# Redis 部署


???+ warning "注意"

     请务必修改 Redis 密码


## 简介 {#intro}
|      |                                                                                                                          |
| ---------- |--------------------------------------------------------------------------------------------------------------------------|
| **部署方式**    | Kubernetes 容器部署                                                                                                          |
| **Redis 版本** | 6.0.20                                                                                                                   |       
| **部署前提条件** | 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> 已部署 [Kubernetes Storage](infra-kubernetes.md#kube-storage) |

## 部署默认配置信息
|      |     |
| ---------- | ------- |
|   **默认地址**  | redis.middleware |
|   **默认端口**  | 6379 |
|   **默认密码**  | viFRKZiZkoPmXnyF |


## 安装 {#install}

保存 redis.yaml ，并部署。

???- note "redis.yaml (单击点开)" 
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

执行命令安装：
```shell
kubectl create namespace middleware
kubectl apply -f redis.yaml
```

## 验证部署

- 查看 pod 状态

```shell
kubectl get pods -n middleware | grep redis
```


## 如何卸载


```shell
kubectl delete -f redis.yaml
```

