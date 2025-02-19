# 部署必读



## 部署步骤 {#install-step}

{{{ custom_key.brand_name }}}部署可以按照以下步骤开始安装：

### 1、资源规划 和 材料准备

* 1.1 [资源规划和准备](basic-env-install.md#basic-planning)
* 1.2 [申请 License](get-license.md)

### 2、 部署基础设施

* 2.1 [部署基础设施](basic-env-install.md#basic-install)

### 3、部署{{{ custom_key.brand_name }}}

* 3.1 [使用 Launcher 部署产品](launcher-install.md)
* 3.2 [初始化 DataWay](dataway-install.md)
* 3.3 [激活{{{ custom_key.brand_name }}}](activate.md)

### 4、开始体验功能

* 4.1 [开始使用](experience-function.md)



## 注意事项

### 关于域名

部署需要提供一个域名，如果有真实域名，需要 DNS 解析，或使用本地 hosts 绑定。

以 `dataflux.cn` 为例，以下为每个二级域名的作用：

|     域名前缀      |           示例域名            |     指向      |        作用        | 是否必须 |
| :---------------: | :---------------------------: | :-----------: | :----------------: | :------: |
|     dataflux      |     dataflux.dataflux.cn      | Ingress-Nginx |  {{{ custom_key.brand_name }}}控制台前端  |    是    |
|      df-api       |      df-api.dataflux.cn       | Ingress-Nginx |  {{{ custom_key.brand_name }}}控制台api   |    是    |
|      df-docs      |      df-docs.dataflux.cn      | Ingress-Nginx |      帮助文档      |    否    |
|      df-func      |      df-func.dataflux.cn      | Ingress-Nginx |   {{{ custom_key.brand_name }}}计算服务   |    否    |
|      df-kodo      |      df-kodo.dataflux.cn      |  kodo-nginx   |  指标数据入口服务  |    是    |
|   df-management   |   df-management.dataflux.cn   | Ingress-Nginx | {{{ custom_key.brand_name }}}后台管理前端 |    是    |
| df-management-api | df-management-api.dataflux.cn | Ingress-Nginx | {{{ custom_key.brand_name }}}后台管理api  |    是    |
|    df-openapi     |    df-openapi.dataflux.cn     | Ingress-Nginx |   {{{ custom_key.brand_name }}}数据接口   |    否    |
|   df-static-res   |   df-static-res.dataflux.cn   | Ingress-Nginx | {{{ custom_key.brand_name }}}模版资源服务 |    是    |

更多{{{ custom_key.brand_name }}}组件介绍请参考：[组件说明](deployment-description.md#module)

### 关于集群存储类

???+ warning "注意"

     {{{ custom_key.brand_name }}}软件部署，必须使用  [nfs-subdir-external-provisioner](nfs-provisioner.md)



在部署{{{ custom_key.brand_name }}}服务主要涉及两个部分的部署，一个是基础组件部署，一个是{{{ custom_key.brand_name }}}软件部署。其中两个部署的存储类有所不同，对比如下：



|      名称      |    [nfs-subdir-external-provisioner](nfs-provisioner.md)     |             [OpenEBS](openebs-install.md)              |
| :------------: | :----------------------------------------------------------: | :----------------------------------------------------: |
| 是否需要第三方 |                           需要 NFS                           |                   不需要，本地盘即可                   |
|      性能      |                      网络存储，IO性能差                      |                   本地存储，IO性能高                   |
|    读写类型    |          ReadWriteMany、ReadOnlyMany、ReadWriteOnce          |                     ReadWriteOnce                      |
|   优点、缺点   |          优点：可以共享数据，多节点挂载 缺点：IO差           | 优点：高IO 缺点：不能多个pod跨节点共享，不支持动态调度 |
|    支持环境    |                 基础组件部署、{{{ custom_key.brand_name }}}软件部署                 |                      基础组件部署                      |
|      备注      | 如果客户环境是POC环境，可以使用该存储类部署基础组件、{{{ custom_key.brand_name }}}软件。如果是生产环境， 基础组件部署不建议使用该存储类 |              该存储不适用于部署{{{ custom_key.brand_name }}}软件              |

