# iOS 应用接入

---
???- quote "更新日志"

    **1.5.1**
    ```
    1. 修复行协议数据转义算法，解决因换行符导致数据同步失败问题
    2. 优化错误类型为 `network_error` 的错误信息，统一使用英文描述网络请求错误码
    3. 优化数据同步逻辑，修复多线程访问已释放 `uploadDelayTimer` 导致的崩溃问题
    4. 修复采集崩溃信息时 OC 与 C 字符串转换时编码格式错误导致的崩溃问题
    ```
    **1.5.0**
    ```
    1. RUM resource 网络请求添加 remote ip 地址解析功能
    2. 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
    3. 日志添加自定义 status 方法
    4. 日志数据写入优化、数据同步优化
    5. 对传入 SDK 的 NSDictionary 类型参数进行格式处理防止转换 json 失败造成数据丢失
    ```
    **1.4.14**
    ```
    1. 修复 `FTSwizzler` 内访问已被销毁的 Class 对象而导致的内存访问错误崩溃
    2. 修复向 SDK 传递的 NSDictionary 类型参数实际上是可变对象时可能引发的数据一致性和操作冲突问题
    ```
    **1.4.13**
    ```
    1. RUM LongTask、Anr 采集优化，修复 LongTask 堆栈信息采集不准确问题，新增支持采集致命卡顿
    2. 修复 `FTSwizzler` 内因多线程同时操作 NSMutableSet 造成的崩溃
    3. 修复打包 SDK Framework info.plist 中版本信息缺失问题
    4. 修复自定义 NSURLSession 未设置 delegate 时 Resource 的性能指标采集失败问题
    5. SDK 内部日志转化为文件功能优化，新增指定文件路径方法
    ```
    **1.4.12**
    ```
    1. 修复 SDK 调用注销方法 shutDown 产生的内存泄漏问题
    2. 修复采集 RUM-Resource 时与其他库冲突导致崩溃问题
    3. 修复崩溃采集 UncaughtExceptionHandler 未传递问题
    4. 修复多次初始化 SDK 造成的数据异常
    ```
    **1.4.11**
    ```
    1. 新增支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数
    2. 新增内部日志转文件方法
    3. 日志关联 RUM 数据获取错误修复
    4. 耗时操作优化
    5. 修复 WebView jsBridge 时产生的崩溃，对 WebView 引用改为弱引用
    ```
    [更多日志](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)


观测云应用监测能够通过收集各个 iOS 应用的指标数据，以可视化的方式分析各个 iOS 应用端的性能。

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入 {#iOS-integration}

登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。

![](../img/6.rum_ios.png)

## 安装

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) 

