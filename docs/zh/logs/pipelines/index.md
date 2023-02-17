# 日志 Pipelines

---

在观测云的日志管理中，可以通过 Pipelines 对日志的文本内容进行切割，将格式各异的日志切割成符合我们要求的结构化数据，如日志的时间戳、日志的状态、以及提取出特定的字段作为标签等。

![](../img/pipeline001.png)

## 前提条件

- [安装 DataKit](../../datakit/datakit-install.md)
- DataKit 版本要求 >= 1.5.0

## 新建 Pipeline

在观测云工作空间「日志」-「Pipelines」，点击「新建Pipeline」，选择「过滤日志」，填入「定义解析规则」，然后在「日志样本测试」输入日志数据进行测试，测试通过后点击「保存」即可创建一个新的 pipeline 文件。支持配置默认 pipeline，并且在新建 pipeline 时支持选择多个 source。

注意：pipeline 文件创建以后，需要安装 DataKit 才会生效，DataKit 会定时从工作空间获取配置的 pipeline 文件，默认时间为 1分钟，可在 `conf.d/datakit.conf` 中修改。

```
[pipeline]
  remote_pull_interval = "1m"
```

- 过滤日志：支持多选日志来源；
-  名称：输入自定义的 pipeline 文件名；
- 定义解析规则：定义日志的解析规则，支持多种脚本函数，可通过观测云提供的脚本函数列表直接查看其语法格式，如`add_pattern()`等。关于如何定义解析规则，可参考文档 [Pipeline 介绍](../../developers/pipeline.md) ；
- 日志样本测试：输入日志数据，根据配置的解析规则进行测试，支持「一键获取」已经采集的日志数据样本。关于如何调试样本数据可参考文档 [调整 Pipeline](../../management/overall-pipeline/#test) 。
- **支持将某一 pipeline 脚本设置为“默认 pipeline 脚本”，当前数据类型在匹配 pipeline 处理时若未匹配到其它的 pipeline 脚本，则数据会按照默认 pipeline 脚本的规则做处理。**设为默认的 pipeline，名称后面会有一个「default」icon 作为标识。

注意：自定义 pipeline 文件不能同名，但可以和官方 pipeline 同名，此时 DataKit 会优先自动获取自定义 pipeline 文件配置。若在日志采集器 `.conf` 中手动配置 pipeline 文件，此时 DataKit 会优先获取手动配置的 pipeline 文件。

![](../img/pipeline002.png)

## 操作 Pipeline

### 编辑/删除/启用/禁用

在观测云工作空间「日志」-「Pipelines」，点击右侧操作下的按钮即可对 pipeline 文件编辑/删除/启用/禁用。
注意：

- 编辑 pipeline 文件后，默认生效时间为 1 分钟；
- 删除 pipeline 文件后，无法恢复，需要重新创建；若存在同名的官方库 pipeline 文件，DataKit 会自动匹配官方库 pipeline 文件进行文本处理；
- 禁用 pipeline 文件后，可通过启用重新恢复；若存在同名的官方库 pipeline 文件，DataKit 会自动匹配官方库 pipeline 文件进行文本处理；

![](../img/pipeline001.png)

### 批量操作

在观测云工作空间「日志」-「Pipelines」，点击「批量操作」，即可「批量导出」或「批量删除」Pipelines。

???- attention

    该功能仅对工作空间拥有者、管理员、普通成员显示，只读成员不显示。

![](../img/pipeline003.png)

### 导入/导出

在观测云工作空间「日志」-「Pipelines」中支持「导入/导出 Pipeline」，即通过导入/导出 JSON 文件的方式创建 Pipeline。

???- attention

    导入的 JSON 文件需要是来自观测云的配置 JSON 文件。



## Pipeline 官方库

在观测云工作空间「日志」-「Pipelines」，点击「Pipeline 官方库」即可查看内置标准的 pipeline 官网文件库，包括如 nginx、apache、redis、elasticsearch、mysql 等。

![](../img/pipeline004.png)

选择打开任意一个 pipeline 文件，如 apache.p ，可以看到内置的解析规则，如果需要自定义修改，可以点击右上角的「克隆」。
注意：

- pipeline 官方库文件不支持修改。
- Pipeline 官方库自带多个日志样本测试数据，在「克隆」前可选择符合自身需求的日志样本测试数据。
- 克隆的 Pipeline 修改保存后， 日志样本测试数据同步保存。

![](../img/1-log-pipeline-1.png)

根据所选日志来源自动生成同名 pipeline 文件名称，点击「确定」后，即可创建一个自定义 pipeline 文件。

注意：DataKit 会自动获取官方库 pipeline 文件，若克隆的自定义 pipeline 文件与官方 pipeline 同名，此时 DataKit 会优先自动获取新建的自定义 pipeline 文件配置；若克隆的自定义 pipeline 文件与官方 pipeline 不同名，则需要在对应采集器的 pipeline 修改对应的 pipeline 的文件名称。

![](../img/6.log_pipeline_6.png)

创建完成后，可以在「日志」-「Pipelines」查看所有已经创建的自定义 pipeline 文件，支持对 pipeline 编辑/删除/启用 /禁用。

![](../img/6.log_pipeline_7.png)

## 注意事项

若您从未通过 DataKit 配置过日志采集器，在观测云工作空间创建了 pipeline 文件以后，您需要在您的主机上 [安装 DataKit](../../datakit/datakit-install.md)  ，且开启 pipeline 文件对应采集器的日志采集和 pipeline 功能。以 Nginx 为例，在 [Nginx 采集器](../../integrations/webserver/nginx.md) 中开启日志采集并开启 `pipeline = "nginx.p"`，开启完成后重启 DataKit 即可生效。

注意：`pipeline = "nginx.p" `中 `nginx.p` 可以不填，DataKit 会根据您选择的日志来源自动匹配您创建的日志 pipeline 文件。若日志来源和 pipeline 文件名称不一致，则需要在 `pipeline = "..."` 填入对应的 pipeline 文件名称，DataKit 会优先匹配用户自定义的 pipeline 文件。

```
    [[inputs.nginx]]
      ...
      [inputs.nginx.log]
		files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
	  pipeline = "nginx.p"
```



更多操作手册可参考文档 [日志 Pipeline 使用手册](manual.md) 和 [DataKit Pipeline 使用手册](datakit-manual.md) 。
