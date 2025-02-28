# Web 应用数据采集

---

应用数据采集到<<< custom_key.brand_name >>>后，可以通过<<< custom_key.brand_name >>>控制台进行自定义配置场景和配置异常检测事件。

## 数据类型

<<< custom_key.brand_name >>>的用户访问监测包括六种数据类型：

| 类型      | 描述                                                                                                                                         |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| session   | 用户会话信息记录，当前会话中，基于会话维度抓取用户页面、资源、操作、错误、长任务相关访问数据。                                               |
| view      | 用户访问页面时，都会生成一个页面查看记录。当用户停留在同一页面上时，资源，长任务，错误和操作记录将通过 `view_id` 属性链接到相关的 RUM 视图。 |
| resource  | 用户访问页面时，加载的资源信息记录。                                                                                                         |
| error     | 用户访问监测采集器收集浏览器上的所有前端错误。                                                                                               |
| long_task | 对于浏览器中的任何阻塞主线程超过 50ms 的任务，都会生成一条长任务记录。                                                                       |
| action    | 跟踪用户页面浏览过程中所有的用户交互记录。                                                                                                   |

<img src="../../img/rumcollection1.png" width="40%" >

## 全局属性

用户访问监测的场景构建和事件告警都可以通过下面的全局属性进行查询。

### SDK 属性

| 字段          | 类型   | 描述                                                                                                           |
| ------------- | ------ | -------------------------------------------------------------------------------------------------------------- |
| `sdk_name`    | string | 采集器名称，固定名称：<br>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string | 采集器版本信息。                                                                                               |

### 应用属性

| 字段      | 类型   | 描述                                                                                                                                                               |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `app_id`  | string | 必填，用户访问应用唯一 ID 标识，在<<< custom_key.brand_name >>>控制台上面创建监控时自动生成。                                                                                             |
| `env`     | string | 必填，环境字段。属性值：prod/gray/pre/common/local。其中：<br>prod：线上环境；<br>gray：灰度环境；<br>pre：预发布环境；<br>common：日常环境；<br>local：本地环境。 |
| `version` | string | 必填，版本号。                                                                                                                                                     |
| `service` | string | 必填，用户访问 SDK 内配置的 service 字段对应值。                                                                                                                   |

### 用户 & 会话属性

| 字段           | 类型    | 描述                                                                                                                                                                       |
| -------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `userid`       | string  | 默认获取浏览器 Cookie 作为 `userid`。如果使用[自定义用户标识](custom-sdk/user-id.md)设置用户 id，那么 `userid` 就会跟定义的保持一致。<br>:warning: Cookie 过期时间 60 天。 |
| `session_id`   | string  | 会话 id （用户会话 15 分钟内未产生交互行为则视为过期）。                                                                                                                   |
| `session_type` | string  | 会话类型。参考值：user & synthetics：<br><li>user：RUM 功能产生的数据；<br><li>synthetics：headless 拨测产生的数据。                                                       |
| `is_signin`    | boolean | 是否是注册用户，属性值：True / False。                                                                                                                                     |

### 设备 & 分辨率属性

| 字段                    | 类型   | 描述                       |
| :---------------------- | :----- | :------------------------- |
| `os`                    | string | 操作系统                   |
| `os_version`            | string | 操作系统版本               |
| `os_version_major`      | string | 设备报告的主要操作系统版本 |
| `browser`               | string | 浏览器提供商               |
| `browser_version`       | string | 浏览器版本                 |
| `browser_version_major` | string | 浏览器主要版本信息         |
| `screen_size`           | string | 屏幕宽度\*高度，分辨率     |

### 地理 & 网络属性

| 字段               | 类型   | 描述                                                                                                                                  |
| ------------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------- |
| `ip`               | string | 用户访问 IP 地址                                                                                                                      |
| `isp`              | string | 运营商                                                                                                                                |
| `network_type`     | string | 网络连接类型，属性值参考：<br>wifi &#124; 2g &#124; 3g &#124; 4g &#124; 5g &#124; unknown（未知网络）&#124; unreachable（网络不可用） |
| `country`          | string | 国家                                                                                                                                  |
| `country_iso_code` | string | 国家 `iso_code`                                                                                                                       |
| `province`         | string | 省                                                                                                                                    |
| `city`             | string | 城市                                                                                                                                  |

