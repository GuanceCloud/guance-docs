# 连接并操作 DataKit
---


本文档主要介绍如何使用本系统连接 Datakit。

> 提示：请始终使用最新版 DataFlux Func 进行操作。

## 1. 背景

某些情况下，独立安装部署的 DataFlux Func 也需要与观测云进行交互，包括且不限于：

- DataFlux Func 充当采集器，向观测云上报数据
- DataFlux Func 中的业务处理需要观测云中的数据

有关 DataFlux Func 的安装，请参考：

- [DataFlux Func 快速开始](/dataflux-func/quick-start)

有关 DataFlux Func 的使用、维护，请参考：

- [DataFlux Func 用户手册](/dataflux-func/user-guide)
- [DataFlux Func 开发手册](/dataflux-func/development-guide)
- [DataFlux Func 维护手册](/dataflux-func/maintenance-guide)

## 2. 确保 DataKit 数据源及联通性

在使用 DataFlux Func 向 DataKit 写入数据之前，首先要确保连通性。
因此，在 DataKit 安装完成后，需要调整配置，允许 DataFlux Func 连接。

可以将 DataFlux Func 和 DataKit 安装在同一台服务器上运行，DataFlux Func 在启动时会自动寻找本机安装的 DataKit。

但是，由于 DataFlux Func 通过 Docker Stack 方式运行并桥接到宿主机`docker0`，与宿主机本地网络并不直接连通。因此，即使 DataFlux Func 和 DataKit 安装在同一台服务器，也不能简单将 DataKit 监听端口绑定到本地网络（`127.0.0.1`）。

此时，应当修改配置，将监听端口绑定到`docker0`（`172.17.0.1`）或`0.0.0.0`，总结如下：

| 绑定 IP      | 宿主机                                | DataFlux Func          | 外部系统             |
| ------------ | ------------------------------------- | ---------------------- | -------------------- |
| `127.0.0.1`  | 可通过`127.0.0.1`访问                 | 无法访问               | 无法访问             |
| `172.17.0.1` | 可通过`172.17.0.1`访问                | 可通过`172.17.0.1`访问 | 无法访问             |
| `0.0.0.0`    | 可通过`127.0.0.1`、`172.17.0.1`等访问 | 可通过`172.17.0.1`访问 | 可通过宿主机 IP 访问 |

DataKit 位于 DataFlux Func 宿主机上时的参考操作：

1. 打开 DataKit 配置：`sudo vim /usr/local/datakit/conf.d/datakit.conf`
2. 将`http_listen = "localhost:9529"`修改为`http_listen = "0.0.0.0:9529"`
3. 重启 DataKit：`sudo datakit --restart`
4. 确认可以通过`docker0`访问 DataKit：`curl -i http://172.17.0.1:9529/v1/ping`
5. 返回`HTTP/1.1 200 OK`即表示成功

DataKit 的安装、部署等文档见 [DataKit 文档](/datakit/)

### 2.1 直接使用自动生成的 DataKit 数据源

DataFlux Func 在启动时，会自动尝试到宿主机网络寻找可能存在的 DataKit。

如果成功发现了 DataKit，系统会自动在「数据源」中创建此 DataKit 的数据源，用户无需手工添加。

### 2.2 手工添加 DataKit 数据源

某些情况下，DataKit Func 无法自动发现 DataKit，如：

- DataFlux Func 启动时，DataKit 尚未安装
- DataKit 未正确配置，导致 DataFlux Func 无法连通本机 DataKit
- DataKit 的配置进行了修改，如使用了非默认端口
- 需要连接的 DataKit 在另一台服务器上

此时，需要用户在「数据源」中手工添加 DataKit：

| 选项 | 示例值          | 说明                                                                                                                                           |
| ---- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| ID   | `datakit`       | 用于后续使用`DFF.SRC('{ID 值}')`获取操作对象                                                                                                   |
| 主机 | `172.17.0.1`    | 由于 DataFlux Func 运行在 Docker 中，此处填写的是`docker0`的地址，用于访问宿主机上的 DataKit。<br>如果 DataKit 在网络位置，则填写实际域名或 IP |
| 端口 | `9529`          | 如果您改变了 DataKit 的默认监听端口，那么此处需要填写实际监听端口                                                                              |
| 协议 | `HTTP`          | 正常 HTTP 即可。<br>如果您的 DataKit 部署在网络位置，并且有域名、有证书等，可以按照实际填写                                                    |
| 源   | `dataflux_func` | 即 DataKit 的 input。<br>不建议改成 mysql 之类已经实际存在的 input，避免混淆                                                                   |

![](connect-to-datakit/add-datakit-in-data-source.png)

## 3. 编写代码操作 DataKit

完成 DataKit 数据源的创建后，即可在代码中操作 DataKit：

~~~python
@DFF.API('DataKit Demo')
def datakit_demo():
    # 获取 DataKit 操作对象
    datakit = DFF.SRC('datakit')

    # 将数据作为指标写入 DataKit
    datakit.write_metric(measurement='指标', tags={'标签名':'标签值'}, fields={'字段名':'字段值'})

    # 将数据作为日志写入 DataKit
    datakit.write_logging(measurement='指标', tags={'标签名':'标签值'}, fields={'字段名':'字段值'})

    # 使用 DQL 语句查询数据
    data = datakit.query(dql='M:: 指标')
~~~

## X. 更多文档

有关 DataKit 操作对象的完整 API 文档，请参考：

- [DataFlux Func 开发手册](/dataflux-func/development-guide) 中的「DataKit」章节