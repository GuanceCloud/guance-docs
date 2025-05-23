# C++ 应用数据采集
---


应用数据采集到<<< custom_key.brand_name >>>后，可以通过<<< custom_key.brand_name >>>控制台进行自定义配置场景和配置异常检测事件。

## 数据类型

<<< custom_key.brand_name >>>的用户访问监测包括六种数据类型：

| **类型** | **描述** |
| --- | --- |
| session | 用户会话信息记录，当前会话中，将会基于会话维度用户页面、资源、操作、错误、长任务相关访问数据。 |
| view | 每次用户访问应用程序的页面时，都会生成一个查看记录。当用户停留在同一页面上时，资源，长任务，错误和操作记录将通过 `view_id` 属性链接到相关的RUM视图。 |
| resource | 用户访问页面时，加载的资源信息记录。 |
| error | 应用程序发出的异常或崩溃。 |
| long_task | 对于应用程序中任何阻塞主线程超过指定持续时间阈值的任务，都会生成一个长任务事件。 |
| action | 记录应用程序中的用户活动（应用程序启动，点击，滑动，后退等）。每个动作都附加有唯一的 `action_id`。 |

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
| `app_id` | string | 必填，用户访问应用唯一 ID 标识，在<<< custom_key.brand_name >>>控制台上面创建监控时自动生成。 |
| `env` | string | 必填，环境字段。属性值：prod/gray/pre/common/local。其中：<br>prod：线上环境<br>gray：灰度环境<br>pre：预发布环境<br>common：日常环境<br>local：本地环境 |
| `version` | string | 必填，版本号。 |
| `service` | string | 可选，所属业务或服务的名称。固定名称：<br/>`df_rum_ios`<br/>`df_rum_android`<br/>`df_rum_windows`<br/>`df_rum_linux` |

### 用户 & 会话属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `userid` | string | 未登录用户使用随机 uuid 作为 `userid`，登录用户使用应用后台生成的用户 id。 |
| `user_name` | string | 可选，用户名称。 |
| `user_email` | string | 可选，用户邮箱。 |
| `session_id` | string | 会话id，未操作 15 分钟以上，会生成一个新的 `session_id`。 |
| `session_type` | string | 会话类型。参考值：user & synthetics<br>user：RUM 功能产生的数据；<br>synthetics：headless 拨测产生的数据。 |
| `is_signin` | boolean | 是否是注册用户，属性值：T & F。 |

### 设备 & 分辨率属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `device` | string | 设备厂商 |
| `model` | string | 设备型号 |
| `device_uuid` | string | 设备唯一 id |
| `os` | string | 操作系统信息 |
| `os_version` | string | 操作系统版本 |
| `os_version_major` | string | 操作系统主要版本 |
| `screen_size` | string | 屏幕分辨率 |

### 地理 & 网络属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `ip` | string | 用户访问IP地址 |
| `isp` | string | 运营商 |
| `network_type` | string | 网络连接类型，属性值参考：<br>wifi & 2g & 3g & 4g & 5g & unknown（未知网络）& unreachable（网络不可用） |
| `country` | string | 国家 |
| `country_iso_code` | string | 国家 `iso_code` |
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
| `session_first_view_id`   | string | 当前会话的第一个页面的 `view_id`                               |
| `session_first_view_name` | string | 当前会话的第一个页面的 URL                                    |
| `session_last_view_id`    | string | 当前会话的最后一个访问页面的 `view_id`                          |
| `session_last_view_name`  | string | 当前会话的最后一个页面的 URL                                  |

#### 统计指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `time_spent` | number(ns) | 当前会话持续时长 |
| `session_view_count` | number | 当前会话关联 `view_id` 个数 |
| `session_error_count` | number | 当前会话产生错误个数 |
| `session_resource_count` | number | 当前会话加载资源个数 |
| `session_action_count` | number | 当前会话用户操作次数 |
| `session_long_task_count` | number | 当前会话产生长任务次数 |

### View 

#### 属性

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

#### 指标

| **字段** | **类型** | **描述**   |
| --- | --- | --- |
| ~~`loading_time`~~ | number（ns） | 页面加载时间 |
| `time_spent` | number（ns） | 页面停留时间 |
| `is_active`     | boolean  | 判断用户是否还在活跃状态，参考值: true & false |

