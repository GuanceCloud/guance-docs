# 日志列表

---

日志查看器是您进行日志分析和问题排查的核心工具之一。面对<<< custom_key.brand_name >>>采集并上报的海量日志数据，您可以通过搜索、过滤、导出等多个操作，实现高效管理日志信息。


## 查看模式 {#mode}

- 标准模式：字段按列展示；

<img src="../img/log_view_model.png" width="70%" >

- 堆叠模式：除时间字段（`time`）外，其余所有字段将被合并到同一列中，并且在单元格内以多行形式展示。

<img src="../img/log_view_model_1.png" width="70%" >

在堆叠模式下，可针对具体字段进行图示操作：

<img src="../img/log_view_model_2.png" width="70%" >

## 状态分布图

根据所选时间范围，系统将自动划分多个时间点，并以堆积柱状图形式展示不同日志状态的数量，助力高效统计分析。当对日志进行筛选过滤时，柱状图将实时同步展示筛选后的结果。

- 可 hover 后导出图表，最终导出到仪表板、笔记或复制到剪贴板；
- 可自定义选择时间间隔。

![](../img/export_chart.png)


## 日志索引

通过设置[日志多索引](./multi-index/index.md)，将符合条件的日志分别存储到不同的索引中，并为每个索引选择合适的数据存储策略，从而有效节约日志数据存储成本。

设置完成后，您可以在查看器中轻松切换不同索引，查看对应的日志内容。

<img src="../img/log_explorer_index.png" width="80%" >

## 搜索与筛选

在日志查看器搜索栏，支持多种[搜索和筛选方式](../getting-started/function-details/explorer-search.md)。

输入搜索或筛选条件后，可查看查询的预览效果。您还可以复制该条件，直接用于图表或查询工具。

<img src="../img/bar-preview.png" width="70%" >


### DQL 搜索 {#dql}

**前提**：DQL 搜索功能目前仅支持日志查看器使用。

通过点击搜索框右侧的切换按钮 :fontawesome-solid-code:，进入 DQL 手动输入查询模式。

- 筛选条件：支持 `and / or` 任意组合，支持通过 `()` 括号指定优先级，同时支持 `=` 、`!=` 等操作符；
- 搜索条件：支持使用 DQL 函数 `query_string()` 字符串查询。例如，输入 `message = query_string()` 可对日志内容进行全文搜索。

> 更多 DQL 语法，可参考 [DQL 定义](../dql/define.md)。



### JSON 字段返回 {#json-content}

**注意**：该功能仅适用于拥有 DQL 查询权限的用户角色。

DQL 查询支持从日志数据的 JSON 字段中提取嵌套值。您只需在 DQL 查询语句中添加带有 `@` 符号的字段路径，系统将自动识别该配置，并将提取的值作为独立字段展示在查询结果中。例如：

- 正常查询：

<img src="../img/json.png" width="70%" >

- 期待提取内嵌字段后的查询：

<img src="../img/json-1.png" width="70%" >

在日志查看器，若想直接在数据列表中指定查看从每条日志 `message` 的 JSON 文本中提取出的值，在显示列处添加格式为 `@targer_fieldname` 的字段。如下图，我们在显示列中添加 DQL 查询语句中已配置的 `@fail_reason`：

![](../img/json-3.gif)

## 新建监控器 {#new}

在进行日志数据筛选时，如果需要对筛选结果进行进一步的告警监控，可以通过一键设置监控器来实现。系统会自动应用您选定的索引、数据来源和搜索条件，从而简化配置流程。


???+ warning "注意"

    - 如果在日志查看器左上角选择了其他工作空间，搜索条件将不会被同步到监控器配置页，监控器配置页会默认置空。
    - 在普通商业版中，默认开启了站点级别的 `左*` 查询功能。您只需开启工作空间级别的 `左*` 查询，即可支持监控器的 `左*` 查询。对于部署版，您可以自主开启或关闭站点级别的 `左*` 查询，只有在站点和工作空间级别的 `左*` 查询都开启后，监控器才可进行 `左*` 查询。否则，如果日志查看器配置了 `左*` 查询，跳转到监控器时可能会出现查询报错。

![](../img/explorer-monitor.png)

![](../img/explorer-monitor-1.png)


## Copy as cURL

在日志查看器中，您可以通过命令行形式获取日志数据。在日志数据列表右侧的**设置**中，点击 **Copy as cURL** 按钮即可复制对应的 cURL 命令。将该命令粘贴到主机终端并执行，即可获取当前时间段内符合筛选及搜索条件的日志数据

![](../img/logexport-1.png)

*示例*

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

系统已为状态值预设了默认颜色。如果您需要自定义不同状态在查看器中显示的颜色，可点击**设置状态颜色**进行修改。

<img src="../img/status-color.png" width="70%" >

## 格式化配置

<font size=2>**注意**：仅管理员及以上可进行查看器格式化配置。</font>

通过格式化配置，您可以隐藏敏感日志内容、突出显示重要日志内容，或通过替换日志内容实现快速筛选。

1. 点击查看器列表右上角的**设置**；
2. 点击**格式化配置**；
3. 添加映射规则，输入以下内容并保存：

    - 字段：指定日志字段（如 `content`）。
    - 匹配方式：选择匹配方式（目前支持 =、!=、match、not match）。
    - 匹配内容：输入需要匹配的内容（如 DEBUG）。
    - 显示为内容：输入替换后的显示内容（如 ******）。


![](../img/11.log_format_2.gif)

## 日志数据导出 {#logexport}

在**日志**中，您可以先筛选出所需日志数据，然后通过 :octicons-gear-24: > 导出按钮将其导出为 CSV 文件或保存到仪表板和笔记中，以便进一步查看和分析。

![](../img/5.log_explorer_3.png)

如果需要导出某条日志数据，打开该日志的详情页，点击右上角 :material-tray-arrow-up: 图标即可。

![](../img/export-log-0808.png)


## 日志颜色高亮

为了帮助快速定位日志中的关键信息，系统采用颜色高亮显示日志内容。在搜索栏中输入关键词时，仅匹配到的关键词会高亮显示。


## 日志单行展开复制

- 点击日志条目中的 :material-chevron-down: 按钮，即可查看该日志的完整内容。若日志支持 JSON 格式，将以 JSON 格式展示；否则正常显示内容。

- 点击 :octicons-copy-16: 按钮，可将整条日志内容复制到剪贴板。

![](../img/log_explorer_expand_copy.png)

## 日志多行浏览

在日志数据列表中，默认显示每条日志的触发时间和内容。通过查看器 > 显示列，可选择显示 “1 行”、“3 行”、“10 行” 或全部内容，以查看完整的日志信息。

![](../img/log_explorer_lines.png)

