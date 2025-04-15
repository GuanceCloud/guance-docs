# macOS Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect metrics data from various macOS applications and analyze the performance of macOS application ends in a visualized manner.

## Prerequisites

???+ warning "Note"

    If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md)

## Application Integration {#macOS-integration}

1. Go to **User Analysis > Create > macOS**;
2. Enter the application name;
3. Input the application ID;
4. Choose the application integration method:

    - Public DataWay: Directly receives RUM data without installing the DataKit collector.
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.

## Installation

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/version.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=macOS&color=brightgreen&query=$.macos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**: [https://github.com/GuanceCloud/datakit-macos/Example](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)

=== "CocoaPods"

    1. Configure the `Podfile`.
    
    ```objectivec
       target 'yourProjectName' do
    
       # Pods for your project
       pod 'FTMacOSSDK', '~>[latest_version]'
    
       end
    ```
    
    2. Run `pod install` in the `Podfile` directory to install the SDK.

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, then click the **+** under the `Packages` section.
    
    2. In the search box of the pop-up page, input `https://github.com/GuanceCloud/datakit-macos`, which is the storage location of the code.
    
    3. After Xcode successfully retrieves the package, it will display the configuration page for the SDK.
    
    `Dependency Rule`: It is recommended to choose `Up to Next Major Version`.
    
    `Add To Project`: Select the supported project.
    
    After filling in the configurations, click the `Add Package` button and wait for the loading to complete.
    
    4. In the popup `Choose Package Products for datakit-macos`, select the Target where you need to add the SDK, and click the `Add Package` button. The SDK has been added successfully at this point.
    
    If your project is managed by SPM, add FTMacOSSDK as a dependency and add `dependencies` to `Package.swift`.
    
    ```swift
      dependencies: [
        .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "[latest_version]"))
    ]
    ```

### Adding Header Files

=== "Objective-C"

    ```
    #import "FTMacOSSDK.h"
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    ```

## SDK Initialization

### Basic Configuration {#base-setting}

Since the `viewDidLoad` method of the first displayed view `NSViewController` and the `windowDidLoad` method of `NSWindowController` are called earlier than the `applicationDidFinishLaunching` method of AppDelegate, to avoid lifecycle collection anomalies for the first view, it is recommended to initialize the SDK in the `main.m` file.

=== "Objective-C"

    ```objectivec
    // main.m file
    #import "FTMacOSSDK.h"
    
    int main(int argc, const char * argv[]) {
        @autoreleasepool {
            // Local environment deployment, Datakit deployment
            FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatakitUrl:datakitUrl];
            // Use public DataWay deployment
            //FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatawayUrl:datawayUrl clientToken:clientToken];
            config.enableSDKDebugLog = YES;
            [FTSDKAgent startWithConfigOptions:config];
        }
        return NSApplicationMain(argc, argv);
    }
    ```

=== "Swift"

    Create a mian.swift file and delete @main or @NSApplicationMain in AppDelegate.swift.
    ```swift
    import Cocoa
    import FTMacOSSDK
    // Create AppDelegate and set it as delegate
    let delegate = AppDelegate()
    NSApplication.shared.delegate = delegate
    // Initialize SDK 
    let config = FTSDKConfig.init(datakitUrl: datakitUrl)
    // Use public DataWay deployment
    //let config = FTSDKConfig(datawayUrl: datawayUrl, clientToken: clientToken)
    config.enableSDKDebugLog = true
    FTSDKAgent.start(withConfigOptions: config)
    
    _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    
    ```

| **Property**          | **Type**     | **Required** | **Meaning**                                                     |
| ----------------- | ------------ | -------- | ------------------------------------------------------------ |
| datakitUrl        | NSString     | Yes      | Datakit access address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, the device with the installed SDK must be able to access this address. **Note: choose one between datakit and dataway configuration** |
| datawayUrl        | NSString     | Yes      | Public Dataway access address, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, the device with the installed SDK must be able to access this address. **Note: choose one between datakit and dataway configuration** |
| clientToken       | NSString     | Yes      | Authentication token, needs to be used together with datawayUrl                       |
| enableSDKDebugLog | BOOL         | No       | Set whether to allow printing logs. Default `NO`                              |
| env               | NSString     | No       | Set the collection environment. Default `prod`, supports customization, can also be set using the provided `FTEnv` enumeration through the `-setEnvWithType:` method |
| service           | NSString     | No       | Set the name of the business or service that belongs. Affects Log and RUM service field data. Default: `df_rum_ios` |
| globalContext     | NSDictionary | No       | Add custom tags. Refer to the rules [here](#user-global-context)   |

### RUM Configuration {#rum-config}

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

| **Property**                 | **Type**                   | **Required** | **Meaning**                     |
| ------------------------ | -------------------------- | -------- | ---------------------------- |
| appid                    | NSString                   | Yes       | User access monitoring application ID unique identifier. Corresponds to setting the RUM `appid`, only then will the `RUM` collection function be enabled, [method to obtain appid](#macOS-integration) |
| sampleRate               | int                        | No       | Sampling rate. Range [0,100], 0 means no collection, 100 means full collection, default value is 100. Scope includes all View, Action, LongTask, Error data under the same session_id |
| enableTrackAppCrash      | BOOL                       | No       | Set whether crash logs need to be collected. Default `NO` |
| enableTrackAppANR        | BOOL                       | No       | Collect ANR events where the app freezes and does not respond. Default `NO` |
| enableTrackAppFreeze     | BOOL                       | No       | Collect UI freeze events. Default `NO`       |
| enableTraceUserView      | BOOL                       | No       | Set whether to track user View operations. Default `NO` |
| enableTraceUserAction    | BOOL                       | No       | Set whether to track user Action operations. Default `NO` |
| enableTraceUserResource  | BOOL                       | No       | Set whether to track user network requests. Default `NO`, only applies to native http |
| resourceUrlHandler | FTResourceUrlHandler | No | Custom resource collection rule. Default does not filter. Returns: NO indicates to collect, YES indicates not to collect. |
| errorMonitorType         | FTErrorMonitorType         | No       | Supplementary type for error event monitoring. Adds monitored information to the collected crash data. `FTErrorMonitorBattery` for battery level, `FTErrorMonitorMemory` for memory usage, `FTErrorMonitorCpu` for CPU occupancy rate. |
| monitorFrequency         | FTMonitorFrequency         | No       | Performance monitoring sampling cycle for views       |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No       | Performance monitoring type for views. Adds corresponding monitored items to the collected **View** data. `FTDeviceMetricsMonitorMemory` monitors current application memory usage, `FTDeviceMetricsMonitorCpu` monitors CPU fluctuations, `FTDeviceMetricsMonitorFps` monitors screen frame rate. |
| globalContext            | NSDictionary               | No       | Add custom tags for user monitoring data source distinction. If tracking functionality is needed, the parameter `key` should be `track_id`, `value` should be any number, refer to the notes on adding rules [here](#user-global-context) |

### Log Configuration {#log-config}

=== "Objective-C"

    ```objective-c
        // Enable logger
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

| **Property**                | **Type**          | **Required** | **Meaning**                          |
| ----------------------- | ----------------- | -------- | --------------------------------- |
| sampleRate              | int               | No       | Sampling rate. Range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| enableCustomLog         | BOOL              | No       | Whether to upload custom logs. Default `NO` |
| logLevelFilter          | NSArray           | No       | Set the status array for the custom logs to be collected. Default collects all. |
| enableLinkRumData       | BOOL              | No       | Whether to link with RUM data. Default `NO`                                |
| discardType             | FTLogCacheDiscard | No       | Set the log discard rule when reaching the limit. Default `FTDiscard` <br/>`FTDiscard` discards appended data when log data quantity exceeds the maximum (5000). `FTDiscardOldest` discards old data when log data exceeds the maximum. |
| printCustomLogToConsole | BOOL              | No       | Set whether to output custom logs to the console. Default `NO`, refer to the [output format](#printCustomLogToConsole) for custom logs |
| globalContext           | NSDictionary      | No       | Add custom tags for logs, refer to the rules [here](#user-global-context) |

### Trace Configuration {#trace-config}

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

| Property              | Type    | Required | Meaning                        |
| ----------------- | ------- | ---- | --------------------------- |
| sampleRate        | int     | No   | Sampling rate. Range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| networkTraceType  | NS_ENUM | No   | Set the type of trace. Default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if choosing the corresponding trace type when integrating OpenTelemetry, please refer to the supported types and agent related configurations |
| enableLinkRumData | BOOL    | No   | Whether to link with RUM data. Default `NO` |
| enableAutoTrace   | BOOL    | No   | Set whether to enable automatic http trace. Default `NO`, currently only supports NSURLSession |

## RUM User Data Tracking

You can configure `FTRUMConfig` to enable automatic mode or manually add data. Rum-related data is passed via the `FTGlobalRumManager` singleton, with relevant APIs as follows:

### View

If you set `enableTraceUserView = YES` to enable automatic collection, the SDK will automatically collect the lifecycle of the Window. The window's lifecycle `-becomeKeyWindow` defines the start of the **View**, and `-resignKeyWindow` defines the end of the **View**.

The page name is set according to the priority order: `NSStringFromClass(window.contentViewController.class)` > `NSStringFromClass(window.windowController.class)` > `NSStringFromClass(window)`.

If the views within the window are very complex, you can use the following API to customize the collection.

#### Usage Method

=== "Objective-C"

    ```objective-c
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method. This method records the page loading time; if the loading time cannot be obtained, this method can be omitted.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page loading time (nanoseconds)
    -(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
    
    /// Enter the page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Event custom properties (optional)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// Leave the page
    /// - Parameter property: Event custom properties (optional)
    -(void)stopViewWithProperty:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method. This method records the page loading time; if the loading time cannot be obtained, this method can be omitted.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page loading time (ns)
    open func onCreateView(_ viewName: String, loadTime: NSNumber)
    
    /// Enter the page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Event custom properties (optional)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// Leave the page
    /// - Parameter property: Event custom properties (optional)
    open func stopView(withProperty property: [AnyHashable : Any]?)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    - (void)viewDidAppear{
      [super viewDidAppear];
      // Scenario 1:
      [[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC"];  
      
      // Scenario 2: Dynamic parameters
      [[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC" property:@{@"custom_key":@"custom_value"}];  
    }
    -(void)viewDidDisappear{
      [super viewDidDisappear];
      // Scenario 1:
      [[FTGlobalRumManager sharedManager] stopView];  
      
      // Scenario 2: Dynamic parameters
      [[FTGlobalRumManager sharedManager] stopViewWithProperty:@{@"custom_key":@"custom_value"}];
    }
    ```

=== "Swift"

    ```swift
    override func viewDidAppear() {
        super.viewDidAppear()
        // Scenario 1:
        FTExternalDataManager.shared().startView(withName: "TestVC")
        // Scenario 2: Dynamic parameters
        FTExternalDataManager.shared().startView(withName: "TestVC",property: ["custom_key":"custom_value"])
    }
    override func viewDidDisappear() {
        super.viewDidDisappear()
        // Scenario 1:
        FTGlobalRumManager.shared().stopView()
        // Scenario 2: Dynamic parameters
        FTGlobalRumManager.shared().stopView(withProperty: ["custom_key":"custom_value"])
    }
    ```

### Action

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Add an Action event
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom properties (optional)
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add an Action event
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom properties (optional)
    func addActionName(String, actionType: String, property: [AnyHashable : Any]?)
    ```
#### Code Example

=== "Objective-C"

    ```objective-c
    // Scenario 1
    [[FTGlobalRumManager sharedManager] addActionName:@"UITableViewCell click" actionType:@"click"];
    // Scenario 2: Dynamic parameters
    [[FTGlobalRumManager sharedManager]  addActionName:@"UITableViewCell click" actionType:@"click" property:@{@"custom_key":@"custom_value"}];
    ```
=== "Swift"

    ```swift
    // Scenario 1
    FTGlobalRumManager.shared().addActionName("custom_action", actionType: "click")
    // Scenario 2: Dynamic parameters
    FTGlobalRumManager.shared().addActionName("custom_action", actionType: "click",property: ["custom_key":"custom_value"])
    ```

### Error

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Add an Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    
    /// Add an Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - state: Program runtime state
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add an Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    open func addError(withType: String, message: String, stack: String, property: [AnyHashable : Any]?)
    
    /// Add an Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - state: Program runtime state
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    open func addError(withType type: String, state: FTAppState, message: String, stack: String, property: [AnyHashable : Any]?)
    ```
#### Code Example

=== "Objective-C"

    ```objectivec
    // Scenario 1
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"type" message:@"message" stack:@"stack"];
    // Scenario 2: Dynamic parameters
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"ios_crash" message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    // Scenario 3: Dynamic parameters
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"ios_crash" state:FTAppStateUnknown message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // Scenario 1
    FTGlobalRumManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack")
    // Scenario 2: Dynamic parameters
    FTGlobalRumManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack",property: ["custom_key":"custom_value"])
    // Scenario 3: Dynamic parameters       
    FTGlobalRumManager.shared().addError(withType: "custom_type", state: .unknown, message: "custom_message", stack: "custom_stack", property: ["custom_key":"custom_value"])
    ```

### LongTask

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Add a long task event
    /// - Parameters:
    ///   - stack: Long task stack
    ///   - duration: Duration of the long task (nanoseconds)
    ///   - property: Event custom properties (optional)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add a long task event
    /// - Parameters:
    ///   - stack: Long task stack
    ///   - duration: Duration of the long task (nanoseconds)
    ///   - property: Event custom properties (optional)
    func addLongTask(withStack: String, duration: NSNumber, property: [AnyHashable : Any]?)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    // Scenario 1
    [[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
    // Scenario 2: Dynamic parameters
    [[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000 property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Scenario 1
    FTGlobalRumManager.shared().addLongTask(withStack: "stack string", duration: 1000000000)
    // Scenario 2: Dynamic parameters
    FTGlobalRumManager.shared().addLongTask(withStack: "stack string", duration: 1000000000 ,property: [["custom_key":"custom_value"]])
    ```

### Resource

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Start HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// Add HTTP request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Request performance attributes
    ///   - content: Request related data
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    
    /// End HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// Start HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// End HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    open func stopResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// Add HTTP request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Request performance attributes
    ///   - content: Request related data
    open func addResource(withKey key: String, metrics: FTResourceMetricsModel?, content: FTResourceContentModel)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    #import "FTMacOSSDK.h"
    
    // Step 1: Before the request starts
    [[FTGlobalRumManager sharedManager] startResourceWithKey:key];
    
    // Step 2: When the request completes
    [[FTGlobalRumManager sharedManager] stopResourceWithKey:key];
    
    // Step 3: Assemble Resource data
    // FTResourceContentModel data
    FTResourceContentModel *content = [[FTResourceContentModel alloc]init];
    content.httpMethod = request.HTTPMethod;
    content.requestHeader = request.allHTTPHeaderFields;
    content.responseHeader = httpResponse.allHeaderFields;
    content.httpStatusCode = httpResponse.statusCode;
    content.responseBody = responseBody;
    // ios native
    content.error = error;
    
    // If time data for each stage can be obtained
    // FTResourceMetricsModel
    // For ios native, if NSURLSessionTaskMetrics data is available, use the initializer method of FTResourceMetricsModel
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
    
    // For other platforms, all time data should be in nanoseconds
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
    
    // Step 4: Add resource, pass nil for metrics if there is no time data
    [[FTGlobalRumManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    
    // Step 1: Before the request starts
    FTGlobalRumManager.shared().startResource(withKey: key)
    
    // Step 2: When the request completes
    FTGlobalRumManager.shared().stopResource(withKey: resource.key)
    
    // Step 3: Assemble Resource data
    // FTResourceContentModel
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)
    
    // If time data for each stage can be obtained
    // FTResourceMetricsModel
    // For ios native, if NSURLSessionTaskMetrics data is available, use the initializer method of FTResourceMetricsModel
    var metricsModel:FTResourceMetricsModel?
    if let metrics = resource.metrics {
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)
    }
    // For other platforms, all time data should be in nanoseconds
    metricsModel = FTResourceMetricsModel()
    ...
    
    // Step 4: Add resource, pass nil for metrics if there is no time data
    FTGlobalRumManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logger Log Printing {#user-logger}
> Currently, the log content is limited to 30 KB, and any characters exceeding this limit will be truncated.
### Usage Method

=== "Objective-C"

    ```objective-c
    //
    //  FTLogger.h
    //  FTMacOSSDK
    
    /// Add custom info logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add custom warning logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add custom error logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;
    
    /// Add custom critical logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add custom ok logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)ok:(NSString *)content property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    open class FTLogger : NSObject, FTLoggerProtocol {}
    public protocol FTLoggerProtocol : NSObjectProtocol {
    /// Add custom info logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func info(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom warning logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func warning(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom error logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func error(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom critical logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func critical(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom ok logs
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func ok(_ content: String, property: [AnyHashable : Any]?)
    }
    ```
#### Log Levels

=== "Objective-C"

    ```objective-c
    /// Event levels and statuses, default: FTStatusInfo
    typedef NS_ENUM(NSInteger, FTLogStatus) {
        /// Hint
        FTStatusInfo         = 0,
        /// Warning
        FTStatusWarning,
        /// Error
        FTStatusError,
        /// Severe
        FTStatusCritical,
        /// Recovery
        FTStatusOk,
    };
    ```
=== "Swift"

    ```swift
    /// Event levels and statuses, default: FTStatusInfo
    public enum FTLogStatus : Int, @unchecked Sendable {
        /// Hint
        case statusInfo = 0
        /// Warning
        case statusWarning = 1
        /// Error
        case statusError = 2
        /// Severe
        case statusCritical = 3
        /// Recovery
        case statusOk = 4
    }
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // Method one: Through FTSDKAgent
    // Note: Ensure the SDK is initialized successfully before use, otherwise it may fail assertion and crash in test environments.
    [[FTSDKAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // Method two: Through FTLogger (recommended)
    // If the SDK fails initialization, calling methods in FTLogger to add custom logs will fail but won't cause assertion failure or crash.
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Method one: Through FTSDKAgent
    // Note: Ensure the SDK is initialized successfully before use, otherwise it may fail assertion and crash in test environments.
    FTSDKAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // Method two: Through FTLogger (recommended)
    // If the SDK fails initialization, calling methods in FTLogger to add custom logs will fail but won't cause assertion failure or crash.
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### Custom Logs Output to Console {#printCustomLogToConsole}


Set `printCustomLogToConsole = YES` to enable outputting custom logs to the console. You will see logs in the following format in the xcode debug console:

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [MACOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`: Standard prefix for os_log output;

`[MACOS APP]`: Prefix to distinguish SDK custom log output;

`[INFO]`: Level of the custom log;

`content`: Content of the custom log;

`{K=V,...,Kn=Vn}`: Custom properties.

## Trace Network Link Tracing

You can configure `FTTraceConfig` to enable automatic mode or manually add data. Trace-related data is passed via the `FTTraceManager` singleton, with relevant APIs as follows:

#### Usage Method

=== "Objective-C"

    ```objective-c
    // FTTraceManager.h
    
    /// Get the trace request header parameters
    /// - Parameters:
    ///   - key: Unique identifier for a specific request
    ///   - url: Request URL
    /// - Returns: Dictionary of trace request header parameters
    - (NSDictionary *)getTraceHeaderWithKey:(NSString *)key url:(NSURL *)url;
    ```

=== "Swift"

    ```swift
    /// Get the trace request header parameters
    /// - Parameters:
    ///   - key: Unique identifier for a specific request
    ///   - url: Request URL
    /// - Returns: Dictionary of trace request header parameters
    open func getTraceHeader(withKey key: String, url: URL) -> [AnyHashable : Any]
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    NSString *key = [[NSUUID UUID]UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://wwwbaidu.com"];
    // Manual operation required: Get traceHeader before the request and add it to the request headers
    NSDictionary *traceHeader = [[FTTraceManager sharedInstance] getTraceHeaderWithKey:key url:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (traceHeader && traceHeader.allKeys.count>0) {
        [traceHeader enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [request setValue:value forHTTPHeaderField:field];
        }];
    }
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       // Your code
    }];
    
    [task resume];
    ```

=== "Swift"

    ```swift
    let url:URL = NSURL.init(string: "https://www.baidu.com")! as URL
    if let traceHeader = FTTraceManager.sharedInstance().getTraceHeader(withKey: NSUUID().uuidString, url: url) {
         let request = NSMutableURLRequest(url: url)
         // Manual operation required: Get traceHeader before the request and add it to the request headers
         for (a,b) in traceHeader {
             request.setValue(b as? String, forHTTPHeaderField: a as! String)
         }
         let task = URLSession.shared.dataTask(with: request as URLRequest) {  data,  response,  error in
            // Your code
         }
         task.resume()
    }
    ```

## User Binding and Logout
### Usage Method

=== "Objective-C"

    ```objectivec
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  User ID
    ///   - userName: User name (optional)
    ///   - userEmail: User email (optional)
    ///   - extra: Additional user information (optional)
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail extra:(nullable NSDictionary *)extra;
    
    /// Unbind current user
    - (void)unbindUser;
    ```

=== "Swift"

    ```swift
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  User ID
    ///   - userName: User name (optional)
    ///   - userEmail: User email (optional)
    ///   - extra: Additional user information (optional)
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)
    
    /// Unbind current user
    open func unbindUser()
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // You can call this method after a successful user login to bind user information
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // You can call this method after the user logs out to unbind user information
    [[FTSDKAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // You can call this method after a successful user login to bind user information
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // You can call this method after the user logs out to unbind user information
    FTSDKAgent.sharedInstance().unbindUser()
    ```

## Shut Down SDK

Use `FTSDKAgent` to shut down the SDK.

### Usage Method

=== "Objective-C"

    ```objective-c
    /// Close running objects within the SDK
    - (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// Close running objects within the SDK
    func shutDown()
    ```
### Code Example

=== "Objective-C"

    ```objective-c
    // If you dynamically change the SDK configuration, you need to close it first to avoid generating incorrect data
    [[FTSDKAgent sharedInstance] shutDown];
    ```  

=== "Swift"

    ```swift
    // If you dynamically change the SDK configuration, you need to close it first to avoid generating incorrect data
    FTSDKAgent.sharedInstance().shutDown()
    ```
## Add Custom Tags {#user-global-context}

### Static Use

You can create multiple Configurations and use preprocessor directives to set values:

1. Create multiple Configurations:

![](../img/image_9.png)

2. Set preset attributes to distinguish different Configurations:

![](../img/image_10.png)

3. Use preprocessor directives:

```objectivec
// Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS configure preset definitions
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
... // other setting operations
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

### Dynamic Use

Since globalContext settings made after RUM starts will not take effect, users can save them locally and set them during the next app launch.

1. Save files locally using, for example, `NSUserDefaults`, and configure the `SDK`. Add code to obtain tag data at the configuration location.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... // other setting operations
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. Add methods to change file data anywhere.

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. Restart the application for the changes to take effect.

### Notes

1. Special key: track_id (configured in RUM for tracking functionality)

2. When users add custom tags via globalContext that conflict with SDK's own tags, the SDK's tags will override the user's settings. It is recommended to prefix tag names with project abbreviations, such as `df_tag_name`.

3. The globalContext must be set before calling the -startRumWithConfigOptions method to take effect.

4. Custom tags configured in `FTSDKConfig` will be added to all types of data.

> For more detailed information, refer to the [SDK Demo](https://github.com/GuanceCloud/datakit-macos/tree/development/Example).

## Frequently Asked Questions {#FAQ}

### [About Crash Log Analysis](../ios/app-access.md#crash-log-analysis)

### Error Occurs: Include of non-modular header inside framework module

Because the .h files in the SDK import dependent library .h files, you need to set

`Target` -> `Build Settings` -> `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` to YES.