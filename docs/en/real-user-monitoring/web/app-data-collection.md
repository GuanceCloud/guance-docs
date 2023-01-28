# Web Application Data Collection
---

## Overview

After collecting application data and reporting it to the observation cloud, you can customize the configuration scene and configure anomaly detection events through the Guance Cloud console.

## Data Type

### 	Hierarchical structure

![](../img/rumcollection1.png)

## Global Properties

Scenario construction and event alerts for Real User Monitoring can be queried through the following global properties.

### SDK Properties

| Fields        | Type   | Description                                                  |
| ------------- | ------ | ------------------------------------------------------------ |
| `sdk_name`    | string | Collector name.<br/>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string | Integrations version                                         |

### Application Properties

| Fields    | Type   | Description                                                  |
| --------- | ------ | ------------------------------------------------------------ |
| `app_id`  | string | Required, The unique ID generated when you create a application. |
| `env`     | string | Required, Environment field. Attribute Value: prod/gray/pre/common/local. |
| `version` | string | Required, Version                                            |

### User & Session Properties

| Fields         | Type    | Description                                                  |
| -------------- | ------- | ------------------------------------------------------------ |
| `userid`       | string  | 默认获取浏览器 cookie 作为 userid。如果使用 [自定义用户标识](custom-sdk/user-id.md) 设置用户 id，那么 userid 就会跟定义的保持一致。注意：cookie 过期时间 60 天。 |
| `session_id`   | string  | 会话 id （用户会话 15 分钟内未产生交互行为则视为过期 ）。    |
| `session_type` | string  | 会话类型。参考值：user &#124; synthetics<br>user 表示是 RUM 功能产生的数据；<br>synthetics 表示是 headless 拨测产生的数据。 |
| `is_signin`    | boolean | 是否是注册用户，属性值：True / False。                       |

### Device & Resolution Properties

| Fields                  | Type   | Description                |
| :---------------------- | :----- | :------------------------- |
| `os`                    | string | 操作系统                   |
| `os_version`            | string | 操作系统版本               |
| `os_version_major`      | string | 设备报告的主要操作系统版本 |
| `browser`               | string | 浏览器提供商               |
| `browser_version`       | string | 浏览器版本                 |
| `browser_version_major` | string | 浏览器主要版本信息         |
| `screen_size`           | string | 屏幕宽度*高度,分辨率       |

### Geographic & Network Properties

| Fields             | Type   | Description                                                  |
| ------------------ | ------ | ------------------------------------------------------------ |
| `ip`               | string | 用户访问IP地址                                               |
| `isp`              | string | 运营商                                                       |
| `network_type`     | string | 网络连接类型，属性值参考：<br>wifi &#124; 2g &#124; 3g &#124; 4g &#124; 5g &#124; unknown（未知网络）&#124; unreachable（网络不可用） |
| `country`          | string | 国家                                                         |
| `country_iso_code` | string | 国家 iso_code                                                |
| `province`         | string | 省                                                           |
| `city`             | string | 城市                                                         |

## Custom Properties

In addition to global properties, you can also build scenarios and configure event alerts through custom properties (**SDK supports users to type custom tag data **). Custom properties are non-global properties. Through custom properties, we can track the whole process of users accessing applications, locate and discover the affected access conditions of users, and monitor the access performance of users.

## Other Data Type Properties

### Session

#### Properties

