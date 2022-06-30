# JAVA 应用 RUM-APM-LOG 联动分析

---

## 应用场景介绍：
本文用于演示的 demo 为若依办公系统，具体内容可查看 [从 0 到 1 利用观测云构建 Spring cloud 服务的可观测性](./apm/spring-cloud-sample.md)。

企业最重要的营收来源即是业务，而现当下，绝大多数企业的业务都是由对应的IT系统承载的，那如何保障企业的业务稳健，归根到企业内部就是如何保障企业内部的IT系统。当业务系统出现异常或故障时，往往是业务、应用开发、运维等多方面同事一起协调进行问题的排查，存在跨平台，跨部门，跨专业领域等多种问题，排查既耗时又费力，为了解决这一问题，目前业界已经比较成熟的方式即是在基础设施监控之外，对应用层、日志层进行深度的监控，通过 RUM+APM+LOG 实现对整个业务系统最核心的的前后端应用、日志进行统一管理，能力强一些的监控还可以将这三方面数据通过关键字段进行打通，实现联动分析，从而提升相关工作人员的工作效率，保障系统平稳运行。目前 Dataflux 已具备这样的能力，本文将从如何接入 RUM+APM+LOG 这三方监控，以及如何利用df进行联动分析的角度进行阐述。

**APM**:（application performance monitoring：应用性能监控）
**RUM**:（real user moitoring：真实用户体验监控）
**LOG**：（日志）

## 安装Datakit：

##### 1、登录[官网](https://www.guance.com)

##### 2、新建工作空间

##### 3、选择集成——datakit——选择适合自己环境额安装指令并复制

![image](../images/java-rum-apm-log/1.png)

##### 4、在服务器上安装 datakit

##### 5、执行 service datakit status （或者 systemctl status datakit）查询 datakit 状态

![image](../images/java-rum-apm-log/2.png)

![image](../images/java-rum-apm-log/3.png)

**Datakit 安装好后，默认会对如下内容进行采集，可直接在 Dataflux——基础设施——主机查看相关数据**<br />**选择不同的集成 inputs 名称，就可以查看对应的监控视图，监控视图下方还可以查看其它数据，例如日志、进程、容器等信息。**

| 采集器名称   | 说明                                                 |
| ------------ | ---------------------------------------------------- |
| cpu          | 采集主机的 CPU 使用情况                              |
| disk         | 采集磁盘占用情况                                     |
| diskio       | 采集主机的磁盘 IO 情况                               |
| mem          | 采集主机的内存使用情况                               |
| swap         | 采集 Swap 内存使用情况                               |
| system       | 采集主机操作系统负载                                 |
| net          | 采集主机网络流量情况                                 |
| host_process | 采集主机上常驻<br />（存活 10min 以上）进程列表      |
| hostobject   | 采集主机基础信息<br />（如操作系统信息、硬件信息等） |
| docker       | 采集主机上可能的容器对象以及容器日志                 |


![image](../images/java-rum-apm-log/4.png)

## RUM（real user moitoring）：

详细步骤参见文档 [web 应用监控（RUM）最佳实践](./apm/web.md)

##### 1、登录 Dataflux 平台

##### 2、选择用户访问监测——新建应用——选择web类型——同步载入

![image](../images/java-rum-apm-log/5.png)

##### 3、在前端页面 index.html 中接入DF rum可观测性 js 文件

```
$ cd /usr/local/ruoyi/dist/index.html

// 记得备份
$ cp index.html index.html.bkd

// 在 index.html 中添加 df-js
// 复制 DF 平台上的 j s内容，放至 index.html 内的 </head> 之前，然后保存文件,示例如下
// datakitOrigin：datakit 地址，df 中 rum 数据流向为：rum.js 文件——datakit——dataway——DF 平台
   如若是生产环境，需将该 IP 设置为域名，测试环境需填写内网IP，对应有 datakit 的服务器 9529 端口
// trackInteractions：用户行为采集配置项，可实现页面端用户操作行为统计
// allowedDDTracingOrigins：前后端（ rum 与 apm ）打通的配置项，可按需进行设置，需在此处填写与前端页面有交互关系的后端服务器所对应的域名或 IP，127.0.0.1 仅为示例。

$ vim index.html

<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'xxxxxxxxxxxxxxxxxxxxxxxxxx',
      datakitOrigin: 'http://127.0.0.1:9529'
      env: 'test',
      version: '1.0.0',
      trackInteractions: true,
      allowedDDTracingOrigins:["http://127.0.0.1"]
      })
</script></head> 
```

