# 简介
        一般企业创建自己的容器云环境后，企业为了简化繁琐的发布流程，一般会使用 GitlabCi 、Jenkins 进行应用部署。同时会考虑使用 Rancher 进行统一的资源编排管理，通过 Rancher 的应用商店简化应用管理。通过应用商店一键安装 Datakit （具体见 Datakit 文档的 Helm 安装方式），观测云对 Rancher管控的 k8s 集群，提供了大量开箱即用的可观测功能。本文通过一个耳熟能详的 Bookinfo 案例，详细解释如何利用观测云实现 GitlabCI、K8S 与微服务的可观测性。
# 案例假设
       某公司利用 Rancher 管理了两套K8S ，一套研发测试，一套线上。公司在研发测试环境部署了 gitlab 做 CICD，BookInfo 项目是个电子书城，是个典型的多语言微服务项目。一个正在研发的发版本部署在研发测试环境，通过测试后，对线上环境的 BookInfo 做金丝雀灰度发布。该公司的可观测体系组成部分如下： <br />1.1 SRE 对整体两套环境的 K8s 资源情况在观测云上进行观测，做好容量规划和应急处理 <br />2.1 开发人员对 cicd 的流程进行观测从而了解软件迭代的速度和质量，及时处理出错的 pipeline。<br />2.2 SRE 对线上环境的金丝雀发布进行观测从而了解版本流量切换的状态，及时回滚避免对线上用户产生影响。 <br />3.1 SRE 通过 istio 对整个应用进行链路追踪，在观测云上查看应用的健康关键指标，及时处理异常请求。<br />3.2 开发对自己的日志进行管理，出现健康异常时，在观测云上及时通过链路追踪找到日志上下文解决问题<br />我们分三篇讲解整体实践。
# 前置条件

