# 拓扑图

为了增强仪表板的可视化效果，<<< custom_key.brand_name >>>根据现有的服务拓扑以及资源调用图进行组件化。可用于展示不同事物之间的关系和相对位置。



## 图表查询

### 服务关系图

<img src="../../img/resource-chart.png" width="70%" >

1. 服务名：可选择所有相关的视图变量或具体的值；
2. 颜色填充：包含请求数、P50 响应时间、P75 响应时间、P99 响应时间和错误率；
3. 筛选：可选 `env`、`version`、`project`、`source_type` 四种字段。

点击服务图标，即可查看当前服务的上下游关联、服务概览、日志等信息。

<img src="../../img/chart-relate.png" width="70%" >

> 此处同样支持 [Service Map 跨工作空间查询](../../application-performance-monitoring/service-manag/service-map.md##servicemap)。



### 资源关系图

<img src="../../img/service-chart.png" width="70%" >

1. 服务名：可选择所有相关的视图变量或具体的值；
2. 资源名：可选择所有相关的视图变量或具体的值；
3. 颜色填充：包含 P99 响应时间、请求错误率、事件状态；
4. 筛选：可选 `env`、`version` 两种字段。

???+ warning "注意"

    资源关系图仅支持针对单个资源进行绘制。因此，当**资源名**选择了单个值，此时服务名也需为单个值。若服务名选择了某个视图变量且该变量包含多个值，此时图表会报错。

点击资源图标，即可查看当前资源相关的日志、用户访问、事件等信息。

<img src="../../img/chart-relate-1.png" width="70%" >


### 外部数据查询

通过外部数据查询的方式，只需按照系统规定的数据结构上报数据，您就可以使用任意数据来绘制拓扑图，并通过本地 Function 函数实现最终图表的生成与展示。

<img src="../../img/chart-relate-2.png" width="70%" >

> 关于如何通过函数处理数据，可查看 [Func 函数详细使用说明与示例](../../studio-backend/tracing-service-map.md)。
> 
> 关于对接数据所需的拓扑图数据结构，可查看 [相关接口响应数据说明](../../studio-backend/tracing-service-map.md)。


## 图表配置

> 更多详情，可参考 [图表配置](./chart-config.md)。