| Fields                          | Type   | Description                                                  |
| --- | --- | --- |
| `session_id` | string | 会话 id（用户会话 15 分钟内未产生交互行为则视为过期 ） |
| `session_type` | string | 会话类型。参考值：user \| synthetics<br><li>user 表示是RUM功能产生的数据；<br><li>synthetics 表示是 headless拨测产生的数据。 |
| `session_referrer` | string | 会话来源。一般是记录来源的页面地址。 |
| `session_first_view_id` | string | 当前会话的第一个页面的 view_id |
| `session_first_view_url` | string | 当前会话的第一个页面的 URL |
| `session_first_view_host` | string | 当前会话的第一个页面的域名 |
| `session_first_view_path` | string | 当前会话的第一个页面的地址 |
| `session_first_view_path_group` | string | 当前会话的第一个页面的地址分组 |
| `session_first_view_url_query` | string | 当前会话的第一个页面的 query 信息 |
| `session_last_view_id` | string | 当前会话的最后一个访问页面的 view_id |
| `session_last_view_url` | string | 当前会话的最后一个页面的 URL |
| `session_last_view_host` | string | 当前会话的最后一个页面的域名 |
| `session_last_view_path` | string | 当前会话的最后一个页面的地址 |
| `session_last_view_path_group` | string | 当前会话的最后一个页面的地址分组 |
| `session_last_view_url_query` | object | 当前会话的最后一个页面的 query 信息 |

#### Statistical Metrics

| Fields                    | Type       | Description               |
| ------------------------- | ---------- | ------------------------- |
| `time_spent`              | number(ns) | 当前会话持续时长          |
| `session_view_count`      | number     | 当前会话关联`view_id`个数 |
| `session_error_count`     | number     | 当前会话产生错误个数      |
| `session_resource_count`  | number     | 当前会话加载资源个数      |
| `session_action_count`    | number     | 当前会话用户操作次数      |
| `session_long_task_count` | number     | 当前会话产生长任务次数    |


### View

#### Properties

| Fields              | Type    | Description                                     |
| :------------------ | :------ | :---------------------------------------------- |
| `view_id`           | string  | 每次访问页面时产生的唯一 ID                     |
| `is_active`         | boolean | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_loading_type` | string  | 页面加载类型， 参考值：`initial_load`           |
| `view_referrer`     | string  | 页面来源                                        |
| `view_url`          | string  | 页面 URL                                        |
| `view_host`         | string  | 页面 URL 域名部分                               |
| `view_path`         | string  | 页面 URL path 部分                              |
| `view_path_group`   | string  | 页面 URL path 分组                              |
| `view_url_query`    | string  | 页面 URL query 部分                             |

#### Metrics

| Fields                   | Type         | Description                                                  |
| --- | --- | --- |
| first_contentful_paint | number（ns） | 首次内容绘制时间 (FCP)<br>计算方式：firstPaintContentEnd - firstPaintContentStart |
| largest_contentful_paint | number（ns） | 最大内容绘制（页面加载时间轴中的一刹那，其中呈现了视口中最大的 DOM 对象）<br>参考链接：[LCP](https://web.dev/lcp/)<br>计算方式：统计最近上报的一次 PerformanceEntry 时间 |
| cumulative_layout_shift | number | 累计布局版面转移 (CLS)，0 表示载入过程没有版面移动变化 |
| first_input_delay | number（ns） | 首次输入延时 (FID)<br>计算方式：performance.now() - event.timeStamp |
| loading_time | number（ns） | 页面加载时间<br>initial_load 模式下计算公式:<br>① loadEventEnd - navigationStart<br>② 页面首次无活动时间 - navigationStart<br>route_change 模式下计算公式：用户点击时间 - 页面首次无活动时间<br>页面首次无活动时间：页面超过 100ms 无网络请求或 DOM 突变 |
| dom_interactive | number（ns） | DOM 结构构建完毕时间<br>获取方式：time = performanceTiming.domInteractive;<br>参考链接：[MDN dom_interactive](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceTiming/domInteractive) |
| dom_content_loaded | number（ns） | DOM 内容加载时间<br>计算方式：domContentLoadedEventEnd - domContentLoadedEventStart |
| dom_complete | number（ns） | DOM 树解析完成时间<br>获取方式：time = performanceTiming.domComplete;<br>参考链接：[MDN dom_complete](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceTiming/domComplete) |
| load_event | number（ns） | 事件加载时间<br>计算方式：loadEventEnd - loadEventStart |
| first_meaningful_paint | number（ns） | 首屏时间<br>计算方式：firstPaintContentEnd - firstPaintContentStart |
| first_paint_time | number（ns） | 首次渲染时间<br>计算方式：responseEnd - fetchStart |
| resource_load_time | number（ns） | 资源加载时间<br>计算方式：loadEventStart - domContentLoadedEventEnd |
| time_to_interactive | number（ns） | 首次可交互时间<br>计算方式：domInteratice - requestStart |
| dom | number（ns） | DOM 解析耗时<br>计算方式：domComplete - domInteractive |
| dom_ready | number（ns） | DOM Ready时间<br>计算方式：domContentLoadedEventEnd - navigationStart |
| time_spent | number（ns） | 页面停留时间 |

#### Statistical Metrics
| Fields                 | Type   | Description                                                  |
| --- | --- | --- |
| `view_error_count` | number | 每次页面加载时发生的错误次数 |
| `view_resource_count` | number | 每次页面加载时请求的资源个数 |
| `view_long_task_count` | number | 每次页面加载时产生的长任务个数 |
| `view_action_count` | number | 页面查看过程中操作的次数 |
| `view_apdex_level` | number | 页面 Apdex 满意度。<br>基础指标：`first_paint_time`（换算成秒单位）<br>参考值：0/1/2/3/4/5/6/7/8/9 (根据 first_paint_time 值，9 表示>= 9 秒) |

### Resource

#### View Properties

| Fields              | Type    | Description                                     |
| :------------------ | :------ | :---------------------------------------------- |
| `view_id`           | string  | 每次访问页面时产生的唯一 ID                     |
| `is_active`         | boolean | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_loading_type` | string  | 页面加载类型， 参考值：`initial_load`           |
| `view_referrer`     | string  | 页面来源                                        |
| `view_url`          | string  | 页面 URL                                        |
| `view_host`         | string  | 页面 URL 域名部分                               |
| `view_path`         | string  | 页面 URL path 部分                              |
| `view_path_group`   | string  | 页面 URL path 分组                              |
| `view_url_query`    | string  | 页面 URL query 部分                             |

