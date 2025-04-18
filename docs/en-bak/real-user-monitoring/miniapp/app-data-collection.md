# Miniapp Application Data Collection
---

## Overview

After collecting application data and reporting it to the guance, you can customize the configuration scene and configure anomaly detection events through the Guance console.

## Data Type

Real User Monitoring of Guance includes six data types.

| Type | Description |
| --- | --- |
| `session` | User session information records, in the current session, will be based on the session dimension of user pages, resources, actions, errors, long task related access data. |
| `view` | When a user accesses a page, a page view record is generated. When the user stays on the same page, the resource, long task, error, and action records are linked to the relevant RUM view through the view_id attribute. |
| `resource` | The resource information record loaded when the user accesses the page. |
| `error` | The Real User Monitoring collector collects all front-end errors on the browser. |
| `long_task` | A long task record is generated for any task in the browser that blocks the main thread for more than 50ms. |
| `action` | Track all user interaction records during user page browsing. |

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

| **Fields**       | **Type** | **Description**                                                     |
| -------------- | -------- | ------------------------------------------------------------ |
| `userid`       | string   | User ID. Unlogged-in users use the cookie as the userid, and logged-in users use the userid generated in the application background. |
| `session_id`   | string   | ID of the session.       |
| `session_type` | string   | Session Type. <br>user: Data generated by RUM functionality. <br>synthetics: headless data generated by dialing test. |
| `is_signin`    | boolean  | Is it a registered user.                       |

### Device & Resolution Properties

| **Fields**           | **Type** | **Description**         |
| :----------------- | :------- | :--------------- |
| `device`           | string   | Device     |
| `model`            | string   | Device model     |
| `device_uuid`      | string   | Device unique id   |
| `os`               | string   | The OS name as reported by the device     |
| `os_version`       | string   | The OS version as reported by the device     |
| `os_version_major` | string   | The OS version major as reported by the device |
| `screen_size`      | string   | Screen resolution       |

### Geographic & Network Properties

| Fields             | Type   | Description                                                  |
| ------------------ | ------ | ------------------------------------------------------------ |
| `ip`               | string | IP                                               |
| `isp`              | string | ISP                                                      |
| `network_type`     | string | Network connection type, e.g. wifi/2g/3g/4g/5g, unknown/unreachable |
| `country`          | string | Country                                                        |
| `country_iso_code` | string | Country iso code                                                |
| `province`         | string | Province                                                          |
| `city`             | string | City                                                         |

### Platform & Library Version Properties

| **Fields** | **Type** | **Description** |
| --- | --- | --- |
| `platform` | string | The app platform where the applet is located, e.g. Wechat |
| `platform_version` | string | The version of the app platform where the applet is located |
| `app_framework_version` | string | Applet base repository |

## Custom Properties

In addition to global properties, you can also build scenarios and configure event alerts through custom properties (**SDK supports users to type custom tag data **). Custom properties are non-global properties. Through custom properties, we can track the whole process of users accessing applications, locate and discover the affected access conditions of users, and monitor the access performance of users.

## Other Data Type Properties

### Session 

#### Properties

| Fields | Type | Description |
| --- | --- | --- |
| `session_id` | string | ID of the session. (A new session_id will be generated if the backend stays for more than 30s) |
| `session_type` | string | Session Type. <br>user: Data generated by RUM functionality. <br>synthetics: headless data generated by dialing test. |
| `session_referrer` | string | Session source. The page address used to record the source. |
| `session_first_view_id` | string | The view_id of the first page of the current session |
| `session_first_view_name` | string | URL of the first page of the current session |
| `session_last_view_id` | string | The view_id of the last page visited by the current session |
| `session_last_view_name` | string | URL of the last page of the current session |

#### Metrics

| Fields                    | Type       | Description               |
| ------------------------- | ---------- | ------------------------- |
| `time_spent`              | number(ns) | Duration of the user session. [Unit: ns]          |
| `session_view_count`      | number     | Count of all views collected for this session. |
| `session_error_count`     | number     | Count of all errors collected for this session.      |
| `session_resource_count`  | number     | Count of all resources collected for this session.      |
| `session_action_count`    | number     | Count of all actions collected for this session.      |
| `session_long_task_count` | number     | Count of all long tasks collected for this session.    |


### View 

#### Properties

| **Fields**        | **Type** | **Description**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | Unique ID for each page view.                      |
| `view_referrer` | string   | The URL of the previous web page from which a link to the currently requested page was followed.                            |
| `view_name`     | string   | View URL                                        |

#### Metrics

| Fields | Type | Description |
| --- | --- | --- |
| `loading_time` | number（ns） | Page loading time |
| `first_paint_time` | number（ns） | First rendering time<br>Unit: ns<br>Calculation: responseEnd - fetchStart |
| `time_spent` | number（ns） | Page dwell time |
| `onload_to_onshow` | number（ns） | Page onload time to onshow time consuming |
| `onshow_to_onready` | number（ns） | Page onshow time to onready time consuming |
| `onready` | number（ns） | Page onready time |
| `setdata_duration` | number（ns） | Total time spent on page set_data (sum of time spent on all setedates under one view_id) |
| `is_active`     | boolean  | Judge whether the user is still active. |

#### Statistical Metrics