**注意事项：**

- **datakitOrigin**：数据传输地址，生产环境如若配置的是域名，可将域名请求转发至具体任意一台安装有datakit-9529 端口的服务器，如若前端访问量过大，可在域名与 datakit 所在服务器中间加一层 slb，前端 js 将数据发送至 slb，slb 将请求转发至多台安装 datakit-9529 所在的服务器。多台 datakit 承接 rum 数据，因前端请求复用因素，session 数据不会中断，对 rum 数据展现也无影响。

举例：

![image](../images/java-rum-apm-log/6.png)

![image](../images/java-rum-apm-log/7.png)

- **allowedDDTracingOrigins**：实现前后端（APM 与 RUM）打通，该场景只有在前端部署 RUM，后端部署APM 的情况才会生效，需在此处填写与前端页面有交互关系的后端应用服务器所对应的域名（生产环境）或IP（测试环境）。**应用场景**：前端用户访问出现慢，是由后端代码逻辑异常导致，可通过前端 RUM 慢请求数据直接跳转至 APM 数据查看当次后端代码调用情况，判定慢的根因。**实现原理**：用户访问前端应用，前端应用进行资源及请求调用，触发 rum-js 性能数据采集，rum-js 会生成 trace-id 写在请求的 request_header 里，请求到达后端，后端的 ddtrace 会读取到该 trace_id 并记录在自己的 trace 数据里，从而实现通过相同的 trace_id 来实现应用性能监测和用户访问监测数据联动
- **env**：必填，应用所属环境，是test或product或其他字段。
- **version**：必填，应用所属版本号。
- **trackInteractions**：用户行为统计，例如点击按钮，提交信息等动作。

![image](../images/java-rum-apm-log/8.png)

##### 4、保存、验证并发布页面

打开浏览器访问目标页面，通过 F12 检查者模式查看页面网络请求中是否有 rum 相关的请求，状态码是否是 200。

![image](../images/java-rum-apm-log/9.png)

**注意！！**：如若 F12 检查者模式发现数据无法上报，显示端口 refused，可 telnet IP:9529 验证端口是否通畅，不通的话，需要修改 /usr/local/datakit/conf.d/datakit.conf 修改首行的 http_listen 为 0.0.0.0，如若还不通，请检查安全组是否已打开 9529 端口。

![image](../images/java-rum-apm-log/10.png)

##### 5、在用户访问监测查看 rum 相关数据

![image](../images/java-rum-apm-log/11.png)

# APM（application performance monitoring）：

详细步骤参见文档 [分布式链路追踪(APM)最佳实践](./apm/apm.md)<br />**DF 支持的 APM 接入方式包含 ddtrace、skywalking、zipkin、jaejer 等多种支持 opentracing 协议的 APM 工具，此处示例采用 ddtrace 实现 APM 方面的可观测性。**

##### 1、在 Datakit 中修改 APM（ddtrace）的 inputs

**默认不需要修改 jvm 的 inputs，仅需复制生成 conf 文件即可**

```
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# 默认不需要修改
```

##### 2、修改 java 应用启动脚本

APM 可观测性，需要在 java 应用中添加一个 agent，该 agent 在伴随应用启动时，会通过字节码注入的技术实现对应用内部方法层层调用、sql 调用、外部系统调用等相关性能数据的采集，从而实现对应用系统代码质量的可观测性。

```
#原应用启动脚本
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &

——————————————————————————————————————————————————————————————————————————————————————————

#添加 ddtrace-agent 后的应用启动脚本
$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000  -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar  -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log  2>&1 & 
```

**ddtrace 相关环境变量（启动参数）释义：**

