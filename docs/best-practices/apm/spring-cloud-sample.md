# 本项目业务系统简介：
**###本案例采用系统为模拟企业内部使用的办公系统，从 0 到 1 利用观测云构建系统的可观测性###**<br />**###本次构建可观测性选择的是单机 jar 包版应用   ###**<br />**###项目开源地址：**[https://gitee.com/y_project/RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud)**  ###**<br />**###项目演示地址：**[http://demo.ruoyi.vip/login](http://demo.ruoyi.vip/login)**  ###**

**系统介绍**：<br />该系统是一套开源的后台管理系统，同时也是一个 Java EE 企业级快速开发平台，基于诸多经典技术组合（Spring Boot、Apache Shiro、MyBatis、Thymeleaf， Bootstrap 等），内置模块诸多如：部门管理、角色用户、菜单及按钮授权、数据权限、系统参数、日志管理、通知公告等，主要目的让开发者注重专注业务，降低技术难度，从而节省人力成本，缩短项目周期，提高软件安全质量。该项目可以用于所有的Web应用程序，如网站管理后台，网站会员中心，CMS，CRM，OA等等，同时支持自定义深度定制，企业可以做出更强大的系统，所有前端后台代码封装过后十分精简易上手，出错概率低。同时已支持移动客户端访问。<br />**项目功能模块：**<br />•用户管理：用户是系统操作者，该功能主要完成系统用户配置。<br />•部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。<br />•岗位管理：配置系统用户所属担任职务。<br />•菜单管理：配置系统菜单，操作权限，按钮权限标识等。<br />•角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。<br />•字典管理：对系统中经常使用的一些较为固定的数据进行维护。<br />•参数管理：对系统动态配置常用参数。<br />•通知公告：系统通知公告信息发布维护。<br />•操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。<br />•登录日志：系统登录日志记录查询包含登录异常。<br />•在线用户：当前系统中活跃用户状态监控。<br />•定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。<br />•代码生成：前后端代码的生成（java、html、xml、sql) 支持 CRUD 下载 。<br />•系统接口：根据业务代码自动生成相关的api接口文档。<br />•服务监控：监视当前系统 CPU、内存、磁盘、堆栈等相关信息。<br />•缓存监控：对系统的缓存查询，查看、清理等操作。<br />•在线构建器：拖动表单元素生成相应的 HTML 代码。<br />**办公系统中涉及的技术栈：**

| 技术 | 版本 | 需开启观测云可观测性inputs |
| --- | --- | --- |
| SpringBoot | 2.3.7.RELEASE | ddtrace |
| SpringCloud | Hoxton.SR9 | ddtrace |
| SpringCloud Alibaba | 2.2.5.RELEASE | ddtrace |
| Nginx | 1.16.1 | nginx |
| Mysql | 5.7.17 | mysql |
| Redis | 3.2.12 | redis |
| Vue | 2.6.0 | rum |
| Java | OpenJDK 1.8.0_292 | Statsd或 jolokia<br />（本示例使用statsd） |

