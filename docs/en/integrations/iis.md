---
title     : 'IIS'
summary   : 'Collect IIS metrics'
__int_icon      : 'icon/iis'
dashboard :
  - desc  : 'IIS'
    path  : 'dashboard/zh/iis'
monitor   :
  - desc  : 'IIS'
    path  : 'monitor/zh/iis'
---

<!-- markdownlint-disable MD025 -->
# IIS
<!-- markdownlint-enable -->

---

:fontawesome-brands-windows:

---

Microsoft IIS collector

## Configuration {#config}

### Preconditions {#requirements}

Operating system requirements::

* Windows Vista and above (excluding Windows Vista)
* Windows Server 2008 R2 and above

### Collector Configuration {#input-config}

Go to the `conf.d/iis` directory under the DataKit installation directory, copy `iis.conf.sample` and name it `iis.conf`. Examples are as follows:

```toml

[[inputs.iis]]
  ## (optional) collect interval, default is 15 seconds
  interval = '15s'
  ##

  [inputs.iis.log]
    files = []
    ## grok pipeline script path
    pipeline = "iis.p"

  [inputs.iis.tags]
    ## tag1 = "v1"
    ## tag2 = "v2"
 
```

After configuration, restart DataKit.

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.iis.tags]`:

``` toml
  [inputs.iis.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    # ...
```

## Metric {#metric}





### `iis_app_pool_was`



- tag


| Tag | Description |
|  ----  | --------|
|`app_pool`|IIS app pool|
|`host`|Host name|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`current_app_pool_state`|The current status of the application pool (1 - Uninitialized, 2 - Initialized, 3 - Running, 4 - Disabling, 5 - Disabled, 6 - Shutdown Pending, 7 - Delete Pending).|float|-|
|`current_app_pool_uptime`|The uptime of the application pool since it was started.|float|s|
|`total_app_pool_recycles`|The number of times that the application pool has been recycled since Windows Process Activation Service (WAS) started.|float|-| 





### `iis_web_service`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`website`|IIS web site|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`anonymous_users`|Rate at which users are making anonymous connections using the web service.|float|-|
|`bytes_received`|Rate at which bytes are received by the web service.|float|B/S|
|`bytes_sent`|Rate at which bytes are sent by the web service.|float|B/S|
|`bytes_total`|Sum of bytes_sent and bytes_received. This is the total rate of bytes transferred by the web service.|float|B/S|
|`connection_attempts`|Rate at which connections using the web service are attempted.|float|-|
|`current_connections`|Current number of connections established with the web service.|float|-|
|`error_locked`|Rate of errors due to requests that cannot be satisfied by the server because the requested document was locked. These are generally reported as an HTTP 423 error code to the client.|float|count|
|`error_not_found`|Rate of errors due to requests that cannot be satisfied by the server because the requested document could not be found. These errors are generally reported as an HTTP 404 error code to the client.|float|count|
|`files_received`|Rate at which files are received by the web service.|float|-|
|`files_sent`|Rate at which files are sent by the web service.|float|-|
|`http_requests_delete`|Rate at which HTTP requests using the DELETE method are made.|float|req/s|
|`http_requests_get`|Rate at which HTTP requests using the GET method are made.|float|req/s|
|`http_requests_head`|Rate at which HTTP requests using the HEAD method are made.|float|req/s|
|`http_requests_options`|Rate at which HTTP requests using the OPTIONS method are made.|float|req/s|
|`http_requests_post`|Rate at which HTTP requests using the POST method are made.|float|req/s|
|`http_requests_put`|Rate at which HTTP requests using the PUT method are made.|float|req/s|
|`http_requests_trace`|Rate at which HTTP requests using the TRACE method are made.|float|req/s|
|`non_anonymous_users`|Rate at which users are making non-anonymous connections using the web service.|float|-|
|`requests_cgi`|Rate of CGI requests that are simultaneously processed by the web service.|float|req/s|
|`requests_isapi_extension`|Rate of ISAPI extension requests that are simultaneously processed by the web service.|float|req/s|
|`service_uptime`|Service uptime.|float|s|
|`total_connection_attempts`|Number of connections that have been attempted using the web service (counted after service startup)|float|count| 



## Log {#logging}

If you need to collect IIS logs, open the log-related configuration in the configuration, such as:

```toml
[inputs.iis.log]
    # Fill in the absolute path
    files = ["C:/inetpub/logs/LogFiles/W3SVC1/*"] 
```
