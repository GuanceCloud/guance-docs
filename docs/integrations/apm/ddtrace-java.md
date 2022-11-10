# JAVA

---

## 视图预览

![image](../imgs/input-ddtrace-java-1.png)

![image](../imgs/input-ddtrace-java-2.png)

![image](../imgs/input-ddtrace-java-3.png)

![image](../imgs/input-ddtrace-java-4.png)

![image](../imgs/input-ddtrace-java-5.png)

## 安装部署 <ddtrace>

观测云 默认支持所有采用 OpenTracing 协议的 APM 监控手段，例如 **SkyWalking** 、 **Jaeger** 、 **Zipkin** 等。

此处官方推荐 **ddtrace** 接入方式。ddtrace 是开源的 APM 监控方式，相较于其他方式，支持更多的自定义字段，也就意味着可以有足够多的标签与其他的组件进行关联。ddtrace 具体接入方式详细如下：

### 前置条件

- 需要进行链路追踪的应用服务器<[安装 DataKit](../../datakit/datakit-install.md)>
- `dd-java-agent.jar` 已默认内置于 `/usr/local/datakit/data` 目录下
- <[ddtrace -java -agent 框架兼容列表](https://docs.datadoghq.com/tracing/setup_overview/compatibility_requirements/java/)>

### 配置实施

Java 所有部署方式都是在原有应用启动脚本中添加 `ddtrace.jar` 启动参数，具体添加字段如下：

```
java -javaagent:/xxx/ddtrace.jar -Ddd.env=xxx -Ddd.service.name=xxx -Ddd.agent.port=xxx    -jar xxx.jar
```

> **注意：**其中 `xxx` 内容都需要填写。

##### 开启 datakit.conf 中链路追踪 inputs

**（必须开启）**

```
###########--------linux环境---------##########

 cd /usr/local/datakit/conf.d/
 cd /ddtrace
 cp ddtrace.conf.sample ddtrace.conf


## 复制完文件后，vim进入编辑模式，放开imputs的注释
## 举例:ddtrace    tags相关注释可根据需要进行开启操作，添加业务或其他相关的标签

#默认无需修改
 vim ddtrace.conf

 wq!

## 重启 DataKit
 systemctl restart datakit
```

#### ddtrace 相关环境变量（启动参数）释义

**可根据需要进行添加**

- Ddd.env：自定义环境类型，可选项。
- Ddd.service.name：自定义应用名称 ，**必填项**。
- Ddd.agent.port：数据上传端口（默认 9529 ），**必填项**。
- Ddd.version：应用版本，可选项。
- Ddd.trace.sample.rate：设置采样率（默认是全采），可选项，如需采样，可设置 0~1 之间的数，例如 0.6，即采样 60%。
- Ddd.service.mapping：当前应用调用到的 redis、mysql 等，可通过此参数添加别名，用以和其他应用调用到的 redis、mysql 进行区分，可选项，应用场景：例如项目 A 项目 B 都调用了 mysql，且分别调用的 mysql-a，mysql-b，如没有添加 mapping 配置项，在观测云平台上会展现项目 A 项目 B 调用了同一个名为 mysql 的数据库，如果添加了 mapping 配置项，配置为 mysql-a，mysql-b，则在观测云平台上会展现项目 A 调用 mysql-a，项目 B 调用 mysql-b。
- Ddd.agent.host：数据传输目标 IP，默认为本机 localhost，可选项。

---

#### Tomcat 环境接入

在 `catlina.sh` 添加 ddtrace 启动参数后，重启 Tomcat。

> **注意：**代码段中的 `xxx` 需替换为绝对路径

```
 cd /xxx/tomcat/bin
 vim catlina.sh

 CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/datakit/data/dd-java-agent.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

## 验证是否添加成功，可以查 Ddd相关字眼的进程，要确保应用启动可以调用到该环境参数。

 wq!

## 重启tomcat
 ./startup.sh
```

是 Windows 环境，设置 setenv.bat ：

```
set CATALINA_OPTS=%CATALINA_OPTS% -javaagent:"c:\path\to\dd-java-agent.jar"
```

如果 setenv 文件不存在，建议在 Tomcat 的安装根目录 `./bin` 下创建它

#### 微服务环境接入

直接在启动脚本中添加 ddtrace 的启动参数，重启应用。

> **注意：**代码段中的 `xxx` 需替换为绝对路径

```
## 举例
## 原启动脚本：
 nohup java -jar mall-admin.jar &

## 添加ddtrace启动参数后的启动脚本如下，执行命令重启应用：
 nohup java -javaagent:/xxx/dd-java-agent.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar &
```

#### Docker 环境接入

Docker 环境下接入方式有多种，本示例会展示两种方式：

- 修改 dockerfile，重新打包镜像
- 不修改 dockerfile，用启动参数覆盖原有启动命令

1、修改 dockerfile，重新打包
> **注意：**代码段中的 `xxx` 需替换为绝对路径

```
 vim Dockerfile

##  Dockerfile中添加ddteace-agent路径,xxx字段均需要改写 IP要填写本机内网IP

 ADD dd-java-agent-0.75.0.jar /xxx/

 ENTRYPOINT ["java","-javaagent:/xxx/dd-java-agent-0.75.0.jar","-Ddd.service.name=xxx","-Ddd.version=xx","-Ddd.env=xxx","-Ddd.agent.port=9529","-Ddd.agent.host=xxx.xxx.xxx.xxx","-jar","xxx.jar"]

 wq!
```

![image](../imgs/input-ddtrace-java-6.png)

```
## build & run
 docker build -t xxx/xxx:v1 .  [ “.” 必须添加]

## docker run   举例
 docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1
```

2、不修改 dockerfile，用启动参数覆盖原有启动命令（某些场景下可能不适用）

举例如下：

```
## 原有启动命令
 docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1

## 包含ddtrace的启动命令，需要查看dockerfile中jar包的启动命令
 docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1 java -javaagent:/wx/dd-java-agent-0.75.0.jar -Ddd.service.name=mall-admin -Ddd.version=v1 -Ddd.env=product -Ddd.agent.port=9529 -Ddd.agent.host=172.16.0.198 -jar -Dspring.profiles.active=prod /mall-admin-1.0-SNAPSHOT.jar

## 注意：添加完java –javaagent后需要在启动脚本后添加-jar your app name.jar
```

#### 链路分析

<[服务](../../application-performance-monitoring/service.md)><br />
<[链路分析](../../application-performance-monitoring/explorer.md)>

## 场景视图

观测云平台已内置 应用性能监测模块，无需手动创建

## 检测库

暂无

## 相关术语说明

<[链路追踪-字段说明](../../../application-performance-monitoring/collection/)>

## 最佳实践

<[JVM 可观测](../../best-practices/monitoring/jvm.md)><br />
<[链路追踪（APM）最佳实践](../../best-practices/monitoring/apm.md)><br />
<[JAVA 应用 RUM-APM-LOG 联动分析](../../best-practices/insight/java-rum-apm-log.md)><br />
<[Kubernetes 应用的 RUM-APM-LOG 联动分析](../../best-practices/cloud-native/k8s-rum-apm-log.md)>

## 故障排查

暂无
