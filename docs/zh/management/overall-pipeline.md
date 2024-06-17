# Pipelines

---

Pipelines 用于数据解析，通过定义解析规则，将各种数据类型切割成符合我们要求的结构化数据。如通过 Pipeline 提取日志的时间戳、日志的状态、以及其他特定的字段作为标签。

## 前提条件

- [安装 DataKit](../datakit/datakit-install.md)；
- DataKit 版本要求 >= 1.5.0。

为了保证正常使用 Pipeline，请将 DataKit 升级到 1.5.0 及以上。版本过低会导致部分 Pipeline 功能失效。

在 `DataKit<1.5.0` 版本之前：

- 不支持默认 Pipeline 功能；

- 数据来源不支持多选，每个 Pipeline 只能选择一个 `source`。所以若您的版本低于 1.5.0，同时又多选了数据来源，则不会生效；

- Pipeline 名称为固定生成不支持修改。例如：日志来源选择了 `nginx`，则 Pipeline 名称固定为 `nginx.p`。所以若您的版本低于 1.5.0，Pipeline 名称与数据来源名称不一致，则 Pipeline 不会生效。

## 新建 Pipeline

在观测云工作空间**管理 > Pipelines**，点击**新建 Pipeline** 即可创建新文件。或者您可以在指标、日志、用户访问、应用性能、基础设施、安全巡检功能目录快捷入口，点击 **Pipelines** 进行创建。

![](img/1-pipeline-2.png)

**注意**：Pipeline 文件创建以后，需要安装 DataKit 才会生效，DataKit 会定时从工作空间获取配置的 Pipeline 文件，默认时间为 1 分钟，可在 `conf.d/datakit.conf` 中修改。

```
[pipeline]
  remote_pull_interval = "1m"
```

### 配置说明

在新建 Pipeline 页面，可以先**过滤**出想要进行文本处理的数据范围，然后再**定义解析规则**，若想要测试输入的解析规则是否正确有效，可以在**样本解析测试**输入对应的数据进行测试，测试通过后点击**保存**即可创建 Pipeline 文件。

![](img/7.pipeline_1.png)

:material-numeric-1-circle: 基础设置

- 过滤：数据类型包括日志、指标、用户访问监测、应用性能监测、基础对象、自定义对象、网络、安全巡检，支持多选；  
- Pipeline 名称：输入自定义的 Pipeline 文件名。

**注意**：自定义 Pipeline 文件不能同名，但可以和官方 Pipeline 同名，此时 DataKit 会优先自动获取自定义 Pipeline 文件配置。若在采集器的 `.conf` 文件中手动配置 Pipeline 文件名，此时 DataKit 会优先获取手动配置的 Pipeline 文件名。

- 设置为默认 Pipeline：勾选**设置为默认 Pipeline**，若当前数据类型在匹配 Pipeline 处理时，未匹配到其他的 Pipeline 脚本，则数据会按照默认 Pipeline 脚本的规则处理。

**注意**：每个数据类型只能设置一个默认 Pipeline，新建/导入时出现重复会弹出确认框，询问是否进行替换，已勾选为默认的 Pipeline，名称后会有一个 `default` 标识。

:material-numeric-2-circle: 定义解析规则

定义不同来源数据的解析规则，支持多种脚本函数，可通过观测云提供的脚本函数列表直接查看其语法格式，如 `add_pattern()` 等。

> 关于如何定义解析规则，可参考 [Pipeline 手册](../developers/pipeline.md)。

:material-numeric-3-circle: 样本解析测试

根据选择的数据类型，输入对应的数据，基于配置的解析规则进行测试。

- 点击**一键获取样**可自动获取已经采集的数据； 
- 点击**添加**可添加多条样本数据（最多 3 条）；
- 点击**开始测试**，返回多条测试结果；若您在同一个测试文本框中输入多条样本数据进行测试，只返回一条测试结果。

**注意**：在观测云工作空间创建的 Pipeline 统一保存在 `<datakit 安装目录>/pipeline_remote 目录下` ，每种类型的 Pipeline 文件都保存在对应的二级目录下，其中一级目录下的文件默认为日志 Pipeline。如指标 `cpu.p` 保存在 `<datakit 安装目录>/pipeline_remote/metric/cpu.p 目录下`。

> 更多详情，可参考 [Pipeline 各类别数据处理](../developers/datakit-pl-global.md)。



### 调试 Pipeline {#test}

在 Pipeline 编辑页面，支持针对已填写的解析规则进行测试，只需要**样本解析测试**中输入数据进行测试，若解析规则不符合，则返回错误提示的结果。样本解析测试为非必填项，样本解析测试后，测试的数据同步保存。

#### 一键获取样本测试

观测云支持一键获取样本测试数据，在创建/编辑 Pipeline 时，点击**样本解析测试**下的的**一键获取样**，系统会自动从已采集上报到工作空间的数据中，按照筛选的数据范围选取最新的一条数据，作为样本填入测试样本框内进行测试。一键获取样本数据时，每次只会查询最近6小时内的数据，若最近6小时无数据上报，则无法自动获取到。

*调试示例：*

以下是一键获取的上报的指标数据样本，指标集为 `cpu`，标签为 `cpu` 和 `host`，从 `usage_guest` 到 `usage_user` 都为字段即指标数据，最后的 1667732804738974000 为时间戳。从返回结果可以很清楚的了解一键获取样本的数据结构。

![](img/7.pipeline_2.png)

#### 手动输入样本测试

您也可以直接手动输入样本数据进行测试，观测云支持两种格式类型：

