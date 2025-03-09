# Frequently Asked Questions

:material-chat-question: Why do scheduled report emails return a 414 error?

The image links in the scheduled reports sent to the target email are generated based on parameters such as the corresponding charts and view variables of the dashboard. If the content of the view variables is too long, it may result in excessively long image links, leading to a 414 error.

---

:material-chat-question: Why can't the JSON format be used in the Explorer search bar?

Using JSON search requires meeting the following three conditions:

1. The site must be "China Region 1 (Hangzhou)", "China Region 3 (Zhangjiakou)", or "China Region 4 (Guangzhou)"
2. The workspace must have been created after June 23, 2022
3. It can only be used in the log Explorer

---

:material-chat-question: <<< custom_key.brand_name >>> currently provides a Node script to convert Grafana dashboard JSON templates into <<< custom_key.brand_name >>> dashboard JSON templates.

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

<<< custom_key.brand_name >>> obtains all values of a metric over a period of time, sorts these values from smallest to largest, and determines the position of the data point corresponding to P99 based on **number of data points * 99%**, then returns the value at that position. The term "all values" refers to the raw data points stored in the database.

For percentile queries on metric data, <<< custom_key.brand_name >>>'s handling method varies depending on the data engine used. If the database does not natively support percentile queries, <<< custom_key.brand_name >>> retrieves the data locally for additional processing to achieve this functionality. For non-metric data (such as logs, APM, RUM, etc.), percentile queries are supported through the native capabilities of the database.