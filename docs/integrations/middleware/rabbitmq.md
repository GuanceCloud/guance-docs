
# RabbitMQ
---

操作系统支持：Linux / Windows

## 视图预览

RabbitMQ 性能指标展示：包括连接数量、通道数量、队列量、消费者数、队列消息速率、队列消息数、交换机、节点、队列等。

![image](../imgs/input-rabbit-1.png)

![image](../imgs/input-rabbit-2.png)

## 安装部署

说明：示例 RabbitMQ 版本为：rabbitmq-server-3.7.17(CentOS7)，各个不同版本指标可能存在差异

### 前置条件

- RabbitMQ 所在服务器 <[安装 Datakit](../../datakit/datakit-install.md)>
- RabbitMQ 已安装

```
systemctl status rabbitmq-server
```

![image](../imgs/input-rabbit-3.png)

配置实施

#### 指标采集 (必选)

1、 开启rabbitmq_management插件

RabbitMQ 采集器是通过插件 `rabbitmq_management` 采集数据监控 RabbitMQ ,它能够：

- RabbitMQ overview 总览，比如连接数、队列数、消息总数等
- 跟踪 RabbitMQ queue 信息，比如队列大小，消费者计数等
- 跟踪 RabbitMQ node 信息，比如使用的 `socket` `mem` 等
- 跟踪 RabbitMQ exchange 信息 ，比如 `message_publish_count` 等

登录安装rabbitmq的服务器，执行如下命令：

```
rabbitmq-plugins enable rabbitmq_management
```    

2、 rabbitmq新增dataflux账号，并赋予monitoring角色

登录安装rabbitmq的服务器，执行如下命令：

```
rabbitmqctl add_user dataflux Datakit1234
rabbitmqctl set_user_tags dataflux monitoring
rabbitmqctl set_permissions -p / dataflux "^aliveness-test$" "^amq\.default$" ".*"
```

3、 开启RabbitMQ插件，复制sample文件

```
cd /usr/local/datakit/conf.d/rabbitmq
cp rabbitmq.conf.sample rabbitmq.conf
```

4、 修改rabbitmq.conf 配置文件

```
vi rabbitmq.conf
```

参数说明

- url：rabbitmq的url
- username：步骤2中设置的用户名
- password：步骤2中设置的密码
- interval：数据采集频率
- insecure_skip_verify：是否忽略安全验证 (如果是 https，请设置为 true)

```
[[inputs.rabbitmq]]
  # rabbitmq url ,required
  url = "http://localhost:15672"

  # rabbitmq user, required
  username = "dataflux"

  # rabbitmq password, required
  password = "Datakit1234"

  # ##(optional) collection interval, default is 30s
  # interval = "30s"

  ## Optional TLS Config
  # tls_ca = "/xxx/ca.pem"
  # tls_cert = "/xxx/cert.cer"
  # tls_key = "/xxx/key.key"
  ## Use TLS but skip chain & host verification
  insecure_skip_verify = false

```

5、 重启 Datakit (如果需要开启日志，请配置日志采集再重启)

```
systemctl restart datakit
```

指标预览

![image](../imgs/input-rabbit-4.png)

#### 日志采集 (非必选)

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- pipeline：日志切割文件(内置)，实际文件路径 /usr/local/datakit/pipeline/rabbitmq.p
- 相关文档 <[DataFlux pipeline 文本数据处理](../../datakit/pipeline.md)>
```
vi /usr/local/datakit/conf.d/rabbitmq/rabbitmq.conf
```
```
  [inputs.rabbitmq.log]
  files = ["/var/log/rabbitmq/rabbit@df_solution_ecs_008.log"]
  #  # grok pipeline script path
  pipeline = "rabbitmq.p"

```

重启 Datakit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

日志预览

![image](../imgs/input-rabbit-5.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 rabbitmq 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../../best-practices/insight/tag.md)>

```
  [inputs.rabbitmq.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

重启 Datakit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Rabbitmq 监控视图>

## 检测库
暂无

## [指标详解](/datakit/rabbitmq#measurements)


## 最佳实践
暂无

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>