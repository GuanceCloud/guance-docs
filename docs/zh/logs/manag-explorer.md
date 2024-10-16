# 日志列表

---

日志查看器是您进行日志分析和问题排查的核心工具之一。面对观测云采集并上报的海量日志数据，您可以通过搜索、过滤、导出等多个操作，实现高效管理日志信息。

## 日志统计

观测云会根据选择的时间范围自动划分若干时间点，通过堆积柱状图展示不同日志状态的数量，帮助进行统计分析。若对日志进行了筛选过滤，柱状图同步展示筛选后结果。

- 日志统计图支持通过鼠标悬浮至图表，点击导出按钮，即可导出到仪表板、笔记或粘贴板；
- 日志统计图支持自定义选择时间间隔。

![](../img/10.export_pic.png)

## 时间控件

观测云查看器默认展示最近 15 分钟的日志数据。您可以自定义数据展示的[时间范围](../getting-started/function-details/explorer-search.md#time)。

## 日志索引

您可以设置[日志多索引](./multi-index/index.md)，筛选符合条件的日志保存在不同的日志索引中，并通过为日志索引选择不同的数据存储策略，从而节约日志数据存储费用。

设置索引后，即可在查看器选择切换不同的索引查看对应的日志内容。


<img src="../../img/5.log_3.1.png" width="70%" >

## 搜索与筛选

在日志查看器搜索栏，支持[多种搜索方式和筛选方式](../getting-started/function-details/explorer-search.md)。

输入搜索或筛选条件后，可查看查询的预览效果。您可以复制该条件，直接用于图表或查询工具。

<img src="../../img/bar-preview.png" width="70%" >


## DQL 搜索 {#dql}

**前提**：DQL 搜索功能目前仅支持日志查看器使用。

在日志查看器，您可以通过点击搜索框内的切换按钮 :fontawesome-solid-code:，切换到 DQL 手动输入查询模式，可自定义输入筛选条件和搜索条件。

- 筛选条件：支持 `and / or` 任意组合，支持使用 `()` 括号表示执行搜索的优先级，支持 `=` 、`!=` 等操作符；
- 搜索条件：支持使用 DQL 函数 `query_string()` 字符串查询，如输入 `message = query_string()` 对日志内容进行搜索。

> 更多 DQL 语法，可参考 [DQL 定义](../dql/define.md)。

## 快捷筛选 {#filter}

在日志查看器左侧，可对[快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)进行编辑。

**注意**：若快捷筛选的列出值受采样影响，显示采样率，并支持用户临时关闭采样。

## 自定义显示列

日志查看器默认显示 `time` 和 `message` 字段，其中 `time` 字段为固定字段无法删除。当 hover 在查看器显示列上时，点击**设置**按钮，即可对显示列进行升序、降序、向左移动列、向右移动列、向左添加列、向右添加列、替换列、添加到快捷筛选、添加到分组、移除列等操作。

> 更多详情，可参考 [显示列说明](../getting-started/function-details/explorer-search.md#columns)。

### JSON 字段返回 {#json-content}

**注意**：该功能仅适用于拥有 DQL 查询权限的用户角色。

观测云 DQL 查询支持从日志数据的 JSON 字段中提取内嵌的值，通过在 DQL 查询语句中添加带有 `@` 符号的字段，系统会识别该配置并将其作为独立字段在查询结果中展示。如：

- 正常查询：

<img src="../../img/json.png" width="70%" >

- 期待提取内嵌字段后的查询：

<img src="../../img/json-1.png" width="70%" >

在日志查看器，若想直接在数据列表中指定查看从每条日志 `message` 的 JSON 文本中提取出的值，在显示列处添加格式为 `@targer_fieldname` 的字段。如下图，我们在显示列中添加 DQL 查询语句中已配置的 `@fail_reason`：

![](../img//json-3.gif)

## 新建监控器 {#new}

您可以在日志查看器通过该入口，直接跳转至监控器[新建](../monitoring/monitor/index.md#new)页面，为日志数据快速设置异常检测规则。

![](../img//explorer-monitor.png)


## Copy as cURL

日志查看器支持通过命令行形式来获取日志数据。在日志数据列表右侧**设置**，点击 **Copy as cURL** 即可复制 cURL 命令行，前往主机终端执行该命令，从可获取当前时间段内相关筛选及搜索条件下的日志数据。

![](../img//logexport-1.png)

<u>**示例**</u>

复制 cURL 命令行后，如下图所示：其中 `<Endpoint>` 需替换为域名，`<DF-API-KEY>` 需前往 [API 管理](../management/api-key/index.md) 更换为 **Key ID**。

> 关于更多相关参数说明，可参考 [DQL 数据查询](../open-api/query-data/query-data.md)。
> 
> 关于 API 更多信息，可参考 [Open API](../management/api-key/open-api.md)。

```shell
curl '<Endpoint>/api/v1/df/query_data?search_after=\[1680226330509,8572,"L_1680226330509_cgj4hqbrhi85kl1m6os0"\]&queries_body=%7B%22queries%22:\[%7B%22uuid%22:%222eb41760-cf6e-11ed-a983-7d559044c3fc%22,%22qtype%22:%22dql%22,%22query%22:%7B%22q%22:%22L::re(%60.*%60):(%60*%60)%7B+%60index%60+IN+\[%27default%27\]+%7D%22,%22highlight%22:true,%22limit%22:50,%22orderby%22:\[%7B%22time%22:%22desc%22%7D\],%22_funcList%22:\[\],%22funcList%22:\[\],%22disableMultipleField%22:false,%22disable_slimit%22:false,%22is_optimized%22:true,%22offset%22:0,%22search_after%22:\[1680226330509,8572,%22L_1680226330509_cgj4hqbrhi85kl1m6os0%22\],%22timeRange%22:\[1680187562081,1680230762081\],%22tz%22:%22Asia%2FShanghai%22%7D%7D\]%7D' \
- H 'DF-API-KEY: <DF-API-KEY>' \
- -compressed \
- -insecure
```


**注意**：仅**标准成员及以上**可进行复制命令行操作。

除该导出路径外，您还可采用[其他日志数据导出](#logexport)方式。


## 设置状态颜色 {#status-color}

观测云为状态值已经设置了系统默认颜色。如您需要修改不同的状态下，对应数据在查看器中显示的颜色，可通过点击**设置状态颜色**进行修改。


<img src="../../img/status-color.png" width="70%" >

## 格式化配置

<font size=2>**注意**：仅管理员及以上可进行查看器格式化配置。</font>

格式化配置可以让您隐藏敏感日志数据内容或者突出需要查看的日志数据内容，还可以通过替换原有日志内容进行快速筛选。

点击查看器列表右上角的**设置**，点击**格式化配置**，即可添加映射，输入以下内容，点击保存，即可把含 “DEGUB” 的原日志内容替换成您想显示的格式。

- 字段：如内容
- 匹配方式：如 match（目前支持`=`、`!=`、`match`、`not match`）
- 匹配内容：如 DEBUG
- 显示为内容：如 `******`



![](../img//11.log_format_2.gif)

## 日志数据导出 {#logexport}

在**日志**中，您可以先筛选出想要的日志数据，再通过 :octicons-gear-24: 导出后进行查看和分析，支持导出到 CSV 文件或者仪表板和笔记。

![](../img//5.log_explorer_3.png)

如果需要导出某条日志数据，打开该条日志详情页，点击右上角 :material-tray-arrow-up: 图标即可。

![](../img//export-log-0808.png)


## 日志颜色高亮

为了让您能更快的的获取日志的重点数据信息，观测云采用不同的颜色高亮日志的不同内容，分成浅色和深色两种主题颜色。

**注意**：如果在搜索栏对日志进行搜索时，返回的列表仅保留匹配到的关键词的高亮显示。

| 日志内容 | 浅色主题 | 深色主题 |
| --- | --- | --- |
| 日期（日志发生的时间） | 黄色 | 浅黄色 |
| 关键字（HTTP协议相关，如GET） | 绿色 | 浅绿色 |
| 文本（带引号的字符串） | 蓝色 | 浅蓝色 |
| 默认（无任何标示的文本） | 黑色 | 灰色 |
| 数字（日志状态码等，如404） | 紫色 | 浅紫色 |

![](../img//2.log_1.png)

## 日志单行展开复制

点击 :material-chevron-down: 至某条日志内容，可展开查看日志的全部内容；

点击 :octicons-copy-16: 按钮可复制整条日志内容。日志内容展开时，若支持 JSON 展示，会将该条日志以 JSON 格式展示，若不支持则正常展示该日志内容。

![](../img//5.log_explorer_1.png)

## 日志多行浏览

观测云的日志数据列表默认为您展示日志的触发时间和内容。您可以在查看器**显示列**中选择日志显示 “1 行”、“3 行”、“10 行”和全部来查看完整的日志内容。

![](../img//5.log_explorer_2.gif)

