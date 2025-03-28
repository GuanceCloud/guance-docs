# React Native Application Data Collection
---

## Introduction
Data collection for React Native applications depends on the Android and iOS native frameworks. To compare with data collection on Android and iOS, the following items marked with strikethrough are parts that have not been implemented.

## Data Types

User access monitoring in <<< custom_key.brand_name >>> includes six types of data.

| **Type** | **Description** |
| --- | --- |
| session | User session information is recorded during the current session, including page views, resources, actions, errors, and long tasks related to user access data. |
| view | A view record is generated each time a user visits a page in a mobile application. When a user stays on the same page, resource, long task, error, and action records are linked to the relevant RUM view via the `view_id` attribute. |
| resource | Records information about resources loaded when a user visits a page. |
| error | Exceptions or crashes issued by the mobile application. |
| <del>long_task</del> | <del>An event is generated for any task that blocks the main thread of the application for longer than a specified duration threshold. </del>|
| action | Records user activities within the mobile application (application launch, clicks, swipes, back actions, etc.). Each action is attached with a unique `action_id`. |

## Global Attributes

Scenarios and event alerts in user access monitoring can be queried using the following global attributes.

### SDK Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `sdk_name` | string | Collector name, fixed names:<br>`df_macos_rum_sdk`<br>`df_linux_rum_sdk`<br>`df_windows_rum_sdk`<br>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string | Collector version information |

### Application Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `app_id` | string | Required, unique ID for the monitored application, automatically generated when creating monitoring in the <<< custom_key.brand_name >>> console. |
| `env` | string | Required, environment field. Possible values: prod/gray/pre/common/local. Where:<br>prod: Production environment<br>gray: Canary environment<br>pre: Pre-release environment<br>common: Daily environment<br>local: Local environment |
| `version` | string | Required, version number. |
| `service` | string | Optional, name of the associated business or service. Fixed names:<br/>`df_rum_ios`<br/>`df_rum_android`<br/>`df_rum_windows`<br/>`df_rum_linux` |

### User & Session Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `userid` | string | For unlogged users, a random UUID is used as `userid`; for logged-in users, the user ID generated by the application backend is used. |
| `user_name` | string | Optional, user name. |
| `user_email` | string | Optional, user email. |
| `session_id` | string | Session ID; if no operation for more than 15 minutes, a new `session_id` will be generated. |
| `session_type` | string | Session type. Reference values: user & synthetics<br>user: Data generated by RUM functionality;<br>synthetics: Data generated by headless dial testing. |
| `is_signin` | boolean | Whether the user is registered, possible values: T & F. |

