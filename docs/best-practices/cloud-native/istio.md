---

# Istio
## Service Mesh 是什么
        过去几年，微服务在软件应用中迅速普及，大型应用被分解成多个微服务，虽然每个微服务能通过容器化在单独的容器中运行，但是服务间通信的网络拓扑仍然非常复杂。既然微服务之间网络通信非常重要，具备通过实现多个服务代理，确保受控的服务到服务之间通信通道安全、健壮的基础组件就非常有必要。<br />        服务网格 ( Service Mesh )是用来描述组成这些应用程序的微服务网络以及它们之间的交互。单个服务调用，表现为 Sidecar。如果有大量的服务，就会表现出来网格，下图绿色方格代表应用微服务，蓝色方格代表 Sidecar，线条表示服务之间的调用关系，Sidecar 之间的连接就会形成一个网络。<br />![](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634882767192-8a05229d-8e8a-40ac-9548-1a07c2a546b5.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&id=Gs8Ai&margin=%5Bobject%20Object%5D&originHeight=279&originWidth=432&originalType=url&ratio=1&rotation=0&showTitle=false&status=done&style=none&taskId=u6c6e0e25-ecf6-47c0-94f6-cc183e40e26&title=)
## Istio简介 
        Istio 是一个开源服务网格，它透明地分层到现有的分布式应用程序上。 提供了对整个服务网格的行为洞察和操作控制的能力，以及一个完整的满足微服务应用各种需求的解决方案。
## Istio核心组件
       Istio 服务网格由数据平面和控制平面组成。

- 数据平面由一组智能代理（Envoy）组成，Envoy 被部署为 sidecar ，微服务之间 Sidecar 的通信是通过策略控制和遥测收集（Mixer）实现。
- 在控制平面负责管理和配置代理来路由流量。Citadel 通过内置身份和凭证管理可以提供强大的服务间和最终用户身份验证。Pilot 用于为 Envoy sidecar 提供服务发现，智能路由（例如 A/B 测试、金丝雀部署等）、流量管理和错误处理（超时、重试和熔断）功能。Galley 是 Istio 配置验证、获取、处理和分发组件。

