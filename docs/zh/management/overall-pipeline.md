# 文本处理（Pipeline）

---

文本处理（Pipeline）用于数据解析，通过定义解析规则，将各种数据类型切割成符合我们要求的结构化数据。

## 前提条件

- [安装 DataKit](../datakit/datakit-install.md)
- DataKit 版本要求 >= 1.5.0

为了保证 Pipeline 的正常使用，请将 DataKit 升级到1.5.0及以上。版本过低会导致部分 Pipeline 功能失效。在 `DataKit<1.5.0`版本之前：

- 不支持默认 Pipeline 功能；

- 数据来源不支持多选，每个 Pipeline 只能选择一个source。所以若你版本低于 1.5.0，同时又多选了数据来源，则不会生效；

- Pipeline 名称为固定生成不支持修改。例如：日志来源选择了nginx，则 pipeline 名称固定为 nginx.p。所以若你版本低于 1.5.0，Pipeline 名称与数据来源名称不一致，则 Pipeline 不会生效；


## 新建 Pipeline

在观测云工作空间「管理」-「文本处理（Pipeline）」，点击「新建Pipeline」即可创建一个新的 pipeline 文件。或者您可以在指标、日志、用户访问、应用性能、基础设施、安全巡检功能目录快捷入口，点击「Pipelines」进行创建。

![](img/1-pipeline-2.png)

注意：pipeline 文件创建以后，需要安装 DataKit 才会生效，DataKit 会定时从工作空间获取配置的 pipeline 文件，默认时间为 1分钟，可在 `conf.d/datakit.conf` 中修改。

```
[pipeline]
  remote_pull_interval = "1m"
```

### 配置说明

在新建 Pipeline 页面，可以先「过滤」出想要进行文本处理的数据范围，然后再「定义解析规则」，若想要测试输入的解析规则是否正确有效，可以在「样本解析测试」输入对应的数据进行测试，测试通过后点击“保存”即可创建 pipeline 文件。

- 过滤：数据类型包括日志、指标、用户访问监测、应用性能监测、基础对象、自定义对象、网络、安全巡检。

注意：在观测云工作空间创建的 Pipeline 统一保存在 `<datakit 安装目录>/pipeline_remote 目录下` ，每种类型的 Pipeline 文件都保存在对应的二级目录下，其中一级目录下的文件默认为日志 Pipeline 。如指标 `cpu.p` 保存在 `<datakit 安装目录>/pipeline_remote/metric/cpu.p 目录下` ，详情可参考文档 [Pipeline 各类别数据处理](../developers/datakit-pl-global.md) 。

- 定义解析规则：定义解析规则，支持多种脚本函数，可通过观测云提供的脚本函数列表直接查看其语法格式，如 `add_pattern()` 等；
- 样本解析测试：输入数据，根据配置的解析规则进行测试；支持一键获取样本数据，支持添加多条样本数据（最多 3 条），点击“开始测试”后，返回多条测试结果；若您在同一个测试文本框中输入多条样本数据进行测试，只返回一条测试结果。

![](img/7.pipeline_1.png)

### 默认 Pipeline

您可在新建页面下方勾选设置 Pipeline 为默认 Pipeline。

**注意**：

- 每个类型只会有一个【默认 Pipeline】，新建/导入时出现重复会弹出确认框，询问是否进行替换。
- 若当前数据类型在匹配 Pipeline 处理时，未匹配到其他的 Pipeline 脚本，则数据会按照默认 Pipeline 脚本的规则处理。

返回 Pipeline 列表页，已勾选为默认的 pipeline 文件会有 “default” 标识。

![](img/1-pipeline-4.png)



### 调试 Pipeline {#test}

在 Pipeline 编辑页面，支持针对已填写的解析规则进行测试，只需要「样本解析测试」中输入数据进行测试，若解析规则不符合，则返回错误提示的结果。样本解析测试为非必填项，样本解析测试后，测试的数据同步保存。

官方支持一键获取样本测试数据，省去了手动输入的步骤。点击右上角的「一键获取」按钮，系统会从工作空间数据中按照你筛选的数据范围选取最新一条作为样本填入测试样本框内。但需要注意的是，每次只会查询最近6小时内的数据，若最近6小时无数据上报，则无法自动获取到。

