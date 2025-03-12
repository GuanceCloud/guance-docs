# 使用 datakit-operator 注入 dd-java-agent

---

## 简介

Kubernetes 环境在接入 Java 应用 APM 时，需要使用到 `dd-java-agent.jar` 包，为了不侵入应用的镜像，常用的方式是在部署应用的 yaml 中使用 initContainers，利用相同 Pod 中的容器共享存储的方式来使用 `dd-java-agent.jar`。使用这种方式就会出现，每个部署文件中都有相同的 initContainers 部分。

那么，是否可以把这些相同的部分提取出来，进一步减少工作量？答案是可以的，这就用到了<<< custom_key.brand_name >>>开源的[Admission Controller（准入控制器）](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/admission-controllers/)。[datakit-operator](https://github.com/GuanceCloud/datakit-operator)，向特殊 Pod 提供注入 dd-lib 文件和 environment 的功能，目前支持 java、python 和 js。

## 前置条件

- 您需要先创建一个[<<< custom_key.brand_name >>>账号](https://www.guance.com/)。
- 一个 Kubernetes 集群。
- 已使用[ DaemonSet 方式部署 DataKit](../../datakit/datakit-daemonset-deploy.md)，且已开通 ddtrace 采集器。

## 操作步骤

???+ warning

    本文示例所使用版本信息为：DataKit `1.5.2`、 Kubernetes `1.24`

### 1 部署 datakit-operator

下载 `datakit-operator.yaml`，并部署到 Kubernetes 集群中。

```
wget https://static.<<< custom_key.brand_main_domain >>>/datakit-operator/datakit-operator.yaml
kubectl apply -f datakit-operator.yaml
```

### 2 部署应用

#### 2.1 编写 Dockerfile

编写应用的 Dockerfile，这里主要把 JAVA_OPTS 暴露出来，方便在外部注入 javaagent 包。

```
FROM openjdk:8u292

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

ENV jar service-demo-1.0-SNAPSHOT.jar

ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar} ${PARAMS} "]

```

编写完成后，把镜像推送到仓库，下面直接使用 `172.16.0.246/df-demo/service-log-demo:v1` 拉取镜像。

#### 2.2 修改应用 yaml

在应用的 yaml 中添加 annotation。

```
      annotations:
        admission.datakit/java-lib.version: ""
```

#### 2.3 修改应用 yaml

声明 JAVA_OPTS 环境变量，应用已经能访问到自动注入的 `/datadog-lib/dd-java-agent.jar` 包，启动参数可参考 [javaagent 参数](../../integrations/ddtrace-java.md#start-options)，这里设置的服务名是 `java-demo-service`。

```
        - name: JAVA_OPTS
          value: |-
            -javaagent:/datadog-lib/dd-java-agent.jar -Ddd.service.name=java-demo-service -Ddd.tags=container_host:$(POD_NAME) -Ddd.env=dev -Ddd.agent.port=9529
```

??? quote "示例完整 `java-demo.yaml` "

    ```yaml
    apiVersion: v1
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: guance-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: guance-pod
      template:
        metadata:
          labels:
            app: guance-pod
          annotations:
            admission.datakit/java-lib.version: ""
        spec:
          containers:
          - name: guance-demo-container
            image: 172.16.0.246/df-demo/service-log-demo:v1
            env:
            - name: HOST_IP
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: status.hostIP
            - name: HOST_NAME
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: spec.nodeName
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            #- name: DD_AGENT_HOST
            #  valueFrom:
            #    fieldRef:
            #      apiVersion: v1
            #      fieldPath: status.hostIP
            - name: JAVA_OPTS
              value: |-
                -javaagent:/datadog-lib/dd-java-agent.jar -Ddd.service.name=java-demo-service -Ddd.tags=container_host:$(POD_NAME) -Ddd.env=dev -Ddd.agent.port=9529
            ports:
            - containerPort: 8090
              protocol: TCP
            volumeMounts:
            - mountPath: /data/app/logs
              name: varlog
          restartPolicy: Always
          volumes:
          - name: varlog
            emptyDir: {}


    ```

#### 2.4 部署应用

```
kubectl apply -f java-demo.yaml
```

### 3 链路上报

获取 pod 的 IP，访问应用的接口产生链路数据。

![image.png](../images/datakit-operator1.png)

登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」- 「应用性能监测」，根据服务器 java-demo-service，即可查询到链路。

![image.png](../images/datakit-operator2.png)