#### Resource Properties

| Fields                    | Type   | Description              |
| ------------------------- | ------ | ------------------------ |
| `resource_url`            | string | 资源 URL                 |
| `resource_url_host`       | string | 资源 URL 域名部分        |
| `resource_url_path`       | string | 资源 URL path 部分       |
| `resource_url_query`      | string | 资源 URL query 部分      |
| `resource_url_path_group` | string | 资源 URL path 分组       |
| `resource_type`           | string | 资源的类别               |
| `resource_method`         | string | 资源请求方式             |
| `resource_status`         | string | 资源请求返回的状态值     |
| `resource_status_group`   | string | 资源请求返回的状态分组值 |

#### Metrics

| Fields                | Type         | Description                                                  |
| --- | --- | --- |
| `resource_size` | number | 资源大小，默认单位：byte |
| `resource_dns` | number（ns） | 资源加载 DNS 解析时间<br>计算方式：domainLookupEnd - domainLookupStart |
| `resource_tcp` | number（ns） | 资源加载 TCP 连接时间<br>计算方式：connectEnd - connectStart |
| `resource_ssl` | number（ns） | 资源加载 SSL 连接时间<br>计算方式：connectEnd - secureConnectStart |
| `resource_ttfb` | number（ns） | 资源加载请求响应时间<br>计算方式：responseStart - requestStart |
| `resource_trans` | number（ns） | 资源加载内容传输时间<br>计算方式：responseEnd - responseStart |
| `resource_first_byte` | number（ns） | 资源加载首包时间<br>计算方式：responseStart - domainLookupStart |
| `duration` | number（ns） | 资源加载时间<br>计算方式：duration(responseEnd-startTime) |

