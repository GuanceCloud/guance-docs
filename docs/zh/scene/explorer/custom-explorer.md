# 快速搭建自定义查看器
---

查看器作为数据可观测的重要工具，支持我们通过搜索、筛选等方式快速定位问题所在。<<< custom_key.brand_name >>>在原有查看器的基础上，**支持在场景处新建自定义查看器**。

自定义的查看器采用全新统一布局、响应式的配置模式和更科学的数据关联配置，您可以在自定义查看器中体验以下功能：

- 多个自定义图表显示设置；  
- 自定义快捷筛选字段；    
- 自定义列表默认显示列；    
- 绑定查看关联的内置视图。

## 开始创建

1、进入**场景 > 查看器**页面，点击**新建查看器**，进入创建页面。

**注意**：若在**日志 > 索引**设置索引以后，可以在自定义查看器选择不同的索引对应的日志内容。

<img src="../../img/1111.png" width="60%" >

> 更多详情，可参考 [日志索引](../../logs/multi-index/index.md)。

2、配置图表：

编辑模式下，支持最多添加 3 个统计类图表。

![](../img/2222.gif)

3、配置快捷筛选字段：

点击**快捷筛选**编辑按钮，添加字段和别名。

![](../img/3333.gif)

4、配置数据列表显示字段：

点击**列表**编辑按钮，编辑更新默认显示字段和别名。

![](../img/4444.gif)

5、创建完成后前往查看器列表查看即可。

在非编辑模式下，hover 在**数据范围**，您可以查看所有的筛选条件。

<img src="../../img/range.png" width="60%" >

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 通过自定义日志查看器定制化您的查看需求</font>](./index.md)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 如何绑定内置视图</font>](../built-in-view/bind-view.md)


</div>


</font>