# Flutter Application Integration
---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit must be configured as [publicly accessible and with IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current Flutter version supports only Android and iOS platforms. Log in to the <<< custom_key.brand_name >>> console, go to the **User Analysis** page, click on the top-left **[Create]**, and start creating a new application.


![](../img/image_13.png)

## Installation {#install}
![](https://img.shields.io/badge/dynamic/json?label=pub.dev&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/version.json) ![](https://img.shields.io/badge/dynamic/json?label=legacy.github.tag&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/legacy/version.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/info.json)

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo Address**: [https://github.com/GuanceCloud/datakit-flutter/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

In the project directory, run the following Flutter command in the terminal:

```bash
 $ flutter pub add ft_mobile_agent_flutter
```

This will add the following line to the `pubspec.yaml` file (and implicitly run `flutter pub get`):

```yaml
dependencies:
  ft_mobile_agent_flutter: [lastest_version]
  
  # For compatibility with flutter 2.0, use the reference below
  ft_mobile_agent_flutter:
    git:
      url: https://github.com/GuanceCloud/datakit-flutter.git
      ref: [github_legacy_lastest_tag]
```

Now in your Dart code, you can use:

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

**Additional Android Integration Configuration**

* Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and Android Native related events (page transitions, click events, Native network requests, WebView data).
* Customize `Application` and declare its usage in `AndroidMainifest.xml`, as shown below.

```kotlin
import io.flutter.app.FlutterApplication

/**
* To track the number of launches and launch time, customize the Application here.
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
    // Local environment deployment, Datakit deployment
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
| datakitUrl | String | Yes | The URL address to access datakit, example: http://10.0.0.1:9529, default port is 9529. The device with SDK installed must be able to access this address. **Note:** Choose either datakit or dataway configuration.|
| datawayUrl | String | Yes | The URL address to access dataway, example: http://10.0.0.1:9528, default port is 9528. The device with SDK installed must be able to access this address. **Note:** Choose either datakit or dataway configuration. |
| cliToken | String | Yes | Authentication token, needs to be configured along with datawayUrl |
| debug | bool | No | Set whether to allow log printing, default is `false` |
| env | String | No | Environment configuration, default is `prod`, any character string, it is recommended to use a single word, such as `test` etc.|
| envType | enum EnvType | No | Environment configuration, default is `EnvType.prod`. **Note:** Only one of `env` or `envType` needs to be configured |
| autoSync | bool | No | Whether to enable automatic synchronization, default is `true`. When set to `false`, use `FTMobileFlutter.flushSyncData()` to manage data synchronization manually |
| syncPageSize | enum | No | Set the number of items per sync request, `SyncPageSize.mini` 5 items, `SyncPageSize.medium` 10 items, `SyncPageSize.large` 50 items, default is `SyncPageSize.medium` |
| customSyncPageSize | number | No | Set the number of items per sync request. Range [5,), Note: Larger item counts mean more computational resources are used for data synchronization |
| syncSleepTime | number | No | Set the intermittent time for synchronization. Range [0,5000], default not set |
| globalContext | object | No | Add custom tags. Refer to [here](../android/app-access.md#key-conflict) for addition rules |
| serviceName | String | No | Service name |
| enableLimitWithDbSize | boolean | No | Enable db size limit for data, default is 100MB, unit Byte, larger databases increase disk pressure, default is not enabled.<br>**Note:** After enabling, Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` will be invalid. Supported by SDK versions 0.5.3-pre.2 and above |
| dbCacheLimit | number | No | DB cache size limit. Range [30MB,), default 100MB, unit byte, supported by SDK versions 0.5.3-pre.2 and above |
| dbCacheDiscard | string | No | Set data discard rule in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. Supported by SDK versions 0.5.3-pre.2 and above |
| compressIntakeRequests | boolean | No | Set whether to compress synchronized data, supported by SDK versions 0.5.3-pre.2 and above, default is disabled |
| enableDataIntegerCompatible | boolean | No | It is recommended to enable when coexisting with web data. This configuration handles storage compatibility issues for web data types. Default is enabled for SDK versions 0.5.4-pre.1 and above |


### RUM Configuration {#rum-config}

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
    );

```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| androidAppId | String | Yes | appId, applied during monitoring |
| iOSAppId | String | Yes | appId, applied during monitoring |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id |
| enableUserResource | bool | No | Whether to enable automatic capture of http `Resource` data, default is `false`, achieved by modifying `HttpOverrides.global`. If the project has customization needs in this aspect, inherit from `FTHttpOverrides`. |
| enableNativeUserAction | bool | No | Whether to perform `Native Action` tracking, native system `Button` click events, app startup events, default is `false` |
| enableNativeUserView | bool | No | Whether to perform `Native View` automatic tracking, pure `Flutter` applications are recommended to disable, default is `false` |
| enableNativeUserResource | bool | No | Whether to perform `Native Resource` automatic tracking, pure `Flutter` applications are recommended to disable, default is `false` |
| errorMonitorType | enum ErrorMonitorType | No | Set auxiliary monitoring information, add additional monitoring data to `RUM` Error data, `ErrorMonitorType.battery` for battery level, `ErrorMonitorType.memory` for memory usage, `ErrorMonitorType.cpu` for CPU usage |
| deviceMetricsMonitorType | enum DeviceMetricsMonitorType | No | In the View lifecycle, add monitoring data, `DeviceMetricsMonitorType.battery` monitors the maximum output current for the current page, `DeviceMetricsMonitorType.memory` monitors the memory usage of the current application, `DeviceMetricsMonitorType.cpu` monitors CPU jumps, `DeviceMetricsMonitorType.fps` monitors screen frame rate |
| globalContext | Map | No | Custom global parameters |
| rumDiscardStrategy | string | No | Discard strategy: `FTRUMCacheDiscard.discard` discards new data (default), `FTRUMCacheDiscard.discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum local cache RUM entry limit [10_000,), default is 100_000 |
| isInTakeUrl | callBack | No | Set filtering conditions for Resources, default does not filter |

#### Adding Custom Tags

##### Static Usage

1. Split the original `main.dart` into two parts: one part is `main()`, the other part is `App()` `MaterialApp` component;
2. Create corresponding entry files for each environment, such as: `main_prod.dart`, `main_gray.dart`, etc.;
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

1. Use file-type data storage, such as the `shared_preferences` library `SharedPreferences`, configure the `SDK`, and add code to retrieve tag data at the configuration point.

```dart
final prefs = await SharedPreferences.getInstance();
String customDynamicValue = prefs.getString("customDynamicValue") ?? "not set";

 await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
        globalContext: {CUSTOM_DYNAMIC_TAG:customDynamicValue},
        //… Add other configurations
    );
```

2. Add methods to change file data anywhere.

```dart
 static Future<void> setDynamicParams(String value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(CUSTOM_DYNAMIC_TAG, value);
  }
```

3. Finally, restart the application.

**Note**:

1. Special key: `track_id` (used for tracking functionality).
2. When users add custom tags through `globalContext` that conflict with SDK's own tags, SDK tags will override user settings. It is recommended to prefix tag names with project abbreviations, such as `df_tag_name`. Key values used in the project can be [queried in the source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java).

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
| logCacheLimitCount | int | No | Maximum local cache log entry limit [1000,), larger logs indicate greater disk cache pressure, default is 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set log discard rules after reaching the limit. Default is `FTLogCacheDiscard.discard`, `discard` discards appended data, `discardOldest` discards old data |


### Trace Configuration {#trace-config}

```dart
await FTTracer().setConfig(
  enableLinkRUMData: true,
  enableAutoTrace:false,
  enableNativeAutoTrace: false
);
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1.   |
| traceType | enum TraceType | No | Trace type, default is `TraceType.ddTrace`. |
| enableLinkRUMData | bool | No | Whether to link with `RUM` data, default is `false`. |
| enableAutoTrace | bool | No | Whether to add `Trace Header` in `http` requests, default is `false`, achieved by modifying `HttpOverrides.global`. If the project has modification requirements in this area, inherit from `FTHttpOverrides` |
| enableNativeAutoTrace |  bool | No | Whether to enable native network auto-tracking for iOS `NSURLSession` and Android `OKhttp`, default is `false`. |

## RUM User Data Tracking

### Action {#action}
#### Usage Method
```dart
  /// Add action
  /// [actionName] action name
  /// [actionType] action type
  /// [property] Additional attribute parameters (optional)
  Future<void> startAction(String actionName, String actionType, 
  {Map<String, String>? property})
```
#### Code Example
```dart
FTRUMManager().startAction("action name", "action type");
```

### View {#rum-view}
#### Automatic Collection {#view-auto-track-config}
* **Method 1**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, set the pages to navigate in `MaterialApp.routes`, the `key` in `routes` is the page name (`view_name`).

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View: Monitor page lifecycle during route navigation
        FTRouteObserver(),
      ],
      routes: <String, WidgetBuilder>{
        //Set Route navigation
        'logging': (BuildContext context) => Logging(),
        'rum': (BuildContext context) => RUM(),
        'tracing_custom': (BuildContext context) => CustomTracing(),
        'tracing_auto': (BuildContext context) => AutoTracing(),
      },
    );
  }
}

//Navigate to the page named "logging" using this method
Navigator.pushNamed(context, "logging");

```

* **Method 2**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, generate with `FTMaterialPageRoute`, where the `widget` class name is the page name (`view_name`).

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View: Monitor page lifecycle during route navigation
        FTRouteObserver(),
      ],
    );
  }
}

