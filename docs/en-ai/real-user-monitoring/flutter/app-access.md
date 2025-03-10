# Flutter Application Integration
---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [publicly accessible and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current Flutter version supports only Android and iOS platforms. Log in to the <<< custom_key.brand_name >>> console, go to the **Synthetic Tests** page, click on the top-left **[Create Application](../index.md#create)**, and start creating a new application.


![](../img/image_13.png)

## Installation {#install}
![](https://img.shields.io/badge/dynamic/json?label=pub.dev&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/version.json) ![](https://img.shields.io/badge/dynamic/json?label=legacy.github.tag&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/legacy/version.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/info.json)

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**Source Code**: [https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo Address**: [https://github.com/GuanceCloud/datakit-flutter/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

In the project directory, run the Flutter command in the terminal:

```bash
 $ flutter pub add ft_mobile_agent_flutter
```

This will add the following line to the package's pubspec.yaml (and implicitly run `flutter pub get`):

```yaml
dependencies:
  ft_mobile_agent_flutter: [lastest_version]
  
  # For compatibility with Flutter 2.0, use the following reference method
  ft_mobile_agent_flutter:
    git:
      url: https://github.com/GuanceCloud/datakit-flutter.git
      ref: [github_legacy_lastest_tag]
```

Now in your Dart code, you can use:

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

**Additional Configuration for Android**

* Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and Android Native related events (page transitions, click events, Native network requests, WebView data).
* Customize `Application` and declare its use in `AndroidMainifest.xml`. The code is as follows:

```kotlin
import io.flutter.app.FlutterApplication

/**
* Add custom Application here if you need to track launch counts and launch times.
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
    // Local environment deployment or Datakit deployment
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
| datakitUrl | String | Yes | Datakit access URL, example: http://10.0.0.1:9529, default port 9529, the device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| datawayUrl | String | Yes | Dataway access URL, example: http://10.0.0.1:9528, default port 9528, the device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| cliToken | String | Yes | Authentication token, must be configured with datawayUrl |
| debug | bool | No | Enable log printing, default `false` |
| env | String | No | Environment configuration, default `prod`, any string, it is recommended to use a single word, e.g., `test` |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. **Note: Only one of env or envType needs to be configured** |
| serviceName | String | No | Service name |
| enableLimitWithDbSize | boolean | No | Enable db size limit for data, default 100MB, unit Byte, larger databases increase disk pressure, default not enabled.<br>**Note:** After enabling, the Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` become ineffective. Supported by SDK versions 0.3.10 and above |
| dbCacheLimit | number | No | DB cache size limit. Range [30MB,), default 100MB, unit byte, supported by SDK versions 0.3.10 and above |
| dbDiscardStrategy | string | No | Set the data discard rule in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discard new data (default), `FTDBCacheDiscard.discardOldest` discard old data. Supported by SDK versions 0.3.10 and above |

### RUM Configuration {#rum-config}

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
    );

```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| androidAppId | String | Yes | appId, obtained from monitoring application |
| iOSAppId | String | Yes | appId, obtained from monitoring application |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Applies to all View, Action, LongTask, Error data under the same session_id |
| enableUserResource | bool | No | Whether to automatically capture HTTP `Resource` data, default `false`, achieved by modifying `HttpOverrides.global`. If there are customization needs, inherit `FTHttpOverrides` |
| enableNativeUserAction | bool | No | Whether to track `Native Action`, native system `Button` click events, app startup events, default `false` |
| enableNativeUserView | bool | No | Whether to automatically track `Native View`, recommend disabling for pure `Flutter` applications, default `false` |
| enableNativeUserResource | bool | No | Whether to automatically track `Native Resource`, recommend disabling for pure `Flutter` applications, default `false` |
| errorMonitorType | enum ErrorMonitorType | No | Set auxiliary monitoring information, add additional monitoring data to `RUM` Error data, `ErrorMonitorType.battery` for battery level, `ErrorMonitorType.memory` for memory usage, `ErrorMonitorType.cpu` for CPU usage |
| deviceMetricsMonitorType | enum DeviceMetricsMonitorType | No | In the View lifecycle, add monitoring data, `DeviceMetricsMonitorType.battery` monitors the highest output current, `DeviceMetricsMonitorType.memory` monitors the application's memory usage, `DeviceMetricsMonitorType.cpu` monitors CPU frequency, `DeviceMetricsMonitorType.fps` monitors screen frame rate |
| globalContext | Map | No | Custom global parameters |
| rumDiscardStrategy | string | No | Discard strategy: `FTRUMCacheDiscard.discard` discard new data (default), `FTRUMCacheDiscard.discardOldest` discard old data |
| rumCacheLimitCount | number | No | Maximum number of local cached RUM entries [10_000,), default 100_000 |
| isInTakeUrl | callBack | No | Set conditions to filter Resources, default no filtering |

#### Adding Custom Tags

##### Static Usage

1. Split the original main.dart into two parts, one part being main(), the other part being the MaterialApp component;
2. Create corresponding entry files for different environments, such as main_prod.dart, main_gray.dart, etc.;
3. Configure custom tags in the corresponding environment files. For example:

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

1. Use file-based data storage, such as the `shared_preferences` library `SharedPreferences`, configure `SDK` and add code to retrieve tag data at the configuration point.

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

1. Special key: track_id (used for tracking features).
2. When users add custom tags via `globalContext` that conflict with SDK-owned tags, SDK tags will override user settings. It is recommended to prefix tag names with project abbreviations, e.g., `df_tag_name`. Project keys can be found in the [source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java).

### Log Configuration {#log-config}

```dart
 await FTLogger().logConfig(
   enableCustomLog: true
 );
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| enableLinkRumData | bool | No | Whether to link with `RUM` data |
| enableCustomLog | bool | No | Whether to enable custom logs |
| logLevelFilters | List<FTLogStatus> | No | Log level filters |
| logCacheLimitCount | int | No | Maximum number of locally cached log entries [1000,), larger logs mean more disk cache pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set the log discard rule when the limit is reached. Default `FTLogCacheDiscard.discard`, `discard` discards appended data, `discardOldest` discards old data |

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
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| traceType | enum TraceType | No | Trace type, default `TraceType.ddTrace`. |
| enableLinkRUMData | bool | No | Whether to link with `RUM` data, default `false`. |
| enableAutoTrace | bool | No | Whether to add `Trace Header` to `http` requests, default `false`, achieved by modifying `HttpOverrides.global`. If there are modification needs, inherit `FTHttpOverrides` |
| enableNativeAutoTrace | bool | No | Whether to enable automatic tracing of native network requests iOS `NSURLSession`, Android `OKhttp`, default `false`. |

## RUM User Data Tracking

### Action {#action}
#### Usage Method
```dart
  /// Add action
  /// [actionName] action name
  /// [actionType] action type
  /// [property] additional properties (optional)
  Future<void> startAction(String actionName, String actionType, 
  {Map<String, String>? property})
```
#### Code Example
```dart
FTRUMManager().startAction("action name", "action type");
```

### View {#rum-view}
#### Automatic Collection {#view-auto-track-config}
* **Method 1**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, set `MaterialApp.routes` for pages to navigate to, where the `routes` keys are the page names (`view_name`).

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        // RUM View: Monitor page lifecycle during navigation
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

// Navigate to a page named "logging"
Navigator.pushNamed(context, "logging");

```

* **Method 2**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, use `FTMaterialPageRoute` to generate the route, where the widget class name is the page name (`view_name`).

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        // RUM View: Monitor page lifecycle during navigation
        FTRouteObserver(),
      ],
    );
  }
}

// Here "Page Name" is NoRouteNamePage
Navigator.of(context).push(FTMaterialPageRoute(builder: (context) => 
	new NoRouteNamePage()
```

* **Method 3**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, customize the `RouteSettings.name` attribute in `Route` type pages. `FTRouteObserver`'s collection logic will prioritize the value assigned to `RouteSettings.name`. This method also applies to `Dialog` type pages like `showDialog()`, `showTimePicker()`.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        // RUM View: Monitor page lifecycle during navigation
        FTRouteObserver(),
      ],
    );
  }
}

