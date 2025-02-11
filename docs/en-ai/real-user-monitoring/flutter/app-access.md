# Flutter Application Integration
---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM collector](../../integrations/rum.md);
- Ensure DataKit is [accessible via the public network and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current Flutter version supports only Android and iOS platforms. Log in to the Guance console, go to the **User Access Monitoring (RUM)** page, click on **[Create New Application](../index.md#create)** in the top-left corner, and start creating a new application.

![](../img/image_13.png)

## Installation
![](https://img.shields.io/badge/dynamic/json?label=pub.dev&color=blue&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/flutter/version.json) ![](https://img-shields.io/badge/dynamic/json?label=legacy.github.tag&color=blue&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/flutter/legacy/version.json) ![](https://img-shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/flutter/info.json)

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**Source Code**: [https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo**: [https://github.com/GuanceCloud/datakit-flutter/tree/dev/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

In your project directory, run the Flutter command in the terminal:

```bash
$ flutter pub add ft_mobile_agent_flutter
```

This will add the following line to the `pubspec.yaml` file of the package (and implicitly run `flutter pub get`):

```yaml
dependencies:
  ft_mobile_agent_flutter: [lastest_version]
  
  # For Flutter 2.0 compatibility, use the following reference method
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

* Configure the Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and Android Native events (page transitions, click events, native network requests, WebView data).
* Customize the `Application` class and declare it in `AndroidMainifest.xml`. The code is as follows:

```kotlin
import io.flutter.app.FlutterApplication

/**
* Add custom Application here if you need to track app launches and launch times.
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
    // Local or DataKit deployment
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
| datakitUrl | String | Yes | DataKit access URL, example: http://10.0.0.1:9529, default port 9529. The device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| datawayUrl | String | Yes | DataWay access URL, example: http://10.0.0.1:9528, default port 9528. The device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| cliToken | String | Yes | Authentication token, must be configured with datawayUrl |
| debug | bool | No | Enable logging, default `false` |
| env | String | No | Environment configuration, default `prod`, any string, suggest using a single word like `test` |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. **Note: Only one of env or envType needs to be configured** |
| serviceName | String | No | Service name |

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
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1. Applies to all View, Action, LongTask, Error data under the same session_id |
| enableUserResource | bool | No | Whether to automatically capture HTTP `Resource` data, default `false`. This is achieved by modifying `HttpOverrides.global`. If your project has such requirements, inherit from `FTHttpOverrides` and set `enableAutoTrace` to `false` |
| enableNativeUserAction | bool | No | Whether to track `Native Action`, such as button clicks and app startup events, default `false` |
| enableNativeUserView | bool | No | Whether to automatically track `Native View`, recommend disabling for pure Flutter apps, default `false` |
| enableNativeUserResource | bool | No | Whether to automatically track `Native Resource`, recommend disabling for pure Flutter apps, default `false` |
| errorMonitorType | enum ErrorMonitorType | No | Set auxiliary monitoring information, add additional monitoring data to RUM Error data, e.g., `ErrorMonitorType.battery` for battery level, `ErrorMonitorType.memory` for memory usage, `ErrorMonitorType.cpu` for CPU usage |
| deviceMetricsMonitorType | enum DeviceMetricsMonitorType | No | In the View lifecycle, add monitoring data, e.g., `DeviceMetricsMonitorType.battery` monitors the highest output current of the current page, `DeviceMetricsMonitorType.memory` monitors the current app's memory usage, `DeviceMetricsMonitorType.cpu` monitors CPU jumps, `DeviceMetricsMonitorType.fps` monitors screen frame rate |
| globalContext | Map | No | Custom global parameters |

#### Adding Custom Tags

##### Static Usage

1. Split the original `main.dart` into two parts: one for `main()`, and one for the `MaterialApp` widget;
2. Create corresponding entry files for different environments, such as `main_prod.dart`, `main_gray.dart`, etc.;
3. Configure custom tags in the corresponding environment files. For example:

```dart
/// main_prod.dart
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

1. Use file-based data storage, such as the `shared_preferences` library `SharedPreferences`, configure the SDK, and add code to retrieve tag data in the configuration section.

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

3. Finally, restart the application.

**Note**:

1. Special key: `track_id` (used for tracking features).
2. When users add custom tags via `globalContext` that conflict with SDK-owned tags, the SDK's tags will override the user settings. It is recommended to prefix custom tags with the project abbreviation, e.g., `df_tag_name`. You can [check the source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java) for available `key` values.

### Log Configuration {#log-config}

```dart
 await FTLogger().logConfig(
   enableCustomLog: true
 );
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| enableLinkRumData | bool | No | Whether to link with RUM data |
| enableCustomLog | bool | No | Whether to enable custom logs |
| logLevelFilters | List<FTLogStatus> | No | Log level filters |
| logCacheLimitCount | int | No | Maximum number of local cached log entries [1000,), larger logs mean higher disk cache pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Log discard rule when the limit is reached. Default `FTLogCacheDiscard.discard`, `discard` discards appended data, `discardOldest` discards old data |

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
| sampleRate | double | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| traceType | enum TraceType | No | Trace type, default `TraceType.ddTrace` |
| enableLinkRUMData | bool | No | Whether to link with RUM data, default `false` |
| enableAutoTrace | bool | No | Whether to add `Trace Header` to HTTP requests, default `false`. This is achieved by modifying `HttpOverrides.global`. If your project has such requirements, inherit from `FTHttpOverrides` and set `enableAutoTrace` to `false` |
| enableNativeAutoTrace | bool | No | Whether to enable automatic tracing for native network requests (iOS `NSURLSession`, Android `OKhttp`), default `false` |

## RUM User Data Tracking

### Action {#action}
#### Usage Method
```dart
  /// Add an action
  /// [actionName] Action name
  /// [actionType] Action type
  /// [property] Additional properties (optional)
  Future<void> startAction(String actionName, String actionType, 
  {Map<String, String>? property})
```
#### Code Example
```dart
FTRUMManager().startAction("action name", "action type");
```

### View {#rum-view}
#### Automatic Collection {#view-auto-track-config}
* **Method 1**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, set `MaterialApp.routes` for pages to navigate, where `routes` keys are the page names (`view_name`).

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

// Navigate to this page with the name "logging"
Navigator.pushNamed(context, "logging");

```

* **Method 2**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, use `FTMaterialPageRoute` to generate routes, where the `widget` class name is the page name (`view_name`).

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

// Here the "page name" is "NoRouteNamePage"
Navigator.of(context).push(FTMaterialPageRoute(builder: (context) => 
	new NoRouteNamePage()
```

* **Method 3**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, customize the `RouteSettings.name` property in `Route` types, which `FTRouteObserver` prioritizes. This method also applies to Dialog-type pages like `showDialog()`, `showTimePicker()`, etc.

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

// Here the "page name" is "RouteSettingName"
Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => new NoRouteNamePage(),
              settings: RouteSettings(name: "RouteSettingName"))
```

* All three methods can be mixed in one project.

* Sleep and Wake Events Collection
For versions below 0.5.1-pre.1, if you need to collect sleep and wake events, add the following code:

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
        // RUM View: Filter out pages that do not need monitoring
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
    // RUM View: Filter DialogRoute components
    FTDialogRouteFilterObserver(filterOnlyNoSettingName: true)
])

// Here the Dialog is collected when `filterOnlyNoSettingName` is true.
// view_name is "About"
showAboutDialog(
            context: context, routeSettings: RouteSettings(name: "About"));
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| filterOnlyNoSettingName | bool | No | Only filter Route pages where `RouteSettings.name` is null |

#### Custom View
##### Usage Method

```dart

  /// Create a view, this method should be called before [starView], currently not implemented in Flutter route
  /// [viewName] Page name
  /// [duration]
  Future<void> createView(String viewName, int duration)

  /// Start a view
  /// [viewName] Page name
  /// [viewReferer] Previous page name
  /// [property] Additional properties (optional)
  Future<void> starView(String viewName, {Map<String, String>? property})

  /// Stop a view
  /// [property] Additional properties (optional)
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
    
    // Capture Flutter exceptions
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
  /// [stack] Stack trace
  /// [message] Error message
  /// [appState] Application state
  /// [errorType] Custom errorType
  /// [property] Additional properties (optional)
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
Enable `enableUserResource` in [configuration](#rum-config) via `FTRUMManager().setConfig`.

#### Custom Resource
##### Usage Method

```dart
  /// Start resource request
  /// [key] Unique id
  /// [property] Additional properties (optional)
  Future<void> startResource(String key, {Map<String, String>? property})

  /// End resource request
  /// [key] Unique id
  /// [property] Additional properties (optional)
  Future<void> stopResource(String key, {Map<String, String>? property})

  /// Send resource metrics
  /// [key] Unique id
  /// [url] Request URL
  /// [httpMethod] HTTP method
  /// [requestHeader] Request headers
  /// [responseHeader] Response headers
  /// [responseBody] Response body
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

> Using http library and dio library, refer to [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## Logger Log Printing 
### Custom Logs
> Current log content is limited to 30 KB, exceeding characters will be truncated.

#### Usage Method
```dart

  /// Output log
  /// [content] Log content
  /// [status] Log status
  /// [property] Additional properties (optional)
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
Enable `enableAutoTrace` in [configuration](#trace-config) via `FTTracer().setConfig`.

### Custom Tracer
#### Usage Method
```dart
  /// Get trace HTTP header data
  /// [key] Unique id
  /// [url] Request URL
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

> Using http library and dio library, refer to [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## Binding and Unbinding User Information
### FTMobileFlutter
#### Usage Method
```dart
  /// Bind user
  ///
  /// [userid] User id
  /// [userName] Username
  /// [userEmail] User email
  /// [userExt] Extended data
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
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) into the pages accessed by WebView.


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