### Device & Resolution Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `device` | string | Mobile device manufacturer |
| `model` | string | Mobile device model |
| `device_uuid` | string | Unique ID of the mobile device, generated using Android:[ANDROID_ID](https://developer.android.com/reference/android/provider/Settings.Secure.html#ANDROID_ID)、iOS:[UIDevice.identifierForVendor](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor) |
| `os` | string | Operating system information |
| `os_version` | string | Operating system version |
| `os_version_major` | string | Major operating system version |
| `screen_size` | string | Screen resolution |

### Geographic & Network Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `ip` | string | User access IP address |
| `isp` | string | Internet service provider |
| `network_type` | string | Network connection type, reference values:<br>wifi &#124; 2g &#124; 3g &#124; 4g &#124; 5g &#124; unknown (unknown network) &#124; unreachable (unavailable network) |
| `country` | string | Country |
| `country_iso_code` | string | ISO code of the country |
| `province` | string | Province |
| `city` | string | City |

## Custom Attributes

In addition to global attributes, custom attributes (**SDK supports user-defined tag data**) can be used to build scenarios and configure event alerts. Custom attributes are non-global attributes that allow tracking the entire process of user access to the application, identifying and discovering affected user visits, and monitoring user access performance.

## Other Data Type Attributes

### Session 

#### Properties

| **Field**                      | **Type**   | **Description**                                                        |
| ------------------------- | ------ | ------------------------------------------------------------ |
| `session_id`              | string | Session ID          |
| `session_type`            | string | Session type. Reference values: user & test<br>user: Data generated by RUM functionality;<br>test: Data generated by headless dial testing. |
| `session_referrer`        | string | Session source, usually recording the URL of the source page.                         |
| `session_first_view_id`   | string | The `view_id` of the first page in the current session                                |
| `session_first_view_name` | string | The URL of the first page in the current session                                    |
| `session_last_view_id`    | string | The `view_id` of the last visited page in the current session                          |
| `session_last_view_name`  | string | The URL of the last page in the current session                                  |

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `time_spent` | number(ns) | Duration of the current session |
| `session_view_count` | number | Number of `view_id` associated with the current session |
| `session_error_count` | number | Number of errors generated in the current session |
| `session_resource_count` | number | Number of resources loaded in the current session |
| `session_action_count` | number | Number of user actions in the current session |
| <del>`session_long_task_count`</del> | number | <del>Number of long tasks generated in the current session</del> |

### View 

#### Properties

| **Field**        | **Type** | **Description**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | Unique ID generated each time a page is visited                          |
| `view_referrer` | string   | Page source, parent page                                |
| `view_name`     | string   | Page name                                            |

#### Metrics

| **Field** | **Type** | **Description**   |
| --- | --- | --- |
| `loading_time` | number(ns) | Page loading time |
| `time_spent` | number(ns) | Time spent on the page |
| `is_active`     | boolean  | Whether the user is still active, reference values: true & false |

#### Statistical Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `view_error_count` | number | Number of errors that occurred each time the page was loaded |
| `view_resource_count` | number | Number of resources requested each time the page was loaded |
| <del>`view_long_task_count`</del> | number | <del>Number of long tasks generated each time the page was loaded</del> |
| `view_action_count` | number | Number of operations during the page view |

#### Monitoring Metrics

| **Field**                    | **Type** | **Description**                 |
| --------------------------- | -------- | ------------------------ |
| `cpu_tick_count`            | number   | Optional, CPU tick count for the page    |
| `cpu_tick_count_per_second` | number   | Optional, average CPU ticks per second  |
| `fps_avg`                   | number   | Optional, average frames per second for the page   |
| `fps_mini`                  | number   | Optional, minimum frames per second for the page   |
| `memory_avg`                | number   | Optional, average memory usage for the page |
| `memory_max`                | number   | Optional, peak memory usage for the page       |

### Resource

#### View Properties

| **Field**        | **Type** | **Description**                   |
| --------------- | -------- | -------------------------- |
| `view_id`       | string   | Unique ID generated each time a page is visited |
| `is_active`     | boolean  | Whether the user is still active, reference values: true & false |
| `view_referrer` | string   | Page source, parent page       |
| `view_name`     | string   | Page name                   |

#### Action Properties

| **Field**      | **Type** | **Description**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | Unique ID generated when the user operates on a page          |
| `action_name` | string   | Operation name                            |
| `action_type` | string   | Operation type (cold/hot start, click, etc.) |

#### Resource Properties

| **Field**                  | **Type** | **Description**                 |
| ------------------------- | -------- | ------------------------ |
| `resource_url`            | string   | Resource URL                  |
| `resource_url_host`       | string   | Domain part of the resource URL         |
| `resource_url_path`       | string   | Path part of the resource URL         |
| `resource_url_query`      | string   | Query part of the resource URL        |
| `resource_url_path_group` | string   | Grouped path part of the resource URL         |
| `resource_type`           | string   | Category of the resource               |
| `resource_method`         | string   | Request method for the resource             |
| `resource_status`         | string   | Status value returned by the resource request     |
| `resource_status_group`   | string   | Grouped status value returned by the resource request |

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `resource_size` | number | Resource size, default unit: byte |
| `resource_dns` | number(ns) | DNS resolution time for resource loading<br>Calculation method: domainLookupEnd - domainLookupStart |
| `resource_tcp` | number(ns) | TCP connection time for resource loading<br>Calculation method: connectEnd - connectStart |
| `resource_ssl` | number(ns) | SSL connection time for resource loading<br>Calculation method: connectEnd - secureConnectStart |
| `resource_ttfb` | number(ns) | Response time for resource loading<br>Calculation method: responseStart - requestStart |
| `resource_trans` | number(ns) | Content transfer time for resource loading<br>Calculation method: responseEnd - responseStart |
| `resource_first_byte` | number(ns) | First byte time for resource loading<br>Calculation method: responseStart - domainLookupStart |
| `duration` | number(ns) | Total resource loading time<br>Calculation method: duration(responseEnd-startTime) |

### Error

#### View Properties

| **Field**        | **Type** | **Description**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | Unique ID generated each time a page is visited                      |
| `view_referrer` | string   | Page source, parent page                            |
| `view_name`     | string   | Page name                                        |

#### Action Properties

| **Field**      | **Type** | **Description**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | Unique ID generated when the user operates on a page          |
| `action_name` | string   | Operation name                            |
| `action_type` | string   | Operation type (cold/hot start, click, etc.) |

#### Error Properties

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `error_source` | string | Error source, reference values: logger &#124; network |
| `error_type` | string | Error type<br>logger error type: reactnative_crash &#124; java_crash &#124; native_crash &#124; anr_error &#124; anr_crash &#124; ios_crash<br>network error type：network_error |
| `error_situation` | string | Timing of the error occurrence, reference values: startup (at startup) and run (during runtime) |

When **type=network**, additional Network Error properties are added.

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `resource_status` | string | Status value returned by the resource request |
| `resource_url` | string | Resource URL |
| `resource_url_host` | string | Domain part of the resource URL |
| `resource_url_path` | string | Path part of the resource URL |
| `resource_url_path_group` | string | Grouped path part of the resource URL |
| `resource_method` | string | Request method for the resource |

#### Monitoring Properties

| **Field**       | **Type** | **Description**             |
| -------------- | -------- | -------------------- |
| `memory_total` | string   | Optional, total memory       |
| `memory_use`   | number   | Optional, memory usage rate     |
| `cpu_use`      | number   | Optional, CPU usage rate     |
| `battery_use`  | number   | Optional, current battery level |
| `locale`       | string   | Current system language         |

#### Metrics

| **Field**        | **Type** | **Description** |
| --------------- | -------- | -------- |
| `error_message` | string   | Error message |
| `error_stack`   | string   | Error stack trace |

### Long Task

#### View Properties

| **Field**        | **Type** | **Description**                   |
| --------------- | -------- | -------------------------- |
| <del>`view_id`</del> | string   | <del>Unique ID generated each time a page is visited</del> |
| <del>`view_referrer`</del> | string   | <del>Page source, parent page</del> |
| <del>`view_name`</del> | string   | <del>Page name</del>        |

#### Action Properties

| **Field**      | **Type** | **Description**                            |
| ------------- | -------- | ----------------------------------- |
| <del>`action_id`</del> | string   | <del>Unique ID generated when the user operates on a page</del> |
| <del>`action_name`</del> | string   | <del>Operation name</del>                 |
| <del>`action_type`</del> | string   | <del>Operation type (cold/hot start, click, etc.)</del> |

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| <del>`duration`</del> | number(ns) | <del>Duration of the freeze</del> |
| <del>`long_task_message`</del> | string | <del>Freeze information</del> |
| <del>`long_task_stack`</del> | string | <del>Freeze stack trace</del> |

### Action

#### View Properties

| **Field**        | **Type** | **Description**                   |
| --------------- | -------- | -------------------------- |
| `view_id`       | string   | Unique ID generated each time a page is visited |
| `view_referrer` | string   | Page source, parent page       |
| `view_name`     | string   | Page name                   |

#### Action Properties

| **Field**      | **Type** | **Description**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | Unique ID generated when the user operates on a page          |
| `action_name` | string   | Operation name                            |
| `action_type` | string   | Operation type (cold/hot start, click, etc.) |

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `duration` | number(ns) | Time taken for the page operation |

#### Statistical Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| <del>`action_long_task_count`</del> | number | <del>Number of long tasks associated with the action</del> |
| `action_resource_count` | number | Number of resource requests associated with the action |
| `action_error_count` | number | Number of errors associated with the action |