**源码地址**：[https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**：[https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1.配置 `Podfile` 文件。
    
    * 使用 Dynamic Library
    
      ```
      platform :ios, '10.0' 
      use_frameworks!
      def shared_pods
      pod 'FTMobileSDK', '[latest_version]'
      # 如果需要采集 widget Extension 数据
      pod 'FTMobileSDK/Extension', '[latest_version]'
      end
    
      //主工程
      target 'yourProjectName' do
      shared_pods
      end
    
      //Widget Extension
      target 'yourWidgetExtensionName' do
      shared_pods
      end
      ```
    
    * 使用 Static Library
    
      ```
      use_modular_headers!
      //主工程
      target 'yourProjectName' do
      pod 'FTMobileSDK', '[latest_version]'
      end
      //Widget Extension
      target 'yourWidgetExtensionName' do
      pod 'FTMobileSDK/Extension', '[latest_version]'
      end
      ```
    
    * [将代码库下载到本地使用](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
      
      **`Podfile` 文件**
      ```
      use_modular_headers!
      //主工程
      target 'yourProjectName' do
      pod 'FTMobileSDK', :path => '[folder_path]' 
      end
      //Widget Extension
      target 'yourWidgetExtensionName' do
      pod 'FTMobileSDK/Extension', :path => '[folder_path]'
      end
      ```
      `folder_path`: `FTMobileSDK.podspec` 所在文件夹的路径。
      **`FTMobileSDK.podspec` 文件**
      修改 `FTMobileSDK.podspec` 文件中的 `s.version`  和 `s.source` 。
      `s.version` ：修改为指定版本，建议与`FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`中`SDK_VERSION`一致。
      `s.source`：tag => s.version
      ```
      Pod::Spec.new do |s|
      s.name         = "FTMobileSDK"
      s.version      = "[latest_version]"  
      s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
      ```
    
    2.在 `Podfile` 目录下执行 `pod install` 安装 SDK。


=== "Carthage" 

    1.配置 `Cartfile` 文件。
    
    ```
    github "GuanceCloud/datakit-ios" == [latest_version]
    ```
    
    2.在 `Cartfile` 目录下执行
    
    ```bash
    carthage update --platform iOS
    ```
    
    如果报错 "Building universal frameworks with common architectures is not possible. The device and simulator slices for "FTMobileAgent.framework" both build for: arm64" 
    
    根据提示添加 --use-xcframeworks 参数
    
    ```bash
    carthage update --platform iOS --use-xcframeworks
    ```
    
    生成的  xcframework ，与普通的 Framework 使用方法相同。将编译生成的库添加到项目工程中。
    
    `FTMobileAgent`：添加到主项目 Target
    
    `FTMobileExtension`：添加到小组件 Widget Extension Target
    
    3.在 `TARGETS`  -> `Build Setting` ->  `Other Linker Flags`  添加  `-ObjC`。
    
    4.使用 Carthage 集成，SDK 版本支持：
      `FTMobileAgent`：>=1.3.4-beta.2 
      `FTMobileExtension`：>=1.4.0-beta.1

=== "Swift Package Manager"

    1.选中 `PROJECT` -> `Package Dependency` ，点击 `Packages` 栏目下的 **+**。
    
    2.在弹出的页面的搜索框中输入 `https://github.com/GuanceCloud/datakit-ios.git`。
    
    3.Xcode 获取软件包成功后，会展示 SDK 的配置页。
    
    `Dependency Rule` ：建议选择 `Up to Next Major Version` 。
    
    `Add To Project` ：选择支持的工程。
    
    填好配置后点击  `Add Package`  按钮，等待加载完成。
    
    4.在弹窗 `Choose Package Products for datakit-ios` 中选择需要添加 SDK 的 Target，点击 `Add Package` 按钮，此时 SDK 已经添加成功。
    
    `FTMobileSDK`：添加到主项目 Target
    
    `FTMobileExtension`：添加到 Widget Extension Target
    
    如果您的项目由 SPM 管理，将 SDK 添加为依赖项，添加 `dependencies `到 `Package.swift`。
    
    ```plaintext
    // 主项目
    dependencies: [
    .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",.upToNextMajor(from: "[latest_version]"))
    ]
    ```
    
    5.1.4.0-beta.1 及以上支持 Swift Package Manager 。

### 添加头文件

=== "Objective-C"

    ```
    //CocoaPods、SPM 
    #import "FTMobileSDK.h"
    //Carthage 
    #import <FTMobileSDK/FTMobileSDK.h>
    ```

=== "Swift"

    ```
    import FTMobileSDK
    ```

## SDK 初始化

### 基础配置 {#base-setting}

=== "Objective-C"

    ```objective-c
    -(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
        // SDK FTMobileConfig 设置
         // 本地环境部署、Datakit 部署
         //FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatakitUrl:datakitUrl];
         // 使用公网 DataWay 部署
        FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatawayUrl:datawayUrl clientToken:clientToken];
        config.enableSDKDebugLog = YES;
        //启动 SDK
        [FTMobileAgent startWithConfigOptions:config];
        
       //...
        return YES;
    }
    ```

=== "Swift"

    ```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         // SDK FTMobileConfig 设置
           // 本地环境部署、Datakit 部署
           //let config = FTMobileConfig(datakitUrl: url)
           // 使用公网 DataWay 部署
         let config = FTMobileConfig(datawayUrl: datawayUrl, clientToken: clientToken)
         config.enableSDKDebugLog = true
         FTMobileAgent.start(withConfigOptions: config)
         //...
         return true
    }
    ```

| 属性 | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| datakitUrl | NSString | 是 | Datakit 访问地址，例子：[http://10.0.0.1:9529](http://10.0.0.1:9529/)，端口默认 9529，安装 SDK 设备需能访问这地址.**注意：datakit 和 dataway 配置两者二选一** |
| datawayUrl | NSString | 是 | 公网 Dataway 访问地址，例子：[http://10.0.0.1:9528](http://10.0.0.1:9528/)，端口默认 9528，安装 SDK 设备需能访问这地址.**注意：datakit 和 dataway 配置两者二选一** |
| clientToken | NSString | 是 | 认证 token，需要与 datawayUrl 同时使用                               |
| enableSDKDebugLog | BOOL | 否 | 设置是否允许打印日志。默认 `NO` |
| env | NSString | 否 | 设置采集环境。默认 `prod`，支持自定义，也可根据提供的 `FTEnv` 枚举通过 `-setEnvWithType:` 方法设置 |
| service | NSString | 否 | 设置所属业务或服务的名称。影响 Log 和 RUM 中 service 字段数据。默认：`df_rum_ios` |
| globalContext | NSDictionary |     否 | 添加自定义标签。添加规则请查阅[此处](#user-global-context) |
| groupIdentifiers | NSArray | 否 | 需要采集的 Widget Extensions 对应的 AppGroups Identifier 数组。若开启 Widget Extensions 数据采集，则必须设置 [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups)，并将 Identifier 配置到该属性中 |
| autoSync | BOOL | 否 | 是否开启自动同步。默认 `YES`。当为 `NO` 时使用 `[[FTMobileAgent sharedInstance] flushSyncData]` 自行管理数据同步 |
| syncPageSize | int | 否 | 设置同步请求条目数。范围 [5,）注意：请求条目数越大，代表数据同步占用更大的计算资源 |
| syncSleepTime | int | 否 | 设置同步间歇时间。范围 [0,100]，默认不设置 |
| enableDataIntegerCompatible | BOOL | 否 | 需要与 web 数据共存情况下，建议开启。此配置用于处理 web 数据类型存储兼容问题 。 |

### RUM 配置 {#rum-config}

=== "Objective-C"

    ```objective-c
        //开启 rum
        FTRumConfig *rumConfig = [[FTRumConfig alloc]initWithAppid:appid];
        rumConfig.samplerate = 80;
        rumConfig.enableTrackAppCrash = YES;
        rumConfig.enableTrackAppANR = YES;
        rumConfig.enableTrackAppFreeze = YES;
        rumConfig.enableTraceUserAction = YES;
        rumConfig.enableTraceUserView = YES;
        rumConfig.enableTraceUserResource = YES;
        rumConfig.errorMonitorType = FTErrorMonitorAll;
        rumConfig.deviceMetricsMonitorType = FTDeviceMetricsMonitorAll;
        rumConfig.monitorFrequency = FTMonitorFrequencyRare;
        [[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
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
        FTMobileAgent.sharedInstance().startRum(withConfigOptions: rumConfig)
    ```

| **属性** | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| appid | NSString | 是 | 用户访问监测应用 ID 唯一标识。对应设置 RUM `appid`，才会开启`RUM`的采集功能，[获取 appid 方法](#iOS-integration) |
| samplerate | int | 否 | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据 |
| enableTrackAppCrash | BOOL | 否 | 设置是否需要采集崩溃日志。默认 `NO` |
| enableTrackAppANR | BOOL | 否 | 采集ANR卡顿无响应事件。默认`NO` |
| enableTrackAppFreeze | BOOL | 否 | 采集UI卡顿事件。默认`NO` |
| enableTraceUserView | BOOL | 否 | 设置是否追踪用户 View 操作。默认`NO` |
| enableTraceUserAction | BOOL | 否 | 设置是否追踪用户 Action 操作。默认`NO` |
| enableTraceUserResource | BOOL | 否 | 设置是否追踪用户网络请求。默认`NO`，仅作用于 native http <br/>注意：不支持采集使用 **Swift URLSession async/await APIs** 和 `[NSURLSession sharedSession]`发起的请求. |
| resourceUrlHandler | FTResourceUrlHandler | 否 | 自定义采集 resource 规则。默认不过滤。 返回：NO 表示要采集，YES 表示不需要采集。 |
| errorMonitorType | FTErrorMonitorType | 否 | 错误事件监控补充类型。在采集的崩溃数据中添加监控的信息。`FTErrorMonitorBattery`为电池余量，`FTErrorMonitorMemory`为内存用量，`FTErrorMonitorCpu`为 CPU 占有率 。 |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | 否 | 视图的性能监控类型。在采集的  **View** 数据中添加对应监控项信息。`FTDeviceMetricsMonitorMemory`监控当前应用使用内存情况，`FTDeviceMetricsMonitorCpu`监控 CPU 跳动次数，`FTDeviceMetricsMonitorFps`监控屏幕帧率。 |
| monitorFrequency | FTMonitorFrequency | 否 | 视图的性能监控采样周期。配置 `monitorFrequency` 来设置 **View** 监控项信息的采样周期。`FTMonitorFrequencyDefault`500ms (默认)，`FTMonitorFrequencyFrequent`100ms，`FTMonitorFrequencyRare`1000ms。 |
| enableResourceHostIP | BOOL | 否 | 是否采集请求目标域名地址的 IP。`>= iOS 13` 下支持 |
| globalContext | NSDictionary | 否 | 添加自定义标签。添加规则请查阅[此处](#user-global-context) |

### Log 配置 {#log-config}

=== "Objective-C"

    ```objective-c
        //开启 logger
        FTLoggerConfig *loggerConfig = [[FTLoggerConfig alloc]init];
        loggerConfig.enableCustomLog = YES;
        loggerConfig.enableLinkRumData = YES;
        loggerConfig.logLevelFilter = @[@(FTStatusError),@(FTStatusCritical)];
        loggerConfig.discardType = FTDiscardOldest;
        [[FTMobileAgent sharedInstance] startLoggerWithConfigOptions:loggerConfig];
    ```

=== "Swift"

    ```
        let loggerConfig = FTLoggerConfig()
        loggerConfig.enableCustomLog = true
        loggerConfig.enableLinkRumData = true
        loggerConfig.logLevelFilter = [NSNumber(value: FTLogStatus.statusError.rawValue),NSNumber(value: FTLogStatus.statusCritical.rawValue)] // loggerConfig.logLevelFilter = [2,3]
        loggerConfig.discardType = .discardOldest
        FTMobileAgent.sharedInstance().startLogger(withConfigOptions: loggerConfig)
    ```

| 属性 | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| samplerate | int | 否 | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。 |
| enableCustomLog | BOOL | 否 | 是否上传自定义 log。默认`NO` |
| printCustomLogToConsole | BOOL | 否 | 设置是否将自定义日志输出到控制台。默认`NO`，自定义日志[输出格式](#printCustomLogToConsole) |
| logLevelFilter | NSArray | 否 | 设置要采集的自定义 log 的状态数组。默认全采集 |
| enableLinkRumData | BOOL | 否 | 是否与 RUM 数据关联。默认`NO` |
| discardType | FTLogCacheDiscard | 否 | 设置频繁日志丢弃规则。默认 `FTDiscard` <br/>`FTDiscard`当日志数据数量大于最大值（5000）时，丢弃追加数据。`FTDiscardOldest`当日志数据大于最大值时,丢弃老数据。 |
| globalContext | NSDictionary |     否 | 添加自定义标签。添加规则请查阅[此处](#user-global-context) |
| logCacheLimitCount | int | 否 | 获取最大日志条目数量。限制 [1000,)，默认 5000 |

### Trace 配置 {#trace-config}

=== "Objective-C"

    ```objective-c
       //开启 trace
       FTTraceConfig *traceConfig = [[FTTraceConfig alloc]init];
       traceConfig.enableLinkRumData = YES;
    	 traceConfig.enableAutoTrace = YES;
       traceConfig.networkTraceType = FTNetworkTraceTypeDDtrace;
       [[FTMobileAgent sharedInstance] startTraceWithConfigOptions:traceConfig];
    ```

=== "Swift"

    ```swift
       let traceConfig = FTTraceConfig.init()
       traceConfig.enableLinkRumData = true
       traceConfig.enableAutoTrace = true
       FTMobileAgent.sharedInstance().startTrace(withConfigOptions: traceConfig)
    ```

| 属性 | 类型 | 必须 | 含义 |
| --- | --- | --- | --- |
| samplerate | int | 否 | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。 |
| networkTraceType | FTNetworkTraceType | 否 | 设置链路追踪的类型。默认为 `DDTrace`，目前支持 `Zipkin` , `Jaeger`, `DDTrace`，`Skywalking` (8.0+)，`TraceParent` (W3C)，如果接入 OpenTelemetry 选择对应链路类型时，请注意查阅支持类型及 agent 相关配置 |
| enableLinkRumData | BOOL | 否 | 是否与 RUM 数据关联。默认`NO` |
| enableAutoTrace | BOOL | 否 | 设置是否开启自动 http trace。默认`NO`，目前只支持 NSURLSession |

## RUM 用户数据追踪 {#rum}

`FTRUMConfig` 配置 `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` 来实现自动获取数据的效果或手动使用 `FTExternalDataManager` 来实现添加这些数据，示例如下：

### View

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
    ///
    /// - Parameters:
    ///  - viewName: 页面名称
    -(void)startViewWithName:(NSString *)viewName;
    
    /// 进入页面
    /// - Parameters:
    ///  - viewName: 页面名称
    ///  - property: 事件自定义属性(可选)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// 离开页面
    -(void)stopView;
    
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
    ///
    /// - Parameters:
    ///  - viewName: 页面名称
    open func startView(withName viewName: String)
    
    /// 进入页面
    /// - Parameters:
    ///  - viewName: 页面名称
    ///  - property: 事件自定义属性(可选)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// 离开页面
    open func stopView() 
    
    /// 离开页面
    /// - Parameter property: 事件自定义属性(可选)
    open func stopView(withProperty property: [AnyHashable : Any]?)
    ```

#### 代码示例

=== "Objective-C"

    ```objectivec
    - (void)viewDidAppear:(BOOL)animated{
      [super viewDidAppear:animated];
      // 场景 1：
      [[FTExternalDataManager sharedManager] startViewWithName:@"TestVC"];  
      
      // 场景 2：动态参数
      [[FTExternalDataManager sharedManager] startViewWithName:@"TestVC" property:@{@"custom_key":@"custom_value"}];  
    }
    -(void)viewDidDisappear:(BOOL)animated{
      [super viewDidDisappear:animated];
      // 场景 1：
      [[FTExternalDataManager sharedManager] stopView];  
      
      // 场景 2：动态参数
      [[FTExternalDataManager sharedManager] stopViewWithProperty:@{@"custom_key":@"custom_value"}];
    }
    ```

=== "Swift"

    ```swift
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 场景 1：
        FTExternalDataManager.shared().startView(withName: "TestVC")
        // 场景 2：动态参数
        FTExternalDataManager.shared().startView(withName: "TestVC",property: ["custom_key":"custom_value"])
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 场景 1：
        FTExternalDataManager.shared().stopView()
        // 场景 2：动态参数
        FTExternalDataManager.shared().stopView(withProperty: ["custom_key":"custom_value"])
    }
    ```

### Action

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// 添加 Click Action 事件
    ///
    /// - Parameters:
    ///   - actionName: 事件名称
    - (void)addClickActionWithName:(NSString *)actionName;
    
    /// 添加 Click Action 事件
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - property: 事件自定义属性(可选)
    - (void)addClickActionWithName:(NSString *)actionName property:(nullable NSDictionary *)property;
    
    /// 添加 Action 事件
    ///
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - actionType: 事件类型
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType;
    /// 添加 Action 事件
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - actionType: 事件类型
    ///   - property: 事件自定义属性(可选)
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// 添加 Click Action 事件
    ///
    /// - Parameters:
    ///   - actionName: 事件名称
    func addClickAction(withName: String)
    
    /// 添加 Click Action 事件
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - property: 事件自定义属性(可选)
    func addClickAction(withName: String, property: [AnyHashable : Any]?)
    
    /// 添加 Action 事件
    ///
    /// - Parameters:
    ///   - actionName: 事件名称
    ///   - actionType: 事件类型
    func addActionName(String, actionType: String)
    
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
    [[FTExternalDataManager sharedManager] addActionName:@"UITableViewCell click" actionType:@"click"];
    // 场景2: 动态参数
    [[FTExternalDataManager sharedManager]  addActionName:@"UITableViewCell click" actionType:@"click" property:@{@"custom_key":@"custom_value"}];
    ```
=== "Swift"

    ```swift
    // 场景1
    FTExternalDataManager.shared().addActionName("custom_action", actionType: "click")
    // 场景2: 动态参数
    FTExternalDataManager.shared().addActionName("custom_action", actionType: "click",property: ["custom_key":"custom_value"])
    ```

### Error

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// 添加 Error 事件
    ///
    /// - Parameters:
    ///   - type: error 类型
    ///   - message: 错误信息
    ///   - stack: 堆栈信息
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
    
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
    ///
    /// - Parameters:
    ///   - type: error 类型
    ///   - message: 错误信息
    ///   - stack: 堆栈信息
    open func addError(withType: String, message: String, stack: String)
    
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
    [[FTExternalDataManager sharedManager] addErrorWithType:@"type" message:@"message" stack:@"stack"];
    // 场景2: 动态参数
    [[FTExternalDataManager sharedManager] addErrorWithType:@"ios_crash" message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    // 场景3: 动态参数
    [[FTExternalDataManager sharedManager] addErrorWithType:@"ios_crash" state:FTAppStateUnknown message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // 场景1
    FTExternalDataManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack")
    // 场景2: 动态参数
    FTExternalDataManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack",property: ["custom_key":"custom_value"])
    // 场景3: 动态参数       
    FTExternalDataManager.shared().addError(withType: "custom_type", state: .unknown, message: "custom_message", stack: "custom_stack", property: ["custom_key":"custom_value"])
    ```


### LongTask

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// 添加 卡顿 事件
    ///
    /// - Parameters:
    ///   - stack: 卡顿堆栈
    ///   - duration: 卡顿时长（纳秒）
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
    
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
    ///
    /// - Parameters:
    ///   - stack: 卡顿堆栈
    ///   - duration: 卡顿时长（纳秒）
    func addLongTask(withStack: String, duration: NSNumber)
    
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
    [[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
    // 场景2: 动态参数
    [[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000 property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // 场景1
    FTExternalDataManager.shared().addLongTask(withStack: "stack string", duration: 1000000000)
    // 场景2: 动态参数
    FTExternalDataManager.shared().addLongTask(withStack: "stack string", duration: 1000000000 ,property: [["custom_key":"custom_value"]])
    ```

### Resource

#### 使用方法

=== "Objective-C"

    ```objectivec
    /// HTTP 请求开始
    ///
    /// - Parameters:
    ///   - key: 请求标识
    - (void)startResourceWithKey:(NSString *)key;
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
    ///
    /// - Parameters:
    ///   - key: 请求标识
    - (void)stopResourceWithKey:(NSString *)key;
    /// HTTP 请求结束
    /// - Parameters:
    ///   - key: 请求标识
    ///   - property: 事件自定义属性(可选)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// HTTP 请求开始
    ///
    /// - Parameters:
    ///   - key: 请求标识
    open func startResource(withKey key: String)
    
    /// HTTP 请求开始
    /// - Parameters:
    ///   - key: 请求标识
    ///   - property: 事件自定义属性(可选)
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// HTTP 请求结束
    ///
    /// - Parameters:
    ///   - key: 请求标识
    open func stopResource(withKey key: String)
    
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
    //第一步：请求开始前
    [[FTExternalDataManager sharedManager] startResourceWithKey:key];
    
    //第二步：请求完成
    [[FTExternalDataManager sharedManager] stopResourceWithKey:key];
    
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
    [[FTExternalDataManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    //第一步：请求开始前
    FTExternalDataManager.shared().startResource(withKey: key)
    
    //第二步：请求完成
    FTExternalDataManager.shared().stopResource(withKey: resource.key)
    
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
    FTExternalDataManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logger 日志打印 {#user-logger}

在 SDK 初始化 [Log 配置](#log-config) 时，配置 `enableCustomLog` 允许自定义添加日志。
> 目前日志内容限制为 30 KB，字符超出部分会进行截断处理
### 使用方法

=== "Objective-C"

    ```objectivec
    //  FTMobileAgent.h
    //  FTMobileSDK
    
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
    
    ```objective-c
    //
    //  FTLogger.h
    //  FTMobileSDK
    
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
    open class FTMobileAgent : NSObject {
    /// 添加自定义日志
    ///
    /// - Parameters:
    ///   - content: 日志内容，可为 json 字符串
    ///   - status: 事件等级和状态
    open func logging(_ content: String, status: FTLogStatus)
    
    /// 添加自定义日志
    /// - Parameters:
    ///   - content: 日志内容，可为 json 字符串
    ///   - status: 事件等级和状态
    ///   - property: 事件自定义属性(可选)
    open func logging(_ content: String, status: FTLogStatus, property: [AnyHashable : Any]?)
    }
    ```
    
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
    // 方法一：通过 FTMobileAgent
    // 注意：需要保证在使用的时候 SDK 已经初始化成功，否则在测试环境会断言失败从而崩溃。
    [[FTMobileAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // 方法二：通过 FTLogger （推荐）
    // SDK 如果没有初始化成功，调用 FTLogger 中方法添加自定义日志会失败，但不会有断言失败崩溃问题。
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // 方法一：通过 FTMobileAgent
    // 注意：需要保证在使用的时候 SDK 已经初始化成功，否则在测试环境会断言失败从而崩溃。
    FTMobileAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // 方法二：通过 FTLogger （推荐）
    // SDK 如果没有初始化成功，调用 FTLogger 中方法添加自定义日志会失败，但不会有断言失败崩溃问题。
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### 自定义日志输出到控制台 {#printCustomLogToConsole}


设置 `printCustomLogToConsole = YES` ，开启将自定义日志输出到控制台，将会在 xcode 调试控制台看到以下格式的日志：

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [IOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`：os_log 日志输出的标准前缀；

`[IOS APP]`：用来区分 SDK 输出自定义日志的前缀；

`[INFO]`：自定义日志的等级；

`content`：自定义日志内容；

`{K=V,...,Kn=Vn}`：自定义属性。

## Trace 网络链路追踪

可以 `FTTraceConfig` 配置开启自动模式，也支持用户自定义添加 Trace 相关数据。自定义添加相关 API 如下：

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
    if let traceHeader = FTExternalDataManager.shared().getTraceHeader(withKey: NSUUID().uuidString, url: url) {
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

## 通过转发 URLSession Delegate 自定义采集 Network

**注意：该方法不适用于 Swift URLSession async/await APIs**

SDK 提供了一个类 `FTURLSessionDelegate`，需要您将 URLSession 的 delegate 转发给 `FTURLSessionDelegate`，以帮助 SDK 采集 Network 的相关数据。

采集 Network 的相关数据在 SDK 中分为 `RUM-Resource` 和 `网络链路追踪`。

**RUM-Resource**：

* 可以开启  `FTRUMConfig` 的 `enableTraceUserResource` ，自动采集逻辑会忽略当前 `URLSession` 发起的请求；
* 支持添加自定义属性。

**网络链路追踪**：

* 可以开启  `FTTraceConfig` 的 `enableAutoTrace` 。当设置自定义链路追踪时自动追踪逻辑会忽略当前 `URLSession` 发起的请求。

下面提供了三种方法，来满足用户的不同场景。

### 方法一

直接设置 URLSession 的 delegate 对象设置为 `FTURLSessionDelegate` 的实例

=== "Objective-C"

    ```objective-c
    id<NSURLSessionDelegate> delegate = [[FTURLSessionDelegate alloc]init];
    // 添加自定义 RUM 资源属性，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。
    delegate.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
    // 拦截 Request 返回修改后的 Request，可用于自定义链路追踪
    delegate.requestInterceptor = ^NSURLRequest * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *traceHeader = [[FTExternalDataManager sharedManager] getTraceHeaderWithUrl:request.URL];
                NSMutableURLRequest *newRequest = [request mutableCopy];
                if(traceHeader){
                    for (NSString *key in traceHeader.allKeys) {
                        [newRequest setValue:traceHeader[key] forHTTPHeaderField:key];
                    }
                }
                return newRequest;
            };            
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:delegate delegateQueue:nil];
    ```


=== "Swift"

    ```swift
    let delegate = FTURLSessionDelegate.init()
    // 添加自定义 RUM 资源属性，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。
    delegate.provider = { request,response,data,error in
                var extraData:Dictionary<String, Any> = Dictionary()
                if let data = data,let requestBody = String(data: data, encoding: .utf8) {
                    extraData["df_requestBody"] = requestBody
                }
                if let error = error {
                    extraData["df_error"] = error.localizedDescription
                }
                return extraData
            }
    // 拦截 Request 返回修改后的 Request，可用于自定义链路追踪        
    delegate.requestInterceptor = { request in
                var mutableRequest = request
                if let traceHeader = FTExternalDataManager.shared().getTraceHeader(with: request.url!){
                    for (key,value) in traceHeader {
                        mutableRequest.setValue(value as? String, forHTTPHeaderField: key as! String)
                    }
                }
                return mutableRequest
            }        
    let session =  URLSession.init(configuration: URLSessionConfiguration.default, delegate:delegate 
    , delegateQueue: nil)
    ```

### 方法二

设置 URLSession 的 delegate 对象设置为 `FTURLSessionDelegate` 的子类

=== "Objective-C"

    ```objective-c
    @interface InstrumentationInheritClass:FTURLSessionDelegate
    @property (nonatomic, strong) NSURLSession *session;
    @end
    @implementation InstrumentationInheritClass
    -(instancetype)init{
        self = [super init];
        if(self){
            _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
            // 添加自定义 RUM 资源属性，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。
            self.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
            NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            return @{@"df_requestbody":body};
        };
            // 拦截 Request 返回修改后的 Request，可用于自定义链路追踪
           self.requestInterceptor = ^NSURLRequest * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *traceHeader = [[FTExternalDataManager sharedManager] getTraceHeaderWithUrl:request.URL];
                NSMutableURLRequest *newRequest = [request mutableCopy];
                if(traceHeader){
                    for (NSString *key in traceHeader.allKeys) {
                        [newRequest setValue:traceHeader[key] forHTTPHeaderField:key];
                    }
                }
                return newRequest;
            }; 
        }
        return self;
    }
    -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics{
        // 一定要调用 父类 方法
        [super URLSession:session task:task didFinishCollectingMetrics:metrics];
        // 您自己的逻辑
        // ......
    }
    @end
    ```

=== "Swift"

    ```swift
    class InheritHttpEngine:FTURLSessionDelegate {
        var session:URLSession?
        override init(){
            session = nil
            super.init()
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            session = URLSession.init(configuration: configuration, delegate:self, delegateQueue: nil)
            override init() {
            super.init()
            // 添加自定义 RUM 资源属性，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。
            provider = { request,response,data,error in
                var extraData:Dictionary<String, Any> = Dictionary()
                if let data = data,let requestBody = String(data: data, encoding: .utf8) {
                    extraData["df_requestBody"] = requestBody
                }
                if let error = error {
                    extraData["df_error"] = error.localizedDescription
                }
                return extraData
            }
            // 拦截 Request 返回修改后的 Request，可用于自定义链路追踪
            requestInterceptor = { request in
                var mutableRequest = request
                if let traceHeader = FTExternalDataManager.shared().getTraceHeader(with: request.url!){
                    for (key,value) in traceHeader {
                        mutableRequest.setValue(value as? String, forHTTPHeaderField: key as! String)
                    }
                }
                return mutableRequest
            }
        }
        }
    
        override func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
            // 一定要调用 父类 方法
            super.urlSession(session, task: task, didFinishCollecting: metrics)
            // 用户自己的逻辑
            // ......
        }
    }
    ```

### 方法三

使 URLSession 的 delegate 对象遵循 `FTURLSessionDelegateProviding` 协议，在该类里声明名为 ftURLSessionDelegate 的  `FTURLSessionDelegate` 属性（readwrite），实现 `- ftURLSessionDelegate` 方法。

接收到 session 的 delegate 方法：

`-URLSession:dataTask:didReceiveData:`

`-URLSession:task:didCompleteWithError:`

`-URLSession:task:didFinishCollectingMetrics:`

后发送给 `ftURLSessionDelegate` ，以能够使 SDK 进行数据采集。

=== "Objective-C"

    ```objective-c
    @interface InstrumentationPropertyClass:NSObject<NSURLSessionDataDelegate,FTURLSessionDelegateProviding>
    @property (nonatomic, strong) FTURLSessionDelegate *ftURLSessionDelegate;
    @end
    @implementation InstrumentationPropertyClass
    
    - (nonnull FTURLSessionDelegate *)ftURLSessionDelegate {
        if(!_ftURLSessionDelegate){
            _ftURLSessionDelegate = [[FTURLSessionDelegate alloc]init];
            _ftURLSessionDelegate.provider =  ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
                // 拦截 Request 返回修改后的 Request，可用于自定义链路追踪
            _ftURLSessionDelegate.requestInterceptor = ^NSURLRequest * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *traceHeader = [[FTExternalDataManager sharedManager] getTraceHeaderWithUrl:request.URL];
                NSMutableURLRequest *newRequest = [request mutableCopy];
                if(traceHeader){
                    for (NSString *key in traceHeader.allKeys) {
                        [newRequest setValue:traceHeader[key] forHTTPHeaderField:key];
                    }
                }
                return newRequest;
            }; 
        }
        return _ftURLSessionDelegate;
    }
    - (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
        [self.ftURLSessionDelegate URLSession:session dataTask:dataTask didReceiveData:data];
    }
    - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
        [self.ftURLSessionDelegate URLSession:session task:task didCompleteWithError:error];
    }
    -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics{
        [self.ftURLSessionDelegate URLSession:session task:task didFinishCollectingMetrics:metrics];
    }
    @end
    ```

=== "Swift"

    ```swift
    class HttpEngine:NSObject,URLSessionDataDelegate,FTURLSessionDelegateProviding {
        var ftURLSessionDelegate: FTURLSessionDelegate = FTURLSessionDelegate()
        var session:URLSession?
    
        override init(){
            session = nil
            super.init()
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            session = URLSession.init(configuration: configuration, delegate:self, delegateQueue: nil)
            // 添加自定义 RUM 资源属性，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。
            ftURLSessionDelegate.provider = { request,response,data,error in
                var extraData:Dictionary<String, Any> = Dictionary()
                if let data = data,let requestBody = String(data: data, encoding: .utf8) {
                    extraData["df_requestBody"] = requestBody
                }
                if let error = error {
                    extraData["df_error"] = error.localizedDescription
                }
                return extraData
            }
            // 拦截 Request 返回修改后的 Request，可用于自定义链路追踪
            ftURLSessionDelegate.requestInterceptor = { request in
                var mutableRequest = request
                if let traceHeader = FTExternalDataManager.shared().getTraceHeader(with: request.url!){
                    for (key,value) in traceHeader {
                        mutableRequest.setValue(value as? String, forHTTPHeaderField: key as! String)
                    }
                }
                return mutableRequest
            }
        }
        // 下面方法一定要实现
        func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
            ftURLSessionDelegate.urlSession(session, dataTask: dataTask, didReceive: data)
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
            ftURLSessionDelegate.urlSession(session, task: task, didFinishCollecting: metrics)
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            ftURLSessionDelegate.urlSession(session, task: task, didCompleteWithError: error)
        }
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
    - (void)bindUserWithUserID:(NSString *)userId;
    
    /// 绑定用户信息
    ///
    /// - Parameters:
    ///   - Id:  用户Id
    ///   - userName: 用户名称
    ///   - userEmailL: 用户邮箱
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail;
    
    /// 绑定用户信息
    ///
    /// - Parameters:
    ///   - Id:  用户Id
    ///   - userName: 用户名称
    ///   - userEmail: 用户邮箱
    ///   - extra: 用户的额外信息
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
    open func bindUser(withUserID userId: String)
    
    /// 绑定用户信息
    ///
    /// - Parameters:
    ///   - Id:  用户Id
    ///   - userName: 用户名称
    ///   - userEmailL: 用户邮箱
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?)
       
    /// 绑定用户信息
    ///
    /// - Parameters:
    ///   - Id:  用户Id
    ///   - userName: 用户名称
    ///   - userEmail: 用户邮箱
    ///   - extra: 用户的额外信息
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)
    
    /// 注销当前用户
    open func unbindUser()
    ```

### 代码示例

=== "Objective-C"

    ```objectivec
    // 可以在用户登录成功后调用此方法用来绑定用户信息
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // 可以在用户退出登录后调用此方法来解绑用户信息
    [[FTMobileAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // 可以在用户登录成功后调用此方法用来绑定用户信息
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // 可以在用户退出登录后调用此方法来解绑用户信息
    FTMobileAgent.sharedInstance().unbindUser()
    ```

## 关闭 SDK

使用 `FTMobileAgent` 关闭 SDK。

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
    [[FTMobileAgent sharedInstance] shutDown];
    ```  

=== "Swift"

    ```swift
    //如果动态改变 SDK 配置，需要先关闭，以避免错误数据的产生
    FTMobileAgent.sharedInstance().shutDown()
    ```

## 主动同步数据

使用 `FTMobileAgent` 主动同步数据。
>FTMobileConfig.autoSync = NO 时, 才需要自行进行数据同步
### 使用方法

=== "Objective-C"

    ```objective-c
    ///  主动同步数据
    - (void)flushSyncData;
    ```

=== "Swift"

    ```swift
    /// 主动同步数据
    func flushSyncData()
    ```

### 代码示例

=== "Objective-C"

    ```objective-c
    [[FTMobileAgent sharedInstance] flushSyncData];
    ```  

=== "Swift"

    ```swift
    //如果动态改变 SDK 配置，需要先关闭，以避免错误数据的产生
    FTMobileAgent.sharedInstance().flushSyncData()
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
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

### 动态使用

因 RUM 启动后设置的 globalContext 不会生效，用户可自行本地保存，在下次应用启动时进行设置生效。

1. 通过存文件本地保存，例如`NSUserDefaults`，配置使用 `SDK`，在配置处添加获取标签数据的代码。

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... //其他设置操作
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
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

4. `FTMobileConfig` 中配置的自定义标签将添加在所有类型的数据中。

详细细节请见 [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)。

## 崩溃日志符号化 {#source_map}

### 上传符号表

#### 方法一：脚本集成到 Xcode 工程的 Target

1. XCode 添加自定义 Run Script Phase：` Build Phases -> + -> New Run Script Phase`
2. 将脚本复制到 Xcode 项目的构建阶段运行脚本中，脚本中需要设置参数如：＜app_id＞、＜datakit_address＞、＜env＞、<dataway_token>、＜version＞(脚本默认配置的版本格式为 `CFBundleShortVersionString`)。
3. [脚本：FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

```sh
#脚本中需要配置的参数
#＜app_id＞
FT_APP_ID="YOUR_APP_ID"
#<datakit_address>
FT_DATAKIT_ADDRESS="YOUR_DATAKIT_ADDRESS"
#<dev> 环境字段。属性值：prod/gray/pre/common/local。需要与 SDK 设置一致
FT_ENV="common"
#<dataway_token> 配置文件 datakit.conf 中 dataway 的 token
FT_TOKEN="YOUR_DATAWAY_TOKEN"
#
#＜version＞ 脚本默认配置的版本格式为CFBundleShortVersionString,如果您修改默认的版本格式, 请设置此变量。注意：需要确保在此填写的与SDK设置的一致。
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
//如果有使用 cocoapods ，需要将 pods 的.xcconfig 路径添加到您的 .xcconfig 文件中
#include "Pods/Target Support Files/Pods-testDemo/Pods-testDemo.debug.xcconfig"

SDK_APP_ID = app_id_common
SDK_ENV = common
SDK_DATAKIT_ADDRESS = http:\$()\xxxxxxxx:9529
SDK_DATAWAY_TOKEN = token
```

3. 配置自定义编译环境

![](../img/multi-environment-configuration4.png)



![](../img/multi-environment-configuration5.png)


4. 使用

**脚本中**

```sh
#脚本中需要配置的参数
#＜app_id＞
FT_APP_ID=${SDK_APP_ID}
#<datakit_address>
FT_DATAKIT_ADDRESS=${SDK_DATAKIT_ADDRESS}
#<dev> 环境字段。属性值：prod/gray/pre/common/local。需要与 SDK 设置一致
FT_ENV=${SDK_ENV}
#<dataway_token> 配置文件 datakit.conf 中 dataway 的 token
FT_TOKEN=${SDK_DATAWAY_TOKEN}
```

**项目文件中** 

映射到  `Info.plist` 文件中

![](../img/multi-environment-configuration8.png)

在文件中可以使用

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let info = Bundle.main.infoDictionary!
        let appid:String = info["SDK_APP_ID"] as! String
        let env:String  = info["SDK_ENV"] as! String

        print("SDK_APP_ID:\(appid)")
        print("SDK_ENV:\(env)")
}
```


详细细节请见 [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)。

#### 方法二：终端运行脚本

找到 .dSYM 文件放在一个文件夹内，命令行下输入应用基本信息, .dSYM 文件的父目录路径, 输出文件目录即可

[脚本：FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

`sh FTdSYMUpload.sh <datakit_address> <app_id> <version> <env> <dataway_token> <dSYMBOL_src_dir> <dSYMBOL_dest_dir>`

#### 方法三：手动上传

[Sourcemap 上传](../../integrations/rum.md#sourcemap)

## Widget Extension 数据采集

### Widget Extension 数据采集支持

* Logger 自定义日志

* Trace 链路追踪
* RUM 数据采集
  * 手动采集  ([RUM 用户数据追踪](#rum) )
  * 自动采集崩溃日志，HTTP Resource 数据

由于  HTTP Resource 数据是与 View 进行绑定的，所以需要用户手动采集 View 的数据。

### Widget Extension 采集配置

使用 `FTExtensionConfig` 配置 Widget Extension 采集数据的自动开关和文件共享 Group Identifier，其他的配置使用主项目 SDK 中已设配置。

| **字段**                   | **类型**  | **必须**           | **说明**                                       |
| -------------------------- | --------- | ------------------ | ---------------------------------------------- |
| groupIdentifier            | NSString  | 是                 | 文件共享 Group Identifier                      |
| enableSDKDebugLog          | BOOL      | 否（默认NO）       | 设置是否允许 SDK 打印 Debug 日志               |
| enableTrackAppCrash        | BOOL      | 否（默认NO）       | 设置是否需要采集崩溃日志                       |
| enableRUMAutoTraceResource | BOOL      | 否（默认NO）       | 设置是否追踪用户网络请求 (仅作用于native http) |
| enableTracerAutoTrace      | BOOL      | 否（默认NO）       | 设置是否开启自动 http 链路追踪                 |
| memoryMaxCount             | NSInteger | 否（默认 1000 条） | 数据保存在 Widget Extension 数量最大值         |

Widget Extension SDK 使用示例：

```swift
let extensionConfig = FTExtensionConfig.init(groupIdentifier: "group.identifier")
extensionConfig.enableTrackAppCrash = true
extensionConfig.enableRUMAutoTraceResource = true
extensionConfig.enableTracerAutoTrace = true
extensionConfig.enableSDKDebugLog = true
FTExtensionManager.start(with: extensionConfig)
FTExternalDataManager.shared().startView(withName: "WidgetDemoEntryView")
```

同时在主项目中设置 `FTMobileConfig` 时，必须设置 `groupIdentifiers` 。

=== "Objective-C"

    ```objective-c
    // 主项目
     FTMobileConfig *config = [[FTMobileConfig alloc]initWithMetricsUrl:url];
     config.enableSDKDebugLog = YES;
     config.groupIdentifiers = @[@"group.com.ft.widget.demo"]; 
    ```

=== "Swift"

    ````swift
    let config = FTMobileConfig.init(metricsUrl: url)
    config.enableSDKDebugLog = true
    config.groupIdentifiers = ["group.com.ft.widget.demo"]
    ````

### Widget Extension 采集的数据上传

Widget Extension SDK 中仅实现数据的采集，数据上传逻辑交给主项目的 SDK 来实现。采集的数据同步到主项目的时机由用户自定义。

#### 使用方法

=== "Objective-C"

    ```objective-c
    // 在主项目中调用
    /// Track App Extension groupIdentifier 中缓存的数据
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: 完成 track 后的 callback
    - (void)trackEventFromExtensionWithGroupIdentifier:(NSString *)groupIdentifier completion:(nullable void (^)(NSString *groupIdentifier, NSArray *events)) completion;
    ```

=== "Swift"

    ```swift
    /// Track App Extension groupIdentifier 中缓存的数据
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: 完成 track 后的 callback
    open func trackEventFromExtension(withGroupIdentifier groupIdentifier: String, completion: ((String, [Any]) -> Void)? = nil)
    ```

#### 代码示例

=== "Objective-C"

    ```objective-c
    // 在主项目中
    -(void)applicationDidBecomeActive:(UIApplication *)application{
        [[FTMobileAgent sharedInstance] trackEventFromExtensionWithGroupIdentifier:@"group.identifier" completion:nil];
    }
    ```

=== "Swift"

    ```swift
    func applicationDidBecomeActive(_ application: UIApplication) {
       FTMobileAgent.sharedInstance().trackEventFromExtension(withGroupIdentifier: "group.identifier" )     
    }
    ```

## WebView 数据监测
WebView 数据监测，需要在 WebView 访问页面集成[Web 监测 SDK](../web/app-access.md)

## 常见问题 {#FAQ}

### 关于崩溃日志分析 {#crash-log-analysis}

在开发时的 **Debug** 和 **Release** 模式下， **Crash** 时捕获的线程回溯是被符号化的。
而发布包没带符号表，异常线程的关键回溯，会显示镜像的名字，不会转化为有效的代码符号，获取到的 **crash log** 中的相关信息都是 16 进制的内存地址，并不能定位崩溃的代码，所以需要将 16 进制的内存地址解析为对应的类及方法。

#### XCode 编译后没有生成 dSYM 文件？

XCode Release 编译默认会生成 dSYM 文件，而 Debug 编译默认不会生成，对应的 Xcode 配置如下：

 ` Build Settings -> Code Generation -> Generate Debug Symbols -> Yes` 

![](../img/dsym_config1.png)


` Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File`

![](../img/dsym_config2.png)




#### 开启了 bitCode 怎么上传符号表？

当您上传您的 bitcode App 到 App Store，在提交对话框里勾选声明符号文件（dSYM文件）的生成：

- 在配置符号表文件之前，需要从App Store中把该版本对应的dSYM文件下载回本地，然后用脚本根据输入参数处理上传符号表文件。
- 不需要将脚本集成到 Xcode 工程的 Target 了，也不要用本地生成的 dSYM 文件来生成符号表文件，因为本地编译生成的 dSYM 文件的符号表信息都被隐藏了。如果用本地编译生成的 dSYM 文件上传，还原出来的结果将是类似于“__hiden#XXX”这样的符号。

#### 如何找回已发布到 App Store 的 App 对应的 dSYM 文件？

| 应用上传到App  Store Connect的Distribution options | dSym文件                                                     |
| -------------------------------------------------- | ------------------------------------------------------------ |
| Don’t include bitcode<br>Upload symbols            | 通过 Xcode 找回                                              |
| Include bitcode<br>Upload symbols                  | 通过 iTunes Connect 找回<br />通过 Xcode 找回， 需要使用 `.bcsymbolmap` 去混淆处理。 |
| Include bitcode<br>Don’t upload symbols            | 通过 Xcode 找回， 需要使用 `.bcsymbolmap` 去混淆处理。       |
| Don’t include bitcode<br>Don’t upload symbols      | 通过 Xcode 找回                                              |

##### 通过 Xcode 找回

1. `Xcode -> Window -> Organizer ` 

2. 选择 `Archives`  标签

    ![](../img/xcode_find_dsym2.png)
   
3. 找到发布的归档包，右键点击对应归档包，选择 `Show in Finder`操作

    ![](../img/xcode_find_dsym3.png)

   

4. 右键选择定位到的归档文件，选择 `显示包内容` 操作 

    ![](../img/xcode_find_dsym4.png)

   

5. 选择 `dSYMs` 目录，目录内即为下载到的 dSYM 文件

    ![](../img/xcode_find_dsym5.png)

##### 通过 iTunes Connect 找回

1. 登录[App Store Connect](https://appstoreconnect.apple.com)；
2. 进入"我的App（My Apps）"
3. 在 "App Store" 或 "TestFlight" 中选择某一个版本"，点击 "构建版本元数据（Build Metadata）" 在此页面，点击按钮 "下载dSYM（Download dSYM）" 下载 dSYM 文件

##### .bcsymbolmap 去混淆处理

在通过 Xcode 找到 dSYM 文件时，可以看到 BCSymbolMaps 目录

![](../img/BCSymbolMaps.png)


打开终端并使用以下命令进行去混淆处理

`xcrun dsymutil -symbol-map <BCSymbolMaps_path> <.dSYM_path>`



