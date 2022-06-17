# 连接并操作DataKit
---


本文档主要介绍如何使用本系统连接Datakit。

> 提示：请始终使用最新版DataFlux Func 进行操作。

## 1. 背景

某些情况下，独立安装部署的DataFlux Func 也需要与观测云进行交互，包括且不限于：

- DataFlux Func 充当采集器，向观测云上报数据
- DataFlux Func 中的业务处理需要观测云中的数据

有关DataFlux Func 的安装，请参考：

- [DataFlux Func 快速开始](/dataflux-func/quick-start)

有关DataFlux Func 的使用、维护，请参考：

- [DataFlux Func 用户手册](/dataflux-func/user-guide)
- [DataFlux Func 开发手册](/dataflux-func/development-guide)
- [DataFlux Func 维护手册](/dataflux-func/maintenance-guide)

## 2. 确保DataKit 数据源及联通性

在使用DataFlux Func 向DataKit 写入数据之前，首先要确保连通性。
因此，在DataKit 安装完成后，需要调整配置，允许DataFlux Func 连接。

可以将DataFlux Func 和DataKit 安装在同一台服务器上运行，DataFlux Func 在启动时会自动寻找本机安装的DataKit。

但是，由于DataFlux Func 通过Docker Stack 方式运行并桥接到宿主机`docker0`，与宿主机本地网络并不直接连通。因此，即使DataFlux Func 和DataKit 安装在同一台服务器，也不能简单将DataKit 监听端口绑定到本地网络（`127.0.0.1`）。

此时，应当修改配置，将监听端口绑定到`docker0`（`172.17.0.1`）或`0.0.0.0`，总结如下：

| 绑定IP       | 宿主机                                | DataFlux Func          | 外部系统           |
| ------------ | ------------------------------------- | ---------------------- | ------------------ |
| `127.0.0.1`  | 可通过`127.0.0.1`访问                 | 无法访问               | 无法访问           |
| `172.17.0.1` | 可通过`172.17.0.1`访问                | 可通过`172.17.0.1`访问 | 无法访问           |
| `0.0.0.0`    | 可通过`127.0.0.1`、`172.17.0.1`等访问 | 可通过`172.17.0.1`访问 | 可通过宿主机IP访问 |

DataKit 位于DataFlux Func 宿主机上时的参考操作：

1. 打开DataKit配置：`sudo vim /usr/local/datakit/conf.d/datakit.conf`
2. 将`http_listen = "localhost:9529"`修改为`http_listen = "0.0.0.0:9529"`
3. 重启DataKit：`sudo datakit --restart`
4. 确认可以通过`docker0`访问DataKit：`curl -i http://172.17.0.1:9529/v1/ping`
5. 返回`HTTP/1.1 200 OK`即表示成功

DataKit的安装、部署等文档见[DataKit 文档](/datakit/datakit-how-to)

### 2.1 直接使用自动生成的DataKit 数据源

DataFlux Func 在启动时，会自动尝试到宿主机网络寻找可能存在的DataKit。

如果成功发现了DataKit，系统会自动在「数据源」中创建此DataKit 的数据源，用户无需手工添加。

### 2.2 手工添加DataKit 数据源

某些情况下，DataKit Func 无法自动发现DataKit，如：

- DataFlux Func 启动时，DataKit 尚未安装
- DataKit 未正确配置，导致DataFlux Func 无法连通本机DataKit
- DataKit 的配置进行了修改，如使用了非默认端口
- 需要连接的DataKit 在另一台服务器上

此时，需要用户在「数据源」中手工添加DataKit：

| 选项 | 示例值          | 说明                                                                                                                                      |
| ---- | --------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| ID   | `datakit`       | 用于后续使用`DFF.SRC('{ID值}')`获取操作对象                                                                                               |
| 主机 | `172.17.0.1`    | 由于DataFlux Func 运行在Docker 中，此处填写的是`docker0`的地址，用于访问宿主机上的DataKit。<br>如果DataKit 在网络位置，则填写实际域名或IP |
| 端口 | `9529`          | 如果您改变了DataKit的默认监听端口，那么此处需要填写实际监听端口                                                                           |
| 协议 | `HTTP`          | 正常HTTP即可。<br>如果您的DataKit 部署在网络位置，并且有域名、有证书等，可以按照实际填写                                                  |
| 源   | `dataflux_func` | 即DataKit 的input。<br>不建议改成mysql 之类已经实际存在的input，避免混淆                                                                  |

![](connect-to-datakit/add-datakit-in-data-source.png)

## 3. 编写代码操作DataKit

完成DataKit 数据源的创建后，即可在代码中操作DataKit：

~~~python
@DFF.API('DataKit Demo')
def datakit_demo():
    # 获取DataKit 操作对象
    datakit = DFF.SRC('datakit')

    # 将数据作为指标写入DataKit
    datakit.write_metric(measurement='指标', tags={'标签名':'标签值'}, fields={'字段名':'字段值'})

    # 将数据作为日志写入DataKit
    datakit.write_logging(measurement='指标', tags={'标签名':'标签值'}, fields={'字段名':'字段值'})

    # 使用DQL语句查询数据
    data = datakit.query(dql='M::指标')
~~~

## X. 更多文档

有关DataKit 操作对象的完整API文档，请参考：

- [DataFlux Func 开发手册](/dataflux-func/development-guide) 中的「DataKit」章节
