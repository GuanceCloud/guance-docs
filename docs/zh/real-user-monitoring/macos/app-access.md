# macOS 应用接入

---

<<< custom_key.brand_name >>>应用监测能够通过收集各个 macOS 应用的指标数据，以可视化的方式分析各个 macOS 应用端的性能。

## 前置条件

???+ warning "注意"

    若已开通 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动配置，可直接接入应用。

- 安装 [DataKit](../../datakit/datakit-install.md);
- 配置 [RUM 采集器](../../integrations/rum.md)

## 应用接入 {#macOS-integration}

1. 进入**用户访问监测 > 新建应用 > macOS**；
2. 输入应用名称；
3. 输入应用 ID；
4. 选择应用接入方式：

    - 公网 DataWay：直接接收 RUM 数据，无需安装 DataKit 采集器。  
    - 本地环境部署：满足前置条件后接收 RUM 数据。

## 安装

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/version.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=macOS&color=brightgreen&query=$.macos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) 

**源码地址**：[https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**：[https://github.com/GuanceCloud/datakit-macos/Example](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)

=== "CocoaPods"

    1.配置 `Podfile` 文件。
    
    ```objectivec
       target 'yourProjectName' do
    
       # Pods for your project
       pod 'FTMacOSSDK', '~>[latest_version]'
    
       end
    ```
    
    2.在 `Podfile` 目录下执行 `pod install` 安装 SDK。

=== "Swift Package Manager"

    1.选中 `PROJECT` -> `Package Dependency` ，点击 `Packages` 栏目下的 **+**。
    
    2.在弹出的页面的搜索框中输入 `https://github.com/GuanceCloud/datakit-macos`，这是代码的存储位置。
    
    3.Xcode 获取软件包成功后，会展示 SDK 的配置页。
    
    `Dependency Rule` ：建议选择 `Up to Next Major Version` 。
    
    `Add To Project` ：选择支持的工程。
    
    填好配置后点击 `Add Package` 按钮，等待加载完成。
    
    4.在弹窗 `Choose Package Products for datakit-macos` 中选择需要添加 SDK 的 Target，点击 `Add Package` 按钮，此时 SDK 已经添加成功。
    
    如果您的项目由 SPM 管理，将 FTMacOSSDK 添加为依赖项，添加 `dependencies ` 到 `Package.swift`。
    
    ```swift
      dependencies: [
        .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "[latest_version]"))
    ]
    ```

### 添加头文件

=== "Objective-C"

    ```
    #import "FTMacOSSDK.h"
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    ```

## SDK 初始化

### 基础配置 {#base-setting}

由于第一个显示的视图 `NSViewController` 的 `viewDidLoad` 方法、 `NSWindowController` 的 `windowDidLoad` 方法调用要早于 AppDelegate `applicationDidFinishLaunching`，为避免第一个视图的生命周期采集异常，建议在 ` main.m`  文件中进行 SDK 初始化。

=== "Objective-C"

    ```objectivec
    // main.m 文件
    #import "FTMacOSSDK.h"
    
    int main(int argc, const char * argv[]) {
        @autoreleasepool {
            // 本地环境部署、Datakit 部署
            FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatakitUrl:datakitUrl];
            // 使用公网 DataWay 部署
            //FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatawayUrl:datawayUrl clientToken:clientToken];
            config.enableSDKDebugLog = YES;
            [FTSDKAgent startWithConfigOptions:config];
        }
        return NSApplicationMain(argc, argv);
    }
    ```

=== "Swift"

    创建 mian.swift 文件，删除 AppDelegate.swift 中 @main 或 @NSApplicationMain
    ```swift
    import Cocoa
    import FTMacOSSDK
    // 创建 AppDelegate，并设置为代理
    let delegate = AppDelegate()
    NSApplication.shared.delegate = delegate
    // 初始化 SDK 
    let config = FTSDKConfig.init(datakitUrl: datakitUrl)
    // 使用公网 DataWay 部署
    //let config = FTSDKConfig(datawayUrl: datawayUrl, clientToken: clientToken)
    config.enableSDKDebugLog = true
    FTSDKAgent.start(withConfigOptions: config)
    
    _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    
    ```

| **属性**          | **类型**     | **必须** | **含义**                                                     |
| ----------------- | ------------ | -------- | ------------------------------------------------------------ |
| datakitUrl        | NSString     | 是       | Datakit 访问地址，例子：[http://10.0.0.1:9529](http://10.0.0.1:9529/)，端口默认 9529，安装 SDK 设备需能访问这地址.**注意：datakit 和 dataway 配置两者二选一** |
| datawayUrl        | NSString     | 是       | 公网 Dataway 访问地址，例子：[http://10.0.0.1:9528](http://10.0.0.1:9528/)，端口默认 9528，安装 SDK 设备需能访问这地址.**注意：datakit 和 dataway 配置两者二选一** |
| clientToken       | NSString     | 是       | 认证 token，需要与 datawayUrl 同时使用                       |
| enableSDKDebugLog | BOOL         | 否       | 设置是否允许打印日志。默认 `NO`                              |
| env               | NSString     | 否       | 设置采集环境。默认 `prod`，支持自定义，也可根据提供的 `FTEnv` 枚举通过 `-setEnvWithType:` 方法设置 |
| service           | NSString     | 否       | 设置所属业务或服务的名称。影响 Log 和 RUM 中 service 字段数据。默认：`df_rum_ios` |
| globalContext     | NSDictionary | 否       | 添加自定义标签。添加规则请查阅[此处](#user-global-context)   |

### RUM 配置 {#rum-config}

=== "Objective-C"

    ```objectivec
       FTRumConfig *rumConfig = [[FTRumConfig alloc]initWithAppid:appid];
       rumConfig.enableTrackAppCrash = YES;
       rumConfig.enableTrackAppANR = YES;
       rumConfig.enableTrackAppFreeze = YES;
       rumConfig.enableTraceUserAction = YES;
       rumConfig.enableTraceUserVIew = YES;
       rumConfig.enableTraceUserResource = YES;
       rumConfig.errorMonitorType = FTErrorMonitorAll;
       rumConfig.deviceMetricsMonitorType = FTDeviceMetricsMonitorAll;
       [[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
    ```
=== "Swift"

    ```swift
       let rumConfig = FTRumConfig(appid: appid)
       rumConfig.enableTraceUserAction = true
       rumConfig.enableTrackAppANR = true
       rumConfig.enableTraceUserView = true
       rumConfig.enableTraceUserResource = true
       rumConfig.enableTrackAppCrash = true
       rumConfig.enableTrackAppFreeze = true
       rumConfig.errorMonitorType = .all
       rumConfig.deviceMetricsMonitorType = .all
       rumConfig.monitorFrequency = .rare
       FTSDKAgent.sharedInstance().startRum(withConfigOptions: rumConfig)
    ```

| **属性**                 | **类型**                   | **必须** | **含义**                     |
| ------------------------ | -------------------------- | -------- | ---------------------------- |
| appid                    | NSString                   | 是       | 用户访问监测应用 ID 唯一标识。对应设置 RUM `appid`，才会开启`RUM`的采集功能，[获取 appid 方法](#macOS-integration) |
| sampleRate               | int                        | 否       | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据 |
| enableTrackAppCrash      | BOOL                       | 否       | 设置是否需要采集崩溃日志。默认 `NO` |
| enableTrackAppANR        | BOOL                       | 否       | 采集ANR卡顿无响应事件。默认 `NO` |
| enableTrackAppFreeze     | BOOL                       | 否       | 采集UI卡顿事件。默认 `NO`       |
| enableTraceUserView      | BOOL                       | 否       | 设置是否追踪用户 View 操作。默认 `NO` |
| enableTraceUserAction    | BOOL                       | 否       | 设置是否追踪用户 Action 操作。默认 `NO` |
| enableTraceUserResource  | BOOL                       | 否       | 设置是否追踪用户网络请求。默认`NO`，仅作用于 native http |
| resourceUrlHandler | FTResourceUrlHandler | 否 | 自定义采集 resource 规则。默认不过滤。 返回：NO 表示要采集，YES 表示不需要采集。 |
| errorMonitorType         | FTErrorMonitorType         | 否       | 错误事件监控补充类型。在采集的崩溃数据中添加监控的信息。`FTErrorMonitorBattery`为电池余量，`FTErrorMonitorMemory`为内存用量，`FTErrorMonitorCpu`为 CPU 占有率 。 |
| monitorFrequency         | FTMonitorFrequency         | 否       | 视图的性能监控采样周期       |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | 否       | 视图的性能监控类型。在采集的  **View** 数据中添加对应监控项信息。`FTDeviceMetricsMonitorMemory`监控当前应用使用内存情况，`FTDeviceMetricsMonitorCpu`监控 CPU 跳动次数，`FTDeviceMetricsMonitorFps`监控屏幕帧率。 |
| globalContext            | NSDictionary               | 否       | 添加自定义标签，用于用户监测数据源区分，如果需要使用追踪功能，则参数 `key` 为 `track_id` ,`value` 为任意数值，添加规则注意事项请查阅[此处](#user-global-context) |

### Log 配置 {#log-config}

=== "Objective-C"

    ```objective-c
        //开启 logger
        FTLoggerConfig *loggerConfig = [[FTLoggerConfig alloc]init];
        loggerConfig.enableCustomLog = YES;
        loggerConfig.printCustomLogToConsole = YES;
        loggerConfig.enableLinkRumData = YES;
        loggerConfig.logLevelFilter = @[@(FTStatusError),@(FTStatusCritical)];
        loggerConfig.discardType = FTDiscardOldest;
        [[FTSDKAgent sharedInstance] startLoggerWithConfigOptions:loggerConfig];
    ```

=== "Swift"

    ```
        let loggerConfig = FTLoggerConfig()
        loggerConfig.enableCustomLog = true
        loggerConfig.enableLinkRumData = true
        loggerConfig.printCustomLogToConsole = true
        loggerConfig.logLevelFilter = [NSNumber(value: FTLogStatus.statusError.rawValue),NSNumber(value: FTLogStatus.statusCritical.rawValue)] // loggerConfig.logLevelFilter = [2,3]
        loggerConfig.discardType = .discardOldest
        FTSDKAgent.sharedInstance().startLogger(withConfigOptions: loggerConfig)
    ```

| **属性**                | **类型**          | **必须** | **含义**                          |
| ----------------------- | ----------------- | -------- | --------------------------------- |
| sampleRate              | int               | 否       | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。 |
| enableCustomLog         | BOOL              | 否       | 是否上传自定义 log。默认`NO` |
| logLevelFilter          | NSArray           | 否       | 设置要采集的自定义 log 的状态数组。默认全采集 |
| enableLinkRumData       | BOOL              | 否       | 是否与 RUM 数据关联。默认`NO`                                |
| discardType             | FTLogCacheDiscard | 否       | 设置日志达到限制上限以后的日志丢弃规则。默认 `FTDiscard` <br/>`FTDiscard`当日志数据数量大于最大值（5000）时，丢弃追加数据。`FTDiscardOldest`当日志数据大于最大值时,丢弃老数据。 |
| printCustomLogToConsole | BOOL              | 否       | 设置是否将自定义日志输出到控制台。默认`NO`，自定义日志[输出格式](#printCustomLogToConsole) |
| globalContext           | NSDictionary      | 否       | 添加 log 自定义标签，添加规则请查阅[此处](#user-global-context) |

### Trace 配置 {#trace-config}

=== "Objective-C"

    ```objective-c
       FTTraceConfig *traceConfig = [[FTTraceConfig alloc]init];
       traceConfig.enableLinkRumData = YES;
    	 traceConfig.enableAutoTrace = YES;
       traceConfig.networkTraceType = FTNetworkTraceTypeDDtrace;
       [[FTSDKAgent sharedInstance] startTraceWithConfigOptions:traceConfig];
    ```

=== "Swift"

    ```swift
       let traceConfig = FTTraceConfig.init()
       traceConfig.enableLinkRumData = true
       traceConfig.enableAutoTrace = true
       FTSDKAgent.sharedInstance().startTrace(withConfigOptions: traceConfig)
    ```

| 属性              | 类型    | 必须 | 含义                        |
| ----------------- | ------- | ---- | --------------------------- |
| sampleRate        | int     | 否   | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。 |
| networkTraceType  | NS_ENUM | 否   | 设置链路追踪的类型。默认为 `DDTrace`，目前支持 `Zipkin` , `Jaeger`, `DDTrace`，`Skywalking` (8.0+)，`TraceParent` (W3C)，如果接入 OpenTelemetry 选择对应链路类型时，请注意查阅支持类型及 agent 相关配置 |
| enableLinkRumData | BOOL    | 否   | 是否与 RUM 数据关联。默认`NO` |
| enableAutoTrace   | BOOL    | 否   | 设置是否开启自动 http trace。默认`NO`，目前只支持 NSURLSession |

## RUM 用户数据追踪

可以 `FTRUMConfig` 配置开启自动模式，或手动添加。Rum 相关数据，通过 `FTGlobalRumManager` 单例，进行传入，相关 API 如下：

### View

若设置 `enableTraceUserView = YES` 开启自动采集 ，SDK 将自动采集 Window 的生命周期。以 window 的生命周期  `-becomeKeyWindow` 定义 **View** 的开始， `-resignKeyWindow` 定义 **View** 的结束。

页面名称以   `NSStringFromClass(window.contentViewController.class)` > `NSStringFromClass(window.windowController.class)` > `NSStringFromClass(window)`  的优先顺序来设置。

如果 window 内的视图十分复杂，您可以使用以下 API 自定义采集。

#### 使用方法

=== "Objective-C"

    ```objective-c
    /// 创建页面
    ///
    /// 在 `-startViewWithName` 方法前调用，该方法用于记录页面的加载时间，如果无法获得加载时间该方法可以不调用。
    /// - Parameters:
    ///  - viewName: 页面名称
    ///  - loadTime: 页面加载时间（纳秒级）
    -(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
    
    /// 进入页面
    /// - Parameters:
    ///  - viewName: 页面名称
    ///  - property: 事件自定义属性(可选)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// 离开页面
    /// - Parameter property: 事件自定义属性(可选)
    -(void)stopViewWithProperty:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// 创建页面
    ///
    /// 在 `-startViewWithName` 方法前调用，该方法用于记录页面的加载时间，如果无法获得加载时间该方法可以不调用。
    /// - Parameters:
    ///  - viewName: 页面名称
    ///  - loadTime: 页面加载时间（ns）
    open func onCreateView(_ viewName: String, loadTime: NSNumber)
    
    /// 进入页面
    /// - Parameters:
    ///  - viewName: 页面名称
    ///  - property: 事件自定义属性(可选)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// 离开页面
    /// - Parameter property: 事件自定义属性(可选)
    open func stopView(withProperty property: [AnyHashable : Any]?)
    ```

#### 代码示例

=== "Objective-C"

    ```objectivec
    - (void)viewDidAppear{
      [super viewDidAppear];
      // 场景 1：
      [[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC"];  
      
      // 场景 2：动态参数
      [[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC" property:@{@"custom_key":@"custom_value"}];  
    }
    -(void)viewDidDisappear{
      [super viewDidDisappear];
      // 场景 1：
      [[FTGlobalRumManager sharedManager] stopView];  
      
      // 场景 2：动态参数
      [[FTGlobalRumManager sharedManager] stopViewWithProperty:@{@"custom_key":@"custom_value"}];
    }
    ```

=== "Swift"

    ```swift
    override func viewDidAppear() {
        super.viewDidAppear()
        // 场景 1：
        FTExternalDataManager.shared().startView(withName: "TestVC")
        // 场景 2：动态参数
        FTExternalDataManager.shared().startView(withName: "TestVC",property: ["custom_key":"custom_value"])
    }
    override func viewDidDisappear() {
        super.viewDidDisappear()
        // 场景 1：
        FTGlobalRumManager.shared().stopView()
        // 场景 2：动态参数
        FTGlobalRumManager.shared().stopView(withProperty: ["custom_key":"custom_value"])
    }
    ```

### Action

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// 添加 Action 事件
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - actionType: 事件类型
    ///   - property: 事件自定义属性(可选)
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// 添加 Action 事件
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - actionType: 事件类型
    ///   - property: 事件自定义属性(可选)
    func addActionName(String, actionType: String, property: [AnyHashable : Any]?)
    ```
#### 代码示例

=== "Objective-C"

    ```objective-c
    // 场景1
    [[FTGlobalRumManager sharedManager] addActionName:@"UITableViewCell click" actionType:@"click"];
    // 场景2: 动态参数
    [[FTGlobalRumManager sharedManager]  addActionName:@"UITableViewCell click" actionType:@"click" property:@{@"custom_key":@"custom_value"}];
    ```
=== "Swift"

    ```swift
    // 场景1
    FTGlobalRumManager.shared().addActionName("custom_action", actionType: "click")
    // 场景2: 动态参数
    FTGlobalRumManager.shared().addActionName("custom_action", actionType: "click",property: ["custom_key":"custom_value"])
    ```

### Error

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// 添加 Error 事件
    /// - Parameters:
    ///   - type: error 类型
    ///   - message: 错误信息
    ///   - stack: 堆栈信息
    ///   - property: 事件自定义属性(可选)
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    
    /// 添加 Error 事件
    /// - Parameters:
    ///   - type: error 类型
    ///   - state: 程序运行状态
    ///   - message: 错误信息
    ///   - stack: 堆栈信息
    ///   - property: 事件自定义属性(可选)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// 添加 Error 事件
    /// - Parameters:
    ///   - type: error 类型
    ///   - message: 错误信息
    ///   - stack: 堆栈信息
    ///   - property: 事件自定义属性(可选)
    open func addError(withType: String, message: String, stack: String, property: [AnyHashable : Any]?)
    
    /// 添加 Error 事件
    /// - Parameters:
    ///   - type: error 类型
    ///   - state: 程序运行状态
    ///   - message: 错误信息
    ///   - stack: 堆栈信息
    ///   - property: 事件自定义属性(可选)
    open func addError(withType type: String, state: FTAppState, message: String, stack: String, property: [AnyHashable : Any]?)
    ```
#### 代码示例

=== "Objective-C"

    ```objectivec
    // 场景1
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"type" message:@"message" stack:@"stack"];
    // 场景2: 动态参数
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"ios_crash" message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    // 场景3: 动态参数
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"ios_crash" state:FTAppStateUnknown message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // 场景1
    FTGlobalRumManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack")
    // 场景2: 动态参数
    FTGlobalRumManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack",property: ["custom_key":"custom_value"])
    // 场景3: 动态参数       
    FTGlobalRumManager.shared().addError(withType: "custom_type", state: .unknown, message: "custom_message", stack: "custom_stack", property: ["custom_key":"custom_value"])
    ```

### LongTask

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// 添加 卡顿 事件
    /// - Parameters:
    ///   - stack: 卡顿堆栈
    ///   - duration: 卡顿时长（纳秒）
    ///   - property: 事件自定义属性(可选)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// 添加 卡顿 事件
    /// - Parameters:
    ///   - stack: 卡顿堆栈
    ///   - duration: 卡顿时长（纳秒）
    ///   - property: 事件自定义属性(可选)
    func addLongTask(withStack: String, duration: NSNumber, property: [AnyHashable : Any]?)
    ```

#### 代码示例

=== "Objective-C"

    ```objectivec
    // 场景1
    [[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
    // 场景2: 动态参数
    [[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000 property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // 场景1
    FTGlobalRumManager.shared().addLongTask(withStack: "stack string", duration: 1000000000)
    // 场景2: 动态参数
    FTGlobalRumManager.shared().addLongTask(withStack: "stack string", duration: 1000000000 ,property: [["custom_key":"custom_value"]])
    ```

### Resource

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// HTTP 请求开始
    /// - Parameters:
    ///   - key: 请求标识
    ///   - property: 事件自定义属性(可选)
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// HTTP 添加请求数据
    ///
    /// - Parameters:
    ///   - key: 请求标识
    ///   - metrics: 请求相关性能属性
    ///   - content: 请求相关数据
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    
    /// HTTP 请求结束
    /// - Parameters:
    ///   - key: 请求标识
    ///   - property: 事件自定义属性(可选)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// HTTP 请求开始
    /// - Parameters:
    ///   - key: 请求标识
    ///   - property: 事件自定义属性(可选)
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// HTTP 请求结束
    /// - Parameters:
    ///   - key: 请求标识
    ///   - property: 事件自定义属性(可选)
    open func stopResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// HTTP 添加请求数据
    ///
    /// - Parameters:
    ///   - key: 请求标识
    ///   - metrics: 请求相关性能属性
    ///   - content: 请求相关数据
    open func addResource(withKey key: String, metrics: FTResourceMetricsModel?, content: FTResourceContentModel)
    ```

#### 代码示例

=== "Objective-C"

    ```objectivec
    #import "FTMacOSSDK.h"
    
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
    
    //第四步：add resource 如果没有时间数据 metrics 传 nil
    [[FTGlobalRumManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    
    //第一步：请求开始前
    FTGlobalRumManager.shared().startResource(withKey: key)
    
    //第二步：请求完成
    FTGlobalRumManager.shared().stopResource(withKey: resource.key)
    
    //第三步：① 拼接 Resource 数据
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)
    
    //② 如果能获取到各阶段的时间数据 
    //FTResourceMetricsModel
    //ios native 获取到 NSURLSessionTaskMetrics 数据 直接使用 FTResourceMetricsModel 的初始化方法
    var metricsModel:FTResourceMetricsModel?
    if let metrics = resource.metrics {
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)
    }
    //其他平台 所有时间数据以纳秒为单位
    metricsModel = FTResourceMetricsModel()
    ...
    
    //第四步：add resource 如果没有时间数据 metrics 传 nil
    FTGlobalRumManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logger 日志打印 {#user-logger}
> 目前日志内容限制为 30 KB，字符超出部分会进行截断处理
### 使用方法

=== "Objective-C"

    ```objective-c
    //
    //  FTLogger.h
    //  FTMacOSSDK
    
    /// 添加 info 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// 添加 warning 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// 添加 error 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;
    
    /// 添加 critical 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// 添加 ok 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    -(void)ok:(NSString *)content property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    open class FTLogger : NSObject, FTLoggerProtocol {}
    public protocol FTLoggerProtocol : NSObjectProtocol {
    /// 添加 info 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    optional func info(_ content: String, property: [AnyHashable : Any]?)
    
    /// 添加 warning 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    optional func warning(_ content: String, property: [AnyHashable : Any]?)
    
    /// 添加 error 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    optional func error(_ content: String, property: [AnyHashable : Any]?)
    
    /// 添加 critical 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    optional func critical(_ content: String, property: [AnyHashable : Any]?)
    
    /// 添加 ok 类型自定义日志
    /// - Parameters:
    ///   - content: 日志内容
    ///   - property: 自定义属性(可选)
    optional func ok(_ content: String, property: [AnyHashable : Any]?)
    }
    ```
#### 日志等级

=== "Objective-C"

    ```objective-c
    ///事件等级和状态，默认：FTStatusInfo
    typedef NS_ENUM(NSInteger, FTLogStatus) {
        /// 提示
        FTStatusInfo         = 0,
        /// 警告
        FTStatusWarning,
        /// 错误
        FTStatusError,
        /// 严重
        FTStatusCritical,
        /// 恢复
        FTStatusOk,
    };
    ```
=== "Swift"

    ```swift
    ///事件等级和状态，默认：FTStatusInfo
    public enum FTLogStatus : Int, @unchecked Sendable {
        /// 提示
        case statusInfo = 0
        /// 警告
        case statusWarning = 1
        /// 错误
        case statusError = 2
        /// 严重
        case statusCritical = 3
        /// 恢复
        case statusOk = 4
    }
    ```

### 代码示例

=== "Objective-C"

    ```objectivec
    // 方法一：通过 FTSDKAgent
    // 注意：需要保证在使用的时候 SDK 已经初始化成功，否则在测试环境会断言失败从而崩溃。
    [[FTSDKAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // 方法二：通过 FTLogger （推荐）
    // SDK 如果没有初始化成功，调用 FTLogger 中方法添加自定义日志会失败，但不会有断言失败崩溃问题。
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // 方法一：通过 FTSDKAgent
    // 注意：需要保证在使用的时候 SDK 已经初始化成功，否则在测试环境会断言失败从而崩溃。
    FTSDKAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // 方法二：通过 FTLogger （推荐）
    // SDK 如果没有初始化成功，调用 FTLogger 中方法添加自定义日志会失败，但不会有断言失败崩溃问题。
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### 自定义日志输出到控制台 {#printCustomLogToConsole}


设置 `printCustomLogToConsole = YES` ，开启将自定义日志输出到控制台，将会在 xcode 调试控制台看到以下格式的日志：

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [MACOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`：os_log 日志输出的标准前缀；

`[MACOS APP]`：用来区分 SDK 输出自定义日志的前缀；

`[INFO]`：自定义日志的等级；

`content`：自定义日志内容；

`{K=V,...,Kn=Vn}`：自定义属性。

## Trace 网络链接追踪

可以 `FTTraceConfig`  配置开启自动模式，或手动添加。Trace 相关数据，通过 `FTTraceManager` 单例，进行传入，相关 API 如下：

#### 使用方法

=== "Objective-C"

    ```objective-c
    // FTTraceManager.h
    
    /// 获取 trace 的请求头参数
    /// - Parameters:
    ///   - key: 能够确定某一请求的唯一标识
    ///   - url: 请求 URL
    /// - Returns: trace 的请求头参数字典
    - (NSDictionary *)getTraceHeaderWithKey:(NSString *)key url:(NSURL *)url;
    ```

=== "Swift"

    ```swift
    /// 获取 trace 的请求头参数
    /// - Parameters:
    ///   - key: 能够确定某一请求的唯一标识
    ///   - url: 请求 URL
    /// - Returns: trace 的请求头参数字典
    open func getTraceHeader(withKey key: String, url: URL) -> [AnyHashable : Any]
    ```

#### 代码示例

=== "Objective-C"

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

=== "Swift"

    ```swift
    let url:URL = NSURL.init(string: "https://www.baidu.com")! as URL
    if let traceHeader = FTTraceManager.sharedInstance().getTraceHeader(withKey: NSUUID().uuidString, url: url) {
         let request = NSMutableURLRequest(url: url)
         //需要的手动操作： 请求前获取 traceHeader 添加到请求头
         for (a,b) in traceHeader {
             request.setValue(b as? String, forHTTPHeaderField: a as! String)
         }
         let task = URLSession.shared.dataTask(with: request as URLRequest) {  data,  response,  error in
            //您的代码
         }
         task.resume()
    }
    ```

## 用户的绑定与注销
### 使用方法

=== "Objective-C"

    ```objectivec
    /// 绑定用户信息
    ///
    /// - Parameters:
    ///   - Id:  用户Id
    ///   - userName: 用户名称 (可选)
    ///   - userEmail: 用户邮箱 (可选)
    ///   - extra: 用户的额外信息 (可选)
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail extra:(nullable NSDictionary *)extra;
    
    /// 注销当前用户
    - (void)unbindUser;
    ```

=== "Swift"

    ```swift
    /// 绑定用户信息
    ///
    /// - Parameters:
    ///   - Id:  用户Id
    ///   - userName: 用户名称 (可选)
    ///   - userEmail: 用户邮箱 (可选)
    ///   - extra: 用户的额外信息 (可选)
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)
    
    /// 注销当前用户
    open func unbindUser()
    ```

### 代码示例

=== "Objective-C"

    ```objectivec
    // 可以在用户登录成功后调用此方法用来绑定用户信息
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // 可以在用户退出登录后调用此方法来解绑用户信息
    [[FTSDKAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // 可以在用户登录成功后调用此方法用来绑定用户信息
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // 可以在用户退出登录后调用此方法来解绑用户信息
    FTSDKAgent.sharedInstance().unbindUser()
    ```

## 关闭 SDK

使用 `FTSDKAgent` 关闭 SDK。

### 使用方法

=== "Objective-C"

    ```objective-c
    /// 关闭 SDK 内正在运行对象
    - (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// 关闭 SDK 内正在运行对象
    func shutDown()
    ```
### 代码示例

=== "Objective-C"

    ```objective-c
    //如果动态改变 SDK 配置，需要先关闭，以避免错误数据的产生
    [[FTSDKAgent sharedInstance] shutDown];
    ```  

=== "Swift"

    ```swift
    //如果动态改变 SDK 配置，需要先关闭，以避免错误数据的产生
    FTSDKAgent.sharedInstance().shutDown()
    ```
## 添加自定义标签 {#user-global-context}

### 静态使用

可采用创建多 Configurations，使用预编译指令进行设置值：

1、创建多 Configurations：

![](../img/image_9.png)

2、设置预设属性来区分不同 Configurations:

![](../img/image_10.png)

3、使用预编译指令：

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

1、通过存文件本地保存，例如 `NSUserDefaults`，配置使用 `SDK`，在配置处添加获取标签数据的代码。

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... //其他设置操作
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2、在任意处添加改变文件数据的方法。

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3、最后重启应用生效。

### 注意

1. 特殊 key : track_id (在 RUM 中配置，用于追踪功能)  

2. 当用户通过 globalContext 添加自定义标签与 SDK 自有标签相同时，SDK 的标签会覆盖用户设置的，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。

3. 在调用 -startRumWithConfigOptions 方法启动 RUM 前设置 globalContext 才能生效。

4. `FTSDKConfig` 中配置的自定义标签将添加在所有类型的数据中。

> 更多详细细节，可参考 [SDK Demo](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)。



## 常见问题 {#FAQ}

### [关于崩溃日志分析](../ios/app-access.md#crash-log-analysis)

### 出现 Include of non-modular header inside framework module 报错

因为 SDK 的 .h 文件中引⼊了依赖库的 .h 文件，所以需要设置

`Target` -> `Build Settings` -> `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` 设置为 YES.
