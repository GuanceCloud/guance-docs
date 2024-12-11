# UniApp 应用数据采集
---

## 简介

UniApp  数据采集依赖于 Android iOS Native 框架，为了与 Android iOS 数据采集做对比，以下删除线标记项为未能实现的部分。

## 数据类型

观测云的用户访问监测包括六种数据类型。

| **类型** | **描述** |
| --- | --- |
| session | 用户会话信息记录，当前会话中，将会基于会话维度用户页面、资源、操作、错误、长任务相关访问数据。 |
| view | 每次用户访问移动端应用程序的页面时，都会生成一个查看记录。当用户停留在同一页面上时，资源，长任务，错误和操作记录将通过 `view_id` 属性链接到相关的 RUM 视图。 |
| resource | 用户访问页面时，加载的资源信息记录。 |
| error | 移动应用程序发出的异常或崩溃。 |
| <del>long_task</del> | <del>对于应用程序中任何阻塞主线程超过指定持续时间阈值的任务，都会生成一个长任务事件。 </del>|
| action | 记录移动应用程序中的用户活动（应用程序启动，点击，滑动，后退等）。每个动作都附加有唯一的 `action_id`。 |


## 全局属性

用户访问监测的场景构建和事件告警都可以通过下面的全局属性进行查询。

### SDK 属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `sdk_name` | string | 采集器名称，固定名称：<br>`df_macos_rum_sdk`<br>`df_linux_rum_sdk`<br>`df_windows_rum_sdk`<br>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string | 采集器版本信息 |

### 应用属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `app_id` | string | 必填，用户访问应用唯一 ID 标识，在观测云控制台上面创建监控时自动生成。 |
| `env` | string | 必填，环境字段。属性值：prod/gray/pre/common/local。其中：<br>prod：线上环境<br>gray：灰度环境<br>pre：预发布环境<br>common：日常环境<br>local：本地环境 |
| `version` | string | 必填，版本号。 |
| `service` | string | 可选，所属业务或服务的名称。固定名称：<br/>`df_rum_ios`<br/>`df_rum_android`<br/>`df_rum_windows`<br/>`df_rum_linux` |

### 用户 & 会话属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `userid` | string | 未登录用户使用随机 uuid 作为 `userid`，登录用户使用应用后台生成的用户 id。 |
| `user_name` | string | 可选，用户名称。 |
| `user_email` | string | 可选，用户邮箱。 |
| `session_id` | string | 会话id，未操作 15分钟以上，会生成一个新的 `session_id`。 |
| `session_type` | string | 会话类型。参考值：user & synthetics<br>user：RUM 功能产生的数据；<br>synthetics：headless 拨测产生的数据。 |
| `is_signin` | boolean | 是否是注册用户，属性值：T & F。 |

