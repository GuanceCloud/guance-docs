# 故障排查

## SDK 初始化异常校验

在 Debug 环境，当您配置观测云 SDK 并首次运行该应用程序后，请在 Xcode 中检查您的调试器控制台，SDK 会使用断言检查多项配置的正确性并在配置错误时崩溃并输出相关警告。

eg：当配置 SDK 时，未设置  datakit metrics 写入地址，程序会崩溃，并在控制台输出警告⚠️。

```objective-c
*** Assertion failure in +[FTMobileAgent startWithConfigOptions:], FTMobileAgent.m:53
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '请设置 datakit metrics 写入地址'
```

## 开启 Debug 调试 {#debug-mode}

建议在 Debug 环境开启 `FTMobileConfig ` 的配置项 `enableSDKDebugLog = YES` ，Release 环境关闭。 SDK 的调试日志以 **[FTLog]** 作为前缀标识，可以使用 [FTLog] 进行筛选。

**注意**：`scheme` 如果设置了环境变量 `OS_ACTIVITY_MODE=disable` ，将影响 SDK 调试日志的输出，建议移除。

> **建议 Release 版本发布时，关闭这个配置**

## SDK 内部日志转化为缓存文件

```objective-c
// 默认路径：1.4.11-1.4.12 /Library/Caches/FTLogs/FTLog xxxx-xx-xx--xx/xx/xx/xxx.log
//         >= 1.4.13 /Documents/FTLogs/FTLog.log

// >= 1.4.11
 [[FTLog sharedInstance] registerInnerLogCacheToLogsDirectory:nil fileNamePrefix:nil];

// >= 1.4.13
//  方法一: 默认路径
 [[FTLog sharedInstance] registerInnerLogCacheToDefaultPath]
//  方法二: 指定路径
 NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject 
stringByAppendingPathComponent:@"ExampleName.log"];
 [[FTLog sharedInstance] registerInnerLogCacheToLogsFilePath:filePath];
```

> **为了内部日志的完整性，需要在 SDK 初始化之前设置该配置**

## SDK 正常运行但是没有数据

* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行

