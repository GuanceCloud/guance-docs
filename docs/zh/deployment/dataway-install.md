# 观测云 DataWay 部署

## 前提条件

- 已部署观测云，未部署参考 [使用 Launcher 部署产品](launcher-install.md)


## 基础信息及兼容

|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|      观测云管理控制台      |  http://df-management.dataflux.cn  |
|    是否支离线安装    |                       是                        |
|       支持架构       |                   amd64/arm64                   |
|      部署机器IP      |                 192.168.100.105                 |



## 安装步骤

### 1、新建 DataWay

登录后台管理控制台 `http://df-management.dataflux.cn ` ，使用管理员账号，密码为 `admin`，账号为你设置的管理员的账号，进入“**观测云管理后台**”的“**数据网关**”菜单，点击“新建 DataWay”，添加一个数据网关 DataWay 。

- **名称**：自定义名称即可
- **绑定地址**：DataWay 的访问地址，在 DataKit 中接入数据使用，可以使用 `http://ip+端口`

**注意：在配置 DataWay 绑定地址时，必须保证 DataKit 主机与这个 DataWay 地址的连通性，能通过这个 DataWay 地址上报数据。**

![](img/12.deployment_1.png)

### 2、 安装 DataWay
DataWay 添加完成后，可获取到一个 DataWay 的安装脚本，复制安装脚本，在部署 DataWay 的主机上运行安装脚本。

???+ warning "注意"
     **此处需要确保部署 DataWay 的这台主机，能访问到前面配置的 kodo 地址，建议 DataWay 通过内网到 kodo！**

![](img/12.deployment_2.png)

安装完毕后，等待片刻刷新“数据网关”页面，如果在刚刚添加的数据网关的“版本信息”列中看到了版本号，即表示这个 DataWay 已成功与观测云中心连接，前台用户可以通过它来接入数据了。

![](img/12.deployment_3.png)