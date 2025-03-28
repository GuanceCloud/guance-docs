# UniApp Application Data Collection
---

## Overview

UniApp data collection relies on the Android iOS Native framework, and for comparison with Android iOS data collection, the following strikethrough tag items are not implemented.

## Data Type

RUM of Guance includes six data types.

| **Type** | **Description** |
| --- | --- |
| session | User session information records, in the current session, will be based on session dimensions user pages, resources, actions, errors, long task-related access data. |
| view | Every time a user accesses a page of the mobile application, a view record is generated. When the user stays on the same page, the resource, long task, error, and action records are linked to the relevant RUM view through the view_id attribute. |
| resource | The resource information record loaded when the user accesses the page. |
| error | An exception or crash from a mobile application. |
| <del>long_task</del> | <del>A long task event is generated for any task in the application that blocks the main thread beyond the specified duration threshold. </del>|
| action | Record user activities in mobile applications (application launch, click, slide, back, etc.). Each action is attached with a unique action_id. |


## Global Attributes

Scene construction and event alerts for RUM can be queried through the following global attributes.

### SDK Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `sdk_name` | string | Collector name, fixed name: <br>`df_web_rum_sdk`<br>`df_miniapp_rum_sdk`<br>`df_ios_rum_sdk`<br>`df_android_rum_sdk` |
| `sdk_version` | string | Collector version information |

### Application Attributes

| Field | Type | Descript ion |
| --- | --- | --- |
| `app_id` | string | Required, the user accesses the unique ID of the application, which is automatically generated when the monitor is created on the Guance studio. |
| `env` | string |Required, environment field. Attribute value: pro/gray/pre/common/local. Where<br>prod: online environment<br>gray: gray environment<br>pre: pre-release environment<br>common: daily environment<br>local: local environment |
| `version` | string | Required, version number. |

### User & Session Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `userid` | string | Unlogged-in users use the cookie as the userid, and logged-in users use the user id generated in the application background. |
| `session_id` | string | Session id |
| `session_type` | string | Session type. Reference value: user &#124; synthetics<br>user indicates that it is the data generated by RUM function;<br>synthetics indicates that the data is generated by headless dialing test. |
| `is_signin` | boolean | Whether a registered user, property value: True / False. |

### Equipment & Resolution Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `device` | string | Mobile device manufacturer |
| `model` | string | Mobile device model |
| `device_uuid` | string | Mobile device unique id |
| `os` | string | Operating system information |
| `os_version` | string | Operating system version |
| `os_version_major` | string | Operating system version |
| `screen_size` | string | Screen resolution |

### Geography & Network Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `ip` | string | User Access IP Address |
| `isp` | string | Operator |
| `network_type` | string | Network connection type, attribute value reference:
wifi &#124; 2g &#124; 3g &#124; 4g &#124; 5g &#124; unknown &#124; unreachable |
| `country` | string | Country |
| `country_iso_code` | string | Country iso_code |
| `province` | string | Province |
| `city` | string | City |

## Custom Attributes

In addition to global attributes, you can also build scenarios and configure event alerts through custom attributes (**SDK supports users to type custom tag data**). Custom attributes are non-global attributes. Through custom attributes, we can track the whole process of users accessing applications, locate and discover the affected access conditions of users, and monitor the access performance of users.

## Other Data Type Attributes

### Session 

#### Attributes

| Field                      | Type   | Description                                                         |
| ------------------------- | ------ | ------------------------------------------------------------ |
| `session_id`              | string | Session id (staying in the background for more than 30s will generate a new session_id).          |
| `session_type`            | string | Session type. Reference value: user &#124; test<br>The user representation is the data generated by the RUM functionality;<br>Test indicates the data generated by headless dialing test. |
| `session_referrer`        | string | Session source. Typically, it is the page address of the record source.                         |
| `session_first_view_id`   | string | The view_id of the first page of the current session.                                |
| `session_first_view_name` | string | The URL of the first page of the current session.                                    |
| `session_last_view_id`    | string | The view_id of the last page visited by the current session.                          |
| `session_last_view_name`  | string | The URL of the last page of the current session.                                  |

#### Statistical Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `time_spent` | number(ns) | Duration of current session |
| `session_view_count` | number | Number of current session associated view_id |
| `session_error_count` | number | Number of errors generated by the current session |
| `session_resource_count` | number | Number of resources loaded in the current session |
| `session_action_count` | number | Number of user operations in the current session |
| <del>`session_long_task_count`</del> | number | <del>Number of long tasks generated in the current session</del> |

### View 

#### Attributes

| **Field**        | **Type** | **Description**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | Unique ID generated every time the page is accessed                          |
| `view_referrer` | string   | Page source, parent of page                                |
| `view_name`     | string   | Page name                                            |

#### Metrics

| Field | Type | Description |
| --- | --- | --- |
| <del>`loading_time`</del> | number（ns） | <del>Page loading time</del> |
| `time_spent` | number（ns） | Page dwell time |
| `is_active`     | boolean  | Judge whether the user is still active. |

#### Statistical Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `view_error_count` | number | Number of errors per page load |
| `view_resource_count` | number | Number of resources requested per page load |
| <del>`view_long_task_count`</del>| number | <del>Number of long tasks generated per page load</del> |
| `view_action_count` | number | Number of actions during page viewing |

### Resource

#### View Attributes

| **Field**        | **Type** | **Description**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | Unique ID generated every time the page is accessed                          |
| `is_active`     | boolean  | Judge whether the user is still active, reference value: true &#124; false |
| `view_referrer` | string   | Page source, parent of page                                |
| `view_name`     | string   | Page name                                            |

#### Action Attributes

