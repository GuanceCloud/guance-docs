# C# Application Integration
---
## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [publicly accessible and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#integration}
The current C# version supports Windows and Linux platforms. Log in to the <<< custom_key.brand_name >>> console, navigate to the "User Analysis" page, click on "Create" in the top-left corner, and start creating a new application.

1. Enter the "Application Name", "Application ID", and select the "Custom" application type

- Application Name: Used to identify the RUM-monitored application.
- Application ID: The unique identifier for the application within the current workspace, corresponding field: app_id. This field only supports English letters, numbers, and underscores, with a maximum of 48 characters.

![](../img/image_14.png)

## Installation {#install}

- Install the [C++ SDK](../cpp/app-access.md#install)
- Use C# [FTWrapper.cs](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk-wrapper-sample/FTWrapper.cs)
- Adjust the FTWrapper.cs DLL path

```csharp
//class FTWrapper.cs

const string dllName = "C:\\{vcpkg_root}\\vcpkg\\installed\\{platform}\\bin\\ft-sdk.dll";

[DllImport(dllName)]
public static extern void Install(string jsonConfig);
...

```

`vcpkg_root` is the `vcpkg` installation directory, and `platform` is the CPU architecture and operating system, e.g., `x64-windows`.

## Initialization
```csharp
FTWrapper.Install(@"
{
    ""serverUrl"": ""http://10.0.0.1:9529"",
    ""envType"": ""prod"",
    ""serviceName"": ""Your Services"",
    ""globalContext"": {
        ""custom_key"": ""custom value""
    }
}");

```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| serverUrl | string | Yes | URL address of the datakit installation, example: http://10.0.0.1:9529, default port is 9529. **Note: The device installing the SDK must be able to access this address** |
| envType | enum | No | Environment configuration, default is `prod` |
| appVersion | enum | No | Automatically obtained for Windows, needs manual assignment for Linux |
| enableFileDBCache | bool | No | Whether to enable local database, default is false |
| globalContext | dictionary | No | Add global properties to the SDK, rules for adding are available [here](#key-conflict) |
| serviceName | string | No | Affects the `service` field data in Logs and RUM, defaults to `df_rum_windows` for Windows and `df_rum_linux` for Linux |

### JSON Configuration File
Configure the `json` file to enable SDK debug logs in the same directory as the application execution

```json
{    
    "general_config": {
        "enable_sdk_log": true  // Enable debug logs, default is off
    }
}
```

### RUM Configuration
```csharp
FTWrapper.InitRUMConfig(@"
{
    ""appId"": ""appid_win_xxxxxx"",
    ""sampleRate"": 0.8,
    ""globalContext"": {
        ""rum_custom"": ""rum custom value""
    }
}");
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| appId | string | Yes | Corresponds to the RUM `appid`, required to enable RUM collection, [method to obtain appid](#integration) |
| sampleRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1. Applies to all View, Action, LongTask, Error data under the same session_id |
| extraMonitorTypeWithError | string | No | Adds additional monitoring data to RUM crash data, `memory` for memory usage, `cpu` for CPU usage, `all` for both |
| globalContext | dictionary | No | Add label data for user monitoring data source differentiation. If using tracking functionality, set `key` to `track_id` and `value` to any number. Rules for adding are available [here](#key-conflict) |

### Log Configuration
```csharp
FTWrapper.InitLogConfig(@"
{
    ""sampleRate"": 0.9,
    ""enableCustomLog"": true,
    ""enableLinkRumData"": true,
    ""globalContext"": {
        ""log_custom"": ""log custom value""
    }
}");
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| globalContext | dictionary | No | Add label data, rules for adding are available [here](#key-conflict) |
| logLevelFilters | array | No | Set log level filters, options: `ok`, `info`, `warning`, `error`, `critical`, default is none |
| enableCustomLog | bool | No | Whether to upload custom logs, default is `false` |
| logCacheDiscardStrategy | string | No | `discard` discards appended data, `discard_oldest` discards old data, default is `discard` |

### Trace Configuration
```csharp
FTWrapper.InitTraceConfig(@"
{
    ""sampleRate"": 0.9,
    ""traceType"": ""ddtrace"",
    ""enableLinkRumData"": true
}");
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| traceType | enum | No | Default is `ddtrace`, currently supports `zipkin`, `jaeger`, `ddtrace`, `skywalking` (8.0+), `traceParent` (W3C). When integrating with OpenTelemetry, please refer to supported types and agent configurations |
| enableLinkRUMData | bool | No | Whether to link with RUM data, default is `false` |

## RUM User Data Tracking
Currently, RUM data transmission can only be achieved through manual method calls.

### Action
#### Usage
```csharp
/**	
 * Start an action
 * 
 * @param actionName action name
 * @param actionType action type
 */
void StartAction(string actionName, string actionType);
		
```

#### Code Example
```csharp
FTWrapper.StartAction("click", "test");
```

### View
#### Usage
```csharp
/**
 * Start a view.
 * 
 * @param viewName current page name
 */
void StartView(string viewName);

/**
 * Stop a view.
 * 
 */
void StopView();
```

#### Code Example

```csharp
FTWrapper.StartView("TEST_VIEW_ONE");

FTWrapper.StopView();
```

### Resource
#### Usage
```csharp
/**
 * Start a resource
 * 
 * @param resourceId resource Id
 */
void StartResource(string resourceId)
	
/**
 * Stop a resource
 * 
 * @param resourceId resource Id
 */
void StopResource(string resourceId)


/**
 * Set network transmission content
 * 
 * @param resourceId resource Id
 * @param params network transmission parameters
 * @param netStatusBean network status statistics
 */
void AddResource((string resourceId, string resourceParams, string netStatus);

```
##### netStatus

| **Method** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| fetchStartTime | long | No | Request start time, ns |
| tcpTime | long | No | TCP connection time, ns |
| dnsTime | long | No | DNS resolution time, ns |
| responseTime | long | No | Response content transmission time, ns |
| sslTime | long | No | SSL connection time, ns |
| firstByteTime | long | No | Total time from DNS resolution to receiving the first data packet, ns |
| ttfb | long | No | Time from sending request to receiving the first response packet, ns |
| tcpStartTime | long | No | TCP connection start time, ns |
| tcpEndTime | long | No | TCP connection end time, ns |
| dnsStartTime | long | No | DNS start time, ns |
| dnsEndTime | long | No | DNS end time, ns |
| responseStartTime | long | No | Response start time, ns |
| responseEndTime | long | No | Response end time, ns |
| sslStartTime | long | No | SSL start time, ns |
| sslEndTime | long | No | SSL end time, ns |

##### resourceParams
| **Method** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| url | string | Yes | URL address |
| requestHeader | string | No | Request header parameters, no format restrictions |
| responseHeader | string | No | Response header parameters, no format restrictions |
| responseConnection | string | No | Response connection |
| responseContentType | string | No | Response ContentType |
| responseContentEncoding | string | No | Response ContentEncoding |
| resourceMethod | string | No | Request method GET, POST, etc. |
| responseBody | string | No | Response body content |

#### Code Example
```csharp
FTWrapper.StartResource(resourceId);

FTWrapper.StopResource(resourceId);

FTWrapper.AddResource(resourceId, @"
            {
                ""url"": ""https://api.fxbsports.com/commune"",
                ""requestHeader"": ""key1=value1,key2=value2"",
                ""responseHeader"": ""key1=value1,key2=value2"",
                ""resourceStatus"": 200
            }",
            @"{
                ""dnsTime"": 0,
                ""tcpTime"": 0,
                ""sslTime"": 0,
                ""ttfb"": 0
            }");

```

### Error
#### Usage
```csharp
/**
 * Add error information
 * 
 * @param log log
 * @param message message
 * @param errorType error type
 * @param state program state
 */
void AddError(string log, string message, string errorType, string state);
```

##### errorType

| **Method** | **Description** |
| --- | --- |
| native_crash | Application error |
| network_error | Network error |

##### state

| **Method** | **Description** |
| --- | --- |
| unknown | Unknown |
| startup | Startup |
| run | Running |

#### Code Example
```csharp
FTWrapper.AddError("error", "error msg", "native_crash", "run");
```

### LongTask
#### Usage
```csharp
/**
 * Add a long-running task
 * 
 * @param log log
 * @param duration duration(ns)
 */
void AddLongTask(string log, long duration)
```

#### Code Example
```csharp
FTWrapper.AddLongTask("long task test", 100002);
```

## Log Logging
### Usage
```csharp
/**
  * Upload user logs to datakit
  * @param content log content
  * @param level log level
  */
void AddLog(string log, string level);
```
### level

| **Method** | **Meaning** |
| --- | --- |
| info | Information |
| warning | Warning |
| error | Error |
| critical | Critical |
| ok | Recovery |

### Code Example
```csharp
FTWrapper.AddLog("test log", "info");
```

## Tracer Network Link Tracking
Tracing is achieved by generating a Trace Header and adding it to the HTTP request headers.

### Usage
```csharp
/**
 * Generate trace header based on configuration
 * 
 * @param url network address
 * @return trace header data
 */
 IntPtr GetTraceHeaderWithUrl(string url);
 
 
 /**
 * Generate trace header based on configuration
 * 
 * @param url network address
 * @param resourceId  
 * @return trace header data
 */
 IntPtr GetTraceHeader(string resourceId, string url);
```

### Code Example
```csharp
IntPtr headData = FTWrapper.GetTraceHeader(resourceId, FAKE_URL);
string headString = Marshal.PtrToStringAnsi(headData);

IntPtr headData = FTWrapper.GetTraceHeader(FAKE_URL);
string headString = Marshal.PtrToStringAnsi(headData);

```

## Binding and Unbinding User Information
### Usage

```csharp 
/**
 * Bind user data
 * 
 * @param config user data
 * @return
 */
void BindUserData(string jsonConfig);
		
/**
 * Unbind user data
 *
 */
void UnbindUserdata();

```

| **Method** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| userId | string | Yes | User ID |
| userName | string | No | Username |
| userEmail | string | No | User email |
| extra | dictionary | No | Key-value pairs, rules for adding are available [here](#key-conflict) |

### Code Example
```csharp 
FTWrapper.BindUserData(@"
{
    ""userId"": ""userid"",
    ""userName"": ""someone"",
    ""userEmail"": ""someone@email.com"",
    ""extra"": {
        ""custom_data"": ""custom data""
    }
}");

```

## Closing the SDK
```csharp
/**
 * Close the SDK and perform cleanup operations 
 */
FTWrapper.DeInit();

```

## Frequently Asked Questions {#FAQ}
### Adding Custom Fields to Avoid Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with the **project abbreviation**, such as `df_tag_name`. For a list of keys used in the project, refer to the [source code](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk/FTSDKConstants.h). If global variables in the SDK conflict with RUM or Log variables, RUM or Log will override the SDK's global variables.