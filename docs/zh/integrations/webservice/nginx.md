---
icon: integrations/nginx
---
# Nginx

---

## 视图预览

Nginx 性能指标展示，包括请求数、处理请求数、活跃请求数、等待连接数等。

![image](../imgs/input-nginx-01.png)

## 版本支持

操作系统：Linux / Windows<br />Nginx 版本：ALL

## 前置条件

- Nginx 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- Nginx 应用已安装 http_stub_status_module 模块

1、 使用命令查看 stub_status 模块是否安装 (如已安装返回 http_stub_status_module)

```
nginx -V 2>&1| grep -o http_stub_status_module
```

## 安装配置

说明：示例 Nginx 版本为 Linux 环境 Nginx/1.16.1 (CentOS)，各个不同版本指标可能存在差异。

### 部署实施

(Linux / Windows 环境相同)

#### 指标采集 (必选)

1、 开启 nginx_status 页面，修改主配置文件 `/etc/nginx/nginx.conf` (以实际路径为准)

参数说明：

- 在主站点的 server 配置里添加 location /nginx_status
- stub_status：开启 nginx_status 页面
- access_log：关闭访问日志
- allow：只允许本机访问 (127.0.0.1)
- deny all：拒绝其他访问连接

```
    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location /nginx_status {
            stub_status  on;
            access_log   off;
            allow 127.0.0.1;
            deny all;
            }
```

2、 使用 `nginx -t` 测试配置文件语法

![image](../imgs/input-nginx-02.png)

3、 重载 Nginx

```
systemctl reload nginx
```

4、 查看监控数据 `curl http://127.0.0.1/nginx_status` (Windows 浏览器访问)

(如果配置了 `server_name`，使用 `curl http://域名:端口/nginx_status` )

![image](../imgs/input-nginx-03.png)

5、 开启 DataKit Nginx 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/nginx/
cp nginx.conf.sample nginx.conf
```

6、 修改 `nginx.conf` 配置文件

主要参数说明

- url：nginx status 页面地址
- interval：采集频率
- insecure_skip_verify：是否忽略安全验证 (如果是 https，请设置为 true)
- response_timeout：响应超时时间 (默认 5 秒)

```
[[inputs.nginx]]
        url = "http://127.0.0.1/nginx_status"
        interval = "60s"
        insecure_skip_verify = false
        response_timeout = "5s"
```

7、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
systemctl restart datakit
```

8、 指标预览

![image](../imgs/input-nginx-05.png)

#### 日志采集 (非必选)

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- Pipeline：日志切割文件(内置)，实际文件路径 `/usr/local/datakit/pipeline/nginx.p`
- 相关文档 <[ 文本数据处理（Pipeline）](../../datakit/pipeline.md)>

```
[inputs.nginx.log]
files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
pipeline = "nginx.p"
```

重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

日志预览

![image](../imgs/input-nginx-07.png)

#### 插件标签 (非必选）

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Nginx 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.nginx.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

#### 链路采集(非必选)

某些场景下，我们需要将前端负载均衡也纳入到全链路观测中，用于分析用户请求从系统入口位置到后端服务结束这一完整过程的链路调用及耗时情况。这时就需要安装 Nginx 链路追踪模块来实现该功能。

安装 Nginx 链路追踪有两个前置条件：