| **Field**     | **Type** | **Description**                                        |
| ------------- | -------- | ------------------------------------------------------ |
| `action_id`   | string   | Unique ID generated when the user operates on the page |
| `action_name` | string   | Operation name                                         |
| `action_type` | string   | Operation type (hot and cold start, click click, etc.) |

#### Resource Attributes

| **Field**                  | **Type** | **Description**                 |
| ------------------------- | -------- | ------------------------ |
| `resource_url`            | string   | Resource URL                  |
| `resource_url_host`       | string   | Resource URL domain name section         |
| `resource_url_path`       | string   | Resource URL path section         |
| `resource_url_query`      | string   | Resource URL query section        |
| `resource_url_path_group` | string   | Resource URL path grouping         |
| `resource_type`           | string   | Category of resources               |
| `resource_method`         | string   | Resource request mode             |
| `resource_status`         | string   | Status value returned by resource request     |
| `resource_status_group`   | string   | Status grouping value returned by resource request |

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| <del>`resource_size` </del>| number | <del>Resource size, default unit: bytes </del>||
| <del>`resource_dns` </del>| number（ns） | <del>Resource load DNS resolution time<br>Calculation method: domainLookupEnd - domainLookupStart </del>|
| <del>`resource_tcp` </del>| number（ns） | <del>Resource load TCP connection time<br>Calculation method: connectEnd - connectStart</del>|
| <del>`resource_ssl` </del>| number（ns） |<del> Resource load SSL connection time<br>Calculation method: connectEnd - secureConnectStart </del>|
| <del>`resource_ttfb`</del>| number（ns） | <del>Resource load request response time<br>Calculation method: responseStart - requestStart</del> |
|<del> `resource_trans` </del>| number（ns） | <del>Resource load content transfer time<br>Calculation method: responseEnd - responseStart </del>|
| <del>`resource_first_byte` </del>| number（ns） | <del>First packet time of resource loading<br>Calculation method: responseStart - domainLookupStart </del>|
| <del>`duration`</del>| number（ns） | <del>Resource load time<br>Calculation method: duration(responseEnd-startTime) </del>|
| `request_header` | string | Resource http request header |
| `response_header` | string | Resource http response header |

### Error

#### View Attributes

| **Field**        | **Type** | **Description**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | Unique ID generated every time the page is accessed                          |
| `view_referrer` | string   | Page source, parent of page                                |
| `view_name`     | string   | Page name                                            |

#### Action Attributes

| **Field**     | **Type** | **Description**                                        |
| ------------- | -------- | ------------------------------------------------------ |
| `action_id`   | string   | Unique ID generated when the user operates on the page |
| `action_name` | string   | Operation name                                         |
| `action_type` | string   | Operation type (hot and cold start, click click, etc.) |

#### Error Attributes

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `error_message` | string | Error message |
| `error_stack` | string | Error stack |
| `error_source` | string | Error source, reference value: logger &#124; network |
| `error_type` | string | Error type<br>logger error type: java_crash &#124; native_crash &#124; abort &#124; ios_crash<br>network error type： |
| `error_situation` | string | When the error occurred, reference values: startup and run |

**When type=network, add the following Network Error attribute.**

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `resource_status` | string | Status value returned by resource request |
| `resource_url` | string | Resource URL |
| `resource_url_host` | string | Resource URL domain name section |
| `resource_url_path` | string | Resource URL path section|
| `resource_url_path_group` | string | Resource URL path grouping|
| `resource_method` | string | Resource request mode |

### Long Task

#### View Attributes

| **Field**        | **Type** | **Description**                                            |
| --------------- | -------- | --------------------------------------------------- |
| <del>`view_id`</del> | string   | <del>Unique ID generated every time the page is accessed</del>               |
| <del>`is_active`</del> | boolean  | <del>Judge whether the user is still active, reference value: true &#124; false</del> |
| <del>`view_referrer`</del> | string   | <del>Page source, parent of page</del>                     |
| <del>`view_name`</del> | string   | <del>Page name</del>                                 |

#### Action Attributes

| **Field**                | **Type** | **Description**                                              |
| ------------------------ | -------- | ------------------------------------------------------------ |
| <del>`action_id`</del>   | string   | <del>Unique ID generated when the user operates on the page</del> |
| <del>`action_name`</del> | string   | <del>Operation name</del>                                    |
| <del>`action_type`</del> | string   | <del>Operation type (hot and cold start, click click, etc.)</del> |

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| <del>`duration`</del> | number（ns） | <del>Carton duration</del> |
| <del>`long_task_message`</del> | string | <del>Carton info</del> |
| <del>`long_task_stack`</del> | string | <del>Carton stack</del> |

### Action

#### View Attributes

| **Field**        | **Type** | **Description**                                            |
| --------------- | -------- | --------------------------------------------------- |
| `view_id`       | string   | Unique ID generated every time the page is accessed                          |
| `is_active`     | boolean  | Judge whether the user is still active, reference value: true &#124; false |
| `view_referrer` | string   | Page source, parent of page                                |
| `view_name`     | string   | Page name                                            |

#### Action Attributes

| **Field**      | **Type** | **Description**                            |
| ------------- | -------- | ----------------------------------- |
| `action_id`   | string   | Unique ID generated when the user operates on the page          |
| `action_name` | string   | Operation name                            |
| `action_type` | string   | Operation type (hot and cold start, click click, etc.)|

#### Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `duration` | number（ns） | Page operation takes time |

#### Statistical Metrics

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| `action_long_task_count` | number | Number of operations associated with long tasks |
| `action_resource_count` | number | Number of requests to operate associated resources |
| `action_error_count` | number | Number of errors associated with the operation |



