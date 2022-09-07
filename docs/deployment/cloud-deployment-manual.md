# 云上部署手册
---

## 1 前言
### 1.1 产品简介
“观测云”是一款旨在解决云计算，以及云原生时代系统为每一个完整的应用构建全链路的可观测性的云服务平台。“观测云”是由驻云科技自2018年以来全力打造的产品，产品的目标是为中国的广大基于云计算的开发项目组提供服务，相较于复杂多变的开源产品，如ELK，Prometheus，Grafana，Skywalking等，“观测云”不单纯的只是提供一种监控类的产品，更重要的是提供整体可观测性的服务，我们除了在底层存储和系统架构上是一体化的基础上，也把所有关于云计算及云原生相关的技术栈进行了完整的分析和解构，任何项目团队可以非常轻松的使用我们的产品，无需再投入太多的精力去研究或者改造不成熟的开源产品，同时“观测云”是以服务方式，按需按量的方式收取费用，完全根据用户产生的数据量收取费用，无需投入硬件，同时对于付费客户，我们还会建立专业的服务团队，帮助客户构建基于数据的核心保障体系，具有实时性、灵活性、易扩展、易部署等特点，支持云端 SaaS 和本地部署模式。
### 1.2 本文档说明
本文档主要以在阿里云上部署，介绍从资源规划、配置开始，到部署观测云、运行的完整步骤。

**说明：**

- 本文档以 **dataflux.cn** 为主域名示例，实际部署替换为相应的域名。

### 1.3 关键词

| **词条** | **说明** |
| --- | --- |
| Launcher | 用于部署安装 观测云 的 WEB 应用，根据 Launcher 服务的引导步骤来完成 观测云 的安装与升级 |
| 运维操作机 | 安装了 kubectl，与目标 Kubernetes 集群在同一网络的运维机器 |
| 安装操作机 | 在浏览器访问 launcher 服务来完成 观测云 引导安装的机器 |
| kubectl | Kubernetes 的命令行客户端工具，安装在 **运维操作机** 上 |


### 1.4 部署架构
![](img/7.deployment_1.png)
## 2 资源准备
### 2.1 资源清单

| **资源** | **规格（最低配置）** | **规格（推荐配置）** | **数量** | **备注** |
| --- | --- | --- | --- | --- |
| ACK | 标准托管集群版 | 标准托管集群版 | 1 | - |
| NAS | 200GB（容量型） | 200GB（容量型） | 1 | ACK集群数据持久化 |
| NAT 网关 | 小型NAT网关 | 小型NAT网关 | 1 | ACK集群出网使用 |
| SLB | 性能保障型 | 性能保障型 | 2 | 在 Kubenetes Ingress 前 |
| ECS | 4C8G（单系统盘80GB） | 8C16G（单系统盘120GB） | 4 | 部署阿里云ACK托管版集群 |
|  | 2C4G（单系统盘80GB） | 4C8G（单系统盘120GB） | 2 | 部署 Dataway |
| RDS | 1C2G 50GB | 2C4G 100GB（三节点企业版） | 1 | MySQL 5.7 |
| Redis | 2G | 4G（标准主从版双副本） | 1 | 版本：4.0 |
| InfluxDB | 4C16G 500GB | 8C32G 1T（集群版） | 1 | 版本：1.7.x |
| Elasticsearch | 4C16G 1T（2节点） | 16C64G 2T（3节点） | 1 | 版本：7.4+（**推荐7.10**） |
| 云通信 | - | - | 1 | 开通邮件服务、短信服务 |
| 域名 | - | - | 1 | 主域名需备案，一个主域名下的8个子域名 |
| SSL 证书 | 通配符域名证书 | 通配符域名证书 | 1 | - |

注：

1. “**最低配置**” 只适合 POC 场景部署，只作功能验证，不适合作为生产环境使用。
1. “**推荐配置**” 适合 InfluxDB 少于15 万时间线，Elasticsearch 少于 70 亿文档数（日志、链路、用户访问监测、事件等文档数总和）的数据量场景使用。
1. 作为生产部署以实际接入数据量做评估，接入的数据量越多，InfluxDB、Elasticsearch 的存储与规格配置相应也需要越高。

### 2.2 创建资源
#### 2.2.1 基础资源
**RDS、Redis、InfluxDB、Elasticsearch、NAS 存储** 按配置要求创建，创建到同一地域的同一个 **VPC** 网络下。
ECS、SLB、NAT 网关，由ACK 来自动创建，不需要单独创建。
#### 2.2.2 ACK 服务创建
##### 2.2.2.1 集群配置
进入 **容器服务 kubernetes 版**，创建 **Kubernetes** 集群，选择 **标准托管集群版**，集群配置要注意事项：

