# Mini Program Application Data Collection
---

After application data is collected into <<< custom_key.brand_name >>>, you can perform custom configuration scenarios and configure anomaly detection events through the <<< custom_key.brand_name >>> console.

## Data Types

<<< custom_key.brand_name >>>'s RUM PV includes six data types:

| Type | Description |
| --- | --- |
| `session` | User session information records. During the current session, session-level user page, resource, action, error, and long task related access data will be recorded. |
| `view` | When a user visits a page, a page view record is generated. If the user stays on the same page, resources, long tasks, errors, and operation records are linked to the relevant RUM view via the `view_id` attribute. |
| `resource` | Records of resources loaded when a user visits a page. |
| `error` | All frontend errors collected by the RUM collector from the browser. |
| `long_task` | Any task blocking the main thread in the browser for more than 50ms generates a long task record. |
| `action` | Tracks all user interaction records during page browsing. |

## Global Properties

Scenarios for RUM and event alerts can be queried using the following global properties.

### SDK Properties

| Field | Type | Description |
| --- | --- | --- |
| `sdk_name` | string | Collector name, fixed names:<br>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string | Collector version information |

### Application Properties

| Field | Type | Description |
| --- | --- | --- |
| `app_id` | string | Required, unique ID identifying the monitored application, auto-generated when creating monitoring in the <<< custom_key.brand_name >>> console. |
| `env` | string | Required, environment field. Values: prod/gray/pre/common/local. Where:<br>prod: Production environment<br>gray: Gray release environment<br>pre: Pre-release environment<br>common: Daily environment<br>local: Local environment |
| `version` | string | Required, version number. |
| `app_launch_query` | string | Query parameters used to launch the mini program. |
| `app_launch_referrer_info` | string | Referrer information. Returned when entering the mini program from another mini program, public account, or App. |

