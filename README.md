[[_TOC_]]

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
pip install git+https://[user]:[token]@gitlab.jiagouyun.com/lhm/mkdocs-material-insiders.git
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

多语言在开发阶段先使用 ```feature/multi-language```  分支，等多语言编写完成可以发布，再并入 `merge` 分支做常规化分支管理。

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

### 添加标题

`# 标题` ：仅用于文章名称

`## 标题` ：文章内容的一级标题，以此类推

### 添加图片

注意事项：

- 在编辑文档时，过期不用的图片需要从文档库删除
- 图片大小建议不要超过 1 M（gif 格式除外）

1）若图片不需要边框，可以用如下格式

```
<img src="img/xxxxxx.png" width=210px />
```

2）若需要定义图片，需要手动加边框，可以用如下格式

```
<img src="img/xxxxxx.png" width=210px border=1px />
```

3）若使用多个图片并列，可使用空格 `&nbsp;`

```
<img src="img/xxxxxx.png" width=210px border=1px />&nbsp;<img src="img/xxxxxx.png" width=210px border=1px />
```

### 添加引用

功能点引用采用「」，其他引用可以用“”

### 添加提示

1）在注意事项前增加符号 `>`

``` markdown
> 注意：xxxxxx
```

2）注意事项使用如下格式

```markdown
???+ attention

    xxxxxx
```

3）提示信息可以使用如下格式：

``` markdown
???+ Note "关于xxxxxx的说明"

    xxxxxx
```

### 添加 tab 切换

```markdown
=== "主机安装"

    xxxxxx

=== "容器安装"

    xxxxxx
```

### 添加文字颜色

```markdown
`<font color=coral>**添加文字颜色**</font>`
```

效果示例：<font color=coral>添加文字颜色</font>

### 添加表格按钮链接

```markdown
| 采集器配置    |          |            |           |            |
| :---------: | :------: | :--------: | :--------: | :-------: |
| [DDTrace](zh/datakit/ddtrace.md){ .md-button .md-button--primary } | [Skywalking](zh/datakit/skywalking.md){ .md-button .md-button--primary } | [OpenTelemetry](zh/datakit/opentelemetry.md){ .md-button .md-button--primary } | [Zipkin](zh/datakit/zipkin.md){ .md-button .md-button--primary } | [Jaeger](zh/datakit/jaeger.md){ .md-button .md-button--primary } |
```

### 添加跳转链接

```
<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; **添加跳转链接**</font>](.md)

<br/>

</div>
```

### 添加目录说明

与 md 文档同名的目录内不要有 md 文档，发现会影响中文搜索插件，导致无法搜索到中文，如下 ：

```shell
.
├── explorer
│   ├── action.md
│   ├── error.md
│   ├── index.md
│   ├── long-task.md
│   ├── resource.md
│   ├── session.md
│   └── view.md
└── explorer.md  <--- 不要有这个名字
```

### 本地图片 Git LFS 问题

由于采用 gitlfs 来保存图片等多媒体资源，本地如果预览，会出现某些图片无法展示的问题，建议将图片拉到本地（可能时间比较长）：

```shell
$ git lfs fetch --all
```

## 文档规范检查

现有 Datakit 文档中有部分文档规则说明[^dk-docs]，此处添加一些描述，说明如何处理检查出俩的错误。

### 拼写检查

由于文档涉及非常多的专有名词，如果遇到拼写检查不通过，可以用如下方式来处理：

1. 如果是文件名中检测出拼写错误，比如 `java-agent.jar` 中含有 `java`
这个禁用词，但是这确实是个文件名，不能改写成 `Java-agent.jar`，对此，
我们建议将其用文件名（斜体）排版： `*java-agent.jar*`，现有的拼写检查会绕过
文件名中的单词。

1. 如果是一段代码单词，比如 `java_agent`，此处也使用了禁用词 `java`，
但是将其用代码字体修饰（`` `ava_agent` ``）即可绕过单词拼写。

1. 如果是正文中插入这些单词，则必须用标准的方式，比如：

``` markdown
# 错误写法
在 java 代码中，我们需要做如下改动：
...

#正确写法
在 Java 代码中，我们需要做如下改动：
...
```

## 文档协作流程

目前项目的 master 分支只有 maintainer 可以直接推送；`merge` 分支禁止了任何推送，只能从其它分支合并更新。

所有文档更新，都应该走如下流程：

1. 作者：文档更新，应该在本地创建一个 git 分支（`feature-xxx`），修改完成后，将该分支推送上来。
1. 作者：创建一个 merge request，将该分支合并到 `merge` 分支（当前项目已经将 `merge` 设为默认分支，所有 MR 默认都是往 `merge` 合并）
1. maintainer：合并该分支到 `merge`
1. maintainer：在其本地切换到 `merge` 分支，拉取最新的 `merge` 分支
1. maintainer：切换到 master 分支，拉取最新的 master 分支
1. maintainer：将本地的 `merge` 分支合并到 master
1. maintainer：将本地的 master 分支推送到 Gitlab
1. 至此分支合并完毕，等 Gitlab CI 跑完，即完成文档发送
1. 作者：本地从其 `feature-xxx` 分支切换到 `merge` 分支，拉取 `merge` 分支的更新
1. 作者：删除本地 `feature-xxx` 分支。对于已经合并的本地 `feature-xxx` 分支，不要在上面再做任何更新。可以将 `feature-xxx` 删掉（`git branch -D feature-xxx`），再在 `merge` 基础上，再次新建一个分支（该分支甚至能跟之前的命名一致）

即使是 maintainer，也不建议直接往 master 推送自己的更新，也需要走如上的流程，以保持 `merge` 跟 `master` 的一致。

> 分支建议：建议在一个特定的分支上，只做一件特定的事情，不要所有事情都在一个分支上修改，这样不利于分支提交：
>  - 事情 1 做好了，但是事情 2 还没改完，但它们混在一个分支上，导致当前该分支不能提交。
>  - 事情 1 出了问题，一堆冲突，跟事情 2 的提交混在一起，不利于修改。

---
<!-- links -->
[^dk-docs]: https://docs.guance.com/datakit/mkdocs-howto/#mdlint-cspell
