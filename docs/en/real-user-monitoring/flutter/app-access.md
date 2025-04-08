# Flutter Application Integration
---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites will be automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure that DataKit is [accessible over the public network and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current Flutter version only supports Android and iOS platforms. Log in to the <<< custom_key.brand_name >>> console, go to the **Synthetic Tests** page, click the top-left **[Create]** to start creating a new application.


![](../img/image_13.png)

## Installation {#install}
![](https://img.shields.io/badge/dynamic/json?label=pub.dev&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/version.json) ![](https://img.shields.io/badge/dynamic/json?label=legacy.github.tag&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/legacy/version.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/info.json)

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo Address**: [https://github.com/GuanceCloud/datakit-flutter/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

Run the following command in the project path:

```bash
 $ flutter pub add ft_mobile_agent_flutter
```

This will add the following line to the `pubspec.yaml` file (and implicitly run `flutter pub get`):

```yaml
dependencies:
  ft_mobile_agent_flutter: [lastest_version]
  
  # For compatibility with Flutter 2.0, use the reference below
  ft_mobile_agent_flutter:
    git:
      url: https://github.com/GuanceCloud/datakit-flutter.git
      ref: [github_legacy_lastest_tag]
```

Now in your Dart code, you can use:

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

**Additional Configuration for Android Integration**

* Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and Android Native related events (page transitions, click events, Native network requests, WebView data).
* Customize `Application` and declare it in `AndroidMainifest.xml`. The code is as follows:

```kotlin
import io.flutter.app.FlutterApplication

/**
* To track the number of launches and launch times, add a custom Application here.
*/
class CustomApplication : FlutterApplication() {
}
```

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="com.cloudcare.ft.mobile.sdk.agent_example">
  <application android:name=".CustomApplication">
    //...
  </application>
</manifest>
```

## SDK Initialization
### Basic Configuration {#base-setting}

```dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Local deployment or Datakit deployment
    await FTMobileFlutter.sdkConfig(
      datakitUrl: datakitUrl
    );

    // Use public DataWay
    await FTMobileFlutter.sdkConfig(
      datawayUrl: datawayUrl,
      cliToken: cliToken,
    );
}  
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, default port is 9529. Devices with the installed SDK need to access this address. **Note: Choose either datakit or dataway configuration**|
| datawayUrl | String | Yes | Dataway access URL address, example: http://10.0.0.1:9528, default port is 9528. Devices with the installed SDK need to access this address. **Note: Choose either datakit or dataway configuration** |
| cliToken | String | Yes | Authentication token, must be configured with datawayUrl |
| debug | bool | No | Set whether to allow log printing, default is `false` |
| env | String | No | Environment configuration, default is `prod`, any character, recommended to use a single word such as `test` etc.|
| envType | enum EnvType | No | Environment configuration, default is `EnvType.prod`. **Note: Only one of env or envType needs to be configured** |
| autoSync | bool | No | Whether to enable automatic synchronization, default is `true`. When set to `false`, use `FTMobileFlutter.flushSyncData()` to manage data synchronization yourself |
| syncPageSize | enum | No | Set the number of items per sync request, `SyncPageSize.mini` 5 items, `SyncPageSize.medium` 10 items, `SyncPageSize.large` 50 items, default is `SyncPageSize.medium` |
| customSyncPageSize | number | No | Set the number of items per sync request. Range [5,), note: The larger the number of items, the more computational resources are used for data synchronization |
| syncSleepTime | number | No | Set the time interval between syncs. Range [0,5000], default is not set |
| globalContext | object | No | Add custom tags. Refer to [here](../android/app-access.md#key-conflict) for rules |
| serviceName | String | No | Service name |
| enableLimitWithDbSize | boolean | No | Enable limiting data size using db, default is 100MB, unit Byte, larger databases increase disk pressure, default is disabled.<br>**Note:** After enabling, the Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` will be invalid. Supported by SDK versions 0.5.3-pre.2 and above |
| dbCacheLimit | number | No | DB cache limit size. Range [30MB,), default is 100MB, unit byte, supported by SDK versions 0.5.3-pre.2 and above |
| dbCacheDiscard | string | No | Set the data discard rule in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. Supported by SDK versions 0.5.3-pre.2 and above |
| compressIntakeRequests | boolean | No | Set whether to compress the synchronized data, supported by SDK versions 0.5.3-pre.2 and above, default is disabled |
| enableDataIntegerCompatible | boolean | No | It is recommended to enable this when coexistence with web data is required. This configuration handles web data type storage compatibility issues. Default is enabled for SDK versions 0.5.4-pre.1 and above |


### RUM Configuration {#rum-config}

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
    );

```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| androidAppId | String | Yes | appId, obtained during monitoring setup |
| iOSAppId | String | Yes | appId, obtained during monitoring setup |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope includes all View, Action, LongTask, Error data within the same session_id |
| enableUserResource | bool | No | Whether to automatically capture `Resource` data via HTTP, default is `false`. This is achieved by modifying `HttpOverrides.global`. If the project has customization requirements, inherit from `FTHttpOverrides`. |
| enableNativeUserAction | bool | No | Whether to track `Native Action`, native system `Button` click events, app startup events, default is `false` |
| enableNativeUserView | bool | No | Whether to automatically track `Native View`, recommend disabling for pure `Flutter` applications, default is `false` |
| enableNativeUserResource | bool | No | Whether to automatically track `Native Resource`, recommend disabling for pure `Flutter` applications, default is `false` |
| enableAppUIBlock | bool | No | Whether to automatically track `Native Freeze`, default is `false` |
| nativeUiBlockDurationMS | int | No | Whether to set the time range for `Native Freeze`, range [100,), unit milliseconds. Default is 250ms on iOS, 1000ms on Android |
| enableTrackNativeAppANR | bool | No | Whether to enable `Native ANR` monitoring, default is `false` |
| enableTrackNativeCrash | bool | No | Whether to enable `Android Java Crash` and `OC/C/C++` crash monitoring, default is `false` |
| errorMonitorType | enum ErrorMonitorType | No | Set auxiliary monitoring information, adding additional monitoring data to `RUM` Error data, `ErrorMonitorType.battery` for battery level, `ErrorMonitorType.memory` for memory usage, `ErrorMonitorType.cpu` for CPU usage, default is disabled |
| deviceMetricsMonitorType | enum DeviceMetricsMonitorType | No | In the View lifecycle, add monitoring data, `DeviceMetricsMonitorType.battery` (only Android) monitors the maximum output current of the current page, `DeviceMetricsMonitorType.memory` monitors the current application memory usage, `DeviceMetricsMonitorType.cpu` monitors CPU jumps, `DeviceMetricsMonitorType.fps` monitors screen frame rate, default is disabled |
| detectFrequency | enum DetectFrequency | No | Sampling frequency for performance monitoring of views, default is `DetectFrequency.normal` |
| globalContext | Map | No | Custom global parameters |
| rumCacheDiscard | enum | No | Discard strategy: `FTRUMCacheDiscard.discard` discards new data (default), `FTRUMCacheDiscard.discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum number of cached RUM entries [10_000,), default is 100_000 |
| isInTakeUrl | callBack | No | Set conditions to filter Resources, default does not filter |

#### Adding Custom Tags

##### Static Usage

1. Split the original `main.dart` into two parts, one part being `main()`, the other part being the `App()` `MaterialApp` component;
2. Create corresponding entry files for each environment, such as `main_prod.dart`, `main_gray.dart`, etc.;
3. Perform custom tag configuration in the corresponding environment file. Example:

```dart
///main_prod.dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize SDK
    await FTMobileFlutter.sdkConfig(
      datakitUrl: serverUrl,
      debug: true,
    );
    await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
        globalContext: {CUSTOM_STATIC_TAG:"prod_static_tag"},
    );
    runApp(MyApp());
  };
```

##### Dynamic Usage

1. Use file-type data storage, such as the `shared_preferences` library `SharedPreferences`, configure the `SDK` in the configuration location, and add code to retrieve tag data.

```dart
final prefs = await SharedPreferences.getInstance();
String customDynamicValue = prefs.getString("customDynamicValue")?? "not set";

 await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
        globalContext: {CUSTOM_DYNAMIC_TAG:customDynamicValue},
        //… Add other configurations
    );
