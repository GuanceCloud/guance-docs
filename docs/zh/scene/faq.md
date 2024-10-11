# 常见问题

:material-chat-question: 为什么定时报告邮件会报错 414？

最终发送到目标邮箱里的定时报告中，图片链接的生成是根据所在仪表板的对应图表迭代视图变量等参数拼接而成。若出现视图变量内容过长，则有可能导致生成的图片链接过长，从而引发 414 报错问题。

---

:material-chat-question: 为什么查看器搜索栏无法使用 JSON 格式？

使用 JSON 搜索需要满足以下三个条件：

1. 站点为“中国区1（杭州）”、“中国区3（张家口）”、以及“中国区4（广州）”
2. 工作空间需要在 `2022年6月23日` 后创建
3. 仅可在日志查看器中使用

---

:material-chat-question: 观测云目前提供 Grafana dashboard json template 转换为观测云仪表板 JSON 模版的 node 脚本.

npm 下载：

```
npm install  @cloudcare/guance-front-tools
```

使用方式：

```
$ npm install -g @cloudcare/guance-front-tools

# show usage information
$ grafanaCovertToGuance

# run task
$ grafanaCovertToGuance -d examples/grafana.json -o examples/guance.json
```

Keywords：

none


---

:material-chat-question: P99 的峰位计算逻辑说明

观测云通过获取一段时间内某个指标的所有值，将这些值从小到大排序，然后根据**数据点数 * 99%** 来确定 P99 对应的数据点位置，并返回该位置的值。这里所说的“所有值”指的是存储在数据库中的原始数据点。

对于指标数据的百分位查询，观测云的处理方式会因使用的数据引擎而异。如果数据库本身不支持百分位查询功能，观测云会通过代码将数据拉取到本地进行额外处理来实现这一功能。而对于非指标类数据（如日志、APM、RUM 等），百分位查询则是通过数据库的原生功能来支持的。
