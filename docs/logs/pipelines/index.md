# 日志 Pipelines

---

在观测云的日志管理中，可以通过 Pipelines 对日志的文本内容进行切割，将格式各异的日志切割成符合我们要求的结构化数据，如日志的时间戳、日志的状态、以及提取出特定的字段作为标签等。

![](../img/6.log_pipeline_1.png)

## 新建 Pipeline

在观测云工作空间「日志」-「Pipelines」，点击「新建Pipeline」，选择「过滤日志」，填入「定义解析规则」，然后在「日志样本测试」输入日志数据进行测试，测试通过后点击「保存」即可创建一个新的 pipeline 文件。

注意：pipeline 文件创建以后，需要安装 DataKit 才会生效，DataKit 会定时从工作空间获取配置的 pipeline 文件，默认时间为 1分钟，可在 `conf.d/datakit.conf` 中修改。

```
[pipeline]
  remote_pull_interval = "1m"
```

- 过滤日志：根据所选日志来源自动生成同名 Pipeline，也可以直接输入自定义的 pipeline 文件名；
- 定义解析规则：定义日志的解析规则，支持多种脚本函数，可通过观测云提供的脚本函数列表直接查看其语法格式，如`add_pattern()`等。关于如何定义解析规则，可参考文档 [文本数据处理（Pipeline）](../../developers/pipeline.md) ；
- 日志样本测试：输入日志数据，根据配置的解析规则进行测试，支持「一键获取」已经采集的日志数据样本。

注意：自定义 pipeline 文件不能同名，但可以和官方 pipeline 同名，此时 DataKit 会优先自动获取自定义 pipeline 文件配置。若在日志采集器 `.conf` 中手动配置 pipeline 文件，此时 DataKit 会优先获取手动配置的 pipeline 文件。

![](../img/6.log_pipeline_2.png)

### 调试 Pipeline {#test}

在新建 Pipeline 页面，选择「过滤日志」，填入「定义解析规则」，然后在「日志样本测试」直接输入或通过「一键获取」日志数据进行测试，若解析规则不符合，则返回错误提示的结果，若解析规则符合要求，则返回解析处理后日志数据结果。
注意：

- 日志样本测试为非必填项
- 自定义 Pipeline 保存后， 日志样本测试数据同步保存。

![](../img/6.log_pipeline_3.png)

## 编辑/删除/启用/禁用 Pipeline

在观测云工作空间「日志」-「Pipelines」，点击右侧操作下的按钮即可对 pipeline 文件编辑/删除/启用/禁用。
注意：

- 编辑 pipeline 文件后，默认生效时间为 1 分钟；
- 删除 pipeline 文件后，无法恢复，需要重新创建；若存在同名的官方库 pipeline 文件，DataKit 会自动匹配官方库 pipeline 文件进行文本处理；
- 禁用 pipeline 文件后，可通过启用重新恢复；若存在同名的官方库 pipeline 文件，DataKit 会自动匹配官方库 pipeline 文件进行文本处理；

![](../img/6.log_pipeline_1.png)

## Pipeline 官方库

在观测云工作空间「日志」-「Pipelines」，点击「Pipeline 官方库」即可查看内置标准的 pipeline 官网文件库，包括如 nginx、apache、redis、elasticsearch、mysql 等。

![](../img/6.log_pipeline_4.png)

选择打开任意一个 pipeline 文件，如 apache.p ，可以看到内置的解析规则，如果需要自定义修改，可以点击右上角的「克隆」。
注意：

- pipeline 官方库文件不支持修改。
- Pipeline 官方库自带多个日志样本测试数据，在「克隆」前可选择符合自身需求的日志样本测试数据。
- 克隆的 Pipeline 修改保存后， 日志样本测试数据同步保存。

![](../img/6.log_pipeline_5.png)

根据所选日志来源自动生成同名 pipeline 文件名称，点击「确定」后，即可创建一个自定义 pipeline 文件。

注意：DataKit 会自动获取官方库 pipeline 文件，若克隆的自定义 pipeline 文件与官方 pipeline 同名，此时 DataKit 会优先自动获取新建的自定义 pipeline 文件配置；若克隆的自定义 pipeline 文件与官方 pipeline 不同名，则需要在对应采集器的 pipeline 修改对应的 pipeline 的 `.p` 文件名称。

![](../img/6.log_pipeline_6.png)

创建完成后，可以在「日志」-「Pipelines」查看所有已经创建的自定义 pipeline 文件，支持对 pipeline 编辑/删除/启用 /禁用。

![](../img/6.log_pipeline_7.png)

## 注意事项

若您从未通过 DataKit 配置过日志采集器，在观测云工作空间创建了 pipeline 文件以后，您需要在您的主机上 [安装 DataKit](../../datakit/datakit-install.md)  ，且开启 pipeline 文件对应采集器的日志采集和 pipeline 功能。以 Nginx 为例，在 [Nginx 采集器](../../integrations/webservice/nginx.md) 中开启日志采集并开启 `pipeline = "nginx.p"`，开启完成后重启 DataKit 即可生效。

注意：`pipeline = "nginx.p" `中 `nginx.p` 可以不填，DataKit 会根据您选择的日志来源自动匹配您创建的日志 pipeline 文件。若日志来源和 pipeline 文件名称不一致，则需要在 `pipeline = "..."` 填入对应的 pipeline 文件名称。

```
    [[inputs.nginx]]
      ...
      [inputs.nginx.log]
		files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
	  pipeline = "nginx.p"
```



更多操作手册可参考文档 [日志 Pipeline 使用手册](manual.md) 和 [DataKit Pipeline 使用手册](datakit-manual.md) 。