// Here "Page Name" is "RouteSettingName"
Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => new NoRouteNamePage(),
              settings: RouteSettings(name: "RouteSettingName"))
```

* All three methods can be mixed within a single project.

* Sleep and Wake Events Collection
For versions below 0.5.1-pre.1, if you need to collect application sleep and wake behavior, add the following code:

```dart
class _HomeState extends State<HomeRoute> {
	
	@override
	void initState(){
	
		// Add sleep and wake listeners
		FTLifeRecycleHandler().initObserver();
	}
	
	@override
	void dispose(){
	
		// Remove sleep and wake listeners
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
        // RUM View: Filter out pages that should not be monitored using routeFilter
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
| routeFilter | RouteFilter | No | Page callback method, returns true to filter out matching data, otherwise does not filter |

**FTDialogRouteFilterObserver**

Filters `DialogRoute` type pages, such as `showDialog()`, `showTimePicker()`.

```dart
MaterialApp(
  navigatorObservers: [
    // RUM View filter DialogRoute components
    FTDialogRouteFilterObserver(filterOnlyNoSettingName: true)
])

// This Dialog will be collected if filterOnlyNoSettingName is true.
// view_name is “About”
showAboutDialog(
            context: context, routeSettings: RouteSettings(name: "About"));
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| filterOnlyNoSettingName | bool | No | Filters only Routes with null `RouteSettings.name` |

#### Custom View
##### Usage Method

```dart

  /// Create view, this method must be called before [starView], currently not available in Flutter routes
  /// [viewName] page name
  /// [duration]
  Future<void> createView(String viewName, int duration)

  /// Start view
  /// [viewName] page name
  /// [viewReferer] previous page name
  /// [property] additional properties (optional)
  Future<void> starView(String viewName, {Map<String, String>? property})

  /// Stop view
  /// [property] additional properties (optional)
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
  /// [stack] stack trace
  /// [message] error message
  /// [appState] application state
  /// [errorType] custom errorType
  /// [property] additional properties (optional)
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
Enable `enableUserResource` through the [configuration](#rum-config) `FTRUMManager().setConfig`.

#### Custom Resource
##### Usage Method

```dart
  /// Start resource request
  /// [key] unique id
  /// [property] additional properties (optional)
  Future<void> startResource(String key, {Map<String, String>? property})

  /// End resource request
  /// [key] unique id
  /// [property] additional properties (optional)
  Future<void> stopResource(String key, {Map<String, String>? property})

  /// Send resource metrics data
  /// [key] unique id
  /// [url] request URL
  /// [httpMethod] HTTP method
  /// [requestHeader] request headers
  /// [responseHeader] response headers
  /// [responseBody] response body
  /// [resourceStatus] response status code
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

  /// Output log
  /// [content] log content
  /// [status] log status
  /// [property] additional properties (optional)
  Future<void> logging(String content, FTLogStatus status, {Map<String, String>? property})

```
#### Code Example
```dart
FTLogger().logging("info log content", FTLogStatus.info);
```

### Log Levels

| **Method Name** | **Meaning** |
| --- | --- |
| FTLogStatus.info | Info |
| FTLogStatus.warning | Warning |
| FTLogStatus.error | Error |
| FTLogStatus.critical | Critical |
| FTLogStatus.ok | OK |


## Tracer Network Link Tracing
### Automatic Collection
Enable `enableAutoTrace` through the [configuration](#trace-config) `FTTracer().setConfig`.

### Custom Tracer
#### Usage Method
```dart
  /// Get trace HTTP header data
  /// [key] unique id
  /// [url] request URL
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
  /// [userid] user id
  /// [userName] username
  /// [userEmail] email
  /// [userExt] extended data
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

## WebView Data Monitoring
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) into the WebView accessed page.

## Hybrid Development with Native and Flutter {#hybrid}

If your project is natively developed with some pages or workflows implemented in Flutter, follow these steps for SDK installation and initialization:

* Installation: Follow the [installation](#install) method unchanged.
* Initialization: Refer to [iOS SDK initialization configuration](../ios/app-access.md#init) and [Android SDK initialization configuration](../android/app-access.md#init) for initializing in the native project.
* Flutter Configuration:
    * View, Resource, Error use the same configuration as pure Flutter projects.
    * Flutter Resource and Trace automatic collection use the following configuration:
    ```dart
        // Set traceHeader, supported from version 0.5.3-pre.1
        FTHttpOverrideConfig.global.traceHeader = true;   
        // Set to collect Resource data, supported from version 0.5.3-pre.1
        FTHttpOverrideConfig.global.traceResource = true; 
    ```
   
## Publish Package Configuration
### Android
* [Android R8/Proguard Configuration](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS
* [iOS Symbol File Upload](../ios/app-access.md#source_map)


## Common Issues
- [Android Privacy Review](../android/app-access.md#third-party)
- [iOS Related](../ios/app-access.md#FAQ)
- [Android Related](../android/app-access.md#FAQ)