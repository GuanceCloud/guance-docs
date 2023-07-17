# 标准日志查看器使用介绍


## 进入日志 > 查看器

![](../img/0714-explorer-1.png)

![](../img/0714-explorer-2.png)

## 筛选

支持按照 `key:value` 的方式进行筛选。

- 正向筛选：`country:us`，筛选出 `key=country`、`value=us` 的数据。

![](../img/0714-explorer-3.png)

- 反向筛选：`-country:us`，排除 `key=country`、`value=us` 的数据。

![](../img/0714-explorer-4.png)

> 关于筛选的更多详细用法，可参考文档[筛选](../function-details/explorer-search.md#filter)。

## 搜索

单词搜索：搜索文本中包含 `replication` 关键词的内容。

![](../img/0714-explorer-5.png)

组合搜索：搜索出文本中包含 `replication` 关键词 且不包含 `section` 的内容。

![](../img/0714-explorer-6.png)

通配符搜索：搜索出 HTTP 开头的内容，通配符只支持 `右星号`，不支持 `左星号`。 

![](../img/0714-explorer-7.png)

> 关于搜索的更多详细用法，可参考文档[搜索](../function-details/explorer-search.md#search)。

## 快捷筛选
  
左侧有默认的快捷筛选项，本质上就是 `key:value` 的筛选模式，可以直接勾选。

![](../img/0714-explorer-8.png)

- 默认全选；
- 勾选某条选项：取消此选项；
- 点击选项右边名称：单选此选项。

![](../img/0714-explorer-9.png)

单选后自动出现 `host:yimeng-ubuntu-master1` 的正向筛选。

![](../img/0714-explorer-10.png)

取消勾选后自动出现 `-host:yimeng-ubuntu-master1` 的反向筛选。

## 分组分析
  
查看器提供了分组分析的能力，用于快速定位分析整体数据。
如<u>时序图、排行榜、饼图、矩形树图</u>。


![](../img/0714-explorer-11.png)

![](../img/0714-explorer-12.gif)


## 数据关联分析

观测云提供强大的数据关联分析能力。
  
点击任意一条内容，将可以看到<u>详情、扩展字段、关联视图 </u>等信息。

![](../img/0714-explorer-15.png)

![](../img/0714-explorer-16.png)

其中 <u>主机、容器、Pod、网络</u> 是观测云系统内置的关联视图。

其他 JVM 监控视图1111111、基础设施 Linux 主机监控视图 123 等是自定义关联视图。

![](../img/0714-explorer-17.png)

可以将此条日志与当时的主机监控数据进行关联查看，极大的缩短了问题定位的耗时。

## 自定义关联视图

观测云提供灵活的自定义关联视图能力，可以非常方便的将视图与指定的 `key:value` 做绑定。

进入**场景 > 仪表板**，选择希望绑定的仪表板，如**基础设施 Container 监控视图**。

![](../img/0714-explorer-18.png)

<img src="../../img/0714-explorer-19.png" width="70%" >

点击上方**设置**按钮，再点击**保存到内置视图**。

![](../img/0714-explorer-20.png)

可以通过 `service`、`app_ip`、`source`、`project`、`label` 五个维度进行视图绑定。

<img src="../../img/0714-explorer-21.png" width="70%" >

例如，需要将该视图绑定至拥有 `service:mysql` 标签的数据上，则在**绑定**输入框中输入 `service:mysql` 后按回车。

<img src="../../img/0714-explorer-22.png" width="70%" >

<img src="../../img/0714-explorer-23.png" width="70%" >

回到**日志查看器**，筛选 `service:mysql` 的服务后，点击任意一条日志。

![](../img/0714-explorer-24.png)

可以看到刚才自定义关联的视图已经出现在这里了。

![](../img/0714-explorer-25.png)