//Here the "page name" is NoRouteNamePage
Navigator.of(context).push(FTMaterialPageRoute(builder: (context) => 
	new NoRouteNamePage()
```

* **Method 3**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, customize the `RouteSettings.name` attribute in `Route` type pages, `FTRouteObserver`'s collection logic will prioritize getting the `RouteSettings.name` assignment. This method also applies to Dialog type pages such as `showDialog()`, `showTimePicker()`.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View: Monitor page lifecycle during route navigation
        FTRouteObserver(),
      ],
    );
  }
}

//Here the "page name" is "RouteSettingName"
Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => new NoRouteNamePage(),
              settings: RouteSettings(name: "RouteSettingName"))
```

* All three methods can be mixed in the same project.

* Sleep and Wakeup Event Collection
For versions below 0.5.1-pre.1, if you need to collect application sleep and wakeup behaviors, add the following code:

```dart
class _HomeState extends State<HomeRoute> {
	
	@override
	void initState(){
	
		//Add application sleep and wakeup listeners
		FTLifeRecycleHandler().initObserver();
	}
	
	@override
	void dispose(){
	
		//Remove application sleep and wakeup listeners
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
        // RUM View: routeFilter filters out pages that do not need to participate in monitoring
         FTRouteObserver(routeFilter: (Route? route, Route? previousRoute) {
          if (filterConfig) {
            //Do not collect
            return true;
           }
           return false;
        }),
])

```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| routeFilter | RouteFilter | No | Page method callback, judge based on entering and previous route details, returning true represents filtering out data that meets the condition, otherwise it does not filter  |

**FTDialogRouteFilterObserver**

Filters `DialogRoute` type pages, such as `showDialog()`, `showTimePicker()`.

```dart
MaterialApp(
  navigatorObservers: [
    //RUM View Filter components of DialogRoute type
    FTDialogRouteFilterObserver(filterOnlyNoSettingName: true)
])

// Here the Dialog will be collected under the premise that filterOnlyNoSettingName is true.
// view_name is “About”
showAboutDialog(
            context: context, routeSettings: RouteSettings(name: "About"));
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| filterOnlyNoSettingName | bool | No | Filters only Routes with `RouteSettings.name` being null  |

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
  /// [property] Additional attribute parameters (optional)
  Future<void> starView(String viewName, {Map<String, String>? property})

  /// Stop a view
  /// [property] Additional attribute parameters (optional)
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
    
    // Flutter exception capture
    FlutterError.onError = FTRUMManager().addFlutterError;
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    //Add Error data
    FTRUMManager().addError(error, stack);
  });
 
```
#### Custom Error
##### Usage Method

```dart
  ///Add custom error
  /// [stack] Stack log
  /// [message] Error message
  /// [appState] Application state
  /// [errorType] Custom errorType
  /// [property] Additional attribute parameters (optional)
  Future<void> addCustomError(String stack, String message,
   {Map<String, String>? property, String? errorType}) 
```

##### Code Example

```dart 
 ///Custom error
 FTRUMManager().addCustomError("error stack", "error message");
```

### Resource

#### Automatic Collection
Enable `enableUserResource` via the [configuration](#rum-config) `FTRUMManager().setConfig`.

#### Custom Resource
##### Usage Method

```dart
  ///Start resource request
  /// [key] Unique id
  /// [property] Additional attribute parameters (optional)
  Future<void> startResource(String key, {Map<String, String>? property})

  ///End resource request
  /// [key] Unique id
  /// [property] Additional attribute parameters (optional)
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
/// Use httpClient  
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

> Using the http library or dio library, refer to [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## Logger Log Printing 
### Custom Logs
> Currently, log content is limited to 30 KB, exceeding characters will be truncated.

#### Usage Method
```dart

  ///Output log
  ///[content] Log content
  ///[status] Log status
  ///[property] Additional attribute parameters (optional)
  Future<void> logging(String content, FTLogStatus status, {Map<String, String>? property})

```
#### Code Example
```dart
FTLogger().logging("info log content", FTLogStatus.info);
```

### Log Levels

| **Method Name** | **Meaning** |
| --- | --- |
| FTLogStatus.info | Information |
| FTLogStatus.warning | Warning |
| FTLogStatus.error | Error |
| FTLogStatus.critical | Critical |
| FTLogStatus.ok | Recovery |


## Tracer Network Link Tracing
### Automatic Collection
Enable `enableAutoTrace` via the [configuration](#trace-config) `FTTracer().setConfig`.

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
/// Use httpClient    
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
```

> Using the http library or dio library, refer to [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## Binding and Unbinding User Information
### FTMobileFlutter
#### Usage Method
```dart
  ///Bind user
  ///
  ///[userid] User id
  ///[userName] Username
  ///[userEmail] User email
  ///[userExt] Extended data
  static Future<void> bindRUMUserData(String userId,
      {String? userName, String? userEmail, Map<String, String>? ext})

  ///Unbind user
  static Future<void> unbindRUMUserData()

```
#### Code Example
```dart
 FTMobileFlutter.bindUser("flutterUser");

 FTMobileFlutter.unbindUser();
```

## Active Synchronization of Data
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
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the accessed WebView page.


## Native and Flutter Hybrid Development {#hybrid}

If your project is natively developed, with some pages or business processes implemented using Flutter, follow these steps for SDK installation and initialization:

* Installation: [Installation](#install) method remains unchanged
* Initialization: Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) for initialization within the native project
* Flutter Configuration:
    * View, Resource, Error are configured in the same way as a pure Flutter project
    * Flutter Resource and Trace automatic collection uses the following configuration method
    ```dart
        // Set traceHeader, supported from 0.5.3-pre.2
        FTHttpOverrideConfig.global.traceHeader = true;   
        // Set Resource data collection, supported from 0.5.3-pre.2
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