```

2. Add methods to change file data at any location.

```dart
 static Future<void> setDynamicParams(String value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(CUSTOM_DYNAMIC_TAG, value);
  }
```

3. Restart the application lastly.

**Note**:

1. Special key: `track_id` (used for tracking features).
2. When users add custom tags via `globalContext` that conflict with SDK-owned tags, the SDK's tags will override user settings. It is recommended to prefix tag names with project abbreviations, e.g., `df_tag_name`. Use `key` values found in [source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java).

### Log Configuration {#log-config}

```dart
 await FTLogger().logConfig(
   enableCustomLog: true
 );
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1.     |
| enableLinkRumData | bool | No | Whether to link with `RUM` data |
| enableCustomLog | bool | No | Whether to enable custom logs |
| logLevelFilters | List<FTLogStatus> | No | Log level filtering |
| logCacheLimitCount | int | No | Maximum number of cached log entries [1000,), larger logs mean greater disk caching pressure, default is 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set the log discard rule when reaching the limit. Default is `FTLogCacheDiscard.discard`, `discard` discards appended data, `discardOldest` discards old data |


### Trace Configuration {#trace-config}

```dart
await FTTracer().setConfig(
  enableLinkRUMData: true,
  enableAutoTrace: true,
);
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1.   |
| traceType | enum TraceType | No | Trace type, default is `TraceType.ddTrace`. |
| enableLinkRUMData | bool | No | Whether to link with `RUM` data, default is `false`. |
| enableAutoTrace | bool | No | Whether to add `Trace Header` in `http` requests, default is `false`, this is achieved by modifying `HttpOverrides.global`, if there are modification requirements, inherit from `FTHttpOverrides` |
| enableNativeAutoTrace |  bool | No | Whether to enable native network automatic tracing for iOS `NSURLSession` and Android `OKhttp`, default is `false`. |

## RUM User Data Tracking

### Action {#action}
#### Usage Method
```dart
  /// Add an action
  /// [actionName] action name
  /// [actionType] action type
  /// [property] Additional property parameters (optional)
  Future<void> startAction(String actionName, String actionType, 
  {Map<String, String>? property})