![](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634886235645-e7e66111-d71f-4464-ab54-190ebe7af2eb.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&id=u09258a2d&margin=%5Bobject%20Object%5D&originHeight=529&originWidth=680&originalType=url&ratio=1&rotation=0&showTitle=false&status=done&style=none&taskId=u7a45b6ad-5f49-4415-a27a-691af7b4140&title=)
## Istio 链路追踪
        Envoy 原生支持 Jaeger，追踪所需 x-b3 开头的 Header (x-b3-traceid， x-b3-spanid, x-b3-parentspanid， x-b3-sampled， x-b3-flags）和 x-request-id 在不同的服务之间由业务逻辑进行传递，并由 Envoy 上报给 Jaeger，最终 Jaeger 生成完整的追踪信息。<br />        在 Istio 中，Envoy 和 Jaeger 的关系如下：

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634887053676-ba8cb841-682d-410d-8bcb-a0f7b2e26a20.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=280&id=uba01c100&margin=%5Bobject%20Object%5D&name=image.png&originHeight=560&originWidth=970&originalType=binary&ratio=1&rotation=0&showTitle=false&size=33700&status=done&style=none&taskId=uece13843-b4fc-4c76-b7c4-633e1ff2da8&title=&width=485)

        图中 Front [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) 指的是第一个接收到请求的 [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) [Sidecar](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#sidecar)，它会负责创建 Root Span 并追加到请求 Header 内，请求到达不同的服务时，[Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy) [Sidecar](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#sidecar) 会将追踪信息进行上报。<br />        Envoy 链路追踪原生支持 Jaeger，Envoy 支持集成外部追踪服务，支持 zipkin、zipkin兼容的后端( jaeger )。Istio 链路追踪提供全局配置 zipkinAddress, [Envoy](https://www.servicemesher.com/istio-handbook/GLOSSARY.html#envoy)的上报地址通过 proxy_init 的 --zipkinAddress 参数传入。
## Istio 可观测性
        Istio 健壮的追踪、监控和日志特性让您能够深入的了解服务网格部署。通过 Istio 的监控能力，可以真正的了解到服务的性能是如何影响上游和下游的；而它的定制 Dashboard 提供了对所有服务性能的可视化能力，并让您看到它如何影响其他进程。所有这些特性都使您能够更有效地设置、监控和加强服务的 SLO。
## BookInfo 简介
        这个示例部署了一个用于演示多种 Istio 特性的应用，该应用由四个单独的微服务构成。这个应用模仿在线书店的一个分类，显示一本书的信息。页面上会显示一本书的描述，书籍的细节（ISBN、页数等），以及关于这本书的一些评论。<br />Bookinfo 应用程序分为四个单独的微服务：

- productpage：productpage (python) 微服务调用 details 和 reviews 微服务来填充页面。
- details：details (ruby) 微服务包含图书的详细信息。
- reviews：reviews (java) 微服务包含书评，它还调用 ratings微服务。
- ratings：ratings (node js) 微服务包含书的排名信息。

reviews 微服务提供了3个版本：

- 版本 v1 不调用 ratings 服务。
- 版本 v2 调用 ratings 服务，并将每个等级显示为 1 到 5 个黑星。
- 版本 v3 调用 ratings 服务，并将每个等级显示为 1 到 5 个红色星号。

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634890297923-d115adc5-a6f2-4314-9664-4b75dd26ce15.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=287&id=uc9a917c4&margin=%5Bobject%20Object%5D&name=image.png&originHeight=574&originWidth=832&originalType=binary&ratio=1&rotation=0&showTitle=false&size=96553&status=done&style=none&taskId=uab26b6b3-79a4-4a11-b98a-5393e686d51&title=&width=416)<br />        Bookinfo 的链路数据，只需要修改 istio 的 configmap 中 zipkin.address 为 datakit 地址，datakit 需要开启zipkin 采集器，即能实现链路数据 push 到 datakit。<br />![1634892270.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634892489461-5af288b3-bfd1-409a-a358-ea3f37c98689.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=253&id=u8afe967e&margin=%5Bobject%20Object%5D&name=1634892270.png&originHeight=506&originWidth=1112&originalType=binary&ratio=1&rotation=0&showTitle=false&size=19104&status=done&style=none&taskId=u2d7c3cec-9489-48c3-af77-48b64af755b&title=&width=556)
# 环境部署
## 前置条件
### Kubernetes 
        本示例在 CentOS7.9 通过 minikube 创建的版本是 1.21.2 的 kubernetes 集群。
