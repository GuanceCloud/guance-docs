# 标准用户访问监测（RUM）查看器使用介绍

## 进入查看器

访问左侧的用户访问监测，点击查看器选项。

![](../img/rum-1.png)

## 查看器类型

Session（会话）查看用户访问的一系列详情，包括用户访问时间、访问页面路径、访问操作数、访问路径和出现的错误信息等。

![](../img/rum-2.png)

> 关于 Session 的详细解释和使用，可参考文档 [Session（会话）](../../real-user-monitoring/explorer/session.md)。

View（页面）查看用户访问环境、回溯用户的操作路径、分解用户操作的响应时间以及了解用户操作导致后端应用一系列调用链的性能指标情况。

![](../img/rum-3.png)

> 关于 View 的详细解释和使用，可参考文档 [View](../../real-user-monitoring/explorer/view.md)。

Resource（资源）查看网页上加载的各种资源信息，包括状态码、请求方式、资源地址，加载耗时等。

![](../img/rum-4.png)

> 关于 Resource 的详细解释和使用，可参考文档 [Resource](../../real-user-monitoring/explorer/resource.md)。

Action（操作）查看用户在使用应用期间的操作交互，包括操作类型，页面操作详情，操作耗时等。

![](../img/rum-5.png)

> 关于 Action 的详细解释和使用，可参考文档 [Action](../../real-user-monitoring/explorer/action.md)。

Long Task（长任务）查看用户在使用应用期间，阻塞主线程超过 50ms 的长任务，包括页面地址、任务耗时等。

![](../img/rum-6.png)

> 关于 Long Task 的详细解释和使用，可参考文档 [Long Task](../../real-user-monitoring/explorer/long-task.md)。

Error（错误）查看用户在使用应用期间，浏览器发出的前端错误，包括错误类型、错误内容等。

![](../img/rum-7.png)

> 关于 Error 的详细解释和使用，可参考文档 [Error](../../real-user-monitoring/explorer/error.md)。

## 筛选

支持按照 `key:value` 的方式进行筛选。

### 正向筛选

正向筛选：`browser:Chrome` ，筛选出 `key=browser`、`value=Chrome` 的数据。

![](../img/rum-8.png)

### 反向筛选

反向筛选：`-browser:Chrome` ，排除 `key=browser`、`value=Chrome` 的数据。

![](../img/rum-9.png)

### 快捷筛选

左侧有默认的快捷筛选项，本质上就是 `key:value` 的筛选模式，可以直接勾选。

![](../img/rum-10.png)

- 默认是全选的状态
- 点击蓝色的勾，是取消此选项
- 点击右边的名称，是单选此选项

![](../img/rum-11.png)

单选后自动出现 `browser:Edge` 的正向筛选。

![](../img/rum-12.png)

取消勾选后自动出现 `-browser:Edge` 的反向筛选。

> 关于搜索和筛选的详细解释和使用，可参考文档 [搜索和筛选](../function-details/explorer-search.md)。

## 分组分析

查看器提供了分组分析的能力，用于快速定位分析整体数据。

如 <u>时序图、排行榜、饼图、矩形树图</u>。

![](../img/rum-13.png)

![](../img/rum-14.png)

![](../img/rum-15.png)

![](../img/rum-16.png)

### 数据关联分析

观测云提供强大的数据关联分析能力。

例如在 View 上点击任意一条内容，将可以看到 <u>性能、扩展字段 `Fetch/XHR` 错误</u> 等信息。

![](../img/rum-17.png)

![](../img/rum-18.png)

其中**性能扩展字段 `Fetch/XHR` 错误**是观测云系统内置的关联视图。

其他日志、网络、JVM 监控视图等是自定义关联视图。

### 自定义关联视图

观测云提供灵活的自定义关联视图能力，可以非常方便的将视图与指定的 `key:value` 做绑定。

进入**场景 > 仪表板**，选择希望绑定的仪表板，如**电商系统业务大盘**。

![](../img/rum-19.png)

点击上方**设置**按钮，再点击**保存到内置视图**。

![](../img/rum-20.png)

可以通过 `service`、`app_ip`、`source`、`project`、`label` 五个维度进行视图绑定。

![](../img/rum-21.png)

例如，需要将该视图绑定至拥有 `service:browser` 标签的数据上，则在绑定输入框中输入 `service:browser` 后按回车。

![](../img/rum-22.png)

回到**查看器**，点击 View 的任意一条日志。可以看到刚才自定义关联电商系统业务大盘的视图已经出现在这里了。

![](../img/rum-23.png)

> 仪表板及数据联动的详细解释和使用可以参考该文档 [仪表板](../function-details/dashboard.md)。
