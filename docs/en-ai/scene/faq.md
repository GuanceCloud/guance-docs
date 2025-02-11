# Frequently Asked Questions

:material-chat-question: Why do scheduled report emails return a 414 error?

The image links in the scheduled reports sent to the target email are generated based on parameters such as the corresponding charts and view variables of the dashboard. If the content of the view variables is too long, it may result in excessively long image links, leading to a 414 error.

---

:material-chat-question: Why can't the Explorer search bar use JSON format?

Using JSON search requires meeting the following three conditions:

1. The site must be "China Region 1 (Hangzhou)", "China Region 3 (Zhangjiakou)", or "China Region 4 (Guangzhou)"
2. The workspace must have been created after June 23, 2022
3. It can only be used in the log Explorer

---

:material-chat-question: Guance provides a Node script to convert Grafana dashboard JSON templates into Guance dashboard JSON templates.

npm installation:

```
npm install @cloudcare/guance-front-tools
```

Usage:

```
$ npm install -g @cloudcare/guance-front-tools

# show usage information
$ grafanaCovertToGuance

# run task
$ grafanaCovertToGuance -d examples/grafana.json -o examples/guance.json
```

Keywords:

none


---

:material-chat-question: Explanation of P99 percentile calculation logic

Guance retrieves all values of a metric over a certain period, sorts these values in ascending order, and determines the position of the P99 data point based on **number of data points * 99%**, returning the value at that position. The term "all values" refers to the raw data points stored in the database.

For percentile queries on metric data, Guance's processing method varies depending on the data engine used. If the database does not support percentile queries, Guance will pull the data locally for additional processing to achieve this functionality. For non-metric data (such as logs, APM, RUM, etc.), percentile queries are supported through the native functionality of the database.