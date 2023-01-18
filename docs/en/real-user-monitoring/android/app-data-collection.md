# Android Application Data Collection
---

## Overview

After collecting application data and reporting it to the observation cloud, you can customize the configuration scene and configure anomaly detection events through the Guance Cloud console.

## Data Type

Real User Monitoring of Guance Cloud includes six data types.

| **Type**  | **Description**                                              |
| --------- | ------------------------------------------------------------ |
| session   | User session information records, in the current session, will be based on the session dimension of user pages, resources, actions, errors, long task related access data. |
| view      | When a user accesses a page, a page view record is generated. When the user stays on the same page, the resource, long task, error, and action records are linked to the relevant RUM view through the view_id attribute. |
| resource  | The resource information record loaded when the user accesses the page. |
| error     | An exception or crash from a mobile application.             |
| long_task | A long task event is generated for any task in the application that blocks the main thread beyond the specified duration threshold. |
| action    | Record user activities in mobile applications (application launch, click, slide, back, etc.). Each action is attached with a unique action_id. |

## Global Properties

Scenario construction and event alerts for Real User Monitoring can be queried through the following global properties.

### SDK Properties

| **字段**      | **类型** | **描述**                                                     |
| ------------- | -------- | ------------------------------------------------------------ |
| `sdk_name`    | string   | 采集器名称，固定名称：<br>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string   | 采集器版本信息                                               |

### Application Properties

| 字段      | 类型   | 描述                                                         |
| --------- | ------ | ------------------------------------------------------------ |
| `app_id`  | string | 必填，用户访问应用唯一ID标识，在观测云控制台上面创建监控时自动生成。 |
| `env`     | string | 必填，环境字段。属性值：prod/gray/pre/common/local。其中<br>prod：线上环境<br>gray：灰度环境<br>pre：预发布环境<br>common：日常环境<br>local：本地环境 |
| `version` | string | 必填，版本号。                                               |

### User & Session Properties

| **字段**       | **类型** | **描述**                                                     |
| -------------- | -------- | ------------------------------------------------------------ |
| `userid`       | string   | 未登录用户使用cookie作为userid，登录用户使用应用后台生成的用户id。 |
| `session_id`   | string   | 会话 id （后台停留30s以上，会生成一个新的session_id）。      |
| `session_type` | string   | 会话类型。参考值：user &#124; synthetics<br>user 表示是 RUM 功能产生的数据；<br>synthetics 表示是 headless 拨测产生的数据。 |
| `is_signin`    | boolean  | 是否是注册用户，属性值：True / False。                       |

### Device & Resolution Properties

| **字段**           | **类型** | **描述**         |
| :----------------- | :------- | :--------------- |
| `device`           | string   | 移动设备厂商     |
| `model`            | string   | 移动设备型号     |
| `device_uuid`      | string   | 移动设备唯一id   |
| `os`               | string   | 操作系统信息     |
| `os_version`       | string   | 操作系统版本     |
| `os_version_major` | string   | 操作系统主要版本 |
| `screen_size`      | string   | 屏幕分辨率       |

### Geographic & Network Properties

| **字段**           | **类型** | **描述**                                                     |
| ------------------ | -------- | ------------------------------------------------------------ |
| `ip`               | string   | 用户访问IP地址                                               |
| `isp`              | string   | 运营商                                                       |
| `network_type`     | string   | 网络连接类型，属性值参考：<br>wifi &#124; 2g &#124; 3g &#124; 4g &#124; 5g &#124; unknown（未知网络）&#124; unreachable（网络不可用） |
| `country`          | string   | 国家                                                         |
| `country_iso_code` | string   | 国家 iso_code                                                |
| `province`         | string   | 省                                                           |
| `city`             | string   | 城市                                                         |

## Custom Properties

In addition to global properties, you can also build scenarios and configure event alerts through custom properties (**SDK supports users to type custom tag data **). Custom properties are non-global properties. Through custom properties, we can track the whole process of users accessing applications, locate and discover the affected access conditions of users, and monitor the access performance of users.

## Other Data Type Properties

### Session 

#### Properties

| 字段 | 类型 | 描述 |
| --- | --- | --- |
| `session_id` | string | 会话id（后台停留30s以上，会生成一个新的session_id） |
| `session_type` | string | 会话类型。参考值：user &#124; test<br>user表示是RUM功能产生的数据；<br>test表示是headless拨测产生的数据。 |
| `session_referrer` | string | 会话来源。一般是记录来源的页面地址。 |
| `session_first_view_id` | string | 当前会话的第一个页面的view_id |
| `session_first_view_name` | string | 当前会话的第一个页面的URL |
| `session_last_view_id` | string | 当前会话的最后一个访问页面的view_id |
| `session_last_view_name` | string | 当前会话的最后一个页面的URL |

#### Statistical Metrics

| **字段**                  | **类型**   | **描述**                |
| ------------------------- | ---------- | ----------------------- |
| `time_spent`              | number(ns) | 当前会话持续时长        |
| `session_view_count`      | number     | 当前会话关联view_id个数 |
| `session_error_count`     | number     | 当前会话产生错误个数    |
| `session_resource_count`  | number     | 当前会话加载资源个数    |
| `session_action_count`    | number     | 当前会话用户操作次数    |
| `session_long_task_count` | number     | 当前会话产生长任务次数  |