### 设备 & 分辨率属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `device` | string | 移动设备厂商 |
| `model` | string | 移动设备型号 |
| `device_uuid` | string | 移动设备唯一 ID, 使用 Android:[ANDROID_ID](https://developer.android.com/reference/android/provider/Settings.Secure.html#ANDROID_ID)、 iOS:[UIDevice.identifierForVendor](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor) 生成 |
| `os` | string | 操作系统信息 |
| `os_version` | string | 操作系统版本 |
| `os_version_major` | string | 操作系统主要版本 |
| `screen_size` | string | 屏幕分辨率 |

### 地理 & 网络属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `ip` | string | 用户访问IP地址 |
| `isp` | string | 运营商 |
| `network_type` | string | 网络连接类型，属性值参考：
wifi &#124; 2g &#124; 3g &#124; 4g &#124; 5g &#124; unknown（未知网络）&#124; unreachable（网络不可用） |
| `country` | string | 国家 |
| `country_iso_code` | string | 国家 iso_code |
| `province` | string | 省 |
| `city` | string | 城市 |

## 自定义属性

除全局属性以外，还可以通过自定义属性（**SDK 支持用户打自定义的 tag 数据**）构建场景和配置事件告警。自定义属性是非全局属性，通过自定义属性，可以跟踪用户访问应用的整个过程，定位和发现用户受影响的访问情况，监控用户访问性能。

## 其他数据类型属性

### Session 

#### 属性

| **字段**                      | **类型**   | **描述**                                                        |
| ------------------------- | ------ | ------------------------------------------------------------ |
| `session_id`              | string | 会话 id          |
| `session_type`            | string | 会话类型。参考值：user & test<br>user：RUM 功能产生的数据；<br>test：headless 拨测产生的数据。 |
| `session_referrer`        | string | 会话来源。一般是记录来源的页面地址。                         |
| `session_first_view_id`   | string | 当前会话的第一个页面的 `view_id`                                |
| `session_first_view_name` | string | 当前会话的第一个页面的 URL                                    |
| `session_last_view_id`    | string | 当前会话的最后一个访问页面的 `view_id`                          |
| `session_last_view_name`  | string | 当前会话的最后一个页面的URL                                  |

#### 统计指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `time_spent` | number(ns) | 当前会话持续时长 |
| `session_view_count` | number | 当前会话关联 `view_id` 个数 |
| `session_error_count` | number | 当前会话产生错误个数 |
| `session_resource_count` | number | 当前会话加载资源个数 |
| `session_action_count` | number | 当前会话用户操作次数 |
| <del>`session_long_task_count`</del> | number | <del>当前会话产生长任务次数</del> |

### View 

#### 属性

| **字段**        | **类型** | **描述**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一 ID                          |
| `view_referrer` | string   | 页面来源，页面的父级                                |
| `view_name`     | string   | 页面名称                                            |

#### 指标

| **字段** | **类型** | **描述**   |
| --- | --- | --- |
| <del>`loading_time`</del> | number（ns） | <del>页面加载时间</del> |
| `time_spent` | number（ns） | 页面停留时间 |
| `is_active`     | boolean  | 判断用户是否还在活跃状态，参考值: true & false |

#### 统计指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `view_error_count` | number | 每次页面加载时发生的错误次数 |
| `view_resource_count` | number | 每次页面加载时请求的资源个数 |
| <del>`view_long_task_count`</del>| number | <del>每次页面加载时产生的长任务个数</del> |
| `view_action_count` | number | 页面查看过程中操作的次数 |

#### 监控指标

| **字段**                    | **类型** | **描述**                 |
| --------------------------- | -------- | ------------------------ |
| `cpu_tick_count`            | number   | 可选，该页面 CPU 跳动次数    |
| `cpu_tick_count_per_second` | number   | 可选，每秒平均 CPU 跳动次数  |
| `fps_avg`                   | number   | 可选，页面平均每秒帧数   |
| `fps_mini`                  | number   | 可选，页面最小每秒帧数   |
| `memory_avg`                | number   | 可选，页面内存使用平均值 |
| `memory_max`                | number   | 可选，页面内存峰值       |

### Resource

#### View 属性

| **字段**        | **类型** | **描述**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一 ID                          |
| `view_referrer` | string   | 页面来源，页面的父级                                |
| `view_name`     | string   | 页面名称                                            |

#### Action 属性

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | 用户页面操作时产生的唯一 ID          |
| `action_name` | string   | 操作名称                            |
| `action_type` | string   | 操作类型(冷热启动，click 点击等操作) |

#### Resource 属性

| **字段**                  | **类型** | **描述**                 |
| ------------------------- | -------- | ------------------------ |
| `resource_url`            | string   | 资源 URL                  |
| `resource_url_host`       | string   | 资源 URL 域名部分         |
| `resource_url_path`       | string   | 资源 URL path 部分         |
| `resource_url_query`      | string   | 资源 URL query 部分        |
| `resource_url_path_group` | string   | 资源 URL path 分组         |
| `resource_type`           | string   | 资源的类别               |
| `resource_method`         | string   | 资源请求方式             |
| `resource_status`         | string   | 资源请求返回的状态值     |
| `resource_status_group`   | string   | 资源请求返回的状态分组值 |

#### 指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| <del>`resource_size` </del>| number | <del>资源大小，默认单位：byte </del>||
| <del>`resource_dns` </del>| number（ns） | <del>资源加载DNS解析时间<br>计算方式：domainLookupEnd - domainLookupStart </del>|
| <del>`resource_tcp` </del>| number（ns） | <del>资源加载TCP连接时间<br>计算方式：connectEnd - connectStart</del>|
| <del>`resource_ssl` </del>| number（ns） |<del> 资源加载SSL连接时间<br>计算方式：connectEnd - secureConnectStart </del>|
| <del>`resource_ttfb`</del>| number（ns） | <del>资源加载请求响应时间<br>计算方式：responseStart - requestStart</del> |
|<del> `resource_trans` </del>| number（ns） | <del>资源加载内容传输时间<br>计算方式：responseEnd - responseStart </del>|
| <del>`resource_first_byte` </del>| number（ns） | <del>资源加载首包时间<br>计算方式：responseStart - domainLookupStart </del>|
| <del>`duration`</del>| number（ns） | <del>资源加载时间<br>计算方式：duration(responseEnd-startTime) </del>|
| `request_header` | string |资源请求头|
| `response_header`| string |资源响应头 |

### Error

#### View 属性

| **字段**        | **类型** | **描述**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一 ID                          |
| `view_referrer` | string   | 页面来源，页面的父级                                |
| `view_name`     | string   | 页面名称                                            |

#### Action 属性

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | 用户页面操作时产生的唯一 ID          |
| `action_name` | string   | 操作名称                            |
| `action_type` | string   | 操作类型(冷热启动，click 点击等操作) |

#### Error 属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `error_source` | string | 错误来源，参考值：logger &#124; network |
| `error_type` | string | **错误类型**<br>logger error type:  java_crash &#124; ios_crash<br>network error type：network_error |
| `error_situation` | string | 错误发生的时机，参考值：startup (启动时)和 run (运行时) |

**type=network时，新增以下Network Error属性。**

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `resource_status` | string | 资源请求返回的状态值 |
| `resource_url` | string | 资源 URL |
| `resource_url_host` | string | 资源 URL 域名部分 |
| `resource_url_path` | string | 资源 URL path部分 |
| `resource_url_path_group` | string | 资源 URL path分组 |
| `resource_method` | string | 资源请求方式 |

#### Error 监控属性


| **字段**       | **类型** | **描述**             |
| -------------- | -------- | -------------------- |
| `memory_total` | string   | 可选，内存总量       |
| `memory_use`   | number   | 可选，内存使用率     |
| `cpu_use`      | number   | 可选，CPU 使用率     |
| `battery_use`  | number   | 可选，当前手机的电量 |
| `locale`       | string   | 当前系统语言         |

#### 指标

| **字段**        | **类型** | **描述** |
| --------------- | -------- | -------- |
| `error_message` | string   | 错误信息 |
| `error_stack`   | string   | 错误堆栈 |

### Long Task

#### View 属性


| **字段**        | **类型** | **描述**                   |
| --------------- | -------- | -------------------------- |
| <del>`view_id`</del> | string   | <del>每次访问页面时产生的唯一 ID</del> |
| <del>`view_referrer`</del> | string   | <del>页面来源，页面的父级</del> |
| <del>`view_name`</del> | string   | <del>页面名称</del>        |

#### Action 属性

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| <del>`action_id`</del> | string   | <del>用户页面操作时产生的唯一 ID</del> |
| <del>`action_name`</del> | string   | <del>操作名称</del>                 |
| <del>`action_type`</del> | string   | <del>操作类型(冷热启动，click 点击等操作)</del> |

#### 指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| <del>`duration`</del> | number（ns） | <del>卡顿时长</del> |
| <del>`long_task_message`</del> | string | <del>卡顿信息</del> |
| <del>`long_task_stack`</del> | string | <del>卡顿堆栈</del> |

### Action

#### View 属性

| **字段**        | **类型** | **描述**                   |
| --------------- | -------- | -------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一 ID |
| `view_referrer` | string   | 页面来源，页面的父级       |
| `view_name`     | string   | 页面名称                   |

#### Action 属性

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | 用户页面操作时产生的唯一 ID          |
| `action_name` | string   | 操作名称                            |
| `action_type` | string   | 操作类型(冷热启动，click 点击等操作) |

#### 指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `duration` | number（ns） | 页面操作花费时间 |

#### 统计指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `action_long_task_count` | number | 操作关联长任务次数 |
| `action_resource_count` | number | 操作关联资源请求次数 |
| `action_error_count` | number | 操作关联的错误次数 |



