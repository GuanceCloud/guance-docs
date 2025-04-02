# 仪表板
---


**仪表板**将功能相关的可视化报表同时展示在同一界面，通过多维度数据分析构建数据洞察场景。您可通过自定义新建空白仪表板或导入自定义模板开始构建可视化场景，借助添加图表、时间控件、关键词搜索、标签过滤等方式全面监控不同来源的数据指标。

## 开始新建

您可以通过三种方式创建一个仪表板。

:material-numeric-1-circle: 直接创建[空白仪表板](#blank)；

:material-numeric-2-circle: 导入[自定义模版](#custom)；

:material-numeric-3-circle: 在[内置模版库](#view)选择视图。

### 空白仪表板 {#blank}

![](../img/blank_dashboard.png)

1. 定义当前仪表板的名称；
2. 定义该仪表板的标识 ID；
3. 按需输入针对该仪表板的描述内容；
4. 选择[标签](../../management/global-label.md)，便于后续分组管理；
5. 选择当前仪表板的[可见范围](#range)；
6. 点击确定，即可创建成功。

#### 标识 ID

该 ID 被定义为 `identifier`，用于确定仪表板或视图的唯一性。

##### 应用场景

可用于配置图表的[跳转链接](../visual-chart/chart-link.md)，从而实现唯一确定性定位。

:material-numeric-1-circle-outline:：定义仪表板的标识 ID 为 `abc`。在最终导出的 [JSON 文件](./config_list.md#options)中，参数为：`"identifier": "abc"`

<img src="../img/identifier.png" width="60%" >

:material-numeric-2-circle-outline:：为图表配置跳转链接时，添加标识 ID 为 `abc` 的仪表板链接为：

```
/scene/dashboard/dashboardDetail?identifier=abc
```

除仪表板外，视图同样适用：

```
// type 字段可选值: inner(用户视图)，sys(系统视图)。不传时默认为 inner:
/scene/builtinview/detail?identifier=abc&type=sys // 系统视图
/scene/builtinview/detail?identifier=abc&type=inner // 用户视图
/scene/builtinview/detail?identifier=abc // 用户视图
```


#### 可见范围 {#range}

仪表板的可见范围，包括：

- 公开：对工作空间内所有成员开放；   
- 仅自己可见：仅创建人可查看；
- 自定义：限制特定成员的可见范围。


???+ warning "注意"

    - 以链接形式分享的**非公开仪表板**，非创建人不可见；
    - 此处的开关仅控制当前仪表板的公开与否，不会影响别的规则。



### 自定义模板 {#custom}

![](../img/custom_dashboard.png)

1. 定义当前仪表板的名称；
2. 定义该仪表板的标识 ID；
3. 按需输入针对该仪表板的描述内容；
4. 上传自定义的视图模板 JSON 文件；
5. 选择[标签](../../management/global-label.md)，便于后续分组管理；
6. 选择当前仪表板的[可见范围](#range)；
7. 点击确定，即可创建成功。

### 内置模版库 {#view}

![](../img/dashboard_view.png)

即选即用，包括[系统视图](../built-in-view/index.md#system)和[用户视图](../built-in-view/index.md#user)。

1. 仪表板名称默认为当前选中视图的名称，可按需更改；
2. 定义该仪表板的标识 ID；
3. 按需输入针对该仪表板的描述内容；
4. 选择[标签](../management/global-label.md)，便于后续分组管理；
5. 选择当前仪表板的[可见范围](#range)；
6. 点击确定，即可创建成功。




