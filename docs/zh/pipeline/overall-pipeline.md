# 管理 Pipelines

---


## 编辑/删除/启用/禁用

在观测云工作空间**管理 > Pipelines**，点击右侧操作下的按钮即可对 Pipeline 文件编辑/删除/启用/禁用。

???+ warning "注意"

    - 编辑 Pipeline 文件后，默认生效时间为 1 分钟； 
    - 删除 Pipeline 文件后，无法恢复，需要重新创建；若存在同名的官方库 Pipeline 文件，DataKit 会自动匹配官方库 Pipeline 文件进行文本处理；  
    - 禁用 Pipeline 文件后，可通过启用重新恢复；若存在同名的官方库 Pipeline 文件，DataKit 会自动匹配官方库 Pipeline 文件进行文本处理。

![](img/1-pipeline-1.png)

## 批量操作

**批量操作**功能支持用户在 Pipeline 文件列表中**批量导出**、**批量删除**。通过选定批量操作，您可以同时选定多个 Pipeline 文件进行导出、删除。

在观测云工作空间**管理 > Pipelines**，点击**批量操作**，即可**批量导出**或**批量删除** Pipelines。

**注意**：该功能仅对工作空间拥有者、管理员、标准成员显示，只读成员不显示。


## 导入/导出

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