- Ddd.env：自定义环境类型，可选项。
- Ddd.tags：自定义应用标签 ，可选项。
- Ddd.service.name：自定义应用名称 ，必填项。
- Ddd.agent.port：数据上传端口（默认 9529 ），必填项。
- Ddd.version:应用版本，可选项。
- Ddd.trace.sample.rate：设置采样率（默认是全采），可选项，如需采样，可设置 0~1 之间的数，例如 0.6，即采样 60%。
- Ddd.service.mapping：当前应用调用到的 redis、mysql 等，可通过此参数添加别名，用以和其他应用调用到的 redis、mysql 进行区分，可选项，应用场景：例如项目 A 项目 B 都调用了mysql，且分别调用的 mysql-a，mysql-b，如没有添加 mapping 配置项，在 df 平台上会展现项目A项目B调用了同一个名为 mysql 的数据库，如果添加了 mapping 配置项，配置为 mysql-a，mysql-b，则在 df 平台上会展现项目 A 调用 mysql-a，项目 B 调用 mysql-b。
- Ddd.agent.host：数据传输目标IP，默认为本机 localhost，可选项。

##### 3、在DF平台查看APM数据

APM（应用性能检测）是 DF 默认内置的模块，无需创建场景或视图即可进行查看。
路径：DF 平台——应用性能检测
视图示例:（通过该视图即可快速查看应用调用情况、拓扑图、异常数据等其他 APM 相关数据）

![image](../images/java-rum-apm-log/12.png)

![image](../images/java-rum-apm-log/13.png)

调用链路的问题追踪：排查接口、数据库问题

![image](../images/java-rum-apm-log/14.png)

## 日志（LOG）：

详细步骤参见文档[[日志采集](../../integrations/logging.md)]

##### 1、标准日志采集（Nginx、mysql、redis等）