> For more details, refer to [Field Descriptions](https://developers.weixin.qq.com/miniprogram/dev/api/base/app/life-cycle/wx.getLaunchOptionsSync.html).

### User & Session Properties

| Field | Type | Description |
| --- | --- | --- |
| `userid` | string | Unregistered users use cookies as `userid`, registered users use the user id generated by the application backend. |
| `session_id` | string | Session ID. |
| `session_type` | string | Session type. Reference values: user & synthetics<br>user: Data generated by RUM features;<br>synthetics: Data generated by headless dial testing. |
| `is_signin` | boolean | Whether it is a registered user, values: True / False. |

### Device & Resolution Properties

| Field | Type | Description |
| --- | --- | --- |
| `device` | string | Mobile device manufacturer |
| `model` | string | Mobile device model |
| `device_uuid` | string | Unique mobile device ID |
| `os` | string | Operating system information |
| `os_version` | string | Operating system version |
| `os_version_major` | string | Major operating system version |
| `screen_size` | string | Screen resolution |

### Geographic & Network Properties

| Field | Type | Description |
| --- | --- | --- |
| `ip` | string | User's IP address |
| `isp` | string | Internet Service Provider |
| `network_type` | string | Network connection type, reference values:<br>wifi & 2g & 3g & 4g & 5g & unknown (unknown network) & unreachable (unavailable network) |
| `country` | string | Country |
| `country_iso_code` | string | Country ISO code |
| `province` | string | Province |
| `city` | string | City |

### Platform & Library Version Properties

| Field | Type | Description |
| --- | --- | --- |
| `platform` | string | The platform where the mini program resides, e.g., WeChat mini program's platform is wechat |
| `platform_version` | string | Version of the app platform where the mini program resides |
| `app_framework_version` | string | Mini program base library version |

## Custom Properties

In addition to global properties, custom properties (**SDK supports custom tag data**) can be used to build scenarios and configure event alerts. Custom properties are non-global properties. By using custom properties, you can track the entire process of user visits, identify and discover affected user visits, and monitor user visit performance.

## Other Data Type Properties

### Session 

#### Properties

| Field | Type | Description |
| --- | --- | --- |
| `session_id` | string | Session ID |
| `session_type` | string | Session type. Reference values: user & test<br>user: Data generated by RUM features;<br>test: Data generated by headless dial testing. |
| `session_referrer` | string | Session referrer; usually records the source page URL |
| `session_first_view_id` | string | `view_id` of the first page in the current session |
| `session_first_view_name` | string | Name of the first page in the current session |
| `session_last_view_id` | string | `view_id` of the last visited page in the current session |
| `session_last_view_name` | string | Name of the last page in the current session |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| `time_spent` | number(ns) | Duration of the current session |
| `session_view_count` | number | Number of associated `view_id`s in the current session |
| `session_error_count` | number | Number of errors in the current session |
| `session_resource_count` | number | Number of resources loaded in the current session |
| `session_action_count` | number | Number of user operations in the current session |
| `session_long_task_count` | number | Number of long tasks in the current session |

### View 

#### Properties

| Field | Type | Description |
| --- | --- | --- |
| `view_id` | string | Unique ID generated each time a page is visited |
| `view_referrer` | string | Page referrer |
| `view_name` | string | Page URL |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| `loading_time` | number(ns) | Page loading time |
| `first_paint_time` | number(ns) | First paint time<br>Calculation method: onShow (first page) - onLaunch (app) |
| `time_spent` | number(ns) | Time spent on the page |
| `onload_to_onshow` | number(ns) | Time from page onload to onshow |
| `onshow_to_onready` | number(ns) | Time from page onshow to onready |
| `onready` | number(ns) | Page onready time |
| `setdata_duration` | number(ns) | Total `set_data` duration (sum of all setedate durations under one `view_id`) |
| `is_active` | boolean | Indicates whether the user is still active, reference values: true & false |

#### Statistical Metrics

| Field | Type | Description |
| --- | --- | --- |
| `view_error_count` | number | Number of errors that occurred during page loading |
| `view_resource_count` | number | Number of resources requested during page loading |
| `view_long_task_count` | number | Number of long tasks generated during page loading |
| `view_action_count` | number | Number of operations during page viewing |
| `view_setdata_count` | number | Number of `set_data` calls during page viewing |
| `view_apdex_level` | number | Page first paint |

### Resource

#### View Properties

| Field | Type | Description |
| --- | --- | --- |
| `view_id` | string | Unique ID generated each time a page is visited |
| `view_referrer` | string | Page referrer |
| `view_name` | string | Page URL |

#### Resource Properties

| Field | Type | Description |
| --- | --- | --- |
| `resource_url` | string | Resource URL |
| `resource_url_host` | string | Domain part of the resource URL |
| `resource_url_path` | string | Path part of the resource URL |
| `resource_url_query` | string | Query part of the resource URL |
| `resource_url_path_group` | string | Grouped path part of the resource URL |
| `resource_type` | string | Resource category |
| `resource_method` | string | Resource request method |
| `resource_status` | string | Status value returned by the resource request |
| `resource_status_group` | string | Grouped status value returned by the resource request |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| `resource_size` | number | Resource size, default unit: byte |
| `resource_dns` | number(ns) | DNS resolution time for resource loading<br>Calculation method: domainLookupEnd - domainLookupStart |
| `resource_tcp` | number(ns) | TCP connection time for resource loading<br>Calculation method: connectEnd - connectStart |
| `resource_ssl` | number(ns) | SSL connection time for resource loading<br>Calculation method: connectEnd - secureConnectStart |
| `resource_ttfb` | number(ns) | Request response time for resource loading<br>Calculation method: responseStart - requestStart |
| `resource_trans` | number(ns) | Content transfer time for resource loading<br>Calculation method: responseEnd - responseStart |
| `resource_first_byte` | number(ns) | First byte time for resource loading<br>Calculation method: responseStart - domainLookupStart |
| `duration` | number(ns) | Resource loading time<br>Calculation method: duration(responseEnd-startTime) |

### Error

#### View Properties

| Field | Type | Description |
| --- | --- | --- |
| `view_id` | string | Unique ID generated each time a page is visited |
| `is_active` | boolean | Indicates whether the user is still active, reference values: true & false |
| `view_referrer` | string | Page referrer |
| `view_name` | string | Page URL |

#### Error Properties

| Field | Type | Description |
| --- | --- | --- |
| `error_source` | string | Error source, reference values: console & network & source & custom |
| `error_type` | string | Error type, reference link: [error type](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error) |
| `resource_status` | string | Status value returned by the resource request |
| `resource_url` | string | Resource URL |
| `resource_url_host` | string | Domain part of the resource URL |
| `resource_url_path` | string | Path part of the resource URL |
| `resource_url_path_group` | string | Grouped path part of the resource URL |
| `resource_method` | string | Resource request method |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| `error_message` | string | Error message |
| `error_stack` | string | Error stack |

### Long Task

#### View Properties

| Field | Type | Description |
| --- | --- | --- |
| `view_id` | string | Unique ID generated each time a page is visited |
| `is_active` | boolean | Indicates whether the user is still active, reference values: true & false |
| `view_referrer` | string | Page referrer |
| `view_name` | string | Page URL |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| `duration` | number(ns) | Time spent on long tasks during page loading |

### Action

#### View Properties

| Field | Type | Description |
| --- | --- | --- |
| `view_id` | string | Unique ID generated each time a page is visited |
| `is_active` | boolean | Indicates whether the user is still active, reference values: true & false |
| `view_referrer` | string | Page referrer |
| `view_name` | string | Page URL |

#### Action Properties

| Field | Type | Description |
| --- | --- | --- |
| `action_id` | string | Unique ID generated when a user performs an action on the page |
| `action_name` | string | Action name |
| `action_type` | string | Action type:<br>launch - launch (no view-related information)<br>package_download - package download (no view-related information)<br>script_insert - script injection (no view-related information)<br>click, etc. |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| `duration` | number(ns) | Time spent on the action |

#### Statistical Metrics

| Field | Type | Description |
| --- | --- | --- |
| `action_long_task_count` | number | Number of long tasks associated with the action |
| `action_resource_count` | number | Number of resource requests associated with the action |
| `action_error_count` | number | Number of errors associated with the action |