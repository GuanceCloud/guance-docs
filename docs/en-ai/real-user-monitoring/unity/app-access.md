# Unity Application Integration
---
## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you. You can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [accessible from the public network and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#integration}
The current Unity version supports Android and iOS platforms. Log in to the Guance console, go to the "User Access Monitoring" page, click on "New Application" in the top-left corner, and start creating a new application.

1. Enter the "Application Name", "Application ID", and select the "Custom" application type.
   - Application Name: Used to identify the name of the current user access monitoring application.
   - Application ID: The unique identifier for the application within the current workspace, corresponding field: `app_id`. This field only supports English letters, numbers, and underscores, with a maximum of 48 characters.

![](../img/image_13.png)

## Installation {#install}
![](https://img.shields.io/badge/dynamic/json?label=unity&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/unity/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-unity)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-unity](https://github.com/GuanceCloud/datakit-unity)

**Demo Address**: [https://github.com/GuanceCloud/datakit-unity/blob/dev/Assets/Scenes](https://github.com/GuanceCloud/datakit-unity/blob/dev/Assets/Scenes/ClickEvent.cs)

* Download the latest [ft-sdk-unity.unitypackage](https://static.guance.com/ft-sdk-package/unitypackage/alpha/ft-sdk-unity.unitypackage)

```
Assets/Plugins
├── Android
│   ├── FTUnityBridge.java					// Android bridge 
│   ├── ft-sdk-release.aar					// Android SDK
│   ├── gson-2.8.5.jar						// Third-party library dependency for Android SDK
├── FTSDK.cs								// Script bound to FTSDK.prefab
├── FTSDK.prefab							// SDK initialization prefab
├── FTUnityBridge.cs						// Bridge method for iOS and Android platforms
├── FTViewObserver.cs						// Script bound to FTViewObserver.prefab
├── FTViewObserver.prefab					// Prefab for View lifecycle monitoring
├── UnityMainThreadDispatcher.cs			// Script bound to UnityMainThreadDispatcher.prefab
├── UnityMainThreadDispatcher.prefab 		// Prefab for main thread queue consumption
├── iOS
│   ├── FTMobileSDK.framework 				// iOS SDK
│   ├── FTUnityBridge.mm					// iOS bridge
	
```

* `Asserts` -> `Import Package` -> `Custom Package...` to import `ft-sdk-unity.unitypackage`
* Add the third-party library for JSON parsing `"com.unity.nuget.newtonsoft-json"` via `Package Manager` -> `Add Package by name ...`
* Drag `FTSDK.prefab` into the first scene page and initialize the SDK in the `_InitSDK` method of `FTSDK.cs`. If the native Android and iOS projects already integrate the native SDK, comment out the `_InitSDK` method to avoid duplicate settings.
* Drag `FTViewObserver.prefab` into other scene pages to achieve lifecycle monitoring of `View`, including app suspension and resumption.
* Use `Application.logMessageReceived` to listen and convert Unity crash data and normal log data. See the `OnEnable` and `OnDisable` methods in `FTSDK.cs`.

> Note: If the native SDKs (Android `gson-2.8.5.jar`, `ft-sdk-release.aar`, iOS `FTMobileSDK.framework`) are already integrated, they can be removed from the project.
> Additionally, for Android Okhttp request and startup time features, use `ft-plugin`. For detailed configuration, see [Android SDK](../android/app-access.md#gradle-setting)

## Initialization
```csharp
FTUnityBridge.Install(new SDKConfig
            {
                serverUrl = "http://10.0.0.1:9529",
                env = "prod",
                debug = true,

            });
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| serverUrl | string | Yes | DataKit access URL, example: http://10.0.0.1:9529, default port is 9529. Note: The device where the SDK is installed must be able to access this address |
| env | string | No | Environment, default `prod`. Options: `prod`: production environment; `gray`: gray release environment; `pre`: pre-release environment; `common`: daily environment; `local`: local environment, custom values supported |
| debug | bool | No | Whether to enable debug mode |
| globalContext | dictionary | No | Add global properties to the SDK, rules for adding can be found [here](#key-conflict) |
| serviceName| string | No | Affects the `service` field data in Logs and RUM, default for Android is `df_rum_android`, for iOS is `df_rum_ios` |

### RUM Configuration
```csharp
FTUnityBridge.InitRUMConfig(new RUMConfig()
            {
                androidAppId = "androidAppId",
                iOSAppId = "iOSAppId",
                sampleRate = 0.8f,
            });
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| androidAppId | string | Yes | Corresponds to setting the RUM `appid`, enabling RUM collection, [method to obtain appid](#integration) |
| iOSAppId | string | Yes | Corresponds to setting the RUM `appid`, enabling RUM collection, [method to obtain appid](#integration) |
| sampleRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1. Applies to all View, Action, LongTask, Error data under the same session_id |
| globalContext | dictionary | No | Add label data for distinguishing user monitoring data sources, if tracking functionality is needed, parameter `key` is `track_id`, `value` is any numeric value. Rules for adding can be found [here](#key-conflict) |
| enableNativeUserAction | bool | No | Whether to enable Native Action collection, default is false |
| enableNativeUserView | bool | No | Whether to enable Native View collection, default is false |
| enableNativeUserResource | bool | No | Whether to enable Native Resource collection, Android supports Okhttp, iOS uses NSURLSession, default is false |
| extraMonitorTypeWithError | enum | No | Add additional monitoring data to RUM crash data, `memory` for memory usage, `cpu` for CPU occupancy, `all` for all |
| deviceMonitorType | enum | No | Page monitoring supplementary types: `all`, `battery` (only supported by Android), `memory`, `cpu`, `fps` |
| detectFrequency | enum | No | Page monitoring frequency: `normal` (default), `frequent`, `rare` |

### Log Configuration
```csharp
FTUnityBridge.InitLogConfig(new LogConfig
            {
                sampleRate = 0.9f,
                enableCustomLog = true,
                enableLinkRumData = true,
            });
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| globalContext | dictionary | No | Add label data, rules for adding can be found [here](#key-conflict) |
| logLevelFilters | array | No | Set log level filters, options: `ok`, `info`, `warning`, `error`, `critical`, default is no filtering |
| enableCustomLog | bool | No | Whether to upload custom logs, default is `false` |
| discardStrategy | enum | No | `discard` discards appended data, `discard_oldest` discards oldest data, default is `discard` |

### Trace Configuration
```csharp
FTUnityBridge.InitTraceConfig(new TraceConfig
            {
                sampleRate = 0.9f,
                traceType = TraceType.DDTrace,
                enableAutoTrace = true,
                enableLinkRumData = true

            });
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| traceType | enum | No | Default is `ddtrace`, currently supports `zipkin`, `jaeger`, `ddtrace`, `skywalking` (8.0+), `traceParent` (W3C). When integrating with OpenTelemetry, choose the appropriate trace type and check the supported types and agent configurations |
| enableLinkRUMData | bool | No | Whether to link with RUM data, default is `false` |

## RUM User Data Tracking
Currently, RUM data transmission can only be achieved through manual method calls.

### Action
#### Usage
```csharp
/// <summary>
/// Add an Action
/// </summary>
/// <param name="actionName">Action name</param>
/// <param name="actionType">Action type</param>
public static void StartAction(string actionName, string actionType)

/// <summary>
/// Add an Action
/// </summary>
/// <param name="actionName">Action name</param>
/// <param name="actionType">Action type</param>
/// <param name="property">Additional property parameters</param>
public static void StartAction(string actionName, string actionType, Dictionary<string, object> property)
		
```

#### Code Example
```csharp
FTUnityBridge.StartAction("click", "test");
```

### View
#### Usage
```csharp
/// <summary>
/// View Start
/// </summary>
/// <param name="viewName">Current page name</param>
public static void StartView(string viewName)
    
/// <summary>
/// View Start
/// </summary>
/// <param name="viewName">Current page name</param>
/// <param name="property">Additional property parameters</param>
public static void StartView(string viewName, Dictionary<string, object> property)

/// <summary>
/// View End
/// </summary>
public static void StopView()
    
/// <summary>
/// View End
/// </summary>
/// <param name="property">Additional property parameters</param>
public static void StopView(Dictionary<string, object> property)
```

#### Code Example

```csharp
FTUnityBridge.StartView("TEST_VIEW_ONE");

FTUnityBridge.StopView();
```

### Resource
#### Usage
```csharp
/// <summary>
/// Resource Start
/// </summary>
/// <param name="resourceId">Resource Id</param>
/// <returns></returns>
public static async Task StartResource(string resourceId)
    
/// <summary>
/// Resource Start
/// </summary>
/// <param name="resourceId">Resource Id</param>
/// <param name="property">Additional property parameters</param>
/// <returns></returns>
public static async Task StartResource(string resourceId, Dictionary<string, object> property)
	
/// <summary>
/// Resource End
/// </summary>
/// <param name="resourceId">Resource Id</param>
/// <returns></returns>
public static async Task StopResource(string resourceId)
    
/// <summary>
/// Resource End
/// </summary>
/// <param name="resourceId">Resource Id</param>
/// <param name="property">Additional property parameters</param>
public static async Task StopResource(string resourceId, Dictionary<string, object> property)


/// <summary>
/// Add network transfer content and metrics
/// </summary>
/// <param name="resourceId">Resource Id</param>
/// <param name="resourceParams">Data transfer content</param>
/// <param name="netStatus">Network metric data</param>
public static async Task AddResource(string resourceId, ResourceParams resourceParams, NetStatus netStatus)

```
##### NetStatus

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| fetchStartTime | long| No | Request start time, ns|
| tcpTime | long | No | TCP connection duration, ns |
| dnsTime | long | No | DNS resolution time, ns |
| responseTime | long | No | Response content transmission duration, ns |
| sslTime |long | No | SSL connection duration, ns |
| firstByteTime |long | No | Total time from DNS resolution to receiving the first data packet, ns |
| ttfb | long | No | Time from sending the request to receiving the first response packet, ns|
| tcpStartTime | long  | No | TCP connection start time, ns |
| tcpEndTime | long | No | TCP connection end time, ns|
| dnsStartTime | long | No | DNS start time, ns|
| dnsEndTime | long | No | DNS end time, ns |
| responseStartTime | long | No | Response start time, ns |
| responseEndTime | long | No | Response end time, ns |
| sslStartTime | long | No | SSL start time, ns |
| sslEndTime | long | No |SSL end time, ns |

##### ResourceParams
| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| url | string| Yes | URL address  |
| requestHeader | string | No | Request header parameters, no format restrictions |
| responseHeader | string | No | Response header parameters, no format restrictions |
| responseConnection | string | No | Response connection |
| responseContentType | string | No | Response Content-Type |
| responseContentEncoding | string | No | Response Content-Encoding |
| resourceMethod | string | No | Request method GET, POST, etc. |
| responseBody | string | No | Response body content |

#### Code Example
```csharp
FTUnityBridge.StartResource(resourceId);

FTUnityBridge.StopResource(resourceId);

ResourceParams resourceParams = new ResourceParams();
resourceParams.url = url;
resourceParams.requestHeader = client.DefaultRequestHeaders.ToDictionary(header => header.Key, header => string.Join(",", header.Value));
resourceParams.responseHeader = response.Headers.ToDictionary(header => header.Key, header => string.Join(",", header.Value));
resourceParams.resourceStatus = (int)response.StatusCode;
resourceParams.responseBody = responseData;
resourceParams.resourceMethod = "GET";
NetStatus netStatus = new NetStatus();
netStatus.fetchStartTime = DateTimeOffset.Now.ToUnixTimeMilliseconds() * 1000000;

FTUnityBridge.AddResource(resourceId, resourceParams, netStatus);

```

### Error
#### Usage
```csharp
/// <summary>
/// Add error information
/// </summary>
/// <param name="log">Log</param>
/// <param name="message">Message</param>
/// <param name="errorType">Error type</param>
/// <param name="state">Program runtime state</param>
/// <returns></returns>
public static async Task AddError(string log, string message)
    
    
/// <summary>
/// Add error information
/// </summary>
/// <param name="log">Log</param>
/// <param name="message">Message</param>
/// <param name="errorType">Error type</param>
/// <param name="state">Program runtime state</param>
/// <param name="property">Additional property parameters</param>
/// <returns></returns>
public static async Task AddError(string log, string message,
    Dictionary<string, object> property)
```


#### Code Example
```csharp
void OnEnable()
{
    Application.logMessageReceived += LogCallBack;

}

void OnDisable()
{
    Application.logMessageReceived -= LogCallBack;
}
    
void LogCallBack(string condition, string stackTrace, LogType type)
{
    if (type == LogType.Exception)
    {
        FTUnityBridge.AddError(stackTrace, condition);
    }

}
```

### LongTask
#### Usage
```csharp
/// <summary>
/// Add long-running task
/// </summary>
/// <param name="log">Log content</param>
/// <param name="duration">Duration in nanoseconds</param>
/// <returns></returns>
public static async Task AddLongTask(string log, long duration)

/// <summary>
/// Add long-running task
/// </summary>
/// <param name="log">Log content</param>
/// <param name="duration">Duration in nanoseconds</param>
/// <param name="property">Additional property parameters</param>
/// <returns></returns>
public static async Task AddLongTask(string log, long duration, Dictionary<string, object> property)
```

#### Code Example
```csharp
FTUnityBridge.AddLongTask("long task test", 100002);
```

## Log Printing
> Current log content limit is 30 KB, exceeding characters will be truncated
### Usage
```csharp
/// <summary>
/// Add log
/// </summary>
/// <param name="log">Log content</param>
/// <param name="level">Log level info, warning, error, critical, ok</param>
/// <returns></returns>
public static async Task AddLog(string log, LogLevel level)
    
 /// <summary>
/// Add log
/// </summary>
/// <param name="log">Log content</param>
/// <param name="level">Log level info, warning, error, critical, ok</param>
/// <param name="property">Additional property parameters</param>
/// <returns></returns>
public static async Task AddLog(string log, LogLevel level, Dictionary<string, object> property)
```

### LogLevel

| **Method Name** | **Meaning** |
| --- | --- |
| info | Information |
| warning | Warning |
| error | Error |
| critical | Critical |
| ok | Recovery |


### Code Example
```csharp
FTUnityBridge.AddLog("test log", "test message");
```

## Tracer Network Link Tracing
Tracing is achieved by generating a Trace Header and adding it to the HTTP request headers.

### Usage
```csharp
/// <summary>
/// Get trace ID
/// </summary>
/// <param name="url">URL address</param>
/// <returns>JSON string</returns>
public static async Task<string> GetTraceHeaderWithUrl(string url)
 
 
/// <summary>
/// Get trace
/// </summary>
/// <param name="resourceId">Resource Id</param>
/// <param name="url">URL address</param>
/// <returns>JSON string</returns>

public static async Task<string> GetTraceHeader(string resourceId, string url)
```

### Code Example
```csharp
string headData = FTUnityBridge.GetTraceHeader(resourceId, FAKE_URL);

string headData = FTUnityBridge.GetTraceHeader(FAKE_URL);


```

## Binding and Unbinding User Information
### Usage

```csharp 
/// <summary>
/// Bind RUM user information
/// </summary>
/// <param name="userId">Unique user id</param>
public static async Task BindUserData(string userId)
	
/// <summary>
/// Bind RUM user information
/// </summary>
/// <param name="userData"></param>
public static async Task BindUserData(UserData userData)

```

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| userId | string| Yes | User id |
| userName | string | No | Username |
| userEmail | string | No | User email |
| extra | dictionary | No | KV assignment, rules for adding can be found [here](#key-conflict) |


### Code Example
```csharp 
FTUnityBridge.BindUserData(new UserData
            {
                userId = "userid",
                userName = "userName",
                userEmail = "someone@email.com",
                extra = new Dictionary<string, string>{
                    {"custom_data","custom data"}
                }
            });
            
FTUnityBridge.UnBindUserdata()

```

## Closing the SDK
```csharp
/// <summary>
/// SDK Deinitialization
/// </summary>
public static void DeInit()
```

### Code Example
```csharp        
FTUnityBridge.DeInit()
```

## Publish Package Related Configurations
### Android
* [Android R8/Proguard Configuration](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS
* [iOS Symbol File Upload](../ios/app-access.md#source_map)


## Frequently Asked Questions {#FAQ}
### Adding Local Variables to Avoid Conflicting Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix tag names with **project abbreviations**, such as `df_tag_name`. In the project, you can [query the source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java) for `key` values. If there are variables in the SDK global variables that conflict with RUM or Log, RUM or Log will override the global variables in the SDK.

### Others
- [iOS Other Related](../ios/app-access.md#FAQ)
- [Android Privacy Review](../android/app-access.md#third-party)
- [Android Other Related](../android/app-access.md#FAQ)