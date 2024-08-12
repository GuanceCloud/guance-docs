# 模板管理
---



模板管理页面支持查看、搜索及导入观测云所有内置的模板项目。

![](img/18.deployment_2.png)


## 相关操作

1. 您可直接根据分类或语言对模版进行筛选过滤；在搜索框，可直接输入关键词进行搜索定位；
2. 点击批量操作，可批量删除选中的模版；也可直接点击模版右侧删除按钮进行操作；

![](img/deployment-1.png)


### 导入模版

**模版管理**这一功能分为两个版本：部署版用户未更新前使用的版本 [1.89.169](./changelog.md#626) 与更新后的版本。基于不同的版本，在做导入这一动作时，针对不同的模版类型会存在些许差异。

目前两个版本均支持导入四类模版：**内置视图、检测库、自定义查看器、Pipeline**。

<img src="../img/deployment-2.png" width="70%" >

#### 版本更新前

- 选择不同的模版类型时，可直接在导入配置页面 > 分类下拉列表右侧下载模版；
- 检测库和 Pipeline 这两种类型导出模版后，需根据官方模板按规范编辑 JSON 文件后才可使用。

???- warning "编辑示意"

    :material-numeric-1-circle-outline: 检测库：

    <img src="../img/detection-template.png" width="60%" >

    1. `checkers`：需替换成导出的监控器模板；
    2. `title`：必填；检测库名称；
    3. `summary`：非必填；检测库描述；
    4. `iconSet`：非必填；检测库 logo 链接，不配置则显示官方默认 logo；
    5. `thumbnail`：不需要配置，但不能删除，删除后将无法导入。


    :material-numeric-2-circle-outline: Pipeline (仅支持日志 Pipeline)：

    <img src="../img/pipeline-template.png" width="60%" >

    1. `pipeline` 名称；格式：xxxx.p；
    2. `pipeline`：必填；解析规则（需输入 Base64 加密后的文本）；
    3. `examples`：非必填；示例样本，支持配置多个（需输入 Base64 加密后的文本）。

#### 版本更新后

四类模版均可以直接从前端控制台导出和从管理后台导入。

**注意**：文件支持一次性上传多个。

:material-numeric-1-circle-outline: 内置视图：可在控制台 > 仪表板/用户视图创建导出。 

:material-numeric-2-circle-outline: 自定义查看器：可在控制台 > 场景 > 查看器创建导出。 

:material-numeric-3-circle-outline: 检测库：观测云的[检测库](../monitoring/monitor/template.md)内包含多种监控器规则模版。支持在监控器列表[导出](../monitoring/monitor/index.md#options)。

可直接导入一个或多个监控器模板，其中检测库名称不允许重复，但监控器内不作限制。 


:material-numeric-4-circle-outline: Pipeline：支持多种类型，包括日志/指标/用户访问等。

在导入过程中，同一类型的 Pipeline 名称不能重复。导入成功后，可在模板列表的描述中查看 Pipeline 类型。如果导入的 Pipeline 模板中含有测试样本数据，将显示在官方库模板详情的 `testData` 中。

???- warning "导出示意"

    <img src="../img/pipeline-template-1.png" width="60%" >

    1. `category`：数据类型；支持导入非日志模板；  
    2. `name`：Pipeline 名称；  
    3. `content`：Pipeline 脚本内容；  
    4. `testData`：非必填；测试样本。 

导入成功后，列表的描述中会自动识别并填入 Pipeline 类型，并区分中英文。

![](img/deployment-3.png)