## 自定义属性

除全局属性以外，还可以通过自定义属性（**SDK 支持用户打自定义的 tag 数据**）构建场景和配置事件告警。自定义属性是非全局属性，通过自定义属性，可以跟踪用户访问应用的整个过程，定位和发现用户受影响的访问情况，监控用户访问性能。

## 其他数据类型属性

### Session

#### 属性

| 字段                            | 类型   | 描述                                                                                                                 |
| ------------------------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| `session_id`                    | string | 会话 id（用户会话 15 分钟内未产生交互行为则视为过期 ）                                                               |
| `session_type`                  | string | 会话类型。参考值：user & synthetics：<br><li>user：RUM 功能产生的数据；<br><li>synthetics：headless 拨测产生的数据。 |
| `session_first_view_id`         | string | 当前会话的第一个页面的 `view_id`                                                                                     |
| `session_first_view_url`        | string | 当前会话的第一个页面的 URL                                                                                           |
| `session_first_view_host`       | string | 当前会话的第一个页面的域名                                                                                           |
| `session_first_view_path`       | string | 当前会话的第一个页面的地址                                                                                           |
| `session_first_view_path_group` | string | 当前会话的第一个页面的地址分组                                                                                       |
| `session_first_view_url_query`  | string | 当前会话的第一个页面的 query 信息                                                                                    |
| `session_first_view_name`       | string | 当前会话的第一个页面的地址分组，同 `session_first_view_path_group` 字段                                              |
| `session_last_view_id`          | string | 当前会话的最后一个访问页面的 `view_id`                                                                               |
| `session_last_view_url`         | string | 当前会话的最后一个页面的 URL                                                                                         |
| `session_last_view_host`        | string | 当前会话的最后一个页面的域名                                                                                         |
| `session_last_view_path`        | string | 当前会话的最后一个页面的地址                                                                                         |
| `session_last_view_path_group`  | string | 当前会话的最后一个页面的地址分组                                                                                     |
| `session_last_view_url_query`   | object | 当前会话的最后一个页面的 query 信息                                                                                  |
| `session_last_view_name`        | string | 当前会话的最后一个页面的地址分组，同 `session_last_view_path_group` 字段                                             |

#### 统计指标

| 字段                       | 类型       | 描述                                                |
| -------------------------- | ---------- | --------------------------------------------------- |
| `time_spent`               | number(ns) | 当前会话持续时长                                    |
| `session_time_spent_count` | number     | 以 4 小时为时间间隔，超出的按每 4 小时加 1 统计得到 |
| `session_view_count`       | number     | 当前会话关联 `view_id` 个数                         |
| `session_error_count`      | number     | 当前会话产生错误个数                                |
| `session_resource_count`   | number     | 当前会话加载资源个数                                |
| `session_action_count`     | number     | 当前会话用户操作次数                                |
| `session_long_task_count`  | number     | 当前会话产生长任务次数                              |

### View

#### 属性

| 字段                | 类型   | 描述                                                                                   |
| ------------------- | ------ | -------------------------------------------------------------------------------------- |
| `view_id`           | string | 每次访问页面时产生的唯一 ID                                                            |
| `view_loading_type` | string | 页面加载类型， 参考值：`initial_load` `route_change` `route_change`为 SPA 页面加载模式 |
| `view_referrer`     | string | 页面来源                                                                               |
| `view_url`          | string | 页面 URL                                                                               |
| `view_host`         | string | 页面 URL 域名部分                                                                      |
| `view_path`         | string | 页面 URL path 部分                                                                     |
| `view_path_group`   | string | 页面 URL path 分组                                                                     |
| `view_url_query`    | string | 页面 URL query 部分                                                                    |

#### 指标

