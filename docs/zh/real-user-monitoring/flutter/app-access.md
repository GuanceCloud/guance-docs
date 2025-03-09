# Flutter 应用接入
---

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入

当前 Flutter 版本暂只支持 Android 和 iOS 平台。登录<<< custom_key.brand_name >>>控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。


![](../img/image_13.png)

## 安装 {#install}
![](https://img.shields.io/badge/dynamic/json?label=pub.dev&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/version.json) ![](https://img.shields.io/badge/dynamic/json?label=legacy.github.tag&color=blue&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/legacy/version.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/flutter/info.json)

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
  ft_mobile_agent_flutter: [lastest_version]
  
  # flutter 2.0 兼容版本使用下面的引用方式
  ft_mobile_agent_flutter:
    git:
      url: https://github.com/GuanceCloud/datakit-flutter.git
      ref: [github_legacy_lastest_tag]
```

现在在您的 Dart 代码中，您可以使用：

```dart
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
```

**Android 集成额外配置**

* 配置 Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting)，采集 App 启动事件，以及 Android Native 原生相关事件（页面跳转、点击事件、Native 网络网络请求、WebView 数据）
* 自定义 `Application`，并`AndroidMainifest.xml` 中声明使用，代码如下.

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
###  基础配置 {#base-setting}

```dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //本地环境部署、Datakit 部署
    await FTMobileFlutter.sdkConfig(
      datakitUrl: datakitUrl
    );

    //使用公网 DataWay
    await FTMobileFlutter.sdkConfig(
      datawayUrl: datawayUrl,
      cliToken: cliToken,
    );
}  
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| datakitUrl | String | 是 | datakit 访问 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529，安装 SDK 设备需能访问该地址。**注意：datakit 和 dataway 配置两者二选一**|
| datawayUrl | String | 是 | dataway 访问 URL 地址，例子：http://10.0.0.1:9528，端口默认 9528，安装 SDK 设备需能访问这地址。**注意：datakit 和 dataway 配置两者二选一** |
| cliToken | String | 是 | 认证 token, 需要与 datawayUrl 同时配置  |
| debug | bool | 否 | 设置是否允许打印日志，默认 `false` |
| env | String | 否 | 环境配置，默认 `prod`，任意字符，建议使用单个单词，例如 `test` 等|
| envType | enum EnvType | 否 | 环境配置，默认 `EnvType.prod`。**注：env 与 envType 只需配置一个** |
| serviceName | String | 否 | 服务名 |
| enableLimitWithDbSize | boolean | 否 | 开启使用 db 限制数据大小，默认 100MB，单位 Byte，数据库越大，磁盘压力越大，默认不开启。<br>**注意：**开启之后 Log 配置  `logCacheLimitCount` 及 RUM 配置`rumCacheLimitCount` 将失效。SDK  0.3.10  以上版本支持该参数 |
| dbCacheLimit | number | 否 | DB 缓存限制大小。范围 [30MB,)，默认 100MB，单位 byte，SDK 0.3.10  以上版本支持该参数 |
| dbDiscardStrategy | string | 否 | 设置数据库中数据丢弃规则。<br>丢弃策略：`FTDBCacheDiscard.discard`丢弃新数据（默认）、`FTDBCacheDiscard.discardOldest`丢弃旧数据。SDK 0.3.10 以上版本支持该参数 |
### RUM 配置 {#rum-config}

