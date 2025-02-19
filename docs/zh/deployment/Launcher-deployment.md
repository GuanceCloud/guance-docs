# Launcher 服务安装配置

## 产品简介
   用于部署安装 {{{ custom_key.brand_name }}} 的 WEB 应用，根据 Launcher 服务的引导步骤来完成 {{{ custom_key.brand_name }}} 的安装与升级

## 关键词

| **词条**   | **说明**                                                     |
| ---------- | ------------------------------------------------------------ |
| Launcher   | 用于部署安装 {{{ custom_key.brand_name }}} 的 WEB 应用，根据 Launcher 服务的引导步骤来完成 {{{ custom_key.brand_name }}} 的安装与升级 |
| 运维操作机 | 安装了 kubectl，与目标 Kubernetes 集群在同一网络的运维机器   |
| 安装操作机 | 在浏览器访问 launcher 服务来完成 {{{ custom_key.brand_name }}} 引导安装的机器       |
| hosts 文件 | hosts文件是一个没有扩展名的系统文件。它的主要作用是保存域名与ip的映射关系。 |

## 1. {{{ custom_key.brand_name }}}离线包导入

如果是离线网络环境下安装，需要先手工下载最新的{{{ custom_key.brand_name }}}镜像包，通过  docker load  命令将所有镜像导入到各个 Kubernetes 工作节点上后，再进行后续的引导安装。