| 指标                                        | 类型（单位） | 简介                                                                                                                                                                                                                                               |
| ------------------------------------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `loading_time`                              | number(ns)   | 页面已经 ready，并且没有任何网络请求和 DOM 变动，详情可参考 [页面 Loading Time](../../security/page-performance.md#loading-time)                                                                                                                   |
| `largest_contentful_paint`                  | number(ns)   | LCP 报告的是视口中可见最大图片或文本块的呈现时间（相对于用户首次导航到相应网页的时间）。为了提供良好的用户体验，LCP 应在页面首次开始加载后的 2.5 秒内发生。                                                                                        |
| `largest_contentful_paint_element_selector` | string       | 产生 LCP 指标对应元素的 selector                                                                                                                                                                                                                   |
| `cumulative_layout_shift`                   | number(ns)   | 累积布局偏移，测量视觉稳定性。为了提供良好的用户体验，页面的 CLS 应保持在 0.1. 或更少。                                                                                                                                                            |
| `cumulative_layout_shift_target_selector`   | number(ns)   | 产生 CLS 指标对应元素的 selector                                                                                                                                                                                                                   |
| `first_input_delay`                         | number(ns)   | 测量页面上首次互动的输入延迟， 目前已被 inp 代替                                                                                                                                                                                                   |
| `interaction_to_next_paint`                 | number(ns)   | 通过考虑所有页面互动（从输入延迟到运行事件处理程序所需的时间，再到浏览器绘制下一帧）来改进 FID。                                                                                                                                                   |
| `interaction_to_next_paint_target_selector` | number(ns)   | 产生 inp 指标对应元素的 selector                                                                                                                                                                                                                   |
| `first_contentful_paint`                    | number(ns)   | 首次内容绘制 (FCP) 指标测量页面从开始加载到页面内容的任何部分在屏幕上完成渲染的时间。对于该指标，"内容"指的是文本、图像（包括背景图像）、`<svg>`元素或非白色的 `<canvas>` 元素。 可参考 [w3c](https://www.w3.org/TR/paint-timing/#sec-terminology) |
| `first_byte`                                | number(ns)   | 请求页面到页面响应第一个字节的时间                                                                                                                                                                                                                 |
| `dom_interactive`                           | number(ns)   | 解析器完成文档解析的时间，详情可参考 [MDN](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceTiming/domInteractive)                                                                                                                      |
| `dom_content_loaded`                        | number(ns)   | 当纯 HTML 被完全加载以及解析时，DOMContentLoaded 事件会被触发，而不必等待样式表，图片或者子框架完成加载,详情参考 [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Document/DOMContentLoaded_event)                                           |
| `dom_complete`                              | number(ns)   | 页面和所有子资源都已准备就绪。对于用户来说，加载 loading 动画已停止旋转。详情可参考 [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/DOMContentLoaded_event)                                                                          |
| `load_event`                                | number(ns)   | 整个页面及所有依赖资源如样式表和图片都已完成加载时触发，它与 `DOMContentLoaded` 不同，后者只要页面 DOM 加载完成就触发，无需等待依赖资源的加载。 详情可参考 [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/load_event)               |
| `resource_load_time`                        | number（ns） | 资源加载时间<br>计算方式：loadEventStart - domContentLoadedEventEnd                                                                                                                                                                                |
| `time_to_interactive`                       | number（ns） | 首次可交互时间<br>计算方式：domInteractive - fetchStart                                                                                                                                                                                            |
| `dom`                                       | number（ns） | DOM 解析耗时<br>计算方式：domComplete - domInteractive                                                                                                                                                                                             |
| `dom_ready`                                 | number（ns） | DOM Ready 时间<br>计算方式：domContentLoadedEventEnd - navigationStart                                                                                                                                                                             |
| `time_spent`                                | number（ns） | 页面停留时间                                                                                                                                                                                                                                       |
| `is_active`                                 | boolean      | 判断用户是否还在活跃状态，参考值: true & false                                                                                                                                                                                                     |

#### 统计指标

| 字段                   | 类型   | 描述                                                                                                                                         |
| ---------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `view_error_count`     | number | 每次页面加载时发生的错误次数                                                                                                                 |
| `view_resource_count`  | number | 每次页面加载时请求的资源个数                                                                                                                 |
| `view_long_task_count` | number | 每次页面加载时产生的长任务个数                                                                                                               |
| `view_action_count`    | number | 页面查看过程中操作的次数                                                                                                                     |
| `view_apdex_level`     | number | 页面 Apdex 满意度。<br>基础指标：`first_paint_time`（换算成秒单位）<br>参考值：0/1/2/3/4/5/6/7/8/9 (根据 first_paint_time 值，9 表示>= 9 秒) |

### Resource

#### View 属性

| 字段                | 类型    | 描述                                            |
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

#### Resource 属性

| 字段                      | 类型   | 描述                     |
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

#### 指标

| 字段                  | 类型         | 描述                                                                   |
| --------------------- | ------------ | ---------------------------------------------------------------------- |
| `resource_size`       | number       | 资源大小，默认单位：byte                                               |
| `resource_dns`        | number（ns） | 资源加载 DNS 解析时间<br>计算方式：domainLookupEnd - domainLookupStart |
| `resource_tcp`        | number（ns） | 资源加载 TCP 连接时间<br>计算方式：connectEnd - connectStart           |
| `resource_ssl`        | number（ns） | 资源加载 SSL 连接时间<br>计算方式：connectEnd - secureConnectStart     |
| `resource_ttfb`       | number（ns） | 资源加载请求响应时间<br>计算方式：responseStart - requestStart         |
| `resource_trans`      | number（ns） | 资源加载内容传输时间<br>计算方式：responseEnd - responseStart          |
| `resource_first_byte` | number（ns） | 资源加载首包时间<br>计算方式：responseStart - domainLookupStart        |
| `duration`            | number（ns） | 资源加载时间<br>计算方式：duration(responseEnd-startTime)              |

### Error

#### View 属性

| 字段                | 类型    | 描述                                            |
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

#### Error 属性

| 字段                      | 类型   | 描述                                                                                                                     |
| ------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------ |
| `error_source`            | string | 错误来源，参考值：console &#124; network &#124; source &#124; custom                                                     |
| `error_type`              | string | 错误类型，参考链接：[error type](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error) |
| `resource_status`         | string | 资源请求返回的状态值                                                                                                     |
| `resource_url`            | string | 资源 URL                                                                                                                 |
| `resource_url_host`       | string | 资源 URL 域名部分                                                                                                        |
| `resource_url_path`       | string | 资源 URL path 部分                                                                                                       |
| `resource_url_path_group` | string | 资源 URL path 分组                                                                                                       |
| `resource_method`         | string | 资源请求方式                                                                                                             |

#### 指标

| 字段            | 类型   | 描述     |
| --------------- | ------ | -------- |
| `error_message` | string | 错误信息 |
| `error_stack`   | string | 错误堆栈 |

### Long Task

#### View 属性

| 字段                | 类型    | 描述                                            |
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

#### 指标

| 字段       | 类型         | 描述                           |
| ---------- | ------------ | ------------------------------ |
| `duration` | number（ns） | 页面加载时产生的长任务花费时间 |

### Action

#### View 属性

| 字段                | 类型    | 描述                                            |
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

#### Action 属性

| 字段          | 类型   | 描述                        |
| ------------- | ------ | --------------------------- |
| `action_id`   | string | 用户页面操作时产生的唯一 ID |
| `action_name` | string | 操作名称                    |
| `action_type` | string | 操作类型                    |

#### 指标

| 字段       | 类型         | 描述             |
| ---------- | ------------ | ---------------- |
| `duration` | number（ns） | 页面操作花费时间 |

#### 统计指标

| 字段                     | 类型   | 描述                 |
| ------------------------ | ------ | -------------------- |
| `action_long_task_count` | number | 操作关联长任务次数   |
| `action_resource_count`  | number | 操作关联资源请求次数 |
| `action_error_count`     | number | 操作关联的错误次数   |
