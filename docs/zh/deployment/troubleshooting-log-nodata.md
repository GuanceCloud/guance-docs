# 数据断档问题排查

## 简介

本文将介绍如何排查{{{ custom_key.brand_name }}}的日志、链路、指标的数据断档问题。

## 架构图

{{{ custom_key.brand_name }}}数据流向如下：

1. DataKit 将指标日志推送给{{{ custom_key.brand_name }}} DataWay 集群
2. DataWay 将数据推送到 kodo 服务处理数据
3. kodo 将处理完成的数据推送给 nsqd 消息队列服务
4. kodo-x 请求  nsqd 消息队列服务消费数据
5. kodo-x 将消费的数据推送给对应的存储引擎

![](img/faq-log-1.png)

## 数据断档排查步骤


### 步骤一：检查主机的时间

请确认以下信息：

- {{{ custom_key.brand_name }}}集群主机时间和当前时间一致
- DataKit 采集器主机和当前时间一致

可执行命令查看：
```shell
date
```

如果主机时间和当前时间不一致，请按照以下方法修正：

=== "联网环境"
    ```shell
    # 安装 ntpdate
    yum install ntpdate -y

    # 同步本地时间
    ntpdate time.windows.com

    # 跟网络源做同步
    ntpdate cn.pool.ntp.org
    ```

=== "离线环境"
    ```shell
    sudo date -s "2022-01-01 10:30:00"
    ```
    > 注意修改时间

### 步骤二：采集器排查

可以参考[DataKit数据断档排查](../datakit/why-no-data.md)

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




### 步骤四：查看每个服务的运行状态

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



### 步骤五：查看 kodo 服务日志

???+ warning "注意"
     查看 kodo 服务日志，可以排查{{{ custom_key.brand_name }}}是否成功将数据推送消费队列中。

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

### 步骤六：查看 kodo-x 服务日志

???+ warning "注意"
     查看 kodo-x 服务日志，可以排查{{{ custom_key.brand_name }}}是否成功写入数据，以及是否写入日志限流，是否写入日志慢等问题。

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


 

