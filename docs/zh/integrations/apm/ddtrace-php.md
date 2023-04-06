---
icon: integrations/php
---
# PHP

---

## 视图预览

![image](../imgs/input-ddtrace-php-1.png)

![image](../imgs/input-ddtrace-php-2.png)

![image](../imgs/input-ddtrace-php-3.png)

![image](../imgs/input-ddtrace-php-4.png)

![image](../imgs/input-ddtrace-php-5.png)
## 安装部署

观测云 默认支持所有采用 OpenTracing 协议的 APM 监控手段，例如 SkyWalking、 Jaeger、  Zipkin 等。<br/>
此处官方推荐 **ddtrace** 接入方式。ddtrace 是开源的 APM 监控方式，相较于其他方式，支持更多的自定义字段，也就意味着可以有足够多的标签与其他的组件进行关联。
### 前置条件

- 在需要进行链路追踪的应用服务器<[安装 DataKit](../../datakit/datakit-install.md)>
- [按需下载对应 agent](https://github.com/DataDog/dd-trace-php)
- <[ddtrace-php-agent 框架兼容列表](https://docs.datadoghq.com/tracing/setup_overview/compatibility_requirements/php)>
### 开启 ddtrace for datakit

开启 ddtrace，复制 sample 文件

```
cd /usr/local/datakit/conf.d/ddtrace
cp ddtrace.conf.sample ddtrace.conf
```

重启 DataKit

```
systemctl restart datakit
```
### 安装 PHP 扩展

<div class="grid" markdown>

=== "脚本安装"

    1.下载 ddtrace 官方安装脚本

    ```python
    curl -LO https://github.com/DataDog/dd-trace-php/releases/latest/download/datadog-setup.php
    ```

    2.执行安装

    ```shell
    # APM for all php
    php datadog-setup.php --php-bin=al
    ```
    安装完成后重启 PHP (PHP-FPM 或 Apache SAPI)，访问启动了 tracing 服务的端口。

    ???+ tip

        执行对应的命令可以安装 PHP 扩展，若存在多个 PHP 版本，省略 php-bin 参数时安装程序以命令行交互的模式选择需要安装的 PHP 版本，也可以指定 PHP 路径，dd-trace-php 只会安装到此 PHP 版本中。

        ```shell
        # APM only for php some version
        php datadog-setup.php --php-bin=/usr/local/php7.4/bin/php
        ```

    3.验证扩展包是否安装成

    ```shell
    php -m | grep ddtrace
    ```

=== "二进制包安装"

    1.根据需要下载对应的<[ddtrace-php-agent](https://github.com/DataDog/dd-trace-php/releases)>

    2.安装扩展

    通过以下方式将安装默认版本的 PHP 扩展，安装完成后重启 PHP (PHP-FPM 或 Apache SAPI)，访问启动了 tracing 服务的端口。

    - RPM package (RHEL/Centos 6+, Fedora 20+)

    ```shell
    rpm -ivh datadog-php-tracer.rpm
    ```

    - DEB package (Debian Jessie+ , Ubuntu 14.04+ on supported PHP versions)

    ```shell
    dpkg -i datadog-php-tracer.deb
    ```

    - APK package (Alpine)

    ```shell
    apk add datadog-php-tracer.apk --allow-untrusted
    ```
    ???+ tip

        若存在多个 PHP 版本，可以通过配置 `DD_TRACE_PHP_BIN` 环境变量设置指定版本的 PHP 路径。

        ```shell
        # php path for some version
        export DD_TRACE_PHP_BIN=/usr/local/php7.4/bin/php
        ```


    3.验证扩展包是否安装成功

    ```shell
    php -m | grep ddtrace
    ```

</div>


### 运行配置

PHP trace 可以通过环境变量和 ini 配置文件进行配置。<br/>
ini 可以进行全局配置，例如：使用 `php.ini` 配置特定的 web server 或 virtual host。

<div class="grid" markdown>

=== "Apache 环境下添加 php 参数"

    - 在 `www.conf` 文件中添加 ddtrace 相关环境变量

    ```shell
    ; Example of passing the host environment variable SOME_ENV
    ; to the PHP process as DD_AGENT_HOST
    env[DD_AGENT_HOST] = localhost  （必填）
    ; to the PHP process as DD_TRACE_AGENT_PORT
    env[DD_TRACE_AGENT_PORT] = 9529  （必填）
    ; Example of passing the value 'my-app' to the PHP
    ; process as DD_SERVICE
    env[DD_SERVICE] = my-app  (my-app 为观测云平台上展示的名称)
    env[DD_ENV] = ENV  (可选)
    env[DD_VERSION] = 1.0.0 (可选)
    ```

    - 还可以在 `.htaccess` 文件中使用 `SetEnv` 设置环境变量

    ```shell
    # In a virtual host configuration as an environment variable
    SetEnv DD_AGENT_HOST localhost
    SetEnv DD_TRACE_AGENT_PORT 9529
    # In a virtual host configuration as an INI setting
    php_value datadog.service my-app
    ```

=== "Nginx 环境下添加 php 参数"

    在 `www.conf` 文件中添加 ddtrace 相关环境变量

    ```shell
    ; Example of passing the host environment variable SOME_ENV
    ; to the PHP process as DD_AGENT_HOST
    env[DD_AGENT_HOST] = localhost  （必填）
    ; to the PHP process as DD_TRACE_AGENT_PORT
    env[DD_TRACE_AGENT_PORT] = 9529  （必填）
    ; Example of passing the value 'my-app' to the PHP
    ; process as DD_SERVICE
    env[DD_SERVICE] = my-app  (my-app 为观测云平台上展示的名称)
    env[DD_ENV] = ENV  (可选)
    env[DD_VERSION] = 1.0.0 (可选)
    ```

=== "命令行方式"

    PHP CLI 启动方式可通过设置环境变量上报 tracing

    ```shell
    DD_AGENT_HOST=localhost \
    DD_TRACE_AGENT_PORT=9529 \
    DD_TRACE_DEBUG=true \
    php -d datadog.service=my-php-app -S 0.0.0.0:8000
    ```

</div>


**参数说明：**

- DD_ENV：自定义环境类型，可选项。
- DD_SERVICE：自定义应用名称，**必填**。
- DD_TRACE_AGENT_PORT：数据上传端口（默认 9529 ），**必填**。
- DD_VERSION：应用版本，可选项。
- DD_TRACE_SAMPLE_RATE：设置采样率（默认是全采），可选项，如需采样，可设置 0~1 之间的数，例如 0.6，即采样 60%。
- DD_SERVICE_MAPPING：当前应用调用到的 redis、mysql 等，可通过此参数添加别名，用以和其他应用调用到的 redis、mysql 进行区分，可选项，应用场景：例如项目 A 项目 B 都调用了 mysql，且分别调用的 mysql-a，mysql-b，如没有添加 mapping 配置项，在观测云平台上会展现项目 A 项目 B 调用了同一个名为 mysql 的数据库，如果添加了 mapping 配置项，配置为 mysql-a，mysql-b，则在观测云平台上会展现项目 A 调用 mysql-a，项目 B 调用 mysql-b。
- DD_AGENT_HOST：数据传输目标 IP，默认为本机 localhost，可选项。


### 重启 PHP 服务

浏览器访问 phpinfo 输出的相关页面，查看 ddtrace 模块是否已安装成功。

![image](../imgs/input-ddtrace-php-6.png)

### [支持的环境变量](../../datakit/ddtrace-php.md#envs)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - PHP FPM 监控视图>

## 更多阅读

- <[应用性能监测功能介绍](../../application-performance-monitoring/index.md)>
- <[链路追踪-字段说明](../../application-performance-monitoring/collection/index.md#_5)>
- <[链路追踪（APM）最佳实践](../../best-practices/monitoring/apm.md)>
