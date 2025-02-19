# 快速部署指南



## 0. 简介

旨在通过本帮助文档，在离线环境快速部署{{{ custom_key.brand_name }}}

前置条件
???+ warning "重要"
    - **部署开始前请确保前置条件满足认真阅读下列部署手册内容**
    - **本文档相关离线包当前仅适配CentOS 7 x86_64 架构**
    - **当前版本{{{ custom_key.brand_name }}}需要一个正常提供服务的 NFS server**
    - **确保各节点时区设置一致、时间同步**
    - **文档中命令默认都需要root权限运行**
    - **确保在干净的系统上开始安装，不要使用曾经装过kubeadm或其他k8s发行版**
    - **基础环境离线资源包上传到所有集群节点，并解压到服务器/etc目录**
    - **部署节点和集群其他节点已配置ssh免密登录(包括部署节点自身)**	
    - **{{{ custom_key.brand_name }}}平台离线资源包上传到所有集群节点，定导入到容器运行时环境(containerd)**
    - **执行一键安装前一定要配置并检查自定义集群生成的配置文件。主要是/etc/kubease/clusters/xxx/hosts和/etc/kubeasz/clusters/config.yaml**
    - **修改方便识别的主机名【可选】**
    
  



**Kubernetes基础环境离线资源包下载地址**  [ https://{{{ custom_key.static_domain }}}/dataflux/package/k8s_offline.tar.gz](https://{{{ custom_key.static_domain }}}/dataflux/package/k8s_offline.tar.gz)

**{{{ custom_key.brand_name }}}平台离线资源包下载地址** 
=== "amd64"

    [https://{{{ custom_key.static_domain }}}/dataflux/package/guance-amd64-latest.tar.gz](https://{{{ custom_key.static_domain }}}/dataflux/package/guance-amd64-latest.tar.gz)
    

=== "arm64"

    
    [https://{{{ custom_key.static_domain }}}/dataflux/package/guance-arm64-latest.tar.gz](https://{{{ custom_key.static_domain }}}/dataflux/package/guance-arm64-latest.tar.gz)
    





**Launcher helm charts 资源包地址**[https://{{{ custom_key.static_domain }}}/dataflux/package/launcher-helm-latest.tgz](https://{{{ custom_key.static_domain }}}/dataflux/package/launcher-helm-latest.tgz)

**{{{ custom_key.brand_name }}}代理服务离线资源包下载地址** [https://{{{ custom_key.static_domain }}}/dataflux/package/docker-nginx.tar.gz]( https://{{{ custom_key.static_domain }}}/dataflux/package/docker-nginx.tar.gz)





## 1. 部署{{{ custom_key.brand_name }}}基础组件

- <u>[Kubernetes HA 离线部署指南](Kubernetes-HA-Guide.md)</u> 

  

## 2. 部署{{{ custom_key.brand_name }}}中间件
- <u>[Step 1 Redis 部署指南](Redis-deployment.md)</u> 
- <u>[Step 2 MySQL 部署指南](Mysql-deployment.md)</u>  
- <u>[Step 3 TDengine 部署指南](Tdengine-deployment.md)</u> 
- <u>[Step 4 OpenSearch 部署指南](Opensearch-deployment.md)</u> 




  

  

## 3. 部署{{{ custom_key.brand_name }}}安装器 

-  <u>[Launcher 服务安装配置](Launcher-deployment.md)</u> 

## 4. {{{ custom_key.brand_name }}}代理部署 

- <u>[{{{ custom_key.brand_name }}}代理部署](Proxy-deployment.md)</u> 
