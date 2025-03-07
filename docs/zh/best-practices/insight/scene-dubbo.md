# 内网场景 Dubbo 微服务接入<<< custom_key.brand_name >>>

---

> _作者： 刘玉杰_

## 简介

有的项目，用户群体是公司内部人员，或者集团公司人员。为了安全，这些项目部署在自建机房，员工通过内网或者 VPN 访问。针对这种场景，**<<< custom_key.brand_name >>>提供了离线部署方案**，即通过一台可以连外网的主机上部署 DataKit，开启 Proxy 采集器，内网的主机通过这台代理安装 DataKit，所有数据也是通过这台部署的 DataKit 上报到<<< custom_key.brand_name >>>。

下面使用微服务架构的项目来介绍如何接入<<< custom_key.brand_name >>>，项目是前后端分离的项目，前端使用 Vue 开发的，后端微服务使用 Spring Boot 结合 Dubbo 开发的，前端通过 Gateway 访问后端的服务。用户通过浏览器访问前端网站，用户点击界面上的按钮触发后端接口请求，请求被 Gateway 转发到 Consumer 微服务，Consumer 微服务处理请求过程中会调用 Provider 微服务，并记录日志，处理完成后把结果返回给浏览器，至此完成一次调用。

![image](../images/dubbo/01.png)

## 部署规划

示例的整个项目有四个服务，分别部署在四台主机上，另外需要一台能连外网的主机，这台主机也与其它四台主机在同一内网。

- 首先，在有外网的主机上部署 DataKit，开通 Proxy 采集器；
- 其次，其它四台主机通过这台代理安装 DataKit；
- 然后，在安装了 Nginx 的 Web 服务器上部署 Web 项目，这台 Web 主机的 9529 端口可以被内网的其它主机访问；
- 最后，部署 Gateway、Consumer、Provider 微服务，并开通 SkyWalking 采集器。