* 确认 SDK 上传地址 `metricsUrl` [配置正确](app-access.md#base-setting) ，并正确初始化。debug 模式下，可以下列日志来判断上传问题

```objective-c
//以下是正常同步日志
[FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:] [line 143] ↵
                                                开始上报事件(本次上报事件数:2)
[FTLog][INFO] -[FTRequestLineBody getRequestBodyWithEventArray:] [line 149]
Upload Datas Type:RUM
Line RequestDatas:
...... datas ......
[FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:]_block_invoke [line 157] ↵
                                                Upload Response statusCode : 200

//在 1.3.10 版本之前并不会打印 Upload Response statusCode : 200，
//可以查看控制台是否有错误日志，没有错误日志即上传成功。
//错误日志:
//Network failure: .....` 或 服务器异常 稍后再试 ......

```

  在 1.3.10 版本之前并不会打印 `Upload Response statusCode : 200 ` ，可以查看控制台是否有错误日志，没有错误日志即上传成功。

  错误日志:  `Network failure: ......` 或`服务器异常 稍后再试 ...... `

* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

  ![](../img/17.trouble_shooting_android_datakit_check.png)

## 数据采集成功检验

#### Logger 

 `enableConsoleLog` ： 是否允许采集控制台日志

 `enableCustomLog   `：  允许上报自定义日志

若要开启 Logger 功能，请确保上述配置至少开启一项。

SDK 采集到日志时， Xcode 中调试器控制台可以看到 SDK 的调试日志。

```objc
[FTLog][INFO] -[FTRecordModel initWithSource:op:tags:fields:tm:] [line 36] write data = {
    op = Logging;
    opdata =     {
        fields =         {
            message = "xxxxx采集到的日志内容XXXXX";
        };
        source = "df_rum_ios_log";
        tags =         {
             ...... 
        }
   }
}
```

看到 **op = Logging;** 即表明 Logger 功能正常开启，数据成功采集。

#### RUM 

Resource 数据与 Action 数据（launch action 除外）是与 View 进行绑定的，需要确保在 View 被采集的情况下才能正常采集。

View 的采集：设置 `FTRumConfig` 的配置项`enableTraceUserView = YES` 开启自动采集或手动采集 `-startViewWithName` 

 Xcode 中调试器控制台查看 SDK 的调试日志。

```objc
[FTLog][INFO] -[FTRecordModel initWithSource:op:tags:fields:tm:] [line 36] write data = {
    op = RUM;
    opdata =     {
        fields =       {
            .......
        };
        source = action;
        tags =         {
            ........
        }       
   }
}
```

看到 **op = RUM;** 即表明 RUM 功能正常开启，数据成功采集。

#### Trace

如果设置 `enableLinkRumData = YES` ，可以在 RUM Resourse 数据中看到显示。Xcode 中调试器控制台查看 SDK 的调试日志。

```tex
[FTLog][INFO] -[FTRecordModel initWithSource:op:tags:fields:tm:] [line 36] write data = {
    op = RUM;
    opdata =     {
        fields =         {
            duration = 5873084;
            "request_header" = "Accept:*/*\nx-datadog-parent-id:12914452039873665275\nx-datadog-trace-id:6849912365449426814\nx-datadog-origin:rum\nAccept-Language:en-US,en;q=0.9\nAccept-Encoding:gzip, deflate\nx-datadog-sampling-priority:2";
            ......
        };
        source = resource;
        tags =         {
            ......
            "span_id" = 12914452039873665275;
            "trace_id" = 6849912365449426814;
            ......
        };
    };
```

找到 **op = RUM;**  **source = resource;** 的数据，在 **tags** 中包含`span_id` 与 `trace_id` 即表明 Trace 功能正常开启。

## 数据丢失

### 丢失部份数据
1.如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据

  首先需要排除是否在 [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config) 设置了 `sampleRate <  1` 。

2.如果丢失 RUM 中 Resource 事件或 Action 事件（launch action 除外）

  需要检查是否开启 View 的自动采集或者有使用 Open API 手动采集。 Resource 事件或 Action 事件是与 View 进行绑定的，需要确保在 View 被采集的情况下才能正常采集。

3.在 SDK 版本 <= 1.4.14 时，如果丢失部分数据，且在 Xcode 调试器控制台查看到此类调试日志

```tex
*********此条数据格式错误********
(null)*** 1717051153966272768
******************
```

  请确认传入 SDK 的 `NSDictionary` 类型参数是否符合以下要求：

  - 所有字典键都是 NSString

  - 所有对象都是 NSString, NSNumber, NSArray, NSDictionary 或 NSNull

  - NSNumber 不是 NaN 或无穷大

  建议键值都使用 NSString。

4.排查上传数据设备网络与安装 datakit 设备网路与负载问题。

### Error 数据丢失 Crash 类型数据

* 检查是否开启 Crash 采集功能

* SDK 的初始化是否在 Crash 之前完成

* 是否有使用具有捕获 Crash 功能的其他第三方组件，若有将 FTMobileSDK 的初始化放在该组件后面

* 是否在 Xcode 调试阶段
  
  SDK 中有使用 **UNIX 信号** 与 **Mach 异常**捕获崩溃，这两种捕获方式均会受到 Xcode 默认开启的 `Debug executable` 影响。它会在 SDK 捕获这些异常之前拦截掉，因此如果想在调试阶段也能正常捕获崩溃，需要手动将 `Debug executable` 功能关闭，或者不在 Xcode 连接调试下进行测试。
  **注意：**关闭 `Debug executable`  后，断点调试功能将会失效。
  
  ![troubleshooting_debug_executable](../img/troubleshooting_debug_executable.png)

## 版本兼容问题

### RUM Resource 事件中的性能指标缺失

SDK 支持 iOS 9 及以上，RUM Resource 事件中的性能指标，需要使用系统支持 iOS 10 及以上的 API 进行采集 ，所以如果用户设备使用的系统是iOS 10以下，采集的 Resource 事件会缺失性能指标部分。

### RUM  Error 数据中的 carrier 属性显示 `--`

在 iOS 16.4 及以上， `CoreTelephony` 中 `CTCarrier` 被废弃，且没有替换的 API，使用废弃方法会返回静态值 `--`。

## WebView

### **[xxViewController retain]: message sent to deallocated instance xxx**

**影响版本：SDK 版本小于等于 1.4.10**

**原因**：当您在使用 WebView 时，对 WebView 添加了观察者，在观察者即将释放前 WebView 未移除该观察者。由于 SDK 内部对 WebView 进行了强引用，WebView 未被释放，后续观察的 KeyPath 变化时会通知观察者，而观察者已释放，就会出现 `EXC_BAD_ACCESS` 错误。

**修复建议**：

* 升级 SDK 版本

* 或在观察者即将释放前移除该观察者。

```objc
   - (void)createWebView{
     [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
   }
   -(void)dealloc{
     [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"]
   }
```









