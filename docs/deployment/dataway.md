# 数据网关
---

## 简介

DataWay 是观测云的数据网关，采集器上报数据到观测云都需要经过 DataWay 网关，DataWay 网关主要作用有两个：

- 接收采集器发送的数据，然后上报到观测云进行存储，多用于数据代理上报的场景； 
- 将采集的数据进行处理后再发送到观测云进行存储，多用于数据清洗的场景。 

注意：观测云部署版 DataWay 需要在本地服务器进行安装后才可以使用。
## 新建 DataWay

在观测云管理后台「数据网关」页面，点击「新建 DataWay 」。

![](img/19.deployment_1.png)

输入“名称”、“绑定地址”，点击「创建」。

- 绑定地址：即 DataWay 网关地址，必须填写完整的 HTTP 地址，例如 http(s)://1.2.3.4:9528，包含协议、主机地址和端口， 主机地址一般可使用部署 DataWay 机器的 IP 地址，也可以指定为一个域名，域名需做好解析。**注意：需确保采集器能够访问该地址，否则数据将采集将不成功）**

![](img/19.deployment_2.png)

创建成功后会自动创建新的 DataWay 并生成 DataWay 的安装脚本。

![](img/19.deployment_3.png)

## 安装 DataWay

新建的 DataWay 支持 Linux 和 Docker 两种安装方式，复制安装脚本到需要部署 DataWay 的服务器中执行。安装成功会提示如下图所示信息。此时 DataWay 默认会自动运行。

![](img/19.deployment_4.png)

安装完毕后，等待片刻刷新“数据网关”页面，如果在刚刚添加的数据网关的“版本信息”列中看到了版本号，即表示这个 DataWay 已成功与观测云中心连接，前台用户可以通过它来接入数据了。

![](img/19.deployment_6.png)

### 注意事项

-  只能在 Linux 系统上运行，不要在 Mac/Windows 等非 Linux 机器上执行安装脚本 
-  关于 Docker 形式安装 
   -  DataWay 支持以 Docker 方式运行，在执行命令头部增加 `DOCKER=1` 即可 
   -  除了增加 `DOCKER=1` 这个设置之外，还可以增加以下这些选项（**在非 Docker 安装中，也能指定**) 
      - `DW_BIND=<port>`: 这个是**容器内部**的绑定端口(**不要超过 50000**)，会占用宿主机的 `10000 + <port>` 端口。如果不指定，该端口默认为 `9528`，即使用宿主机上的 `19528` 端口。故务必确保宿主机上该端口可用。如果不是以 Docker 方式运行，则该处指定的端口即**宿主机将占用的端口**。
      - `DW_KODO=<http://your-kodo-host:port>`: 用于指定特定的 kodo 服务器地址
      - `DW_UPGRADE=1`: 升级的时候，指定该选项即可。另外，即使只是升级，如果被升级的 DataWay 是运行在 Docker 中的，也需要指定 `DOCKER=1` 这个选项
   -  建议**不要在非 Linux 环境下用 Docker 安装**(虽然主流的 Windows/Mac 都已经支持 Docker) 
   -  用 Docker 安装，**不是登陆到 Docker 容器之后再安装，而是在宿主机上直接执行安装指令** 
   -  执行 `docker ps -a |grep <your-agent-uuid>` 即可看到运行 DataWay 的容器情况(**需要 root 权限**) 
   -  安装完后，数据文件会落在宿主机 `/dataway-data/<your-agent-uuid>/` 目录下，包括程序、配置文件、数据文件以及日志等。如果要更新配置文件以及 license 文件，请再宿主机的该目录下更新即可，更新完后，记得重启容器: `docker restart <dataway-container-id>` 

## 使用 DataWay 

DataWay 成功与观测云中心连接后，登录观测云控制台，在「集成」-「DataKit」页面，即可查看所有的 DataWay 地址，选择需要的 DataWay 网关地址，获取 DataKit 安装指令在服务器上执行，即可开始采集数据。

![](img/19.deployment_6.png)

## 管理 DataWay

### 删除 DataWay

在观测云管理后台「数据网关」页面，选择需要删除的 DataWay ，点击「配置」，在弹出的编辑 DataWay 对话框，点击左下角「删除」按钮即可。

**注意：**删除 DataWay 后，还需登录部署 DataWay 网关的服务器中停止 DataWay 的运行，然后删除安装目录才可彻底删除 DataWay。

![](img/19.deployment_7.png)

### 升级 DataWay

在观测云管理后台「数据网关」页面，如果 DataWay 存在可升级的版本，版本信息处会有升级提示。选择需要升级的 DataWay，点击「配置」，，在弹出的编辑 DataWay 对话框，打开 DataWay 弹框，点击「获取升级脚本」，复制升级脚本到部署 DataWay 的主机上执行即可。

![](img/19.deployment_8.png)

### 更改 DataWay 配置

打开配置文件 `dataway.yaml`：

```
bind             : ":9528"                                       # 绑定地址和端口，如果希望调整为 1.2.3.4，端口 9538，可配置为 "1.2.3.4:9538"
remote_host      : "https://kodo.dataflux.cn/"                   # kodo服务地址
ws_bind:         : ":9530"                                       # datakit websocket proxy bind 
remote_ws_host   : "wss://kodo.dataflux.cn"                      # ws 服务 地址
log       : /usr/local/cloudcare/dataflux/dataway/log            # 日志文件位置
log_level : info                                                 # 日志等级
gin_log   : /usr/local/cloudcare/dataflux/dataway/gin.log        # gin 日志文件位置

enable_internal_token : true                                     # 允许使用 __internal__ 这个 token，此时数据打到系统工作空间
enable_empty_token    : true                                     # 允许 token 为空，此时数据打到系统工作空间
```

### DataWay 状态管理命令

**systemd**

```
启动：systemctl start dataway
重启：systemctl restart dataway
停止：systemctl stop dataway
```

**upstart**

```
启动：start dataway
重启：restart dataway
停止：stop dataway
```

**其他**

其他状态管理命令可参考安装成功后的终端提示

### DataWay 相关路径

DataWay 默认数据上报路径为 `/v1/write/metrics`

DataWay 默认安装路径为 `/usr/local/cloudcare/dataflux/dataway`

DataWay 默认网关地址：`绑定地址/v1/write/metrics`

```
dataway.yaml： DataWay 配置文件
install.log：DataWay 安装日志
log：DataWay 运行日志
```


