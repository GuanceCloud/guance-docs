# 1 各种离线包如何手工更新
本节介绍的是如果想要在不升级观测云版本的情况下，离线环境需要手工更新 **视图模板包**、**指标字典**、**官方 Pipeline 包**等，如何手工操作。
## 1.1 离线环境如何更新视图模板包

1. 下载最新的视图模板包：

[https://gitee.com/dataflux/dataflux-template](https://gitee.com/dataflux/dataflux-template)

2. 上传到容器持久存储中：

上传目录为forethought-core => inner 容器挂载的 /config/cloudcare-forethought-backend/sysconfig/staticFolder 目录对应的持久化存储目录中，上传的目录结构如下：
![](https://cdn.nlark.com/yuque/0/2021/tif/21511589/1636021975253-cef61aa8-ee2a-4072-8eaa-1f94b1f7cd38.tif?x-oss-process=image/format,png#crop=0&crop=0&crop=1&crop=1&id=wGzwO&originHeight=344&originWidth=849&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

3. 进入 forethought-core => inner 容器，路径为默认工作目录：/config/cloudcare-forethought-backend
3. 执行 Python 命令，进入 Python 环境：

![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021975995-42c84bb5-5f85-4ac1-a6a8-beb34fd7a659.png#crop=0&crop=0&crop=1&crop=1&id=kNmXG&originHeight=305&originWidth=670&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

5. 执行如下两条 Python 命令：

from forethought.tasks.timed_sync_integration import execute_update_integration
execute_update_integration()

**看到如下提示，表示成功执行成功：**
![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021976424-72fb4d38-6df7-4961-bd6b-21fc59fdd5d7.png#crop=0&crop=0&crop=1&crop=1&id=sSwok&originHeight=360&originWidth=1252&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
## 1.2 离线环境如何更新指标字典 json

1.  下载最新的指标字典 JSON 文件 

[https://static.guance.com/datakit/measurements-meta.json](https://static.guance.com/datakit/measurements-meta.json)

2. 上传到容器持久存储中

上传目录为forethought-core => inner 容器挂载的 /config/cloudcare-forethought-backend/sysconfig/staticFolder/metric 目录对应的持久化存储目录中，文件名为 metric_config.json ，上传的目录结构如下：
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1645521023189-444f102e-3d87-4397-9f32-02383872bad4.png#clientId=u29e09ffa-b5cb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=148&id=sQGVu&margin=%5Bobject%20Object%5D&name=image.png&originHeight=148&originWidth=778&originalType=binary&ratio=1&rotation=0&showTitle=false&size=102312&status=done&style=none&taskId=u8856ab1c-2886-4b8d-a2e7-9bb2028a009&title=&width=778)
## 1.3 离线环境如何更新官方 Pipeline 库

1.  下载最新的指标字典 JSON 文件 

[https://static.guance.com/datakit/internal-pipelines.json](https://static.guance.com/datakit/internal-pipelines.json)

2. 上传到容器持久存储中

上传目录为forethought-core => inner 容器挂载的 /config/cloudcare-forethought-backend/sysconfig/staticFolder/ 目录对应的持久化存储目录中，文件名为 internal-pipelines.json ，上传的目录结构如下：
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1646041535038-91f0e7c1-6968-4196-9f4f-b318cc4d7296.png#clientId=ua5d1277b-e678-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=194&id=AhE9Q&margin=%5Bobject%20Object%5D&name=image.png&originHeight=194&originWidth=756&originalType=binary&ratio=1&rotation=0&showTitle=false&size=136566&status=done&style=none&taskId=u3241caf2-c7f9-4506-9ea8-273c417314a&title=&width=756)
# 2 初次安装发生问题，需要清理后重新安装怎么办！
**注意：仅限初次安装时发生问题，需要铲除重新安装的场景，请仔细确认后再执行此以下清理步骤！**

如果发生安装问题，需要全部铲除后重新安装，需要清理以下三个地方，才可以从 Launcher 开始重新安装观测云：
## 2.1 清理已安装的观测云应用服务
清理 Kubernetes 中已安装的各种观测云应用服务，可以在运维操作机上，进入 Launcher 容器，执行 Launcher 自带的清理脚本：
```
kubectl exec -it launcher-xxxxxxxx-xxx -n launcher /bin/bash
```
**launcher-xxxxxxxx-xxx 为您的 launcher 服务 pod 名称！**
进入容器后，可以看到 Launcher 服务自带的 k8s-clear.sh（1.47.103 之后的版本，这个脚本在 /config/tools 目录中） 脚本，执行此脚本，将清理所有观测云应用服务及 k8s 的资源：
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1648106945386-6116c6ab-b93a-44f2-a544-2d4441191a3b.png#clientId=u3331c8c8-66ed-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=454&id=ua80b27b2&margin=%5Bobject%20Object%5D&name=image.png&originHeight=454&originWidth=736&originalType=binary&ratio=1&rotation=0&showTitle=false&size=93139&status=done&style=none&taskId=u350f157c-0acb-46e5-89d6-935d12c906c&title=&width=736)
## 2.2 清理 MySQL 中自动创建的数据库
可以进入 Launcher 容器，Launcher 容器中自带了 mysql 客户端工具，使用以下命令连接到观测云MySQL 实例：
```
mysql -h <mysql 实例 host> -u root -P <mysql 端口> -p  
```
需要使用 mysql 管理员账号连接，连接后，执行以下 6 个 MySQL 数据库及用户清理命令：
```
drop database df_core;
drop user df_core;
drop database df_message_desk;
drop user df_message_desk;
drop database df_func;
drop user df_func;
```
## 2.3 清理 InfluxDB 中自动创建的用户
使用 influx 客户端工具，连接 InfluxDB，执行以下两个用户清理命令：
```
drop user user_wr;
drop user user_ro;
```
# 3 部署注意事项
## 3.1 部署好之后，能不能手工修改安装程序自动生成的 Kubernetes 资源？
**不可以手工修改**，因为下次新版本发布后，使用 Launcher 升级安装，会根据安装时填写的配置信息重新生成 **Deployment、Service、Ingress** 等资源（ Configmap 除外，Configmap 配置项中的信息可以任意手工修改，但随意修改可能会造成程序运行异常）。

# 4 独立容器 Rancher Server 证书更新
## 4.1 证书未过期如何处理
rancher server 可以正常运行。升级到 Rancher v2.0.14+ 、v2.1.9+、v2.2.2+ 后会自动检查证书有效期，如果发现证书即将过期，将会自动生成新的证书。所以独立容器运行的 Rancher Server，只需在证书过期前把 rancher 版本升级到支持自动更新 ssl 证书的版本即可，无需做其他操作。
## 4.2 证书已过期如何处理
 rancher server 无法正常运行。即使升级到 Rancher v2.0.14+ 、v2.1.9+、v2.2.2+ 也可能会提示证书错误。如果出现这种情况，可通过以下操作进行处理：

   1. 正常升级 rancher 版本到 v2.0.14+ 、v2.1.9+、v2.2.2+；
   1. 执行以下命令：
   - 2.0 或 2.1 版本
```yaml
    docker exec -ti <rancher_server_id>mv /var/lib/rancher/management-state/certs/bundle.json /var/lib/rancher/management-state/certs/bundle.json-bak
```

   - 2.2 +
```yaml
docker exec -ti <rancher_server_id>mv /var/lib/rancher/management-state/tls/localhost.crt /var/lib/rancher/management-state/tls/localhost.crt-bak
```

   - 2.3 +
```yaml
    docker exec -ti <rancher_server_id>mv /var/lib/rancher/k3s/server/tls /var/lib/rancher/k3s/server/tlsbak
    
    # 执行两侧，第一次用于申请证书，第二次用于加载证书并启动
    docker restart <rancher_server_id>
```

   - 2.4 +
      1. exec 到 rancher server
```yaml
kubectl --insecure-skip-tls-verify -n kube-system delete secrets k3s-serving
kubectl --insecure-skip-tls-verify delete secret serving-cert -n cattle-system
rm -f /var/lib/rancher/k3s/server/tls/dynamic-cert.json
```

      2. 重启 rancher-server
```yaml
docker restart <rancher_server_id>
```

      3. 执行以下命令刷新参数
```yaml
curl --insecure -sfL https://server-url/v3
```

   3.   重启 Rancher Server 容器
```yaml
docker restart <rancher_server_id>
```
# 5 rancher server 证书已过期导致无法纳管k8s集群处理
如果集群证书已经过期，那么即使升级到Rancher v2.0.14、v2.1.9以及更高版本也无法轮换证书。rancher 是通过Agent去更新证书，如果证书过期将无法与Agent连接。
## 5.1 解决方法
可以手动设置节点的时间，把时间往后调整一些。因为Agent只与K8S master和Rancher Server通信，如果 Rancher Server 证书未过期，那就只需调整K8S master节点时间。
调整命令：
```yaml
# 关闭ntp同步，不然时间会自动更新
timedatectl set-ntp false
# 修改节点时间
timedatectl set-time '2019-01-01 00:00:00'
```

然后再对 Rancher Server 进行升级，等到证书轮换完成后再把时间同步回来。
```yaml
timedatectl set-ntp true
```
检查证书有效期
```yaml
openssl x509 -in /etc/kubernetes/ssl/kube-apiserver.pem -noout -dates
```

# 6 创建了 DataWay 为什么在前台看不到
## 6.1 常见原因分析

-       Dataway 服务部署到服务器上之后并未正常运行。
-       Dataway 服务配置文件错误，未配置对正确的监听、工作空间token信息。
-       Dataway 服务运行配置错误，具体可以通过查看dataway 日志定位。
-       部署Dataway 的服务器无法与 kodo 服务通信。（包括dataway服务器并未在hosts中添加df-kodo 服务的正确解析）
-       kodo 服务异常，具体可通过查看kodo 服务日志进行确认。
-       df-kodo ingress 服务未正确配置。具体表现为无法访问 http|https://df-kodo.<xxxx>:<port>
# 7 为什么不能使用拨测服务
## 7.1 原因剖析

-       部署的观测云应用为离线环境，物理节点网络环境无法出网。（较为常见）
-       自建探测节点网络异常。
-       地区供应商网络异常。
-       拨测任务创建错误。

---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642761909015-750c7ecd-81ba-4abf-b446-7b8e97abe76e.png#clientId=ucc58c24e-d7a9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1f1c3a96&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=u420e6521-1eac-4f17-897f-53a63d36ff8&title=)
