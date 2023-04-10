# macOS 应用接入
---

## 简介

观测云应用监测能够通过收集各个 macOS 应用的指标数据，以可视化的方式分析各个 macOS 应用端的性能。

## 前置条件

- 安装 DataKit（[DataKit 安装文档](../../datakit/datakit-install.md)）

## macOS应用接入

登录观测云控制台，进入「用户访问监测」页面，点击右上角「新建应用」，在新窗口输入「应用名称」并自定义「应用 ID 标识」，点击「创建」，即可选择应用类型获取接入方式。

- 应用名称（必填项）：用于识别当前实施用户访问监测的应用名称。
- 应用 ID（必填项）：应用在当前工作空间的唯一标识，用于 SDK 采集数据上传匹配，数据入库后对应字段：app_id 。该字段仅支持英文、数字、下划线输入，最多为 48 个字符。

![](../img/13.rum_access_3.png)
## 安装

![](https://img.shields.io/cocoapods/p/FTMacOSSDK#crop=0&crop=0&crop=1&crop=1&id=xs5E2&originHeight=20&originWidth=82&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/cocoapods/v/FTMacOSSDK#crop=0&crop=0&crop=1&crop=1&id=Uyl38&originHeight=20&originWidth=122&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/cocoapods/l/FTMacOSSDK#crop=0&crop=0&crop=1&crop=1&id=SxRum&originHeight=20&originWidth=98&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/badge/macOS-api%20%3E=%20macOS%2010.13-brightgreen#crop=0&crop=0&crop=1&crop=1&id=uFhFJ&originHeight=20&originWidth=118&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=) 

**源码地址**：[https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**：[https://github.com/GuanceCloud/datakit-macos/tree/develop/Example](https://github.com/GuanceCloud/datakit-macos/tree/develop/Example)


### CocoaPods 方式

1.配置 `Podfile` 文件。

```objectivec
target 'yourProjectName' do

# Pods for your project
 pod 'FTMacOSSDK', '1.0.0-alpha.1'
    
end
```

2.在 `Podfile` 目录下执行 `pod install` 安装 SDK。

### Swift Package Manager 方式

1.选中 **File** 菜单，然后选择 **Swift Packages > Add Package Dependency**。

2.在搜索框中输入 `https://github.com/GuanceCloud/datakit-macos`，这是代码的存储位置。

3.Xcode 获取软件包成功后，选中 `Add To Project` 选择支持的工程。`Dependency Rule` 建议选择 `Up to Next Major Version` ，填上版本号，等待加载完成。

4.选中 **Target** -> **Build Phases** -> **Link Binary With Libraries** -> **+** 添加 `FTMacOSSDK.framwork` ，将包添加到工程中。

如果您的项目由 SPM 管理，将 FTMacOSSDK 添加为依赖项，添加 `dependencies ` 到 `Package.swift`。

```
dependencies: [
    .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "1.0.0-alpha.1"))
]
```

### 添加头文件

```objectivec
#import "FTMacOSSDK.h"
```

## SDK 初始化

### 基础配置 {#base-setting}

由于第一个显示的视图 `NSViewController` 的 `viewDidLoad` 方法、 `NSWindowController` 的 `windowDidLoad` 方法调用要早于 AppDelegate `applicationDidFinishLaunching`，为避免第一个视图的生命周期采集异常，建议在 ` main.m`  文件中进行 SDK 初始化。

```objectivec
// main.m 文件
#import "FTMacOSSDK.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        FTSDKConfig *config = [[FTSDKConfig alloc]initWithMetricsUrl:@"YOUR_ACCESS_SERVER_URL"];
        config.enableSDKDebugLog = YES;
        [FTSDKAgent startWithConfigOptions:config];
    }
    return NSApplicationMain(argc, argv);
}

```

| **字段**          | **类型**     | **说明**                                                     | **必须**              |
| ----------------- | ------------ | ------------------------------------------------------------ | --------------------- |
| metricsUrl        | NSString     | datakit 安装地址 URL 地址，例子：http://datakit.url:[port]。注意：安装 SDK 设备需能访问这地址 | 是                    |
| enableSDKDebugLog | BOOL         | 设置是否允许打印日志                                         | 否（默认NO）          |
| env               | NS_ENUM      | 环境                                                         | 否  （默认FTEnvProd） |
| XDataKitUUID      | NSString     | 请求HTTP请求头X-Datakit-UUID 数据采集端  如果用户不设置会自动配置 | 否                    |
| globalContext     | NSDictionary | [添加自定义标签](#user-global-context)                       | 否                    |
| service           | NSString     | 设置所属业务或服务的名称，影响 Log 和 RUM 中 service 字段数据。默认：`df_rum_macos` | 否                    |

#### env 环境

```objectivec
typedef NS_ENUM(NSInteger, FTEnv) {
    FTEnvProd         = 0, //线上环境
    FTEnvGray,             //灰度环境
    FTEnvPre,              //预发布环境
    FTEnvCommon,           //日常环境
    FTEnvLocal,            //本地环境
};

@property (nonatomic, assign) FTEnv env;
```

### RUM 配置 {#rum-config}

```objectivec
    //开启 rum
    FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
    rumConfig.appid = appid;
    rumConfig.enableTrackAppCrash = YES;
    rumConfig.enableTrackAppANR = YES;
    rumConfig.enableTrackAppFreeze = YES;
    rumConfig.enableTraceUserAction = YES;
	  rumConfig.enableTraceUserVIew = YES;
    rumConfig.deviceMetricsMonitorType = FTDeviceMetricsMonitorAll;
    [[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

| **字段**                 | **类型**     | **说明**                                                     | **必须**                 |
| ------------------------ | ------------ | ------------------------------------------------------------ | ------------------------ |
| appid                    | NSString     | 用户访问监测应用 ID 唯一标识，在用户访问监测控制台上面创建监控时自动生成。 | 否（开启RUM 必选）       |
| sampleRate               | int          | 采样采集率                                                   | 否（默认100）            |
| enableTrackAppCrash      | BOOL         | 设置是否需要采集崩溃日志                                     | 否（默认NO）             |
| enableTrackAppANR        | BOOL         | 采集ANR卡顿无响应事件                                        | 否（默认NO）             |
| enableTrackAppFreeze     | BOOL         | 采集UI卡顿事件                                               | 否（默认NO）             |
| enableTraceUserAction    | BOOL         | 设置是否追踪用户 Action 操作                                 | 否（默认NO）             |
| enableTraceUserView      | BOOL         | 设置是否追踪用户 View 操作                                   | 否（默认NO）             |
| globalContext            | NSDictionary | [添加自定义标签](#user-global-context)                       | 否                       |
| errorMonitorType         | NS_OPTIONS   | 错误事件监控补充类型                                         | 否                       |
| deviceMetricsMonitorType | NS_OPTIONS   | 视图的性能监控类型                                           | 否（未设置则不开启监控） |
| monitorFrequency         | NS_OPTIONS   | 视图的性能监控采样周期                                       | 否                       |

#### 监控数据配置

配置 `FTRumConfig` 的 `errorMonitorType` 属性，将在采集的崩溃数据中添加对应的信息。可采集的类型如下：

```objectivec
/// ERROR 中的设备信息
typedef NS_OPTIONS(NSUInteger, FTErrorMonitorType) {
    /// 开启所有监控： 电池、内存、CPU使用率
    FTErrorMonitorAll          = 0xFFFFFFFF,
    /// 电池电量
    FTErrorMonitorBattery      = 1 << 1,
    /// 内存总量、内存使用率
    FTErrorMonitorMemory       = 1 << 2,
    /// CPU使用率
    FTErrorMonitorCpu          = 1 << 3,
};
```

配置 `FTRumConfig` 的 `deviceMetricsMonitorType` 属性，将在采集的  **View** 数据中添加对应监控项信息，同时可配置 `monitorFrequency` 来设置监控采样周期。可采集的类型与采样周期如下：

```objective-c
/**
 * 监控项
 * @constant
 *  FTDeviceMetricsMonitorMemory   - 平均内存、最高内存
 *  FTDeviceMetricsMonitorCpu      - CPU跳动最大、平均数
 */
typedef NS_OPTIONS(NSUInteger, FTDeviceMetricsMonitorType){
    FTDeviceMetricsMonitorAll      = 0xFFFFFFFF,
    FTDeviceMetricsMonitorCpu      = 1 << 1,
    FTDeviceMetricsMonitorMemory   = 1 << 2,
};

/**
 * 监控项采样周期
 * @constant
 *  FTMonitorFrequencyDefault   - 500ms (默认)
 *  FTMonitorFrequencyFrequent  - 100ms
 *  FTMonitorFrequencyRare      - 1000ms
 */
typedef NS_OPTIONS(NSUInteger, FTMonitorFrequency) {
    FTMonitorFrequencyDefault,
    FTMonitorFrequencyFrequent,
    FTMonitorFrequencyRare,
};
```

### Log 配置 {#log-config}

```objectivec
    //开启 logger
    FTLoggerConfig *loggerConfig = [[FTLoggerConfig alloc]init];
    loggerConfig.enableCustomLog = YES;
    loggerConfig.enableLinkRumData = YES;
    loggerConfig.enableConsoleLog = YES;
    [[FTSDKAgent sharedInstance] startLoggerWithConfigOptions:loggerConfig];
```

| **字段**          | **类型**          | **说明**                               | **必须**               |
| ----------------- | ----------------- | -------------------------------------- | ---------------------- |
| sampleRate        | int               | 采样采集率                             | 否（默认100）          |
| enableConsoleLog  | BOOL              | 设置是否需要采集控制台日志             | 否（默认NO）           |
| prefix            | NSString          | 设置采集控制台日志过滤字符串           | 否（默认全采集）       |
| enableCustomLog   | BOOL              | 是否上传自定义 log                     | 否（默认NO）           |
| logLevelFilter    | NSArray           | 设置要采集的自定义 log 的状态数组      | 否（默认全采集）       |
| enableLinkRumData | BOOL              | 是否将 logger 数据与 rum 关联          | 否（默认NO）           |
| discardType       | FTLogCacheDiscard | 设置日志废弃策略                       | 否（默认丢弃最新数据） |
| globalContext     | NSDictionary      | [添加自定义标签](#user-global-context) | 否                     |

#### 日志废弃策略

**上传机制** : 日志数据采集后会存储到本地数据库中，等待时机进行上传。数据库存储日志数据的量限制在 5000 条，如果网络异常等原因导致数据堆积，存储 5000 条后，会根据您设置的废弃策略丢弃数据。

```objectivec
typedef NS_ENUM(NSInteger, FTLogCacheDiscard)  {
    FTDiscard,        //默认，当日志数据数量大于最大值（5000）时，新数据不进行写入
    FTDiscardOldest   //当日志数据数量大于最大值时,废弃旧数据
};
/**
 * 设置日志废弃策略
 */
@property (nonatomic, assign) FTLogCacheDiscard  discardType;
```

#### 采集控制台日志

一般情况下， 因为 NSLog 的输出会消耗系统资源，而且输出的数据也可能会暴露出 App 里的保密数据， 所以在发布正式版时会把这些输出全部屏蔽掉。此时开启采集控制台日志，也并不能抓取到工程里打印的日志。建议使用 [自定义上报日志](#user-logger) 来上传想查看的日志。 

- 开启采集控制台日志

```objectivec
/**
 * 设置是否需要采集控制台日志，默认为 NO
 */
 @property (nonatomic, assign) BOOL enableConsoleLog;
```

- 设置采集控制台日志的过滤条件

```objectivec
/**
 * 设置过滤字符串，包含该字符串的控制台日志会被采集，默认为全采集
 */
@property (nonatomic, copy) NSString *prefix;
```

### Trace 配置 {#trace-config}

```objectivec
    //开启 trace
    FTTraceConfig *traceConfig = [[FTTraceConfig alloc]init];
    traceConfig.enableLinkRumData = YES;
	  traceConfig.enableAutoTrace = YES;
    traceConfig.networkTraceType = FTNetworkTraceTypeDDtrace;
    [[FTSDKAgentsharedInstance] startTraceWithConfigOptions:traceConfig];
```

| 字段              | 类型    | 说明                                                         | 必须              |
| ----------------- | ------- | ------------------------------------------------------------ | ----------------- |
| sampleRate        | int     | 采样采集率                                                   | 否（默认100)      |
| networkTraceType  | NS_ENUM | 设置网络请求信息采集时 使用链路追踪类型，如果接入 OpenTelemetry 选择对应链路类型时，请注意查阅支持类型及 agent 相关配置 | 否（默认DDtrace） |
| enableLinkRumData | BOOL    | 是否将 Trace 数据与 rum 关联                                 | 否（默认NO）      |
| enableAutoTrace   | BOOL    | 设置是否开启自动 http trace，目前只支持 NSURLSession         | 否（默认NO）      |

#### 链路追踪类型

```objectivec
/**
 * @enum
 * 网络链路追踪使用类型
 *
 * @constant
 *  FTNetworkTraceTypeDDtrace       - datadog trace
 *  FTNetworkTraceTypeZipkinMultiHeader   - zipkin multi header
 *  FTNetworkTraceTypeZipkinSingleHeader  - zipkin single header
 *  FTNetworkTraceTypeTraceparent         - w3c traceparent
 *  FTNetworkTraceTypeSkywalking    - skywalking 8.0+
 *  FTNetworkTraceTypeJaeger        - jaeger
 */

typedef NS_ENUM(NSInteger, FTNetworkTraceType) {
    FTNetworkTraceTypeDDtrace,
    FTNetworkTraceTypeZipkinMultiHeader,
    FTNetworkTraceTypeZipkinSingleHeader,
    FTNetworkTraceTypeTraceparent,
    FTNetworkTraceTypeSkywalking,
    FTNetworkTraceTypeJaeger,
};
```

## RUM 用户数据追踪

可以 `FTRUMConfig` 配置开启自动模式，或手动添加。Rum 相关数据，通过 `FTGlobalRumManager` 单例，进行传入，相关 API 如下：

### View

若设置 `enableTraceUserView= YES` 开启自动采集 ，SDK 将自动采集 Window 的生命周期，以 window 的 `becomeKeyWindow` 为开始，记录进入页面， 以 `resignKeyWindow` 为结束，记录离开页面。页面名称根据 contentViewController > windowController > window 的优先顺序来设置，即若 window 的 contentViewController 存在，则页面名称为 contentViewController 的类名，如 contentViewController 不存在，则查看 windowController 是否存在，存在即为 windowController 的类名，反之则为 Window 的类名。

若想记录 window 内更为详细的 NSViewController 的生命周期，可以使用下面的 API 手动采集。

```objectivec
//进入页面时调用  duration 以纳秒为单位 示例中为 1s
[[FTGlobalRumManager sharedManager] onCreateView:@"TestVC" loadTime:@1000000000];

[[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC"];

[[FTGlobalRumManager sharedManager] stopView];
```

```objectivec
/**
 * 创建页面 需要在 -startView 与 -stopView 方法前使用 
 * @param viewName     页面名称
 * @param loadTime     页面加载时间
 */
-(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
/**
 * 进入页面 viewId 内部管理
 * @param viewName        页面名称
 */
-(void)startViewWithName:(NSString *)viewName;
/**
 * 进入页面
 * @param viewName  页面名称
 * @param property   事件属性(可选)
 */
-(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
/**
 * 离开页面
 */
-(void)stopView;
/**
 * 离开页面
 * @param property  事件属性(可选)
 */
-(void)stopViewWithProperty:(nullable NSDictionary *)property;
```

### Action

```objective-c
[[FTGlobalRumManager sharedManager]  addActionName:@"UITableViewCell click" actionType:@"click"];
```

```objectivec
/**
 * 添加  Action 事件
 * @param actionName 事件名称
 * @param actionType 事件类型
 */
- (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType;
/**
 * 添加  Action 事件
 * @param actionName 事件名称
 * @param actionType 事件类型
 * @param property   事件属性(可选)
 */
- (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
```

### Error

```objectivec
[[FTGlobalRumManager sharedManager] addErrorWithType:@"type" situation:RUN message:@"message" stack:@"stack"];
```

```objectivec
/**
 * 添加 Error 事件
 * @param type       error 类型
 * @param message    错误信息
 * @param stack      堆栈信息
 */
- (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
/**
 * 添加 Error 事件
 * @param type       error 类型
 * @param message    错误信息
 * @param stack      堆栈信息
 * @param property   事件属性(可选)
 */
- (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
```

### LongTask

```objectivec
[[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"堆栈信息 string" duration:@1000000000];
```

```objectivec
/**
 * 添加 卡顿 事件
 * @param stack      卡顿堆栈
 * @param duration   卡顿时长
 */
- (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
/**
 * 添加 卡顿 事件
 * @param stack      卡顿堆栈
 * @param duration   卡顿时长
 * @param property   事件属性(可选)
 */
- (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
```

### Resource

```objectivec
#import "FTMacOSSDK.h"
#import "FTResourceContentModel.h"
#import "FTResourceMetricsModel.h"
//第一步：请求开始前
 [[FTGlobalRumManager sharedManager] startResourceWithKey:key];

 //第二步：请求完成
 [[FTGlobalRumManager sharedManager] stopResourceWithKey:key];

 //第三步：拼接 Resource 数据
 //FTResourceContentModel 数据
  FTResourceContentModel *content = [[FTResourceContentModel alloc]init];
  content.httpMethod = request.HTTPMethod;
  content.requestHeader = request.allHTTPHeaderFields;
  content.responseHeader = httpResponse.allHeaderFields;
  content.httpStatusCode = httpResponse.statusCode;
  content.responseBody = responseBody;
  //ios native
  content.error = error;
  
  //如果能获取到各阶段的时间数据 
  //FTResourceMetricsModel
  //ios native 获取到 NSURLSessionTaskMetrics 数据 直接使用 FTResourceMetricsModel 的初始化方法
  FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
  
  //其他平台 所有时间数据以纳秒为单位
  FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
  [metricsModel setDnsStart:dstart end:dend];
  [metricsModel setTcpStart:tstart end:tend];
  [metricsModel setSslStart:sstart end:send];
  [metricsModel setTtfbStart:ttstart end:ttend];
  [metricsModel setTransStart:trstart end:trend];
  [metricsModel setFirstByteStart:fstart end:fend];
  [metricsModel setDurationStart:dstart end:dend];

 //第四步：add resource 如果没有时间数据 metrics 传 nil
 [[FTGlobalRumManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
```

```objectivec
/**
 * 请求开始
 * @param key       请求标识
 */
- (void)startResourceWithKey:(NSString *)key;
/**
 * 请求开始
 * @param key       请求标识
 * @param property  事件属性(可选)
 */
- (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
/**
 * 请求结束
 * @param key       请求标识
 */
- (void)stopResourceWithKey:(NSString *)key;
/**
 * 请求结束
 * @param key       请求标识
 * @param property  事件属性(可选)
 */
- (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
/**
 * 请求数据添加
 * @param key       请求标识
 * @param metrics   请求相关性能属性
 * @param content   请求相关数据
 */
- (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
```

#### Resource url 过滤

当开启自动采集后，内部会进行处理不采集 SDK 的数据上报地址。您也可以通过 Open API 设置过滤条件，采集您需要的网络地址。

```objective-c
[[FTSDKAgent sharedInstance] isIntakeUrl:^BOOL(NSURL * _Nonnull url) {
        // 您的采集判断逻辑
        return YES;//return NO; (YES 采集，NO 不采集)
 }];
```

```objective-c
//  FTSDKAgent.h
//  
/**
 * @abstract
 * 判断 URL 是否采集
 */
- (void)isIntakeUrl:(BOOL(^)(NSURL *url))handler;
```

## Logger 日志打印 {#user-logger}

```objectivec
[[FTSDKAgent sharedInstance] logging:@"TestLoggingBackground" status:FTStatusInfo];
```

```objectivec
typedef NS_ENUM(NSInteger, FTStatus) {
    FTStatusInfo         = 0,
    FTStatusWarning,
    FTStatusError,
    FTStatusCritical,
    FTStatusOk,
};
/// 日志上报
/// @param content 日志内容，可为json字符串
/// @param status  事件等级和状态
-(void)logging:(NSString *)content status:(FTStatus)status;

/// 日志上报
/// @param content 日志内容，可为json字符串
/// @param status  事件等级和状态
/// @param property 事件属性
-(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;
```

## Trace 网络链接追踪

可以 `FTTraceConfig`  配置开启自动模式，或手动添加。Trace 相关数据，通过 `FTTraceManager` 单例，进行传入，相关 API 如下：

```objectivec
 NSString *key = [[NSUUID UUID]UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//需要的手动操作： 请求前获取 traceHeader 添加到请求头
    NSDictionary *traceHeader = [[FTTraceManager sharedInstance] getTraceHeaderWithKey:key url:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (traceHeader && traceHeader.allKeys.count>0) {
        [traceHeader enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [request setValue:value forHTTPHeaderField:field];
        }];
    }
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       //您的代码
    }];
    
    [task resume];
```

```objectivec
// FTTraceManager.h
/**
 * 获取 trace 请求头
 * @param key 请求标识
 */
- (NSDictionary *)getTraceHeaderWithKey:(NSString *)key url:(NSURL *)url;
```

## 用户的绑定与注销

```objectivec
/**
 * 绑定用户信息
 * @param Id        用户Id
 * @param userName  用户名称
 * @param userEmail 用户邮箱
 * @param extra     用户的额外信息
*/
[[FTSDKAgent sharedInstance] bindUserWithUserID:USERID];
//or
[[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
//or
[[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];

//解绑用户
[[FTSDKAgent sharedInstance] unbindUser];
```

## 添加自定义标签 {#user-global-context}

### 静态使用

可采用创建多 Configurations ，使用预编译指令进行设置值

1. 创建多 Configurations ：

![](../img/image_9.png)

2. 设置预设属性来区分不同 Configurations:

![](../img/image_10.png)

3. 使用预编译指令：

```objectivec
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS 进行配置预设定义
#if PRE
#define Track_id       @"0000000001"
#define STATIC_TAG     @"preprod"
#elif  DEVELOP
#define Track_id       @"0000000002"
#define STATIC_TAG     @"common"
#else
#define Track_id       @"0000000003"
#define STATIC_TAG     @"prod"
#endif
   
FTRumConfig *rumConfig = [[FTRumConfig alloc]init]; 
rumConfig.globalContext = @{@"track_id":Track_id,@"static_tag":STATIC_TAG};
... //其他设置操作
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

### 动态使用

因 RUM 启动后设置的 globalContext 不会生效，用户可自行本地保存，在下次应用启动时进行设置生效。

1. 通过存文件本地保存，例如`NSUserDefaults`，配置使用 `SDK`，在配置处添加获取标签数据的代码。

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... //其他设置操作
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. 在任意处添加改变文件数据的方法。

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. 最后重启应用生效。

### 注意

1. 特殊 key : track_id (在 RUM 中配置，用于追踪功能)  

2. 当用户通过 globalContext 添加自定义标签与 SDK 自有标签相同时，SDK 的标签会覆盖用户设置的，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。

3. 在调用 -startRumWithConfigOptions 方法启动 RUM 前设置 globalContext 才能生效。

4. `FTSDKConfig` 中配置的自定义标签将添加在所有类型的数据中。

详细细节请见 [SDK Demo](https://github.com/GuanceCloud/datakit-macos/tree/develop/Example)。

## 崩溃日志符号化

### 上传符号表

#### 方法一：脚本集成到 Xcode 工程的 Target

1. XCode 添加自定义 Run Script Phase：` Build Phases -> + -> New Run Script Phase`
2. 将脚本复制到 Xcode 项目的构建阶段运行脚本中，脚本中需要设置参数如：＜app_id＞、＜dea_address＞、＜env＞、＜version＞(脚本默认配置的版本格式为 `CFBundleShortVersionString`)。
3. [脚本](https://github.com/GuanceCloud/datakit-macos/tree/develop/Example/FTdSYMUploader.sh)

```sh
#脚本中需要配置的参数
#＜app_id＞
FT_APP_ID="YOUR_APP_ID"
#＜dea_address＞
FT_DEA_ADDRESS="YOUR_DEA_ADDRESS"
# ＜env＞ 环境字段。属性值：prod/gray/pre/common/local。需要与 SDK 设置一致
FT_ENV="common"
#
#＜version＞ 脚本默认配置的版本格式为CFBundleShortVersionString,如果你修改默认的版本格式, 请设置此变量。注意：需要确保在此填写的与SDK设置的一致。
# FT_VERSION=""
```

##### 多环境便捷的配置参数

示例：使用预设宏和 .xcconfig 配置文件

1. 添加预设宏：`Target —> Build Settings -> + -> Add User-Defined Setting` 

![](../img/multi-environment-configuration1.png)

![](../img/multi-environment-configuration2.png)


2. 使用多 Xcconfig 来实现多环境，新建 Xcconfig

![](../img/multi-environment-configuration3.png)


.xcconfig 文件中配置预设宏：

```sh
//如果有使用 cocoapods ，需要将 pods 的.xcconfig 路径添加到您的 .xcconfig 文件中，如果您不清楚路径是什么，可以使用终端进入项目文件夹，执行 pod install，终端会有提示路径，将该路径复制后如下使用即可。
#include "Pods/Target Support Files/Pods-testDemo/Pods-testDemo.debug.xcconfig"

SDK_APP_ID = app_id_common
SDK_ENV = common
SDK_DEA_ADDRESS = http:\$()\xxxxxxxx:9531 
```

3. 配置自定义编译环境

![](../img/multi-environment-configuration4.png)



![](../img/multi-environment-configuration5.png)


4. 使用

**脚本中**

```sh
#脚本中需要配置的参数
#＜app_id＞
FT_APP_ID=SDK_APP_ID
#＜dea_address＞
FT_DEA_ADDRESS=SDK_DEA_ADDRESS
# ＜env＞ 环境字段。属性值：prod/gray/pre/common/local。需要与 SDK 设置一致
FT_ENV=SDK_ENV
```

**项目某一文件中** 

方法一：对指定文件进行配置：-D'SDK_APP_ID=@"$(SDK_APP_ID)"'

![](../img/multi-environment-configuration6.png)



 在指定文件中可以使用

![](../img/multi-environment-configuration7.png)



方法二：映射到  `Info.plist` 文件中

![](../img/multi-environment-configuration8.png)



在文件中可以使用

![](../img/multi-environment-configuration9.png)


详细细节请见 [SDK Demo](https://github.com/GuanceCloud/datakit-macos/tree/develop/Example)。

#### 方法二：终端运行脚本

找到 .dSYM 文件放在一个文件夹内，命令行下输入应用基本信息, .dSYM 文件的父目录路径, 输出文件目录即可

`sh FTdSYMUpload.sh <dea_address> <app_id> <version> <env> <dSYMBOL_src_dir> <dSYMBOL_dest_dir>`

#### 方法三：手动上传

[Sourcemap 上传](../../datakit/rum.md#sourcemap)

## 常见问题 {#FAQ}

### [关于崩溃日志分析](../ios/app-access.md#crash-log-analysis)

### 出现 Include of non-modular header inside framework module 报错

因为 SDK 的 .h ⽂文件中引⼊入了了依赖库的 .h ⽂文件，所以需要设置

`Target` -> `Build Settings` -> `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` 设置为 YES.