```
#### Code Example
```dart
FTRUMManager().startAction("action name", "action type");
```

### View {#rum-view}
#### Automatic Collection {#view-auto-track-config}
* **Method 1**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, set the pages to navigate in `MaterialApp.routes`, where the `key` in `routes` is the page name (`view_name`).

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        // RUM View: Monitor page lifecycle when using route navigation
        FTRouteObserver(),
      ],
      routes: <String, WidgetBuilder>{
        // Set Route navigation
        'logging': (BuildContext context) => Logging(),
        'rum': (BuildContext context) => RUM(),
        'tracing_custom': (BuildContext context) => CustomTracing(),
        'tracing_auto': (BuildContext context) => AutoTracing(),
      },
    );
  }
}

// Navigate to the page named "logging" in this way
Navigator.pushNamed(context, "logging");

```

* **Method 2**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, use `FTMaterialPageRoute` to generate, where the `widget` class name is the page name (`view_name`).

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        // RUM View: Monitor page lifecycle when using route navigation
        FTRouteObserver(),
      ],
    );
  }
}

// Here the "page name" is NoRouteNamePage
Navigator.of(context).push(FTMaterialPageRoute(builder: (context) => 
	new NoRouteNamePage()
```

* **Method 3**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, customize the `RouteSettings.name` attribute in `Route` type pages, the `FTRouteObserver` collection logic will prioritize getting the value assigned to `RouteSettings.name`, this method also applies to Dialog type pages, such as `showDialog()`,`showTimePicker()`.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        // RUM View: Monitor page lifecycle when using route navigation
        FTRouteObserver(),
      ],
    );
  }
}

// Here the "page name" is "RouteSettingName"
Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => new NoRouteNamePage(),
              settings: RouteSettings(name: "RouteSettingName"))
```

* All three methods can be mixed in the same project

* Sleep and Wake Events Collection
For versions below 0.5.1-pre.1, if you need to collect sleep and wake behaviors of the application, add the following code:

```dart
class _HomeState extends State<HomeRoute> {
	
	@override
	void initState(){
	
		// Add application sleep and wake listener
		FTLifeRecycleHandler().initObserver();
	}
	
	@override
	void dispose(){
	
		// Remove application sleep and wake listener
		FTLifeRecycleHandler().removeObserver();
	}
}

```

#### Automatic Collection Filtering {#view-auto-track-route-filter}
Only supported in versions 0.5.0-pre.1 and above

**FTRouteObserver**

```dart
MaterialApp(
  navigatorObservers: [
        // RUM View: routeFilter filters out pages that do not need to be monitored
         FTRouteObserver(routeFilter: (Route? route, Route? previousRoute) {
          if (filterConfig) {
            // Do not collect
            return true;
           }
           return false;
        }),
])

```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| routeFilter | RouteFilter | No | Page callback method, judgments can be made based on entering and previous route specifics, returning true represents filtering out data that meets the condition, otherwise it does not filter  |

**FTDialogRouteFilterObserver**

Filters `DialogRoute` type pages, such as `showDialog()`,`showTimePicker()`.

```dart
MaterialApp(
  navigatorObservers: [
    // RUM View filters components of type DialogRoute
    FTDialogRouteFilterObserver(filterOnlyNoSettingName: true)
])

// This dialog is collected under the premise that filterOnlyNoSettingName is true.
// view_name is “About”
showAboutDialog(
            context: context, routeSettings: RouteSettings(name: "About"));
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| filterOnlyNoSettingName | bool | No | Only filters out Route pages where `RouteSettings.name` is null  |

#### Custom View
##### Usage Method

```dart

  /// Create a view, this method must be called before [starView], currently there is none in the Flutter route
  /// [viewName] Interface name
  /// [duration]
  Future<void> createView(String viewName, int duration)

  /// Start a view
  /// [viewName] Interface name
  /// [viewReferer] Previous interface name
  /// [property] Additional property parameters (optional)
  Future<void> starView(String viewName, {Map<String, String>? property})

  /// Stop a view
  /// [property] Additional property parameters (optional)
  Future<void> stopView({Map<String, String>? property})

```

##### Code Example
```dart
FTRUMManager().createView("Current Page Name", 100000000)

FTRUMManager().starView("Current Page Name");
         
FTRUMManager().stopView();
```
### Error {#error}
#### Automatic Collection
```dart

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FTMobileFlutter.sdkConfig(
      datakitUrl: serverUrl,
      debug: true,
    );
    await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
    );
    
    // Flutter exception handling
    FlutterError.onError = FTRUMManager().addFlutterError;
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    // Add Error data
    FTRUMManager().addError(error, stack);
  });
 