- 安装 [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/)。
- 安装 [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/)。
- 安装 [Gitlab](https://about.gitlab.com/  )。
- 安装 [Metrics-Server 组件](https://github.com/kubernetes-sigs/metrics-server#installation)。
- 部署 harbor 仓库或其它镜像仓库。
- 部署 Istio，已熟悉[基于 Istio 实现微服务可观测最佳实践](https://www.yuque.com/dataflux/bp/istio)**。**
- 配置 Gitlab-runner，已熟悉 [Gitlab-CI 可观测最佳实践](https://www.yuque.com/dataflux/bp/gitlab-cicd)。
# 部署步骤
## 步骤 1： 使用 Rancher 安装 DataKit
### 1.1 部署 DataKit
#### 1.1.1 下载部署文件
         登录『[观测云](https://console.guance.com/)』，点击『集成』模块，再点击左上角『DataKit』，选择『Kubernetes』，下载 datakit.yaml。
#### 1.1.2 配置 token
         登录『[观测云](https://console.guance.com/)』，进入『管理』模块，找到下图中 token，替换 datakit.yaml 文件中的 ENV_DATAWAY 环境变量的 value 值中的 <your-token>。
```
        - name: ENV_DATAWAY
          value: https://openway.guance.com?token=<your-token>
```
![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648545764623-52524aa3-2232-40cb-aa36-d54e4d0108d8.png#crop=0&crop=0&crop=1&crop=1&from=url&id=Eb2tb&margin=%5Bobject%20Object%5D&originHeight=810&originWidth=1532&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
#### 1.1.3 设置全局标签
        在 datakit.yaml 文件中的 ENV_GLOBAL_TAGS 环境变量值最后增加 cluster_name_k8s=k8s-istio，其中  k8s-istio 为您的集群名称，此步骤为集群设置全局 tag。
```
        - name: ENV_GLOBAL_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-istio
```
#### 1.1.4 设置名称空间
        DataKit 在选举时为了区分不同集群，这里需要设置 ENV_NAMESPACE 环境变量，不同集群值不能相同。在 datakit.yaml 文件中的环境变量部分增加如下内容。
```
        - name: ENV_NAMESPACE
          value: k8s-istio
```
#### 1.1.5 开通采集器
        开通 ddtrace 和 statsd 采集器，在 datakit.yaml 文件中找到 ENV_DEFAULT_ENABLED_INPUTS 环境变量，最后增加 statsd,ddtrace。
```
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ddtrace
```
#### 1.1.6 部署 DataKit
         登录『Rancher』，在浏览集群标签下，选择『k8s-solution-cluster』集群，打开 datakit.yaml，根据资源文件内容，在 k8s-solution-cluster 集群中找到对应的菜单并一一创建资源。<br /> <br />![1648612746(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648612752143-bdc6485d-8951-41b9-9c7a-d6ce133ac116.png#clientId=u4594850f-b855-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u08c7e911&margin=%5Bobject%20Object%5D&name=1648612746%281%29.png&originHeight=733&originWidth=1892&originalType=binary&ratio=1&rotation=0&showTitle=false&size=43573&status=done&style=none&taskId=uc2d6a10d-778b-457a-b753-3f8086cb91f&title=&width=1681.7777777777778)<br />『注意』为了快速实现下一步操作，本次操作将合并 ConfigMap 后，直接使用 kubectl 命令部署 DataKit。
### 1.2 创建 ConfigMap
        开通 container 采集器和 zipkin 采集器，需要先定义 container.conf 和 zipkin.conf。
```
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
        container_include_metric = ["image:*"]
        container_exclude_metric = []

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = ["image:*"]
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
          
    #### zipkin
    zipkin.conf: |-          
        [[inputs.zipkin]]
          pathV1 = "/api/v1/spans"
          pathV2 = "/api/v2/spans"
```
[inputs.container]参数说明

- container_include_metric：须要采集的容器指标。
- container_exclude_metric：不须要采集的容器指标。
- container_include_log：须要采集的容器日志。
- container_exclude_log：不须要采集的容器日志。
- exclude_pause_container：true 是排除 pause 容器。
- `container_include` 和 `container_exclude` 必须以 `image` 开头，格式为 `"image:<glob规则>"`，表示 glob 规则是针对容器 image 生效
- [Glob 规则](https://en.wikipedia.org/wiki/Glob_(programming))是一种轻量级的正则表达式，支持 `*` `?` 等基本匹配单元

         然后登录『Rancher』，在浏览集群标签下，选择『k8s-solution-cluster』集群，依次进入『更多资源』-> 『Core』-> 『ConfigMaps』，使用 yaml 格式把上述定义的 ConfigMap 创建。<br />![1648609475(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648609488580-68f33280-e960-4e62-96be-3535c6954cf8.png#clientId=u4594850f-b855-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=763&id=uff9ce419&margin=%5Bobject%20Object%5D&name=1648609475%281%29.png&originHeight=858&originWidth=1898&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74883&status=done&style=none&taskId=ubb273295-5304-4125-a035-8924b5d5138&title=&width=1687.111111111111)<br />        最后在把 DataKit 与 ConfigMap 做下关联，在『k8s-solution-cluster』集群，进入 『工作负载』-> 『DaemonSets』找到 DataKit，在右边选择『编辑 YAML』，添加如下内容，最后点击『保存』。<br />![1648617535(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648617699291-bd771b89-f3b9-4f60-be81-2fc7989688e7.png#clientId=u4594850f-b855-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=549&id=u486bb7f9&margin=%5Bobject%20Object%5D&name=1648617535%281%29.png&originHeight=618&originWidth=1366&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37877&status=done&style=none&taskId=u3de81131-53ba-4b5d-a9fd-3ac30670c34&title=&width=1214.2222222222222)
```
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```
        <br />        如果使用 kubectl 命令创建 Datakit，请把 ConfigMap 中定义的内容添加在 datakit.yaml 文件最后，再把上面的配置加到 文件中 volumeMounts 下面。<br />『注意』使用 --- 做分割。

       
### 1.3 查看 DataKit 运行状态
        DataKit 部署成功后，可以看到如下图的运行状态。<br />![1648617972(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648617978073-517f040d-b7b7-4f8b-8eb3-39b619ea4a4c.png#clientId=u4594850f-b855-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=587&id=u934951d6&margin=%5Bobject%20Object%5D&name=1648617972%281%29.png&originHeight=660&originWidth=1896&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51559&status=done&style=none&taskId=uf70547e3-70fd-4e01-8003-0e586db7fb9&title=&width=1685.3333333333333)
## 步骤 2： 映射 DataKit 服务
        使用 Istio 上报链路数据时，链路数据会被打到** **zipkin.istio-system的 Service上，且上报端口是 9411，由于 DataKit 服务的名称空间是 datakit，端口是 9529，所以这里需要做一下转换，详情请参考[Kubernetes 集群使用 ExternalName 映射 DataKit 服务](https://www.yuque.com/dataflux/bp/external-name)。

## 步骤 3： DataFlux Function 配置 DataKit
        在使用 Gitlab-CI 部署微服务时，为了收集 Gitlab 执行数据，需要部署 DataFlux Function 并配置 DataKit，详细步骤请参考 [Gitlab-CI 可观测最佳实践](https://www.yuque.com/dataflux/bp/gitlab-cicd)。
## 步骤 4： 部署 Bookinfo
### 2.1 下载源码
        下载 [istio-1.13.2.zip](https://github.com/istio/istio/releases)，后面使用的部署文件全部来自此压缩包，为了操作方便，将使用 kubectl 命令代替 Rancher 的图形化界面创建资源的操作。
### 2.2 开启 RUM
         为了观测网站被调用的信息，需要开通前端的数据采集。登录『 [观测云](https://console.guance.com/)』，进入『用户访问监测』，新建应用 **devops-bookinfo** ，复制下方 JS。<br />![1652853576(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652853589948-8e1d3db6-75e1-45a5-bc58-811aeab47b12.png#clientId=u84c75b42-2536-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=507&id=ubcfeba6d&margin=%5Bobject%20Object%5D&name=1652853576%281%29.png&originHeight=760&originWidth=1218&originalType=binary&ratio=1&rotation=0&showTitle=false&size=80053&status=done&style=none&taskId=ub495df50-8b2c-4478-9534-4538d238875&title=&width=812)<br />        上述的 JS 需要放置到 productpage 项目所有界面都能访问到的地方，本项目把上面的 JS 复制到 **istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html** 文件中。<br />『注意』关于 RUM 数据上报的 DataKit 地址，请参考 [RUM 数据上报 DataKit 集群最佳实践](https://www.yuque.com/dataflux/bp/datakit-cluster)。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652848875108-546f755b-4e07-4674-9089-abd726832cf1.png#crop=0&crop=0&crop=1&crop=1&from=url&id=ZrdU9&margin=%5Bobject%20Object%5D&originHeight=374&originWidth=1150&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />        然后对 productpage 重新发布镜像并上传到镜像仓库。
```
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1  .
docker push 172.16.0.238/df-demo/product-page:v1
```
### 2.3 开通 Sidecar 注入
        新建 prod 命名空间，开启该空间下创建 Pod 时自动注入 Sidecar，让 Pod 的出入流量都转由 Sidecar 进行处理。
```
kubectl create ns prod 
kubectl label namespace prod istio-injection=enabled
```
### 2.4 部署 productpage、details、ratings
        在 istio-1.13.2\samples\bookinfo\platform\kube\bookinfo.yaml 文件中，移除关于 reviews 微服务部署的部分，把 Service 和 Deployment 都部署到 prod 名称空间，并在所有 Deployment 控制器，Pod 模板上增加 annotations，来开启 Pod 的自定义采集。把 productpage 镜像修改为上步创建的。完整文件如下：
```

# Copyright Istio Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

##################################################################################################
# This file defines the services, service accounts, and deployments for the Bookinfo sample.
#
# To apply all 4 Bookinfo services, their corresponding service accounts, and deployments:
#
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
#
# Alternatively, you can deploy any resource separately:
#
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -l service=reviews # reviews Service
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -l account=reviews # reviews ServiceAccount
#   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -l app=reviews,version=v3 # reviews-v3 Deployment
##################################################################################################

##################################################################################################
# Details service
##################################################################################################
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
            source = "bookinfo-istio-details"
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
            source = "bookinfo-istio-ratings"
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
            source = "bookinfo-istio-product"
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
    spec:
      serviceAccountName: bookinfo-productpage
      containers:
      - name: productpage
        #image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2
        image: 172.16.0.238/df-demo/product-page:v1
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
### 
```
kubectl apply -f bookinfo.yaml
```
### 2.5 创建 Gateway 资源和虚拟服务
        修改 istio-1.13.2\samples\bookinfo\networking\bookinfo-gateway.yaml 文件，增加 prod 名称空间。
```
apiVersion: networking.istio.io/v1alpha3
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

```
kubectl apply -f bookinfo-gateway.yaml 
```
### 2.6 访问 productpage
        查看 ingresgateway 对外暴露的端口。
```
kubectl get svc -n istio-system
```
![1648632432(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648632448123-1ae4fc04-3bec-4e7a-94dd-4700259a7473.png#clientId=u4e1d4362-c866-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=163&id=uf5674b89&margin=%5Bobject%20Object%5D&name=1648632432%281%29.png&originHeight=183&originWidth=1531&originalType=binary&ratio=1&rotation=0&showTitle=false&size=18976&status=done&style=none&taskId=uc32dde67-6a78-4ffd-b4e0-291704c8309&title=&width=1360.888888888889)

        根据虚拟服务规则，浏览器访问 [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage)，即可访问 productpage，由于此时 reviews 服务还没部署，所以会出现** Sorry, product reviews are currently unavailable for this book** 的提示。<br />![1648632007(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648632026700-0ce685e7-008f-410c-8052-1b00610a5e5f.png#clientId=u4e1d4362-c866-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=635&id=ue78e9d43&margin=%5Bobject%20Object%5D&name=1648632007%281%29.png&originHeight=714&originWidth=1893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=40070&status=done&style=none&taskId=u4ffbe7f6-d6e5-4cee-a50d-a7d199af242&title=&width=1682.6666666666667)
## 步骤 5： 自动化部署
### 5.1 创建 Gitlab 项目
        登录 Gitlab，创建 bookinfo-views 项目。<br />![1648634179(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648634192491-ec7eba2f-b91f-45f6-9566-79b11069f54e.png#clientId=u4e1d4362-c866-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=449&id=u617cafdb&margin=%5Bobject%20Object%5D&name=1648634179%281%29.png&originHeight=505&originWidth=1832&originalType=binary&ratio=1&rotation=0&showTitle=false&size=33995&status=done&style=none&taskId=u1187c67b-ce83-4c4e-b651-8697fff1d09&title=&width=1628.4444444444443)<br /> 
### 5.2 打通 Gitlab 与 DataKit
        请参考 [gitlab 集成文档](https://www.yuque.com/dataflux/integrations/gitlab)打通 Gitlab 和 DataKit，这里只配置 Gitlab CI。<br />        登录『Gitlab』，进入『bookinfo-views』-> 『Settings』-> 『Webhooks』，在 url 中输入URL 中输入 DataKit 所在的主机 IP 和 DataKit 的 9529 端口，再加 /v1/gitlab。如下图。<br />![1652346256(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346270462-79354129-dd0a-4e03-a36a-1564e25ca4ea.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=626&id=ub85fba94&margin=%5Bobject%20Object%5D&name=1652346256%281%29.png&originHeight=845&originWidth=1899&originalType=binary&ratio=1&rotation=0&showTitle=false&size=131828&status=done&style=none&taskId=u21fa9b20-67db-4235-9494-b2b6ce49250&title=&width=1406.6667660371827)

        选中 Job events 和 Pipeline events，点击 Add webhook。<br />![1652346330(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346336359-691db6af-7cdd-430e-b0b0-61a42c932208.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=148&id=u9458bc94&margin=%5Bobject%20Object%5D&name=1652346330%281%29.png&originHeight=200&originWidth=451&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9460&status=done&style=none&taskId=u2f070d12-d2bf-4d16-879f-e388a2cc440&title=&width=334.07409767391755)<br />         点击刚才创建的 Webhooks 右边的 Test，选择 Pipeline events，出现下图的 HTTP 200 说明配置成功。<br />![1652346373(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346379611-b4d3d016-5f8f-40f2-84d8-075fe59418b8.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=282&id=u3e289674&margin=%5Bobject%20Object%5D&name=1652346373%281%29.png&originHeight=381&originWidth=1508&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54874&status=done&style=none&taskId=u8a76ab65-c097-43d6-8ba0-ca82b860b27&title=&width=1117.0371159473784)

       
### 5.3 为 reviews 微服务配置 Gitlab-CI
        登录『Gitlab』，进入『bookinfo-views』，根目录新建 deployment.yaml 和 .gitlab-ci.yml 文件。在 annotations 定义了 project、env、version 标签，用于不同项目、不同版本的区分。
```
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
  name: reviews-__version__
  namespace: prod
  labels:
    app: reviews
    version: __version__
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reviews
      version: __version__
  template:
    metadata:
      labels:
        app: reviews
        version: __version__
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "bookinfo-istio-review"
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
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: zipkin.istio-system:9411
            custom_tags:
              project:
                literal:
                  value: "reviews"
              version:
                literal:
                  value: __version__
              env:
                literal:
                  value: "test"        
    spec:
      serviceAccountName: bookinfo-reviews
      containers:
      - name: reviews
        image: docker.io/istio/examples-bookinfo-reviews-__version__:1.16.2
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

```
```
variables:
  APP_VERSION: "v1"


stages:
  - deploy

deploy_k8s:
  image: bitnami/kubectl:1.22.7
  stage: deploy
  tags:
    - kubernetes-runner
  script:
    - echo "执行deploy"
    - ls
    - sed -i "s#__version__#${APP_VERSION}#g" deployment.yaml
    - cat deployment.yaml
    - kubectl apply -f deployment.yaml
  after_script:
    - sleep 10
    - kubectl get pod  -n prod

```
### 
## 步骤 6：Gitlab CI 可观测
### 6.1 发布 reviews 微服务
        修改 .gitlab-ci.yml 文件中的 APP_VERSION 的值为 "v1"，提交一次代码，修改成 "v2"，提交一次代码，修改成 "v3" 提交一次代码。<br />![1648635268(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648635274583-f67fc40c-f230-4225-913b-2e240d6881ba.png#clientId=u4e1d4362-c866-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=719&id=ud651b62c&margin=%5Bobject%20Object%5D&name=1648635268%281%29.png&originHeight=809&originWidth=1422&originalType=binary&ratio=1&rotation=0&showTitle=false&size=59543&status=done&style=none&taskId=u0760d361-67c7-4e40-8285-b24110f9677&title=&width=1264)<br />        此时 Pipeline 被触发 3次。        <br />![1648634419(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648634484952-fabac73d-e3a9-46d2-ab77-2efeb6904e21.png#clientId=u4e1d4362-c866-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=709&id=ub5703cdc&margin=%5Bobject%20Object%5D&name=1648634419%281%29.png&originHeight=798&originWidth=1901&originalType=binary&ratio=1&rotation=0&showTitle=false&size=93943&status=done&style=none&taskId=u3865b029-7b77-4865-b9e3-00284be64a8&title=&width=1689.7777777777778)

### 6.2 Gitlab CI 流水线可观测
          登录『[观测云](https://console.guance.com/)』，进入『CI』，点击『概览』选择 bookinfo-views 项目，查看 Pipeline 和 Job 的执行情况。<br />![1652346915(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346992531-ed17a1ff-c5c3-4cb5-9fe6-fe241d3f032c.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=539&id=u39724ead&margin=%5Bobject%20Object%5D&name=1652346915%281%29.png&originHeight=727&originWidth=1696&originalType=binary&ratio=1&rotation=0&showTitle=false&size=63052&status=done&style=none&taskId=ud2ca02c4-4cc0-41b0-a973-8806c59ab8c&title=&width=1256.2963850442663)<br />![1652346926(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652347000981-b26df358-34b8-4df4-b158-d5ee726cf200.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=425&id=u38d8c278&margin=%5Bobject%20Object%5D&name=1652346926%281%29.png&originHeight=574&originWidth=1681&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50864&status=done&style=none&taskId=u57f1f983-7829-45bc-b674-0fc1e4941bb&title=&width=1245.1852731482381)

         登录『[观测云](https://console.guance.com/)』，进入『CI』,点击『查看器』，选择 gitlab_pipeline。<br />![1652346801(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652347030018-9b362337-6a28-4811-99e5-c13b8663ee2e.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=uea985760&margin=%5Bobject%20Object%5D&name=1652346801%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=84893&status=done&style=none&taskId=u4f1a816f-4ec8-4ab9-b5f5-e224e0ca4d2&title=&width=1422.2223226916224)<br />![1652346830(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652347039336-035d0ead-df34-4e21-94f8-ba9d11badcaa.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=627&id=ua26e9772&margin=%5Bobject%20Object%5D&name=1652346830%281%29.png&originHeight=847&originWidth=1521&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56084&status=done&style=none&taskId=ub9f4e5bf-b548-400a-b3f9-6f8805ed704&title=&width=1126.6667462572696)

         登录『[观测云](https://console.guance.com/)』，进入『CI』,点击『查看器』，选择 gitlab_job。<br />![1652346850(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652347050514-c558ca42-53a0-4efe-9815-4ff6b2866bdd.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=udcd5e8b9&margin=%5Bobject%20Object%5D&name=1652346850%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=87419&status=done&style=none&taskId=u1e38a660-c64e-4f64-adc3-031ab23479e&title=&width=1422.2223226916224)
## ![1652346872(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652347057510-95817121-5a04-451f-9e09-dd1ed5c62a83.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=626&id=u96cda42e&margin=%5Bobject%20Object%5D&name=1652346872%281%29.png&originHeight=845&originWidth=1523&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56362&status=done&style=none&taskId=ubac69e57-86b5-4e1d-b7ab-0f4ad213d39&title=&width=1128.1482278434066)
![1652346891(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652347065026-2fb3484f-cd11-46ed-92fb-cebfff9c1f0e.png#clientId=ue2e9a766-85cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=627&id=ub14cc24e&margin=%5Bobject%20Object%5D&name=1652346891%281%29.png&originHeight=847&originWidth=1521&originalType=binary&ratio=1&rotation=0&showTitle=false&size=42463&status=done&style=none&taskId=u43228a4a-724b-439c-9bde-2c927635745&title=&width=1126.6667462572696)
