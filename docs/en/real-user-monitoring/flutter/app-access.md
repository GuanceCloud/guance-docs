# Flutter Application Access
---

## Precondition

- Installing DataKit ([DataKit Installation Documentation](... /... /datakit/datakit-install.md))

## Application Access
The current version of Flutter only supports Android and iOS platforms for now. Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

![](../img/image_12.png)

![](../img/image_13.png)

## Installation

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**Source Code Address**：[https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo Address**：[https://github.com/GuanceCloud/datakit-flutter/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

Under the project path, the terminal runs the Flutter command:

```bash
 $ flutter pub add ft_mobile_agent_flutter
```

This will add a line like this to the package's pubspec.yaml (and run an implicit flutter pub get):

```yaml
dependencies:
  ft_mobile_agent_flutter: ^0.2.7-dev.2
```

Now in your Dart code, you can use:

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

> Android needs to install ft-plugin in app/android directory build.gradle to use with it, and declare it in the custom Application creation and AndroidMainifest.xml, the code is as follows, please see [Android SDK](../android/app-access.md#gradle-setting) for detailed configuration, or refer to the demo

```kotlin
import io.flutter.app.FlutterApplication

/**
* 如果需要统计【启动次数】和【启动时间】需要在此处添加自定义 Application
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
    //初始化 SDK
    await FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true,
    );
}  
```

| Fields | **Type** | Required | **Description** |
| --- | --- | --- | --- |
| serverUrl | String | Yes | The url of the datakit installation address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed s |
| useOAID | bool | No | Whether to use `OAID` for unique identification, default `false`, replace `deviceUUUID` for use when enabled, only for Android devices |
| debug | bool | No | Set whether to allow printing of logs, default `false` |
| datakitUUID | String | No | Request `HTTP` request header `X-Datakit-UUID` Data collection side will be configured automatically if the user does not set |
| envType | enum EnvType | No | Environment, default `prod` |

### RUM Configuration

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
        enableNativeUserAction:false,
        enableNativeUserView: false
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
| monitorType | enum MonitorType | No | Monitoring supplement type |
| globalContext | Map | No | Customizing global parameters |

#### Add Custom Tags

##### Static Use

1. Split the original main.dart into 2 parts, one for main() and one for App() MaterialApp component.
1. Create entry files corresponding to each environment, such as: main_prod.dart, main_gray.dart, etc.
1. Configure custom tags in the corresponding environment files. For example:

```dart
///main_prod.dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //初始化 SDK
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
        //… 添加其他配置
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

### Log Configuration

```dart
 await FTLogger().logConfig(
   serviceName: "flutter_agent", 
   enableCustomLog: true
 );
```

| **Fields** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, the value of the sample rate ranges from >= 0, <= 1, the default value is 1 |
| serviceName | String | No | Service Name |
| enableLinkRumData | bool | No | Associated with `RUM` or not |
| enableCustomLog | bool | No | Whether to enable custom logging |
| discardStrategy | enum FTLogCacheDiscard | No | Log discard policy, default `FTLogCacheDiscard.discard` |
| logLevelFilters | List<FTLogStatus> | No | Log level filtering |

### Trace Configuration

```dart
await FTTracer().setConfig(
  enableLinkRUMData: true,
  enableAutoTrace:false,
  enableNativeAutoTrace: false
);
```

| **Fields** | Type | **Required** | Description |
| --- | --- | --- | --- |
| sampleRate | double | No | Sampling rate, the value of the sample rate ranges from >= 0, <= 1, the default value is 1 |
| serviceName | String | No | Service Name |
| traceType | enum TraceType | No | Trace type, default `TraceType.ddTrace` |
| enableLinkRUMData | bool | No | Whether to associate with `RUM` data, default `false` |
| enableAutoTrace | bool | No | Whether to enable flutter network tracking, default `false` |
| enableNativeAutoTrace |  bool | No | Whether to enable native network auto-tracking iOS `NSURLSession` ,Android `OKhttp`, default `false` |

## RUM User Data Tracking

### Action

```dart
FTRUMManager().startAction("action name", "action type");
```

### View

```dart
FTRUMManager().createView("Current Page Name",100000000)

FTRUMManager().starView("Current Page Name");
         
FTRUMManager().stopView();
```

If you need to capture the hibernation and wake-up behavior of the application you need to add the following code.

```dart
class _HomeState extends State<HomeRoute> {
	
	@override
	void initState(){
	
		//添加应用休眠和唤醒监听
		FTLifeRecycleHandler().initExplorer();
	}
	
	@override
	void dispose(){
	
		//移除应用休眠和唤醒监听
		FTLifeRecycleHandler().removeExplorer();
	}
}

```

### Error

```dart
/// flutter 自动采集 error
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
        enableNativeUserAction:false,
        enableNativeUserView: false
    );
    
    // Flutter 框架异常捕获
    FlutterError.onError = FTRUMManager().addFlutterError;
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    //其它异常捕获与日志收集
    FTRUMManager().addError(error, stack);
  });
  
  
 ///自定义 error
 FTRUMManager().addCustomError("error stack", "error message");
```

### Resource

```dart
/// 使用 httpClient  
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
/// 使用 httpClient    
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

To use the http library and the dio library, see [example](https://github.com/DataFlux-cn/datakit-flutter/tree/dev/example/lib).

## User Information Binding and Unbinding

```dart
 FTMobileFlutter.bindUser("flutterUser");

 FTMobileFlutter.unbindUser();
```

## Frequently Asked Questions 

- [iOS Related](. /ios/app-access.md#FAQ)
- [Android Related](../android/app-access.md#FAQ)