- 日志数据可在样本解析测试中直接输入 `message` 内容进行测试；
- 其他数据类型先将内容转换成“行协议”格式的内容，再输入进行样本解析测试。
  
> 更多日志 Pipeline 详情，可参考 [日志 Pipeline 使用手册](../logs/pipelines/manual.md)。

##### 行协议示例

![](img/5.pipeline_5.png)


- `cpu`、`redis` 为指标集；tag1、tag2 为标签集；f1、f2、f3 为字段集（其中 f1=1i 表示为 int，f2=1.2 表示默认为 float，f3="abc" 表示为 string）；162072387000000000 为时间戳；    
- 指标集和标签集之间用逗号隔开；多个标签之间用逗号隔开； 
- 标签集和字段集之间用空格隔开；多个字段之间用逗号隔开；      
- 字段集和时间戳之间用空格隔开；时间戳必填；           
- 若是对象数据，必须有 `name` 标签，否则协议报错；最好有 `message` 字段，主要便于做全文搜索。

> 更多行协议详情，可参考 [DataKit API](../datakit/apis.md)。

更多行协议数据的获取方式，可在 `conf.d/datakit.conf` 中配置 `output_file` 的输出文件，并在该文件中查看行协议。

  ```
  [io]
    output_file = "/path/to/file"
  ```


#### 终端命令行调试

除了在观测云控制台调试 Pipeline 以外，您也可以通过终端命令行来调试 Pipeline。

> 更多详情，可参考 [如何编写 Pipeline 脚本](../developers/datakit-pl-how-to.md)。

### 配置示例

> 更多 Pipeline 的配置示例相关，可参考 [日志 Pipeline 使用手册](../logs/pipelines/manual.md)、[DataKit Pipeline 使用手册](../logs/pipelines/datakit-manual.md)。

## 管理 Pipeline

### 编辑/删除/启用/禁用

在观测云工作空间**管理 > Pipelines**，点击右侧操作下的按钮即可对 Pipeline 文件编辑/删除/启用/禁用。

???+ warning "注意"

    - 编辑 Pipeline 文件后，默认生效时间为 1 分钟； 
    - 删除 Pipeline 文件后，无法恢复，需要重新创建；若存在同名的官方库 Pipeline 文件，DataKit 会自动匹配官方库 Pipeline 文件进行文本处理；  
    - 禁用 Pipeline 文件后，可通过启用重新恢复；若存在同名的官方库 Pipeline 文件，DataKit 会自动匹配官方库 Pipeline 文件进行文本处理。

![](img/1-pipeline-1.png)

### 批量操作

**批量操作**功能支持用户在 Pipeline 文件列表中**批量导出**、**批量删除**。通过选定批量操作，您可以同时选定多个 Pipeline 文件进行导出、删除。

在观测云工作空间**管理 > Pipelines**，点击**批量操作**，即可**批量导出**或**批量删除** Pipelines。

**注意**：该功能仅对工作空间拥有者、管理员、标准成员显示，只读成员不显示。


### 导入/导出

在观测云工作空间**管理 > Pipelines**中支持**导入/导出 Pipeline**，即通过导入/导出 JSON 文件的方式创建 Pipeline。

**注意**：导入的 JSON 文件需要是来自观测云的配置 JSON 文件。

选定需要删除的 Pipeline 文件，点击**确认**即可删除当前 Pipeline 文件。

![](img/1-pipeline-3.png)

## Pipeline 官方库

观测云为日志数据提供标准的 Pipeline 官方库，帮助您快速结构化您的日志数据。

在观测云工作空间**日志 > Pipelines**，点击 **Pipeline 官方库**即可查看内置标准的 Pipeline 官网文件库，包括 nginx、apache、redis、elasticsearch、mysql 等。

![](img/2.pipeline_1.png)

选择打开任意一个 Pipeline 文件，如 `apache.p`，可以看到内置的解析规则，如果需要自定义修改，可以点击右上角的**克隆**。

???+ warning "注意"

    - Pipeline 官方库文件不支持修改；  
    - Pipeline 官方库自带多个日志样本测试数据，在**克隆**前可选择符合自身需求的日志样本测试数据；  
    - 克隆的 Pipeline 修改保存后，日志样本测试数据同步保存。

![](img/2.pipeline_2.png)

根据所选日志来源自动生成同名 Pipeline 文件名称，点击**确定**后，即可创建一个自定义 Pipeline 文件。

**注意**：DataKit 会自动获取官方库 Pipeline 文件，若克隆的自定义 Pipeline 文件与官方 Pipeline 同名，此时 DataKit 会优先自动获取新建的自定义 Pipeline 文件配置；若克隆的自定义 Pipeline 文件与官方 Pipeline 不同名，则需要在对应采集器的 Pipeline 修改对应的 Pipeline 的文件名称。

![](img/2.pipeline_3.png)

创建完成后，可以在**日志 > Pipelines** 查看所有已经创建的自定义 Pipeline 文件，支持对 Pipeline 编辑/删除/启用/禁用。

![](img/2.pipeline_4.png)

## 注意事项

Pipeline 可以对 DataKit 采集的数据执行如下操作：

- 新增、删除、修改 field 和 tag 的值或数据类型；

- 将 field 变更为 tag；

- 修改指标集名字；

- 丢弃当前数据（`drop()`）；

- 终止 Pipeline 脚本的运行（`exit()`）。

在用 Pipeline 对不同数据类型进行处理时，会对原有的数据结构产生影响，建议通过 [调试](../developers/datakit-pl-how-to.md) 确认数据处理结果符合预期后再进行使用。
