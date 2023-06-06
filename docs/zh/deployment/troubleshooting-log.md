# 日志、链路问题排查

## 简介

本文将介绍如何排查观测云的日志、链路的无数据、延迟等问题

## 架构图

为了方便排查问题，观测云数据流量为：

1. DataKit 将指标日志推送给观测云 DataWay 集群
2. DataWay 将数据推送到 kodo 服务处理数据
3. kodo 将处理完成的数据推送给 nsqd 消息队列服务
4. kodo-x 请求  nsqd 消息队列服务消费数据
5. kodo-x 将消费的数据推送给对应的存储引擎

![](img/faq-log-1.png)

## 无数据排查步骤

### 步骤一：检查集群主机的时间

登录机器时间是否正常：

```shell
date
```

### 步骤二：查看每个服务的运行状态

- 查看集群节点的状态是否正常

  ```shell
  kubectl get node
  ```

- 查看`forethought-kodo` 下的所有服务状态是否正常

  ```shell
  kubectl get pods -n forethought-kodo
  ```

- 查看 nsqd 服务状态是否正常

  ```shell
  kubectl get pods -n middleware | grep nsqd
  ```

- 查看存储引擎是否正常

  ```shell
  kubectl get pods -n middleware
  ```

### 步骤三：查看 DataWay 服务日志

请按照以下内容执行：

```shell
# 登录容器
kubectl exec -ti -n  <Namespace> <dataway pod name> bash
# 查看日志
cd /usr/local/cloudcare/dataflux/dataway
# 搜索错误日志
grep -Ei error log
```



### 步骤四：查看 kodo 服务日志

???+ warning "注意"
     查看 kodo 服务日志，可以排查观测云是否成功将数据推送消费队列中。

- Namespace: forethought-kodo

- Deployment: kodo

- Log path: /logdata/log

  

=== "kodo 服务正常"
    如果 kodo 服务正常，请按照以下内容执行：

    ```shell
    # 登录容器
    kubectl exec -ti -n  forethought-kodo <kodo pod name> bash
    # 查看日志
    cd /logdata
    # 搜索错误日志
    grep -Ei error log
    ```

=== "kodo 服务异常"

    如果 kodo 服务异常，您将会无法登录容器。您可以先调整 kodo 日志输出模式，再查看容器日志。

    - 修改 kodo 日志输出模式

      ```shell
      kubectl get configmap kodo -n forethought-kodo -o yaml | \
             sed "s/\/logdata\/log/stdout/g" | \
             kubectl apply -f -
      ```

    - 重启 kodo 容器

      ```shell
      kubectl rollout restart -n forethought-kodo deploy kodo 
      ```

    - 查看 kodo 容器日志

      ```shell
      kubectl logs -f -n forethought-kodo <kodo pod name>
      ```

### 步骤五：查看 kodo-x 服务日志

???+ warning "注意"
     查看 kodo-x 服务日志，可以排查观测云是否成功写入数据，以及是否写入日志限流，是否写入日志慢等问题。

- Namespace: forethought-kodo
- Deployment: kodo-x
- Log path: /logdata/log

=== "kodo-x 服务正常"
   
    如果 kodo-x 服务正常，请按照以下内容执行：

    ```shell
    # 登录容器
    kubectl exec -ti -n  forethought-kodo <kodo-x pod name> bash
    # 查看日志
    cd /logdata
    # 搜索错误日志
    grep -Ei error log
    ```

=== "kodo-x 服务异常"

    如果kodo 服务异常，您将会无法登录容器。您可以先调整 kodo 日志输出模式，再查看容器日志。

    - 修改 kodo 日志输出模式

      ```shell
      kubectl get configmap kodo-x -n forethought-kodo -o yaml | \
             sed "s/\/logdata\/log/stdout/g" | \
             kubectl apply -f -
      ```

    - 重启 kodo 容器

      ```shell
      kubectl rollout restart -n forethought-kodo deploy kodo-x
      ```

    - 查看 kodo 容器日志

      ```shell
      kubectl logs -f -n forethought-kodo <kodo-x pod name>
      ```

## 数据延迟排查步骤 

???+ warning "注意"
     nsqadmin 服务没有鉴权功能，使用后请关闭访问。
     
### 步骤一：开启 nsqdadmin 访问


=== "NodePort"
    请按照以下内容执行：

    - 设置 nsqadmin svc
      ```shell
      kubectl patch svc  nsqadmin -n middleware -p '{"spec": {"type": "ClusterIP"}}'
      ```
      
    - 查看端口
      ```shell
      kubectl get svc -n middleware nsqadmin
      ```
      ![](img/faq-log-2.png)

    - 查看主机 IP

      ```shell
      kubectl get node -o wide
      ```

    - 访问

    登录浏览访问 `http://node-ip:NodePort`
    ![](img/faq-log-3.png)

=== "Ingress"
    请按照以下内容执行：

    - 创建ingress
      注意修改域名

    ???- note "nsqadmin.yaml(单击点开)" 
         ```yaml hl_lines='8'
         apiVersion: networking.k8s.io/v1
         kind: Ingress
         metadata:
           name: nsqadmin
           namespace: middleware
         spec:
           rules:
             - host: xxxx.cloudcare.cn
               http:
                 paths:
                   - backend:
                       service:
                         name: nsqadmin
                         port:
                           number: 4171
                     path: /
                     pathType: ImplementationSpecific
         ```
    
    ```shell
    kubectl apply -f nsqadmin.yaml
    ```

### 步骤二：查看消息堆积

选择 `df_logging` 和 `df_metric` 查看日志和指标堆积情况。

![](img/faq-log-4.png)

depth 是反映消息堆积情况。请谨慎处理消费数据。

![](img/faq-log-6.png)

### 步骤三：关闭 nsqdadmin 访问

=== "NodePort"
    ```shell
    kubectl patch svc nsqadmin -n middleware  --type json   -p='[{"op": "remove", "path": "/spec/ports/0/nodePort"},{"op": "replace", "path": "/spec/type", "value":"ClusterIP"}]'
    ```

=== "Ingress"
    ```shell
    kubectl delete -f nsqadmin.yaml
    ```



 