### View 

#### Properties

| **字段**        | **类型** | **描述**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一ID                      |
| `is_active`     | boolean  | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_referrer` | string   | 页面来源，页面的父级                            |
| `view_name`     | string   | 页面名称                                        |

#### Metrics

| 字段 | 类型 | 描述 |
| --- | --- | --- |
| `loading_time` | number（ns） | 页面加载时间 |
| `time_spent` | number（ns） | 页面停留时间 |

#### Statistical Metrics
| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `view_error_count` | number | 每次页面加载时发生的错误次数 |
| `view_resource_count` | number | 每次页面加载时请求的资源个数 |
| `view_long_task_count` | number | 每次页面加载时产生的长任务个数 |
| `view_action_count` | number | 页面查看过程中操作的次数 |

### Resource

#### View Properties

| **字段**        | **类型** | **描述**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一ID                      |
| `is_active`     | boolean  | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_referrer` | string   | 页面来源，页面的父级                            |
| `view_name`     | string   | 页面名称                                        |

#### Resource Properties

| **字段**                  | **类型** | **描述**                 |
| ------------------------- | -------- | ------------------------ |
| `resource_url`            | string   | 资源URL                  |
| `resource_url_host`       | string   | 资源URL 域名部分         |
| `resource_url_path`       | string   | 资源URL path部分         |
| `resource_url_query`      | string   | 资源URL query部分        |
| `resource_url_path_group` | string   | 资源URL path分组         |
| `resource_type`           | string   | 资源的类别               |
| `resource_method`         | string   | 资源请求方式             |
| `resource_status`         | string   | 资源请求返回的状态值     |
| `resource_status_group`   | string   | 资源请求返回的状态分组值 |

#### Metrics

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `resource_size` | number | 资源大小，默认单位：byte |
| `resource_dns` | number（ns） | 资源加载DNS解析时间<br>计算方式：domainLookupEnd - domainLookupStart |
| `resource_tcp` | number（ns） | 资源加载TCP连接时间<br>计算方式：connectEnd - connectStart |
| `resource_ssl` | number（ns） | 资源加载SSL连接时间<br>计算方式：connectEnd - secureConnectStart |
| `resource_ttfb` | number（ns） | 资源加载请求响应时间<br>计算方式：responseStart - requestStart |
| `resource_trans` | number（ns） | 资源加载内容传输时间<br>计算方式：responseEnd - responseStart |
| `resource_first_byte` | number（ns） | 资源加载首包时间<br>计算方式：responseStart - domainLookupStart |
| `duration` | number（ns） | 资源加载时间<br>计算方式：duration(responseEnd-startTime) |

### Error

#### View Properties

| **字段**        | **类型** | **描述**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一ID                      |
| `is_active`     | boolean  | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_referrer` | string   | 页面来源，页面的父级                            |
| `view_name`     | string   | 页面名称                                        |

#### Error Properties

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `error_message` | string | 错误信息 |
| `error_stack` | string | 错误堆栈 |
| `error_source` | string | 错误来源，参考值：logger &#124; network |
| `error_type` | string | 错误类型<br>logger error type: java_crash &#124; native_crash &#124; abort &#124; ios_crash<br>network error type： |
| `error_situation` | string | 错误发生的时机，参考值：startup(启动时)和run(运行时) |

When type=network, the following Network Error properties is added.

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `resource_status` | string | 资源请求返回的状态值 |
| `resource_url` | string | 资源URL |
| `resource_url_host` | string | 资源URL 域名部分 |
| `resource_url_path` | string | 资源URL path部分 |
| `resource_url_path_group` | string | 资源URL path分组 |
| `resource_method` | string | 资源请求方式 |

### Long Task

#### View Properties

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | 用户页面操作时产生的唯一ID          |
| `action_name` | string   | 操作名称                            |
| `action_type` | string   | 操作类型(冷热启动，click点击等操作) |

#### Metrics

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `duration` | number（ns） | 卡顿时长 |
| `long_task_message` | string | 卡顿信息 |
| `long_task_stack` | string | 卡顿堆栈 |

### Action

#### View Properties

| **字段**        | **类型** | **描述**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | 每次访问页面时产生的唯一ID                      |
| `is_active`     | boolean  | 判断用户是否还在活跃状态，参考值: true \| false |
| `view_referrer` | string   | 页面来源，页面的父级                            |
| `view_name`     | string   | 页面名称                                        |

#### Action Properties

| **字段**      | **类型** | **描述**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | 用户页面操作时产生的唯一ID          |
| `action_name` | string   | 操作名称                            |
| `action_type` | string   | 操作类型(冷热启动，click点击等操作) |

#### Metrics

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `duration` | number（ns） | 页面操作花费时间 |

#### Statistical Metrics

| **字段** | **类型** | **描述** |
| --- | --- | --- |
| `action_long_task_count` | number | 操作关联长任务次数 |
| `action_resource_count` | number | 操作关联资源请求次数 |
| `action_error_count` | number | 操作关联的错误次数 |