- 首先，安装 Nginx 的 OpenTracing 插件 [linux-amd64-nginx-${NGINX_VERSION}-ot16-ngx_http_module.so.tgz](https://github.com/opentracing-contrib/nginx-opentracing/releases/latest)。点击链接打开 git 目录后，在 Asset 中根据自己的 Nginx 版本选择对应的模块包进行下载，将这个包解压到 nginx 模块目录下，通常为 `/usr/lib/nginx/modules`。也可解压到其他目录，区别是在下面操作 load_module 时，需要引用绝对路径。
- 其次，需要安装 ddagent 运行所依赖的 C++ 插件 [linux-amd64-libdd_opentracing_plugin.so.gz](https://github.com/DataDog/dd-opentracing-cpp/releases/latest)。这个包需要解压到 nginx 可访问的某个目录下，例如 `/usr/local/lib` 。

完成插件包下载后，可使用下面的命令解压：

- Nginx OpenTracing 包：<br />
  ```
  tar zxf linux-amd64-nginx-<填写您下载的.so 的版本号>-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules`
  ```
- ddagent Cpp 支持包：<br />
  ```
  gunzip linux-amd64-libdd_opentracing_plugin.so.gz -c > /usr/local/lib/libdd_opentracing_plugin.so
  ```

解压完成后，首先配置 `nginx.conf` ，加载 Nginx OpenTracing 模块：

```
#ps -ef | grep nginx 、nginx -V或whereis nginx命令查找您环境中nginx的安装位置
#cd到该目录下,进入conf文件夹，vi 编辑nginx.conf
#增加如下命令，加载Nginx OpenTracing 模块。注意需要加在event配置之前：
`load_module modules/ngx_http_opentracing_module.so;`
```

在 `nginx.conf` 的 http 配置项中，增加如下内容：

```
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;

opentracing_load_tracer /usr/local/lib/libdd_opentracing_plugin.so /etc/nginx/dd-config.json;
```

其中， `opentracing_load_tracer` 的配置需要注意，第一个参数是 C++ 插件的位置，这个已经在拷贝命令中添加好了；第二个参数 `dd-config.json` 需要手动添加。<br />
以示例中的位置为例，我们在 `/etc/nginx/` 目录下，`vi dd-config.json` 并填写以下内容：

```
{
  "environment": "prod",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}

```

其中，`agent_host` 需填写本地可访问的 DataKit 地址，`agent_port` 须填写 DataKit 端口号 `9529`。

下一步，编辑 Nginx 日志格式，将 Trace 信息注入到 Nginx 日志中。可按如下示例编辑：

```
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **说明：**`log_format` 关键字告诉 Nginx 这里定义了一套日志规则， `with_trace_id` 是规则名，可以自己修改，注意在下方指定日志路径时要用一样的名字来关联该日志的规则。`access_log` 中的路径和文件名可以更换。通常情况下原 Nginx 是配有日志规则的，我们可以配置多条规则，并将不同的日志格式输出到不同的文件，即保留原 `access_log` 规则及路径不变，新增一个包含 trace 信息的日志规则，命名为不同的日志文件，供不同的日志工具读取。

完成上述配置后，在 `http.server` 需要进行追踪的 `location` 配置中，增加如下内容：

```
opentracing_operation_name "$request_method $uri";
opentracing_propagate_context;

opentracing_tag "custom-tag" "special value";#用户自定义标签，可选
```

配置完成后保存并退出 `nginx.conf` ，首先使用 `nginx -t` 进行基本的语法检查，在注入 Nginx Trace 模块之前，检查结果仅显示 Nginx 本身的内容：

![image](../imgs/input-nginx-08.png)

如成功配置 Nginx Trace 模块，则再次使用 `nginx -t` 进行语法检查时，会提示 ddtrace 的相关配置信息：

![image](../imgs/input-nginx-09.png)

使用 `nginx -s reload` 重新加载 Nginx，使 tracing 功能生效。登录观测云的应用性能监控界面，查看 Nginx Tracing 信息：

![image](../imgs/input-nginx-10.png)

**可能遇到的问题：**

- 问题1： 在进行 Nginx 语法检查时报错，提示没有找到 OpenTracing 的 module 。

![image](../imgs/input-nginx-11.png)

这个报错说明您环境中的 Nginx 保存 Modules 的路径并不是 `/usr/lib/nginx/modules` 。<br />
这时可以根据报错提示的路径，将 Nginx OpenTracing 包拷贝到您环境中 Nginx 的模块引用位置；或在配置 `nginx.conf` 时，使用 `OpenTrace so` 文件所在位置的绝对路径。

- 问题2： 在进行 Nginx 语法检查时报错，提示 `“Nginx is not binary compatible...”` 类错误。

产生这个错误的原因，可能是您本地使用的 Nginx 为编译安装版本，与本例中提供的 OpenTracing 模块的包签名不一致，导致出现兼容性问题。<br />
建议的解决方法为：通过本例提供的 Module 下载链接，找到 Nginx_OpenTracing 的代码仓库，将代码下载到本地。
> **注意：**需要根据您现在所使用的 Nginx 版本来进行选择，例如 Nginx-Opentracing Release 0.24.x 版本支持的 Nginx 最低要求为 1.13.x(可以通过 github 项目中记录的已经编译好的包的版本号来确认),如果低于这个版本的 Nginx，需要在历史 Release 版本中查找对应的源代码版本。

找到对应版本后，停用本地 nginx。将 Nginx-Opentracing 的代码拷贝到本地并解压。进入到 nginx 代码路径使用 configure 重建 objt 时，增加 `--add-dynamic-module=/path/to/your/module` (该路径指向您本地保存 ddagent 代码)，可以在 Nginx 目录下使用 `./configure` 命令直接添加。

**注意：** tracing 模块的重新编译依赖 OpenTracingCPP 公共包，需要一并下载这个包用于编译：<br />
相关帮助信息：[https://github.com/opentracing-contrib/nginx-opentracing](https://github.com/opentracing-contrib/nginx-opentracing)

![image](../imgs/input-nginx-12.png)

OpenTracingCPP 下载地址：[https://github.com/opentracing/opentracing-cpp/releases/tag/v1.6.0](https://github.com/opentracing/opentracing-cpp/releases/tag/v1.6.0)

编译安装步骤简述：
1、编译 OpenTracing CPP 库，生成 libopentracing.so，这个库后续用于 Nginx 调用 OT 接口生成 trace 信息。使用上面的 opentracing-cpp 链接将代码下载到编译环境本地。进入代码目录，按顺序执行以下命令：
`mkdir .build `<br />`cd .build `<br />`cmake .. `<br />`make sudo make install`<br />第一步操作生成编译临时目录。cd 进入该目录后调用 cmake 执行编译，编译结果将保存在.bulid 目录中。这里需要注意最新版本的 opentracing-cpp 编译需要 cmake 版本高于 3.1，如使用操作系统默认版本的 cmake，可能报版本过低的错误，可以通过 yum install -7 cmake3 的方式安装 3.x 版本。如安装提示找不到包，可尝试将 yum 源配置为国内安装源后重试。

2、下载 nginx-opentracing 代码，解压到本地并编译 Nginx 以加载该模块
下载 nginx-opentracing 代码：[https://github.com/opentracing-contrib/nginx-opentracing](https://github.com/opentracing-contrib/nginx-opentracing)
保存在本地任意路径<br />下载您所需要版本的 Nginx，下载后解压到本地目录，增加 opentracing 模块并启动编译：
`tar zxvf nginx-1.xx.x.tar.gz `<br />`cd nginx-1.x.x `<br />增加模块时，--add 参数后填写指向之前下载的 nginx-opentracing 代码目录中的 opentracing<br />`./configure --add-dynamic-module=/absolute/path/to/nginx-opentracing/opentracing`<br />操作完成后启动编译<br />`make && sudo make install`<br />这一步操作可能会遇到较多头文件问题，因为 ng opentracing 的头文件路径以<>包含，编译器默认在/usr/include 下查找文件，找不到即会编译报错。处理方式是在/usr/include 下，创建指向头文件所在目录的软连接。使 make 可以找到这些文件。具体的头文件在哪个地方，可使用 find 等检索命令查找。<br />3、下载 ddagent 的 nginx trace 插件，在 nginx.conf 中开启 trace_plugin 使链路追踪生效：
wget -O - [https://github.com/DataDog/dd-opentracing-cpp/releases/download/v0.3.0/linux-amd64-libdd_opentracing_plugin.so.gz](https://github.com/DataDog/dd-opentracing-cpp/releases/download/v0.3.0/linux-amd64-libdd_opentracing_plugin.so.gz) | gunzip -c > /usr/local/lib/libdd_opentracing_plugin.so<br />注意：这里下载的 ddplugin 版本需要与 opentracing lib 版本对应，如 opentracing 版本与 libdd_opentracing_plugin 有差异，需要下载 ddtrace 代码到本地，基于本地环境 opentracing 库重新编译生成插件。本方案提供的版本：[https://github.com/opentracing/opentracing-cpp/releases/tag/v1.6.0](https://github.com/opentracing/opentracing-cpp/releases/tag/v1.6.0)与 ddagent 插件环境匹配，下载的插件可以直接使用。后续不排除 otracing 库及 ddagent 同步更新的情况，请在使用前注意核对版本号。

本例中的 nginx 版本使用 yum 安装，考虑到编译安装的实施及调试成本，建议采用 yum 安装的版本进行尝试。安装方法(CentOS7 为例)：<br />增加 Nginx 安装源：<br />rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm<br />yum 安装指定版本 nginx,版本号 1.x.xx：<br />yum -y install nginx-1.x.xx

3、在接入 nginx tracing 后，发现观测云界面上 nginx 的 tracing 数据没有和 location 指向的后端应用关联起来。

这个问题产生的原因是 nginx tracing 模块生成的链路追踪 ID 没有被同时转发到后端服务，导致后端生成了新的 traceid，在界面上被识别为两个不同的链路，解决方法是在需要追踪的 Location 中，配置 http_header 的转发：

proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;<br />proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;

这里的参数为固定值，X-datadog-*\*\*为 ddagent 识别 header 转发字段的参数，opentracing*context\*\*为 OpenTracing 模块的 traceid 参数。

配置完成后保存并退出 nginx.conf,使用 nginx -s reload 重启服务。

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Nginx 监控视图>

## [指标详解](../../../datakit/nginx#measurements)

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

## 进一步阅读

<[观测云 Nginx 可观测最佳实践](../../best-practices/monitoring/nginx.md)>