#### 统计指标

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `view_error_count` | number | 每次页面加载时发生的错误次数 |
| `view_resource_count` | number | 每次页面加载时请求的资源个数 |
| `view_long_task_count` | number | 每次页面加载时产生的长任务个数 |
| `view_action_count` | number | 页面查看过程中操作的次数 |

#### 监控指标

| **字段**                    | **类型** | **描述**                 |
| --------------------------- | -------- | ------------------------ |
| ~~`cpu_tick_count`~~            | number   | 可选，该页面 CPU 跳动次数    |
| ~~`cpu_tick_count_per_second`~~ | number   | 可选，每秒平均 CPU 跳动次数  |
| ~~`fps_avg`~~               | number   | 可选，页面平均每秒帧数   |
| ~~`fps_mini`~~              | number   | 可选，页面最小每秒帧数   |
| ~~`memory_avg`~~                | number   | 可选，页面内存使用平均值 |
| ~~`memory_max`~~                | number   | 可选，页面内存峰值       |

### Resource

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
| `resource_size` | number | 资源大小，默认单位：byte |
| `resource_dns` | number（ns） | 资源加载 DNS 解析时间<br>计算方式：domainLookupEnd - domainLookupStart |
| `resource_tcp` | number（ns） | 资源加载 TCP 连接时间<br>计算方式：connectEnd - connectStart |
| `resource_ssl` | number（ns） | 资源加载 SSL 连接时间<br>计算方式：connectEnd - secureConnectStart |
| `resource_ttfb` | number（ns） | 资源加载请求响应时间<br>计算方式：responseStart - requestStart |
| `resource_trans` | number（ns） | 资源加载内容传输时间<br>计算方式：responseEnd - responseStart |
| `resource_first_byte` | number（ns） | 资源加载首包时间<br>计算方式：responseStart - domainLookupStart |
| `duration` | number（ns） | 资源加载时间<br>计算方式：duration (responseEnd-startTime) |
| `request_header` | string | 资源请求头 |
| `response_header` | string | 资源响应头 |

### Error

#### View 属性

| **字段**        | **类型** | **描述**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一 ID                      |
| `view_referrer` | string   | 页面来源，页面的父级                            |
| `view_name`     | string   | 页面名称                                        |

#### Action 属性

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | 用户页面操作时产生的唯一 ID          |
| `action_name` | string   | 操作名称                            |
| `action_type` | string   | 操作类型(冷热启动，click 点击等操作) |

#### Error 属性

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `error_source` | string | 错误来源，参考值：logger & network |
| `error_type` | string | 错误类型<br>logger error type: java_crash & native_crash & abort & ios_crash<br>network error type：network |
| `error_situation` | string | 错误发生的时机，参考值：startup (启动时)和 run (运行时) |

**type=network时，新增以下Network Error属性。**

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `resource_status` | string | 资源请求返回的状态值 |
| `resource_url` | string | 资源 URL |
| `resource_url_host` | string | 资源 URL 域名部分 |
| `resource_url_path` | string | 资源 URL path 部分 |
| `resource_url_path_group` | string | 资源 URL path 分组 |
| `resource_method` | string | 资源请求方式 |

#### Error 监控属性

| **字段**       | **类型** | **描述**             |
| -------------- | -------- | -------------------- |
| ~~`memory_total`~~ | string   | 可选，内存总量       |
| ~~`memory_use`~~  | number   | 可选，内存使用率     |
| ~~`cpu_use`~~      | number   | 可选，CPU 使用率     |
| ~~`battery_use`~~  | number   | 可选，当前设备的电量 |
| ~~`locale`~~       | string   | 当前系统语言         |

#### 指标

| **字段**        | **类型** | **描述** |
| --------------- | -------- | -------- |
| `error_message` | string   | 错误信息 |
| `error_stack`   | string   | 错误堆栈 |

### Long Task

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
| `duration` | number（ns） | 卡顿时长 |
| `long_task_message` | string | 卡顿信息 |
| `long_task_stack` | string | 卡顿堆栈 |

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

