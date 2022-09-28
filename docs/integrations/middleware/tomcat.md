
# Tomcat
---

操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64

## 视图预览

Tomcat 性能指标展示：发送字节数、接收字节数、请求处理时间、请求数、请求错误数、线程数、缓存命中次数等

![image](../imgs/input-tomcat-1.png)

![image](../imgs/input-tomcat-2.png)

## 安装部署

说明：以 apache-tomcat-9.0.45 （centOS）为例，各个不同版本指标可能存在差异

### 前置条件

- Tomcat 所在服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- 用于实现 Tomcat 可观测性的数据采集文件 jolokia.war 已内置在/usr/local/datakit/data 文件夹下，需要在安装完毕 datakit 后，将 jolokia.war 复制一份到 tomcat 的 webapps 目录下。

### 配置实施

#### 新增权限用户（必选）

**（以下为配置示例，实操时， jolokia user 的 username 和 password 请务必修改！！！）**

```
# 以 apache-tomcat-9.0.45 为例

 cd apache-tomcat-9.0.45/

 vim conf/tomcat-users.xml

 37 <!--
 38   <role rolename="tomcat"/>
 39   <role rolename="role1"/>
 40   <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
 41   <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
 42   <user username="role1" password="<must-be-changed>" roles="role1"/>
 43 -->
 
 44   <role rolename="jolokia"/>
 45   <user username="jolokia_user" password="secPassWd@123" roles="jolokia"/>
  
 46 </tomcat-users>


 cd ../bin/
# 重启tomcat
 ./startup.sh 

 ...
 Tomcat started.
```

**本机访问**[**http://localhost:80/jolokia**](http://localhost:8080/jolokia)** （具体端口为tomcat实际开放端口）查看是否配置成功。**

linux 环境下成功示例如下：

![image](../imgs/input-tomcat-3.png)

#### 开启指标及日志采集

进入 DataKit 安装目录下的 `conf.d/tomcat` 目录，复制 `tomcat.conf.sample`  并命名为 `tomcat.conf`。示例如下：
（**以下为示例，实操时， 下边内容中的 的 username 、password、urls 请务必修改！！！**）

**指标（必选）**
[[inputs.tomcat]]指标参数说明

- username：上文中，在tomcat-users.xml中配置的用户名 
- password：上文中，在tomcat-users.xml中配置的密码
- url：上文中添加完jolokia监控war包，用来访问jolokia所采集数据的地址。

**日志（非必选）**
[inputs.tomcat.log]日志参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- pipeline：日志切割文件(tomcat日志切割文件已默认内置，无需修改)，实际文件路径 为：/usr/local/datakit/pipeline/tomcat.p
- 相关文档 <[DataFlux pipeline 文本数据处理](../../datakit/pipeline.md)>

```
 cd /usr/local/datakit/conf.d/tomcat
 cp tomcat.conf.sample tomcat.conf
 cim tomcat.conf

[[inputs.tomcat]]
  ### Tomcat user(rolename="jolokia"). For example:
  username = "jolokia_user"
  password = "secPassWd@123"

  # response_timeout = "5s"

  urls = ["http://localhost:80/jolokia"]

  ### Optional TLS config
  # tls_ca = "/var/private/ca.pem"
  # tls_cert = "/var/private/client.pem"
  # tls_key = "/var/private/client-key.pem"
  # insecure_skip_verify = false

  ### Monitor Interval
  # interval = "15s"

  [inputs.tomcat.log]
     files = ["/usr/tomcat/apache-tomcat-8.5.60/logs/catalina.2021-09-02.log"]
    ## grok pipeline script path
    # pipeline = "tomcat.p"

  [inputs.tomcat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...

  ### Tomcat metrics
  [[inputs.tomcat.metric]]
    name     = "tomcat_global_request_processor"
    mbean    = '''Catalina:name="*",type=GlobalRequestProcessor'''
    paths    = ["requestCount","bytesReceived","bytesSent","processingTime","errorCount"]
    tag_keys = ["name"]

  [[inputs.tomcat.metric]]
    name     = "tomcat_jsp_monitor"
    mbean    = "Catalina:J2EEApplication=*,J2EEServer=*,WebModule=*,name=jsp,type=JspMonitor"
    paths    = ["jspReloadCount","jspCount","jspUnloadCount"]
    tag_keys = ["J2EEApplication","J2EEServer","WebModule"]

  [[inputs.tomcat.metric]]
    name     = "tomcat_thread_pool"
    mbean    = "Catalina:name=\"*\",type=ThreadPool"
    paths    = ["maxThreads","currentThreadCount","currentThreadsBusy"]
    tag_keys = ["name"]

  [[inputs.tomcat.metric]]
    name     = "tomcat_servlet"
    mbean    = "Catalina:J2EEApplication=*,J2EEServer=*,WebModule=*,j2eeType=Servlet,name=*"
    paths    = ["processingTime","errorCount","requestCount"]
    tag_keys = ["name","J2EEApplication","J2EEServer","WebModule"]

  [[inputs.tomcat.metric]]
    name     = "tomcat_cache"
    mbean    = "Catalina:context=*,host=*,name=Cache,type=WebResourceRoot"
    paths    = ["hitCount","lookupCount"]
    tag_keys = ["context","host"]
    tag_prefix = "tomcat_"
```

重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

日志预览

![image](../imgs/input-tomcat-4.png)

#### tomcat 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 tomcat 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.tomcat.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Tomcat 监控视图>


## 指标详解

## 最佳实践
暂无

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>


