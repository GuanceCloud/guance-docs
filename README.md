# 如何在本地调试文档

## 安装 Python 环境

mkdocs 本地调试需要依赖 Python 环境的支持，建议安装 Python 3.7.7 以上的版本。

通过以下命令查看本地是否有 Python 环境，且是 3.7.7 以上，如果没有 Python 环境，需要安装一下：

```shell
python --version
```

[如何安装 Python](https://www.python.org/downloads/) ？

## 拉取文档仓库

从 gitlab 中拉取帮助文档仓库到本地： [https://gitlab.jiagouyun.com/zy-docs/dataflux-doc](https://gitlab.jiagouyun.com/zy-docs/dataflux-doc)

**如何拉取文档仓库到本地？**

## 安装 mkdocs 依赖库

进入 `dataflux-doc`目录，执行以下 `shell` 命令，安装 mkdocs 依赖库：

```shell
pip install  -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt
```

## 安装 mkdocs 服务

使用自己的 gitlab 账号和 token 安装 mkdocs：

```shell
pip install git+https://[user]:[token]@gitlab.jiagouyun.com:40022/lhm/mkdocs-material-insiders.git
```

**user** 是你的 gitlab 登录账号，**token** 可以在 gitlab 的右上角菜单的 Edit profile -> Access Tokens 中创建，权限只需要 **read_repository**。

## 启动 mkdocs 本地服务

进入 `dataflux-doc`目录，执行以下 `shell` 命令，启动 mkdocs 服务：

```shell
mkdocs serve
```

看到以下输出，就表示启动成功服务：

```shell
INFO     -  Documentation built in 3.32 seconds
INFO     -  [15:52:48] Watching paths for changes: 'docs', 'mkdocs.yml'
INFO     -  [15:52:48] Serving on http://127.0.0.1:8000/
```

如何默认的本地 `8000` 端口已经被占用，可以在启动服务时自行指定端口号，如下形式：

```shell
mkdocs serve -a 127.0.0.1:8090
```

## 多语言

多语言在开发阶段先使用 ```feature/multi-language```  分支，等多语言编写完成可以发布，再并入 dev 分支做常规化分支管理。

本地中、英文服务需要分开调试，分别启动中文或英文的文档服务：

> 本地中文版服务启动

```shell
mkdocs serve -f mkdocs.zh.saas.yml
```

或不指定语言配置文件，默认为中文启动

```shell
mkdocs serve
```

> 本地英文版服务启动

```shell
mkdocs serve -f mkdocs.en.saas.yml
```

## 浏览器中访问本地文档库

在浏览器中访问本地的文档库地址：`http://127.0.0.1:8000`。

注：开启本地调试后，`dataflux-doc` 目录中的任务文档变化，mkdocs 服务都会自动监听本地文档的变化并且浏览器中也会自动刷新文档。

## 编辑文档注意事项

1.在编辑文档时，过期不用的图片需要从文档库删除。

2.功能点引用采用「」，其他引用可以用“”

3.若图片不需要边框，可以用如下格式

`<img src="img/xxxxxx.png" width=210px />`

4.若需要定义图片，需要手动加边框，可以用如下格式

`<img src="img/xxxxxx.png" width=210px border=1px />`

5.若使用多个图片并列，可使用空格 `&nbsp;`

`<img src="img/xxxxxx.png" width=210px border=1px />&nbsp;<img src="img/xxxxxx.png" width=210px border=1px />`

6.注意事项可以用以下方式：

1）在注意事项前增加符号 >

> 注意：xxxxxx

2）使用如下格式

???+ attention

    xxxxxx

7.提示信息可以使用如下格式：

???+ Note "关于xxxxxx的说明"

    xxxxxx

8.使用 tab 切换可以使用如下格式：

=== "主机安装"

    xxxxxx

=== "容器安装"

    xxxxxx

9.表格按钮链接可以使用如下格式：

|                          采集器配置                          |                                                              |                                                              |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [DDTrace](zh/datakit/ddtrace.md){ .md-button .md-button--primary } | [Skywalking](zh/datakit/skywalking.md){ .md-button .md-button--primary } | [OpenTelemetry](zh/datakit/opentelemetry.md){ .md-button .md-button--primary } | [Zipkin](zh/datakit/zipkin.md){ .md-button .md-button--primary } | [Jaeger](zh/datakit/jaeger.md){ .md-button .md-button--primary } |

10.图片大小建议不要超过 1 M（gif 格式除外）