示例使用的服务可以在 [https://github.com/stevenliu2020/vue3-dubbo](https://github.com/stevenliu2020/vue3-dubbo) 下载，里面包含 `provider.jar`、`consumer.jar`、`gateway.jar` 和 `dist` 目录，dist 即是 vue 项目。  
下面是项目与主机的对应关系及整体部署架构图。

- 项目与主机的对应关系

| IP           | 部署项目          | 描述                    |
| ------------ | ----------------- | ----------------------- |
| 172.16.0.245 | DataKit （Proxy） | 可连外网                |
| 172.16.0.29  | Web/DataKit       | 内网，Web 服务器(Nginx) |
| 172.16.0.51  | Gateway/DataKit   | 内网，部署网关服务      |
| 172.16.0.52  | Consumer/DataKit  | 内网，部署消费者服务    |
| 172.16.0.53  | Provider/DataKit  | 内网，部署生产者服务    |

- 整体部署架构图

![image](../images/dubbo/02.png)

## 前置条件

- Centos 7.9
- 安装 Nginx
- 安装 JDK
- 安装 Zookeeper
- <<< custom_key.brand_name >>>账号

## 环境版本

???+ warning

    本次示例使用版本如下：DataKit `1.4.9`、Nginx `1.22.0`、Spring Cloud `3.1.1`、Spring Boot `2.6.6`、Dubbo `2.7.15`、Zookeeper `3.7.1`、Vue `3.2`、 JDK `1.8`

## 操作步骤

### 1 部署 DataKit

#### 1.1 在线部署 DataKit

登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」，进入「集成」模块，点击 「DataKit」 - 「Linux」，复制安装命令，在 172.16.0.245 主机上执行。注意安装命令中包含了 token，后续操作中会使用到这个 token。

![image](../images/dubbo/03.png)

安装完成后，执行如下命令开通 Proxy 采集器。

```shell
cd /usr/local/datakit/conf.d/proxy
cp proxy.conf.sample proxy.conf
```

编辑 `/usr/local/datakit/conf.d/datakit.conf` 文件，修改 `http_api` 的 listen 的值是 `0.0.0.0:9529`，确保其它主机可以正常访问这台主机的 9529 端口。

![image](../images/dubbo/04.png)

重启 DataKit。

```shell
systemctl restart datakit
```

#### 1.2 通过代理部署 DataKit

登录 `172.16.0.29` 主机，执行如下命令安装 DataKit。

这里 `172.16.0.245` 即是上步中安装的 DataKit 的主机 IP，此步骤即是通过 DataKit 代理来安装的，命令中使用到的 token 与上面提到的 token 相同。

```shell
export HTTPS_PROXY=http://172.16.0.245:9530;  DK_DATAWAY=https://openway.guance.com?token=tkn_9a1111123412341234123412341113bb bash -c "$(curl -L https://<<< custom_key.static_domain >>>/datakit/install.sh)"
```

执行如下命令，测试是否能上报数据到<<< custom_key.brand_name >>>。

```shell
curl -x http://172.16.0.245:9530 -v -X POST https://openway.guance.com/v1/write/metrics?token=tkn_9a1111123412341234123412341113bb -d "proxy_test,name=test c=123i"
```

返回 200 表示数据上报成功。

![image](../images/dubbo/05.png)

使用同样的步骤在 `172.16.0.51`、`172.16.0.52`、`172.16.0.53` 主机上部署 DataKit，至此四台主机部署 DataKit 完成。

### 2 APM 接入

#### 2.1 开启 SkyWaking 采集器

登录 `172.16.0.51` 主机，复制 sample 文件，开通 skywalking 采集器。

```shell
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

重启 DataKit。

```shell
systemctl restart datakit
```

使用同样的操作，开通 `172.16.0.52`、`172.16.0.53` 主机上部署的 DataKit 的 SkyWaking 采集器。

#### 2.2 上传 SkyWalking 探针

市面上 APM 工具比较多，由于微服务使用的是 dubbo 框架，这里推荐使用 SkyWalking。

下载 [apache-skywalking-java-agent-8.11.0](https://www.apache.org/dyn/closer.cgi/skywalking/java-agent/8.11.0/apache-skywalking-java-agent-8.11.0.tgz)，解压后把文件命名为 agent，上传到 172.16.0.51、172.16.0.52、172.16.0.53 主机的 `/usr/local/df-demo/` 目录。

> **注意：** 172.16.0.51 这台主机部署的是 gateway，需要把 `agent\optional-plugins` 目录下的 `apm-spring-cloud-gateway-3.x-plugin-8.11.0.jar` 和 `apm-spring-webflux-5.x-plugin-8.11.0.jar` 包 复制到 `agent\plugins` 目录下。

![image](../images/dubbo/06.png)

#### 2.3 部署 provider 微服务

上传 `provider.jar` 到 172.16.0.53 主机的 `/usr/local/df-demo/` 目录，确保 `provider.jar` 与 agent 文件夹相同目录。启动 provider 服务。

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-provider -Dskywalking.collector.backend_service=localhost:11800 -jar provider.jar
```

#### 2.4 部署 consumer 微服务

上传 `consumer.jar` 到 172.16.0.52 主机的 `/usr/local/df-demo/` 目录。启动 consumer 服务。

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-consumer -Dskywalking.collector.backend_service=localhost:11800 -jar consumer.jar
```

#### 2.5 部署 gateway 微服务

上传 `gateway.jar` 到 172.16.0.51 主机的 `/usr/local/df-demo/` 目录。启动 gateway 服务。

```shell
cd /usr/local/df-demo/
java -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=dubbo-gateway -Dskywalking.collector.backend_service=localhost:11800 -jar gateway.jar
```

### 3 RUM 接入

上传 `dist` 目录 到 172.16.0.29 主机的 `/usr/local/df-demo/ `目录，前端连接后端接口的 url 是在 `dist\js\app.ec288764.js` 文件内，这里后端 gateway 的 url 是 [http://172.16.0.51:9000/api](http://172.16.0.51:9000/api)。  
登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」，进入「用户访问监测」模块，新建 dubbo-web 应用，复制下面命令。

![image](../images/dubbo/07.png)

![image](../images/dubbo/08.png)

修改 `/etc/nginx/nginx.conf` 文件，增加如下内容：

```toml
server {
        listen       80;
        #add_header Access-Control-Allow-Origin '*';
        #add_header Access-Control-Allow-Headers Origin,X-Requested-Width,Content-Type,Accept;

        location / {
            proxy_set_header   Host    $host:$server_port;
            proxy_set_header   X-Real-IP   $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
            root   /usr/local/df-demo/dist;
            index  index.html index.htm;
        }
        #location /nginx_status{
        #        stub_status on;
        #}

    }

```

重新加载配置。

```shell
 nginx -s reload
```

浏览器访问 [http://172.16.0.29/](http://172.16.0.29/) ，即可访问前端界面，点击界面按钮会调用后端接口。

登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」，进入「用户访问监测」 - 「dubbo-web」，这里有许多功能可以用来对前端应用做性能分析。

![image](../images/dubbo/09.png)

### 4 日志接入

使用 SkyWalking 的 `apm-toolkit-log4j-2.x` 包，可以把 SkyWalking 生成的 traceId 通过 log4j2 输出到日志中。

DataKit 的 pipeline 可以提取日志中的 traceId 与链路关联。

#### 4.1 添加依赖

在 provider 微服务的日志中输出 traceId，需要在 provider 的 `pom.xml` 文件中添加依赖，版本与 javaagent 使用的版本相同，这里是 8.11.0。

```xml
<dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>8.11.0</version>
</dependency>
```

#### 4.2 开通日志采集器

登录 Provider 服务部署的服务器 172.16.0.53，复制 sample 文件。

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample logging.conf
```

编辑 `logging.conf` 文件，source 输入 `log-dubbo-provider`，这个名称在日志查询或者配置 pipeline 需要用到。logfiles 填待收集 log 文件路径。

![image](../images/dubbo/10.png)

重启 DataKit。

```shell
systemctl restart datakit
```

#### 4.3 pipeline

登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」，进入「日志」 - 「Pipelines」。<br/>
点击「新建 Pipeline」，过滤选择开通日志采集器定义的 source 即 `log-dubbo-provider` 。<br/>
定义解析规则输入如下内容，最后点击「保存」。

```toml
# 2022-08-03 10:55:50.818 [DubboServerHandler-172.16.0.29:20880-thread-2] INFO dubbo.service.StockAPIService - [decreaseStorage,21] - [TID: 1bc41dfa-3c2c-4917-9da7-0f48b4bcf4b7] - 用户ID：-4972683369271453960 ，发起流程审批：-1133938638

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - \\[TID: %{DATA:trace_id}\\] - %{GREEDYDATA:msg}")
default_time(time)
```

![image](../images/dubbo/11.png)

使用前端触发 provider 服务的调用，这样 provider 生成的日志即被 DataKit 采集后上报到<<< custom_key.brand_name >>>。

登录「[<<< custom_key.brand_name >>>](https://console.guance.com/)」，进入「日志」模块的查看器，数据来源找到 `log-dubbo-provider`，点击一条日志进去，可看到 traceId 已做为 tag，后面在 APM 中通过这个 traceId 即可关联到日志，帮助我们快速定位问题 。

![image](../images/dubbo/12.png)

### 5 联动分析

通过上面的步骤，已经完成了 Rum、Apm 和日志的联动。

登录「 [<<< custom_key.brand_name >>>](https://console.guance.com/)」 - 「用户访问监测」，点击 「dubbo-web」进入后点击「查看器」，选择「view」，查看页面调用情况。<br/>
然后点击「route_change」进入，在 Fetch/XHR 标签可以查看到前端触发的接口调用情况，点击一条进入后，可查看火焰图、span 列表、服务调用关系，及关联的 provider 服务的日志。

![image](../images/dubbo/13.png)

![image](../images/dubbo/14.png)
