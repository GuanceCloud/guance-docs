# 简介
        上篇文件介绍了在 Kubernetes 环境部署 DataKit，在 Istio 环境部署 Bookinfo 项目，为 reviews 微服务配置 CICD 的 Pipeline 并使用金丝雀发布 reviews 的三个版本。本篇将介绍 Kubernetes 的可观测和 Istio 的可观测。

# 1 Kubernetes 可观测
## 1.1 Docker 监控视图

        在 Kubernetes 集群中， Pod 是最小的调度单元，一个 Pod 可以包含一个或多个容器，在观测云中，可以使用 **Docker 监控视图**对容器进行可观测。<br />        登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Docker 监控视图**。<br />![1648693652(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648693700884-b5c799b7-6162-45c3-b89e-a60305f4ce54.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=586&id=ucc3c9b8b&margin=%5Bobject%20Object%5D&name=1648693652%281%29.png&originHeight=659&originWidth=1357&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52695&status=done&style=none&taskId=ubc20b0b0-7e58-49e7-9e0b-cffca2ba2b1&title=&width=1206.2222222222222)<br />        仪表板名称填 **Docker 监控视图1**，名称可以自定义，点击『确定』。<br />![1648693689(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648693707159-b79a0437-08be-4228-90f6-c88355cb6b2f.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=476&id=u9286ac82&margin=%5Bobject%20Object%5D&name=1648693689%281%29.png&originHeight=535&originWidth=732&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9860&status=done&style=none&taskId=u852af5dd-1ac0-4432-8f8b-f9678292861&title=&width=650.6666666666666)<br />        进入监控视图，选择主机名和容器名。<br />![1648692874(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648692886223-e006691c-d63d-4a36-b01f-f49536da771a.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=696&id=u650afdcf&margin=%5Bobject%20Object%5D&name=1648692874%281%29.png&originHeight=783&originWidth=1893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97185&status=done&style=none&taskId=u8f87cbec-c47a-4d48-b1e7-b89787ae5e9&title=&width=1682.6666666666667)

## 1.2 Kubernetes 监控视图
        登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Kubernetes 监控视图**。

![1648691529(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648691600067-1cc9acf4-e202-4454-8648-7ef17a5bc79d.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=517&id=u33e25714&margin=%5Bobject%20Object%5D&name=1648691529%281%29.png&originHeight=582&originWidth=1154&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37582&status=done&style=none&taskId=u266fdfac-a7f4-47bb-8a46-3dea7c3c954&title=&width=1025.7777777777778)<br />        仪表板名称填 **Kubernetes 监控视图**，名称可以自定义，点击『确定』。<br />![1648694802(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648694808731-1a4d7611-3926-4ec9-adff-f94c816cca58.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=476&id=u6e653b60&margin=%5Bobject%20Object%5D&name=1648694802%281%29.png&originHeight=535&originWidth=728&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9672&status=done&style=none&taskId=ub6f5b79e-f6f5-439a-b846-33d1bcf5ba9&title=&width=647.1111111111111)<br />         进入监控视图，选择集群名称和命名空间。<br />『注意』集群名称下拉框是在上篇中部署 DataKit 设置的。<br />![1648690629.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648690639509-ec8bf916-2a62-49a7-8bdf-a662844ef2c3.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=716&id=uf5754fed&margin=%5Bobject%20Object%5D&name=1648690629.png&originHeight=805&originWidth=1654&originalType=binary&ratio=1&rotation=0&showTitle=false&size=257379&status=done&style=none&taskId=ua870ebfe-c027-49b3-b5f6-d590bb77863&title=&width=1470.2222222222222)<br />![1648690647.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648690652729-62c14ed4-2082-4cfa-8a5d-3e697a54f432.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=243&id=u567c69e0&margin=%5Bobject%20Object%5D&name=1648690647.png&originHeight=273&originWidth=1642&originalType=binary&ratio=1&rotation=0&showTitle=false&size=16358&status=done&style=none&taskId=ucce508b9-4836-4b91-b95f-838be09df4c&title=&width=1459.5555555555557)

## 1.3 ETCD 监控视图
### 1.3.1 开通 ETCD 采集器
        在 Kubernetes 集群，开通采集器需要使用 ConfigMap 定义配置，然后挂载到 DataKit 相应目录。etcd.conf 内容如下：
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### etcd
    etcd.conf: |-    
        [[inputs.prom]]
          ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
          ## 文件路径各个操作系统下不同
          ## Windows example: C:\\Users
          ## UNIX-like example: /usr/local/
          urls = ["https://172.16.0.229:2379/metrics"]

          ## 采集器别名
          source = "etcd"

          ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
          # 默认只采集 counter 和 gauge 类型的指标
          # 如果为空，则不进行过滤
          metric_types = ["counter", "gauge"]

          ## 指标名称过滤
          # 支持正则，可以配置多个，即满足其中之一即可
          # 如果为空，则不进行过滤
          metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]

          ## 指标集名称前缀
          # 配置此项，可以给指标集名称添加前缀
          measurement_prefix = ""

          ## 指标集名称
          # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
          # 如果配置measurement_name, 则不进行指标名称的切割
          # 最终的指标集名称会添加上measurement_prefix前缀
          # measurement_name = "prom"

          ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
          interval = "10s"

          ## 过滤tags, 可配置多个tag
          # 匹配的tag将被忽略
          # tags_ignore = ["xxxx"]

          ## TLS 配置
          tls_open = true
          #tls_ca = "/etc/kubernetes/pki/etcd/ca.crt"
          tls_cert = "/etc/kubernetes/pki/etcd/peer.crt"
          tls_key = "/etc/kubernetes/pki/etcd/peer.key"

          ## 自定义指标集名称
          # 可以将包含前缀prefix的指标归为一类指标集
          # 自定义指标集名称配置优先measurement_name配置项
          [[inputs.prom.measurements]]
            prefix = "etcd_"
            name = "etcd"

          ## 自定义认证方式，目前仅支持 Bearer Token
          # [inputs.prom.auth]
          # type = "bearer_token"
          # token = "xxxxxxxx"
          # token_file = "/tmp/token"

          ## 自定义Tags


```
        登录『Rancher』，在浏览集群标签下，选择『k8s-solution-cluster』集群，依次进入『更多资源』-> 『Core』-> 『ConfigMaps』，选择 datakit 空间，在 datakit.conf 行点击**编辑配置**，点击『添加』，加入 etcd.conf 配置后点击『保存』。<br />![1648719560(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648719569906-cb1285bd-692a-47fb-9b8b-71cdc672ce35.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=675&id=u3ff4c340&margin=%5Bobject%20Object%5D&name=1648719560%281%29.png&originHeight=759&originWidth=1917&originalType=binary&ratio=1&rotation=0&showTitle=false&size=58440&status=done&style=none&taskId=u50e30d4f-7010-4257-8675-e6d6648acd1&title=&width=1704)

![1648718989(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648718997104-fb5b92de-6bb5-4722-b651-4017cb6c882d.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=679&id=ue1307695&margin=%5Bobject%20Object%5D&name=1648718989%281%29.png&originHeight=764&originWidth=1895&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70749&status=done&style=none&taskId=u325eb38b-ea69-4904-a032-78331ffa588&title=&width=1684.4444444444443)<br />        登录『Rancher』，在浏览集群标签下，选择『k8s-solution-cluster』集群，依次进入『工作负载』-> 『DaemonSets』，选择 datakit 工作空间，在 datakit 列，点击右边**编辑配置**。 <br />![1648719842(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648719904190-00814f8f-3c08-4c57-8ca0-a2d789ac8850.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=734&id=ub2d848a2&margin=%5Bobject%20Object%5D&name=1648719842%281%29.png&originHeight=826&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64506&status=done&style=none&taskId=u9287cfaf-0615-4337-ad36-2a6d9f50b42&title=&width=1706.6666666666667)<br />        进入**存储**界面，添加 etcd.conf 挂载的目录 /usr/local/datakit/conf.d/etcd/etcd.conf，点击『保存』<br />![1648719889(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648719911532-9fa6ed0b-a0b9-4780-873f-72edc1b3ff75.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=668&id=u74eafc3d&margin=%5Bobject%20Object%5D&name=1648719889%281%29.png&originHeight=752&originWidth=1898&originalType=binary&ratio=1&rotation=0&showTitle=false&size=67262&status=done&style=none&taskId=ud8dd4b97-2c51-491f-80bd-7f7d711806a&title=&width=1687.111111111111)<br />      
### 1.3.2 挂载证书文件
        使用 https 采集 etcd 指标，需要使用 Kubernetes 集群的证书。即需要把 Kubeadmin 部署集群的 /etc/kubernetes/pki/etcd 目录，挂载到 datakit 的 /etc/kubernetes/pki/etcd 目录。
```
      volumes:
      - hostPath:
          path: /etc/kubernetes/pki/etcd
        name: dir-etcd
```
```
          volumeMounts:
          - mountPath: /etc/kubernetes/pki/etcd
          name: dir-etcd   
```

        下面使用 Rancher 来完成配置。登录『Rancher』，在浏览集群标签下，选择『k8s-solution-cluster』集群，依次进入『工作负载』-> 『DaemonSets』，选择 datakit 工作空间，在 datakit 列，点击右边**编辑 YAML**。<br />![1648720702(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648720710600-07e47156-14ff-475a-b7a6-885381919117.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=748&id=u88304c74&margin=%5Bobject%20Object%5D&name=1648720702%281%29.png&originHeight=842&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60688&status=done&style=none&taskId=u02efcc89-6c85-443e-9876-428dc97fc7f&title=&width=1696)<br />         添加如图内容后，点击保存。<br />![1648720650(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648721070558-9eafec08-73b1-4122-b217-1162b309b03c.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=700&id=uf044c65e&margin=%5Bobject%20Object%5D&name=1648720650%281%29.png&originHeight=788&originWidth=1731&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46561&status=done&style=none&taskId=ud2065c9b-039d-42bd-8d0e-f225d42ff35&title=&width=1538.6666666666667)<br />![1648720616(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648721077809-4baf07d6-2ac2-4258-9784-6a6c2ffb5af6.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=719&id=u11a63523&margin=%5Bobject%20Object%5D&name=1648720616%281%29.png&originHeight=809&originWidth=1708&originalType=binary&ratio=1&rotation=0&showTitle=false&size=41091&status=done&style=none&taskId=ue62d0911-0669-4bdf-8868-fb978fd3e48&title=&width=1518.2222222222222)



### 1.3.3 实现 ETCD 可观测
         登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** ETCD 监控视图**。

         仪表板名称填 **ETCD 监控视图**，名称可以自定义，点击『确定』。<br />![1648775826(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648775832581-7434f052-aba6-4d95-9782-b1361794c3da.png#clientId=uf25fbcc1-790e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=473&id=u2d8e2412&margin=%5Bobject%20Object%5D&name=1648775826%281%29.png&originHeight=532&originWidth=726&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9231&status=done&style=none&taskId=u9d0d514f-3f56-4c54-a50f-360cbdf35b3&title=&width=645.3333333333334)

         进入监控视图，选择集群名称。<br />![1648718494(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648718500659-037d3444-508c-417d-9a2a-64e555dbab70.png#clientId=ud94b4d9d-be14-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=762&id=ub259604d&margin=%5Bobject%20Object%5D&name=1648718494%281%29.png&originHeight=857&originWidth=1667&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56206&status=done&style=none&taskId=u91aaf078-005a-4c0d-aa21-2cdf8b50477&title=&width=1481.7777777777778)

       需要了解更多 ETCD 接入方式，请参考 [ETCD](https://www.yuque.com/dataflux/integrations/etcd) 集成文档。
# 2 Istio 可观测
## 2.1 Istio **Mesh  **监控视图
        登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Istio Mesh 监控视图**。<br />![1652341680(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652341690390-58f79aeb-8919-4636-9838-ad0895c581d5.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=604&id=ud8a51423&margin=%5Bobject%20Object%5D&name=1652341680%281%29.png&originHeight=815&originWidth=1680&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50288&status=done&style=none&taskId=u2b5dba71-a6d9-4eec-a7c3-e7d23e50faa&title=&width=1244.4445323551695)<br />        仪表板名称填 **Istio Mesh 监控视图**，名称可以自定义，点击『确定』。<br />![1652342031(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652342039859-eff2e3dd-d428-4e00-8f46-c94915383486.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=329&id=u02801b71&margin=%5Bobject%20Object%5D&name=1652342031%281%29.png&originHeight=444&originWidth=606&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7625&status=done&style=none&taskId=u7021e023-468f-4a4e-bf6f-ac4d5319ebe&title=&width=448.88892059954327)<br />         进入监控视图，选择集群名称。<br />![1652342099(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652342107520-c578f280-3941-45ba-bb5f-f3772e445909.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=416&id=ue1f0a939&margin=%5Bobject%20Object%5D&name=1652342099%281%29.png&originHeight=561&originWidth=1904&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75842&status=done&style=none&taskId=ubcc5307b-9952-47be-b04e-65599d537b7&title=&width=1410.3704700025255)<br />![1652342424(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652342430511-23fb2730-c09e-4813-86e8-f31c79b1ebe5.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=225&id=ue4ace3f2&margin=%5Bobject%20Object%5D&name=1652342424%281%29.png&originHeight=304&originWidth=1693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=18301&status=done&style=none&taskId=u7526b67f-a588-4d9f-affc-fbdaed2d9f0&title=&width=1254.0741626650608)
## 2.2 Istio **Control Plane **监控视图
         登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Istio Control Plane 监控视图**。<br />![1652344137(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344146062-38011de7-c43a-48e6-9608-ababc74c34ab.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=328&id=u255d13d2&margin=%5Bobject%20Object%5D&name=1652344137%281%29.png&originHeight=443&originWidth=607&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7920&status=done&style=none&taskId=u71a085af-d972-4d55-aa18-06ed1928cd9&title=&width=449.62966139261187)<br />         进入监控视图，选择集群名称。<br />![1652342497(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652342534748-cfd8f78f-4aba-47f5-a688-eb00d1c149c3.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=521&id=ucbcf0033&margin=%5Bobject%20Object%5D&name=1652342497%281%29.png&originHeight=704&originWidth=1691&originalType=binary&ratio=1&rotation=0&showTitle=false&size=40446&status=done&style=none&taskId=udda18fb4-ceff-4f96-bdf8-404af744444&title=&width=1252.5926810789235)<br />![1652342509(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652342540768-5f3a0b6e-9ad0-4a2d-97dc-0a3d44ef5a9c.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=359&id=u9d05c0d2&margin=%5Bobject%20Object%5D&name=1652342509%281%29.png&originHeight=485&originWidth=1691&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37182&status=done&style=none&taskId=u0d599bde-84bc-4563-b655-144fa062afe&title=&width=1252.5926810789235)<br />![1652342520(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652342547110-7128c314-58c9-49ec-98f4-0d5ade07586a.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=379&id=ue163f1a4&margin=%5Bobject%20Object%5D&name=1652342520%281%29.png&originHeight=512&originWidth=1691&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38158&status=done&style=none&taskId=u32e1e3ba-a110-451d-a445-c3b8a3afc5f&title=&width=1252.5926810789235)

## 2.3 Istio **Service **监控视图
         登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Istio Service 监控视图**。<br />![1652344434(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344546539-2fc4c481-debb-497f-9e64-ce70fb028231.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=329&id=u1b419002&margin=%5Bobject%20Object%5D&name=1652344434%281%29.png&originHeight=444&originWidth=603&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7413&status=done&style=none&taskId=ube2a6454-c919-487d-a4f1-a16f01df397&title=&width=446.66669822033765)<br />         进入监控视图，选择集群名称。<br />![1652344477(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344561280-d1feadaf-817b-454c-b636-2aa89ee69df7.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=597&id=u003cabed&margin=%5Bobject%20Object%5D&name=1652344477%281%29.png&originHeight=806&originWidth=1699&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69291&status=done&style=none&taskId=ud68f663e-155b-456a-8f5a-7e1b96f56dd&title=&width=1258.518607423472)<br />![1652344488(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344567437-76e2d1c4-22bf-4690-b174-4f02870e3390.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=292&id=u51d59f95&margin=%5Bobject%20Object%5D&name=1652344488%281%29.png&originHeight=394&originWidth=1696&originalType=binary&ratio=1&rotation=0&showTitle=false&size=23282&status=done&style=none&taskId=u5d982453-02db-4062-a5fb-b682d949083&title=&width=1256.2963850442663)

## 2.4 Istio **Workload **监控视图
         登录『[观测云](https://console.guance.com/)』，点击『场景』->『新建仪表板』，选择** Istio Workload 监控视图**。<br />![1652344656(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344663694-6dfe2aee-8c8c-478d-b009-5bd3705462a8.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=327&id=u4f87233f&margin=%5Bobject%20Object%5D&name=1652344656%281%29.png&originHeight=441&originWidth=601&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7398&status=done&style=none&taskId=u6ebd24bb-dd71-4093-a2d7-d8ed5bfc7e6&title=&width=445.1852166342005)<br />         进入监控视图，选择集群名称。<br />![1652344711(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344750727-07587189-98fa-430c-aa10-55f638a8ca7e.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=341&id=u5bee656e&margin=%5Bobject%20Object%5D&name=1652344711%281%29.png&originHeight=460&originWidth=1697&originalType=binary&ratio=1&rotation=0&showTitle=false&size=55172&status=done&style=none&taskId=ud307ed36-9afa-4d64-bef9-c339a17652e&title=&width=1257.037125837335)<br />![1652344724(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344756267-dfebcb47-f728-4dbe-b251-c41ed75f58bc.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=546&id=u5f881a2a&margin=%5Bobject%20Object%5D&name=1652344724%281%29.png&originHeight=737&originWidth=1695&originalType=binary&ratio=1&rotation=0&showTitle=false&size=78395&status=done&style=none&taskId=uf525695d-8dc4-43b5-9d58-3a8e772e10f&title=&width=1255.555644251198)<br />![1652344740(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652344763358-6e7d8f17-efa2-4d37-a521-69da2855ba09.png#clientId=uf14cfd5a-bd16-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=541&id=u327ee8f4&margin=%5Bobject%20Object%5D&name=1652344740%281%29.png&originHeight=730&originWidth=1688&originalType=binary&ratio=1&rotation=0&showTitle=false&size=77560&status=done&style=none&taskId=u1823f465-9d0e-43cb-b23e-83c3f80d94b&title=&width=1250.370458699718)