- 必须与前面创建的 RDS、 InfluxDB、Elasticsearch 等资源同一地域
- 勾选“配置 SNAT”选项（ACK 自动创建和配置 NAT 网关，使集群有出网能力）
- 勾选“公网访问”选项（可以在公网访问集群 API，如果是在内网运维此集群，可以不勾选此项）
- 开通ACK服务时储存驱动暂时选择flexvolume，CSI驱动本文档暂时未支持

![](img/7.deployment_2.png)

##### 2.2.2.2 Worker 配置
主要是选择 ECS 规格及数量，规格可以按配置清单要求来创建，或者按实际情况评估，但不可低于最低配置要求，数量至少3台，或3台以上。

![](img/7.deployment_3.png)

##### 2.2.2.3 组件配置
组件配置，必须勾选“安装 Ingress 组件”选项，选择“公网”类型，ACK 会自动创建一个公网类型的 SLB，安装完成后，将域名触到到此 SLB 的公网 IP。

![](img/7.deployment_4.png)

### 2.3 资源配置
#### 2.3.1 RDS

- 创建管理员账号（必须是**管理员账号**，后续安装初始化需要用此账号去创建和初始化各应用 DB）
- 在控制台修改参数配置，将 **innodb_large_prefix** 设置为 **ON**
- 将 ACK 自动创建的 ECS 内网 IP，添加到 RDS 白名单
#### 2.3.2 Redis

- 设置 Redis 密码
- 将 ACK 自动创建的 ECS 内网 IP，添加到 Redis 白名单
#### 2.3.3 InfluxDB

- 创建管理员账号（必须是**管理员账号**，后续安装初始化需要用此账号去创建和初始化 DB 及 RP等信息）
- 将 ACK 自动创建的 ECS 内网 IP，添加到 InfluxDB 白名单
#### 2.3.4 Elasticsearch

