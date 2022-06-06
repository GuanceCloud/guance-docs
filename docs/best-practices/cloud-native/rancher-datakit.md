# 简介
企业有一定规模后，服务器、kubernetes 环境、微服务应用会越来越多，如何高效地对这些资源进行可观测，节省人力、资源成本是企业面临的问题。通过一键部署Rancher应用商店内的 Datakit，观测云对 Rancher管控的 k8s 集群，提供了大量开箱即用的可观测功能。<br />本文通过一个耳熟能详的 service mesh 微服务架构Bookinfo 案例，详细解释下如何利用观测云一键提升 K8S , istio, 持续集成,金丝雀发布,以及微服务端到端全链路的可观测性。        <br />       观测云是一家致力于云原生领域可观测的头部企业，使用一个平台、部署 DataKit Agent 即可把主机、应用的指标、链路、日志串联起来。用户登录观测云即可实时主动观测自己的 k8s 运行时与微服务应用健康状态.
# 案例假设
        假设一公司拥有若干台云服务器，两套 Kubernetes 集群，一套测试环境，一套生产环境，测试环境有一台 Master 节点，两台 Node 节点。在云服务器上部署了 Harbor、Gitlab、在 Kubernetes 测试环境部署了 Istio 项目bookinfo，现在使用观测云进行主机、Kubernetes 集群、Gitlab CI、金丝雀发布、RUM、APM、Istio 等做可观测。
# 前置条件