```dart
 await FTRUMManager().setConfig(
        androidAppId: appAndroidId, 
        iOSAppId: appIOSId,
    );

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| androidAppId | String | 是 | appId，监测中申请 |
| iOSAppId | String | 是 | appId，监测中申请 |
| sampleRate | double | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据     |
| enableUserResource | bool | 否 | 是否开启  http `Resource` 数据自动抓取，默认为 `false`，这个是通过修改 `HttpOverrides.global` 来实现，如果项目有这方面定制需求需要继承 `FTHttpOverrides`。 |
| enableNativeUserAction | bool | 否 | 是否进行 `Native Action` 追踪，原生系统 `Button` 点击事件，应用启动事件，默认为 `false` |
| enableNativeUserView | bool | 否 | 是否进行 `Native View` 自动追踪，纯 `Flutter` 应用建议关闭，，默认为 `false` |
| enableNativeUserResource | bool | 否 | 是否进行 `Native Resource` 自动追踪，纯 `Flutter` 应用建议关闭，默认为 `false` |
| errorMonitorType | enum ErrorMonitorType | 否 | 设置辅助监控信息，添加附加监控数据到 `RUM` Error 数据中，`ErrorMonitorType.battery` 为电池余量，`ErrorMonitorType.memory` 为内存用量，`ErrorMonitorType.cpu` 为 CPU 占有率 |
| deviceMetricsMonitorType | enum DeviceMetricsMonitorType | 否 |在 View 周期中，添加监控数据，`DeviceMetricsMonitorType.battery` 监控当前页的最高输出电流输出情况，`DeviceMetricsMonitorType.memory` 监控当前应用使用内存情况，`DeviceMetricsMonitorType.cpu` 监控 CPU 跳动次数 ，`DeviceMetricsMonitorType.fps` 监控屏幕帧率 |
| globalContext | Map | 否 | 自定义全局参数 |
| rumDiscardStrategy | string | 否 | 丢弃策略：`FTRUMCacheDiscard.discard`丢弃新数据（默认）、`FTRUMCacheDiscard.discardOldest`丢弃旧数据 |
| rumCacheLimitCount | number | 否 | 本地缓存最大 RUM 条目数量限制 [10_000,)，默认 100_000 |
| isInTakeUrl | callBack | 否 | 设置需要过滤的 Resource 条件，默认不过滤|

#### 添加自定义标签

##### 静态使用

1. 拆分原有的 main.dart 为 2 个部分，一部分为 main()，一部分为 App() MaterialApp 组件；
2. 建立对应各个环境的入口文件，如：main_prod.dart、main_gray.dart 等；
3. 在对应的环境文件中进行自定义标签配置。例如：

```dart
///main_prod.dart
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    //初始化 SDK
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

**注意**：

1. 特殊 key : track_id (用于追踪功能) 。
2. 当用户通过 globalContext 添加自定义标签与 SDK 自有标签相同时，SDK 的标签会覆盖用户设置的，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。项目中使用 `key` 值可[查询源码](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java)。

### Log 配置 {#log-config}

```dart
 await FTLogger().logConfig(
   enableCustomLog: true
 );
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| sampleRate | double | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。     |
| enableLinkRumData | bool | 否 | 是否与 `RUM` 关联 |
| enableCustomLog | bool | 否 | 是否开启自定义日志 |
| logLevelFilters | List<FTLogStatus> | 否 | 日志等级过滤 |
| logCacheLimitCount | int | 否 | 本地缓存最大日志条目数量限制 [1000,)，日志越大，代表磁盘缓存压力越大，默认 5000 |
| discardStrategy | enum FTLogCacheDiscard | 否 | 设置日志达到限制上限以后的日志丢弃规则。默认`FTLogCacheDiscard.discard`，`discard` 丢弃追加数据, `discardOldest` 丢弃老数据 |


### Trace 配置 {#trace-config}

```dart
await FTTracer().setConfig(
  enableLinkRUMData: true,
  enableAutoTrace:false,
  enableNativeAutoTrace: false
);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| sampleRate | double | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。   |
| traceType | enum TraceType | 否 | 链路类型，默认`TraceType.ddTrace`。 |
| enableLinkRUMData | bool | 否 | 是否与 `RUM` 数据关联，默认`false`。 |
| enableAutoTrace | bool | 否 | 是否 `http` 请求中添加 `Trace Header`，默认`false`，这个是通过修改 `HttpOverrides.global` 来实现，如果项目有这方面更改需求需要继承 `FTHttpOverrides`|
| enableNativeAutoTrace |  bool | 否 | 是否开启原生网络自动追踪 iOS `NSURLSession` ,Android `OKhttp`，默认`false`。 |

## RUM 用户数据追踪

### Action {#action}
#### 使用方法
```dart
  /// 添加 action
  /// [actionName] action 名称
  /// [actionType] action 类型
  /// [property] 附加属性参数(可选)
  Future<void> startAction(String actionName, String actionType, 
  {Map<String, String>? property})
```
#### 代码示例
```dart
FTRUMManager().startAction("action name", "action type");
```

### View {#rum-view}
#### 自动采集 {#view-auto-track-config}
* **方法 1**:  `MaterialApp.navigatorObservers` 添加 `FTRouteObserver `，设置 `MaterialApp.routes` 需要跳转的页面，`routes` 中 `key` 即为页面名称(`view_name`)。

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View： 使用路由跳转时，监控页面生命周期
        FTRouteObserver(),
      ],
      routes: <String, WidgetBuilder>{
        //set Route 路由跳转
        'logging': (BuildContext context) => Logging(),
        'rum': (BuildContext context) => RUM(),
        'tracing_custom': (BuildContext context) => CustomTracing(),
        'tracing_auto': (BuildContext context) => AutoTracing(),
      },
    );
  }
}