最新的{{{ custom_key.brand_name }}}镜像包下载地址：
=== "amd64"

    [https://{{{ custom_key.static_domain }}}/dataflux/package/guance-amd64-latest.tar.gz](https://{{{ custom_key.static_domain }}}/dataflux/package/guance-amd64-latest.tar.gz)
    

=== "arm64"

    
    [https://{{{ custom_key.static_domain }}}/dataflux/package/guance-arm64-latest.tar.gz](https://{{{ custom_key.static_domain }}}/dataflux/package/guance-arm64-latest.tar.gz)
    
Containterd 环境导入镜像命令
```shell
$ gunzip guance-xxx-latest.tar.gz
$ ctr -n=k8s.io images import guance-xxx-latest.tar
```
???+ info "说明"
    > 每个节点都要导入镜像，guance-xxx-latest.tar.gz资源包

## 2. Launcher 安装

- 安装

  在 `launcher` 目录，执行命令

  ```shell
  helm install launcher launcher-*.tgz -n launcher --create-namespace  \
    --set ingress.hostName=launcher.dataflux.cn \
    --set storageClassName=managed-nfs-storage
  ```

>launcher chart 下载 [Download](https://{{{ custom_key.static_domain }}}/dataflux/package/launcher-helm-latest.tgz)

- Launcher 卸载

```shell
helm uninstall <RELEASE_NAME> -n launcher
```

> Launcher 安装成功，非正常情况请勿卸载。

## 3. 解析 launcher 域名到 launcher 服务
因为 launcher 服务为部署和升级 {{{ custom_key.brand_name }}} 使用，不需要对用户开放访问，所以域名不要在公网解析，可以在**安装操作机**上，绑定 host 的方式，模拟域名解析，在 /etc/hosts 中添加 **launcher.dataflux.cn** 的域名绑定

```shell
192.168.100.104 df-kodo.dataflux.cn
192.168.100.104 test.dataflux.cn
192.168.100.104 launcher.dataflux.cn
192.168.100.104 dataflux.dataflux.cn
192.168.100.104 df-func.dataflux.cn
192.168.100.104 df-api.dataflux.cn
192.168.100.104 df-management.dataflux.cn
192.168.100.104 df-management-api.dataflux.cn
192.168.100.104 df-static-res.dataflux.cn
```

> `192.168.100.104` 为 代理 ip 

## 4. 应用安装引导步骤
在**安装操作机**的`浏览器`中访问 **launcher.dataflux.cn**，根据引导步骤一步一步完成安装配置。



![](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/liwenjin/docker/guance-launcher.png)

### 4.1 数据库配置

- 数据库连接地址必须使用内网地址
- 账号必须使用管理员账号，因为需要此账号去初始化多个子应用的数据库及数据库访问账号

   

| url         | mysql.middleware       |
| ----------- | --------------------- |
| port        | 3306                  |
| 用户名/密码 | root/mQ2LZenlYs1UoVzi |



### 4.2 Redis 配置
- Redis 连接地址必须使用内网地址

  | url  | redis.middleware  |
  | ---- | ---------------- |
  | Port | 6379             |
  | 密码 | pNpX15GZkgICqX5D |

  

### 3.3 时序引擎配置

- TDengine
     - TDengine 链接地址必须使用内网地址
     - 账号必须使用管理员账号，因为需要使用此账号去初始化 DB 以及 RP 待信息

     | url         | taos-tdengine.middleware |
     | ----------- | ------------------------ |
     | 端口        | 6041                     |
     | 用户名/密码 | 您创建的账号/你设置的密码        |

### 4.4 日志引擎配置

- OpenSearch
       - 链接地址必须使用内网地址
           - 账号必须使用管理员账号
   
   | url         | opensearch-cluster-client.middleware |
   | ----------- | ------------------------------------ |
   | 端口        | 9200                                 |
   | 用户名/密码 | openes/kJMerxk3PwqQ                  |
   
   

### 4.5 其他设置

- {{{ custom_key.brand_name }}}管理后台的管理员账号初始账号名与邮箱（默认密码为 **admin，**建议登录后立即修改默认密码）
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

> TLS 域名证书填写

### 4.6 安装信息

汇总显示刚才填写的信息，如有信息填写错误可返回上一步修改

### 4.7 应用配置文件

安装程序会自动根据前面步骤提供的安装信息，初始化应用配置模板，但还是需要逐个检查所有应用模板，修改个性化应用配置，具体配置说明见安装界面。

确认无误后，提交创建配置文件。

### 4.8 应用镜像

- 选择正确的**共享存储**，即你前面步骤中创建的 **storage class** 名称
- 应用镜像会根据你选的 **Launcher** 版本，自动填写无需修改，确认无误后开始 **创建应用**

### 4.9 应用状态

此处会列出所有应用服务的启动状态，此过程需要下载所有镜像，可能需要几分钟到十几分钟，待全部服务都成功启动之后，即表示已安装成功。

**注意：服务启动过程中，必须停留在此页面不要关闭，到最后看到“版本信息写入成功”的提示，且没有弹出错误窗口，才表示安装成功！**

### 4.10 域名解析

将除 **df-kodo.dataflux.cn** 之外的其他所有子域名，都解析到 SLB 公网 IP 地址上 或 边缘节点 ingress 地址上：

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-openapi.dataflux.cn
- df-func.dataflux.cn
- df-static-res.dataflux.cn



由于本地部署 Kubernetes 集群无法使用 LoadBalancer 服务，所以需要使用 边缘节点 ingress。

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: df-kodo
  namespace: forethought-kodo
spec:
  rules:
  - host: df-kodo.dataflux.cn
    http:
      paths:
      - backend:
          serviceName: kodo-nginx
          servicePort: http
        path: /
        pathType: ImplementationSpecific
---
apiVersion: v1
kind: Service
metadata:
  name: kodo-nginx
  namespace: forethought-kodo
spec:
  ports:
  - name: https
    nodePort: 31841
    port: 443
    protocol: TCP
    targetPort: 80
  - name: http
    nodePort: 31385
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: deployment-forethought-kodo-kodo-nginx
  sessionAffinity: None
  type: NodePort

```

```shell
kubectl apply -f kodo-ingress.yaml
```

## 5. 安全设置
???+ warning "重要"

    经过以上步骤，{{{ custom_key.brand_name }}} 都安装完毕，可以进行验证，验证无误后一个很重要的步骤，将 launcher 服务下线，防止被误访问而破坏应用配置，可在**运维操作机**上执行以下命令，将 launcher 服务的 pod 副本数设为 0：

    ```shell
    kubectl patch deployment launcher \
    -p '{"spec": {"replicas": 0}}' \
    -n launcher
    ```
