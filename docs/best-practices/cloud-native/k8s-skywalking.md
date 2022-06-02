# 简介
        在 Kubernetes 集群中，应用都是以镜像的方式来部署。在使用 SkyWalking 采集应用链路数据时，如果再按照传统的方式，把 SkyWalking 的 Agent 打入到每一个应用的镜像中再来部署，会造成镜像过于庞大，并且以后升级 SkyWalking 版本也不方便。本文介绍一种使用官方的 SkyWalking 镜像，以 initContainers 方式为应用提供 SkyWalking Agent 来采集链路数据。
# 前置条件
## 安装 DataKit

- <安装 [DataKit](https://www.yuque.com/dataflux/datakit/datakit-daemonset-deploy)>
- DataKit 接入版本 >=1.2.18
## 开启 Input 
        开通 Skywalking 采集器，即是在 DataKit 所在的服务器上增加 /usr/local/datakit/conf.d/skywalking/skywalking.conf 文件，在使用 DaemonSet 方式部署时，需要先定义 ConfigMap，再把文件挂载到 DataKit 容器中。接下来需要用到部署 DataKit 时用到的 datakit.yaml。
### 定义 skywalking.conf
        在 datakit.yaml 文件的 ConfigMap 资源中，增加 skywalking.conf 的定义。
```
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
          address = "0.0.0.0:13800"
```
### 挂载 skywalking.conf
        在 datakit.yaml 文件的 volumeMounts 下面新增如下内容。
```
        - mountPath: /usr/local/datakit/conf.d/skywalking/skywalking.conf
          name: datakit-conf
          subPath: skywalking.conf
```
### 重启 DataKit
```
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```
## Java 链路数据接入
### 编写测试应用
        示例用到 [datakit-springboot-demo](https://github.com/stevenliu2020/datakit-springboot-demo)，下载后制作成 jar，即 service-demo-1.0-SNAPSHOT.jar。
### 制作镜像
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
```
docker build -t 172.16.0.246/df-demo/service-demo:v1  .
docker push 172.16.0.246/df-demo/service-demo:v1
```

### 部署应用
        在应用部署的 skywalking-demo.yaml 文件中，使用 initContainers 初始化 apache/skywalking-java-agent:8.7.0-alpine 镜像 ，同 Pod 的应用即可访问到 skywalking-agent.jar，然后在 JAVA_OPTS 定义 jar 的启动命令，其中 -Dskywalking.agent.service_name=skywalking-demo-master 定义应用的别名是 skywalking-demo-master。      
```
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
                -javaagent:/skywalking/agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-demo-master  -Dskywalking.collector.backend_service=$(HOST_IP):13800           
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

```
kubectl apply -f skywalking-demo.yaml 
```
### 访问应用
        查看 pod 端口。<br />![1651915364(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1651915410598-1eba502c-8bca-49e6-af15-d6d31b9124dc.png#clientId=ub4e0bb42-1e6c-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=79&id=ub4d4a85a&margin=%5Bobject%20Object%5D&name=1651915364%281%29.png&originHeight=106&originWidth=1535&originalType=binary&ratio=1&rotation=0&showTitle=false&size=12035&status=done&style=none&taskId=u94c55b4c-338f-427e-b4c9-ed29e307279&title=&width=1137.0371173602293)<br />      调用应用，生成链路数据
```
curl 10.244.36.98:8090/ping
```
### 应用性能监测
         登录『[观测云](https://console.guance.com/)』，进入『应用性能监测』模块，查看 skywalking-demo-master 应用。<br />![1651915533(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1651915572267-91d64a05-d795-4f32-96fb-2ebc4ab57f0d.png#clientId=ub4e0bb42-1e6c-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u52bc9e09&margin=%5Bobject%20Object%5D&name=1651915533%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57618&status=done&style=none&taskId=uc59686ba-07bc-4f39-bc1d-332bd01bfbd&title=&width=1422.2223226916224)