//通过这种方式进行页面跳转，此处页面名称为 logging
Navigator.pushNamed(context, "logging");

```

* **方法 2**: `MaterialApp.navigatorObservers` 添加 `FTRouteObserver `，通过`FTMaterialPageRoute`配合使用生成，其中 `widget` 类名称即为页面名称(`view_name`)。

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View： 使用路由跳转时，监控页面生命周期
        FTRouteObserver(),
      ],
    );
  }
}

//此处“页面名称”为 NoRouteNamePage
Navigator.of(context).push(FTMaterialPageRoute(builder: (context) => 
	new NoRouteNamePage()
```

* **方法 3**: `MaterialApp.navigatorObservers` 添加 `FTRouteObserver `,在 `Route` 类型页面中自定义 `RouteSettings.name` 属性，`FTRouteObserver ` 的采集逻辑会优先获取 `RouteSettings.name` 的赋值，这个方法同样适用 Dialog 类型页面，例如 `showDialog()`,`showTimePicker()` 等。

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeRoute(),
      navigatorObservers: [
        //RUM View： 使用路由跳转时，监控页面生命周期
        FTRouteObserver(),
      ],
    );
  }
}

//此处“页面名称”为 "RouteSettingName"
Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => new NoRouteNamePage(),
              settings: RouteSettings(name: "RouteSettingName"))
```

* 以上三种方法同时在一个项目中混合使用

* 休眠和唤醒事件采集
低于 0.5.1-pre.1 版本，如果需要采集应用休眠和唤醒行为需要添加如下代码：

```dart
class _HomeState extends State<HomeRoute> {
	
	@override
	void initState(){
	
		//添加应用休眠和唤醒监听
		FTLifeRecycleHandler().initObserver();
	}
	
	@override
	void dispose(){
	
		//移除应用休眠和唤醒监听
		FTLifeRecycleHandler().removeObserver();
	}
}

```

#### 自动采集过滤  {#view-auto-track-route-filter}
仅支持 0.5.0-pre.1 以上的版本

**FTRouteObserver**

```dart
MaterialApp(
  navigatorObservers: [
        // RUM View： routeFilter 过滤不需要参与监听的页面
         FTRouteObserver(routeFilter: (Route? route, Route? previousRoute) {
          if (filterConfig) {
            //不采集
            return true;
           }
           return false;
        }),
])

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| routeFilter | RouteFilter | 否 | 页面方法回调，可以根据进入和上一个 route 具体情况进行判断，返回 true 代表过滤符合条件的数据 ，反之则不过滤  |

**FTDialogRouteFilterObserver**

针对 `DialogRoute` 类型页面进行过滤，例如 `showDialog()`,`showTimePicker()` 等。

```dart
MaterialApp(
  navigatorObservers: [
    //RUM View 过滤 DialogRoute 类型的组件
    FTDialogRouteFilterObserver(filterOnlyNoSettingName: true)
])

// 这里的 Dialog 在 filterOnlyNoSettingName 为 true 的前提下会被采集。
// view_name 为 “About”
showAboutDialog(
            context: context, routeSettings: RouteSettings(name: "About"));
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| filterOnlyNoSettingName | bool | 否 | 仅过滤 `RouteSettings.name` 为 null 的 Route 页面  |

#### 自定义 View
##### 使用方法

```dart

  /// view 创建,这个方法需要在 [starView] 之前被调用，目前 flutter route 中未有
  /// [viewName] 界面名称
  /// [duration]
  Future<void> createView(String viewName, int duration)

  /// view 开始
  /// [viewName] 界面名称
  /// [viewReferer] 前一个界面名称
  /// [property] 附加属性参数(可选)
  Future<void> starView(String viewName, {Map<String, String>? property})

  /// view 结束
  /// [property] 附加属性参数(可选)
  Future<void> stopView({Map<String, String>? property})

```

##### 代码示例
```dart
FTRUMManager().createView("Current Page Name", 100000000)

FTRUMManager().starView("Current Page Name");
         
FTRUMManager().stopView();
```
### Error {#error}
#### 自动采集
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
    
    // Flutter 异常捕获
    FlutterError.onError = FTRUMManager().addFlutterError;
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    //添加 Error 数据
    FTRUMManager().addError(error, stack);
  });
 
```
#### 自定义 Error
##### 使用方法