通过开启Datakit内置的各种inputs，直接开启相关的日志采集，例如 [Ngnix](../../datakit/nginx.md#62b5133f)、 [Redis](../../datakit/redis.md#62b5133f)、[Docker](../../integrations/container.md)、[ES](../../integrations/elasticsearch.md#62b5133f) 等；<br />**示例：Nginx**

```
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## 修改 log 路径为正确的 nginx 路径
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## pipeline 即为 grok 语句，主要用来进行文本日志切割，datakit 已内置多种 pipeline，包括nginx、mysql 等，pipeline 默认目录为 /usr/local/datakit/pipeline/ ，此处无需修改 pipeline 路径，datakit 默认会自动读取。
```

![image](../images/java-rum-apm-log/15.png)

**视图展示：**

![image](../images/java-rum-apm-log/16.png)

![image](../images/java-rum-apm-log/17.png)

##### 2、自定义日志采集（应用日志、业务日志等）

示例：应用日志
pipeline（日志 grok 切割）[ **[**df 官方文档**](../../datakit/pipeline.md)**]**

```
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample logging.conf
$ vim logging.conf
## 修改 log 路径为正确的应用日志的路径
## source 与 service 为必填字段，可以直接用应用名称，用以区分不同的日志名称
$  [inputs.nginx.log]
$    logfiles = [
      "/usr/local/java/ruoyi/logs/ruoyi-system/error.log",
      "/usr/local/java/ruoyi/logs/ruoyi-system/info.log",]
$    source = "ruoyi-system"
$    service = "ruoyi-system"
$    pipeline = "ruoyi_system.p"
## pipeline 即为 grok 语句，主要用来进行文本日志切割，如果该配置不放开，默认 df 平台上展示日志原始文本内容，如若填写，会对对应日志进行 grok 切割，此处填写的 .p文件 需要自己手动编写
```

![image](../images/java-rum-apm-log/18.png)

```
$ /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

##示例：
#日志样式 
#2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - 查询用户

##示例 grok

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{NOTSPACE:status}\\s+%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NOTSPACE:line}\\] %{NOTSPACE:app_name} %{NOTSPACE:trace_id} %{NOTSPACE:span_id} - %{NOTSPACE:msg}")

default_time(time)
```

![image](../images/java-rum-apm-log/19.png)

##### 3、在 DF 平台查看日志数据

![image](../images/java-rum-apm-log/20.png)

![image](../images/java-rum-apm-log/21.png)

## RUM 跟 APM 联动数据演示：

**      原理介绍**：用户访问前端应用（已添加 rum 监控且已配置 **allowedDDTracingOrigins **字段），前端应用调用资源及请求，触发 rum-js 性能数据采集，rum-js 会生成 trace-id 写在请求的 request_header 里，请求到达后端，后端的 ddtrace 会读取到该 trace_id 并记录在自己的 trace 数据里，从而实现通过相同的 trace_id 来实现应用性能监测和用户访问监测数据联动分析。<br />     **应用场景**：前后端关联，前端请求与后端方法执行性能数据进行一对一绑定，从而更方便定位前后端关联的问题，例如前端用户登录缓慢，是因为后端服务调用数据库查询用户耗时过长导致的，就可通过前后端联动分析迅速跨团队跨部门进行问题定位，示例如下：<br />**     配置方式**：[ [java 示例](web.md#fpjkl)] 

##### 1、前端 RUM 数据

![image](../images/java-rum-apm-log/22.png)

##### 

![image](../images/java-rum-apm-log/23.png)

2、跳转至后端 APM 数据

![image](../images/java-rum-apm-log/24.png)

![image](../images/java-rum-apm-log/25.png)

## APM 跟 LOG 联动数据演示：

原理：APM 与 LOG

##### 1、开启 APM 监控

参考 [Kubernetes 应用的 RUM-APM-LOG 联动分析](./cloud-native/k8s-rum-apm-log.md) APM 部分，无需额外操作。

##### 2、修改应用日志输出格式（需开发介入）

修改应用日志输出格式文件 logback/log4j<br />**备注**：Ddtrace-agent  java-0.70 版本后会自动将跟踪标识注入，仅需修改 logback/log4j 的 xml 文件，在应用日志的输出内容中添加 trace_id 字段即可。<br />       可参考[ [datadog 官方文档](https://docs.datadoghq.com/logs/log_collection/java/?tab=logback)]

```
## 首先在 pom.xml 的 dependency 中引入 datadog 依赖

<dependency>
   <groupId>com.datadoghq</groupId> 
   <artifactId>dd-java-agent</artifactId> 
   <version>0.83.0</version> 
</dependency>

## 0.83.0 为对应 agent 版本号，请查看datakit/data 中的 agent 版本号
```

![image](../images/java-rum-apm-log/26.png)

```xml
<!-- 日志输出格式 -->

<property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />
```

保存该 xml 文件并重新发布应用。

##### 3、开启日志监控

参考 [JAVA应用-RUM-APM-LOG 联动分析](./apm/java-rum-apm-log.md) 自定义日志采集部分<br />举例：

```bash
$ cd /usr/local/datakit/conf.d/log/
$ cp log.conf.sample ruoyi-system.conf
$ vim ruoyi-system.conf

## 修改如下图内容
## logfiles 为应用日志绝对路径
## service 与 source 为必填字段，方便在 df 平台上进行查找
## Pipeline 可根据需求进行设置，pipeline 主要用作对日志进行字段切割，切割后的日志内容可转存成指标进行可视化展示，trace-id 相关内容没有可视化展示的必要，所以可以不用进行切割。
```

![image](../images/java-rum-apm-log/27.png)

##### 4、APM&LOG 联动分析

**正向关联[ APM——日志]**
在APM链路数据中，下方日志模块直接搜索 trace_id，即可查看此次链路调用所对应产生的应用日志。

![image](../images/java-rum-apm-log/28.png)

![image](../images/java-rum-apm-log/29.png)

**反向关联[日志——APM]**
查看异常日志，在日志中复制 trace_id，在链路追踪页面搜索框直接检索该 trace_id，即可搜出于该 id 相关的所有 trace 及 span 数据，点击查看即可。<br />![image](../images/java-rum-apm-log/30.png)

![image](../images/java-rum-apm-log/31.png)

![image](../images/java-rum-apm-log/32.png)
