# Flutter 应用接入
---

## 前置条件

- 安装 DataKit（[DataKit 安装文档](../../../datakit/datakit-how-to.md)）

## 应用接入
当前 Flutter 版本暂只支持 Android 和 iOS 平台。登录 “观测云” 控制台，进入「应用监测」页面，点击右上角「新建应用」，在新窗口输入「应用名称」，点击「创建」，然后相应接入的平台，即可开始配置。

![](../../img/image_12.png)

![](../../img/image_13.png)

## 安装

**Pub.Dev**: [ft_mobile_agent_flutter](https://pub.dev/packages/ft_mobile_agent_flutter)

**源码地址**：[https://github.com/GuanceCloud/datakit-flutter](https://github.com/GuanceCloud/datakit-flutter)

**Demo 地址**：[https://github.com/GuanceCloud/datakit-flutter/example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example)

在项目路径下，终端运行 Flutter 命令：

```bash
 $ flutter pub add ft_mobile_agent_flutter
```

这将在包的 pubspec.yaml 中添加这样的一行（并运行一个隐式 flutter pub get ）：

```yaml
dependencies:
  ft_mobile_agent_flutter: ^0.2.1-dev.5
```

现在在您的 Dart 代码中，您可以使用：

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

> Android 需要在 app/android 目录下 build.gradle 安装 ft-plugin 配合使用，并在创建自定义 Application，并且 AndroidMainifest.xml  中声明使用，代码如下，详细配置请见 [Android SDK](../../android/app-access.md) 配置，或参考 demo

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

## SDK 初始化
###  基础配置

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

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| serverUrl | String | 是 | 数据上报地址 |
| useOAID | bool | 否 | 是否使用 `OAID` 唯一识别，默认`false`,开启后替换 `deviceUUID` 进行使用，仅仅作用于 Android 设备 |
| debug | bool | 否 | 设置是否允许打印日志，默认`false` |
| datakitUUID | String | 否 | 请求`HTTP`请求头`X-Datakit-UUID` 数据采集端  如果用户不设置会自动配置 |
| envType | enum EnvType | 否 | 环境，默认`prod` |

### RUM 配置

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
        enableNativeUserAction:false,
        enableNativeUserView: false
    );

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| androidAppId | String | 是 | appId，监测中申请 |
| iOSAppId | String | 是 | appId，监测中申请 |
| sampleRate | double | 否 | 采样率，（采集率的值范围为>= 0、<= 1，默认值为 1） |
| enableNativeUserAction | bool | 否 | 是否进行 `Native Action` 追踪，`Button` 点击事件，纯 `Flutter` 应用建议关闭，默认为 `false` |
| enableNativeUserView | bool | 否 | 是否进行 `Native View` 自动追踪，纯 `Flutter` 应用建议关闭，，默认为 `false` |
| enableNativeUserResource | bool | 否 | 是否进行 `Native Resource` 自动追踪，纯 `Flutter` 应用建议关闭，默认为 `false` |
| monitorType | enum MonitorType | 否 | 监控补充类型 |
| globalContext | Map | 否 | 自定义全局参数 |

#### 添加自定义标签

##### 静态使用

1. 拆分原有的 main.dart 为 2 个部分，一部分为 main()，一部分为 App() MaterialApp 组件；
1. 建立对应各个环境的入口文件，如：main_prod.dart、main_gray.dart 等；
1. 在对应的环境文件中进行自定义标签配置。例如：

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

##### 动态使用

1. 通过存文件类型数据，例如 `shared_preferences` 库`SharedPreferences`，配置使用 `SDK`，在配置处添加获取标签数据的代码。

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

2. 在任意处添加改变文件数据的方法。

```dart
 static Future<void> setDynamicParams(String value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(CUSTOM_DYNAMIC_TAG, value);
  }
```

3. 最后重启应用。

> 注意：
> 
> 1. 特殊 key : track_id (用于追踪功能) 
> 1. 当用户通过 globalContext 添加自定义标签与 SDK 自有标签相同时，SDK 的标签会覆盖用户设置的，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。项目中使用 `key` 值可[查询源码](https://github.com/DataFlux-cn/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java)。

### Log 配置

```dart
 await FTLogger().logConfig(
   serviceName: "flutter_agent", 
   enableCustomLog: true
 );
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| sampleRate | double | 否 | 采样率，采集率的值范围为>= 0、<= 1，默认值为 1 |
| serviceName | String | 否 | 服务名 |
| enableLinkRumData | bool | 否 | 是否与 `RUM` 关联 |
| enableCustomLog | bool | 否 | 是否开启自定义日志 |
| discardStrategy | enum FTLogCacheDiscard | 否 | 日志丢弃策略，默认`FTLogCacheDiscard.discard` |
| logLevelFilters | List<FTLogStatus> | 否 | 日志等级过滤 |

### Trace 配置

```dart
await FTTracer().setConfig(
  enableLinkRUMData: true,
  enableNativeAutoTrace: false
);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| sampleRate | double | 否 | 采样率，采集率的值范围为>= 0、<= 1，默认值为 1 |
| serviceName | String | 否 | 服务名 |
| traceType | enum TraceType | 否 | 链路类型，默认`TraceType.ddTrace` |
| enableLinkRUMData | bool | 否 | 是否与 `RUM` 数据关联，默认`false` |
| enableNativeAutoTrace |  bool | 否 | 是否开启原生网络网络自动追踪 iOS `NSURLSession` ,Android `OKhttp`，默认`false` |

## RUM 用户数据追踪

### Action

```dart
FTRUMManager().startAction("action name", "action type");
```

### View

```dart
FTRUMManager().starView("Current Page Name");

FTRUMManager().createView("Current Page Name",100000000)
         
FTRUMManager().stopView();
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

使用 http 库与 dio 库，可参考 [example](https://github.com/DataFlux-cn/datakit-flutter/tree/dev/example/lib)。

## Logger 日志打印 

```dart
FTLogger().logging("info log content", FTLogStatus.info);
```

### 日志等级

| **方法名** | **含义** |
| --- | --- |
| FTLogStatus.info | 提示 |
| FTLogStatus.warning | 警告 |
| FTLogStatus.error | 错误 |
| FTLogStatus.critical | 严重 |
| FTLogStatus.ok | 恢复 |


## Tracer 网络链路追踪

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

使用 http 库与 dio 库，可参考 [example](https://github.com/DataFlux-cn/datakit-flutter/tree/dev/example/lib)。

## 用户信息绑定与解绑

```dart
 FTMobileFlutter.bindUser("flutterUser");

 FTMobileFlutter.unbindUser();
```

## 常见问题

- [iOS 相关](https://www.yuque.com/dataflux/doc/gsto6k#EiSnQ)
- [Android 相关](../../android/app-access.md#FAQ)


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../../img/logo_2.png)