- 安装 [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+。
- 安装 [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/)，并有操作 Kubernetes 集群的权限。
- 安装 [Gitlab](https://about.gitlab.com/  )。
- 安装 [Helm](https://github.com/helm/helm) 3.0+。
- 部署 harbor 仓库或其它镜像仓库。
# 环境版本
        本次示例使用版本如下，DataKit 版本不同，配置可能存在差异。

- Kubernetes 1.22.6
- Rancher 2.6.3
- Gitlab 14.9.4
- Istio 1.13.2
- DataKit 1.4.0
# 操作步骤
## 步骤 1： 使用 Rancher 安装 DataKit
         为方便管理，DataKit 安装到 datakit 命名空间。登录『Rancher』-> 『集群』-> 『项目/命名空间』，点击『创建命名空间』。<br />![1652597953.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652597961569-7e1cdb6e-6629-4e9d-973f-70517c96c696.png#clientId=u76a54c05-07d1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=456&id=u4e5b90cd&margin=%5Bobject%20Object%5D&name=1652597953.png&originHeight=615&originWidth=1914&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49255&status=done&style=none&taskId=uec8692ca-33b9-4813-ba18-7beffcb4c64&title=&width=1417.777877933211)<br />        名称输入“datakit”,点击『创建』。<br />![1652597952(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652597971457-4d1f6ccc-d17f-4f5c-8b7e-affc59218a02.png#clientId=u76a54c05-07d1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=499&id=ue5efcc4b&margin=%5Bobject%20Object%5D&name=1652597952%281%29.png&originHeight=673&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49566&status=done&style=none&taskId=ubacd85b9-1eb6-4df1-83c5-120c90820fe&title=&width=1413.3334331747997)<br />         『集群』-> 『应用市场』-> 『Chart 仓库』，点击『创建』。名称输入 **datakit**，URL 输入 [https://pubrepo.guance.com/chartrepo/datakit](https://pubrepo.guance.com/chartrepo/datakit)，点击『创建』。<br />![1652425459.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652425465435-f3413f1d-341c-447f-84ce-c282177b87ea.png#clientId=udea9cda1-5ad9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=639&id=ucc8cdb6c&margin=%5Bobject%20Object%5D&name=1652425459.png&originHeight=862&originWidth=1904&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49816&status=done&style=none&taskId=uc8b4ce66-57cd-49fd-bdff-4e82ee9f993&title=&width=1410.3704700025255)<br />        进入『集群』-> 『应用市场』-> 『Charts』,   选择 datakit，出现下图带 **DataKit** 的图表，点击进去。 <br />![1652425547(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652425577368-91e60182-6a7e-4907-877d-f9f2e00317eb.png#clientId=udea9cda1-5ad9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=413&id=u4b1940ac&margin=%5Bobject%20Object%5D&name=1652425547%281%29.png&originHeight=558&originWidth=941&originalType=binary&ratio=1&rotation=0&showTitle=false&size=26222&status=done&style=none&taskId=u06301bcf-cb1b-4c8d-bf5c-5080931d7a1&title=&width=697.0370862775086)<br />        点击『安装』。<br />![1653614849(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653614853976-4bb10782-5cb7-417c-b56c-6331f040caf4.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u727994d1&margin=%5Bobject%20Object%5D&name=1653614849%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103298&status=done&style=none&taskId=ue96eea5d-996e-499c-968c-45efdfdfc09&title=&width=1280)<br />        命名空间选择 **datakit**，点击『下一步』。<br />![1653614894(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653614901381-20b5dfca-7802-49d6-95eb-a808d31f033e.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u31dd88c6&margin=%5Bobject%20Object%5D&name=1653614894%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=39929&status=done&style=none&taskId=u3abacd86-d0d4-4b1b-8e0b-a308bd1b61d&title=&width=1280)<br />        登录『[观测云](https://console.guance.com/)』，进入『管理』模块，找到下图中 token，点击旁边的复制图表。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648545764623-52524aa3-2232-40cb-aa36-d54e4d0108d8.png?x-oss-process=image%2Fresize%2Cw_1012%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=iXKFa&margin=%5Bobject%20Object%5D&originHeight=535&originWidth=1012&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />        切换到 Rancher 界面，替换下图中的 token 为复制的 token，**Enable The Default Inputs** 增加 **ebpf 采集器**，即在最后增加 “,ebpf”，注意是以逗号做分割。DataKit Global Tags 最后增加 “,cluster_name_k8s=k8s-prod”，其中  k8s-prod 为您的集群名称，可以自己定义，为集群采集到的指标设置全局 tag。<br />![1653615057(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653615067021-d1769f7f-535b-41c3-8bde-e3d98859b963.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u3bef4953&margin=%5Bobject%20Object%5D&name=1653615057%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=79075&status=done&style=none&taskId=ub72b1f7b-6dda-43ee-903e-8cdcdf51e2e&title=&width=1280)<br />        点击“Kube-State-Metrics”，选择安装。<br />![1653615142(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653615149463-2940242f-b76b-4184-a180-25179039ae8d.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=ELwSt&margin=%5Bobject%20Object%5D&name=1653615142%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47609&status=done&style=none&taskId=u75e79148-6061-4ec0-b7a9-717e89bf7ab&title=&width=1280)<br />        点击“metrics-server”，选择安装，点击下发『安装』按钮。<br />![1653615390.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653615456644-dc1eeea6-8f05-4e80-bdcf-cbeb80d6e7a5.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=ucc8e2920&margin=%5Bobject%20Object%5D&name=1653615390.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46968&status=done&style=none&taskId=u72a850f0-3079-456d-acda-3047794018f&title=&width=1280)<br />        进入『集群』-> 『应用市场』-> 『已安装的 Apps』，查看到 DataKit 已经安装成功。<br />![1653615866(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653615898534-281224bf-4f41-4c3e-87a6-fc2806ae2fb4.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=uf4b54523&margin=%5Bobject%20Object%5D&name=1653615866%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38260&status=done&style=none&taskId=ubae8f924-5b9f-4bc8-848a-270687b1dae&title=&width=1280)<br />         进入『集群』-> 『工作负载』-> 『Pods』，查看到 datakit 命名空间已经运行了三个 Datakit 、一个 kube-state-metrics 和一个 metrics-server。<br />![1653615980(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653616049528-875cfe74-e3d4-42c3-8485-f6b03cab0ddc.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u9b3a0850&margin=%5Bobject%20Object%5D&name=1653615980%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57467&status=done&style=none&taskId=ue261d4fc-542c-48c5-802f-87c978d0ebe&title=&width=1280)<br />        由于公司有多个集群，需要增加 ENV_NAMESPACE 环境变量，这个环境变量是为了区分不同集群的选举，多个集群 value 值不能相同。 进入『集群』-> 『工作负载』-> 『DaemonSets』，点击 datakit 行的右边，选择『编辑配置』。<br />![1653616165(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653616174060-6fdc0c50-a530-4d6b-a6f9-2a782f845849.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=ub039cf3b&margin=%5Bobject%20Object%5D&name=1653616165%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=55857&status=done&style=none&taskId=u1101c268-b72c-4c0a-bf22-53dd61337d3&title=&width=1280)<br />        这里变量名输入“ENV_NAMESPACE”，值是“guance-k8s”，点击『保存』。<br />![1652686689(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652686702271-019c5bca-7fb7-46f4-9def-79a8f4be3a7f.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=ufe8563dc&margin=%5Bobject%20Object%5D&name=1652686689%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75611&status=done&style=none&taskId=u7fb2e8c0-914e-4559-b8a3-171304b3451&title=&width=1422.2223226916224)

## 步骤 2： 开启 Kubernetes 可观测
### 2.1 ebpf 可观测
#### 2.1.1 开启采集器
        在部署 DataKit 时已经开启了 **ebpf 采集器。**
#### 2.1.2 ebpf 视图
         登录『[观测云](https://console.guance.com/)』-> 『基础设施』，点击 **k8s-node1**。<br />![1652592057(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652592126652-473a4f4d-cf6a-4eaf-ae85-039aad17366d.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=465&id=ud0c6f9e9&margin=%5Bobject%20Object%5D&name=1652592057%281%29.png&originHeight=628&originWidth=1895&originalType=binary&ratio=1&rotation=0&showTitle=false&size=55333&status=done&style=none&taskId=u79dd6197-333a-49b3-af55-572c942288c&title=&width=1403.7038028649085)<br />        点击 『网络』，查看 ebpf 的监控视图。<br />![1652592082(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652592137007-f14a7ead-5ec7-4cef-ac56-b3fd35356917.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=631&id=u5203837d&margin=%5Bobject%20Object%5D&name=1652592082%281%29.png&originHeight=852&originWidth=1528&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90368&status=done&style=none&taskId=u42f51780-88ee-4fb1-95ce-62013cbd6c1&title=&width=1131.8519318087494)<br />![1652592099(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652592145691-3282bde6-ddb8-4484-a1f8-9b0d32fa9843.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=630&id=u49a862b6&margin=%5Bobject%20Object%5D&name=1652592099%281%29.png&originHeight=851&originWidth=1522&originalType=binary&ratio=1&rotation=0&showTitle=false&size=88026&status=done&style=none&taskId=u964b9988-285c-4475-9a37-b5f51ff80ae&title=&width=1127.4074870503382)
### 2.2 容器可观测
#### 2.2.1 开启采集器
        DataKit 默认已开启 Container 采集器，这里介绍一下自定义采集器配置。登录『Rancher』-> 『集群』-> 『存储』-> 『ConfigMaps』，点击『创建』。<br />![1652594500(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652594963128-5c043566-08bd-487f-ba0a-d4a038e873ab.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=520&id=u2ca979ac&margin=%5Bobject%20Object%5D&name=1652594500%281%29.png&originHeight=702&originWidth=1916&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49329&status=done&style=none&taskId=u1b0fea87-a6ca-4402-9ce7-21e8b9a055c&title=&width=1419.2593595193482)<br />        命名空间输入“datakit”，名称输入“datakit-conf”，键输入“container.conf”，值输入如下内容。注意，生产环境建议设置 container_include_log = [] 且 container_exclude_log = ["image:*"]，然后在需要采集log 的 Pod 上增加 annotations 来采集指定 container 的日志。
```
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  ## Containers metrics to include and exclude, default not collect. Globs accepted.
  container_include_metric = []
  container_exclude_metric = ["image:*"]

  ## Containers logs to include and exclude, default collect all containers. Globs accepted.
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
```
        填写内容如下图，点击『创建』。<br />![1652594686(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652594969999-d0bc7613-5113-4296-8c4b-e4f2cda89cd0.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u3790d0ce&margin=%5Bobject%20Object%5D&name=1652594686%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68775&status=done&style=none&taskId=u16df0d89-35ea-45de-8a3f-ca85e3e7115&title=&width=1422.2223226916224)<br />        『集群』-> 『工作负载』-> 『DaemonSets』，找到 datakit，点击『编辑配置』。        <br />![1653616165(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653616262320-cb95ccd6-3ee2-485d-b368-62245070ac4b.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u8a15320b&margin=%5Bobject%20Object%5D&name=1653616165%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=55857&status=done&style=none&taskId=u70815229-8787-4fc2-96f8-efc0c5c21c0&title=&width=1280)<br />        点击『存储』。      <br />![1653616308(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653616551670-fadd8fce-29c4-4c4d-8efb-8f5edd79393b.png#clientId=u301ab45d-64b5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=ub2ae7a54&margin=%5Bobject%20Object%5D&name=1653616308%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71672&status=done&style=none&taskId=u31a34e0d-6ccb-4068-a708-1fb0285f2d0&title=&width=1280)<br />        点击『添加卷』-> 『配置映射』。<br />![1652596190(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652596236262-f3bc94c9-a7af-4634-9fce-f9a46df566e7.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=544&id=ubae1b401&margin=%5Bobject%20Object%5D&name=1652596190%281%29.png&originHeight=735&originWidth=1862&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56991&status=done&style=none&taskId=ufe0e4374-4482-4c43-90fd-bbe6344b5b5&title=&width=1379.2593566936462)<br />        卷名称这里输入 datakit-conf，配置映射选择 **datakit.conf**，卷内子路径输入 **container.conf**，容器挂载路径输入 **/usr/local/datakit/conf.d/container/container.conf**。  点击『保存』。<br />![1652774319.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652774458542-9c492a9f-035d-4135-ac25-4385837d7f36.png#clientId=u4d8f5577-6a5a-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=ube1b1730&margin=%5Bobject%20Object%5D&name=1652774319.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=58615&status=done&style=none&taskId=u230b55b6-0bad-4653-aa6b-9cffb8cfb3d&title=&width=1599.9999364217147)
#### 2.2.2 Container 监控视图
        登录『[观测云](https://console.guance.com/)』-> 『基础设施』-> 『容器』，输入** host:k8s-node1**，显示 k8s-node1 节点的容器，点击 ingress。<br />![1652761871(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652761890726-462bdd84-821c-47ae-b6bd-2a74e0facf69.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u9bfe30ab&margin=%5Bobject%20Object%5D&name=1652761871%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=169016&status=done&style=none&taskId=u5cefff94-7df8-434c-89d4-238cf6d75c5&title=&width=1599.9999364217147)<br />        点击『指标』，查看 DataKit Container 的监控视图。<br />![1652761795(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652761846467-daa2de8b-74ef-4dbe-9cbf-9a338545f357.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u2be78641&margin=%5Bobject%20Object%5D&name=1652761795%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=100980&status=done&style=none&taskId=uba0988d1-5899-489d-8381-d2959403753&title=&width=1599.9999364217147)
### 2.3 Kubernetes 监控视图
#### 2.3.1 部署采集器
        在安装 DataKit 时已经安装了 metric-server 和 Kube-State-Metrics。
#### 2.3.2 部署 Kubernetes 监控视图
         登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“kubernetes 监控”，选择 “Kubernetes 监控视图”，点击『确定』。<br />![1652597037(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652597046667-0849565b-6182-484a-9a69-e1e0fd39c883.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=489&id=u9c12032c&margin=%5Bobject%20Object%5D&name=1652597037%281%29.png&originHeight=660&originWidth=1286&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38213&status=done&style=none&taskId=u4950cef3-f7fe-4509-9f4f-04fe43399eb&title=&width=952.5926598861595)<br />        点击新建的“Kubernetes 监控视图”，查看集群信息。<br />![1652664455(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652664497561-b6f2106d-9845-4beb-aa9b-1466bb8270a7.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=546&id=u7d2ad023&margin=%5Bobject%20Object%5D&name=1652664455%281%29.png&originHeight=737&originWidth=1697&originalType=binary&ratio=1&rotation=0&showTitle=false&size=230142&status=done&style=none&taskId=u80536750-00bf-44ce-b823-5558da11ee6&title=&width=1257.037125837335)<br />![1652664490(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652664506818-c9022f1e-4f0b-436d-9967-b857840bbdc7.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=566&id=u871ef7a1&margin=%5Bobject%20Object%5D&name=1652664490%281%29.png&originHeight=764&originWidth=1681&originalType=binary&ratio=1&rotation=0&showTitle=false&size=78519&status=done&style=none&taskId=uad22bb3a-3a0e-4aa4-8ceb-3f7ba8eb4c7&title=&width=1245.1852731482381)
### 2.4 Kubernetes Overview with Kube State Metrics 监控视图
#### 2.4.1 开启采集器
        登录『Rancher』-> 『集群』-> 『存储』-> 『ConfigMaps』，找到 datakit-conf，点击『编辑配置』。<br />![1652687966(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652687973298-b7d8ade3-6113-4349-96d1-1d409f03e350.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u52bb33f1&margin=%5Bobject%20Object%5D&name=1652687966%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46510&status=done&style=none&taskId=u87e29ea1-0536-44fa-8679-68874212c27&title=&width=1422.2223226916224)<br />        点击『添加』，键输入“kube-state-metrics.conf”，值输入如下内容，点击『保存』。
```
          [[inputs.prom]]
            urls = ["http://datakit-kube-state-metrics.datakit.svc.cluster.local:8080/metrics","http://datakit-kube-state-metrics.datakit.svc.cluster.local:8081/metrics"]
            source = "prom_state_metrics"
            metric_types = ["counter", "gauge"]
            interval = "10s"
            #measurement_prefix = ""
            measurement_name = "prom_state_metrics"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"         
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
            pod_name = "$PODNAME"
```
#### ![1652688255(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652688271681-7f126eb2-7427-4956-bfcb-7eee4ba2dd69.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u42d93752&margin=%5Bobject%20Object%5D&name=1652688255%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=77142&status=done&style=none&taskId=uf7c64d80-7e76-4e32-9348-acaad366ce9&title=&width=1422.2223226916224)
        进入『集群』-> 『工作负载』-> 『DaemonSets』，点击 datakit 行的右边，选择『编辑配置』。 点击『存储』，找到卷名称是“datakit-conf”的配置映射，点击『添加』，容器挂载路径填“/usr/local/datakit/conf.d/prom/kube-state-metrics.conf”，卷内子路径输入“kube-state-metrics.conf”，点击『保存』。<br />![1652774066(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652774077741-709251b2-9af0-43ea-a31a-34a73e1437f5.png#clientId=u4d8f5577-6a5a-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=uacf1cd8f&margin=%5Bobject%20Object%5D&name=1652774066%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61791&status=done&style=none&taskId=ufb26bb8d-229f-4933-b8b2-0cd92dfd8bd&title=&width=1599.9999364217147)
#### 2.4.2 Kubernetes Overview with Kube State Metrics 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“kubernetes Overview”，选择 “Kubernetes Overview with Kube State Metrics 监控视图”，点击『确定』。

![1652665339(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652665344415-1ae0e0db-64f3-4617-9a05-378382d2c448.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=473&id=u30db4312&margin=%5Bobject%20Object%5D&name=1652665339%281%29.png&originHeight=639&originWidth=1298&originalType=binary&ratio=1&rotation=0&showTitle=false&size=43080&status=done&style=none&taskId=ua4848391-9a55-4ab7-8063-fcb772e94fb&title=&width=961.4815494029822)<br />        点击新建的“Kubernetes Overview with KSM 监控视图”，查看集群信息。<br />![1652665202(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652665211223-a310ccb6-9114-4341-9e5d-a9d7c9171140.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=604&id=uf8887967&margin=%5Bobject%20Object%5D&name=1652665202%281%29.png&originHeight=815&originWidth=1676&originalType=binary&ratio=1&rotation=0&showTitle=false&size=188345&status=done&style=none&taskId=u6299cb14-0933-4259-9e55-a09e47a7a2c&title=&width=1241.4815691828953)
### 2.5 Kubernetes Overview by Pods 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“kubernetes Overview by”，选择 “Kubernetes Overview by Pods 监控视图”，点击『确定』。<br />![1652597166(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652597175155-754fc79a-4168-4d6b-bb6d-225d68a212b4.png#clientId=u5b75abdd-c1da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=440&id=ud64c1d61&margin=%5Bobject%20Object%5D&name=1652597166%281%29.png&originHeight=594&originWidth=1280&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38659&status=done&style=none&taskId=u72aef85a-99eb-4d93-af46-e0f9145ff6f&title=&width=948.1482151277482)<br />        点击新建的“Kubernetes Overview by Pods 监控视图”，查看集群信息。<br />![1652710990(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652711056855-b067ce14-2b40-41ad-983b-b5f4a15dcdef.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=472&id=u9bb043a1&margin=%5Bobject%20Object%5D&name=1652710990%281%29.png&originHeight=566&originWidth=1693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=297981&status=done&style=none&taskId=u6d53eb2d-5abe-4d0f-a566-0050a36a1eb&title=&width=1410.8332772718559)<br />![1652711015(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652711068174-047980bb-c802-4f30-a0e7-624455f7c147.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=647&id=u032e4695&margin=%5Bobject%20Object%5D&name=1652711015%281%29.png&originHeight=776&originWidth=1693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=110834&status=done&style=none&taskId=u9bb1309a-9467-4ac4-a300-53249f03fe5&title=&width=1410.8332772718559)
### 2.6 Kubernetes Services 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“kubernetes Services”，选择 “Kubernetes Services 监控视图”，点击『确定』。<br />![1652597213(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652597254660-c1c8f93e-526e-4606-bb2c-cf2ce88c2d86.png#clientId=u76a54c05-07d1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=456&id=u46ad134e&margin=%5Bobject%20Object%5D&name=1652597213%281%29.png&originHeight=616&originWidth=1289&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38032&status=done&style=none&taskId=uf19d8646-f89e-4c9d-8508-294d9d369be&title=&width=954.8148822653652)<br />        点击新建的“Kubernetes Services 监控视图”，查看集群信息。<br />![1652688847(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652688855449-cfe0f07a-5f89-40f1-815e-e851b2aedb02.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=635&id=u45f83cd8&margin=%5Bobject%20Object%5D&name=1652688847%281%29.png&originHeight=857&originWidth=1684&originalType=binary&ratio=1&rotation=0&showTitle=false&size=77763&status=done&style=none&taskId=u1976d59d-11c3-446e-9eb2-04925d1d5c9&title=&width=1247.4074955274436)
## 步骤 3：  部署 Istio 及应用
### 3.1 部署 Istio
        登录『Rancher』-> 『应用市场』-> 『Charts』，选择 Istio 进行安装。![1652788230(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652788431604-9ae30b19-4802-4ac8-9610-75f0617f7147.png#clientId=uf4de39b4-5c4c-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=ub34a9005&margin=%5Bobject%20Object%5D&name=1652788230%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=45686&status=done&style=none&taskId=u057d0884-3801-4de0-a725-61af32bb15a&title=&width=1599.9999364217147)
### 3.2 开通 Sidecar 注入
        新建 prod 命名空间，开启该空间下创建 Pod 时自动注入 Sidecar，让 Pod 的出入流量都转由 Sidecar 进行处理。登录『Rancher』-> 『集群』-> 『项目/命名空间』，点击『创建命名空间』。

![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652597961569-7e1cdb6e-6629-4e9d-973f-70517c96c696.png#crop=0&crop=0&crop=1&crop=1&from=url&id=QoA6V&margin=%5Bobject%20Object%5D&originHeight=615&originWidth=1914&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />         名称输入“prod”,点击『创建』。<br />![1652604069(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652604075864-10c0f20b-ec02-4d61-bbd0-ee4e5b816aeb.png#clientId=u225d25e6-9f4d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u15f97fa8&margin=%5Bobject%20Object%5D&name=1652604069%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54010&status=done&style=none&taskId=ud6711492-fa62-49ee-bfa0-ba901c1f3d8&title=&width=1422.2223226916224)<br />        点击 Rancher 上方的“命令行”图标，输入“kubectl label namespace prod istio-injection=enabled”回车。<br />![1652788644(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652788662139-99547b86-ab2c-4ae9-a9fc-4307198a5a2d.png#clientId=uf4de39b4-5c4c-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u75429b64&margin=%5Bobject%20Object%5D&name=1652788644%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=43883&status=done&style=none&taskId=uc93a4f11-1265-458b-9e21-ec76bbce784&title=&width=1599.9999364217147)

### 3.3 开启 Istiod 采集器
        登录『Rancher』-> 『集群』-> 『服务发现』-> 『Service』，查看 Service 名称是 istiod，空间是 istio-system。<br />![1652666990(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652667007739-df19549a-231b-4591-a462-f01e333fd472.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=ua37801d7&margin=%5Bobject%20Object%5D&name=1652666990%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=77663&status=done&style=none&taskId=ucdfc9742-61d0-41bf-b6f3-03f31fbc3c8&title=&width=1422.2223226916224)<br />        登录『Rancher』-> 『集群』-> 『存储』-> 『ConfigMaps』，找到 datakit-conf，点击『编辑配置』。<br />![1652687966(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652687973298-b7d8ade3-6113-4349-96d1-1d409f03e350.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=MR56D&margin=%5Bobject%20Object%5D&name=1652687966%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46510&status=done&style=none&taskId=u87e29ea1-0536-44fa-8679-68874212c27&title=&width=1422.2223226916224)<br />        点击『添加』，键输入“prom-istiod.conf”，值输入如下内容。点击『保存』。
```
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
![1652690803(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652690819677-d2e5e1fd-a798-412a-8d6e-deff57453bac.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u1192c179&margin=%5Bobject%20Object%5D&name=1652690803%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=81185&status=done&style=none&taskId=u78d9cb32-ecea-411d-9828-01821bb457c&title=&width=1422.2223226916224)<br />        进入『集群』-> 『工作负载』-> 『DaemonSets』，点击 datakit 行的右边，选择『编辑配置』。 点击『存储』，找到卷名称是“datakit-conf”的配置映射，点击『添加』，容器挂载路径填“/usr/local/datakit/conf.d/prom/prom-istiod.conf”，卷内子路径输入“prom-istiod.conf”，点击『保存』。<br />![1652774308(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652774318730-b3423745-cf8b-456a-9305-53d9d0bf609d.png#clientId=u4d8f5577-6a5a-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u9c1b8f4c&margin=%5Bobject%20Object%5D&name=1652774308%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=63508&status=done&style=none&taskId=u04439ac6-abf6-42e9-87b7-513f47bfeae&title=&width=1599.9999364217147)
### 3.4 开启 Zipkin 采集器
        登录『Rancher』-> 『集群』-> 『存储』-> 『ConfigMaps』，找到 datakit-conf，点击『编辑配置』。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652687973298-b7d8ade3-6113-4349-96d1-1d409f03e350.png#crop=0&crop=0&crop=1&crop=1&from=url&id=o7J3Y&margin=%5Bobject%20Object%5D&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />      点击『添加』，键输入“zipkin.conf”，值输入如下内容。点击『保存』。
```
[[inputs.zipkin]]
        pathV1 = "/api/v1/spans"
        pathV2 = "/api/v2/spans"
        customer_tags = ["project","version","env"]
```
![1652690862(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652690897249-fae7cab6-c084-4684-bd66-426f8111b7f9.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u51a7ed56&margin=%5Bobject%20Object%5D&name=1652690862%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=76562&status=done&style=none&taskId=u7b5d7513-9476-4b94-8c12-60a0ad1aef5&title=&width=1422.2223226916224)<br />        进入『集群』-> 『工作负载』-> 『DaemonSets』，点击 datakit 行的右边，选择『编辑配置』。 点击『存储』，找到卷名称是“datakit-conf”的配置映射，点击『添加』，容器挂载路径填“/usr/local/datakit/conf.d/zipkin/zipkin.conf”，卷内子路径输入“zipkin.conf”，点击『保存』。<br />![1652774396(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652774405792-deef447b-48b2-40de-bfa6-3c37ffbde70b.png#clientId=u4d8f5577-6a5a-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u7a418c43&margin=%5Bobject%20Object%5D&name=1652774396%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=65180&status=done&style=none&taskId=uab254ab1-9d1d-448e-b2e0-487112ce089&title=&width=1599.9999364217147)
### 3.5 映射 DataKit 服务
       在 Kubernets 集群中，以 DaemonSet 方式部署 DataKit 后，如果存在部署的某一应用以前是推送链路数据到 istio-system 名称空间的 zipkin 服务，端口是 9411，即访问地址是 zipkin.istio-system.svc.cluster.local:9411，这时就需要用到了 Kubernetes 的 ExternalName 服务类型。先定义一个 ClusterIP 的 服务类型，把 9529 端口转成 9411，然后使用 ExternalName 的服务将 ClusterIP 的服务映射成 DNS 的名称。通过这两步转换，应用就可以与 DataKit 打通了。
#### 3.5.1 定义 Cluster IP 服务
        登录『Rancher』-> 『集群』-> 『服务发现』-> 『Service』，点击『创建』，选择“集群 IP”。<br />![1652668032(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652668039558-b02a57bf-bfed-4e25-a2c4-970ba1bbcc53.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u7f4e51f9&margin=%5Bobject%20Object%5D&name=1652668032%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68739&status=done&style=none&taskId=ub1f799c0-4f30-4919-b8ac-9294921a245&title=&width=1422.2223226916224)<br />        命名空间输入“datakit”，名称输入“datakit-service-ext”，监听端口输入“9411”，目标端口输入“9529”。<br />![1652667884(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652668002379-6e74c843-9ea5-4167-b471-ce8262ed6dca.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u6c0c11bc&margin=%5Bobject%20Object%5D&name=1652667884%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=59554&status=done&style=none&taskId=ub9204ba0-367f-4172-8a6c-a34804d96d5&title=&width=1422.2223226916224)<br />    点击“选择器”，键输入“app”，值输入“datakit”，点击『保存』。<br />![1652678272(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652678453811-fcbbcdf8-a149-4102-ac2e-c3497102637d.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=579&id=u6d917b98&margin=%5Bobject%20Object%5D&name=1652678272%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=58517&status=done&style=none&taskId=u4b3bd3e1-3475-428d-94bb-672ae3f78c9&title=&width=1422.2223226916224)
#### 3.5.2 定义 ExternalName 的服务
       『集群』-> 『服务发现』-> 『Service』，点击『创建』，选择“外部DNS服务名称”。<br />![1652668150(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652668154524-ee1e2d6f-ac67-4fb9-87ce-f8be8b612ce3.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u87bc9429&margin=%5Bobject%20Object%5D&name=1652668150%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68886&status=done&style=none&taskId=u99aa89dd-6ed4-4a68-b8ba-418a652392a&title=&width=1422.2223226916224)<br />        名称空间输入“istio-system”，名称输入“zipkin”，DNS名称输入“datakit-service-ext.datakit.svc.cluster.local”，点击『创建』。<br />![1652668229(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652668238918-2ca3592a-b3d8-4bb8-b3d0-1f311b9c117f.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u8f71b0e2&margin=%5Bobject%20Object%5D&name=1652668229%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52075&status=done&style=none&taskId=ue4649012-c63b-40c9-b28e-a0fe0ecda27&title=&width=1422.2223226916224)
### 3.6 创建 Gateway 资源
         登录『Rancher』-> 『集群』-> 『Istio』-> 『Gateways』，点击上方的“导入 YAML”图标。<br />![1652693539(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652693543932-e3431e56-e58d-489e-818d-06c5f8842c04.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u830b890b&margin=%5Bobject%20Object%5D&name=1652693539%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=31763&status=done&style=none&taskId=ua012a45e-5967-40fc-ae9c-b3d1bb4c09e&title=&width=1422.2223226916224)<br />        命名空间输入“prod”，在输入如下内容，点击『导入』。
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
```
   <br />![1652693525.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652693626406-aa3e277e-efd1-4824-b570-13a439b062cb.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u93011d0d&margin=%5Bobject%20Object%5D&name=1652693525.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=41740&status=done&style=none&taskId=u885df275-a8bc-48b0-98fa-c897aa266e7&title=&width=1422.2223226916224)
### 3.7 创建虚拟服务
         登录『Rancher』-> 『集群』-> 『Istio』-> 『VirtualServices』，点击上方的“导入 YAML”图标。        命名空间输入“prod”，在输入如下内容，点击『导入』。
```
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
![1652693787(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652693834393-8856891a-e0d0-4d21-b93f-63f0d67579a4.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u72aa4b7c&margin=%5Bobject%20Object%5D&name=1652693787%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=48226&status=done&style=none&taskId=uf8a22efa-f296-494a-a119-4718711dd99&title=&width=1422.2223226916224)
### 3.8 创建 productpage、details、ratings
        这里使用为 Pod 增加 annotations 来采集 Pod 的指标，增加的内容如下所示。        
```
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "bookinfo-istio-product"
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
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: zipkin.istio-system:9411
            custom_tags:
              project:
                literal:
                  value: "productpage"
              version:
                literal:
                  value: "v1"
              env:
                literal:
                  value: "test"  
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

        下面是 productpage、details、ratings 的完整部署文件。
```
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
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: zipkin.istio-system:9411
            custom_tags:
              project:
                literal:
                  value: "details"
              version:
                literal:
                  value: "v1"
              env:
                literal:
                  value: "test"              
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
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: zipkin.istio-system:9411
            custom_tags:
              project:
                literal:
                  value: "ratings"
              version:
                literal:
                  value: "v1"
              env:
                literal:
                  value: "test"  
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
        proxy.istio.io/config: |
          tracing:
            zipkin:
              address: zipkin.istio-system:9411
            custom_tags:
              project:
                literal:
                  value: "productpage"
              version:
                literal:
                  value: "v1"
              env:
                literal:
                  value: "test"  
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
        securityContext:
          runAsUser: 1000
      volumes:
      - name: tmp
        emptyDir: {}

```
        点击上方的“导入 YAML”图标。命名空间输入“prod”，在输入上面的内容，点击『导入』。<br />![1652694923(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652694927852-3986e7de-5249-4b7b-93e1-2e31cee748b5.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u668e0489&margin=%5Bobject%20Object%5D&name=1652694923%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=59248&status=done&style=none&taskId=u09ba5225-9334-49bd-a99b-ccf04d4cc06&title=&width=1422.2223226916224)<br />![1652694558(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652694937847-3424b155-4358-4d61-a368-94c12bd78d0c.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=ua11e181a&margin=%5Bobject%20Object%5D&name=1652694558%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71880&status=done&style=none&taskId=ue0cfc1e5-9fa7-4569-a340-0fc76aca39b&title=&width=1422.2223226916224)
### 3.9 部署 reviews 流水线
         登录 Gitlab，创建 bookinfo-views 项目。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1648634192491-ec7eba2f-b91f-45f6-9566-79b11069f54e.png#crop=0&crop=0&crop=1&crop=1&from=url&id=BrZ2p&margin=%5Bobject%20Object%5D&originHeight=505&originWidth=1832&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />        请参考 [gitlab 集成文档](https://www.yuque.com/dataflux/integrations/gitlab)打通 Gitlab 和 DataKit，这里只配置 Gitlab CI。<br />        登录『Gitlab』，进入『bookinfo-views』-> 『Settings』-> 『Webhooks』，在 url 中输入URL 中输入 DataKit 所在的主机 IP 和 DataKit 的 9529 端口，再加 /v1/gitlab。如下图。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346270462-79354129-dd0a-4e03-a36a-1564e25ca4ea.png?x-oss-process=image%2Fresize%2Cw_1012%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=rKLsw&margin=%5Bobject%20Object%5D&originHeight=450&originWidth=1012&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

       选中 Job events 和 Pipeline events，点击 Add webhook。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346336359-691db6af-7cdd-430e-b0b0-61a42c932208.png#crop=0&crop=0&crop=1&crop=1&from=url&id=ZoZTp&margin=%5Bobject%20Object%5D&originHeight=200&originWidth=451&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />        点击刚才创建的 Webhooks 右边的 Test，选择 Pipeline events，出现下图的 HTTP 200 说明配置成功。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652346379611-b4d3d016-5f8f-40f2-84d8-075fe59418b8.png#crop=0&crop=0&crop=1&crop=1&from=url&id=oCBAl&margin=%5Bobject%20Object%5D&originHeight=381&originWidth=1508&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)<br />        进入“bookinfo-views”项目，根目录新建 deployment.yaml 和 .gitlab-ci.yml 文件。在 annotations 定义了 project、env、version 标签，用于不同项目、不同版本的区分。
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
         修改 .gitlab-ci.yml 文件中的 APP_VERSION 的值为 "v1"，提交一次代码，修改成 "v2"，提交一次代码。

![1652670726(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670792155-02dec3f6-1c06-4e80-8bf3-e6957e25fbba.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u8e3797fe&margin=%5Bobject%20Object%5D&name=1652670726%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116609&status=done&style=none&taskId=u9f1ef60b-90fb-4566-a59f-d87d814f05f&title=&width=1422.2223226916224)<br />![1652670744(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670800804-a731c00f-36e1-45e1-bc93-c7e2a892e6de.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u3a9d86f1&margin=%5Bobject%20Object%5D&name=1652670744%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97887&status=done&style=none&taskId=u72971cc5-7323-4bf0-aa3f-ae624a647a1&title=&width=1422.2223226916224)
### 3.10 访问 productpage
        点击 Rancher 上方的“命令行”图标，输入“kubectl get svc -n istio-system”回车。<br />![1652695878(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652695895312-24ba4770-f983-420c-80b1-601d074f1df8.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u89c4b528&margin=%5Bobject%20Object%5D&name=1652695878%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=59716&status=done&style=none&taskId=u4ed5474f-cbb9-4c29-b8b7-eb7acf2a35d&title=&width=1599.9999364217147)<br />        上图可以看到端口是 31409，根据服务器 IP 得到 productpage 访问路径是  [http://8.136.193.105:31409/productpage](http://8.136.193.105:31409/productpage)。<br />![1652670815(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670830555-00f8f9a0-fd9a-42a8-8820-4768f7e35ccd.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=ud5c44496&margin=%5Bobject%20Object%5D&name=1652670815%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57161&status=done&style=none&taskId=u6dcbe530-6453-4085-96b2-70311d4e4bb&title=&width=1422.2223226916224)
## 步骤 4： Istio 可观测
        上述的步骤中，已经对 Istiod 及 bookinfo 应用做了指标采集，观测云默认提供了四个监控视图来观测 Istio 的运行情况。
#### 4.1 Istio Workload 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“Istio”，选择 “Istio Workload 监控视图”，点击『确定』。再点击新建的“Istio Workload 监控视图”进行观测 。<br />![1652712762(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652712813344-7378764b-9a32-4417-ac67-5f3bb5699d00.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=606&id=ufa879450&margin=%5Bobject%20Object%5D&name=1652712762%281%29.png&originHeight=727&originWidth=1704&originalType=binary&ratio=1&rotation=0&showTitle=false&size=85875&status=done&style=none&taskId=ue55f47b3-510e-466f-b045-1da0e2f1f62&title=&width=1419.9999435742718)<br />![1652712785(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652712820832-6ee4514c-52ca-4433-9cd4-0ce62a150178.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=565&id=uce803a25&margin=%5Bobject%20Object%5D&name=1652712785%281%29.png&originHeight=678&originWidth=1695&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94100&status=done&style=none&taskId=uf64fba04-971d-443d-830d-988ea1fdd29&title=&width=1412.499943872295)<br />![1652712798(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652712827005-04149534-f739-43ed-89b6-126b1e9d8cd4.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=564&id=uac39b536&margin=%5Bobject%20Object%5D&name=1652712798%281%29.png&originHeight=677&originWidth=1696&originalType=binary&ratio=1&rotation=0&showTitle=false&size=96281&status=done&style=none&taskId=u096c232a-6a44-45f6-86fb-6a709a49c78&title=&width=1413.3332771725147)
#### 4.2 Istio Control Plane 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“Istio”，选择 “Istio Control Plane 监控视图”，点击『确定』。再点击新建的“Istio Control Plane 监控视图”进行观测 。<br />![1652712936(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713017073-227c386f-aba9-46e5-844a-7bf51f47a9df.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=582&id=u409ee25f&margin=%5Bobject%20Object%5D&name=1652712936%281%29.png&originHeight=698&originWidth=1693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47052&status=done&style=none&taskId=u8ac77ea6-6741-4861-a5f1-8ef57bf82ea&title=&width=1410.8332772718559)<br />![1652712973(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713025790-2c253219-8cd1-4a26-a6a0-2ee9b1149fb9.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=439&id=u2c435a53&margin=%5Bobject%20Object%5D&name=1652712973%281%29.png&originHeight=527&originWidth=1701&originalType=binary&ratio=1&rotation=0&showTitle=false&size=39921&status=done&style=none&taskId=u184c178b-3f8b-4953-b958-2d90657dd09&title=&width=1417.499943673613)<br />![1652712986(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713033846-293b2d76-5e32-431d-9d99-35aba8fad413.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=483&id=uab38418c&margin=%5Bobject%20Object%5D&name=1652712986%281%29.png&originHeight=580&originWidth=1696&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49146&status=done&style=none&taskId=udc9364df-c057-433a-b3c8-36caae60cd0&title=&width=1413.3332771725147)
#### 4.3 Istio Service 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“Istio”，选择 “Istio Service 监控视图”，点击『确定』。再点击新建的“Istio Service 监控视图”进行观测 。

![1652712889(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652712905753-02ac212f-8b7d-4812-9da7-07db4b901802.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=u05c959f2&margin=%5Bobject%20Object%5D&name=1652712889%281%29.png&originHeight=769&originWidth=1693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69723&status=done&style=none&taskId=ud409ba8a-27f8-4ff2-80e3-52037bd4355&title=&width=1410.8332772718559)
#### 4.4 Istio Mesh 监控视图
        登录『[观测云](https://console.guance.com/)』，进入『场景』模块，点击『新建仪表板』，输入“Istio”，选择 “Istio Mesh 监控视图”，点击『确定』。再点击新建的“Istio Mesh 监控视图”进行观测 。<br />![1652713088(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713128554-90751da5-3f2a-4d24-9286-ee61206f3976.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=462&id=ued95a727&margin=%5Bobject%20Object%5D&name=1652713088%281%29.png&originHeight=555&originWidth=1694&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52166&status=done&style=none&taskId=ud9908b95-a78b-4521-b193-c3a4273f50b&title=&width=1411.6666105720753)


## 步骤 5： RUM 可观测
#### 5.1 新建用户访问监测
        登录『 [观测云](https://console.guance.com/)』，进入『用户访问监测』，新建应用 **devops-bookinfo** ，复制下方 JS。<br />![1652702138(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652702144412-67eec9c7-ec0c-4b8d-9859-59ff69d92622.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u0f71b1ca&margin=%5Bobject%20Object%5D&name=1652702138%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=78145&status=done&style=none&taskId=u44375233-fbb8-413d-85a0-3412c5832b1&title=&width=1599.9999364217147)<br />![1652702179(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652702184905-4c9a8d0a-f003-4d91-95f2-7c273afeb46f.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u481e167b&margin=%5Bobject%20Object%5D&name=1652702179%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90793&status=done&style=none&taskId=ub6bf2ff3-0ce7-4fd0-882d-d351f95f955&title=&width=1599.9999364217147)
#### 5.2 制作 productpage 镜像
        下载 [istio-1.13.2-linux-amd64.tar.gz](https://github.com/istio/istio/releases/download/1.13.2/istio-1.13.2-linux-amd64.tar.gz)，解压文件。上述的 JS 需要放置到 productpage 项目所有界面都能访问到的地方，本项目把上面的 JS 复制到 **istio-1.13.2\samples\bookinfo\src\productpage\templates\productpage.html** 文件中，其中 datakitOrigin 值是 DataKit 的地址。<br />![1652848860(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652848875108-546f755b-4e07-4674-9089-abd726832cf1.png#clientId=u92e0150e-3f1d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=312&id=ufbd29bc0&margin=%5Bobject%20Object%5D&name=1652848860%281%29.png&originHeight=374&originWidth=1150&originalType=binary&ratio=1&rotation=0&showTitle=false&size=30819&status=done&style=none&taskId=ub525508e-c143-4a4e-86fb-371139595f0&title=&width=958.3332952525896)<br />参数说明

- datakitOrigin：数据传输地址，这里是 datakit 的域名或 IP，必填。
- env：应用所属环境，必填。
- version：应用所属版本，必填。
- trackInteractions：是否开启用户行为统计，例如点击按钮、提交信息等动作，必填。
- traceType：trace类型，默认为 ddtrace，非必填。
- allowedTracingOrigins：实现 APM 与 RUM 链路打通，填写后端服务的域名或 IP ，非必填。

        制作镜像，并上传到镜像仓库。
```
cd istio-1.13.2\samples\bookinfo\src\productpage
docker build -t 172.16.0.238/df-demo/product-page:v1  .
docker push 172.16.0.238/df-demo/product-page:v1
```
#### 5.3 替换 productpage 镜像
         进入『集群』-> 『工作负载』->『Deployments』，找到 “productpage-v1”点击“编辑配置”。

![1652701379(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652701462766-d9b910ef-599c-4720-a7be-f2323717b014.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u31057fc1&margin=%5Bobject%20Object%5D&name=1652701379%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71125&status=done&style=none&taskId=u40d04f06-78e1-42b1-904e-83557ffc494&title=&width=1599.9999364217147)<br />        把镜像 image: docker.io/istio/examples-bookinfo-productpage-v1:1.16.2 替换成下面镜像<br />image: 172.16.0.238/df-demo/product-page:v1，点击“保存”。<br />![1652701442(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652701469202-099e9dab-91ce-489e-a630-4d8ea1c61a13.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u12907467&margin=%5Bobject%20Object%5D&name=1652701442%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68602&status=done&style=none&taskId=u1e80bfa4-5b1f-4e2f-ae45-871a5965c62&title=&width=1599.9999364217147)
#### 5.4 用户访问监测
        登录『 [观测云](https://console.guance.com/)』，进入『用户访问监测』，找到  **devops-bookinfo **应用，点击进入，查看 UV、PV、会话数、访问的页面等信息。<br />![1652711631(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652711708094-50ac47c1-ee10-4507-ad79-88cfb57a8435.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u4e30e396&margin=%5Bobject%20Object%5D&name=1652711631%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=144518&status=done&style=none&taskId=ue06d881c-ac55-42d1-9f2c-76dd549b03d&title=&width=1599.9999364217147)![1652711691(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652711715358-ec185383-12d3-4c6c-8902-94dab0033b75.png#clientId=ud7a5c529-7741-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=ofeRw&margin=%5Bobject%20Object%5D&name=1652711691%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105206&status=done&style=none&taskId=uc3d308f8-7755-4bd9-b155-6f392360b8c&title=&width=1599.9999364217147)<br />        性能分析。<br />![1652713219(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713256283-905598af-e925-4e50-bc78-19a6b674c6bc.png#clientId=u28162871-1058-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u53dc87c6&margin=%5Bobject%20Object%5D&name=1652713219%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=122470&status=done&style=none&taskId=u31269e68-cce5-41e1-afc0-ddc53d5c1d8&title=&width=1599.9999364217147)<br />        资源分析。<br />![1652713228(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713263869-2dc1e4ca-9b9b-48a2-8eb7-a2052344c9d9.png#clientId=u28162871-1058-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=652&id=u24b74c18&margin=%5Bobject%20Object%5D&name=1652713228%281%29.png&originHeight=782&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97290&status=done&style=none&taskId=u95622e18-d9f8-4f2a-89c9-e9f52682e66&title=&width=1599.9999364217147)
## 步骤 6： 日志可观测
        根据部署 datakit 时的配置，默认采集输出到 /dev/stdout 的日志。 登录『 [观测云](https://console.guance.com/)』，进入『日志』，查看日志信息。此外观测云还提供了 RUM、APM 和日志直接的联动功能，请参考官方文档做相应的配置。<br />![1652758430(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652758442410-eb7dd0e6-bfd9-48ca-9270-ef098243de9d.png#clientId=ub6934c5a-f41b-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=u2ba69c06&margin=%5Bobject%20Object%5D&name=1652758430%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=154186&status=done&style=none&taskId=u8e819e23-20dc-4313-b44b-e5df7298168&title=&width=1599.9999364217147)
## 步骤 7： Gitlab CI 可观测
        登录『[观测云](https://console.guance.com/)』，进入『CI』，点击『概览』选择 bookinfo-views 项目，查看 Pipeline 和 Job 的执行情况。<br />![1652696115(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652696145319-758d3500-0e70-4b26-a192-adcd1375dd11.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=AFK3j&margin=%5Bobject%20Object%5D&name=1652696115%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=99378&status=done&style=none&taskId=ucd12a74a-40e5-4b27-b26a-b91e20ce110&title=&width=1599.9999364217147)<br />        进入『CI』,点击『查看器』，选择 gitlab_pipeline。<br />![1652670844(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670863886-173ab4ba-92a2-4d18-85e6-1f3ed39d2b8f.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=FjJcH&margin=%5Bobject%20Object%5D&name=1652670844%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69951&status=done&style=none&taskId=u63e79d54-e3a3-41b9-8223-9e6ccce455c&title=&width=1422.2223226916224)<br />![1652670856(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670870125-5e3e543f-0fe3-4b27-a578-36f67165a89b.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=tCvVi&margin=%5Bobject%20Object%5D&name=1652670856%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=89881&status=done&style=none&taskId=u9b984e5a-90df-4e02-81d8-f84dda4b60d&title=&width=1422.2223226916224)<br />        进入『CI』,点击『查看器』，选择 gitlab_job。<br />![1652670893(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670908183-94cb82d6-0ccb-4de9-a1ad-bc432d822cd0.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=on4Ii&margin=%5Bobject%20Object%5D&name=1652670893%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69119&status=done&style=none&taskId=ue3b67c60-b086-4c42-a4aa-1c8b8d14973&title=&width=1422.2223226916224)<br />![1652670901(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670918042-9d6bb9af-58fa-48fb-9a17-f675ccaecbae.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=NrukE&margin=%5Bobject%20Object%5D&name=1652670901%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=91955&status=done&style=none&taskId=u32930fcd-9984-4eda-8a59-fa874e8b370&title=&width=1422.2223226916224)
## 步骤 8： 金丝雀发布可观测
        操作步骤是先创建 DestinationRule 和 VirtualService，把流量只流向 reviews-v1版本，发布 reviews-v2，切 10% 流量到 reviews-v2，通过观测云验证通过后，把流量完全切到 reviews-v2，下线 reviews-v1。
#### 8.1 创建 DestinationRule
        登录『Rancher』-> 『集群』-> 『Istio』-> 『DestinationRule』，点击『创建』。命名空间天“prod”，名称填“reviews”，Input a host填“reviews”，添加 Subset v1 和 Subset v2，详细信息如下图，最后点击『创建』。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652682689790-f10c2298-e996-41bd-bff9-b34ecd8150b1.png#crop=0&crop=0&crop=1&crop=1&from=url&id=JiUFu&margin=%5Bobject%20Object%5D&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
#### 8.2 创建 VirtualService
        登录『Rancher』-> 『集群』-> 『Istio』-> 『VirtualServices』，点击上方的“导入YAML”图标，输入如下内容后，点击『导入』。
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
#### 8.3 发布 reviews-v2 版本
         登录『gitlab』，找到 bookinfo-views 项目， 修改 .gitlab-ci.yml 文件中的 APP_VERSION 的值为 "v2"，提交一次代码。<br />![1652670984(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652670989847-362356a8-05ec-4b50-9e47-217815b19741.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=641&id=azQw8&margin=%5Bobject%20Object%5D&name=1652670984%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=117271&status=done&style=none&taskId=u3795dc79-ba0c-4a08-81f7-9c427c7085f&title=&width=1422.2223226916224)<br />       登录『[观测云](https://console.guance.com/)』，进入『CI』->『查看器』，可以看到 v2 版本已发布。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652671145586-25dfd430-0773-4a44-b948-d988e5d080fb.png#crop=0&crop=0&crop=1&crop=1&from=url&id=Sl9ot&margin=%5Bobject%20Object%5D&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
#### 8.4 切换流量到 reviews-v2 版本
        『Rancher』-> 『集群』-> 『Istio』-> 『VirtualServices』，点击“reviews”右边的“编辑 YAML”。<br />![1652764107(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652764118744-e706d69c-805b-4842-8241-342294ad2554.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=EmYD2&margin=%5Bobject%20Object%5D&name=1652764107%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46807&status=done&style=none&taskId=ubd058883-9036-4928-a43a-11e2719e39e&title=&width=1599.9999364217147)<br />        增加 v1 的权重是 90，v2 的权重是 10，最后点击“保存”。<br />![1652764010(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652764030996-028a11bc-f7f3-4720-a191-22f76daba6c4.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=FAMCo&margin=%5Bobject%20Object%5D&name=1652764010%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46138&status=done&style=none&taskId=uca067ecb-039f-4542-ac57-59ae49ad039&title=&width=1599.9999364217147)
#### 8.5 观测 reviews-v2 运行情况
        登录『[观测云](https://console.guance.com/)』，进入『应用性能监测』模块，点击右上方的图标。<br />![1652764598(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652764607332-04de222c-f7c9-438c-8027-6d70958b3ef8.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=501&id=hGO7m&margin=%5Bobject%20Object%5D&name=1652764598%281%29.png&originHeight=601&originWidth=1909&originalType=binary&ratio=1&rotation=0&showTitle=false&size=63920&status=done&style=none&taskId=u3123d4c9-fdf9-454a-8251-992b30c63b3&title=&width=1590.8332701192987)<br />        打开“区分环境和版本”，查看 bookinfo 的调用拓扑图。<br />![无标题.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652681248712-c0f3d91b-54b4-480d-a0a9-7109360d9a2d.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=0.7128&from=paste&height=815&id=gms2Z&margin=%5Bobject%20Object%5D&name=%E6%97%A0%E6%A0%87%E9%A2%98.png&originHeight=1100&originWidth=1932&originalType=binary&ratio=1&rotation=0&showTitle=false&size=78833&status=done&style=none&taskId=u2d299c52-6b20-49ad-a01d-4b944f34b4d&title=&width=1431)<br />        鼠标点击 reviews-v2 上，可以看到是 v2 在连ratings，而 reviews-v1 并不调用 ratings。<br />![2.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652681312379-326c7ff6-5b24-40ea-a850-d0131e9ae025.png#clientId=u10ce2a5d-fd6e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=568&id=F61NP&margin=%5Bobject%20Object%5D&name=2.png&originHeight=767&originWidth=1932&originalType=binary&ratio=1&rotation=0&showTitle=false&size=100419&status=done&style=none&taskId=u9165776c-1b25-4118-87ec-fff38bb40b9&title=&width=1431.111212208445)<br />        点击“链路”，选择“reviews.prod”服务，点击进入一个带“v2”版本的链路。<br />![1652701039(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652701044292-c5e59f53-ac43-4e42-b59d-63bca29d4bd0.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=dfS7J&margin=%5Bobject%20Object%5D&name=1652701039%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=157520&status=done&style=none&taskId=u7b4dd80d-fef0-43a0-ba44-9377225a156&title=&width=1599.9999364217147)<br />        查看火焰图。<br />![1652700977(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652701052534-bde34786-9d91-4ba5-b307-3a149667c48b.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=HbWgR&margin=%5Bobject%20Object%5D&name=1652700977%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=126441&status=done&style=none&taskId=ud0be8df1-81d4-496a-ae04-a19a8ae6d2c&title=&width=1599.9999364217147)<br />        查看 Span 列表。<br />![1652700977(2).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652701061274-3fe06c11-ddfd-4901-9a82-efdbdd4d979c.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=abgSa&margin=%5Bobject%20Object%5D&name=1652700977%282%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=98031&status=done&style=none&taskId=ue7e5a97c-a02b-4210-85e1-206902d8b88&title=&width=1599.9999364217147)<br />        查看服务调用关系。<br />![1652700977(3).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652701070655-88c7d23d-bd7b-4258-a49d-83ca11e9924b.png#clientId=u588afc24-5180-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=722&id=GDYNC&margin=%5Bobject%20Object%5D&name=1652700977%283%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97812&status=done&style=none&taskId=u98a0c751-9787-44a6-92b5-f3930882167&title=&width=1599.9999364217147)<br />        在 Istio Mesh 监控视图里面也可以看到服务的调用情况，v1、v2 版本的流量基本是 9:1。<br />![](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652713141701-55b23f61-8fec-40c3-94cb-07b4c23354d5.png#crop=0&crop=0&crop=1&crop=1&from=url&id=PVNg8&margin=%5Bobject%20Object%5D&originHeight=456&originWidth=1690&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
#### 8.6 完成发布
        通过在观测云的操作，本次发布符合预期。『Rancher』-> 『集群』-> 『Istio』-> 『VirtualServices』，点击“reviews”右边的“编辑 YAML”，把“v2”权重设置成 100，“v1”去掉，点击“保存”。<br />![1652764964(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652764976117-b6484954-0a7c-4b82-9016-ba4120c2e443.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=zafx3&margin=%5Bobject%20Object%5D&name=1652764964%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=44079&status=done&style=none&taskId=u51c99b41-68dc-4e0a-a9ef-76d6541702f&title=&width=1280)<br />        进入『集群』-> 『工作负载』->『Deployments』，找到 “reviews-v1”点击“删除”。<br />![1652765218.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1652765234480-5636797e-b326-4e1f-a4a3-3772b74c1b97.png#clientId=u5c569214-b688-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=V4lPD&margin=%5Bobject%20Object%5D&name=1652765218.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70960&status=done&style=none&taskId=u576b1acd-dd27-46da-a92e-755e6f3410a&title=&width=1280)
## <br />