**办公系统架构：**<br />web 页面：放置在 Nginx 中<br />注册中心：Nacos<br />网关：Gateway<br />服务模块：Auth、System<br />数据库：Mysql<br />缓存：Redis<br />备注：此demo将所有服务模块都部署在同一台服务器上，利用不同端口进行服务的访问。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1626228008241-bba7908f-3ceb-4831-b6b8-9d2e90ec3eb1.png#clientId=u83bbafaf-327f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=286&id=u0895f511&margin=%5Bobject%20Object%5D&name=image.png&originHeight=572&originWidth=743&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27868&status=done&style=none&taskId=uf7dffe8f-e7a4-4468-906d-fc37050255c&title=&width=371.5)
# 观测云简介：
**简介：**[[观测云官方简介](https://www.yuque.com/dataflux/doc/kue3dg)]<br />观测云是一款旨在解决云计算，以及云原生时代系统为每一个完整的应用构建**全链路的可观测性**的云服务平台，与传统的监控系统有着本质的区别，传统的监控系统往往都是单一领域的监控系统，就好比企业内部建立的诸多烟囱，例如 APM、RUM、日志、NPM、zabbix 等都是单一且割裂的监控体系，有应用的、日志的、基础设施的等等，现象就是烟囱林立，而且监控系统的割裂也带来监控数据的割裂，也造成了企业内部的数据孤岛，往往在企业内部进行问题排查时，通常要跨部门，跨平台，耗费大量人力物力进行异常定位。而**可观测性**的概念是通过一套完整的体系对承载业务系统的IT体系进行可观测性，包含指标、日志、链路追踪三大组件，实现统一数据采集，统一存储，统一查询，统一展现，并且将指标、链路、日志所有的可观测数据关联起来，实现IT体系完整的可观测性。观测云就是基于这个理念研发出来的可观测性解决方案，致力于提升企业内部IT服务的质量，提升最终用户体验。<br />**观测云数据流向：**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625132955369-4636d546-6165-4d87-991a-edeafdb54bbe.png#crop=0&crop=0&crop=1&crop=1&height=641&id=u972c54ab&margin=%5Bobject%20Object%5D&name=image.png&originHeight=641&originWidth=1178&originalType=binary&ratio=1&rotation=0&showTitle=false&size=126670&status=done&style=none&title=&width=1178)<br />备注：DQL为dataflux专门开发的QL语言，用以关联查询es以及influxdb的数据。
# 安装 Datakit：
#### 1、登录 console.guance.com
#### 2、新建工作空间
#### 3、选择集成——datakit——选择适合自己环境额安装指令并复制
#### 4、在服务器上安装 datakit
#### 5、执行 service datakit status （或者 systemctl status datakit）查询 datakit 状态
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625037390898-a133e9ed-8946-4075-a4fb-aafc06734f20.png#crop=0&crop=0&crop=1&crop=1&height=644&id=u0807d364&margin=%5Bobject%20Object%5D&name=image.png&originHeight=644&originWidth=1080&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70855&status=done&style=none&title=&width=1080)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625037620752-9455781a-7254-4237-8b4a-c2211a95828a.png#crop=0&crop=0&crop=1&crop=1&height=119&id=uaf243721&margin=%5Bobject%20Object%5D&name=image.png&originHeight=119&originWidth=1761&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139666&status=done&style=none&title=&width=1761)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625037676251-6401b8ed-393a-475c-b384-77a77533366d.png#crop=0&crop=0&crop=1&crop=1&height=429&id=uc574356d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=429&originWidth=1630&originalType=binary&ratio=1&rotation=0&showTitle=false&size=96944&status=done&style=none&title=&width=1630)<br />**Datakit 安装好后，默认会对如下内容进行采集，可直接在 Dataflux——基础设施——主机查看相关数据**<br />**选择不同的集成 inputs 名称，就可以查看对应的监控视图，监控视图下方还可以查看其它数据，例如日志、进程、容器等信息。**

| 采集器名称 | 说明 |
| --- | --- |
| cpu | 采集主机的 CPU 使用情况 |
| disk | 采集磁盘占用情况 |
| diskio | 采集主机的磁盘 IO 情况 |
| mem | 采集主机的内存使用情况 |
| swap | 采集 Swap 内存使用情况 |
| system | 采集主机操作系统负载 |
| net | 采集主机网络流量情况 |
| host_process | 采集主机上常驻<br />（存活 10min 以上）进程列表 |
| hostobject | 采集主机基础信息<br />（如操作系统信息、硬件信息等） |
| docker | 采集主机上可能的容器对象以及容器日志 |


![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625039140395-1c806bf8-12e4-49cb-9379-a9e3642685fd.png#crop=0&crop=0&crop=1&crop=1&height=885&id=u16b225d7&margin=%5Bobject%20Object%5D&name=image.png&originHeight=885&originWidth=1504&originalType=binary&ratio=1&rotation=0&showTitle=false&size=86656&status=done&style=none&title=&width=1504)
# 开启具体的 inputs：
| 涉及组件 | 需开启inputs | inputs所在目录 | 相关指标 |
| --- | --- | --- | --- |
| Nginx | √ | •/usr/local/datakit/conf.d/nginx     | 请求信息，日志，请求耗时等 |
| Mysql | √ | •/usr/local/datakit/conf.d/db   | 连接数、QPS、读写情况、慢查询 |
| Redis | √ | •/usr/local/datakit/conf.d/db     | 连接数、CPU 消耗、内存消耗、命中率、丢失率 |
| JVM | √ | •/usr/local/datakit/conf.d/statsd | 堆内存、GC次 数、GC耗时 |
| APM | √ | •/usr/local/datakit/conf.d/ddtrace    | 响应时间、错误次数、错误率 |
| RUM | 默认已开启 | —— | uv/pv、LCP、FID、CLS、js错误 |

**备注：**

| RUM指标说明 | 说明 | 目标值 |
| --- | --- | --- |
| LCP(Largest Contentful Paint) | 计算网页可视范围内最大的内容元件需花多少时间载入 | 小于2.5s |
| FID(First Input Delay) | 计算用户首次与网页互动时的延迟时间 | 小于100ms |
| CLS(Cumulative Layout Shift) | 计算网页载入时的内容是否会因动态加载而页面移动，0表示没有变化。 | 小于0.1 |

## Nginx：
详细步骤参见文档 [[Nginx 可观测最佳实践](https://www.yuque.com/dataflux/bp/nginx)]<br />前提条件：需先查看 nginx 的 **http_stub_status_module **模块是否已打开，**如已安装该模块，请直接跳过第1步。**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627369681343-1d5192fe-eaee-4bc0-b265-d168d944670a.png#clientId=u8230afdf-43f9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=149&id=u7e1296ee&margin=%5Bobject%20Object%5D&name=image.png&originHeight=297&originWidth=1896&originalType=binary&ratio=1&rotation=0&showTitle=false&size=76914&status=done&style=none&taskId=u5e7f2778-c4d6-408d-b963-7237ca0e733&title=&width=948)
#### 1、安装 with-http_stub_status_module 模块（linux）：
开启该模块需要重新编译 nginx，具体命令如下：<br />**    ./configure --with-http_stub_status_module**<br />configure 文件位置的查询方式：**find /| grep configure |grep nginx**
```
$ find /| grep configure |grep nginx
  
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1622096942329-1800f6e0-1a36-48be-8b13-394afa732498.png#crop=0&crop=0&crop=1&crop=1&height=42&id=uc0cf75d6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=42&originWidth=620&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5875&status=done&style=none&title=&width=620)
#### 2、在 Nginx.conf 中增添 nginx_status 的 location 转发
```
$ cd /etc/nginx   
   ## nginx 路径根据实际情况而定
$ vim nginx.conf

$  server{
     listen 80;   
     server_name localhost;
     ##端口可自定义
     
      location /nginx_status {
          stub_status  on;
          allow 127.0.0.1;
          deny all;
                             }
                             
          }
```
#### 3、在 Datakit 中修改 nginx 的 inputs
```
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim  nginx.conf

#修改如下内容
[[inputs.nginx]]
        url = http://localhost/nginx_status
[inputs.nginx.log]
        files = ["/var/log/nginx/access.log","/var/log/nginx /error.log"]

#保存文件后重启 datakit    
$ service datakit restart
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625042308240-4848614a-ef99-4278-97fb-f7f20839d41e.png#crop=0&crop=0&crop=1&crop=1&height=267&id=ub047962f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=267&originWidth=524&originalType=binary&ratio=1&rotation=0&showTitle=false&size=62684&status=done&style=none&title=&width=524)<br />**验证数据：curl 127.0.0.1/nginx_status**<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1624427768730-2a256fb1-567c-496b-81e1-b16dfacabf92.png#crop=0&crop=0&crop=1&crop=1&height=152&id=ODVmS&margin=%5Bobject%20Object%5D&originHeight=152&originWidth=921&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=921)
#### 4、在观测云平台创建 Nginx 视图并查看数据
**创建步骤参考[**[**创建场景及视图**](#IVN7h)**]**<br />**步骤：场景——新建场景——新建空白场景——系统视图（创建 NGINX）**<br />**视图示例（通过该视图即可快速查看 Nginx 相关的指标及日志信息，从而断定 Nginx 的健康状态）:**<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1624429445212-e7080803-6f1b-4f26-bf0f-359ab2ad525f.png#crop=0&crop=0&crop=1&crop=1&height=695&id=bnVxw&margin=%5Bobject%20Object%5D&originHeight=695&originWidth=1731&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1731)<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1624429481780-a6396a7b-0597-4740-9913-683f42ba1e1b.png#crop=0&crop=0&crop=1&crop=1&height=660&id=z5D5z&margin=%5Bobject%20Object%5D&originHeight=660&originWidth=1730&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1730)
## Mysql：
详细步骤参见文档 [[Mysql datakit 接入](https://www.yuque.com/dataflux/datakit/mysql)]

```xml
# 登录 mysql 
$ mysql -uroot -p  
# 输入密码：Solution****

# 创建监控账号
$ CREATE USER 'datakit'@'localhost' IDENTIFIED BY 'Datakit_1234';

# 授权监控账号
$ grant process,select,replication client on *.* to 'datakit'@'%' identified by 'Datakit_1234';

# 刷新授权
flush privileges;
```
#### 1、在 Datakit 中修改 mysql 的 inputs
```
$ cd /usr/local/datakit/conf.d/db/
$ cp mysql.conf.sample mysql.conf
$ vim mysql.conf

# 修改如下内容 
## 建议自定义创建一个 mysql 的只读账号
[[inputs.mysql]]
     user ="datakit"
     pass ="Datakit_1234“

#保存文件后重启 datakit    
$ service datakit restart
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625124183195-9de42770-afd0-4631-86ac-fe8a2862e3b8.png#crop=0&crop=0&crop=1&crop=1&height=185&id=u532a9921&margin=%5Bobject%20Object%5D&name=image.png&originHeight=185&originWidth=576&originalType=binary&ratio=1&rotation=0&showTitle=false&size=13123&status=done&style=none&title=&width=576)
#### 2、在观测云平台创建 Mysql 视图并查看数据
**创建步骤参考[**[**创建场景及视图**](#IVN7h)**]**<br />**步骤：场景——新建场景——新建空白场景——系统视图（创建 Mysql）**<br />**视图示例（通过该视图即可快速查看 Mysql 相关的指标及日志信息，从而断定 Mysql 的健康状态）:**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625119613219-1ce05754-c509-44a4-afa2-2a5bdcb86f18.png#crop=0&crop=0&crop=1&crop=1&height=1014&id=sNdd5&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1014&originWidth=1702&originalType=binary&ratio=1&rotation=0&showTitle=false&size=150589&status=done&style=none&title=&width=1702)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625119667673-6b3b12c3-6686-4fbe-a5e4-e3a8f5ca8bf9.png#crop=0&crop=0&crop=1&crop=1&height=856&id=u2c1c807d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=856&originWidth=1710&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68372&status=done&style=none&title=&width=1710)
## Redis：
详细步骤参见文档 [[redis datakit 接入](https://www.yuque.com/dataflux/datakit/redis)]
#### 1、在 Datakit 中修改 redis 的 inputs
```
$ cd /usr/local/datakit/conf.d/db/
$ cp redis.conf.sample redis.conf
$ vim redis.conf



#修改如下内容
## 建议自定义创建一个 redis 的只读账号
[[inputs.redis]]
     pass ="Solution******“
#注意放开 pass 之前的注释符号 #
[inputs.redis.log]
    files = ["/var/log/redis/redis.log"]

#保存文件后重启 datakit    
$ service datakit restart
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625124211233-61d6c20f-a18a-410e-9fb2-f9d069b37c89.png#crop=0&crop=0&crop=1&crop=1&height=291&id=u22524113&margin=%5Bobject%20Object%5D&name=image.png&originHeight=291&originWidth=523&originalType=binary&ratio=1&rotation=0&showTitle=false&size=42785&status=done&style=none&title=&width=523)
#### 2、在观测云平台创建 Redis 视图并查看数据
**创建步骤参考[**[**创建场景及视图**](#IVN7h)**]**<br />**步骤：场景——新建场景——新建空白场景——系统视图（创建 Redis）**<br />**视图示例（通过该视图即可快速查看 Redis 相关的指标及日志信息，从而断定 Redis 的健康状态）:**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625119710572-12f92b88-be66-4a4d-9cca-3eeb1d09b75f.png#crop=0&crop=0&crop=1&crop=1&height=925&id=ufbc48026&margin=%5Bobject%20Object%5D&name=image.png&originHeight=925&originWidth=1701&originalType=binary&ratio=1&rotation=0&showTitle=false&size=143051&status=done&style=none&title=&width=1701)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625119731376-02a20ff3-935e-4966-8494-de907ebd92ff.png#crop=0&crop=0&crop=1&crop=1&height=235&id=uf299a5ef&margin=%5Bobject%20Object%5D&name=image.png&originHeight=235&originWidth=1699&originalType=binary&ratio=1&rotation=0&showTitle=false&size=34909&status=done&style=none&title=&width=1699)
## JVM：
详细步骤参见文档 [[jvm datakit 接入](https://www.yuque.com/dataflux/datakit/jvm)]
#### 1、在 Datakit 中修改 jvm 的 inputs
  **默认不需要修改 jvm 的 inputs，仅需复制生成 conf 文件即可**
```
$ cd /usr/local/datakit/conf.d/statsd/
$ cp statsd.conf.sample ddtrace-jvm-statsd.conf 
$ vim ddtrace-jvm-statsd.conf

# 默认不需要修改
```
#### 2、修改 jav a应用启动脚本
    ** ### 因 JVM 跟 APM 都是借由 ddtrace-agent 实现数据采集，应用启动脚本参见 APM 相关内容 [**[**APM**](https://www.yuque.com/dataflux/bp/sample1/edit#X4X7T)**] ###**
#### 3、在观测云平台创建 JVM 视图并查看数据
**创建步骤参考[**[**创建场景及视图**](#IVN7h)**]**<br />**步骤：场景——新建场景——新建空白场景——系统视图（创建 JVM）**<br />**视图示例（通过该视图即可快速查看 JVM 相关的指标及日志信息，从而断定 JVM 的健康状态）:**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625119804961-28e21b23-7323-4308-94ac-d06ec9d5e6de.png#crop=0&crop=0&crop=1&crop=1&height=596&id=u8f96ab5a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=596&originWidth=1701&originalType=binary&ratio=1&rotation=0&showTitle=false&size=109720&status=done&style=none&title=&width=1701)
## APM（application performance monitoring）：
详细步骤参见文档[[链路追踪（APM）可观测性最佳实践](https://www.yuque.com/dataflux/bp/apm)]<br />**观测云支持的 APM 接入方式包含 ddtrace、skywalking、zipkin、jaejer 等多种支持 opentracing 协议的 APM工具，此处示例采用 ddtrace 实现 APM 方面的可观测性。**
#### 1、在 Datakit 中修改 APM（ddtrace）的 inputs
  **默认不需要修改 jvm 的 inputs，仅需复制生成 conf 文件即可**
```
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# 默认不需要修改
```
#### 2、修改 java 应用启动脚本
   APM 可观测性，需要在 java 应用中添加一个 agent，该 agent 在伴随应用启动时，会通过字节码注入的技术实现对应用内部方法层层调用、sql 调用、外部系统调用等相关性能数据的采集，从而实现对应用系统代码质量的可观测性。
```xml
#原应用启动脚本
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &
```
需 kill 掉原有应用启动进程，添加 ddtrace 参数后，重启应用，具体查杀方法见下图：<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627372730573-2304fe86-0fdd-45e2-90ca-5782c03ba78e.png#clientId=ud929a3f6-164d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=179&id=ua97a0914&margin=%5Bobject%20Object%5D&name=image.png&originHeight=273&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&size=62434&status=done&style=none&taskId=u62d408f7-ee40-46b0-8d40-a265a6f840e&title=&width=751.5)
```
#添加 ddtrace-agent 后的应用启动脚本

$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000  -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar  -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log  2>&1 & 
```
**！若果在观测云平台未看到 APM 相关数据，请查看 datakit 日志**<br />**cat /var/log/datakit/gin.log**<br />正常日志：<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627373315436-0518c79a-6ed9-43ff-8a3d-90bca5f934e3.png#clientId=ud929a3f6-164d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=178&id=u5a00ba4a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=215&originWidth=898&originalType=binary&ratio=1&rotation=0&showTitle=false&size=44155&status=done&style=none&taskId=u1acd97a5-91fa-4901-ae7d-c3d06153ed7&title=&width=742)<br />错误日志：<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627373199331-75555413-d710-44b4-8ad9-b5e43e507458.png#clientId=ud929a3f6-164d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=199&id=u388aeef9&margin=%5Bobject%20Object%5D&name=image.png&originHeight=229&originWidth=893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46813&status=done&style=none&taskId=ubca2cad7-7b5e-4f71-9f09-f9ef73eca38&title=&width=776.5)<br />**此种错误需修改** /usr/local/datakit/con.d/ddtrace/ddtrace.conf 修改成如下图片<br />**需保证 ddtrace.conf 配置中的 path 路径与 datakit/gin.log 日志中的路径保持一致**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627373284958-d199da4d-a5e9-4cfb-8203-77e8da2d0f54.png#clientId=ud929a3f6-164d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=145&id=u8f480f97&margin=%5Bobject%20Object%5D&name=image.png&originHeight=172&originWidth=889&originalType=binary&ratio=1&rotation=0&showTitle=false&size=19108&status=done&style=none&taskId=u28be4352-3699-473a-befc-d566ee8582e&title=&width=748.5)

**ddtrace 相关环境变量（启动参数）释义：**

- Ddd.env：自定义环境类型，可选项。
- Ddd.tags：自定义应用标签 ，可选项。
- Ddd.service.name：自定义应用名称 ，必填项。
- Ddd.agent.port：数据上传端口（默认9529 ），必填项。
- Ddd.version:应用版本，可选项。
- Ddd.trace.sample.rate：设置采样率（默认是全采），可选项，如需采样，可设置 0~1 之间的数，例如 0.6，即采样 60%。
- Ddd.service.mapping：当前应用调用到的 redis、mysql 等，可通过此参数添加别名，用以和其他应用调用到的 redis、mysql 进行区分，可选项，应用场景：例如项目 A 项目 B 都调用了 mysql，且分别调用的 mysql-a，mysql-b，如没有添加 mapping 配置项，在观测云平台上会展现项目 A 项目 B 调用了同一个名为 mysql 的数据库，如果添加了 mapping 配置项，配置为 mysql-a，mysql-b，则在观测云平台上会展现项目A调用 mysql-a，项目 B 调用 mysql-b。
- Ddd.agent.host：数据传输目标 IP，默认为本机 localhost，可选项。
- <br />
#### 3、在观测云平台查看 APM 数据
**APM（应用性能检测）是观测云默认内置的模块，无需创建场景或视图即可进行查看。**<br />**路径：观测云平台——应用性能检测**<br />**视图示例:（通过该视图即可快速查看应用调用情况、拓扑图、异常数据等其他 APM 相关数据）**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625119944045-f2a24cc7-bb28-4918-b25d-5314ed3b2b75.png#crop=0&crop=0&crop=1&crop=1&height=669&id=u09d0fbf6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=669&originWidth=1885&originalType=binary&ratio=1&rotation=0&showTitle=false&size=73201&status=done&style=none&title=&width=1885)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625120015288-4c575fdb-a4e4-4efc-937c-79f1c207d655.png#crop=0&crop=0&crop=1&crop=1&height=1059&id=uda5081d6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1059&originWidth=1898&originalType=binary&ratio=1&rotation=0&showTitle=false&size=149755&status=done&style=none&title=&width=1898)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625120066417-a04b6f66-24d0-4139-95fb-7e9b710d7316.png#crop=0&crop=0&crop=1&crop=1&height=1055&id=u3b93fb8b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1055&originWidth=1893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=304198&status=done&style=none&title=&width=1893)

## RUM（real user moitoring）：
详细步骤参见文档[[用户访问（RUM）可观测性最佳实践](https://www.yuque.com/dataflux/doc/eqs7v2)]
#### 1、登录 Dataflux 平台
#### 2、选择用户访问监测——新建应用——选择 web 类型——同步载入
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625107795680-25ffcbc3-beb8-4c5b-b996-4e8ecdc1286a.png#crop=0&crop=0&crop=1&crop=1&height=933&id=u67374a66&margin=%5Bobject%20Object%5D&name=image.png&originHeight=933&originWidth=1432&originalType=binary&ratio=1&rotation=0&showTitle=false&size=114789&status=done&style=none&title=&width=1432)
#### 3、在前端页面 index.html 中接入观测云 rum 可观测性 js 文件

```
$ cd /usr/local/ruoyi/dist/

// 记得备份
$ cp index.html index.html.bkd

// 在 index.html 中添加 df-js
// 复制 DF 平台上的 js 内容，放至 index.html 内的 </head> 之前，然后保存文件,示例如下

$ vim index.html

<script src="https://static.dataflux.cn/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'xxxxxxxxxxxxxxxxxxxxxxxxxx',
      datakitOrigin: 'xxx.xxx.xxx.xxx:9529',
      env: 'test',
      version: '1.0.0',
      trackInteractions: true,
      allowedDDTracingOrigins:["xxx.xxx.xxx.xxx"]
      })
</script></head> 

# xxx 均需要根据实际情况进行更改，详细更改内容请参考如下：
```
> **datakitOrigin**：datakit 地址（datakit 所在服务器的 ip 或域名），观测云中 rum 数据流向为：rum.js 文件——>datakit——>dataway——>观测云平台，如若是生产环境，需将该 IP 设置为域名或 slb 地址，测试环境需填写内网IP，对应 datakit 的服务器 9529 端口
>    
> **trackInteractions**：用户行为采集配置项，可实现页面端用户操作行为统计
> 
> **allowedDDTracingOrigins**：前后端（rum 与 apm）打通的配置项，可按需进行设置，需在此处填写与前端页面有交互关系的后端服务器所对应的域名或IP。


**注意事项：**

- **datakitOrigin**：数据传输地址，生产环境如若配置的是域名，可将域名请求转发至具体任意一台安装有datakit-9529 端口的服务器，如若前端访问量过大，可在域名与 datakit 所在服务器中间加一层 slb，前端 js 将数据发送 至slb，slb 也需要开放 **9529 **端口，slb 将请求转发至多台安装 datakit-**9529 **所在的服务器。多台datakit 承接 rum 数据，因前端请求复用因素，session 数据不会中断，对 rum 数据展现也无影响。

       举例：<br />       ![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1626146045116-7cda7c9f-8769-4eaa-b927-0f3dce255203.png#crop=0&crop=0&crop=1&crop=1&height=435&id=uf54376ea&margin=%5Bobject%20Object%5D&name=image.png&originHeight=869&originWidth=1355&originalType=binary&ratio=1&rotation=0&showTitle=false&size=151051&status=done&style=none&title=&width=677.5)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1626146120043-f6cfba4f-4b3a-403a-9fb1-8fd30e8243ae.png#crop=0&crop=0&crop=1&crop=1&height=412&id=u966506c2&margin=%5Bobject%20Object%5D&name=image.png&originHeight=824&originWidth=1669&originalType=binary&ratio=1&rotation=0&showTitle=false&size=122876&status=done&style=none&title=&width=834.5)

- **allowedDDTracingOrigins**：实现前后端（APM 与 RUM）打通，该场景只有在前端部署 RUM，后端部署APM 的情况才会生效，需在此处填写与前端页面有交互关系的后端应用服务器所对应的域名（生产环境）或 IP（测试环境）。**应用场景**：前端用户访问出现慢，是由后端代码逻辑异常导致，可通过前端 RUM 慢请求数据直接跳转至 APM 数据查看当次后端代码调用情况，判定慢的根因。**实现原理**：用户访问前端应用，前端应用进行资源及请求调用，触发 rum-js 性能数据采集，rum-js 会生成 trace-id 写在请求的 request_header 里，请求到达后端，后端的 ddtrace 会读取到该 trace_id 并记录在自己的 trace 数据里，从而实现通过相同的 trace_id 来实现应用性能监测和用户访问监测数据联动
- **env**：必填，应用所属环境，是 test 或 product 或其他字段。
- **version**：必填，应用所属版本号。
- **trackInteractions**：用户行为统计，例如点击按钮，提交信息等动作。

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627897603601-e62e4faa-2394-4805-ae27-789f7f336a47.png#clientId=uc4e71ed3-e57a-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=483&id=u173768dd&margin=%5Bobject%20Object%5D&name=image.png&originHeight=483&originWidth=1323&originalType=binary&ratio=1&rotation=0&showTitle=false&size=92092&status=done&style=none&taskId=ufb1b410b-a84b-42c7-b343-9b80e6b8793&title=&width=1323)
#### 4、保存、验证并发布页面
打开浏览器访问目标页面，通过f12检查者模式查看页面网络请求中是否有 rum 相关的请求，状态码是否是 200。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625626818799-896bf940-b442-45ec-b7bc-5e90c1ada474.png#crop=0&crop=0&crop=1&crop=1&height=418&id=u3f7a80b6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=835&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&size=144435&status=done&style=none&title=&width=954)<br />**注意！！**：如若f12检查者模式发现数据无法上报，显示端口 refused，可 telnet IP:9529 验证端口是否通畅，不通的话，需要修改 /usr/local/datakit/conf.d/datakit.conf 修改 http_listen 的 localhost 为 0.0.0.0。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1628134816151-a21ab7a7-09be-4a45-bb68-ed908e58f586.png#clientId=uf20b83e3-7260-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=391&id=uf0104d0c&margin=%5Bobject%20Object%5D&name=image.png&originHeight=513&originWidth=879&originalType=binary&ratio=1&rotation=0&showTitle=false&size=32826&status=done&style=none&taskId=u43c28055-8ab5-4a79-b206-810276af42d&title=&width=669.5)
#### 5、在用户访问监测查看 rum 相关数据
![](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622722383564-d8061ec2-786c-478a-84ff-e50f8871d226.png#crop=0&crop=0&crop=1&crop=1&height=1677&id=TZdtk&margin=%5Bobject%20Object%5D&originHeight=1677&originWidth=1204&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1204)
#### 6、RUM 跟 APM 打通数据演示
     配置方式：[[java示例](https://www.yuque.com/dataflux/bp/web#fpjkl)] [[python示例](https://www.yuque.com/dataflux/doc/vg4y50)]<br />     应用场景：前后端关联，前端请求与后端方法执行性能数据进行一对一绑定，从而更方便定位前后端关联的问题，例如前端用户访问缓慢，是因为后端服务调用异常导致的，可以迅速跨团队跨部门进行问题定位，示例如下：<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1623821965875-ebce8bc3-4e74-4ea5-8c80-a59b0a57f629.png#crop=0&crop=0&crop=1&crop=1&height=500&id=Ub7wG&margin=%5Bobject%20Object%5D&originHeight=500&originWidth=1901&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1901)<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1623822001114-957e89ed-4e9e-4b22-a849-f604f3808f83.png#crop=0&crop=0&crop=1&crop=1&height=580&id=XfwTG&margin=%5Bobject%20Object%5D&originHeight=580&originWidth=1902&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1902)<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1623822019472-29c40469-7927-4925-af34-c7651a17f71b.png#crop=0&crop=0&crop=1&crop=1&height=529&id=Lfq8I&margin=%5Bobject%20Object%5D&originHeight=529&originWidth=1912&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1912)<br />![](https://cdn.nlark.com/yuque/0/2021/png/21516613/1623822047767-86d72d7f-8d81-43e6-a4d0-c19e22a8a350.png#crop=0&crop=0&crop=1&crop=1&height=902&id=Kvjzy&margin=%5Bobject%20Object%5D&originHeight=902&originWidth=1915&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=&width=1915)
## Security Checker（安全巡检）：
**Security Checker简介：[**[**观测云官方简介**](https://www.yuque.com/dataflux/sec_checker/readme)**]     **<br />**注意：目前仅支持 linux**<br />详细步骤参见文档 [[Security Checker 安装和配置](https://www.yuque.com/dataflux/sec_checker/install)]
#### 1、安装 Security Checker
```shell
##  安装
$ bash -c "$(curl https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/security-checker/install.sh)"
## 或者执行   sudo datakit --install scheck
 
## 更新
$ bash -c "$(curl https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/security-checker/install.sh) --upgrade"

## 启停命令
$ systemctl start/stop/restart/status scheck

## 或者
$ service scheck start/stop/restart/status

## 安装目录  /usr/local/scheck
```
#### 2、Security Checker 连接 Datakit
     将 Security Checker 数据打至 datakit，然后再转发至 dataflux 平台。
```
$ cd /usr/local/scheck/
$ vim scheck.conf
 
 
    # ##(required) directory contains script
    rule_dir='/usr/local/scheck/rules.d'

    # ##(required) output of the check result, support local file or remote http server
    # ##localfile: file:///your/file/path
    # ##remote:  http(s)://your.url
    output='http://127.0.0.1:9529/v1/write/security'


    # ##(optional)global cron, default is every 10 seconds
    #cron='*/10 * * * *'

    log='/usr/local/scheck/log'
    log_level='info'
    #disable_log=false

```
#### 3、查看 Security Checker 相关数据
#### ![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625127045732-0ea8e260-a6f2-4db3-a0d7-2bdccf37b8c0.png#crop=0&crop=0&crop=1&crop=1&height=926&id=u5def6f5a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=926&originWidth=1867&originalType=binary&ratio=1&rotation=0&showTitle=false&size=251763&status=done&style=none&title=&width=1867)
## 日志：
详细步骤参见文档 [[日志采集](https://www.yuque.com/dataflux/doc/ilhawc)]
#### 1、标准日志采集（Nginx、Mysql、Redis 等）
  **    **通过开启 Datakit 内置的各种 inputs，直接开启相关的日志采集，例如 [Ngnix](https://www.yuque.com/dataflux/datakit/nginx#62b5133f)、[Redis](https://www.yuque.com/dataflux/datakit/redis#62b5133f)、[Docker](https://www.yuque.com/dataflux/datakit/docker)、[ES](https://www.yuque.com/dataflux/datakit/elasticsearch#62b5133f) 等；<br />**示例：Nginx**
```
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## 修改 log 路径为正确的 nginx 路径
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## pipeline 即为 grok 语句，主要用来进行文本日志切割，datakit 已内置多种 pipeline，包括nginx、mysql 等，pipelin e默认目录为 /usr/local/datakit/pipeline/ ，此处无需修改 pipeline 路径，datakit 默认会自动读取。

```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625129448467-00a6c922-b147-4b41-bccb-f3c523662974.png#crop=0&crop=0&crop=1&crop=1&height=438&id=u6c4882a1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=438&originWidth=914&originalType=binary&ratio=1&rotation=0&showTitle=false&size=36195&status=done&style=none&title=&width=914)<br />**视图展示：**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625129908640-1c4fbebf-8e1c-4af4-bc1d-b6f1121ca9c6.png#crop=0&crop=0&crop=1&crop=1&height=867&id=u733ac703&margin=%5Bobject%20Object%5D&name=image.png&originHeight=867&originWidth=1880&originalType=binary&ratio=1&rotation=0&showTitle=false&size=196451&status=done&style=none&title=&width=1880)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625129944474-142bc3d2-a210-4ac6-9e04-471b30bb3069.png#crop=0&crop=0&crop=1&crop=1&height=832&id=ub40f5358&margin=%5Bobject%20Object%5D&name=image.png&originHeight=832&originWidth=1857&originalType=binary&ratio=1&rotation=0&showTitle=false&size=121928&status=done&style=none&title=&width=1857)
#### 2、自定义日志采集（应用日志、业务日志等）
**      示例：应用日志**<br />**      pipeline（日志grok切割）[**[**观测云官方文档**](https://www.yuque.com/dataflux/datakit/pipeline)**]**
```
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample logging.conf
$ vim logging.conf

## 修改 log 路径为正确的应用日志的路径
## source 与 service 为必填字段，可以直接用应用名称，用以区分不同的日志名称

$  [inputs.nginx.log]
$    logfiles = [
      "/usr/local/ruoyi/logs/ruoyi-system/error.log",
      "/usr/local/ruoyi/logs/ruoyi-system/info.log",]
$    source = "ruoyi-system"
$    service = "ruoyi-system"
#    pipeline = "ruoyi-system.p"


## pipeline 即为 grok 语句，主要用来进行文本日志切割，如果该配置不放开，默认 df 平台上展示日志原始文本内容，如若填写，会对对应日志进行 grok 切割，此处填写的 .p 文件 需要自己手动编写
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627375914742-ff1ad3fd-77ca-4dc0-9938-fb6be7227df2.png#clientId=ud929a3f6-164d-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=477&id=u404657a2&margin=%5Bobject%20Object%5D&name=image.png&originHeight=593&originWidth=865&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47587&status=done&style=none&taskId=uf21d30f4-6760-4c55-ae15-0a137b2073d&title=&width=696.5)
```
$ cd /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

##示例：
#日志样式 
#2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - 查询用户

##示例 grok，复制如下内容至 ruoyi_system.p 中

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:level} \\s+%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time)
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625132690231-85d876be-94bd-4cdd-8eb0-b87415f29cd4.png#crop=0&crop=0&crop=1&crop=1&height=379&id=u998f347f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=379&originWidth=1893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37130&status=done&style=none&title=&width=1893)<br />**视图展示：**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625132743808-a40f41ad-3f74-4645-93a7-3b649e4c1a28.png#crop=0&crop=0&crop=1&crop=1&height=551&id=ubcc99c17&margin=%5Bobject%20Object%5D&name=image.png&originHeight=551&originWidth=1875&originalType=binary&ratio=1&rotation=0&showTitle=false&size=87031&status=done&style=none&title=&width=1875)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625132755085-34704298-5ead-4774-8b24-6a82b1246048.png#crop=0&crop=0&crop=1&crop=1&height=708&id=u45f8551f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=708&originWidth=1503&originalType=binary&ratio=1&rotation=0&showTitle=false&size=80381&status=done&style=none&title=&width=1503)
## 创建 Nginx 日志异常检测：
#### 1、打开观测云平台—>异常检测库—>新建检测库—>自定义监控
#### ![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461215709-a9de9852-955d-4901-89cf-0837092941da.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=337&id=ucf67cd8e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=674&originWidth=1879&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64321&status=done&style=none&taskId=u60d17359-c9f6-4573-8377-f81641f5fe6&title=&width=939.5)
#### 2、点击新创建的检测库名称—>新建检测规则—>新建日志检测
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461232167-f7e98013-caa8-40b2-b678-3765dea7a6b1.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=412&id=u616925b9&margin=%5Bobject%20Object%5D&name=image.png&originHeight=824&originWidth=1887&originalType=binary&ratio=1&rotation=0&showTitle=false&size=86242&status=done&style=none&taskId=ue75f00fe-9804-4650-a9b5-a37d02afc61&title=&width=943.5)

#### 3、填写具体检测规则内容并保存

**规则名称**：Nginx 日志 ERROR 次数过多异常检测<br />**检测指标**：见图示<br />**触发条件**：Result>=5<br />**事件名称**：Nginx 日志 ERROR 次数过多异常告警<br />**事件内容**：<br />>等级：{{status}}  <br />>主机：{{host}}  <br />>内容：日志ERROR次数过多，错误数为 {{ Result }}<br />>建议：日志ERROR次数过多，应用可能存在异常，建议对应用健康度进行检查。<br />**检测频率**：1分钟<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461257067-3492f690-acfb-4869-bf91-0fffc67b5276.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=456&id=ua79dbd07&margin=%5Bobject%20Object%5D&name=image.png&originHeight=911&originWidth=1774&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94586&status=done&style=none&taskId=u03bb50e8-5bad-4522-8a4d-c93cf9f22e1&title=&width=887)
## 验证异常检测机制：
#### 1、服务器上查询 ruoyi-gateway 相关进程并kill掉
```xml
$ ps -ef|grep ruoyi-gateway
$ kill -9 xxxxx
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461486203-910ff385-07c4-471f-98a2-915cee107017.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=80&id=uf214c2c6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=159&originWidth=1895&originalType=binary&ratio=1&rotation=0&showTitle=false&size=95018&status=done&style=none&taskId=ufd960a01-dca8-4d5e-bc43-1b33f2ad0f2&title=&width=947.5)
#### 2、访问 ruoyi 网站（可以多刷新几次，至少5次以上）
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461521100-dde2694e-3d68-40c2-ad88-7484cd444f2e.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=303&id=u5d45f9ba&margin=%5Bobject%20Object%5D&name=image.png&originHeight=606&originWidth=1341&originalType=binary&ratio=1&rotation=0&showTitle=false&size=1572633&status=done&style=none&taskId=u0be000c6-692e-4068-9acc-9d78a541e72&title=&width=670.5)
#### 3、查看观测云平台事件相关内容
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461534602-f32514d3-4c62-4caa-a4dd-cdee1034fa5d.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=236&id=ua321ea5b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=472&originWidth=1600&originalType=binary&ratio=1&rotation=0&showTitle=false&size=91047&status=done&style=none&taskId=ue31d1e52-9fd1-4d88-8bdf-3cfdd5b7278&title=&width=800)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461561445-8794cbea-b875-4b1e-821b-bea6a4737c00.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=378&id=u388bbc59&margin=%5Bobject%20Object%5D&name=image.png&originHeight=755&originWidth=1615&originalType=binary&ratio=1&rotation=0&showTitle=false&size=104069&status=done&style=none&taskId=u941e9566-60e0-4098-93b3-19951354c3d&title=&width=807.5)

#### 4、查看 nginx 日志相关内容及相关视图
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461582454-3fe7ceea-5047-4b8e-918b-2e75210dd88b.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=295&id=u8ebd99bf&margin=%5Bobject%20Object%5D&name=image.png&originHeight=590&originWidth=1589&originalType=binary&ratio=1&rotation=0&showTitle=false&size=228043&status=done&style=none&taskId=ubf94665c-b220-40df-b63d-4b79c2661a7&title=&width=794.5)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1627461599332-2e0e0900-b2d3-4309-ba2c-c333ae850195.png#clientId=ubd40606d-53bb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=311&id=u35d773a1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=622&originWidth=1599&originalType=binary&ratio=1&rotation=0&showTitle=false&size=279544&status=done&style=none&taskId=u2b403844-6365-4150-bd30-df72502474e&title=&width=799.5)

## 开启 inputs 过程中问题排查方式：
#### 1、查看 inputs 报错信息
     观测云已默认将inputs的状态信息以一定的频率上传至观测云平台，可以直接在基础设施——具体主机内查看集成情况<br />     **示例：apache 服务宕机，inputs 显示报错**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625121031150-9cd93f0b-d807-48c1-95fa-3bf3b9ffc883.png#crop=0&crop=0&crop=1&crop=1&height=765&id=ud7fe1db2&margin=%5Bobject%20Object%5D&name=image.png&originHeight=765&originWidth=1893&originalType=binary&ratio=1&rotation=0&showTitle=false&size=132282&status=done&style=none&title=&width=1893)![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625121055467-8ed9245d-77dd-460b-8482-383eebe1800b.png#crop=0&crop=0&crop=1&crop=1&height=798&id=u676c959d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=798&originWidth=1885&originalType=binary&ratio=1&rotation=0&showTitle=false&size=181208&status=done&style=none&title=&width=1885)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625121071270-d2a070d2-c25d-4d65-84b3-e4ef427bb304.png#crop=0&crop=0&crop=1&crop=1&height=838&id=u4976ab92&margin=%5Bobject%20Object%5D&name=image.png&originHeight=838&originWidth=1821&originalType=binary&ratio=1&rotation=0&showTitle=false&size=178493&status=done&style=none&title=&width=1821)

#### 2、查看数据上报信息
     **方式1：**<br />**浏览器或者控制台输入 curl 127.0.0.1:9529/monitor 查看**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625121405744-1e67c337-ee01-4905-b05a-df48e0164c19.png#crop=0&crop=0&crop=1&crop=1&height=958&id=ubb22d9fa&margin=%5Bobject%20Object%5D&name=image.png&originHeight=958&originWidth=1560&originalType=binary&ratio=1&rotation=0&showTitle=false&size=167158&status=done&style=none&title=&width=1560)<br />     **方式2：**<br />**浏览器或者控制台输入 curl 127.0.0.1:9529/stats 查看**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625121295324-39206707-70fb-4e81-84ab-e27d7be56b27.png#crop=0&crop=0&crop=1&crop=1&height=617&id=ucbf0ea88&margin=%5Bobject%20Object%5D&name=image.png&originHeight=617&originWidth=647&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37369&status=done&style=none&title=&width=647)

#### 3、查看 datakit 日志
   **datakit 日志目录：cd /var/log/datakit**<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625121657852-499431f3-6d49-4850-9830-9114a19936e3.png#crop=0&crop=0&crop=1&crop=1&height=232&id=u8af75fc9&margin=%5Bobject%20Object%5D&name=image.png&originHeight=232&originWidth=983&originalType=binary&ratio=1&rotation=0&showTitle=false&size=36930&status=done&style=none&title=&width=983)

## 创建场景及视图：
###利用系统视图模板创建###<br />###举例 NGINX 视图创建###

1. **场景——新建场景**

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625044170660-59b06ef5-efe7-4cad-b061-c026b57b42e2.png#crop=0&crop=0&crop=1&crop=1&height=799&id=uddedb7ea&margin=%5Bobject%20Object%5D&name=image.png&originHeight=799&originWidth=1888&originalType=binary&ratio=1&rotation=0&showTitle=false&size=533416&status=done&style=none&title=&width=1888)

2. **新建空白场景**

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625044280335-c0c82fb1-6d22-46c2-bcc4-db82100dbbe2.png#crop=0&crop=0&crop=1&crop=1&height=484&id=u2fcbcbbc&margin=%5Bobject%20Object%5D&name=image.png&originHeight=484&originWidth=1860&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60916&status=done&style=none&title=&width=1860)

3. **输入场景名称——确定**

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625044303062-808e05ca-dac1-48d4-aa63-839b8e0f6a86.png#crop=0&crop=0&crop=1&crop=1&height=633&id=uc706fc35&margin=%5Bobject%20Object%5D&name=image.png&originHeight=633&originWidth=1838&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70648&status=done&style=none&title=&width=1838)

4. **系统视图——NGINX视图（创建）**

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1625044341107-01a6b365-5891-4d37-a987-c466475a7837.png#crop=0&crop=0&crop=1&crop=1&height=584&id=u651c6679&margin=%5Bobject%20Object%5D&name=image.png&originHeight=584&originWidth=1853&originalType=binary&ratio=1&rotation=0&showTitle=false&size=187968&status=done&style=none&title=&width=1853)

5. **查看 NGINX 视图**

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1624429445212-e7080803-6f1b-4f26-bf0f-359ab2ad525f.png#crop=0&crop=0&crop=1&crop=1&height=416&id=bwAl9&margin=%5Bobject%20Object%5D&name=image.png&originHeight=695&originWidth=1731&originalType=binary&ratio=1&rotation=0&showTitle=false&size=130090&status=done&style=none&title=&width=1036.5)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1624429481780-a6396a7b-0597-4740-9913-683f42ba1e1b.png#crop=0&crop=0&crop=1&crop=1&height=395&id=g45wY&margin=%5Bobject%20Object%5D&name=image.png&originHeight=660&originWidth=1730&originalType=binary&ratio=1&rotation=0&showTitle=false&size=148403&status=done&style=none&title=&width=1035)

6. **其他**

       其他视图创建方法类似，如有自定义视图内容及布局需求，可以创建空白视图自己进行搭建。

# 总结：
如此，便对此次 demo 办公系统的链路、指标、日志、基础设施等进行了全方位的可观测性，Dataflux 整体试用下来配置便捷，管理方便，同时还提供了统一的查看视图，所有的指标，链路，日志都通过同一tag（host）实现数据关联，很方便就可在平台上实现级联，从而实现it系统的整体可观测性，最后再结合异常检测即可实现系统一体化的管理，进而提升运维研发效率，提升 IT 决策能力！该产品还在不断的完善，未来，功能会越来越强大，越来越易用，ui 也会越来越美观。dataflux，要做可观测性的代言人！
