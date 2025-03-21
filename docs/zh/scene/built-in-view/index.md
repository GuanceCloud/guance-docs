# 内置视图
---


内置视图为记录在<<< custom_key.brand_name >>>平台的视图模板，包括[**系统视图**](#system)和[**用户视图**](#user)两种类型，您能直接将系统视图应用于场景，也可以自定义为新的内置视图。


## 系统视图 {#system}

系统视图为<<< custom_key.brand_name >>>提供的官方视图模板，包括 Docker 监控视图、JVM 监控视图、Kafka 监控视图、Mysql Activity 监控视图、阿里云 Redis 监控视图等，支持您一键创建，及时开启针对监控对象的数据洞察。

    
![](../img/4.view_1_1.png)

系统视图支持在**场景**中，通过**内置模板库**直接新建一个系统视图模板为仪表板。如若需要对该模板进行自定义修改，您可以对已经添加到仪表板的系统视图进行自定义修改。

- 点击进入**场景 > 内置视图 > 系统视图**页面，您可以通过**克隆**按钮，将当前视图创建为新仪表板或新用户视图。

<img src="../img/4.view_1.png" width="60%" >

- 在**场景 > 内置视图 > 系统视图**，您可导出某特定视图。



**注意**：除了<<< custom_key.brand_name >>>本身在查看器绑定的系统视图以外，若有其他系统视图曾经被绑定为查看器的视图，支持删除绑定关系。
    


## 用户视图 {#user}

用户视图为用户自定义视图后保存作为模板使用的视图，支持新建、修改，导出、克隆和删除，支持编辑绑定链路服务、应用、日志源、项目、标签等关联在查看器绑定相关视图。

> 具体操作，可参考 [绑定内置视图](../../scene/built-in-view/bind-view.md)。

**注意**：目前<<< custom_key.brand_name >>>仅支持手动绑定用户视图为查看器的视图，若需要绑定系统视图，需要先克隆系统视图为用户视图，若系统视图和用户视图重名，在查看器优先显示用户视图。
    
![](../img/4.view_3.png)

- 新建用户视图：点击**新建用户视图**即可创建用户自定义视图模板；
- 编辑：用户视图支持重新编辑名称或者绑定链路服务、应用、日志源、项目等关联。通过点击视图右上角的下拉按钮，选择**编辑**即可；
- 克隆：用户视图支持克隆为一个新的**用户视图**，通过选定需要克隆的用户视图， 点击视图右上角的下拉按钮，并选择“克隆视图”，输入用户视图名称后即可在当前列表下生成一个内容相同、名称不同的新视图；
- 导出：支持对已创建的用户视图进行导出，点击**导出视图**可直接导出为 JSON 文件，用于不同工作空间的场景或内置视图导入；
- 删除：选定需要删除的用户视图，通过点击视图右上角的下拉按钮，选择**删除**即可删除该视图。

**注意**：

- 同一个工作空间下用户视图不允许重名；
- 用户视图的新增、修改、克隆、删除等操作仅支持标准成员、管理员和拥有者。

## 相关操作

### 导出视图 JSON

<<< custom_key.brand_name >>>可以通过将视图直接导出为 JSON 文件，导出的 JSON 文件可用于不同工作空间的场景仪表板或用户视图的导入。

在<<< custom_key.brand_name >>>工作空间**管理 > 内置视图 > 系统视图/用户视图**，在设置下选择**导出视图 JSON** 即可生成一份 JSON 文件；

![](../img/3.view_2.png)


### 导入视图 JSON

在进行自定义用户视图时，<<< custom_key.brand_name >>>支持导入 JSON 文件为新的视图模板。点击**导入视图 JSON**：

![](../img/3.view_4.png)

**注意**：

- 导入视图 JSON 文件时会覆盖原有视图，一经覆盖无法恢复，请谨慎操作；
- 导入视图 JSON 仅支持用户视图，系统视图无法导入视图 JSON 文件。


### 导出到仪表板

<<< custom_key.brand_name >>>用户视图可以直接导出视图到场景仪表板。在设置下选择**导出至仪表板**；


![](../img/3.view_3.png)

输入仪表板名称，选择自定义标签（用来筛选仪表板），点击确定即可。

![](../img/3.view_6.png)


### pin

在当前访问工作空间被授权查看若干其他工作空间数据的前提下，可选择 pin 住被授权的工作空间 A，从而该工作空间 A 将会被设置为查询视图数据的默认工作空间。

<img src="../img/view-pin.png" width="60%" >

同时，若查看器详情页处若绑定了此用户视图，则默认按照 pin 住的工作空间数据做查询展示。如下图：

![](../img/pin-example.png)



