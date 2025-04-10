# macOS Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect various macOS application Metrics data and analyze the performance of macOS applications in a visualized manner.

## Prerequisites

???+ warning "Note"

    If you have already activated the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md)

## Application Integration {#macOS-integration}

1. Enter **User Access Monitoring > Create > macOS**;
2. Input the application name;
3. Input the application ID;
4. Select the application integration method:

    - Public DataWay: Directly receives RUM data without installing the DataKit collector.
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.

## Installation

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/version.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=macOS&color=brightgreen&query=$.macos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**: [https://github.com/GuanceCloud/datakit-macos/Example](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)

=== "CocoaPods"

    1. Configure the `Podfile` file.
    
    ```objectivec
       target 'yourProjectName' do
    
       # Pods for your project
       pod 'FTMacOSSDK', '~>[latest_version]'
    
       end
    ```
    
    2.Execute `pod install` in the `Podfile` directory to install the SDK.

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, click **+** under the `Packages` section.
    
    2. In the search box of the pop-up page, input `https://github.com/GuanceCloud/datakit-macos`, which is the storage location of the code.
    
    3. After Xcode successfully retrieves the package, it will display the configuration page of the SDK.
    
    `Dependency Rule`: It's recommended to select `Up to Next Major Version`.
    
    `Add To Project`: Choose the supported project.
    
    After filling out the configuration, click the `Add Package` button and wait for the loading to complete.
    
    4. If your project is managed by SPM, add FTMacOSSDK as a dependency, adding `dependencies` to `Package.swift`.
    
    ```swift
      dependencies: [
        .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "[latest_version]"))
    ]
    ```

### Add Header Files

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

Since the `viewDidLoad` method of the first displayed `NSViewController` and the `windowDidLoad` method of `NSWindowController` are called earlier than the `applicationDidFinishLaunching` method of AppDelegate, to avoid lifecycle collection anomalies of the first view, it is recommended to initialize the SDK in the `main.m` file.

=== "Objective-C"

    ```objectivec
    // main.m file
    #import "FTMacOSSDK.h"
    
    int main(int argc, const char * argv[]) {
        @autoreleasepool {
            // Local environment deployment, Datakit deployment
            FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatakitUrl:datakitUrl];
            // Using public DataWay deployment
            //FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatawayUrl:datawayUrl clientToken:clientToken];
            config.enableSDKDebugLog = YES;
            [FTSDKAgent startWithConfigOptions:config];
        }
        return NSApplicationMain(argc, argv);
    }
    ```

=== "Swift"

    Create mian.swift file, delete @main or @NSApplicationMain in AppDelegate.swift
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

| **Property**          | **Type**     | **Required** | **Meaning**                 | Note                                                         |
| ----------------- | ------------ | -------- | ------------------------ | ------------------------------------------------------------ |
| datakitUrl        | NSString     | Yes      | Datakit access address         | Datakit access URL address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, note: the device where SDK is installed must be able to access this address. **Note: Either datakit or dataway configuration should be selected** |
| datawayUrl        | NSString     | Yes      | Public Dataway access address    | Dataway access URL address, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, note: the device where SDK is installed must be able to access this address. **Note: Either datakit or dataway configuration should be selected** |
| clientToken       | NSString     | Yes      | Authentication token               | Must be used together with datawayUrl                                   |
| enableSDKDebugLog | BOOL         | No       | Set whether to allow printing logs     | Default `NO`                                                    |
| env               | NSString     | No       | Set the collection environment             | Default `prod`, supports customization, can also be set via the `-setEnvWithType:` method provided by `FTEnv`<br/>`FTEnv`<br/>`FTEnvProd`： prod<br/>`FTEnvGray`： gray<br/>`FTEnvPre` ：pre <br/>`FTEnvCommon` ：common <br/>`FTEnvLocal`： local |
| service           | NSString     | No       | Set the name of the business or service | Affects the `service` field data in Logs and RUM. Default: `df_rum_macos`    |
| globalContext     | NSDictionary | No       | Add custom tags           | Please refer to [here](#user-global-context) for the addition rules                   |

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

| **Property**                 | **Type**                   | **Required** | **Meaning**                     | Note                                                         |
| ------------------------ | -------------------------- | -------- | ---------------------------- | ------------------------------------------------------------ |
| appid                    | NSString                   | Yes       | User access monitoring application ID unique identifier | Corresponds to setting RUM `appid`, only then will the `RUM` collection function be activated, [how to obtain appid](#macOS-integration) |
| sampleRate               | int                        | No       | Sampling rate                   | Value range [0,100], 0 means no collection, 100 means full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id                 |
| enableTrackAppCrash      | BOOL                       | No       | Set whether to collect crash logs     | Default `NO`                                                    |
| enableTrackAppANR        | BOOL                       | No       | Collect ANR unresponsive events        | Default `NO`                                                    |
| enableTrackAppFreeze     | BOOL                       | No       | Collect UI freeze events               | Default `NO`                                                    |
| enableTraceUserView      | BOOL                       | No       | Set whether to trace user View operations   | Default `NO`                                                    |
| enableTraceUserAction    | BOOL                       | No       | Set whether to trace user Action operations | Default `NO`                                                    |
| enableTraceUserResource  | BOOL                       | No       | Set whether to trace user network requests     | Default `NO`, only applicable to native http                               |
| resourceUrlHandler | FTResourceUrlHandler | No | Custom rule for collecting resources | Default does not filter. Returns: NO means to collect, YES means not to collect. |
| errorMonitorType         | FTErrorMonitorType         | No       | Supplementary type for error event monitoring         | Additional information added to collected crash data.<br/>`FTErrorMonitorType`<br/>`FTErrorMonitorAll`： Enable all monitoring items: battery, memory, CPU usage<br/>`FTErrorMonitorBattery`： Battery level<br/>`FTErrorMonitorMemory`： Total memory, memory usage<br/>`FTErrorMonitorCpu`： CPU usage |
| monitorFrequency         | FTMonitorFrequency         | No       | Sampling cycle for view performance monitoring       | Configure `monitorFrequency` to set the sampling cycle for **View** monitoring item information.<br/>`FTMonitorFrequency`<br/>`FTMonitorFrequencyDefault`：500ms (default)<br/>`FTMonitorFrequencyFrequent`：100ms<br/>`FTMonitorFrequencyRare`：1000ms |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No       | Type of view performance monitoring           | Add corresponding monitoring items information to collected **View** data.<br/>`FTDeviceMetricsMonitorType`<br/>`FTDeviceMetricsMonitorAll`： Enable all monitoring items: memory, CPU, FPS<br/>`FTDeviceMetricsMonitorMemory`： Average memory, maximum memory<br/>`FTDeviceMetricsMonitorCpu`： Maximum CPU fluctuation, average number |
| globalContext            | NSDictionary               | No       | Add custom tags               | Please refer to [here](#user-global-context) for the addition rules                   |

### Log Configuration {#log-config}

=== "Objective-C"

    ```objective-c
        //Enable logger
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

| **Property**                | **Type**          | **Required** | **Meaning**                          | Note                                                         |
| ----------------------- | ----------------- | -------- | --------------------------------- | ------------------------------------------------------------ |
| sampleRate              | int               | No       | Sampling rate                        | Value range [0,100], 0 means no collection, 100 means full collection, default value is 100.                   |
| enableCustomLog         | BOOL              | No       | Whether to upload custom logs                | Default `NO`                                                     |
| logLevelFilter          | NSArray           | No       | Set the status array of custom logs to be collected | Default full collection                                                   |
| enableLinkRumData       | BOOL              | No       | Whether to associate with RUM data               | Default `NO`                                                     |
| discardType             | FTLogCacheDiscard | No       | Set frequent log discard rules              | Default `FTDiscard` <br/>`FTLogCacheDiscard`:<br/>`FTDiscard`： Default, when the number of log data exceeds the maximum value (5000), discard appended data<br/>`FTDiscardOldest`： When the number of log data exceeds the maximum value, discard old data |
| printCustomLogToConsole | BOOL              | No       | Set whether to print custom logs to the console  | Default `NO`<br/> Refer to [output format](#printCustomLogToConsole) for custom logs  |
| globalContext           | NSDictionary      | No       | Add custom tags                    | Please refer to [here](#user-global-context) for the addition rules                   |

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

| Property              | Type    | Required | Meaning                        | Note                                                         |
| ----------------- | ------- | ---- | --------------------------- | ------------------------------------------------------------ |
| sampleRate        | int     | No   | Sampling rate                  | Value range [0,100], 0 means no collection, 100 means full collection, default value is 100.                  |
| networkTraceType  | NS_ENUM | No   | Set the type of link tracing          | Default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C). When choosing the corresponding trace type for OpenTelemetry integration, please refer to supported types and agent configurations |
| enableLinkRumData | BOOL    | No   | Whether to associate with RUM data         | Default `NO`                                                     |
| enableAutoTrace   | BOOL    | No   | Set whether to enable automatic http trace | Default `NO`, currently only supports NSURLSession                            |

## RUM User Data Tracking

You can configure `FTRUMConfig` to enable automatic mode or manually add tracking. Related RUM data is passed through the singleton `FTGlobalRumManager`. Relevant APIs are as follows:

### View

If you set `enableTraceUserView = YES` to enable automatic collection, the SDK will automatically collect the lifecycle of the Window. The lifecycle of the window `-becomeKeyWindow` defines the start of the **View**, and `-resignKeyWindow` defines the end of the **View**.

The page name is set in the priority order of `NSStringFromClass(window.contentViewController.class)` > `NSStringFromClass(window.windowController.class)` > `NSStringFromClass(window)`.

If the views within the window are very complex, you can use the following API to customize the collection.

#### Usage Method

=== "Objective-C"

    ```objective-c
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method. This method records the page loading time. If unable to get the loading time, this method can be skipped.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page loading time (in nanoseconds)
    -(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
    
    /// Enter the page
    ///
    /// - Parameters:
    ///  - viewName: Page name
    -(void)startViewWithName:(NSString *)viewName;
    
    /// Enter the page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Event custom properties (optional)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// Leave the page
    -(void)stopView;
    
    /// Leave the page
    /// - Parameter property: Event custom properties (optional)
    -(void)stopViewWithProperty:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method. This method records the page loading time. If unable to get the loading time, this method can be skipped.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page loading time (in nanoseconds)
    open func onCreateView(_ viewName: String, loadTime: NSNumber)
    
    /// Enter the page
    ///
    /// - Parameters:
    ///  - viewName: Page name
    open func startView(withName viewName: String)
    
    /// Enter the page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Event custom properties (optional)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// Leave the page
    open func stopView() 
    
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
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType;
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
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    func addActionName(String, actionType: String)
    
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
    ///
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
    
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
    ///   - state: Program running state
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add an Error event
    ///
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    open func addError(withType: String, message: String, stack: String)
    
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
    ///   - state: Program running state
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
    /// Add a freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
    
    /// Add a freeze event
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Event custom properties (optional)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add a freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    func addLongTask(withStack: String, duration: NSNumber)
    
    /// Add a freeze event
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
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
    /// HTTP request starts
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)startResourceWithKey:(NSString *)key;
    /// HTTP request starts
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// HTTP add request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Request related performance attributes
    ///   - content: Request related data
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    /// HTTP request ends
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)stopResourceWithKey:(NSString *)key;
    /// HTTP request ends
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// HTTP request starts
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func startResource(withKey key: String)
    
    /// HTTP request starts
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// HTTP request ends
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func stopResource(withKey key: String)
    
    /// HTTP request ends
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    open func stopResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// HTTP add request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Request related performance attributes
    ///   - content: Request related data
    open func addResource(withKey key: String, metrics: FTResourceMetricsModel?, content: FTResourceContentModel)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    #import "FTMacOSSDK.h"
    
    //Step one: Before the request starts
    [[FTGlobalRumManager sharedManager] startResourceWithKey:key];
    
    //Step two: Request completed
    [[FTGlobalRumManager sharedManager] stopResourceWithKey:key];
    
    //Step three: Concatenate Resource data
    //FTResourceContentModel data
    FTResourceContentModel *content = [[FTResourceContentModel alloc]init];
    content.httpMethod = request.HTTPMethod;
    content.requestHeader = request.allHTTPHeaderFields;
    content.responseHeader = httpResponse.allHeaderFields;
    content.httpStatusCode = httpResponse.statusCode;
    content.responseBody = responseBody;
    //ios native
    content.error = error;
    
    //If able to get time data for each phase 
    //FTResourceMetricsModel
    //ios native gets NSURLSessionTaskMetrics data and directly uses FTResourceMetricsModel's initialization method
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
    
    //Other platforms All time data in nanoseconds
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
    
    //Fourth step: add resource if no time data metrics pass nil
    [[FTGlobalRumManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    
    //Step one: Before the request starts
    FTGlobalRumManager.shared().startResource(withKey: key)
    
    //Step two: Request completed
    FTGlobalRumManager.shared().stopResource(withKey: resource.key)
    
    //Step three: ① Concatenate Resource data
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)
    
    //② If able to get time data for each phase 
    //FTResourceMetricsModel
    //ios native gets NSURLSessionTaskMetrics data and directly uses FTResourceMetricsModel's initialization method
    var metricsModel:FTResourceMetricsModel?
    if let metrics = resource.metrics {
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)
    }
    //Other platforms All time data in nanoseconds
    metricsModel = FTResourceMetricsModel()
    ...
    
    //Fourth step: add resource if no time data metrics pass nil
    FTGlobalRumManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logger Log Printing {#user-logger}
> Currently, log content is limited to 30 KB, exceeding characters will be truncated.
### Usage Method

=== "Objective-C"

    ```objectivec
    //  FTSDKAgent.h
    //  FTMacOSSDK
    
    /// Log reporting
    /// @param content Log content, can be json string
    /// @param status Event level and status
    -(void)logging:(NSString *)content status:(FTStatus)status;
    
    /// Log reporting
    /// @param content Log content, can be json string
    /// @param status Event level and status
    /// @param property Event attributes
    -(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;
    ```
    
    ```objective-c
    //
    //  FTLogger.h
    //  FTMacOSSDK
    
    /// Add info type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add warning type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add error type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;
    
    /// Add critical type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add ok type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    -(void)ok:(NSString *)content property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    open class FTSDKAgent : NSObject {
    /// Add custom log
    ///
    /// - Parameters:
    ///   - content: Log content, can be json string
    ///   - status: Event level and status
    open func logging(_ content: String, status: FTLogStatus)
    
    /// Add custom log
    /// - Parameters:
    ///   - content: Log content, can be json string
    ///   - status: Event level and status
    ///   - property: Event custom attributes (optional)
    open func logging(_ content: String, status: FTLogStatus, property: [AnyHashable : Any]?)
    }
    ```
    
    ```swift
    open class FTLogger : NSObject, FTLoggerProtocol {}
    public protocol FTLoggerProtocol : NSObjectProtocol {
    /// Add info type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    optional func info(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add warning type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    optional func warning(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add error type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    optional func error(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add critical type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    optional func critical(_ content: String,```swift
    property: [AnyHashable : Any]?)
    
    /// Add ok type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom attributes (optional)
    optional func ok(_ content: String, property: [AnyHashable : Any]?)
    }
    ```
#### Log Levels

=== "Objective-C"

    ```objective-c
    /// Event level and status, default: FTStatusInfo
    typedef NS_ENUM(NSInteger, FTLogStatus) {
        /// Prompt
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
    /// Event level and status, default: FTStatusInfo
    public enum FTLogStatus : Int, @unchecked Sendable {
        /// Prompt
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
    // Note: Ensure the SDK is initialized successfully when used; otherwise, it will fail assertions and crash in the test environment.
    [[FTSDKAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // Method two: Through FTLogger (recommended)
    // If the SDK initialization fails, calling methods in FTLogger to add custom logs will fail but won't cause assertion failures or crashes.
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Method one: Through FTSDKAgent
    // Note: Ensure the SDK is initialized successfully when used; otherwise, it will fail assertions and crash in the test environment.
    FTSDKAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // Method two: Through FTLogger (recommended)
    // If the SDK initialization fails, calling methods in FTLogger to add custom logs will fail but won't cause assertion failures or crashes.
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### Custom Logs Output to Console {#printCustomLogToConsole}

Set `printCustomLogToConsole = YES` to enable outputting custom logs to the console. You will see the following format of logs in the xcode debugging console:

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [MACOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`: Standard prefix for os_log log output;

`[MACOS APP]`: Prefix used to distinguish SDK output custom logs;

`[INFO]`: Custom log level;

`content`: Custom log content;

`{K=V,...,Kn=Vn}`: Custom attributes.

## Trace Network Link Tracking

You can configure `FTTraceConfig` to enable automatic mode or manually add tracking. Related Trace data is passed through the singleton `FTTraceManager`. Relevant APIs are as follows:

#### Usage Method

=== "Objective-C"

    ```objective-c
    // FTTraceManager.h
    
    /// Get trace request header parameters
    /// - Parameters:
    ///   - key: A unique identifier that determines a particular request
    ///   - url: Request URL
    /// - Returns: Dictionary of trace request header parameters
    - (NSDictionary *)getTraceHeaderWithKey:(NSString *)key url:(NSURL *)url;
    ```

=== "Swift"

    ```swift
    /// Get trace request header parameters
    /// - Parameters:
    ///   - key: A unique identifier that determines a particular request
    ///   - url: Request URL
    /// - Returns: Dictionary of trace request header parameters
    open func getTraceHeader(withKey key: String, url: URL) -> [AnyHashable : Any]
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    NSString *key = [[NSUUID UUID]UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    // Manual operation needed: Get traceHeader before the request and add it to the request header
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
         // Manual operation needed: Get traceHeader before the request and add it to the request header
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
    - (void)bindUserWithUserID:(NSString *)userId;
    
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  User ID
    ///   - userName: User name
    ///   - userEmailL: User email
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail;
    
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  User ID
    ///   - userName: User name
    ///   - userEmail: User email
    ///   - extra: Additional user information
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
    open func bindUser(withUserID userId: String)
    
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  User ID
    ///   - userName: User name
    ///   - userEmailL: User email
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?)
       
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  User ID
    ///   - userName: User name
    ///   - userEmail: User email
    ///   - extra: Additional user information
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)
    
    /// Unbind current user
    open func unbindUser()
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // Call this method after successful user login to bind user information
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // Call this method after user logout to unbind user information
    [[FTSDKAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // Call this method after successful user login to bind user information
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // Call this method after user logout to unbind user information
    FTSDKAgent.sharedInstance().unbindUser()
    ```

## Shut Down SDK

Use `FTSDKAgent` to shut down the SDK.

### Usage Method

=== "Objective-C"

    ```objective-c
    /// Shut down running objects within the SDK
    - (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// Shut down running objects within the SDK
    func shutDown()
    ```
### Code Example

=== "Objective-C"

    ```objective-c
    // If dynamically changing the SDK configuration, you need to shut it down first to avoid incorrect data generation
    [[FTSDKAgent sharedInstance] shutDown];
    ```  

=== "Swift"

    ```swift
    // If dynamically changing the SDK configuration, you need to shut it down first to avoid incorrect data generation
    FTSDKAgent.sharedInstance().shutDown()
    ```
## Adding Custom Tags {#user-global-context}

### Static Usage

You can create multiple Configurations and use preprocessor directives to set values:

1. Create multiple Configurations:

![](../img/image_9.png)

2. Set predefined properties to differentiate different Configurations:

![](../img/image_10.png)

3. Use preprocessor directives:

```objectivec
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS Configure predefined definitions
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
... // Other setup operations
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

### Dynamic Usage

Since the globalContext set after RUM starts will not take effect, users can save it locally themselves and set it during the next app launch to make it effective.

1. Save files locally using, for example, `NSUserDefaults`, configure and use the `SDK`, and add code to obtain tag data in the configuration section.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... // Other setup operations
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. Add methods to change file data at any point.

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. Finally, restart the application to take effect.

### Notes

1. Special key: track_id (configured in RUM for tracking functionality)  

2. When users add custom tags via globalContext that conflict with the SDK's own tags, the SDK's tags will override the user settings. It is recommended to prefix tag names with project abbreviations, such as `df_tag_name`.

3. Set globalContext before calling the -startRumWithConfigOptions method to activate RUM.

4. Custom tags configured in `FTSDKConfig` will be added to all types of data.

> For more detailed details, refer to [SDK Demo](https://github.com/GuanceCloud/datakit-macos/tree/development/Example).

## Common Issues {#FAQ}

### [Crash Log Analysis](../ios/app-access.md#crash-log-analysis)

### Non-modular Header Included Inside Framework Module Error Appears

Because the .h files in the SDK import dependency library .h files, the setting needs to be made:

`Target` -> `Build Settings` -> `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` Set to YES.