注意：

- 日志数据可在样本解析测试中直接输入 message 内容进行测试，更多详情可参考文档 [日志 Pipeline 使用手册](../logs/pipelines/manual.md) ；

- 其他数据类型需要在样本解析测试中，将内容转换成“[行协议](../datakit/apis.md)”格式的内容进行测试；

  - 关于如何编写和调试解析规则，可参考文档 [如何编写 Pipeline 脚本](../developers/datakit-pl-how-to.md) 
  - 更多行协议数据的获取方式，可在`conf.d/datakit.conf` 中配置 `output_file` 的输出文件，并在该文件中查看行协议

  ```
  [io]
    output_file = "/path/to/file"
  ```

  

#### 行协议示例

![](img/5.pipeline_5.png)

**行协议说明：**

- cpu 、redis 为指标集；tag1、tag2 为标签集；f1、f2、f3 为字段集（其中 f1=1i 表示为 int，f2=1.2 表示默认为 float，f3="abc" 表示为 string）；162072387000000000 为时间戳；
- 指标集和标签集之间用逗号隔开；多个标签之间用逗号隔开；
- 标签集和字段集之间用空格隔开；多个字段之间用逗号隔开；
- 字段集和时间戳之间用空格隔开；时间戳必填；
- 若是对象数据，必须有 `name` 这个 tag，否则协议报错；最好有 `message` 字段，主要便于做全文搜索。

更多详情可参考文档 [DataKit API](../datakit/apis.md) 。

**调试示例：**

以下是一键获取的上报的指标数据样本，指标集为 cpu，标签为 cpu 和 host，从 usage_guest 到 usage_user 都为字段即指标数据，最后的 1667732804738974000 为时间戳。从返回结果可以很清楚的了解一键获取样本的数据结构。

![](img/7.pipeline_2.png)

## 操作 Pipeline

### 编辑/删除/启用/禁用

在观测云工作空间「管理」-「文本处理（Pipeline）」，点击右侧操作下的按钮即可对 pipeline 文件编辑/删除/启用/禁用。
注意：

- 编辑 pipeline 文件后，默认生效时间为 1 分钟；
- 删除 pipeline 文件后，无法恢复，需要重新创建；若存在同名的官方库 pipeline 文件，DataKit 会自动匹配官方库 pipeline 文件进行文本处理；
- 禁用 pipeline 文件后，可通过启用重新恢复；若存在同名的官方库 pipeline 文件，DataKit 会自动匹配官方库 pipeline 文件进行文本处理；

![](img/1-pipeline-1.png)

### 批量操作

在观测云工作空间「管理」-「文本处理（Pipeline）」，点击「批量操作」，即可「批量导出」或「批量删除」Pipelines。

???- attention

    该功能仅对工作空间拥有者、管理员、普通成员显示，只读成员不显示。

「批量操作」功能支持用户在 pipeline 文件列表中「批量导出」、「批量删除」。通过选定批量操作，您可以同时选定多个 pipeline 文件进行导出、删除。

### 导入/导出

在观测云工作空间「管理」-「文本处理（Pipeline）」中支持「导入/导出 Pipeline」，即通过导入/导出 JSON 文件的方式创建 Pipeline。

???- attention

    导入的 JSON 文件需要是来自观测云的配置 JSON 文件。

选定需要删除的 pipeline 文件，点击「确认删除」即可删除当前 pipeline 文件。

![](img/1-pipeline-3.png)

## 注意事项

Pipeline 可以对 DataKit 采集的数据执行如下操作：

- 新增、删除、修改 field 和 tag 的值或数据类型

- 将 field 变更为 tag

- 修改指标集名字

- 丢弃当前数据（`drop()`）

- 终止 Pipeline 脚本的运行（`exit()`）

  在用 Pipeline 对不同数据类型进行处理时，会对原有的数据结构产生影响，建议通过 [调试](../developers/datakit-pl-global/#examples) 确认数据处理结果符合预期后再进行使用。
