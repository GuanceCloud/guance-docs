# 集成首页生成器

本工具用于生成观测云集成的首页（index page），通过该首页我们可以直接通过交互的方式搜索对应的集成文档。

## 编译

直接运行如下命令即可生成多个平台的二进制：

```shell
make
```

## 运行

通过 `-h` 可查看基本的使用方式：

```shell
$ ./integrationdoc-darwin-amd64 -h
Usage of ./integrationdoc-darwin-amd64:
  -integration-path string
    	path of integration docs
  -lang string
    	language(zh/en) to generate (default "zh")
  -out string
    	generated result file
  -template string
    	template file path
  -version
    	show version info
```

具体示例，参见 *idg.sh*。

## 文档规范

如果你编写的集成文档，需要在集成首页搜索，那么文档头部需具备如下信息，示例如下：

```yaml
---
title     : 'Aerospike'
summary   : '采集 Aerospike 相关指标信息'
tags      :
  - 'tag1'
  - 'tag2'
  - 'tag3'
__int_icon: 'icon/aerospike'
dashboard :
  - desc  : 'Aerospike Namespace Overview 监控视图'
    path  : 'dashboard/zh/aerospike_namespace'
  - desc  : 'Aerospike Monitoring Stack Node 监控视图'
    path  : 'dashboard/zh/aerospike_stack_node'
monitor   :
  - desc  : 'Aerospike 检测库'
    path  : 'monitor/zh/aerospike'
explorer:
  - desc : 'Aerospike 察看器'
    path: 'explorer/zh/aerospike'
---
```

其中（以下所有字段都是 **区分大小写** ）：

- `title/summary/tags/__int_icon` 都会在集成页面使用到，务必补全。其中 **`title` 是必填的**，否则该文档无法在首页可见。如果在这里指定了 `title`，那么文档中不用再用一级标题（`# 文章标题`）了，如果用了反而会导致文件检测失败（`MD025` 号报错）
    - 如果没有指定 `__int_icon`，将默认使用 *docs/{zh,en}/integrations/icon/integration-default-logo.png*，如果要改变该默认 logo，可更改 *docs/{zh,en}/integrations/integration-index.template* 中 `this.src` 处设置。另外，icon 路径最好是**全小写形式**，碰到专有名词，直接用其小写模式接口，比如 SNMP 的路径是 `'icon/snmp'`
- 所有的 key-value 之间至少有一个空白字符，形如 `title:'Aerospike'` 不合 yaml 的语法
- 由于现有的 value 都是字符串，建议统一写成 `key: 'value'` 这种形式，不要写成 `key: value`。因为这段文本会位于 markdown 里面，我们针对 markdown 有严格的编写检查，现有的检查规则跳过了形如 `'this-is-a-string'` 这样的文本段，参见[这里](../checking/cspell.json) 的规则
- 对于不需要在集成页面搜索的集成文档，我们应该在头部加上如下标记，导出程序会忽略这个文档，从而不会将其带入 *integration-index.md* 中


    ```yaml
    ---
    skip: 'reason: why you skip this file?'
    ---
    ```

- 一旦导出程序发现有部分文件未能正确导入（比如上面的 yaml header 编写有误），又没有 `skip` 标记，那么程序将认为这是个错误

## 日常使用流程

我们本希望将 *integration-index.md* 的生成放到 GitLab 的 CI/CD 流程中，但这个页面关乎集成的整体使用体验，所以还是希望人工 check 一下，待流程成熟后，我们再考虑将其集成到 CI/CD 中自动生成。

1. 下载导出程序的二进制当当前目录，或者自己编译（目前不支持 Windows 下编译），需安装 Golang 1.19（含）以上的版本（这个步骤一般只执行一次即可，**后续不用再执行**)
    - [macOS-amd64](https://static.guance.com/idg/integrationdoc-darwin-amd64)
    - [macOS-arm64](https://static.guance.com/idg/integrationdoc-darwin-arm64)
    - [linux-amd64](https://static.guance.com/idg/integrationdoc-linux-amd64)
    - [linux-amd64](https://static.guance.com/idg/integrationdoc-linux-amd64)
    - [windows-amd64](https://static.guance.com/idg/integrationdoc-windows-amd64.exe)

    > 注意：虽然我们编译并发布了 Windows 版本的二进制，但我们的 *idg.sh* 并不支持在 Windows 下运行（也许通过 [git-for-windows](https://git-scm.com/download/win) 可以）。如果你确实需要在 Windwows 下使用，请自行编写对应的 cmd 或 powershell 脚本，具体流程，参见 *idg.sh*。

    这些二进制文件下载到本地后，务必执行，否则无法运行：

    ```shell
    $ chmod +x integrationdoc-{os}-{arch}
    ```

    如果你对导出程序的源码有更改，请修改 Makefile 中的版本号，**并将其编译后的二进制同步到上面这些地址**。

1. 在 *docs/{zh,en}/integrations* 目录下编写对应的 markdown 文档
1. 务必准备对应的 icon 图标，分别放到 *docs/{zh,en}/integrations/icon* 目录下，其示例如下：

    ```text
    [ 128]  docs/zh/integrations/icon/disk
    ├── [1.6K]  icon-dark.png
    └── [1.7K]  icon.png
    ```

    其中 `disk` 就是集成的名字，**其名字需与对应 markdown 头部 yaml 中的 `__int_icon` 字段值相同**。我们目前使用的就是这里的 `icon.png` 文件，`icon-dark.png` 暂未使用。

1. 执行项目 *idg.sh*，它自动会判定操作系统平台并使用对应的二进制，至此，对应的 *integration-index.md* 就更新好了，我们可以 `git diff` 看一下更新情况

    ```shell
    $ ./idg.sh
    ```

    执行完后，我们从 *log.idg* 日志文件中，能看到文件导出情况：

    ```text
    2024/09/13 16:13:26 main.go:56: ok docs(234)
	docs/en/integrations/active_directory.md
	docs/en/integrations/aerospike.md
	docs/en/integrations/aliyun_clickhouse_community.md
    ...
    2024/09/13 16:13:26 main.go:61: failed docs(54):
	docs/en/integrations/built-in_cdn_dict_config.md
	docs/en/integrations/container-log.md
	docs/en/integrations/datakit-input-conf.md
    ...
    ```