| Fields                 | Type   | Description                                                  |
| --- | --- | --- |
| `view_error_count` | number | Count of all errors collected for the view. |
| `view_resource_count` | number | Count of all resources collected for the view. |
| `view_long_task_count` | number | Count of all long tasks collected for the view. |
| `view_action_count` | number | Count of all actions collected for the view. |
| `view_setdata_count` | number | Number of page set_data calls |
| `view_apdex_level` | number | First paint time |

### Resource

#### View Properties

| **Fields**        | **Type** | **Description**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | Unique ID for each page view.                      |
| `is_active`     | boolean  | Judge whether the user is still active. |
| `view_referrer` | string   | The URL of the previous web page from which a link to the currently requested page was followed.                            |
| `view_name`     | string   | View URL                                        |

#### Resource Properties

| Fields                    | Type   | Description              |
| ------------------------- | ------ | ------------------------ |
| `resource_url`            | string | The resource URL.                 |
| `resource_url_host`       | string | The host part of the URL.        |
| `resource_url_path`       | string | The path part of the URL.       |
| `resource_url_query`      | string | The query string parts of the URL decomposed as query params key/value attributes.      |
| `resource_url_path_group` | string | The path part of the URL group.       |
| `resource_type`           | string | The type of resource being collected.               |
| `resource_method`         | string | The HTTP method.<br>e.g. POST/GET             |
| `resource_status`         | string | The response status.     |
| `resource_status_group`   | string | The response status code. |

#### Metrics

| Fields                | Type         | Description                                                  |
| --- | --- | --- |
| `resource_size` | number | Resource size.<br>Unit: ns |
| `resource_dns` | number（ns） | Time spent resolving the DNS name of the last request.<br>Unit: ns<br>Calculation: domainLookupEnd - domainLookupStart |
| `resource_tcp` | number（ns） | Time spent for the TCP handshake.<br>Unit: ns<br>Calculation: connectEnd - connectStart |
| `resource_ssl` | number（ns） | Time spent for the TLS handshake.<br>Unit: ns<br>Calculation: connectEnd - secureConnectStart |
| `resource_ttfb` | number（ns） | Time spenton on request response.<br>Unit: ns<br>Calculation: responseStart - requestStart |
| `resource_trans` | number（ns） | Time spenton  on content transfer.<br>Unit: ns<br>Calculation: responseEnd - responseStart |
| `resource_first_byte` | number（ns） | Time spent waiting for the first byte of response to be received. <br>Unit: ns<br>Calculation: responseStart - domainLookupStart |
| `duration` | number（ns） | Resource loading time.<br>Calculation: duration(responseEnd-startTime) |

### Error

#### View Properties

| **Fields**        | **Type** | **Description**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | Unique ID for each page view.                      |
| `is_active`     | boolean  | Judge whether the user is still active. |
| `view_referrer` | string   | The URL of the previous web page from which a link to the currently requested page was followed.                            |
| `view_name`     | string   | View URL                                        |

#### Error Properties

| **Fields** | **Type** | **Description** |
| --- | --- | --- |
| `error_source` | string | Where the error originates from. e.g. console &#124; network &#124; source &#124; custom |
| `error_type` | string | The error type, e.g. [error type](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error) |
| `resource_status` | string | The response status. |
| `resource_url` | string | The resource URL. |
| `resource_url_host` | string | The host part of the URL. |
| `resource_url_path` | string | The path part of the URL. |
| `resource_url_path_group` | string | The path part of the URL group. |
| `resource_method` | string | The HTTP method.<br>e.g. POST/GET |

#### Metrics

| **Fields** | **Type** | **Description** |
| --- | --- | --- |
| `error_message` | string | Error message |
| `error_stack` | string | Error stack |

### Long Task

#### View Properties

| **Fields**        | **Type** | **Description**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | Unique ID for each page view.                      |
| `is_active`     | boolean  | Judge whether the user is still active. |
| `view_referrer` | string   | The URL of the previous web page from which a link to the currently requested page was followed.                            |
| `view_name`     | string   | View URL                                        |

#### Metrics

| Fields     | Type         | Description                    |
| --- | --- | --- |
| `duration` | number（ns） | Long task spend time generated on page load. |

### Action

#### View Properties

| **Fields**        | **Type** | **Description**                                        |
| :-------------- | :------- | :---------------------------------------------- |
| `view_id`       | string   | Unique ID for each page view.                      |
| `is_active`     | boolean  | Judge whether the user is still active. |
| `view_referrer` | string   | The URL of the previous web page from which a link to the currently requested page was followed.                            |
| `view_name`     | string   | View URL                                        |

#### Action Properties

| Fields        | Type   | Description                 |
| ------------- | ------ | --------------------------- |
| `action_id`   | string | Unique ID generated when the user operates on the page. |
| `action_name` | string | Action name                    |
| `action_type` | string | Action type <br> Start-launch (without view-related information) <br> Applet download-package_download (without view-related information) <br> Script injection-script_insert (without view-related information) <br> click-click and so on                   |


#### Metrics

| Fields     | Type         | Description      |
| --- | --- | --- |
| `duration` | number（ns） | Time spent on page operations. |

#### Statistical Metrics

| Fields                   | Type   | Description          |
| --- | --- | --- |
| `action_long_task_count` | number | Number of operations associated with long tasks. |
| `action_resource_count` | number | Number of requests to operate associated resources. |
| `action_error_count` | number | Number of errors associated with the operation. |
