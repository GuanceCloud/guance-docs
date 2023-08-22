# Flutter Application Access
---

## Precondition

- Installing [DataKit](../../datakit/datakit-install.md)；  
- Collector Configuration [RUM Coloctor](../../integrations/rum.md)；
- DataKit Configure[ for public access and install IP geolocation services.](../../datakit/datakit-tools-how-to.md#install-ipdb)

## Application Access
The current version of Flutter only supports Android and iOS platforms for now. Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

![](../img/image_12.png)

![](../img/image_13.png)

## Installation
![](https://img.shields.io/badge/dynamic/json?label=pub.dev&color=blue&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/flutter/version.json) ![](https://img.shields.io/badge/dynamic/json?label=legacy.github.tag&color=blue&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/flutter/legacy/version.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/flutter/info.json)

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**Source Code**：[https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo**：[https://github.com/GuanceCloud/datakit-flutter/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

Under the project path, the terminal runs the Flutter command:

```bash
 $ flutter pub add ft_mobile_agent_flutter
```

This will add a line like this to the package's pubspec.yaml (and run an implicit flutter pub get):

```yaml
dependencies:
  ft_mobile_agent_flutter: [lastest_version]
  
  # flutter 2.0 Compatible Version
  ft_mobile_agent_flutter:
    git:
      url: https://github.com/GuanceCloud/datakit-flutter.git
      ref: [github_legacy_lastest_tag]
```

Now in your Dart code, you can use:

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

> Android needs to install ft-plugin in app/android directory build.gradle to use with it, and declare it in the custom Application creation and AndroidMainifest.xml, the code is as follows, please see [Android SDK](../android/app-access.md#gradle-setting) for detailed configuration, or refer to the demo

```kotlin
import io.flutter.app.FlutterApplication

/**
* If you need to track "number of launches" and "launch time," you need to add a custom Application here.
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
###  Basic Configuration

```dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //Initialization SDK
    await FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true,
    );
}  
```

| Fields | **Type** | Required | **Description** |
| --- | --- | --- | --- |
| serverUrl | String | Yes | The url of the datakit installation address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed s |
| debug | bool | No | Set whether to allow printing of logs, default `false` |
| envType | enum EnvType | No | Environment, default `EnvType.prod` |
| env | String | No | Environment, defaulting to prod, any character is allowed, preferably a single word, such as test, etc.|
| serviceName | String | No | Service name |

### RUM Configuration

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
    );

```

| **Fields** | **Type** | **Required** | Description |
| --- | --- | --- | --- |
| androidAppId | String | Yes | appId, apply under monitoring |
| iOSAppId | String | Yes | appId, apply under monitoring |
| sampleRate | double | No | Sampling rate, (values for sample rate range from >= 0, <= 1, default value is 1) |
| enableNativeUserAction | bool | No | Whether or not to do `Native Action` tracking, `Button` click events, pure `Flutter` applications are recommended to be turned off, default is `false` |
| enableNativeUserView | bool | No | Whether to do `Native View` auto-tracking, recommended to be turned off for pure `Flutter` applications, default is `false` |
| enableNativeUserResource | bool | No | Whether to do `Native Resource` auto-tracking, pure `Flutter` applications are recommended to turn it off, default is `false` |
| errorMonitorType | enum ErrorMonitorType | No | Configure auxiliary monitoring information, and add additional monitoring data to `RUM` Error data. Use `ErrorMonitorType.battery` for battery level, `ErrorMonitorType.memory` for memory usage, and `ErrorMonitorType.cpu` for CPU usage. |
| deviceMetricsMonitorType | enum DeviceMetricsMonitorType | No |During the View lifecycle, add monitoring data. Use DeviceMetricsMonitorType.battery to monitor the highest current output of the battery on the current page, DeviceMetricsMonitorType.memory to monitor the memory usage of the current application, DeviceMetricsMonitorType.cpu to monitor CPU spikes, and DeviceMetricsMonitorType.fps to monitor the screen frame rate. |
| globalContext | Map | No | Custom global parameters. |


#### Add Custom Tags

##### Static Use

1. Split the original main.dart into 2 parts, one for main() and one for App() MaterialApp component.
1. Create entry files corresponding to each environment, such as: main_prod.dart, main_gray.dart, etc.
1. Configure custom tags in the corresponding environment files. For example:

```dart
///main_prod.dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //Initialization SDK
    await FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true,
    );
    await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
        globalContext: {CUSTOM_STATIC_TAG:"prod_static_tag"},
    );
    runApp(MyApp());
  };
}
```

##### Dynamic Use

1.By storing file type data, such as `shared_preferences` library `SharedPreferences`, configure the use of `SDK` and add the code to get the tag data at the configuration.

```dart
final prefs = await SharedPreferences.getInstance();
String customDynamicValue = prefs.getString("customDynamicValue")?? "not set";

 await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
        globalContext: {CUSTOM_DYNAMIC_TAG:customDynamicValue},
        //… Other configuration
    );
```

2.Add a way to change the file data anywhere.

```dart
 static Future<void> setDynamicParams(String value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(CUSTOM_DYNAMIC_TAG, value);
  }
```

3.Finally restart the application.

> Note:
> 
> 1. special key : track_id (for tracking function) 
> 1. When the user adds a custom tag through globalContext and the SDK has the same tag, the SDK tag will override the user set, it is recommended that the tag name add the prefix of the project abbreviation, such as `df_tag_name`. Project use `key` value can be [query source code](https://github.com/DataFlux-cn/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants. java).

### Log Configuration {#log-config}

```dart
 await FTLogger().logConfig(
   enableCustomLog: true
 );
```

| **Fields** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, the value of the sample rate ranges from >= 0, <= 1, the default value is 1 |
| enableLinkRumData | bool | No | Associated with `RUM` or not |
| enableCustomLog | bool | No | Whether to enable custom logging |
| discardStrategy | enum FTLogCacheDiscard | No | Log discard policy, default `FTLogCacheDiscard.discard` |
| logLevelFilters | List<FTLogStatus> | No | Log level filtering |

### Trace Configuration {#trace-config}

```dart
await FTTracer().setConfig(
  enableLinkRUMData: true,
  enableAutoTrace:false,
  enableNativeAutoTrace: false
);
```

| **Fields** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, the value of the sample rate ranges from >= 0, <= 1, the default value is 1 |
| traceType | enum TraceType | No | Trace type, default `TraceType.ddTrace` |
| enableLinkRUMData | bool | No | Whether to associate with `RUM` data, default `false` |
| enableAutoTrace | bool | No | Whether to enable flutter network tracking, default `false` |
| enableNativeAutoTrace |  bool | No | Whether to enable native network auto-tracking iOS `NSURLSession` ,Android `OKhttp`, default `false` |

## RUM User Data Tracking

### Action {#action}

```dart
FTRUMManager().startAction("action name", "action type");
```

### View {#rum-view}
#### Auto Track
* **Method 1**:  Add `FTRouteObserver` to `MaterialApp.navigatorObservers`, and configure the pages to navigate to in `MaterialApp.routes`. In the `routes` section, the `key` corresponds to the page name (`view_name`).

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View： Monitor page lifecycle when using routing for Navigation
        FTRouteObserver(),
      ],
      routes: <String, WidgetBuilder>{
        //set Router looper
        'logging': (BuildContext context) => Logging(),
        'rum': (BuildContext context) => RUM(),
        'tracing_custom': (BuildContext context) => CustomTracing(),
        'tracing_auto': (BuildContext context) => AutoTracing(),
      },
    );
  }
}

