# macOS Application Access

---

## Overview

Guance Real User Monitoring can analyze the performance of each macOS application in a visual way by collecting the metrics data of each macOS application.

## Precondition

- Installing DataKit ([DataKit Installation Documentation](... /... /datakit/datakit-install.md))

## macOS Application Access {#macOS-integration}

Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

- Application Name (required): The name of the application used to identify the current implementation of user access monitoring.
- Application ID (required): The unique identification of the application in the current workspace, which is used for SDK data collection and upload matching, and corresponds to the field: app_id after data entry. This field only supports English, numeric, underscore input, up to 48 characters.

![](../img/image_14.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/macos/version.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.guance.com/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=macOS&color=brightgreen&query=$.macos_api_support&uri=https://static.guance.com/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) 

**Source Code Address**：[https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**：[https://github.com/GuanceCloud/datakit-macos/Example](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)

=== "CocoaPods"

    1.Configure the `Podfile` file.
    
    ```objectivec
       target 'yourProjectName' do
    
       # Pods for your project
       pod 'FTMacOSSDK', '~>[latest_version]'
    
       end
    ```
    
    2.Run `pod install` in the `Podfile` directory to install the SDK.

=== "Swift Package Manager"

    1.Select `PROJECT` -> `Package Dependency` ，Click **+** under 'Packages'.
    
    2.Enter `https://github.com/GuanceCloud/datakit-macos` in the search box on the page that pops up.
    
    3.After Xcode successfully obtains the package, the SDK configuration page is displayed.
    
    `Dependency Rule` ：suggest you to choose `Up to Next Major Version` .
    
    `Add To Project` ：Select a supported project.
    
    Click the 'Add Package' button and wait for the load to complete.
    
    4.In the pop-up window `Choose Package Products for datakit-macos` ,select the Target that needs to Add the SDK and click the' Add Package 'button. At this time, the SDK has been added successfully.
    
    If your project is managed by SPM, add the SDK as a dependency and add 'dependencies' to 'Package.swift'.
    
    ```swift
      dependencies: [
        .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "[latest_version]"))
    ]
    ```

### Add Header File

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

The `-viewDidLoad` method of `NSViewController` and `-windowDidLoad` method of `NSWindowController` are called earlier than AppDelegate `-applicationDidFinishLaunching `.To avoid life cycle collection exceptions for the first view, it is recommended to initialize the SDK in the main.m file.

=== "Objective-C"

    ```objectivec
    // main.m 
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

=== "Swift"

    create mian.swift file，deleate `@main` or `@NSApplicationMain` in `AppDelegate.swift` file.
    ```swift
    import Cocoa
    import FTMacOSSDK
    
    let delegate = AppDelegate()
    NSApplication.shared.delegate = delegate
    // Installation SDK 
    let config = FTSDKConfig.init(metricsUrl: "YOUR_ACCESS_SERVER_URL")
    config.enableSDKDebugLog = true
    FTSDKAgent.start(withConfigOptions: config)
    
    _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    
    ```

| **Fields**        | **Type**     | **Required** | **Meaning**                     | Attention                                                    |
| ----------------- | ------------ | ------------ | ------------------------------- | ------------------------------------------------------------ |
| metricsUrl        | NSString     | Yes          | Datakit installation address    | The url of the datakit installation address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed |
| enableSDKDebugLog | BOOL         | No           | Whether to turn on debug mode   | Default is `NO`, enable to print SDK run log                 |
| env               | NSString     | No           | Set the acquisition environment | Default `prod`, support for custom. It can also be set using the `-setEnvWithType:` method based on the 'FTEnv' enumeration.<br/>`FTEnv`<br/>`FTEnvGray`： gray<br/>`FTEnvPre` ：pre <br/>`FTEnvCommon` ：common <br/>`FTEnvLocal`： local |
| service           | NSString     | No           | Set Service Name                | Impact the service field data in Log and RUM, which is set to `df_rum_macos` by default. |
| globalContext     | NSDictionary | No           | Add SDK global properties       | Adding rules can be found [here](#user-global-context)       |

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

| **Fields**               | **Type**                   | **Required** | **Meaning**                                   | Attention                                                    |
| ------------------------ | -------------------------- | ------------ | --------------------------------------------- | ------------------------------------------------------------ |
| appid                    | NSString                   | Yes          | Set `Rum AppId`                               | Corresponding to setting RUM `appid` to enable `RUM` collection, [get appid method](#macOS-integration) |
| sampleRate               | int                        | No           | Set acquisition rate                          | The collection rate ranges from >= 0 to <= 100. The default value is 100 |
| enableTrackAppCrash      | BOOL                       | No           | Set whether crash need to be collected        | Default `NO`                                                 |
| enableTrackAppANR        | BOOL                       | No           | Collect ANR stuck unresponsive events         | Default `NO`                                                 |
| enableTrackAppFreeze     | BOOL                       | No           | Collect UI jamming events                     | Default `NO`                                                 |
| enableTraceUserView      | BOOL                       | No           | Set whether to track user View actions        | Default `NO`                                                 |
| enableTraceUserAction    | BOOL                       | No           | Set whether to track user Action actions      | Default `NO`                                                 |
| enableTraceUserResource  | BOOL                       | No           | Set whether to track user network requests    | Default `NO`                                                 |
| errorMonitorType         | FTErrorMonitorType         | No           | Error Event Monitoring Supplementary Type     | Add monitoring information to the collected crash data.<br/>`FTErrorMonitorType`<br/>`FTErrorMonitorAll`：all<br/>`FTErrorMonitorBattery`：battery power<br/>`FTErrorMonitorMemory`：total memory, memory usage<br/>`FTErrorMonitorCpu`：CPU usage |
| monitorFrequency         | FTMonitorFrequency         | No           | View's Performance Monitoring Sampling Period | Configure 'monitorFrequency' to set the sampling period for **View** monitor information.<br/>`FTMonitorFrequency`<br/>`FTMonitorFrequencyDefault`：500ms (default)<br/>`FTMonitorFrequencyFrequent`：100ms<br/>`FTMonitorFrequencyRare`：1000m |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No           | The performance monitoring type of the view   | Add the monitoring item information to the collected **View** data。<br/>`FTDeviceMetricsMonitorType`<br/>`FTDeviceMetricsMonitorAll`:all<br/>`FTDeviceMetricsMonitorMemory`:average memory, maximum memory<br/>`FTDeviceMetricsMonitorCpu`：The maximum and average number of CPU ticks |
| globalContext            | NSDictionary               | No           | Add Rum global properties                     | Adding rules can be found [here](#user-global-context)       |

### Log Configuration {#log-config}

=== "Objective-C"

    ```objective-c
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

| **Fields**        | **Type**          | **Required**                                 | **Meaning**                                       | Attention |
| --- | --- | --- | --- | --- |
| samplerate | int | No | Set acquisition rate | The collection rate ranges from >= 0 to <= 100. The default value is 100 |
| enableCustomLog | BOOL | No | Whether to upload custom logs | Default `NO` |
| printCustomLogToConsole | BOOL | No | Sets whether to output custom logs to the console | Default `NO`<br/>Custom log [print format](#printCustomLogToConsole) |
| logLevelFilter | NSArray | No | Set the state array of the custom logs to be collected | Default full collection |
| enableLinkRumData | BOOL | No | Whether to associate logger data with rum | Default `NO` |
| discardType | FTLogCacheDiscard | No (the latest data is discarded by default) | Setting the log deprecation policy | Default `FTDiscard` <br/>`FTLogCacheDiscard`:<br/>`FTDiscard`：Default，When the number of log data exceeds the maximum value (5000), the appended data is discarded<br/>`FTDiscardOldest`：When the log data exceeds the maximum value, the old data is discarded |
| globalContext | NSDictionary |   No | Add log global properties | Adding rules can be found [here](#user-global-context) |

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

| **Fields**        | **Type**          | **Required**                                 | **Meaning**                                       | Attention |
| --- | --- | --- | --- | --- |
| samplerate | int | No | Set acquisition rate | The collection rate ranges from >= 0 to <= 100. The default value is 100 |
| enableCustomLog | BOOL | No | Whether to upload custom logs | Default `NO` |
| printCustomLogToConsole | BOOL | No | Sets whether to output custom logs to the console | Default `NO`<br/>Custom log [print format](#printCustomLogToConsole) |
| logLevelFilter | NSArray | No | Set the state array of the custom logs to be collected | Default full collection |
| enableLinkRumData | BOOL | No | Whether to associate logger data with rum | Default `NO` |
| discardType | FTLogCacheDiscard | No (the latest data is discarded by default) | Setting the log deprecation policy | Default `FTDiscard` <br/>`FTLogCacheDiscard`:<br/>`FTDiscard`：Default，When the number of log data exceeds the maximum value (5000), the appended data is discarded<br/>`FTDiscardOldest`：When the log data exceeds the maximum value, the old data is discarded |
| globalContext | NSDictionary |   No | Add log global properties | Adding rules can be found [here](#user-global-context) |

## RUM {#rum}

You can configure `FTRUMConfig` to enable automatic mode or add it manually. Rum related data can be passed in through the `FTGlobalRumManager` singleton with the following API.

### View

If you set `enableTraceUserView = YES` to enable automatic collection, the SDK will automatically collect the life cycle of the Window. The life cycle of the window `-becomeKeyWindow` defines the beginning of **View**, and `-resignKeyWindow` defines the end of **View**.

The view name is set in the order of  `NSStringFromClass(window.contentViewController.class)` > `NSStringFromClass(window.windowController.class)` > `NSStringFromClass(window)` .

If the views inside the window is  complex, you can use the following API to customize the capture。

### Method

=== "Objective-C"

    ```objective-c
    /// Create View
    ///
    /// Called before the '-startViewWithName' method, which is used to record the loading time of the page. If the loading time cannot be obtained, this method may not be called.
    /// - Parameters:
    ///  - viewName: Current View Name
    ///  - loadTime: The loading time of this view（ns）
    -(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
    
    /// view start
    ///
    /// - Parameters:
    ///  - viewName: Current View Name
    -(void)startViewWithName:(NSString *)viewName;
    
    /// view start
    /// - Parameters:
    ///  - viewName: Current View Name
    ///  - property: Extra Property (optional)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// view stop
    -(void)stopView;
    
    /// view stop
    /// - Parameter property: Extra Property (optional)
    -(void)stopViewWithProperty:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Create View
    ///
    /// Called before the '-startViewWithName' method, which is used to record the loading time of the page. If the loading time cannot be obtained, this method may not be called.
    /// - Parameters:
    ///  - viewName: Current View Name
    ///  - loadTime: The loading time of this view （ns）
    open func onCreateView(_ viewName: String, loadTime: NSNumber)
    
    /// view start
    ///
    /// - Parameters:
    ///  - viewName: Current View Name
    open func startView(withName viewName: String)
    
    /// view start
    /// - Parameters:
    ///  - viewName: Current View Name
    ///  - property: Extra Property (optional)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// view stop
    open func stopView() 
    
    /// view stop
    /// - Parameter property: Extra Property (optional)
    open func stopView(withProperty property: [AnyHashable : Any]?)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    - (void)viewDidAppear{
      [super viewDidAppear];
      // Scene 1：
      [[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC"];  
      
      // Secne 2：  extra property
      [[FTGlobalRumManager sharedManager] startViewWithName:@"TestVC" property:@{@"custom_key":@"custom_value"}];  
    }
    -(void)viewDidDisappear{
      [super viewDidDisappear];
      // Scene 1：
      [[FTGlobalRumManager sharedManager] stopView];  
      
      // Secne 2：  extra property
      [[FTGlobalRumManager sharedManager] stopViewWithProperty:@{@"custom_key":@"custom_value"}];
    }
    ```

=== "Swift"

    ```swift
    override func viewDidAppear() {
        super.viewDidAppear()
        // Scene 1：
        FTExternalDataManager.shared().startView(withName: "TestVC")
        // Secne 2：  extra property
        FTExternalDataManager.shared().startView(withName: "TestVC",property: ["custom_key":"custom_value"])
    }
    override func viewDidDisappear() {
        super.viewDidDisappear()
        // Scene 1：
        FTGlobalRumManager.shared().stopView()
        // Secne 2：  extra property
        FTGlobalRumManager.shared().stopView(withProperty: ["custom_key":"custom_value"])
    }
    ```

### Action

### Method

=== "Objective-C"

    ```objectivec
    /// add action
    ///
    /// - Parameters:
    ///   - actionName: action name
    ///   - actionType: action type
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType;
    
    /// add action
    /// - Parameters:
    ///   - actionName: action name
    ///   - actionType: action type
    ///   - property: extra property (optional)
    - (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// add action
    ///
    /// - Parameters:
    ///   - actionName: action name
    ///   - actionType: action type
    func addActionName(String, actionType: String)
    
    /// add action
    /// - Parameters:
    ///   - actionName: action name
    ///   - actionType: action type
    ///   - property: extra property (optional)
    func addActionName(String, actionType: String, property: [AnyHashable : Any]?)
    ```
#### Code Example

=== "Objective-C"

    ```objective-c
    // Scene 1：
    [[FTGlobalRumManager sharedManager] addActionName:@"UITableViewCell click" actionType:@"click"];
    // Secne 2：  extra property
    [[FTGlobalRumManager sharedManager]  addActionName:@"UITableViewCell click" actionType:@"click" property:@{@"custom_key":@"custom_value"}];
    ```
=== "Swift"

    ```swift
    // Scene 1：
    FTGlobalRumManager.shared().addActionName("custom_action", actionType: "click")
    // Secne 2：  extra property
    FTGlobalRumManager.shared().addActionName("custom_action", actionType: "click",property: ["custom_key":"custom_value"])
    ```

### Error

#### Method

=== "Objective-C"

    ```objectivec
    /// add error data
    ///
    /// - Parameters:
    ///   - type: error type
    ///   - message: error message detail
    ///   - stack: error log content
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
    
    /// add error data
    /// - Parameters:
    ///   - type: error type
    ///   - message: error message detail
    ///   - stack: error log content
    ///   - property: extra property (optional)
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    
    /// add error data
    /// - Parameters:
    ///   - type: error type
    ///   - state: application running state
    ///   - message: error message detail
    ///   - stack: error log content
    ///   - property: extra property (optional)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// add error data
    ///
    /// - Parameters:
    ///   - type: error type
    ///   - message: error message detail
    ///   - stack: error log content
    func addError(withType: String, message: String, stack: String)
    
    /// add error data
    /// - Parameters:
    ///   - type: error type
    ///   - message: error message detail
    ///   - stack: error log content
    ///   - property: extra property (optional)
    func addError(withType: String, message: String, stack: String, property: [AnyHashable : Any]?)
    
    /// add error data
    /// - Parameters:
    ///   - type: error type
    ///   - state: application running state
    ///   - message: error message detail
    ///   - stack: error log content
    ///   - property: extra property (optional)
    open func addError(withType type: String, state: FTAppState, message: String, stack: String, property: [AnyHashable : Any]?)
    ```
#### Code Example

=== "Objective-C"

    ```objectivec
    // Scene 1：
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"type" message:@"message" stack:@"stack"];
    // Secne 2：  extra property
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"ios_crash" message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    // Secne 3：  extra property
    [[FTGlobalRumManager sharedManager] addErrorWithType:@"ios_crash" state:FTAppStateUnknown message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // Scene 1：
    FTGlobalRumManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack")
    // Secne 2：  extra property
    FTGlobalRumManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack",property: ["custom_key":"custom_value"])
    // Secne 3：  extra property       
    FTGlobalRumManager.shared().addError(withType: "custom_type", state: .unknown, message: "custom_message", stack: "custom_stack", property: ["custom_key":"custom_value"])
    ```

### LongTask

#### Method

=== "Objective-C"

    ```objectivec
    /// add long task data
    ///
    /// - Parameters:
    ///   - stack: stack or log content
    ///   - duration: Duration, in nanoseconds.
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
    
    /// add long task data
    /// - Parameters:
    ///   - stack: stack or log content
    ///   - duration: Duration, in nanoseconds.
    ///   - property: extra property (optional)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// add long task data
    ///
    /// - Parameters:
    ///   - stack: stack or log content
    ///   - duration: Duration, in nanoseconds.
    func addLongTask(withStack: String, duration: NSNumber)
    
    /// add long task data
    /// - Parameters:
    ///   - stack: stack or log content
    ///   - duration: Duration, in nanoseconds.
    ///   - property: extra property (optional)
    func addLongTask(withStack: String, duration: NSNumber, property: [AnyHashable : Any]?)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    // Scene 1：
    [[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
    // Secne 2：  extra property
    [[FTGlobalRumManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000 property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Scene 1：
    FTGlobalRumManager.shared().addLongTask(withStack: "stack string", duration: 1000000000)
    // Secne 2：  extra property
    FTGlobalRumManager.shared().addLongTask(withStack: "stack string", duration: 1000000000 ,property: [["custom_key":"custom_value"]])
    ```

### Resource

#### Method

=== "Objective-C"

    ```objectivec
    /// resource start
    ///
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    - (void)startResourceWithKey:(NSString *)key;
    
    /// resource start
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - property: extra property
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// resource stop
    ///
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    - (void)stopResourceWithKey:(NSString *)key;
    
    /// resource stop
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - property: extra property
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// append network metrics and content data
    ///
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - metrics: request performance attributes
    ///   - content: request data
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    ```
=== "Swift"

    ```swift
    /// resource start
    ///
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    open func startResource(withKey key: String)
    
    /// resource start
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - property: extra property
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// resource stop
    ///
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    open func stopResource(withKey key: String)
    
    /// resource stop
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - property: extra property
    open func stopResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// append network metrics and content data
    ///
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - metrics: request performance attributes
    ///   - content: request data
    open func addResource(withKey key: String, metrics: FTResourceMetricsModel?, content: FTResourceContentModel)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    #import "FTMacOSSDK.h"
    
    //step 1： Before the network request starts
    [[FTGlobalRumManager sharedManager] startResourceWithKey:key];
    
    //step 2：Request completed
    [[FTGlobalRumManager sharedManager] stopResourceWithKey:key];
    
    //step 3：① Add resource data
    //FTResourceContentModel 
    FTResourceContentModel *content = [[FTResourceContentModel alloc]init];
    content.httpMethod = request.HTTPMethod;
    content.requestHeader = request.allHTTPHeaderFields;
    content.responseHeader = httpResponse.allHeaderFields;
    content.httpStatusCode = httpResponse.statusCode;
    content.responseBody = responseBody;
    //ios native
    content.error = error;
    
    //② If the performance data of the network request can be obtained
    //FTResourceMetricsModel
    //ios native. Get NSURLSessionTaskMetrics data, directly use the initialization method of FTResourceMetricsModel
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
    
    //other platforms. All time data in nanoseconds
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
    
    // step 4：add resource： If there is no performance data, the metrics parameter is set to nil
    [[FTGlobalRumManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    
    //step 1： Before the network request starts
    FTGlobalRumManager.shared().startResource(withKey: key)
    
    //step 2：Request completed
    FTGlobalRumManager.shared().stopResource(withKey: resource.key)
    
    //step 3：① Add resource data
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)
    
    //② If the performance data of the network request can be obtained
    //FTResourceMetricsModel
    //ios native. Get NSURLSessionTaskMetrics data, directly use the initialization method of FTResourceMetricsModel
    var metricsModel:FTResourceMetricsModel?
    if let metrics = resource.metrics {
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)
    }
    //other platforms. All time data in nanoseconds
    metricsModel = FTResourceMetricsModel()
    ...
    
    // step 4：add resource： If there is no performance data, the metrics parameter is set to nil
    FTGlobalRumManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

#### Resource url filter

When the automatic collection is enabled, the internal processing will not collect the data reporting address of the SDK. You can also set filter conditions through the Open API to collect the network addresses you need.

##### Method

=== "Objective-C"

    ```objective-c
    //  FTSDKAgent.h
    //  
    /// Determine whether the URL is collected
    /// - Parameter handler: callback，(YES collect，NO do not collect)
    - (void)isIntakeUrl:(BOOL(^)(NSURL *url))handler;
    ```

=== "Swift"

    ````swift
    //  FTSDKAgent
    /// Determine whether the URL is collected
    /// - Parameter handler: callback，(YES collect，NO do not collect)
    open func isIntakeUrl(_ handler: @escaping (URL) -> Bool)
    ````

##### Code Example

=== "Objective-C"

    ````objective-c
    [[FTSDKAgent sharedInstance] isIntakeUrl:^BOOL(NSURL * _Nonnull url) {
            // Your collection judgment logic
            return YES;//return NO; (YES collect，NO do not collect)
     }];
    ````

=== "Swift"

    ````swift
    FTSDKAgent.sharedInstance().isIntakeUrl {  url in
             //  Your collection judgment logic
           return true //return false (true collect，false do not collect)
     } 
    ````

## Logging {#user-logger}

### Method

=== "Objective-C"

    ```objectivec
    //  FTSDKAgent.h
    //  FTMacOSSDK
    
    /// add log
    /// @param content Log content, which can be a json string
    /// @param status  Log Level (info、warning、error、critical、ok). 
    -(void)logging:(NSString *)content status:(FTStatus)status;
    
    /// add log
    /// @param content Log content, which can be a json string
    /// @param status  Log Level (info、warning、error、critical、ok). 
    /// @param property Extra Property (optional)
    -(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;
    ```
    
    ```objective-c
    //
    //  FTLogger.h
    //  FTMacOSSDK
    
    /// add info type log
    /// - Parameters:
    ///   - content: Log content, which can be a json string
    ///   - property: Extra Property (optional)
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// add warning type log
    /// - Parameters:
    ///   - content: Log content, which can be a json string
    ///   - property: Extra Property (optional)
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// add error type log
    /// - Parameters:
    ///   - content: Log content, which can be a json string
    ///   - property: Extra Property (optional)
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;
    
    /// add critical type log
    /// - Parameters:
    ///   - content: Log content, which can be a json string
    ///   - property: Extra Property (optional)
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// add ok type log
    /// - Parameters:
    ///   - content: Log content, which can be a json string
    ///   - property: Extra Property (optional)
    -(void)ok:(NSString *)content property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    open class FTSDKAgent : NSObject {
    /// add log
    ///
    /// - Parameters:
    ///   - content: Log content, can be a json string
    ///   - status: Log Level (info、warning、error、critical、ok). 
    open func logging(_ content: String, status: FTLogStatus)
    
    /// add log
    /// - Parameters:
    ///   - content: Log content, can be a json string
    ///   - status: Log Level (info、warning、error、critical、ok). 
    ///   - property: Extra Property (optional)
    open func logging(_ content: String, status: FTLogStatus, property: [AnyHashable : Any]?)
    }
    ```
    
    ```swift
    open class FTLogger : NSObject, FTLoggerProtocol {}
    public protocol FTLoggerProtocol : NSObjectProtocol {
    /// add info type log
    /// - Parameters:
    ///   - content: Log content, can be a json string
    ///   - property: Extra Property (optional)
    optional func info(_ content: String, property: [AnyHashable : Any]?)
    
    /// add warning type log
    /// - Parameters:
    ///   - content: Log content, can be a json string
    ///   - property: Extra Property (optional)
    optional func warning(_ content: String, property: [AnyHashable : Any]?)
    
    /// add error type log
    /// - Parameters:
    ///   - content:  Log content, can be a json string
    ///   - property: Extra Property (optional)
    optional func error(_ content: String, property: [AnyHashable : Any]?)
    
    /// add critical type log
    /// - Parameters:
    ///   - content:  Log content, can be a json string
    ///   - property: Extra Property (optional)
    optional func critical(_ content: String, property: [AnyHashable : Any]?)
    
    /// add ok type log
    /// - Parameters:
    ///   - content: Log content, can be a json string
    ///   - property: Extra Property (optional)
    optional func ok(_ content: String, property: [AnyHashable : Any]?)
    }
    ```
#### Log level

=== "Objective-C"

    ```objective-c
    /// log level
    typedef NS_ENUM(NSInteger, FTLogStatus) {
        /// info
        FTStatusInfo         = 0,
        /// warning
        FTStatusWarning,
        /// error
        FTStatusError,
        /// critical
        FTStatusCritical,
        /// ok
        FTStatusOk,
    };
    ```
=== "Swift"

    ```swift
    /// log level
    public enum FTLogStatus : Int, @unchecked Sendable {
        /// info
        case statusInfo = 0
        /// warning
        case statusWarning = 1
        /// error
        case statusError = 2
        /// critical
        case statusCritical = 3
        /// ok
        case statusOk = 4
    }
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // Method 1：Use FTSDKAgent
    // Note: Ensure that the SDK has been successfully initialized at the time of use, otherwise failure will be asserted in the test environment resulting in a crash.
    [[FTSDKAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // Method 2：Use FTLogger （recommend）
    // If the SDK is not initialized successfully, calling the methods in FTLogger to add custom logs will fail, but there will be no assertion failure crash.
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Method 1：Use FTSDKAgent
    // Note: Ensure that the SDK has been successfully initialized at the time of use, otherwise failure will be asserted in the test environment resulting in a crash.
    FTSDKAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // Method 2：Use FTLogger （recommend）
    // If the SDK is not initialized successfully, calling the methods in FTLogger to add custom logs will fail, but there will be no assertion failure crash.
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### Print Custom Log To Console {#printCustomLogToConsole}


Set 'printCustomLogToConsole = YES' to enable the output of custom logs to the console. You will see logs in the following format in the xcode debug console:

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [MACOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`：os_log Specifies the standard prefix of log output (< xcode 15)；

`[MACOS APP]`：The prefix is used to distinguish the custom log output by the SDK；

`[INFO]`：Customize the log level；

`content`：Customize log content；

`{K=V,...,Kn=Vn}`：Extra Property 。

## Network Link Tracing

You can `FTTraceConfig` configuration to turn on automatic mode, or manually add. Trace related data, through the `FTTraceManager` singleton, to pass in, the relevant API as follows.

### Method

=== "Objective-C"

    ```objective-c
    // FTTraceManager.h
    
    /// Gets the request header parameters of trace
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - url: Request URL
    /// - Returns: trace dict
    - (NSDictionary *)getTraceHeaderWithKey:(NSString *)key url:(NSURL *)url;
    ```

=== "Swift"

    ```swift
    /// Gets the request header parameters of trace
    /// - Parameters:
    ///   - key: resource Id ，unique every request
    ///   - url: Request URL
    /// - Returns: trace dict
    open func getTraceHeader(withKey key: String, url: URL) -> [AnyHashable : Any]
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    NSString *key = [[NSUUID UUID]UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    //manual operation required： Get trace header before the request and add it to the request header
    NSDictionary *traceHeader = [[FTTraceManager sharedInstance] getTraceHeaderWithKey:key url:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (traceHeader && traceHeader.allKeys.count>0) {
        [traceHeader enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
            [request setValue:value forHTTPHeaderField:field];
        }];
    }
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       //your code
    }];
    
    [task resume];
    ```

=== "Swift"

    ```swift
    let url:URL = NSURL.init(string: "https://www.baidu.com")! as URL
    if let traceHeader = FTTraceManager.sharedInstance().getTraceHeader(withKey: NSUUID().uuidString, url: url) {
         let request = NSMutableURLRequest(url: url)
        //manual operation required： Get trace header before the request and add it to the request header
         for (a,b) in traceHeader {
             request.setValue(b as? String, forHTTPHeaderField: a as! String)
         }
         let task = URLSession.shared.dataTask(with: request as URLRequest) {  data,  response,  error in
            //your code
         }
         task.resume()
    }
    ```

## User Information Binding and Unbinding

### Method

=== "Objective-C"

    ```objectivec
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  user id
    - (void)bindUserWithUserID:(NSString *)userId;
    
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  user id
    ///   - userName: user name
    ///   - userEmailL: user email
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail;
    
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  user id
    ///   - userName: user name
    ///   - userEmail: user email
    ///   - extra: extar infomation
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail extra:(nullable NSDictionary *)extra;
    
    /// Unbind user information
    - (void)unbindUser;
    ```

=== "Swift"

    ```swift
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  user id
    open func bindUser(withUserID userId: String)
    
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  user id
    ///   - userName: user name
    ///   - userEmailL: user email
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?)
       
    /// Bind user information
    ///
    /// - Parameters:
    ///   - Id:  user id
    ///   - userName: user name
    ///   - userEmail: user email
    ///   - extra: extar infomation
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)
    
    /// Unbind user information
    open func unbindUser()
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // bind user info after log in
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTSDKAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // clear user data after log out
    [[FTSDKAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // bind user info after log in
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTSDKAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // clear user data after log out
    FTSDKAgent.sharedInstance().unbindUser()
    ```

## Close SDK

Using `FTSDKAgent`  to close SDK

### Method

=== "Objective-C"

    ```objective-c
    /// Close the running object inside the SDK
    - (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// Close the running object inside the SDK
    func shutDown()
    ```
### Code Example

=== "Objective-C"

    ```objective-c
    //If you dynamically change the SDK configuration, you need to close it first to avoid the generation of wrong data
    [[FTSDKAgent sharedInstance] shutDown];
    ```  

=== "Swift"

    ```swift
    //If you dynamically change the SDK configuration, you need to close it first to avoid the generation of wrong data
    FTSDKAgent.sharedInstance().shutDown()
    ```
## Add Custom Tags {#user-global-context}

### Static Use

You can create multiple Configurations to set values using pre-compiled instructions

1. Create multiple configurations.

![](../img/image_9.png)

2. Set preset properties to distinguish between Configurations.

![](../img/image_10.png)

3. Use the pre-compile command.

```objectivec
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS 
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
... //other set
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

### Dynamic Use

Since the globalContext set after RUM is started will not take effect, users can save it locally and set it to take effect the next time the application is started.

1. Save it locally by saving a file, e.g. `NSUserDefaults`, configure it using `SDK` and add the code to get the tag data in the configuration.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... //other set
[[FTSDKAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. Add a way to change the file data anywhere.

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. Finally restart the application to take effect.

### Attention

1. Special key : track_id (configured in RUM for tracking function)  

2. When the user adds a custom tag through globalContext and the SDK has the same tag, the SDK tag will override the user's settings, it is recommended that the tag name add the prefix of the project abbreviation, such as `df_tag_name`.

3. Set the globalContext before calling the -startRumWithConfigOptions method to start RUM to take effect.

4. Custom tags configured in `FTSDKConfig` will be added to all types of data.

For more details, please see [SDK Demo](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)。

## Frequently Asked Questions {#FAQ}

### [About crash log analysis](../ios/app-access.md#crash-log-analysis)

### An `Include of non-modular header inside framework module` occurred

Because the SDK's .h file introduces a library-dependent .h file, it needs to be set

`Target` -> `Build Settings` -> `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` set  YES.