### Error

#### View Properties

| Fields              | Type    | Description                                     |
| :------------------ | :------ | :---------------------------------------------- |
| `view_id`           | string  | 每次访问页面时产生的唯一 ID                     |
| `is_active`         | boolean | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_loading_type` | string  | 页面加载类型， 参考值：`initial_load`           |
| `view_referrer`     | string  | 页面来源                                        |
| `view_url`          | string  | 页面 URL                                        |
| `view_host`         | string  | 页面 URL 域名部分                               |
| `view_path`         | string  | 页面 URL path 部分                              |
| `view_path_group`   | string  | 页面 URL path 分组                              |
| `view_url_query`    | string  | 页面 URL query 部分                             |

#### Error Properties

| Fields                    | Type   | Description                                                  |
| ------------------------- | ------ | ------------------------------------------------------------ |
| `error_source`            | string | 错误来源，参考值：console &#124; network &#124; source &#124; custom |
| `error_type`              | string | 错误类型，参考链接：[error type](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error) |
| `resource_status`         | string | 资源请求返回的状态值                                         |
| `resource_url`            | string | 资源 URL                                                     |
| `resource_url_host`       | string | 资源 URL 域名部分                                            |
| `resource_url_path`       | string | 资源 URL path 部分                                           |
| `resource_url_path_group` | string | 资源 URL path 分组                                           |
| `resource_method`         | string | 资源请求方式                                                 |

#### Metrics

| Fields          | Type   | Description |
| --- | --- | --- |
| `error_message` | string | 错误信息 |
| `error_stack` | string | 错误堆栈 |

### Long Task

#### View Properties

| Fields              | Type    | Description                                     |
| :------------------ | :------ | :---------------------------------------------- |
| `view_id`           | string  | 每次访问页面时产生的唯一 ID                     |
| `is_active`         | boolean | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_loading_type` | string  | 页面加载类型， 参考值：`initial_load`           |
| `view_referrer`     | string  | 页面来源                                        |
| `view_url`          | string  | 页面 URL                                        |
| `view_host`         | string  | 页面 URL 域名部分                               |
| `view_path`         | string  | 页面 URL path 部分                              |
| `view_path_group`   | string  | 页面 URL path 分组                              |
| `view_url_query`    | string  | 页面 URL query 部分                             |

#### Metrics

| Fields     | Type         | Description                    |
| --- | --- | --- |
| `duration` | number（ns） | 页面加载时产生的长任务花费时间 |

### Action

#### View Properties

| Fields              | Type    | Description                                     |
| :------------------ | :------ | :---------------------------------------------- |
| `view_id`           | string  | 每次访问页面时产生的唯一 ID                     |
| `is_active`         | boolean | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_loading_type` | string  | 页面加载类型， 参考值：`initial_load`           |
| `view_referrer`     | string  | 页面来源                                        |
| `view_url`          | string  | 页面 URL                                        |
| `view_host`         | string  | 页面 URL 域名部分                               |
| `view_path`         | string  | 页面 URL path 部分                              |
| `view_path_group`   | string  | 页面 URL path 分组                              |
| `view_url_query`    | string  | 页面 URL query 部分                             |

#### Action Properties

| Fields        | Type   | Description                 |
| ------------- | ------ | --------------------------- |
| `action_id`   | string | 用户页面操作时产生的唯一 ID |
| `action_name` | string | 操作名称                    |
| `action_type` | string | 操作类型                    |

#### Metrics

| Fields     | Type         | Description      |
| --- | --- | --- |
| `duration` | number（ns） | 页面操作花费时间 |

#### Statistical Metrics

| Fields                   | Type   | Description          |
| --- | --- | --- |
| `action_long_task_count` | number | 操作关联长任务次数 |
| `action_resource_count` | number | 操作关联资源请求次数 |
| `action_error_count` | number | 操作关联的错误次数 |