```
#### Custom Error
##### Usage Method

```dart
  /// Add custom error
  /// [stack] Stack log
  /// [message] Error message
  /// [appState] Application state
  /// [errorType] Custom errorType
  /// [property] Additional property parameters (optional)
  Future<void> addCustomError(String stack, String message,
   {Map<String, String>? property, String? errorType}) 
```

##### Code Example

```dart 
 /// Custom error
 FTRUMManager().addCustomError("error stack", "error message");
```

### Resource

#### Automatic Collection
Enable `enableUserResource` in the [configuration](#rum-config) `FTRUMManager().setConfig`.

#### Custom Resource
##### Usage Method

```dart
  /// Start resource request
  /// [key] Unique id
  /// [property] Additional property parameters (optional)
  Future<void> startResource(String key, {Map<String, String>? property})

  /// End resource request
  /// [key] Unique id
  /// [property] Additional property parameters (optional)
  Future<void> stopResource(String key, {Map<String, String>? property})

  /// Send resource data metrics
  /// [key] Unique id
  /// [url] Request address
  /// [httpMethod] Request method
  /// [requestHeader] Request header parameters
  /// [responseHeader] Response header parameters
  /// [responseBody] Response content
  /// [resourceStatus] Response status code
  Future<void> addResource(
      {required String key,
      required String url,
      required String httpMethod,
      required Map<String, dynamic> requestHeader,
      Map<String, dynamic>? responseHeader,
      String? responseBody = "",
      int? resourceStatus})
```

##### Code Example

```dart
/// Using httpClient  
void httpClientGetHttp(String url) async {
    var httpClient = new HttpClient();
    String key = Uuid().v4();
    HttpClientResponse? response;
    HttpClientRequest? request;
    try {
      request = await httpClient
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: 10));
      FTRUMManager().startResource(key);
      response = await request.close();
    } finally {
      Map<String, dynamic> requestHeader = {};
      Map<String, dynamic> responseHeader = {};

      request!.headers.forEach((name, values) {
        requestHeader[name] = values;
      });
      var responseBody = "";
      if (response != null) {
        response.headers.forEach((name, values) {
          responseHeader[name] = values;
        });
        responseBody = await response.transform(Utf8Decoder()).join();
      }
      FTRUMManager().stopResource(key);
      FTRUMManager().addResource(
        key: key,
        url: request.uri.toString(),
        requestHeader: requestHeader,
        httpMethod: request.method,
        responseHeader: responseHeader,
        resourceStatus: response?.statusCode,
        responseBody: responseBody,
      );
    }
  }
