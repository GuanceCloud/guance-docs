# 应用镜像获取


## 线上获取

观测云镜像公网地址可以访问 [观测云版本历史](changelog.md) 获取。



## 观测云离线包下载、导入 {#offline-image}

如果是离线网络环境下安装，需要先手工下载最新的观测云镜像包，通过  docker load  命令将所有镜像导入到各个 kubernetes 工作节点上后，再进行后续的引导安装。

最新的观测云 Docker 镜像包下载地址：[https://static.guance.com/dataflux/package/guance-latest.tar.gz](https://static.guance.com/dataflux/package/guance-latest.tar.gz)

1. 通过以下命令，将 Docker 镜像包下载到本地：
```shell
$ wget https://static.guance.com/dataflux/package/guance-latest.tar.gz
```

2. 下载后，将 Docker 镜像包上传到 kubernetes 的每一个 node 主机上后，执行以下命令，导入 Docker 镜像：
- **Docker 环境导入镜像命令：**
```shell
$ gunzip -c guance-latest.tar.gz | docker load
```

- **Containterd 环境导入镜像命令：**
```shell
$ gunzip guance-latest.tar.gz
$ ctr -n=k8s.io images import guance-latest.tar

```

???+ warning "注意"
     如果 kubernetes 节点主机可以访问公网，不需要通过以上离线导入的方式导入镜像，安装程序会自动下载镜像。