```dart
  ///添加自定义错误
  /// [stack] 堆栈日志
  /// [message] 错误信息
  /// [appState] 应用状态
  /// [errorType] 自定义 errorType
  /// [property] 附加属性参数(可选)
  Future<void> addCustomError(String stack, String message,
   {Map<String, String>? property, String? errorType}) 
```

##### 代码示例

```dart 
 ///自定义 error
 FTRUMManager().addCustomError("error stack", "error message");
```

### Resource

#### 自动采集
通过[配置](#rum-config) `FTRUMManager().setConfig` 开启 `enableUserResource`来实现。

#### 自定义 Resource
##### 使用方法

```dart
  ///开始资源请求
  /// [key] 唯一 id
  /// [property] 附加属性参数(可选)
  Future<void> startResource(String key, {Map<String, String>? property})

  ///结束资源请求
  /// [key] 唯一 id
  /// [property] 附加属性参数(可选)
  Future<void> stopResource(String key, {Map<String, String>? property})

  /// 发送资源数据指标
  /// [key] 唯一 id
  /// [url] 请求地址
  /// [httpMethod] 请求方法
  /// [requestHeader] 请求头参数
  /// [responseHeader] 返回头参数
  /// [responseBody] 返回内容
  /// [resourceStatus] 返回状态码
  Future<void> addResource(
      {required String key,
      required String url,
      required String httpMethod,
      required Map<String, dynamic> requestHeader,
      Map<String, dynamic>? responseHeader,
      String? responseBody = "",
      int? resourceStatus})
```

##### 代码示例

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

> 使用 http 库与 dio 库，可参考 [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib)。

## Logger 日志打印 
### 自定义日志
> 目前日志内容限制为 30 KB，字符超出部分会进行截断处理

#### 使用方法
```dart

  ///输出日志
  ///[content] 日志内容
  ///[status] 日志状态
  ///[property] 附加属性参数(可选)
  Future<void> logging(String content, FTLogStatus status, {Map<String, String>? property})

```
#### 代码示例
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
### 自动采集
通过[配置](#trace-config) `FTTracer().setConfig` 开启 `enableAutoTrace`来实现。

### 自定义 Tracer
#### 使用方法
```dart
  /// 获取 trace http 请求头数据
  /// [key] 唯一 id
  /// [url] 请求地址
  ///
  Future<Map<String, String>> getTraceHeader(String url, {String? key})
```
#### 代码示例

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

> 使用 http 库与 dio 库，可参考 [example](https://github.com/GuanceCloud/datakit-flutter/tree/dev/example/lib)。

## 用户信息绑定与解绑
### FTMobileFlutter
#### 使用方法
```dart
  ///绑定用户
  ///
  ///[userid] 用户 id
  ///[userName] 用户名
  ///[userEmail] 用户邮箱
  ///[userExt] 扩展数据
  static Future<void> bindRUMUserData(String userId,
      {String? userName, String? userEmail, Map<String, String>? ext})

  ///解绑用户
  static Future<void> unbindRUMUserData()

```
#### 代码示例
```dart
 FTMobileFlutter.bindUser("flutterUser");

 FTMobileFlutter.unbindUser();
```

## WebView 数据监测
WebView 数据监测，需要在 WebView 访问页面集成[Web 监测 SDK](../web/app-access.md)


##  原生与 Flutter 混合开发 {#hybrid}

如果您的项目是原生开发，部分页面或业务流程使用 Flutter 实现，SDK 的安装初始化配置方法如下：

* 安装：[安装](#install)方式不变
* 初始化：请参考 [iOS SDK 初始化配置](../ios/app-access.md#init) 、[Android SDK 初始化配置](../android/app-access.md#init) 在原生工程内进行初始化配置
* Flutter 配置:
    * View, Resource, Error 采用与纯 Flutter 项目一样的配置方式
    * Flutter Resource 与 Trace 自动采集使用以下配置方式
    ```dart
        // 设置 traceHeader 0.5.3-pre.1 支持
        FTHttpOverrideConfig.global.traceHeader = true;   
        //设置采集 Resource 数据 0.5.3-pre.1 支持
        FTHttpOverrideConfig.global.traceResource = true; 
    ```
   
## Publish Package 相关配置
### Android
* [Android R8/Prograd 配置](../android/app-access.md#r8_proguard)
* [Android 符号文件上传](../android/app-access.md#source_map)

### iOS
* [iOS 符号文件上传](../ios/app-access.md#source_map)


## 常见问题
- [Android 隐私审核](../android/app-access.md#third-party)
- [iOS 相关](../ios/app-access.md#FAQ)
- [Android 相关](../android/app-access.md#FAQ)

