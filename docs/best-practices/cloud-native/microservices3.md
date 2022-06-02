# 简介
        本篇将介绍金丝雀发布的整体情况，利用观测云对微服务的指标、链路、日志进行可观测。以下关于Rancher 的操作都是在 k8s-solution-cluster 集群，不再重复提示。 

# 金丝雀发布
        为了实现金丝雀发布，在部署微服务的 Deployment 上增加 app=reviews 的标签，用来区分微服务名称。第一次部署的版本增加 version=v1 的标签，第二次部署的版本增加 version=v2 的标签。这样根据标签就可以控制每个版本流量进入的多少，比如发布完 v2 后，让 90% 的流量进入 v1 版本，10% 的流量进入 v2 版本，等验证没问题，流量完全切换到 v2 版本，下线 v1 版本。整个发布完成。<br />        <br />![1648791448(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648791506000-c9f27c02-5f32-4c25-87a1-ba997a31db9c.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=377&id=u7f59f5b8&margin=%5Bobject%20Object%5D&name=1648791448%281%29.png&originHeight=424&originWidth=666&originalType=binary&ratio=1&rotation=0&showTitle=false&size=15720&status=done&style=none&taskId=ub1c3568e-4d54-40ea-8bf6-ec7ce256df6&title=&width=592)
## 步骤一： 删除 reviews 
        第一篇操作中，为了讲述 Gitlab-CI 自动化部署，部署了 reviews 的三个版本，本次操作前，需要删掉 reviews 的三个部署版本。 登录『Rancher』，在集群中，依次进入『工作负载』-> 『Deployments』找到 reviews-v1，在右边选择『删除』。然后再用同样的方式删除 reviews-v2、reviews-v3。<br />![1648790689(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648790699457-beca3669-0663-4a37-87be-6935894f9b38.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=540&id=u01886b1f&margin=%5Bobject%20Object%5D&name=1648790689%281%29.png&originHeight=607&originWidth=1906&originalType=binary&ratio=1&rotation=0&showTitle=false&size=67732&status=done&style=none&taskId=u3db4d8a7-4939-4c61-92b0-fe62ae78339&title=&width=1694.2222222222222)
## 步骤二： 发布 reviews-v1
        登录『gitlab』，找到 bookinfo-views 项目， 修改 .gitlab-ci.yml 文件中的 APP_VERSION 的值为 "v1"，提交一次代码。登录『Rancher』，在集群中，依次进入『工作负载』-> 『Deployments』可以看到 reviews-v1 部署完成。<br />![1648792065(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648792070480-eec7d22a-98e5-4986-a6c9-127ac67eb1f1.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=490&id=u930f916c&margin=%5Bobject%20Object%5D&name=1648792065%281%29.png&originHeight=551&originWidth=1902&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52082&status=done&style=none&taskId=u9f4232bc-be88-4947-b5cc-21c831cec91&title=&width=1690.6666666666667)
## 步骤三： 创建 DestinationRule
        定义目标地址，为 reviews Service 做服务发现时划分 subsets，分别是 v1 和 v2，为了使用 kubectl 部署该资源，把以下内容保存到 destination-rule-reviews.yaml 文件。
```
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: reviews
  namespace: prod
spec:
  host: reviews
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```
```
kubectl create -f destination-rule-reviews.yaml
```
## 步骤四： 创建 VirtualService
        再没发布 v2 之前，先把流量完全切换到 v1。把下面的内容存入 virtual-service-reviews.yaml 文件。
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
  namespace: prod
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
```

```
kubectl create -f virtual-service-reviews.yaml
```
        访问 [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage) 。<br />![1648794591(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648794599763-24454122-7005-4c8f-8569-a2b2aaf2adb0.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=632&id=u1b7aead1&margin=%5Bobject%20Object%5D&name=1648794591%281%29.png&originHeight=632&originWidth=1882&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54526&status=done&style=none&taskId=u5fd2af38-4ccd-441e-b89a-233e3fbe2ff&title=&width=1882)
## 步骤五： 发布 reviews-v2
        登录『gitlab』，找到 bookinfo-views 项目， 修改 .gitlab-ci.yml 文件中的 APP_VERSION 的值为 "v2"，提交一次代码。登录『Rancher』，在集群中，依次进入『工作负载』-> 『Deployments』可以看到 reviews-v2 部署完成。虽然发布了 v2，此时访问 [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage)，reviews 微服务只能请求到 V1 版本。<br />![1648794797(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648794800471-4d26387d-fa26-443f-aca9-aac3ca8e7d33.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=658&id=uc9beb33b&margin=%5Bobject%20Object%5D&name=1648794797%281%29.png&originHeight=658&originWidth=1903&originalType=binary&ratio=1&rotation=0&showTitle=false&size=58794&status=done&style=none&taskId=u25a1d383-bd8a-4ad1-8eea-ced5bb5d884&title=&width=1903)

![1648794932(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648794941506-8b430aa3-87a9-44bc-ab6c-d4fb9c085c27.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=613&id=u4d0bb004&margin=%5Bobject%20Object%5D&name=1648794932%281%29.png&originHeight=613&originWidth=1904&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54585&status=done&style=none&taskId=u60a4b1bf-500f-4339-b153-2b8ad4c426b&title=&width=1904)
## 步骤六： 切换 10% 流量到 reviews-v2
        修改 virtual-service-reviews.yaml 文件，内容如下：
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
  namespace: prod
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 90
    - destination:
        host: reviews
        subset: v2
      weight: 10
```
         重新部署。
```
kubectl replace -f virtual-service-reviews.yaml
```
        多次访问  [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage)，reviews 微服务的 v1 版本和 v2 版本分别会接收到 90% 和 10% 的流量， 

![1648795459(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648795481600-9bd84cf0-900c-4ede-94ab-d174f64dc7ce.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=613&id=u4316706d&margin=%5Bobject%20Object%5D&name=1648795459%281%29.png&originHeight=613&originWidth=1904&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56588&status=done&style=none&taskId=u820cc78e-4140-4e89-908c-21cdf76280a&title=&width=1904)<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648795463513-3f54b356-7421-4cfb-808a-0d8a9ceb3859.png#crop=0&crop=0&crop=1&crop=1&from=url&id=DCVvW&margin=%5Bobject%20Object%5D&originHeight=639&originWidth=1911&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
## 步骤七： 观测 reviews-v2
#### 1. 应用性能监测
        登录『观测云』->『应用性能监测』-> 右上角拓扑图表。打开区分环境和版本开关，reviews 有两个版本，其中 reviews:test:v2 调用 ratings 服务。<br />![1652339001(1).jpg](https://cdn.nlark.com/yuque/0/2022/jpeg/21583952/1652339083717-88fbdfa3-95fb-4585-bd5f-f68955ac6d80.jpeg#clientId=u96d2dee0-7582-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=589&id=u83286b4f&margin=%5Bobject%20Object%5D&name=1652339001%281%29.jpg&originHeight=795&originWidth=1775&originalType=binary&ratio=1&rotation=0&showTitle=false&size=150640&status=done&style=none&taskId=u333fc877-d66e-4b6d-8ee4-7126ec2e4eb&title=&width=1314.814907696682)<br />![1652349754(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652349863342-ca3b7469-3239-445a-b670-58ea9cfeb320.png#clientId=udb9f7049-9813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=456&id=u1e5d04d4&margin=%5Bobject%20Object%5D&name=1652349754%281%29.png&originHeight=616&originWidth=739&originalType=binary&ratio=1&rotation=0&showTitle=false&size=32815&status=done&style=none&taskId=uaf67ad40-bb39-46f8-9b1f-cd5b3d13941&title=&width=547.4074460776609)

      点击上方的『链路』，本次使用按资源查找功能，选择 reviews.prod，找到 reviews 版本是 v2 的链路，点击进去。<br />![1652339751(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652339780273-e1073019-27bb-4581-9af0-5c2eb4f4c329.png#clientId=u96d2dee0-7582-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u62ddd01c&margin=%5Bobject%20Object%5D&name=1652339751%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=161771&status=done&style=none&taskId=u06a6c435-5c0e-4a2d-83b1-e1b8b33668d&title=&width=1422.2223226916224)<br />        在详情界面观测火焰图，如果有链路调用错误，或者超时等问题，都能清晰地看到。这里的 project、version 和 env 标签，就是在 gitlab 中 bookinfo-views 项目的 deployment.yaml 文件定义的 annotations。

![1652339841(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652339848311-57eab5a9-ba3d-42b5-8acd-15119184efb7.png#clientId=u96d2dee0-7582-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u8c496486&margin=%5Bobject%20Object%5D&name=1652339841%281%29.png&originHeight=866&originWidth=1516&originalType=binary&ratio=1&rotation=0&showTitle=false&size=87047&status=done&style=none&taskId=u71c0afa3-7732-4331-8590-56e32ea6567&title=&width=1122.9630422919267)<br />        Span 列表中查看每个 Span 的执行耗时。        <br />![1652339884(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652339891535-86e00650-e485-4ecc-a9ad-ad2ce809b1a6.png#clientId=u96d2dee0-7582-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=624&id=u652a9b73&margin=%5Bobject%20Object%5D&name=1652339884%281%29.png&originHeight=842&originWidth=1523&originalType=binary&ratio=1&rotation=0&showTitle=false&size=66763&status=done&style=none&taskId=uaab5b590-337b-44b8-adb9-ca6c9357555&title=&width=1128.1482278434066)<br />        服务调用关系中，可以看到清晰的拓扑图。<br />![1652339909(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652339916869-08510319-b6f8-4bfc-b4ac-12a7ae8b8cf6.png#clientId=u96d2dee0-7582-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=604&id=u9034ffb1&margin=%5Bobject%20Object%5D&name=1652339909%281%29.png&originHeight=815&originWidth=1508&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56388&status=done&style=none&taskId=u3b248210-37ab-4921-ad6c-e6da09356a7&title=&width=1117.0371159473784)

#### 2 Istio Mesh 监控视图
         登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Istio Mesh 监控视图**。在这个视图里面可以看到调用 reviews-v1 和 reviews-v2 的比例基本是 9:1.

![1650598933(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1650598937764-e5500f9c-3833-4b38-b7be-0ab93dce0574.png#clientId=u609fab63-79a9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=477&id=ud5110b64&margin=%5Bobject%20Object%5D&name=1650598933%281%29.png&originHeight=644&originWidth=1652&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61961&status=done&style=none&taskId=u27e8919c-8662-4b83-bb5e-a703e59687c&title=&width=1223.7037901492502)

## 步骤八： 完成发布
        在 reviews-v2 版本的微服务经过验证正常后，流量可以完全切换到 v2 版本。 修改 virtual-service-reviews.yaml 文件，内容如下：
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
  namespace: prod
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v2
```
        重新部署。
```
kubectl replace -f virtual-service-reviews.yaml
```

![1648795819(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648795825960-af71f874-4313-42bb-bde8-eeaaa15d7073.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=650&id=u31b10f5e&margin=%5Bobject%20Object%5D&name=1648795819%281%29.png&originHeight=650&originWidth=1874&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70300&status=done&style=none&taskId=ud0201576-bdcc-48c3-98be-dfe04b77428&title=&width=1874)<br />『注意』如果 reviews-v2 版本有问题，请登录『 [观测云](https://console.guance.com/)』参考本章最后一节的链路超时分析来分析问题，参考步骤六把流量完全切回 reviews-v1，等问题修复后，重新发布。
# 指标
        部署 Bookinfo 时，在使用自定义配置开启 Pod 时，在 annotations 配置中增加了 measurement_name = "istio_prom"，这就是把指标采集到 **istio_prom** 指标集中。登录『观测云』->『指标』，查看 istio_prom 指标集。<br />![](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635151277660-c6321a8d-2044-4a30-813f-d9cacf0f12d5.png#crop=0&crop=0&crop=1&crop=1&from=url&id=h70P3&margin=%5Bobject%20Object%5D&originHeight=842&originWidth=1909&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />        利用这些指标可以根据自身项目需要，制作类似上步介绍的** Istio Mesh 监控视图**。 


# 链路
## RUM
        登录『 [观测云](https://console.guance.com/)』，进入『用户访问监测』，找到  **devops-bookinfo **应用，点击进入。<br />![1648797176(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648797181763-7371f3b1-3a7a-4270-8494-26f516726702.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=749&id=u500d2e34&margin=%5Bobject%20Object%5D&name=1648797176%281%29.png&originHeight=749&originWidth=1880&originalType=binary&ratio=1&rotation=0&showTitle=false&size=55298&status=done&style=none&taskId=ue53649c4-1104-4918-adc8-0499a610e4c&title=&width=1880)<br />        查看 UV、PV、会话数、访问的页面等信息。<br />![1648796444(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648796454158-af07fb64-40b4-4f70-b485-546d5ce34cc4.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=794&id=u88858f50&margin=%5Bobject%20Object%5D&name=1648796444%281%29.png&originHeight=794&originWidth=1658&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116394&status=done&style=none&taskId=u8fe76bf5-b61a-4c9b-a6ba-64c9ae97fd6&title=&width=1658)<br />![1648796444.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648796482680-2f22c867-bdc2-49ba-8ad0-618d0d03cc13.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=782&id=u0fa8ab4b&margin=%5Bobject%20Object%5D&name=1648796444.png&originHeight=782&originWidth=1641&originalType=binary&ratio=1&rotation=0&showTitle=false&size=110060&status=done&style=none&taskId=u0f78ab95-fc75-4ab5-9b0c-d115d8cbb22&title=&width=1641)<br />『温馨提示』如果是前后端分离的项目，可以在查看器中与后端链路和日志打通。详细操作步骤请参考[Kubernetes 应用的 RUM-APM-LOG 联动分析](https://www.yuque.com/dataflux/bp/k8s-rum-apm-log)。<br />![1648797778(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648797850695-729dc7c5-6fda-4efc-b616-6dd23c73c18e.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=832&id=ueb98ca4f&margin=%5Bobject%20Object%5D&name=1648797778%281%29.png&originHeight=832&originWidth=1893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=142472&status=done&style=none&taskId=ue7581202-918a-4ca6-877d-e85079df1b8&title=&width=1893)<br />![1648798302(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648798308087-bea60457-d327-4117-a451-136323b01122.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=519&id=u1e20d463&margin=%5Bobject%20Object%5D&name=1648798302%281%29.png&originHeight=519&originWidth=1497&originalType=binary&ratio=1&rotation=0&showTitle=false&size=45744&status=done&style=none&taskId=u72b9c4f5-08a7-40cf-9ec7-51494d87cfd&title=&width=1497)

![1648798302.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648798315689-926669fd-9930-480d-9bd6-3d8ca95034a4.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=881&id=u1b451e80&margin=%5Bobject%20Object%5D&name=1648798302.png&originHeight=881&originWidth=1505&originalType=binary&ratio=1&rotation=0&showTitle=false&size=101949&status=done&style=none&taskId=u45fe9c00-eb97-4ff3-b6fd-dcf493fc465&title=&width=1505)

## APM
        登录『 [观测云](https://console.guance.com/)』，进入『应用性能监测』。通过应用性能监测，查看链路数据。<br />![](https://cdn.nlark.com/yuque/0/2021/png/21583952/1635152132752-662755ed-cf69-4df9-8d1e-fc03af5e648c.png#crop=0&crop=0&crop=1&crop=1&from=url&id=EkVbW&margin=%5Bobject%20Object%5D&originHeight=700&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />![1648799737(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648799742176-43adb3ac-e4b9-4101-9c7d-03b5b122685d.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=868&id=ud7a6fee8&margin=%5Bobject%20Object%5D&name=1648799737%281%29.png&originHeight=868&originWidth=1892&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134965&status=done&style=none&taskId=ue7c545d8-9968-42ae-9d01-935b5aa470a&title=&width=1892)
# 日志
## stdout
        根据部署 datakit 时的配置，默认采集输出到 /dev/stdout 的日志。 登录『 [观测云](https://console.guance.com/)』，进入『日志』，查看日志信息。<br />![1648800955(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648800969977-7f42e161-9199-42b6-ab6c-6383c68ab8bd.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=809&id=u52b00771&margin=%5Bobject%20Object%5D&name=1648800955%281%29.png&originHeight=809&originWidth=1878&originalType=binary&ratio=1&rotation=0&showTitle=false&size=177871&status=done&style=none&taskId=u2258af2e-71ac-482b-aa8b-57daeeb86b4&title=&width=1878)<br />『温馨提示』更多日志采集方式，请参考：<br />[Pod 日志采集最佳实践](https://www.yuque.com/dataflux/bp/pod-log)<br />[Kubernetes 集群中日志采集的几种玩法](https://www.yuque.com/dataflux/bp/mk0gcl)
# 链路超时分析
        Bookinfo 项目有个演示超时的示例，使用 jason 用户登录，ratings 服务会超时。新建 virtual-service-ratings-test-delay.yaml  内容如下：
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ratings
  namespace: prod
spec:
  hosts:
  - ratings
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    fault:
      delay:
        percentage:
          value: 100.0
        fixedDelay: 7s
    route:
    - destination:
        host: ratings
        subset: v1
  - route:
    - destination:
        host: ratings
        subset: v1

```
        创建资源。
```

kubectl apply -f virtual-service-ratings-test-delay.yaml 
```
        使用 jason 登录，密码为空。

![1648802663.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648802816743-2a8cda89-f4d1-43ac-8e74-9064cc2e1049.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=627&id=u3e7aa7dd&margin=%5Bobject%20Object%5D&name=1648802663.png&originHeight=627&originWidth=1792&originalType=binary&ratio=1&rotation=0&showTitle=false&size=58815&status=done&style=none&taskId=u176a9a25-0061-4e49-a08c-36ee9b558ab&title=&width=1792)<br />        访问  [http://8.136.193.105:32156/productpage](http://8.136.193.105:32156/productpage)，此时 ratings 服务不可达。<br />![1648802837(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648802842177-c20d59f0-c5ca-4dce-890a-e8cc9dee9dde.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=645&id=u4cf86d8f&margin=%5Bobject%20Object%5D&name=1648802837%281%29.png&originHeight=645&originWidth=1914&originalType=binary&ratio=1&rotation=0&showTitle=false&size=59356&status=done&style=none&taskId=uc9bae356-2912-40ec-80dc-97713dbdf80&title=&width=1914)<br />         登录『 [观测云](https://console.guance.com/)』，进入『应用性能监测』。点击超时的链路。<br />![1648802947(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648802979261-02ff7fb6-8b29-485a-8a43-8beae9233eb7.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=492&id=u6875e059&margin=%5Bobject%20Object%5D&name=1648802947%281%29.png&originHeight=811&originWidth=1904&originalType=binary&ratio=1&rotation=0&showTitle=false&size=135042&status=done&style=none&taskId=u6a1f1a5e-4e59-44b3-a38c-48f78c5cfde&title=&width=1153.939327243497)<br />        观测火焰图，找出超时调用。<br />![1648802964(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648802984885-45357503-b490-46e3-9d52-ba12b6411bd3.png#clientId=u7fe3f993-409f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=519&id=ue72967cd&margin=%5Bobject%20Object%5D&name=1648802964%281%29.png&originHeight=856&originWidth=1523&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74686&status=done&style=none&taskId=u9f9ad3b8-e124-4064-8ca8-b3376ea9177&title=&width=923.0302496805914)
