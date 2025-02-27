# Kubernetes 集群 应用使用 SkyWalking 采集链路数据

---

## 简介

在 Kubernetes 集群中，应用都是以镜像的方式来部署。在使用 SkyWalking 采集应用链路数据时，如果再按照传统的方式，把 SkyWalking 的 Agent 打入到每一个应用的镜像中再来部署，会造成镜像过于庞大，并且以后升级 SkyWalking 版本也不方便。本文介绍一种使用官方的 SkyWalking 镜像，以 initContainers 方式为应用提供 SkyWalking Agent 来采集链路数据。

## 前置条件

### 安装 DataKit

- <安装 [DataKit](../../datakit/datakit-daemonset-deploy.md)>
- DataKit 接入版本 >=1.4.15

### 开启 Input 

开通 Skywalking 采集器，即是在 DataKit 所在的服务器上增加 /usr/local/datakit/conf.d/skywalking/skywalking.conf 文件，在使用 DaemonSet 方式部署时，需要先定义 ConfigMap，再把文件挂载到 DataKit 容器中。接下来需要用到部署 DataKit 时用到的 datakit.yaml。

#### 定义 skywalking.conf

在 datakit.yaml 文件的 ConfigMap 资源中，增加 skywalking.conf 的定义。

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:  
    ## 下面是新增内容
    skywalking.conf: |- 
        [[inputs.skywalking]]
          ## skywalking grpc server listening on address
          address = "0.0.0.0:11800"
```

#### 挂载 skywalking.conf

在 datakit.yaml 文件的 volumeMounts 下面新增如下内容。

```yaml
        - mountPath: /usr/local/datakit/conf.d/skywalking/skywalking.conf
          name: datakit-conf
          subPath: skywalking.conf
```

#### 重启 DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

### Java 链路数据接入

#### 编写测试应用

示例用到 [datakit-springboot-demo](https://github.com/stevenliu2020/datakit-springboot-demo)，下载后制作成 jar，即 service-demo-1.0-SNAPSHOT.jar。

#### 制作镜像

编写 Dockerfile。

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

制作镜像并上传到镜像仓库。

```shell
docker build -t 172.16.0.246/df-demo/service-demo:v1  .
docker push 172.16.0.246/df-demo/service-demo:v1
```

#### 部署应用

在应用部署的 skywalking-demo.yaml 文件中，使用 initContainers 初始化 apache/skywalking-java-agent:8.7.0-alpine 镜像 ，同 Pod 的应用即可访问到 skywalking-agent.jar，然后在 JAVA_OPTS 定义 jar 的启动命令，其中 -Dskywalking.agent.service_name=skywalking-demo-master 定义应用的别名是 skywalking-demo-master。      

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: skywalking-demo-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: skywalking-demo-pod
  template:
    metadata:
      labels:
        app: skywalking-demo-pod
      annotations:
    spec:
      containers:
      - name: skywalking-demo-demo-container
        image: 172.16.0.246/df-demo/service-demo:v1
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
        - name: JAVA_OPTS
          value: |-
                -javaagent:/skywalking/agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-demo-master  -Dskywalking.collector.backend_service=$(HOST_IP):11800           
        ports:
        - containerPort: 8090
          protocol: TCP
        volumeMounts:
        - mountPath: /skywalking
          name: skywalking-agent
      initContainers:
        - name: agent-container
          image: apache/skywalking-java-agent:8.7.0-alpine
          volumeMounts:
            - name: skywalking-agent   
              mountPath: /agent
          command: [ "/bin/sh" ]
          args: [ "-c", "cp -R /skywalking/agent /agent/" ]  
      restartPolicy: Always
      volumes:
        - name: skywalking-agent
          emptyDir: {}
```

```shell
kubectl apply -f skywalking-demo.yaml 
```

#### 访问应用

查看 pod 端口。

![image](../images/k8s-skywalking/1.png)	

调用应用，生成链路数据

```shell
curl 10.244.36.98:8090/ping
```

#### 应用性能监测

登录『[{{{ custom_key.brand_name }}}](https://console.guance.com/)』，进入『应用性能监测』模块，查看 skywalking-demo-master 应用。

![image](../images/k8s-skywalking/2.png)	