```

> Using the http library and dio library, refer to [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## Logger Log Printing 
### Custom Logs
> Currently, log content is limited to 30 KB, exceeding characters will be truncated.

#### Usage Method
```dart

  /// Output logs
  ///[content] Log content
  ///[status] Log status
  ///[property] Additional property parameters (optional)
  Future<void> logging(String content, FTLogStatus status, {Map<String, String>? property})

```
#### Code Example
```dart
FTLogger().logging("info log content", FTLogStatus.info);
```

### Log Levels

| **Method Name** | **Meaning** |
| --- | --- |
| FTLogStatus.info | Prompt |
| FTLogStatus.warning | Warning |
| FTLogStatus.error | Error |
| FTLogStatus.critical | Severe |
| FTLogStatus.ok | Recovery |


## Tracer Network Link Tracing
### Automatic Collection
Enable `enableAutoTrace` in the [configuration](#trace-config) `FTTracer().setConfig`.

### Custom Tracer
#### Usage Method
```dart
  /// Get trace http request header data
  /// [key] Unique id
  /// [url] Request address
  ///
  Future<Map<String, String>> getTraceHeader(String url, {String? key})
```
#### Code Example

```dart
/// Using httpClient    
void httpClientGetHttp() async {
    var url = 'http://www.google.cn';
    var httpClient = new HttpClient();
    String key = DateTime.now().millisecondsSinceEpoch.toString() + url;
    var errorMessage = "";
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse? response;
    try {
      final traceHeaders =
          await FTTracer().getTraceHeader(key, request.uri.toString());
      traceHeaders.forEach((key, value) {
        request.headers.add(key, value);
      });
      response = await request.close();
    } catch (exception) {
      errorMessage = exception.toString();
    } finally {
      Map<String, dynamic> requestHeader = {};
      Map<String, dynamic> responseHeader = {};

      request.headers.forEach((name, values) {
        requestHeader[name] = values;
      });
      if (response != null) {
        response.headers.forEach((name, values) {
          responseHeader[name] = values;
        });
      }
    }
  }
```

> Using the http library and dio library, refer to [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## Binding and Unbinding User Information
### FTMobileFlutter
#### Usage Method
```dart
  /// Bind user
  ///
  ///[userid] User id
  ///[userName] Username
  ///[userEmail] User email
  ///[userExt] Extended data
  static Future<void> bindRUMUserData(String userId,
      {String? userName, String? userEmail, Map<String, String>? ext})

  /// Unbind user
  static Future<void> unbindRUMUserData()

```
#### Code Example
```dart
 FTMobileFlutter.bindUser("flutterUser");

 FTMobileFlutter.unbindUser();
```

## Active Data Synchronization
### FTMobileFlutter
#### Usage Method

```dart
/// Immediately synchronize data
static Future<void> flushSyncData())
```

#### Usage Example

```dart
FTMobileFlutter.flushSyncData();
```

## WebView Data Monitoring
To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) on the accessed page.


## Native and Flutter Hybrid Development {#hybrid}

If your project is natively developed, but some pages or business flows are implemented using Flutter, follow these initialization steps:

* Installation: [Installation](#install) remains unchanged
* Initialization: Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) to initialize within the native project
* Flutter Configuration:
    * View, Resource, Error use the same configuration method as pure Flutter projects
    * Flutter Resource and Trace automatic collection use the following configuration method
    ```dart
        // Set traceHeader, supported by 0.5.3-pre.2
        FTHttpOverrideConfig.global.traceHeader = true;   
        // Set to collect Resource data, supported by 0.5.3-pre.2
        FTHttpOverrideConfig.global.traceResource = true; 
    ```
   
## Publish Package Related Configurations
### Android
* [Android R8/Prograd Configuration](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS
* [iOS Symbol File Upload](../ios/app-access.md#source_map)


## Common Issues
- [Android Privacy Review](../android/app-access.md#third-party)
- [iOS Related](../ios/app-access.md#FAQ)
- [Android Related](../android/app-access.md#FAQ)