# 数据转发
---


???- quote "更新日志"

    **2023.11.2**：
    
    1. 支持将数据保存到观测云侧的 OSS、S3、OBS 数据存储库；
    2.【数据转发】导航位置调整至【管理】模块，仍可通过原【日志】、【用户访问监测】、【应用性能监测】的导航栏二级菜单进入。

    **2023.9.26**：数据转发规则查询支持 RUM、APM 数据。

    **2023.9.21**：新增外部存储转发规则数据查询入口；支持启用/禁用转发规则。

    **2023.9.7**：原【备份日志】正式更名为【数据转发】。

观测云提供日志、链路和用户访问数据保存到观测云的对象存储及转发到外部存储的功能，您可以自由选择存储对象，灵活管理数据转发数据。

在数据转发页面，您可以通过设置查询时间和数据转发规则快速查询存储数据（包含观测云备份日志、AWS S3、华为云 OBS、阿里云 OSS 和 Kafka 消息队列），还可以查看观测云历史备份日志和 SLS Query Logstore 数据。

## 前提条件

观测云商业版用户可使用数据转发功能，[体验版](../../plans/trail.md)用户需先[升级商业版](../../plans/trail.md#upgrade-commercial)。

## 新建规则

进入**数据转发**页面，点击**转发规则 > 新建规则**。

![](../img/5.log_backup_1.png)

![](../img/back-5.png)

**注意**：数据转发规则创建完成后，每 5 分钟执行一次规则校验。  


### 输入规则名称

![](../img/back-9.png)

在弹出的对话框，输入**规则名称**即可添加一条新的规则：

| 字段      | 描述     | 
| ------------- | -------------- |
| 规则名称 | 限制最多输入 30 个字符。 |
| 包含扩展字段      | 默认情况下仅转发符合条件日志的 `message` 字段内容信息。若勾选 “包含扩展字段”，符合条件的整条日志数据都会被转发。应用性能和用户访问数据默认转发整条数据，不受此选项影响。<br/>:warning: 若创建多个数据转发规则，则优先匹配勾选包含扩展字段的规则，即若不同的规则命中同一条数据，则优先按照同步包含扩展字段的逻辑展示整条日志数据。     |


### 定义过滤条件

![](../img/back-1.png)

:material-numeric-1-circle-outline: 数据源：日志、链路、用户访问。

:material-numeric-2-circle-outline: 过滤条件：支持自定义条件间的运算逻辑，您可以选择**所有条件**、**任意条件**：

- 所有条件：匹配所有过滤条件都满足的日志数据才会被保存到数据转发；

- 任意条件：任意一个过滤条件满足即可被保存到数据转发。

**注意**：不添加过滤条件即表示保存全部日志数据；您可以添加多条过滤条件。

条件运算符见下表：

| 条件运算符      | 匹配类型     | 
| ------------- | -------------- | 
| in、not in      | 精确匹配，支持多值（逗号隔开） | 
| match、not match | 模糊匹配，支持输入正则语法 | 


### 选择存档类型


???- warning "注意"

    五种存档类型全站点开放。

    <img src="../img/back-4.png" width="70%" >

为提供更加全面的数据转发存储方式，观测云支持以下五种存储路径：

:material-numeric-1-circle: 观测云：

![](../img/backup-guance.png)

当选择数据转发存储对象为观测云，匹配到的日志数据将被保存到**观测云侧的 OSS、S3、OBS 对象存储**中。

该规则下的日志数据最低存储默认为 180 天，规则一旦创建无法取消，存储期间会每天收取费用；您可以前往**管理 > 设置 > 变更数据存储策略**中修改数据转发存储策略。

:material-numeric-2-circle: [AWS S3](./backup-aws.md)；

:material-numeric-3-circle: [华为云 OBS](./backup-huawei.md)；

:material-numeric-4-circle: [阿里云 OSS](./backup-ali.md)；

:material-numeric-5-circle: [Kafka 消息队列](./backup-kafka.md)。




## 查看转发规则

规则创建完成后，自动进入转发规则列表：

![](../img/rule-update.png)

:material-numeric-1-circle-outline: 支持输入规则名称进行搜索； 

:material-numeric-2-circle-outline: 您可以选择启用、禁用当前规则；

:material-numeric-3-circle-outline: 点击规则右侧 :material-text-search: 、编辑、 :fontawesome-regular-trash-can: 按钮，即可进行相应操作。

**注意**：

- 编辑模式下，**访问类型**和**地区**不支持调整；选择**观测云**存储的规则，编辑和查看内容一致；

- 规则删除后已转发的数据不会被删除，但不再产生新的转发数据。

:material-numeric-4-circle-outline: 您可以选中多个规则进行批量操作。

![](../img/rule-update-1.png)

### 转发规则查看器 {#explorer}

回到**数据转发**页面，默认进入**转发规则** tab 页。首先在下拉框选定规则，您可以自定义时间范围查询，可选择多个日期及定义开始时间和结束时间，时间会精确到小时：

![](../img/rule-update-3.png)

**注意**：

- 您可以输入关键字来搜索查询匹配数据； 
- 时间控件默认为空，选定日期后再选择小时。会根据转发规则列出可点击的小时选项；   
- 当您选择了未来的时间范围，系统会自动更正为当前日期；

<img src="../img/rule-update-4.png" width="60%" >

- 观测云会根据选中的时间按批次获取文件搜索匹配数据，每批返回 50 条数据。**首次查询若未查到数据，或返回的数据未满足每页 50 条的要求**，您可以手动点击**继续查询**直至扫描完成。
- 由于查询到的数据为乱序状态，您可以针对列出的数据的时间范围做排序。此行为不会影响数据查询结果。


在**索引**下，您可以查看观测云历史备份日志和 SLS Query Logstore 数据：

![](../img/rule-update-2.png)

> 关于查看器具体操作，可参考 [查看器的强大之处](../../getting-started/function-details/explorer-search.md)。

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 数据转发计费逻辑</font>](../../billing/billing-method/billing-item.md#backup)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 日志数据转发到 OSS 最佳实践</font>](../../best-practices/partner/log-backup-to-oss-by-func.md)

</div>

</font>