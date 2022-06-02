# 简介
        随着以 Istio 为代表的服务网格的流行，阿里云也推出了全托管式的服务网格平台-阿里云服务网格（Alibaba Cloud Service Mesh，简称ASM），ASM 兼容社区 Istio 开源服务网格，用于简化服务的治理，包括服务调用之间的流量路由与拆分管理、服务间通信的认证安全以及网格可观测性能力。<br /> 	ASM 的可观测能力是一种开放式的设计，既可以通过阿里的 arms + sls，也可以通过开源的 zipkin，因为观测云是兼容 zipkin 的， 所以观测云可以一站式的把 ASM 相关的指标链路日志，关联起来放在一起观测。而且观测云的 DataKit 既可以通过 daemonSet 的方式部署，也可以作为集群内的 Service，自身具有强大的处理能力，比如自动关联指标日志链路，对 tracing 的数据进行上报之前的预处理， 相对阿里自身的方案和开源的方案，具有更强的灵活性和功能。<br />本文以阿里云 ASM 可观测最佳实践 [https://help.aliyun.com/document_detail/176527.html](https://help.aliyun.com/document_detail/176527.html) 为参照，开源项目 BookInfo 为例，换用观测云来实现部署在 ASM 平台的 BookInfo 微服务的可观测。

# 前置条件

- 已创建一个 ACK 集群。如果没有创建，请参见[创建 Kubernetes 专有版集群](https://help.aliyun.com/document_detail/86488.htm#task-skz-qwk-qfb)和[创建 Kubernetes 托管版集群](https://help.aliyun.com/document_detail/95108.htm#task-skz-qwk-qfb)。
- 已创建一个 ASM 实例。如果没有创建，请参见[创建 ASM 实例](https://help.aliyun.com/document_detail/147793.htm#task-2370657)。**注意**，创建新网格时，请选择**自行搭建 Zipkin**。

![1647931621(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647931634808-330c3277-3763-4983-b448-cd9edf236e3b.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=620&id=ua7dd0b54&margin=%5Bobject%20Object%5D&name=1647931621%281%29.png&originHeight=698&originWidth=923&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52369&status=done&style=none&taskId=u093485c2-7af7-4551-b2c9-7e9ed4ff498&title=&width=820.4444444444445)

# 操作步骤
# 步骤一 添加集群到 ASM 

1. 登录 [ASM 控制台](https://servicemesh.console.aliyun.com/)。
1. 在左侧导航栏，选择**服务网格 > 网格管理**。
1. 在**网格管理**页面，找到待配置的实例，单击实例的名称或在**操作**列中单击**管理**。

![1647931998(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647932002461-44bbda8e-851c-4b08-a74c-c20ce7c8f808.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=643&id=ufe465bba&margin=%5Bobject%20Object%5D&name=1647931998%281%29.png&originHeight=723&originWidth=1903&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103334&status=done&style=none&taskId=ubd6aa68e-37fd-4699-836e-e6cab15e67b&title=&width=1691.5555555555557)

4. 在网格详情页面左侧导航栏选择**集群与工作负载管理 > Kubernetes 集群**，然后在右侧页面单击**添加**。
4. 在**添加集群**面板，选中需要添加的集群，然后单击**确定**。

![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647932064611-6c25bf95-c9f8-4be7-ac8a-1bc9a8757b3c.png#crop=0&crop=0&crop=1&crop=1&from=url&id=hclsl&margin=%5Bobject%20Object%5D&originHeight=831&originWidth=1917&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

# 步骤二 创建入口网关

1. 登录 [ASM 控制台](https://servicemesh.console.aliyun.com/)。
1. 在左侧导航栏，选择**服务网格 > 网格管理**。
1. 在**网格管理**页面，找到待配置的实例，单击实例的名称或在**操作**列中单击**管理**。
1. 在网格详情页面左侧导航栏单击 **ASM 网关**，然后在右侧页面单击**创建**。

![1647932756(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647932807348-0a84519d-2bb0-4a67-a3e3-6b8a70d18ca9.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=665&id=u07ba1e54&margin=%5Bobject%20Object%5D&name=1647932756%281%29.png&originHeight=748&originWidth=1308&originalType=binary&ratio=1&rotation=0&showTitle=false&size=29042&status=done&style=none&taskId=uaac223a5-512f-4b6c-9751-e3a78c20b83&title=&width=1162.6666666666667)<br />![1647932782(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647932814713-94c68492-09a4-4a48-ab94-06002d06d901.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=684&id=u544269f1&margin=%5Bobject%20Object%5D&name=1647932782%281%29.png&originHeight=770&originWidth=1309&originalType=binary&ratio=1&rotation=0&showTitle=false&size=23631&status=done&style=none&taskId=u4eb0ff2c-8c80-4681-9884-ac200544647&title=&width=1163.5555555555557)

         输入上述信息后，点击**创建**，需要耐心等待几分钟，创建完成后界面如下图，其中 IP 地址 [120.55.180.137](https://cs.console.aliyun.com/?spm=5176.13895322.0.0.3bbf5fcf9WxLGC#/k8s/cluster/cfdf5e2c69f6149c3a853df5f22754499/v2/service/detail/istio-system/istio-ingressgateway?ns=istio-system) 就是应用的入口地址，后面会使用到。![1647932693(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647932699336-f7bcf19e-fc3c-4ff0-b2bb-4599e8441a57.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=773&id=uc30641d9&margin=%5Bobject%20Object%5D&name=1647932693%281%29.png&originHeight=870&originWidth=1913&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71056&status=done&style=none&taskId=u0258704b-fc8a-4b2c-80ba-1342280a297&title=&width=1700.4444444444443)
# 步骤三  开通 Sidecar 注入 

1. 登录[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)。
1. 在控制台左侧导航栏中，单击**集群**。
1. 在**集群列表**页面中，单击目标集群名称或者目标集群右侧**操作**列下的**详情**。
1. 在集群管理页左侧导航栏单击**命名空间与配额**。
1. 在**命名空间**页面，找到 default，单机**编辑**。
   1. 在**变量名称**文本框中输入 istio-injection。
   1. 在**变量值**文本框中输入 enabled。

        点击**添加**后，再点**确定**。<br />![1654061371(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1654061468832-96413c4f-d0ed-4fc9-ab70-6824c53fac5e.png#clientId=ufc1da154-a0d7-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u38d98d2a&margin=%5Bobject%20Object%5D&name=1654061371%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=79411&status=done&style=none&taskId=ua0e72768-57cc-49cf-86aa-955edf82d31&title=&width=1422.2223226916224)<br />![1647929475(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647929513120-c3cf25c5-2011-42c9-b1d2-dcebb0f523db.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=603&id=u0bf21f22&margin=%5Bobject%20Object%5D&name=1647929475%281%29.png&originHeight=678&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69938&status=done&style=none&taskId=u41971378-ba01-4cfc-a96a-9235cad38fd&title=&width=1706.6666666666667)<br />        **说明** 您也可以通过 kubectl 执行以下命令为命名空间添加标签。
```
kubectl label namespace default istio-injection=enabled
```
# 步骤四  部署 BookInfo 
        在 Kubernetes 集群部署的 DataKit，会采集添加了 annotations 注解的 POD 的指标数据。

```
annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "ack-istio-product"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
```
参数说明

- url：Exporter 地址
- source：采集器名称
- metric_types：指标类型过滤
- measurement_name：采集后的指标集名称
- interval：采集指标频率，s秒
- $IP：通配 Pod 的内网 IP
- $NAMESPACE：Pod所在命名空间
- $PODNAME:  Pod名称

    <br />        更改后的 [bookinfo.yaml](https://github.com/istio/istio/blob/master/samples/bookinfo/platform/kube/bookinfo.yaml) 文件如下：
```
apiVersion: v1
kind: Service
metadata:
  name: details
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
  labels:
    account: details
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: details-v1
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
            source = "ack-istio-details"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
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
---
##################################################################################################
# Ratings service
##################################################################################################
apiVersion: v1
kind: Service
metadata:
  name: ratings
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
  labels:
    account: ratings
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ratings-v1
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
            source = "ack-istio-ratings"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
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
---
##################################################################################################
# Reviews service
##################################################################################################
apiVersion: v1
kind: Service
metadata:
  name: reviews
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
  labels:
    account: reviews
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reviews-v1
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
            source = "ack-istio-review1"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
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
            source = "ack-istio-review2"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
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
            source = "ack-istio-review3"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
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
  labels:
    account: productpage
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage-v1
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
            source = "ack-istio-product"
            metric_types = ["counter", "gauge", "histogram"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_asm_istio"
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
        image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9080
        volumeMounts:
        - name: tmp
          mountPath: /tmp
      volumes:
      - name: tmp
        emptyDir: {}
```
部署步骤：

1. 登录[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)。
1. 在控制台左侧导航栏中，单击**集群**。
1. 在**集群列表**页面中，单击目标集群名称或者目标集群右侧**操作**列下的**详情**。
1. 在集群管理页左侧导航栏单击**工作负载 **> **无状态**，然后在右侧页面单击**使用 YAML 创建**。
- 选择相应的命名空间。本文以选择 **default **命名空间为例。
- 在示例模板中，选择自定义。把上文的 bookinfo.yaml 贴入模板中。

        点击创建后，在列表中可以看到部署的无状态 Deployment 和服务。

![1647930667.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647930686624-c2a791df-ec30-43e8-b173-c20273d05be1.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=763&id=u7378b276&margin=%5Bobject%20Object%5D&name=1647930667.png&originHeight=858&originWidth=1892&originalType=binary&ratio=1&rotation=0&showTitle=false&size=92040&status=done&style=none&taskId=u50b0a61d-52d0-4512-b28e-8cbed3d85fb&title=&width=1681.7777777777778)<br />![1647930667(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647930694518-b9065a06-5fb8-461b-8434-c4d1ed73b234.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=749&id=ucd6cf68f&margin=%5Bobject%20Object%5D&name=1647930667%281%29.png&originHeight=843&originWidth=1909&originalType=binary&ratio=1&rotation=0&showTitle=false&size=84848&status=done&style=none&taskId=u959e4536-3e58-4b69-b9e4-1e68850cb81&title=&width=1696.888888888889)

# 步骤五  定义 Gateway 资源

1. 登录 [ASM 控制台](https://servicemesh.console.aliyun.com/)。
1. 在左侧导航栏，选择**服务网格 > 网格管理**。
1. 在**网格管理**页面，找到待配置的实例，单击实例的名称或在**操作**列中单击**管理**。

![1647926949(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647926956613-d33f83cd-31bf-4b3f-aba1-a487ef7a8696.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=691&id=uf0462a02&margin=%5Bobject%20Object%5D&name=1647926949%281%29.png&originHeight=777&originWidth=1820&originalType=binary&ratio=1&rotation=0&showTitle=false&size=112510&status=done&style=none&taskId=u8aa27ead-d232-4531-bde5-ea670e90a5d&title=&width=1617.7777777777778)

4. 在网格详情页面左侧导航栏选择**流量管理 > 网关规则**，然后在右侧页面单击**使用 YAML 创建**。
- 选择相应的命名空间。本文以选择 **default **命名空间为例。
- 在文本框中，定义服务网关。可参考以下YAML定义，详情请参见 [Istio官方示例](https://github.com/istio/istio/blob/master/samples/bookinfo/networking/bookinfo-gateway.yaml)。
```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: bookinfo-gateway
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
```
        点击**创建**后，在**网关规则**页面可以看到新建的 bookinfo-gateway 网关。<br />![1647927563(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647927568186-415a0111-3290-4582-b6ff-6e6631105387.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u64f02cf0&margin=%5Bobject%20Object%5D&name=1647927563%281%29.png&originHeight=812&originWidth=1905&originalType=binary&ratio=1&rotation=0&showTitle=false&size=84957&status=done&style=none&taskId=uf9707aca-5fcd-41d0-86d2-52d18a19d70&title=&width=1693.3333333333333)
# 步骤六 定义虚拟服务

1. 登录 [ASM 控制台](https://servicemesh.console.aliyun.com/)。
1. 在左侧导航栏，选择**服务网格 > 网格管理**。
1. 在**网格管理**页面，找到待配置的实例，单击实例的名称或在**操作**列中单击**管理**。
1. 在网格详情页面左侧导航栏选择**流量管理 > 虚拟服务**，然后在右侧页面单击**使用 YAML 创建**。
1. 按以下步骤定义虚拟服务，然后单击**确定**。
   1. 选择相应的命名空间。本文以选择 **default **命名空间为例。
   1. 在文本框中，定义 Istio 虚拟服务。可参考以下 YAML 定义，详情请参见 [Istio 官方示例](https://github.com/istio/istio/blob/master/samples/bookinfo/networking/bookinfo-gateway.yaml#L16)。

```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo
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
        点击**创建**后，在**虚拟服务**页面可以看到新建的bookinfo服务。

![1647928083(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647928091608-42027754-d875-4ac5-8f26-7ec170a74c15.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=707&id=u1c59ad20&margin=%5Bobject%20Object%5D&name=1647928083%281%29.png&originHeight=795&originWidth=1865&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69369&status=done&style=none&taskId=u1d2f344e-32a6-4e2d-95ea-99e55ab43b5&title=&width=1657.7777777777778)
# 步骤七 部署 DataKit
        登录 [观测云](https://console.guance.com/)，【集成】->【Datakit】-> 【Kubernetes】，请按照指引在 Kubernetes 集群中安装 DataKit ，其中部署使用的 datakit.yaml 文件，在接下来的操作中会使用到。<br />        在观测云的一个工作空间中，可能收到多个集群的采集数据，为了区分集群，使用全局 Tag 为这个集群增加 **k8s-ac**k 的 Tag。
```
        - name: ENV_GLOBAL_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-ack
```
        收集 ASM 的链路数据，需要开通 Zipkin 采集器，即在 ConfigMap 中增加：
```
    zipkin.conf: |-
      [[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
```
        然后再把 zipkin.conf 挂载到 DataKit 的 /usr/local/datakit/conf.d/zipkin 目录：
```
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```
        本次使用的完整 datakit.yaml，您在使用时请使用最新的 datakit.yaml 做适当替换。  
```
apiVersion: v1
kind: Namespace
metadata:
  name: datakit
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - clusterroles
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - nodes
  - nodes/proxy
  - namespaces
  - pods
  - pods/log
  - events
  - services
  - endpoints
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - statefulsets
  - replicasets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - batch
  resources:
  - jobs
  - cronjobs
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - metrics.k8s.io
  resources:
  - pods
  - nodes
  verbs:
  - get
  - list
- nonResourceURLs: ["/metrics"]
  verbs: ["get"]

---

apiVersion: v1
kind: ServiceAccount
metadata:
  name: datakit
  namespace: datakit

---

apiVersion: v1
kind: Service
metadata:
  name: datakit-service
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - protocol: TCP
      port: 9529
      targetPort: 9529

---

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: datakit
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: datakit
subjects:
- kind: ServiceAccount
  name: datakit
  namespace: datakit

---

apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: daemonset-datakit
  name: datakit
  namespace: datakit
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: daemonset-datakit
  template:
    metadata:
      labels:
        app: daemonset-datakit

    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      - env:
        - name: HOST_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: ENV_K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: ENV_DATAWAY
          value: https://openway.guance.com?token=<your-token>
        - name: ENV_GLOBAL_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-ack
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd
        - name: ENV_ENABLE_ELECTION
          value: enable
        #- name: ENV_LOG
        #  value: stdout
        - name: ENV_HTTP_LISTEN
          value: 0.0.0.0:9529
        - name: ENV_NAMESPACE
          value: guance-ack
        image: pubrepo.jiagouyun.com/datakit/datakit:1.4.0
        imagePullPolicy: Always
        name: datakit
        ports:
        - containerPort: 9529
          hostPort: 9529
          name: port
          protocol: TCP
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: /var/run
          name: run
        - mountPath: /var/lib
          name: lib
        - mountPath: /var/log
          name: log
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
          name: datakit-conf
          subPath: logfwdserver.conf  
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
        - mountPath: /host/proc
          name: proc
          readOnly: true
        - mountPath: /host/dev
          name: dev
          readOnly: true
        - mountPath: /host/sys
          name: sys
          readOnly: true
        - mountPath: /rootfs
          name: rootfs
        - mountPath: /sys/kernel/debug
          name: debugfs
        workingDir: /usr/local/datakit
      hostIPC: true
      hostPID: true
      restartPolicy: Always
      serviceAccount: datakit
      serviceAccountName: datakit
      tolerations:
      - operator: Exists
      volumes:
      - configMap:
          name: datakit-conf
        name: datakit-conf
      - hostPath:
          path: /var/run
        name: run
      - hostPath:
          path: /var/lib
        name: lib
      - hostPath:
          path: /var/log
        name: log
      - hostPath:
          path: /proc
          type: ""
        name: proc
      - hostPath:
          path: /dev
          type: ""
        name: dev
      - hostPath:
          path: /sys
          type: ""
        name: sys
      - hostPath:
          path: /
          type: ""
        name: rootfs
      - hostPath:
          path: /sys/kernel/debug
          type: ""
        name: debugfs
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### container
    container.conf: |-           
      [inputs.container]
        endpoint = "unix:///var/run/docker.sock"

        ## Containers metrics to include and exclude, default not collect. Globs accepted.
        container_include_metric = []
        container_exclude_metric = ["image:*"]

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        #container_include_log = ["image:*"]
        container_include_log = []
        container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*"]

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false
        ## Maximum length of logging, default 32766 bytes.
        max_logging_length = 32766

        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
    #### log-socket
    logging-socket.conf: |-
      [[inputs.logging]]
        # only two protocols are supported:TCP and UDP
        sockets = [
          "tcp://0.0.0.0:9542",
        #"udp://0.0.0.0:9531",                  
        ]
        ignore = [""]
        source = "ack-log-socket-source"
        service = "ack-log-socket-service"
        pipeline = ""
        ignore_status = []
        character_encoding = ""
        # multiline_match = '''^\S'''
        remove_ansi_escape_codes = false

        [inputs.logging.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
        
    zipkin.conf: |-
      [[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
```
部署步骤：

1. 登录[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)。
1. 在控制台左侧导航栏中，单击**集群**。
1. 在**集群列表**页面中，单击目标集群名称或者目标集群右侧**操作**列下的**详情**。
1. 在集群管理页左侧导航栏单击**工作负载 **> **守护进程集**，然后在右侧页面单击**使用 YAML 创建**。
- 选择相应的命名空间。选择**所有名称空间**。
- 在示例模板中，选择自定义。把上文的 datakit-ack.yaml 贴入模板中。

        点击创建后，在列表中可以看到部署的守护进程集、服务和配置项。<br />![1647934209(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647934225671-3c478083-af6c-449c-8892-f28a559a5194.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=716&id=u56cd6265&margin=%5Bobject%20Object%5D&name=1647934209%281%29.png&originHeight=805&originWidth=1899&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56357&status=done&style=none&taskId=u0cd46cf0-0bf9-4105-9504-767f5b740ee&title=&width=1688)<br />![1647934412(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647934419828-4039c405-ab97-4473-a16c-f3bb79e47896.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=703&id=u897fc26d&margin=%5Bobject%20Object%5D&name=1647934412%281%29.png&originHeight=791&originWidth=1905&originalType=binary&ratio=1&rotation=0&showTitle=false&size=55843&status=done&style=none&taskId=u9ad57276-3c3c-4bd7-a274-d66eebc6fdb&title=&width=1693.3333333333333)

![1647934444(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647934449914-74035c7f-ab7e-4cbf-ba66-9509094362ff.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=682&id=u4486b0f1&margin=%5Bobject%20Object%5D&name=1647934444%281%29.png&originHeight=767&originWidth=1899&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54105&status=done&style=none&taskId=u7dad19e6-0c0c-485a-8b9a-6198fd7c702&title=&width=1688)
# 步骤八 映射 DataKit 服务
        新增 ASM 时，如果选择了**自行搭建 Zipkin，**则链路数据会被打到** **zipkin.istio-system的 Service上，且上报端口是 9411，由于 DataKit 服务的名称空间是 datakit，端口是 9529，所以这里需要做一下转换，详情请参考[Kubernetes 集群使用 ExternalName 映射 DataKit 服务](https://www.yuque.com/dataflux/bp/external-name)。创建后的 Service 如下图：

![1647933835(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647933840972-ba195f25-7031-4911-b6cd-885f4d1b6599.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=724&id=u1628af68&margin=%5Bobject%20Object%5D&name=1647933835%281%29.png&originHeight=814&originWidth=1877&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57721&status=done&style=none&taskId=ud421338d-95c0-477f-92b9-0e4df15b93b&title=&width=1668.4444444444443)<br />![1647933801(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647933808876-0dfc7f6f-5ff3-48b3-a2c3-a21227f6737a.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=742&id=uf40a314f&margin=%5Bobject%20Object%5D&name=1647933801%281%29.png&originHeight=835&originWidth=1900&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53860&status=done&style=none&taskId=ubf3483b0-eb98-43ff-bb61-0f30494bf88&title=&width=1688.888888888889)

   **说明** 如果不使用 ExternalName 映射 DataKit 服务，也可以使用在 POD 上增加 annotations 的方式，即使用下面的方式指定 DataKit 的服务地址。
```
      annotations:
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: datakit-service.datakit.svc.cluster.local:9529
```
        完整的 productpage 部署文件如下，仅供参考。
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage-v1
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: productpage
      version: v1
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      annotations:
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: datakit-service.datakit.svc.cluster.local:9529
      labels:
        app: productpage
        version: v1
    spec:
      containers:
        - image: 'docker.io/istio/examples-bookinfo-productpage-v1:1.16.2'
          imagePullPolicy: IfNotPresent
          name: productpage
          ports:
            - containerPort: 9080
              protocol: TCP
          resources: {}
          securityContext:
            runAsUser: 1000
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
          volumeMounts:
            - mountPath: /tmp
              name: tmp
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      serviceAccount: bookinfo-productpage
      serviceAccountName: bookinfo-productpage
      terminationGracePeriodSeconds: 30
      volumes:
        - emptyDir: {}
          name: tmp
```

# 步骤九 访问应用
        在第二步配置入口网关时，有一个入口 IP，使用 [http://120.55.180.137/productpage](http://120.55.180.137/productpage) 就可以访问应用了。

![1647931304(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647931326038-76cb4b4e-5a9b-4b3f-b8e8-fc6cc75fc8da.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=801&id=u46a3a83a&margin=%5Bobject%20Object%5D&name=1647931304%281%29.png&originHeight=901&originWidth=1881&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105113&status=done&style=none&taskId=ua42f5c04-5291-4b20-8485-17ccf38fd33&title=&width=1672)
# 步骤十 开启 RUM
        上述的部署中应用是可以启动的，如果想使用观测云的用户访问监测，需要重新制作 productpage 镜像。 
#### 1 新建应用  
         登录 [观测云](https://console.guance.com/)，【用户访问监测】-> 新建应用 **ack-productpage** 。<br />![1652853576(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652853602465-97ecba2c-c3c1-49c6-a120-190cb2178778.png#clientId=ub7190cd0-a1e0-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=507&id=ufb0abfe1&margin=%5Bobject%20Object%5D&name=1652853576%281%29.png&originHeight=760&originWidth=1218&originalType=binary&ratio=1&rotation=0&showTitle=false&size=80053&status=done&style=none&taskId=u4cee1421-96fe-4dc7-a2b1-65fcec6643d&title=&width=812)
#### 2 制作 productpage 镜像 
        下载 [istio-1.13.2.zip](https://github.com/istio/istio/releases)。解压后，把上面的 JS 复制到 **istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html** 文件中，并修改<DATAKIT ORIGIN> 为外网可访问的 DataKit 地址。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652848875108-546f755b-4e07-4674-9089-abd726832cf1.png?x-oss-process=image%2Fresize%2Cw_1125%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=lyIKb&margin=%5Bobject%20Object%5D&originHeight=366&originWidth=1125&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />参数说明

- applicationId：应用 id。
- datakitOrigin：是用户可访问到的 datakit 的地址或域名。
- env：必填，应用所属环境，是 test 或 product 或其他字段。
- version：必填，应用所属版本号。
- allowedDDTracingOrigins：RUM 与 APM 打通，配置后端服务器地址或域名。
- trackInteractions：用户行为统计，例如点击按钮，提交信息等动作。
- traceType：非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型。

#### 3 推送镜像到镜像仓库
        修改完成后，执行下面命令推送镜像到镜像仓库，您在使用时请换成自己的镜像仓库。
```
cd istio-1.13.2\samples\bookinfo\src\productpage\Dockerfile 
docker build -t 172.168.3.28/product-page:v1  .
docker push 172.168.3.28/product-page:v1
```
#### 4 替换 productpage 镜像
        登录[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)，进入集群，单击**工作负载 > 无状态**，找到 productpage，单击**编辑，**替换镜像，点击**更新**。

![1647941276(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647941281686-9d04e3a8-1ebf-4a80-bfdc-1dc15839d450.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=566&id=u50e8ce98&margin=%5Bobject%20Object%5D&name=1647941276%281%29.png&originHeight=637&originWidth=1406&originalType=binary&ratio=1&rotation=0&showTitle=false&size=48853&status=done&style=none&taskId=ubdc25075-0c98-419d-a933-7346b90a7f2&title=&width=1249.7777777777778)

![1647941222(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647941230718-606de5db-3c5b-4d19-87cf-b2ffbd7d3f49.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=700&id=u0055edb5&margin=%5Bobject%20Object%5D&name=1647941222%281%29.png&originHeight=788&originWidth=1916&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56440&status=done&style=none&taskId=u37370690-9eb5-40e0-93b9-c6d00d3da02&title=&width=1703.111111111111)

# 步骤十一 可观测
### 场景
          登录 [观测云](https://console.guance.com/)，【场景】->【新建仪表板】-> 选择 **阿里云 ASM Workload 监控视图**<br />                                                                                        ** 阿里云 ASM Mesh 监控视图**<br />                                                                                        ** 阿里云 ASM Control Plane 监控视图**<br />![1650607020.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1650607023431-a93f9633-efdc-4cd5-92be-8eed5f4f6b68.png#clientId=u7f7277c4-78d0-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=449&id=ua7c39475&margin=%5Bobject%20Object%5D&name=1650607020.png&originHeight=606&originWidth=1657&originalType=binary&ratio=1&rotation=0&showTitle=false&size=79514&status=done&style=none&taskId=u0b398374-7e5e-4f3c-be71-8a6e2420296&title=&width=1227.4074941145927)<br />![1650607020(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1650607034148-63aa3093-4c8a-4910-b9f6-d297aa0efd15.png#clientId=u7f7277c4-78d0-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=413&id=uf9f9876f&margin=%5Bobject%20Object%5D&name=1650607020%281%29.png&originHeight=557&originWidth=1647&originalType=binary&ratio=1&rotation=0&showTitle=false&size=32128&status=done&style=none&taskId=u8cb3622d-ca5d-4c55-9198-670d58b1d74&title=&width=1220.0000861839073)<br />![1650607020(2).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1650607043794-3a18e33e-dc5e-4c7d-ae2d-1f0735364683.png#clientId=u7f7277c4-78d0-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=242&id=u07fee1d5&margin=%5Bobject%20Object%5D&name=1650607020%282%29.png&originHeight=327&originWidth=1650&originalType=binary&ratio=1&rotation=0&showTitle=false&size=39023&status=done&style=none&taskId=ubc44256a-613e-4a72-844a-0d6f8541cb3&title=&width=1222.2223085631128)![1650607020(3).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1650607054172-4e5743b6-4246-452a-80be-07a529b691f6.png#clientId=u7f7277c4-78d0-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=362&id=u1b957a36&margin=%5Bobject%20Object%5D&name=1650607020%283%29.png&originHeight=489&originWidth=1649&originalType=binary&ratio=1&rotation=0&showTitle=false&size=30382&status=done&style=none&taskId=u9ff62d3e-45d5-4a50-a444-478d4fe7a8e&title=&width=1221.4815677700444)![1650607020(4).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1650607064387-c4a971d7-18a3-4333-b270-81ae569fb2fa.png#clientId=u7f7277c4-78d0-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=241&id=ufea3a40e&margin=%5Bobject%20Object%5D&name=1650607020%284%29.png&originHeight=326&originWidth=1648&originalType=binary&ratio=1&rotation=0&showTitle=false&size=30664&status=done&style=none&taskId=udf1c9603-6492-4359-90a3-5a24f2e35e3&title=&width=1220.7408269769758)
### 链路
#### APM
          登录 [观测云](https://console.guance.com/)，进入**应用性能监测**。<br />![1647935945(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647936152298-47a87e94-4b0c-42ac-bc7b-92341e494ca3.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=742&id=u7a18e37b&margin=%5Bobject%20Object%5D&name=1647935945%281%29.png&originHeight=835&originWidth=1889&originalType=binary&ratio=1&rotation=0&showTitle=false&size=112853&status=done&style=none&taskId=u491de6f1-7d5d-4f34-b2ee-fc9c90ae4b9&title=&width=1679.111111111111)<br />![1647935997(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647936165219-32fd9153-5f3e-4bc8-b493-78ddbd8d4771.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=744&id=ua00d779d&margin=%5Bobject%20Object%5D&name=1647935997%281%29.png&originHeight=837&originWidth=1896&originalType=binary&ratio=1&rotation=0&showTitle=false&size=138160&status=done&style=none&taskId=uf32701c1-2a6e-47a8-bed2-499e43626e6&title=&width=1685.3333333333333)
#### RUM
        登录 [观测云](https://console.guance.com/)，**用户访问监测**。<br />![1647939582(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1647939813253-ac2c97c5-e857-4162-bd44-9431fa0c8358.png#clientId=u75c2dd23-e616-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=728&id=ud17d4896&margin=%5Bobject%20Object%5D&name=1647939582%281%29.png&originHeight=819&originWidth=1884&originalType=binary&ratio=1&rotation=0&showTitle=false&size=133896&status=done&style=none&taskId=u12e0160d-a7e7-4123-9591-804291d4d2d&title=&width=1674.6666666666667)
# 日志
        本次部署未涉及到日志，如您的应用需要采集日志，请参考：<br />[Pod 日志采集最佳实践](https://www.yuque.com/dataflux/bp/pod-log)<br />[Kubernetes 集群中日志采集的几种玩法](https://www.yuque.com/dataflux/bp/mk0gcl)


参考文献：<br />[https://help.aliyun.com/document_detail/149552.html](https://help.aliyun.com/document_detail/149552.html)