// Page navigation using this approach, with the page name as 'logging'.
Navigator.pushNamed(context, "logging");

```

* **Method 2**: Add `FTRouteObserver` to `MaterialApp.navigatorObservers` and generate using `FTMaterialPageRoute`. In this approach, the `widget` class name serves as the page name (`view_name`).

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View： Monitor page lifecycle when using routing for Navigation
        FTRouteObserver(),
      ],
    );
  }
}

//View Name is NoRouteNamePage
Navigator.of(context).push(
          FTMaterialPageRoute(builder: (context) => new NoRouteNamePage()
```

If you need to capture the hibernation and wake-up behavior of the application you need to add the following code.

```dart
class _HomeState extends State<HomeRoute> {
	
	@override
	void initState(){
	
		//Add Application sleep and wake-up listeners.
		FTLifeRecycleHandler().initObserver();
	}
	
	@override
	void dispose(){
	
		//Remove Application sleep and wake-up listeners.
		FTLifeRecycleHandler().removeObserver();
	}
}

```
#### Custom View

```dart
FTRUMManager().createView("Current Page Name",100000000)

FTRUMManager().starView("Current Page Name");
         
FTRUMManager().stopView();
```


### Error {#error}
#### Auto Track
```dart

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true,
    );
    await FTRUMManager().setConfig(
        androidAppId: appAndroidId,
        iOSAppId: appIOSId,
    );
    
    // Flutter Exception Handling
    FlutterError.onError = FTRUMManager().addFlutterError;
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    //Add Error Data
    FTRUMManager().addError(error, stack);
  });
 
```
#### Custom Error
``` 
 FTRUMManager().addCustomError("error stack", "error message");
```

### Resource

#### Auto Track
Achieve this by enabling `enableUserResource` through the configuration using `FTRUMManager().setConfig` as described in the [configuration](#rum-config) section.

#### Custom Resource

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

To use the http library and the dio library, see [example](https://github.com/DataFlux-cn/datakit-flutter/tree/dev/example/lib).

## Logger Log Printing 

```dart
FTLogger().logging("info log content", FTLogStatus.info);
```

### Log Level

| Method Name | Meaning |
| --- | --- |
| FTLogStatus.info | info |
| FTLogStatus.warning | warning |
| FTLogStatus.error | error |
| FTLogStatus.critical | critical |
| FTLogStatus.ok | ok |


## Tracer Network Trace Tracking

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

To use the http library and the dio library, see [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib).

## User Information Binding and Unbinding

```dart
 FTMobileFlutter.bindUser("flutterUser");

 FTMobileFlutter.unbindUser();
```

## FAQ

- [iOS Related](. /ios/app-access.md#FAQ)
- [Android Related](../android/app-access.md#FAQ)