- 创建管理员账号
- 安装中文分词插件：
   1. 下载对应 ES 版本的分词插件：[https://github.com/medcl/elasticsearch-analysis-ik/releases](https://github.com/medcl/elasticsearch-analysis-ik/releases)
   1. 解压后，放到 elasticsearch 目录的 plugins 目录内，如：
```bash
[root@ft-elasticsearch-867fb8d9bb-xchnm plugins]# find .
.
./analysis-ik
./analysis-ik/commons-codec-1.9.jar
./analysis-ik/commons-logging-1.2.jar
./analysis-ik/config
./analysis-ik/config/IKAnalyzer.cfg.xml
./analysis-ik/config/extra_main.dic
./analysis-ik/config/extra_single_word.dic
./analysis-ik/config/extra_single_word_full.dic
./analysis-ik/config/extra_single_word_low_freq.dic
./analysis-ik/config/extra_stopword.dic
./analysis-ik/config/main.dic
./analysis-ik/config/preposition.dic
./analysis-ik/config/quantifier.dic
./analysis-ik/config/stopword.dic
./analysis-ik/config/suffix.dic
./analysis-ik/config/surname.dic
./analysis-ik/elasticsearch-analysis-ik-7.10.1.jar
./analysis-ik/elasticsearch-analysis-ik-7.10.1.zip
./analysis-ik/httpclient-4.5.2.jar
./analysis-ik/httpcore-4.4.4.jar
./analysis-ik/plugin-descriptor.properties
./analysis-ik/plugin-security.policy
```

- 将 ACK 自动创建的 ECS 内网 IP，添加到 Elasticsearch 白名单
## 3 kubectl 安装及配置
### 3.1 安装 kubectl
kubectl 是一个 kubernetes 的一个命令行客户端工具，可以通过此命令行工具去部署应用、检查和管理集群资源等。
我们的 Launcher 就是基于此命令行工具，去部署应用的，具体安装方式可以看官方文档：

[https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 3.2 配置 kube config
kubectl 要获得管理集群的能力，需要将集群的 kubeconfig 内容放入 **$HOME/.kube/config** 文件内，kubeconfig 内容可以在集群 **基本信息** 中查看到。

选择 公网访问还是内网访问的kubeconfig，取决于你的运维操作机是否与集群内网联通。

![](img/7.deployment_5.png)

## 4 开始安装 观测云
### 4.1 自动存储配置
#### 4.1.1 NAS Controller

NAS Controller YAML 文件下载地址：
[https://static.guance.com/launcher/nas_controller.yaml](https://static.guance.com/launcher/nas_controller.yaml)

将上面的 YAML 内容保存为 **nas_controller.yaml** 文件，放到**运维操作机**上。

#### 4.1.2 存储类配置

Storage Class YAML 下载：
 https://static.guance.com/launcher/storage_class.yaml

将上面的 YAML 内容保存为 **storage_class.yaml** 文件，放到**运维操作机**上，然后替换文档内的变量部分：

- **{{ nas_server_id }}** 替换为前面创建的 NAS 存储的 Server ID。

#### 4.1.3 导入存储配置

- 导入**controller.yaml**，在**运维操作机**上执行命令： 

```shell
$ kubectl apply -f ./nas_controller.yaml
```

- 导入 **storage_class.yaml**，在**运维操作机**上执行命令：  

```shell
$ kubectl apply -f ./storage_class.yaml
```

### 4.2 Launcher 服务安装配置
#### 4.2.1 Launcher 安装
Launcher 安装有2种方式：

- Helm 安装
- 原始  YAML 安装

**!! 注意选一种安装方式即可**
##### 4.2.1.1 Helm 安装
前提条件：

- 已安装[Helm3](https://helm.sh/zh/docs/intro/install/)
- 已完成存储配置
###### 4.2.1.1.1 安装
```shell
# 添加仓库
$ helm repo add launcher https://pubrepo.guance.com/chartrepo/launcher

# 更新仓库
$ helm repo update 

# helm 安装 Launcher
$ helm install <RELEASE_NAME> launcher/launcher -n launcher --create-namespace  \
        --set-file configyaml="<Kubeconfig Path>" \
  --set ingress.hostName="<Hostname>",storageClassName=<Stroageclass>
```

**注意：** `<RELEASE_NAME>` 为发布名称，可设置为 launcher, `<Kubeconfig Path>` 为 2.3 章节的 kube config 文件路径可设置为 /root/.kube/config，`<Hostname>` 为 Launcher ingress 域名， `<Stroageclass>` 为 4.1.2章节存储类名称，可执行 `kubectl get sc` 获取。

```shell
helm install my-launcher launcher/launcher -n launcher --create-namespace  \
        --set-file configyaml="/Users/buleleaf/.kube/config" \
  --set ingress.hostName="launcher.my.com",storageClassName=nfs-client
```
###### 4.2.1.1.2 社区版安装
如果部署社区版，可以先获取[社区版部署镜像](changelog.md) ，添加 --set image.repository=<镜像地址>，--set image.tag=<镜像tag> 参数进行部署。
```shell
# 此命令为演示命令，请根据自身需求修改内容
$ helm install my-launcher launcher/launcher -n launcher --create-namespace  \
        --set-file configyaml="/Users/buleleaf/.kube/config" \
 --set ingress.hostName="launcher.my.com",storageClassName=nfs-client \
 --set image.repository=pubrepo.jiagouyun.com/dataflux/1.40.93,image.tag=launcher-aa97377-1652102035
```
###### 4.2.1.1.3 如何卸载
Launcher 安装成功，非正常情况请勿卸载。
```shell
helm uninstall <RELEASE_NAME> -n launcher
```
##### 4.2.1.2 YAML 安装
Launcher YAML 下载：
 https://static.guance.com/launcher/launcher.yaml

将上面的 YAML 内容保存为 **launcher.yaml** 文件，放到**运维操作机**上，然后替换文档内的变量部分：

- {{ launcher_image }} 替换为最新版的 Launcher 应用的镜像地址，可以在 [社区版部署镜像](changelog.md) 文档中获取到最新版本的 Launcher 安装镜像地址
- {{ domain }} 替换为主域名，如使用 dataflux.cn
- {{ kube_config }}替换为kube config，launcher 需要获取到集群权限，去自动部署应用，注意缩进
- {{ storageClassName }}替换为storage class name，如前一步的 storage_class.yaml 中配置的 name： alicloud-nas

在**运维操作机**上执行以下 **kubectl** 命令，在导入 **Launcher** 服务：
```shell
kubectl apply -f ./laucher.yaml
```
#### 4.2.2 解析 launcher 域名到 launcher 服务
因为 launcher 服务为部署和升级 观测云 使用，不需要对用户开放访问，所以域名不要在公网解析，可以在**安装操作机**上，绑定 host 的方式，模拟域名解析，在 /etc/hosts 中添加 **launcher.dataflux.cn** 的域名绑定：

192.168.0.1  launcher.dataflux.cn
192.168.0.1 实际为前面步骤中创建 ACK 时自动创建的 SLB 实例的公网 IP 地址。

### 4.3 应用安装引导步骤 {#deploy-steps}
在**安装操作机**的浏览器中访问 **launcher.dataflux.cn**，根据引导步骤一步一步完成安装配置。
#### 4.3.1 数据库配置

- 数据库连接地址必须使用内网地址
- 账号必须使用管理员账号，因为需要此账号去初始化多个子应用的数据库及数据库访问账号
#### 4.3.2 Redis 配置

- Redis 连接地址必须使用内网地址
#### 4.3.3 InfluxDB 配置

- InfluxDB 链接地址必须使用内网地址
- 账号必须使用管理员账号，因为需要使用此账号去初始化 DB 以及 RP 待信息
- 可添加多个 InfluxDB 实例
#### 4.3.4 其他设置

- 观测云管理后台的管理员账号初始账号名与邮箱（默认密码为 **admin，**建议登录后立即修改默认密码）
- 集群节点内网 IP（会自动获取，需要确认是否正确）
- 主域名及各子应用的子域名配置，默认子域名如下，可根据需要修改：
   - dataflux 【**用户前台**】
   - df-api 【**用户前台 API**】
   - df-management 【**管理后台**】
   - df-management-api 【**管理后台 API**】
   - df-websocket 【**Websocket 服务**】
   - df-func 【**Func 平台**】
   - df-openapi 【OpenAPI】
   - df-static-res 【**静态资源站点**】
   - df-kodo 【**kodo**】

**注：df-kodo 服务可选择是否使用内网SLB，如 DataWay 与 kodo 是在同一个内网网络，安装时可选择使用内网。**

- TLS 域名证书填写

#### 4.3.5 安装信息

汇总显示刚才填写的信息，如有信息填写错误可返回上一步修改

#### 4.3.6 应用配置文件

安装程序会自动根据前面步骤提供的安装信息，初始化应用配置模板，但还是需要逐个检查所有应用模板，修改个性化应用配置，具体配置说明见安装界面。

确认无误后，提交创建配置文件。

#### 4.3.7 应用镜像

- 选择正确的**共享存储**，即你前面步骤中创建的 **storage class** 名称
- 应用镜像会根据你选的 **Launcher** 版本，自动填写无需修改，确认无误后开始 **创建应用**

#### 4.3.8 应用状态

此处会列出所有应用服务的启动状态，此过程需要下载所有镜像，可能需要几分钟到十几分钟，待全部服务都成功启动之后，即表示已安装成功。

**注意：服务启动过程中，必须停留在此页面不要关闭，到最后看到“版本信息写入成功”的提示，且没有弹出错误窗口，才表示安装成功！**

### 4.4 域名解析

将除 **df-kodo.dataflux.cn** 之外的其他所有子域名，都解析到 ACK 自动创建的 SLB 公网 IP 地址上：

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-openapi.dataflux.cn
- df-func.dataflux.cn
- df-static-res.dataflux.cn

服务安装完成之后，集群会自动为 **kodo** 服务创建一个公网 SLB，可使用 kubectl get svc -n forethought-kodo  命令，查看到 kodo-nginx 服务的 EXTERNAL-IP，**df-kodo.dataflux.cn** 子域名区别单独解析到此 SLB 的公网 IP 上，如下图：

![](img/7.deployment_6.tiff)

该 SLB 需要配置 HTTPS 证书，所需证书需自行上传到 SLB 控制台，并修改 SLB 监听协议为七层 HTTPS，DataWay 默认上报数据选择 HTTPS 协议
**重要提示：**
通过 SLB 接入服务的具体方式参阅：[https://www.alibabacloud.com/help/zh/doc-detail/86531.htm](https://www.alibabacloud.com/help/zh/doc-detail/86531.htm)
编辑 kodo-nginx deploy 的 YAML文件，添加如下 annotations 内容：

```
service.beta.kubernetes.io/alibaba-cloud-loadbalancer-cert-id: 1642778637586298_17076818419_1585666584_-1335499667 ## 以实际控制台上的证书id为准 ##
service.beta.kubernetes.io/alibaba-cloud-loadbalancer-force-override-listeners: '"true"'  ## 使用现有配置强制覆盖监听  ##
service.beta.kubernetes.io/alibaba-cloud-loadbalancer-id: lb-k2j4h4nlg2vgiwi9jyga6   ## 负载均衡实例id ## （指定已存在的slb实例）
service.beta.kubernetes.io/alibaba-cloud-loadbalancer-protocol-port: '"https:443"'  ## 协议类型 ##
```
### 4.5 安装完成后

部署成功手，可以参考手册 [如何开始使用](how-to-start.md) 

如果安装过程中发生问题，需要重新安装，可参考手册 [维护手册](faq.md)

### 4.6 很重要的步骤！！！

经过以上步骤，观测云 都安装完毕，可以进行验证，验证无误后一个很重要的步骤，将 launcher 服务下线，防止被误访问而破坏应用配置，可在**运维操作机**上执行以下命令，将 launcher 服务的 pod 副本数设为 0：

```shell
kubectl patch deployment launcher \
-p '{"spec": {"replicas": 0}}' \
-n launcher
```