### 部署datakit 
        参考< [Daemonset 部署 Datakit](https://www.yuque.com/dataflux/integrations/kubernetes) >。
### 开启采集器 
        使用 [Daemonset 部署 Datakit](https://www.yuque.com/dataflux/integrations/kubernetes)  的 datakit.yaml 文件，上传到 kubernetes 集群 的 master 节点 /usr/local/df-demo/datakit.yaml，修改 datakit.yaml 文件，增加 ConfigMap 并挂载文件来开通 zipkin 和 prom 采集器，最终结果是部署完成的 DataKit，增加文件 /usr/local/datakit/conf.d/zipkin/zipkin.conf  是开通 zipkin 采集器，增加 /usr/local/datakit/conf.d/prom/prom_istiod.conf 文件是开通 Istiod pod 的指标采集器。<br />![1647919207(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647919219957-8240aacd-d571-4468-8269-5b78b9648788.png#clientId=u20656fe3-dbcf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=89&id=u8d7bb57f&margin=%5Bobject%20Object%5D&name=1647919207%281%29.png&originHeight=100&originWidth=783&originalType=binary&ratio=1&rotation=0&showTitle=false&size=10138&status=done&style=none&taskId=uc574a4c5-05bd-4189-90c5-b402d581764&title=&width=696)<br />        下面是 datakit.yaml 文件的修改部分。

- ConfigMap 增加
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:    
    zipkin.conf: |-
      [[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
  
    prom_istiod.conf: |-    
      [[inputs.prom]] 
        url = "http://istiod.istio-system.svc.cluster.local:15014/metrics"
        source = "prom-istiod"
        metric_types = ["counter", "gauge", "histogram"]
        interval = "10s"
        #measurement_prefix = ""
        measurement_name = "istio_prom"
        #[[inputs.prom.measurements]]
        # prefix = "cpu_"
        # name ="cpu"
        [inputs.prom.tags]
          app_id="istiod"
```

- 挂载 zipkin.conf 和 prom_istiod.conf
```
apiVersion: apps/v1
kind: DaemonSet
...
spec:
  template
    spec:
      containers:
      - env:
        volumeMounts: # 下面是新增部分
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
        - mountPath: /usr/local/datakit/conf.d/prom/prom_istiod.conf
          name: datakit-conf
          subPath: prom_istiod.conf
```
### 替换 token
登录[观测云](https://console.guance.com/)，【集成】->【Datakit】复制 token，替换到 datalit.yam l中的 <your-token>。<br />![3.jpg](https://cdn.nlark.com/yuque/0/2021/jpeg/21583952/1635328116924-9dc258bf-d30b-47e2-a461-22b4c6ad5187.jpeg#clientId=u052b2413-3847-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=ub05c8d00&margin=%5Bobject%20Object%5D&name=3.jpg&originHeight=738&originWidth=1258&originalType=binary&ratio=1&rotation=0&showTitle=false&size=81604&status=done&style=none&taskId=ue79c6b67-4217-415c-95bb-0f3291cfd3a&title=)<br />![1651050694(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1651050747417-75e1fc96-e799-4b85-8adf-c06ae3df3f5b.png#clientId=uff4c41f4-bebb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=103&id=u3e3a45e2&margin=%5Bobject%20Object%5D&name=1651050694%281%29.png&originHeight=139&originWidth=752&originalType=binary&ratio=1&rotation=0&showTitle=false&size=11381&status=done&style=none&taskId=u49aa6cc5-bd9c-4da2-be3c-8aee040495c&title=&width=557.0370763875521)
### 重新部署 Datakit 
```
cd /usr/local/df-demo
kubectl apply -f datakit.yaml
```
## ![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634893247880-daac8d5a-2f3b-4968-aef6-39758a15bd3c.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=56&id=u30b50dee&margin=%5Bobject%20Object%5D&name=image.png&originHeight=111&originWidth=680&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51943&status=done&style=none&taskId=ud4b3f2fe-f02c-4cb5-87c6-49f98eba518&title=&width=340)
## 部署 Istio
### 下载 Istio
        [下载](https://github.com/istio/istio/releases ) **Source Code **和 **istio-1.11.2-linux-amd64.tar.gz**，
### 安装 Istio
上传 istio-1.11.2-linux-amd64.tar.gz 到 /usr/local/df-demo/ 目录，查看 kubernetes 所在服务器的内网地址是_**172.16.0.15 **_所，请替换 _**172.16.0.15 **_为您的 ip。
```
su minikube
cd /usr/local/df-demo/
tar zxvf istio-1.11.2-linux-amd64.tar.gz  
cd /usr/local/df-demo/istio-1.11.2
export PATH=$PWD/bin:$PATH$ 
cp -ar /usr/local/df-demo/istio-1.11.2/bin/istioctl /usr/bin/

istioctl install --set profile=demo 

```
### 验证安装
部署成功后，ingressgateway、egressgateway、istiod 会处于 Running 状态。
```
kubectl get pods -n istio-system 
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1634896963255-04a00725-9076-45de-96d1-33e3fb0c9a27.png#clientId=udf376454-5ced-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=78&id=u65c82dbc&margin=%5Bobject%20Object%5D&name=image.png&originHeight=156&originWidth=1060&originalType=binary&ratio=1&rotation=0&showTitle=false&size=120997&status=done&style=none&taskId=ud08deb8a-659c-4e7f-a9e5-36256b45f71&title=&width=530)
## 部署 BookInfo
### 文件拷贝
解压源码，拷贝 /usr/local/df-demo/istio-1.11.2/samples/bookinfo/src/productpage 目录到 /usr/local/df-demo/bookinfo 目录。拷贝部署 bookInfo 需要的 yaml。
```
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/networking/bookinfo-gateway.yaml /usr/local/df-demo/bookinfo/bookinfo-gateway.yaml
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml /usr/local/df-demo/bookinfo/virtual-service-ratings-test-delay.yaml
cp /usr/local/df-demo/istio-1.11.2/samples/bookinfo/platform/kube/bookinfo.yaml /usr/local/df-demo/bookinfo/bookinfo.yaml
```

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635129974850-ca1a0ff1-ed55-4cc9-a955-89dedbecf557.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=68&id=uc6c8ee4f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=135&originWidth=911&originalType=binary&ratio=1&rotation=0&showTitle=false&size=17334&status=done&style=none&taskId=u64433389-46d7-4514-8285-1774c489776&title=&width=455.5)
### 开启自动注入
新建 prod 命名空间，开启该空间下创建 Pod 时自动注入 Sidecar，让 Pod 的出入流量都转由 Sidecar 进行处理。 
```
kubectl create namespace prod
kubectl label namespace prod istio-injection=enabled

```
### 开启 RUM

- 1  登录[观测云](https://console.guance.com/)->【用户访问监测】->【新建应用】->输入bookinfo，复制 js 到 /usr/local/df-demo/bookinfo/productpage/templates/productpage.html，并修改<DATAKIT ORIGIN> 为

      http://<your-外网ip>:9529。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635132977213-0e154e79-645c-413c-8ec2-8cc399284bb8.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=359&id=u44e3bdd5&margin=%5Bobject%20Object%5D&name=image.png&originHeight=717&originWidth=1266&originalType=binary&ratio=1&rotation=0&showTitle=false&size=89419&status=done&style=none&taskId=u27a07532-673d-4920-b599-808dfb1504a&title=&width=633)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635132760059-ac0c0f07-5e23-4cdc-ba1f-cb35a2476546.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=196&id=ufdcbf59e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=392&originWidth=1161&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47335&status=done&style=none&taskId=u36767ae8-0c60-4964-b0db-22bfc755b83&title=&width=580.5)

- 2  修改 /usr/local/df-demo/bookinfo/productpage/Dockerfile

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635133293477-e8d590f4-9c5e-4be9-9bc4-559314d34342.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=251&id=ue6e5ae28&margin=%5Bobject%20Object%5D&name=image.png&originHeight=502&originWidth=1113&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53065&status=done&style=none&taskId=u8e1d3cf0-667d-43e1-90cd-b33d5ddffd8&title=&width=556.5)

- 3  制作镜像
```
cd /usr/local/df-demo/bookinfo/productpage
eval $(minikube docker-env)
docker build -t product-page:v1  .
```

- 4  替换镜像

替换 /usr/local/df-demo/bookinfo/bookinfo.yaml 中的 image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2 为 **image: product-page:v1**。<br />![2.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635328669007-65220424-4472-46b7-b1cb-315118c271d5.png#clientId=u052b2413-3847-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=u9aa9121c&margin=%5Bobject%20Object%5D&name=2.png&originHeight=763&originWidth=942&originalType=binary&ratio=1&rotation=0&showTitle=false&size=35052&status=done&style=none&taskId=u93fae521-f599-4a6a-bb6d-ee7a0ae8bde&title=)

### 打通 APM 和 Datakit

```
kubectl edit configmap istio -n istio-system -o yaml 
```
![1648002743(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648004376014-8b91d852-5984-47c0-a9b6-bb9465f6a396.png#clientId=u34f486e5-055f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=595&id=uc779a373&margin=%5Bobject%20Object%5D&name=1648002743%281%29.png&originHeight=669&originWidth=1316&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56848&status=done&style=none&taskId=u6e7f0b89-c494-45ca-a311-85726078285&title=&width=1169.7777777777778)<br />        在上图中，可以看到链路数据默认推送到 zipkin.istio-system:9411 这个地址。由于 DataKit 服务的名称空间是 datakit，端口是 9529，所以这里需要做一下转换，详情请参考[Kubernetes 集群使用 ExternalName 映射 DataKit 服务](https://www.yuque.com/dataflux/bp/external-name)。
### 增加 namespace
修改 bookinfo 的 yaml，所有资源的 metadata 下增加 namespace: prod
```
vi /usr/local/df-demo/bookinfo/bookinfo.yaml
vi /usr/local/df-demo/bookinfo/bookinfo-gateway.yaml
vi /usr/local/df-demo/bookinfo/virtual-service-ratings-test-delay.yaml
```
### ![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635140678035-d9160efd-55a7-49a5-b2c5-cc3e0916c39d.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=299&id=ubacdc70b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=597&originWidth=496&originalType=binary&ratio=1&rotation=0&showTitle=false&size=31544&status=done&style=none&taskId=ue6ee082a-bb28-4175-b7a6-6fe97e1b714&title=&width=248)
### 开启 Pod 自定义采集
修改 bookinfo.yaml
```
vi /usr/local/df-demo/bookinfo/bookinfo.yaml
```
在所有 Deployment 控制器，pod 模板上增加 annotations。<br />参数说明

- url：Exporter 地址
- source：采集器名称
- metric_types：指标类型过滤
- measurement_name：采集后的指标集名称
- interval：采集指标频率，s秒
- $IP：通配 Pod 的内网 IP
- $NAMESPACE：Pod所在命名空间
- $PODNAME:  Pod名称
```
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-product"
            metric_types = ["counter", "gauge"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"

```
### ![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635137463871-c5b6d0af-0f21-4a0b-a921-99065f88144d.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=380&id=ue515a33b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=760&originWidth=623&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53721&status=done&style=none&taskId=u6619fbf7-0fc7-4eef-83ba-ec08149bb79&title=&width=311.5)
完整 bookinfo.yaml。
```
apiVersion: v1
kind: Service
metadata:
  name: details
  namespace: prod
  labels:
    app: details
    service: details
spec:
  ports:
  - port: 9080
    name: http
  selector:
    app: details
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: bookinfo-details
  namespace: prod
  labels:
    account: details
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: details-v1
  namespace: prod
  labels:
    app: details
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: details
      version: v1
  template:
    metadata:
      labels:
        app: details
        version: v1
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-details"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
    spec:
      serviceAccountName: bookinfo-details
      containers:
      - name: details
        image: docker.io/istio/examples-bookinfo-details-v1:1.16.2
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9080
        securityContext:
          runAsUser: 1000
---
##################################################################################################
# Ratings service
##################################################################################################
apiVersion: v1
kind: Service
metadata:
  name: ratings
  namespace: prod
  labels:
    app: ratings
    service: ratings
spec:
  ports:
  - port: 9080
    name: http
  selector:
    app: ratings
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: bookinfo-ratings
  namespace: prod
  labels:
    account: ratings
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ratings-v1
  namespace: prod
  labels:
    app: ratings
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ratings
      version: v1
  template:
    metadata:
      labels:
        app: ratings
        version: v1
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-ratings"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
    spec:
      serviceAccountName: bookinfo-ratings
      containers:
      - name: ratings
        image: docker.io/istio/examples-bookinfo-ratings-v1:1.16.2
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9080
        securityContext:
          runAsUser: 1000
---
##################################################################################################
# Reviews service
##################################################################################################
apiVersion: v1
kind: Service
metadata:
  name: reviews
  namespace: prod
  labels:
    app: reviews
    service: reviews
spec:
  ports:
  - port: 9080
    name: http
  selector:
    app: reviews
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: bookinfo-reviews
  namespace: prod
  labels:
    account: reviews
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v1
  namespace: prod
  labels:
    app: reviews
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: v1
  template:
    metadata:
      labels:
        app: reviews
        version: v1
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-review1"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-v1:1.16.2
        imagePullPolicy: IfNotPresent
        env:
        - name: LOG_DIR
          value: "/tmp/logs"
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: wlp-output
          mountPath: /opt/ibm/wlp/output
        securityContext:
          runAsUser: 1000
      volumes:
      - name: wlp-output
        emptyDir: {}
      - name: tmp
        emptyDir: {}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v2
  namespace: prod
  labels:
    app: reviews
    version: v2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: v2
  template:
    metadata:
      labels:
        app: reviews
        version: v2
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-review2"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-v2:1.16.2
        imagePullPolicy: IfNotPresent
        env:
        - name: LOG_DIR
          value: "/tmp/logs"
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: wlp-output
          mountPath: /opt/ibm/wlp/output
        securityContext:
          runAsUser: 1000
      volumes:
      - name: wlp-output
        emptyDir: {}
      - name: tmp
        emptyDir: {}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v3
  namespace: prod
  labels:
    app: reviews
    version: v3
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: v3
  template:
    metadata:
      labels:
        app: reviews
        version: v3
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-review3"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-v3:1.16.2
        imagePullPolicy: IfNotPresent
        env:
        - name: LOG_DIR
          value: "/tmp/logs"
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: wlp-output
          mountPath: /opt/ibm/wlp/output
        securityContext:
          runAsUser: 1000
      volumes:
      - name: wlp-output
        emptyDir: {}
      - name: tmp
        emptyDir: {}
---
##################################################################################################
# Productpage services
##################################################################################################
apiVersion: v1
kind: Service
metadata:
  name: productpage
  namespace: prod
  labels:
    app: productpage
    service: productpage
spec:
  ports:
  - port: 9080
    name: http
  selector:
    app: productpage
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: bookinfo-productpage
  namespace: prod
  labels:
    account: productpage
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage-v1
  namespace: prod
  labels:
    app: productpage
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: productpage
      version: v1
  template:
    metadata:
      labels:
        app: productpage
        version: v1
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "minik8s-istio-product"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
    spec:
      serviceAccountName: bookinfo-productpage
      containers:
      - name: productpage
        #image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2
        image: image: product-page:v1
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        securityContext:
          runAsUser: 1000
      volumes:
      - name: tmp
        emptyDir: {}
---

```
完整 bookinfo-gateway.yaml。
```
kind: Gateway
metadata:
  name: bookinfo-gateway
  namespace: prod
spec:
  selector:
    istio: ingressgateway # use istio default controller
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo
  namespace: prod
spec:
  hosts:
  - "*"
  gateways:
  - bookinfo-gateway
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        prefix: /static
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        prefix: /api/v1/products
    route:
    - destination:
        host: productpage
        port:
          number: 9080

```
### 部署服务
```
cd /usr/local/df-demo/bookinfo
kubectl apply -f bookinfo.yaml
kubectl apply -f bookinfo-gateway.yaml
```
### nginx 代理 productpage服务
       由于本示例使用 minikube，通过 nginx 代理集群内服务，所以要配置一下 nginx。

- 查看 minikube http2 的 url：
```
minikube service istio-ingressgateway -n istio-system
```
![97B25EA3-B06C-4f6f-8B9A-81C9A8DAC06B.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635139337608-b5e802f5-e901-45b5-b407-1b6e34a051c0.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=222&id=uec4f3793&margin=%5Bobject%20Object%5D&name=97B25EA3-B06C-4f6f-8B9A-81C9A8DAC06B.png&originHeight=444&originWidth=990&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37001&status=done&style=none&taskId=u877f1705-e5b1-4768-ac0b-42f7d01905c&title=&width=495)

- root 账号登录服务器，修改 proxy_pass为http2 的服务地址
```
vim  /etc/nginx/nginx.conf
```
![F982C9B1-37C6-4a68-AEBB-E94F1A346916.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635139559815-6ceef578-6a3d-4865-8a43-fc9cf02a7fa2.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=147&id=ufad69d53&margin=%5Bobject%20Object%5D&name=F982C9B1-37C6-4a68-AEBB-E94F1A346916.png&originHeight=293&originWidth=871&originalType=binary&ratio=1&rotation=0&showTitle=false&size=16645&status=done&style=none&taskId=u825579b5-d443-4db3-8104-47b548f2859&title=&width=435.5)

- 重启 nginx
```
systemctl restart nginx
```
### 访问 productpage
[http://121.43.225.226/productpage](http://121.43.225.226/productpage)
# 可观测演练
## 指标 (Metrics)
部署 BookInfo 时，开启 Pod 自定义采集时，配置了 measurement_name = "istio_prom"。登录【观测云】->【指标】，查看 istio_prom 指标集。<br />![1635151270(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635151277660-c6321a8d-2044-4a30-813f-d9cacf0f12d5.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=421&id=uf7453b9d&margin=%5Bobject%20Object%5D&name=1635151270%281%29.png&originHeight=842&originWidth=1909&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69977&status=done&style=none&taskId=u3f53c7c1-e489-4e5b-be86-7f9ebff2a3f&title=&width=954.5)
## 链路 (Traces)
### RUM
通过用户访问监测模块，查看 UV、PV、会话数、访问的页面等信息。<br />![1635151480(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635151507006-12287627-6440-45d3-bc78-da0e8eaf9918.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=457&id=u32e76992&margin=%5Bobject%20Object%5D&name=1635151480%281%29.png&originHeight=913&originWidth=1897&originalType=binary&ratio=1&rotation=0&showTitle=false&size=145299&status=done&style=none&taskId=uf672ffc4-b93c-481a-8d13-18e2226cdc4&title=&width=948.5)<br />![1635151950(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635151959126-e8c059b1-820e-4843-b02d-0da41d7a7908.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=438&id=u868110a8&margin=%5Bobject%20Object%5D&name=1635151950%281%29.png&originHeight=876&originWidth=1860&originalType=binary&ratio=1&rotation=0&showTitle=false&size=118535&status=done&style=none&taskId=u3faa1f8f-5f29-451d-a07f-d5e25d74678&title=&width=930)
### APM
通过应用性能监测，查看链路数据。<br />![1635152126(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635152132752-662755ed-cf69-4df9-8d1e-fc03af5e648c.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=350&id=u8c390249&margin=%5Bobject%20Object%5D&name=1635152126%281%29.png&originHeight=700&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68544&status=done&style=none&taskId=u1dd82793-e3e4-4230-bd88-f7c826d7671&title=&width=954)

![1635152272(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635152278445-c268b1cb-8807-4604-8705-117677902b34.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=401&id=uaf9eb3b4&margin=%5Bobject%20Object%5D&name=1635152272%281%29.png&originHeight=801&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&size=123408&status=done&style=none&taskId=u942910bf-321e-4b1e-8a4b-eb3e57e9251&title=&width=954)
## 日志 (logs)
### stdout
datakit 默认采集输出到 /dev/stdout 的日志，如果需要使用更深层的功能，请参考<[容器日志采集](https://www.yuque.com/dataflux/datakit/container#6a1b31bb)>。<br />![1635152731(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635152737592-4d9854e8-ac98-49b4-ae34-09f39839d87e.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=395&id=u91db9d5f&margin=%5Bobject%20Object%5D&name=1635152731%281%29.png&originHeight=790&originWidth=1917&originalType=binary&ratio=1&rotation=0&showTitle=false&size=143016&status=done&style=none&taskId=u322e0b7e-8378-4a0b-ae81-1f35d857302&title=&width=958.5)
### log文件
本示例未涉及到日志文件的采集，如需要请参考<[开启 log 采集](https://www.yuque.com/dataflux/bp/k8s-rum-apm-log#j8FFp)>
## 链路超时分析

- 执行 virtual-service-ratings-test-delay.yaml 
```
cd /usr/local/df-demo/bookinfo
kubectl apply -f virtual-service-ratings-test-delay.yaml 
```

- 使用 jason 登录，密码为空，访问 productpage 界面

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635141618658-c5451357-96e6-40c7-91ff-0fcf5d80a8df.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=412&id=u65d68a28&margin=%5Bobject%20Object%5D&name=image.png&originHeight=823&originWidth=1907&originalType=binary&ratio=1&rotation=0&showTitle=false&size=146055&status=done&style=none&taskId=u594dfc9f-fec0-445f-9737-56462f43ef5&title=&width=953.5)

- 点击超时的链路，观测火焰图，找出超时调用。

![1635150640(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635150698156-817dfb8f-dca3-457e-9c74-9f3876d60e25.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=382&id=ud4a6ced4&margin=%5Bobject%20Object%5D&name=1635150640%281%29.png&originHeight=764&originWidth=1769&originalType=binary&ratio=1&rotation=0&showTitle=false&size=98817&status=done&style=none&taskId=u7f0ff883-2f3e-4e8d-87e7-22b2e1136e0&title=&width=884.5)<br />![1635150665(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635150706305-6633bdf4-7bca-4b84-9029-d0b4ed777012.png#clientId=ue8d8e77c-4b29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=440&id=u9cbd1a7c&margin=%5Bobject%20Object%5D&name=1635150665%281%29.png&originHeight=880&originWidth=1488&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61721&status=done&style=none&taskId=u9184153f-2dc6-4e40-825a-5bfeb2343d5&title=&width=744)


