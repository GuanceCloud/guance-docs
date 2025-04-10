# iOS/tvOS Application Integration

---

By collecting metrics data from various iOS applications, analyze the performance of each iOS application endpoint in a visualized manner.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has already been activated, the prerequisites have been automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit is configured to be [publicly accessible and with IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#iOS-integration}

1. Enter **User Access Monitoring > Create Application > iOS**;
2. Input application name;
3. Input application ID;
4. Choose application integration method:

    - Public DataWay: Directly receives RUM data without installing the DataKit collector.
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.

## Installation

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![tvOS](https://img.shields.io/badge/dynamic/json?label=tvOS&color=brightgreen&query=$.tvos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1. Configure the `Podfile` file.
    
        * Use Dynamic Library
          ```
          use_frameworks!
          def shared_pods
            pod 'FTMobileSDK', '[latest_version]'
            # If widget Extension data collection is needed
            pod 'FTMobileSDK', :subspecs => ['Extension'] 
          end
    
          # Main project
          target 'yourProjectName' do
            shared_pods
          end
    
          # Widget Extension
          target 'yourWidgetExtensionName' do
            shared_pods
          end
          ```
    
        * Use Static Library
          ```
          use_modular_headers!
          # Main project
          target 'yourProjectName' do
            pod 'FTMobileSDK', '[latest_version]'
          end
          # Widget Extension
          target 'yourWidgetExtensionName' do
            pod 'FTMobileSDK', :subspecs => ['Extension'] 
          end
          ```
    
        * [Download the repository locally for use](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
          
          **`Podfile` File:**
          ```
          use_modular_headers!
          # Main project
          target 'yourProjectName' do
            pod 'FTMobileSDK', :path => '[folder_path]' 
          end
          # Widget Extension
          target 'yourWidgetExtensionName' do
            pod 'FTMobileSDK', :subspecs => ['Extension'] , :path => '[folder_path]'
          end
          ```
          `folder_path`: The path of the folder where the `FTMobileSDK.podspec` file is located.
    
          **`FTMobileSDK.podspec` File:**
          
          Modify the `s.version` and `s.source` in the `FTMobileSDK.podspec` file.
          ```
          Pod::Spec.new do |s|
            s.name         = "FTMobileSDK"
            s.version      = "[latest_version]"  
            s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
          end
          ```
          
          `s.version`: Modify to the specified version, it is recommended to be consistent with `SDK_VERSION` in `FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`.
          
          `s.source`: `tag => s.version`
    
    2. Execute `pod install` in the `Podfile` directory to install the SDK.

=== "Carthage" 

    1. Configure the `Cartfile` file.
        ```
        github "GuanceCloud/datakit-ios" == [latest_version]
        ```
    
    2. Update dependencies.
    
        Depending on your target platform (iOS or tvOS), execute the corresponding `carthage update` command and add the `--use-xcframeworks` parameter to generate XCFrameworks:
       
        * For iOS platform:
          ```
          carthage update --platform iOS --use-xcframeworks
          ```
        
        * For tvOS platform:
          ```
          carthage update --platform tvOS --use-xcframeworks
          ```
       
        The generated xcframework uses the same method as ordinary Frameworks. Add the compiled library to the project.
        
        `FTMobileAgent`: Add to the main project Target, supports iOS and tvOS platforms.
        
        `FTMobileExtension`: Add to the Widget Extension Target.
    
    3. In `TARGETS` -> `Build Setting` -> `Other Linker Flags`, add `-ObjC`.
    
    4. When using Carthage integration, the SDK version supports:
       
        `FTMobileAgent`: >=1.3.4-beta.2 
    
        `FTMobileExtension`: >=1.4.0-beta.1

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, click the **+** under the `Packages` column.
    
    2. In the search box of the pop-up page, input `https://github.com/GuanceCloud/datakit-ios.git`.
    
    3. After Xcode successfully retrieves the package, it will display the SDK configuration page.
    
        `Dependency Rule`: It is recommended to choose `Up to Next Major Version`.
    
        `Add To Project`: Select the supported project.
        
        After filling out the configuration, click the `Add Package` button and wait for the loading to complete.
    
    4. In the popup `Choose Package Products for datakit-ios`, select the Targets that need to add the SDK, click the `Add Package` button, at this point the SDK has been added successfully.
    
        `FTMobileSDK`: Add to the main project Target
    
        `FTMobileExtension`: Add to the Widget Extension Target
    
        If your project is managed by SPM, add the SDK as a dependency and add `dependencies` to `Package.swift`.
    
        ```plaintext
        // Main project
        dependencies: [
            .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",
            .upToNextMajor(from: "[latest_version]"))]
        ```
    
    5. Support Swift Package Manager from 1.4.0-beta.1 onwards.

### Adding Header Files

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

## SDK Initialization {#init}

### Basic Configuration {#base-setting}

=== "Objective-C"

    ```objective-c
    -(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
        // SDK FTMobileConfig settings
         // Local environment deployment, Datakit deployment
         //FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatakitUrl:datakitUrl];
         // Using public DataWay deployment
        FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatawayUrl:datawayUrl clientToken:clientToken];
        config.enableSDKDebugLog = YES;
        //Start SDK
        [FTMobileAgent startWithConfigOptions:config];
        
       //...
        return YES;
    }
    ```

=== "Swift"

    ```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         // SDK FTMobileConfig settings
           // Local environment deployment, Datakit deployment
           //let config = FTMobileConfig(datakitUrl: url)
           // Using public DataWay deployment
         let config = FTMobileConfig(datawayUrl: datawayUrl, clientToken: clientToken)
         config.enableSDKDebugLog = true
         FTMobileAgent.start(withConfigOptions: config)
         //...
         return true
    }
    ```

| Property | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| datakitUrl | NSString | Yes | Datakit access address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, the device with SDK installed must be able to access this address. **Note: Either datakit or dataway configuration should be chosen** |
| datawayUrl | NSString | Yes | Public Dataway access address, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, the device with SDK installed must be able to access this address. **Note: Either datakit or dataway configuration should be chosen** |
| clientToken | NSString | Yes | Authentication token, needs to be used with datawayUrl                               |
| enableSDKDebugLog | BOOL | No | Set whether to allow printing logs. Default `NO` |
| env | NSString | No | Set the collection environment. Default `prod`, supports customization, can also be set via the provided `FTEnv` enumeration through `-setEnvWithType:` method |
| service | NSString | No | Set the name of the business or service it belongs to. Affects the service field data in Logs and RUMs. Default: `df_rum_ios` |
| globalContext | NSDictionary |     No | Add custom tags. Refer to the rules [here](#key-conflict) |
| groupIdentifiers | NSArray | No | Array of AppGroups Identifier corresponding to the Widget Extensions to be collected. If Widget Extensions data collection is enabled, then this property must be set [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups), and configure the Identifier into this property |
| autoSync | BOOL | No | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use `[[FTMobileAgent sharedInstance] flushSyncData]` to manage data synchronization yourself |
| syncPageSize | int | No | Set the number of entries per sync request. Range [5,), Note: The larger the number of request entries, the more computational resources are consumed by data synchronization, default is 10 |
| syncSleepTime | int | No | Set the interval time for synchronization. Range [0,5000], default not set |
| enableDataIntegerCompatible | BOOL | No | Needs to coexist with web data, it is recommended to enable. This configuration is used to handle web data type storage compatibility issues. |
| compressIntakeRequests | BOOL | No | Compress sync data, SDK versions 1.5.6 and above support this parameter, default disabled |
| enableLimitWithDbSize       | BOOL             | No       | Enable the function to limit total cache size using DB.<br>**Note:** Once enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will become invalid. SDK versions 1.5.8 and above support this parameter |
| dbCacheLimit                | long             | No       | DB cache limit size. Range [30MB,), default 100MB, unit byte, SDK versions 1.5.8 and above support this parameter |
| dbDiscardType               | FTDBCacheDiscard | No       | Set the data discard rule for the database. Default `FTDBDiscard`<br/>`FTDBDiscard` discards appended data when the number of data exceeds the maximum value. `FTDBDiscardOldest` discards old data when the number of data exceeds the maximum value. SDK versions 1.5.8 and above support this parameter |

### RUM Configuration {#rum-config}

=== "Objective-C"

    ```objective-c
        //Enable rum
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

| **Property** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| appid | NSString | Yes | Unique identifier for User Access Monitoring application ID. Corresponding to setting RUM `appid`, only enables RUM collection functionality when set, [method to obtain appid](#iOS-integration) |
| samplerate | int | No | Sampling rate. Value range [0,100], 0 means no collection, 100 means full collection, default value is 100. Scope applies to all View, Action, LongTask, Error data within the same session_id |
| enableTrackAppCrash | BOOL | No | Set whether to collect crash logs. Default `NO` |
| enableTrackAppANR | BOOL | No | Collect ANR unresponsive events. Default `NO` |
| enableTrackAppFreeze | BOOL | No | Collect UI freeze events. Default `NO`<br>Can be enabled by using `-setEnableTrackAppFreeze:freezeDurationMs:` method and set freeze threshold |
| freezeDurationMs | long | No | Set the threshold for UI freeze. Value range [100,), unit milliseconds, default 250ms. SDK versions 1.5.7 and above support this |
| enableTraceUserView | BOOL | No | Set whether to track user View operations. Default `NO` |
| enableTraceUserAction | BOOL | No | Set whether to track user Action operations. Default `NO` |
| enableTraceUserResource | BOOL | No | Set whether to track user network requests. Default `NO`, only applies to native http <br/>Note: Network requests initiated by `[NSURLSession sharedSession]` cannot collect performance data; <br/>SDK versions 1.5.9 and above support collecting network requests initiated through **Swift's URLSession async/await APIs** |
| resourceUrlHandler | FTResourceUrlHandler | No | Custom resource collection rules. Default does not filter. Return: NO means to collect, YES means not to collect |
| errorMonitorType | FTErrorMonitorType | No | Supplementary type for error event monitoring. Adds monitored information to the collected crash data. `FTErrorMonitorBattery` for battery level, `FTErrorMonitorMemory` for memory usage, `FTErrorMonitorCpu` for CPU usage |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No | Performance monitoring type for views. Adds corresponding monitoring items to the collected **View** data. `FTDeviceMetricsMonitorMemory` monitors current application memory usage, `FTDeviceMetricsMonitorCpu` monitors CPU jumps, `FTDeviceMetricsMonitorFps` monitors screen frame rate |
| monitorFrequency | FTMonitorFrequency | No | Performance monitoring sampling period for views. Configure `monitorFrequency` to set the sampling period for **View** monitoring item information. `FTMonitorFrequencyDefault` 500ms (default), `FTMonitorFrequencyFrequent` 100ms, `FTMonitorFrequencyRare` 1000ms |
| enableResourceHostIP | BOOL | No | Whether to collect the IP address of the requested target domain name. Supported on `>= iOS 13.0` `>= tvOS 13.0` |
| globalContext | NSDictionary | No | Add custom tags for user monitoring data differentiation. If tracking functionality is needed, then the parameter `key` is `track_id`, `value` is any numerical value. Refer to the notes for adding rules [here](#key-conflict) |
| rumCacheLimitCount | int                        | No | Maximum RUM cache size. Default 100_000, SDK versions 1.5.8 and above support this parameter |
| rumDiscardType | FTRUMCacheDiscard          | No | Set the RUM discard rule. Default `FTRUMCacheDiscard` <br/>`FTRUMCacheDiscard` discards appended data when the number of RUM data exceeds the maximum value. `FTRUMDiscardOldest` discards old data when the number of RUM data exceeds the maximum value. SDK versions 1.5.8 and above support this parameter |
| resourcePropertyProvider | FTResourcePropertyProvider | No | Add custom properties to RUM Resource through block callback. SDK versions 1.5.10 and above support this parameter. Priority is lower than [URLSession custom collection](#urlsession_interceptor) |

### Log Configuration {#log-config}

=== "Objective-C"

    ```objective-c
        //Enable logger
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

| Property | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| samplerate | int | No | Sampling rate. Value range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| enableCustomLog | BOOL | No | Whether to upload custom log. Default `NO` |
| printCustomLogToConsole | BOOL | No | Set whether to output custom logs to the console. Default `NO`, custom log [output format](#printCustomLogToConsole) |
| logLevelFilter | NSArray | No | Set the status array of custom logs to be collected. Default collects all |
| enableLinkRumData | BOOL | No | Whether to link with RUM data. Default `NO` |
| globalContext | NSDictionary |     No | Add custom tags to logs. Refer to the rules [here](#key-conflict) |
| logCacheLimitCount | int | No | Local cache maximum log entry limit [1000,), the larger the log, the greater the disk cache pressure, default 5000 |
| discardType | FTLogCacheDiscard | No | Set the log discard rule when the log reaches the limit. Default `FTDiscard` <br/>`FTDiscard` discards appended data when the number of log data exceeds the maximum value (5000). `FTDiscardOldest` discards old data when the number of log data exceeds the maximum value. |

### Trace Configuration {#trace-config}

=== "Objective-C"

    ```objective-c
       //Enable trace
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

| Property | Type | Required | Meaning |
| --- | --- | --- | --- |
| samplerate | int | No | Sampling rate. Value range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| networkTraceType | FTNetworkTraceType | No | Set the type of tracing links. Default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C). If choosing the corresponding link type while integrating OpenTelemetry, please refer to the supported types and related agent configurations |
| enableLinkRumData | BOOL | No | Whether to link with RUM data. Default `NO` |
| enableAutoTrace | BOOL | No | Set whether to enable automatic http trace. Default `NO`, currently only supports NSURLSession |
| traceInterceptor | FTTraceInterceptor | No | Supports determining whether to perform custom link tracing through URLRequest. Returns `TraceContext` upon confirmation of interception, returns nil if not intercepted. SDK versions 1.5.10 and above support this parameter. Priority is lower than [URLSession custom collection](#urlsession_interceptor) |

## RUM User Data Tracking {#rum}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition or manually use `FTExternalDataManager` to add these data, examples below:

### View

#### Usage Method

=== "Objective-C"

    ```objective-c
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method, this method records the page load time, if unable to obtain the load time, this method can be skipped.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page load time (nanoseconds)
    -(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
    
    /// Enter the page
    ///
    /// - Parameters:
    ///  - viewName: Page name
    -(void)startViewWithName:(NSString *)viewName;
    
    /// Enter the page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Event custom attributes (optional)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// Leave the page
    -(void)stopView;
    
    /// Leave the page
    /// - Parameter property: Event custom attributes (optional)
    -(void)stopViewWithProperty:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method, this method records the page load time, if unable to obtain the load time, this method can be skipped.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page load time (ns)
    open func onCreateView(_ viewName: String, loadTime: NSNumber)
    
    /// Enter the page
    ///
    /// - Parameters:
    ///  - viewName: Page name
    open func startView(withName viewName: String)
    
    /// Enter the page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Event custom attributes (optional)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// Leave the page
    open func stopView() 
    
    /// Leave the page
    /// - Parameter property: Event custom attributes (optional)
    open func stopView(withProperty property: [AnyHashable : Any]?)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    - (void)viewDidAppear:(BOOL)animated{
      [super viewDidAppear:animated];
      // Scenario 1:
      [[FTExternalDataManager sharedManager] startViewWithName:@"TestVC"];  
      
      // Scenario 2: Dynamic parameters
      [[FTExternalDataManager sharedManager] startViewWithName:@"TestVC" property:@{@"custom_key":@"custom_value"}];  
    }
    -(void)viewDidDisappear:(BOOL)animated{
      [super viewDidDisappear:animated];
      // Scenario 1:
      [[FTExternalDataManager sharedManager] stopView];  
      
      // Scenario 2: Dynamic parameters
      [[FTExternalDataManager sharedManager] stopViewWithProperty:@{@"custom_key":@"custom_value"}];
    }
    ```

=== "Swift"

    ```swift
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Scenario 1:
        FTExternalDataManager.shared().startView(withName: "TestVC")
        // Scenario 2: Dynamic parameters
        FTExternalDataManager.shared().startView(withName: "TestVC",property: ["custom_key":"custom_value"])
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Scenario 1:
        FTExternalDataManager.shared().stopView()
        // Scenario 2: Dynamic parameters
        FTExternalDataManager.shared().stopView(withProperty: ["custom_key":"custom_value"])
    }
    ```

### Action

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Start RUM Action.
    ///
    /// RUM binds possible triggered Resource, Error, LongTask events to this Action. Avoid adding multiple times within 0.1 s, only one Action can be associated with the same View at the same time, newly added Actions will be discarded if the previous Action has not ended.
    /// Does not affect Actions added via `addAction:actionType:property` method.
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom attributes (optional)
    - (void)startAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    
    /// Add Action event. No duration, no discard logic
    ///
    /// Does not affect RUM Actions started via `startAction:actionType:property:` method.
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom attributes (optional)
    - (void)addAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Start RUM Action.
    ///
    /// RUM binds possible triggered Resource, Error, LongTask events to this Action. Avoid adding multiple times within 0.1 s, only one Action can be associated with the same View at the same time, newly added Actions will be discarded if the previous Action has not ended.
    /// Does not affect Actions added via `addAction:actionType:property` method.
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom attributes (optional)
    open func startAction(_ actionName: String, actionType: String, property: [AnyHashable : Any]?)
    
    /// Add Action event. No duration, no discard logic
    ///
    /// Does not affect RUM Actions started via `startAction:actionType:property:` method.
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom attributes (optional)
    open func addAction(_ actionName: String, actionType: String, property: [AnyHashable : Any]?)
    ```
#### Code Example

=== "Objective-C"

    ```objective-c
    // startAction
    [[FTExternalDataManager sharedManager] startAction:@"action" actionType:@"click" property:@{@"action_property":@"testActionProperty1"}];
    // addAction
    [[FTExternalDataManager sharedManager] addAction:@"action" actionType:@"click" property:@{@"action_property":@"testActionProperty1"}];
    ```
=== "Swift"

    ```swift
    // startAction
    FTExternalDataManager.shared().startAction("custom_action", actionType: "click",property: nil)
    // addAction
    FTExternalDataManager.shared().addAction("custom_action", actionType: "click",property: nil)
    ```

### Error

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Add Error event
    ///
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack information
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack information
    ///   - property: Event custom attributes (optional)
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - state: Program running state
    ///   - message: Error message
    ///   - stack: Stack information
    ///   - property: Event custom attributes (optional)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add Error event
    ///
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack information
    open func addError(withType: String, message: String, stack: String)
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack information
    ///   - property: Event custom attributes (optional)
    open func addError(withType: String, message: String, stack: String, property: [AnyHashable : Any]?)
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - state: Program running state
    ///   - message: Error message
    ///   - stack: Stack information
    ///   - property: Event custom attributes (optional)
    open func addError(withType type: String, state: FTAppState, message: String, stack: String, property: [AnyHashable : Any]?)
    ```
#### Code Example

=== "Objective-C"

    ```objectivec
    // Scenario 1
    [[FTExternalDataManager sharedManager] addErrorWithType:@"type" message:@"message" stack:@"stack"];
    // Scenario 2: Dynamic parameters
    [[FTExternalDataManager sharedManager] addErrorWithType:@"ios_crash" message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    // Scenario 3: Dynamic parameters
    [[FTExternalDataManager sharedManager] addErrorWithType:@"ios_crash" state:FTAppStateUnknown message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // Scenario 1
    FTExternalDataManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack")
    // Scenario 2: Dynamic parameters
    FTExternalDataManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack",property: ["custom_key":"custom_value"])
    // Scenario 3: Dynamic parameters       
    FTExternalDataManager.shared().addError(withType: "custom_type", state: .unknown, message: "custom_message", stack: "custom_stack", property: ["custom_key":"custom_value"])
    ```


### LongTask

#### Usage Method

=== "Objective-C"

    ```objectivec
    /// Add Freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
    
    /// Add Freeze event
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Event custom attributes (optional)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add Freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    func addLongTask(withStack: String, duration: NSNumber)
    
    /// Add Freeze event
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Event custom attributes (optional)
    func addLongTask(withStack: String, duration: NSNumber, property: [AnyHashable : Any]?)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    // Scenario 1
    [[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
    // Scenario 2: Dynamic parameters
    [[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000 property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Scenario 1
    FTExternalDataManager.shared().addLongTask(withStack: "stack string", duration: 1000000000)
    // Scenario 2: Dynamic parameters
    FTExternalDataManager.shared().addLongTask(withStack: "stack string", duration: 1000000000 ,property: [["custom_key":"custom_value"]])
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
    ///   - property: Event custom attributes (optional)
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// HTTP adds request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Request-related performance attributes
    ///   - content: Request-related data
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    /// HTTP request ends
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)stopResourceWithKey:(NSString *)key;
    /// HTTP request ends
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom attributes (optional)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// HTTP request starts
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func startResource(withKey key: String)
    
    /// HTTP requeststarts  
    /// - Parameters:  
    ///   - key: Request identifier  
    ///   - property: Event custom attributes (optional)  
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)  
  
    /// HTTP request ends  
    ///  
    /// - Parameters:  
    ///   - key: Request identifier  
    open func stopResource(withKey key: String)  
  
    /// HTTP request ends  
    /// - Parameters:  
    ///   - key: Request identifier  
    ///   - property: Event custom attributes (optional)  
    open func stopResource(withKey key: String, property: [AnyHashable : Any]?)  
  
    /// HTTP adds request data  
    ///  
    /// - Parameters:  
    ///   - key: Request identifier  
    ///   - metrics: Request-related performance attributes  
    ///   - content: Request-related data  
    open func addResource(withKey key: String, metrics: FTResourceMetricsModel?, content: FTResourceContentModel)  
    ```  
  
#### Code Example  
  
=== "Objective-C"  
  
    ```objectivec  
    // Step 1: Before the request starts  
    [[FTExternalDataManager sharedManager] startResourceWithKey:key];  
  
    // Step 2: After the request completes  
    [[FTExternalDataManager sharedManager] stopResourceWithKey:key];  
  
    // Step 3: Concatenate Resource data  
    // FTResourceContentModel Data  
    FTResourceContentModel *content = [[FTResourceContentModel alloc]init];  
    content.httpMethod = request.HTTPMethod;  
    content.requestHeader = request.allHTTPHeaderFields;  
    content.responseHeader = httpResponse.allHeaderFields;  
    content.httpStatusCode = httpResponse.statusCode;  
    content.responseBody = responseBody;  
    // ios native  
    content.error = error;  
  
    // If able to obtain time data for each stage  
    // FTResourceMetricsModel  
    // For ios native obtaining NSURLSessionTaskMetrics data directly use FTResourceMetricsModel's initialization method  
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];  
  
    // For other platforms all time data in nanoseconds  
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];  
  
    // Step 4: Add resource if no time data metrics pass nil  
    [[FTExternalDataManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];  
    ```  
  
=== "Swift"  
  
    ```swift  
    // Step 1: Before the request starts  
    FTExternalDataManager.shared().startResource(withKey: key)  
  
    // Step 2: After the request completes  
    FTExternalDataManager.shared().stopResource(withKey: resource.key)  
  
    // Step 3: ① Concatenate Resource data  
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)  
  
    // ② If able to obtain time data for each stage  
    // FTResourceMetricsModel  
    // For ios native obtaining NSURLSessionTaskMetrics data directly use FTResourceMetricsModel's initialization method  
    var metricsModel:FTResourceMetricsModel?  
    if let metrics = resource.metrics {  
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)  
    }  
    // For other platforms all time data in nanoseconds  
    metricsModel = FTResourceMetricsModel()  
    ...  
  
    // Step 4: Add resource if no time data metrics pass nil  
    FTExternalDataManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)  
    ```  
  
## Logger Log Printing {#user-logger}  
  
When initializing the SDK with [Log Configuration](#log-config), configure `enableCustomLog` to allow adding custom logs.  
> Current log content is limited to 30 KB, any exceeding characters will be truncated.  
### Usage Method  
  
=== "Objective-C"  
  
    ```objectivec  
    //  FTMobileAgent.h  
    //  FTMobileSDK  
  
    /// Log reporting  
    /// @param content Log content, can be json string  
    /// @param status  Event level and status  
    -(void)logging:(NSString *)content status:(FTStatus)status;  
  
    /// Log reporting  
    /// @param content Log content, can be json string  
    /// @param status  Event level and status  
    /// @param property Event attributes  
    -(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;  
    ```  
  
    ```objective-c  
    //  
    //  FTLogger.h  
    //  FTMobileSDK  
  
    /// Add custom info log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;  
  
    /// Add custom warning log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;  
  
    /// Add custom error log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;  
  
    /// Add custom critical log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;  
  
    /// Add custom ok log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    -(void)ok:(NSString *)content property:(nullable NSDictionary *)property;  
    ```  
  
=== "Swift"  
  
    ```swift  
    open class FTMobileAgent : NSObject {  
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
  
    ```swift  
    open class FTLogger : NSObject, FTLoggerProtocol {}  
    public protocol FTLoggerProtocol : NSObjectProtocol {  
    /// Add custom info log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    optional func info(_ content: String, property: [AnyHashable : Any]?)  
  
    /// Add custom warning log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    optional func warning(_ content: String, property: [AnyHashable : Any]?)  
  
    /// Add custom error log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    optional func error(_ content: String, property: [AnyHashable : Any]?)  
  
    /// Add custom critical log  
    /// - Parameters:  
    ///   - content: Log content  
    ///   - property: Custom attributes (optional)  
    optional func critical(_ content: String, property: [AnyHashable : Any]?)  
  
    /// Add custom ok log  
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
        /// Information  
        FTStatusInfo         = 0,  
        /// Warning  
        FTStatusWarning,  
        /// Error  
        FTStatusError,  
        /// Critical  
        FTStatusCritical,  
        /// Recovery  
        FTStatusOk,  
    };  
    ```  
  
=== "Swift"  
  
    ```swift  
    /// Event level and status, default: FTStatusInfo  
    public enum FTLogStatus : Int, @unchecked Sendable {  
        /// Information  
        case statusInfo = 0  
        /// Warning  
        case statusWarning = 1  
        /// Error  
        case statusError = 2  
        /// Critical  
        case statusCritical = 3  
        /// Recovery  
        case statusOk = 4  
    }  
    ```  
  
### Code Example  
  
=== "Objective-C"  
  
    ```objectivec  
    // Method one: Through FTMobileAgent  
    // Note: Ensure that the SDK has been initialized successfully when using, otherwise it will cause a crash due to assertion failure in test environments.  
    [[FTMobileAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];  
  
    // Method two: Through FTLogger (recommended)  
    // If the SDK is not initialized successfully, calling methods in FTLogger to add custom logs will fail but there won't be an assertion failure causing a crash.  
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];  
  
    ```  
  
=== "Swift"  
  
    ```swift  
    // Method one: Through FTMobileAgent  
    // Note: Ensure that the SDK has been initialized successfully when using, otherwise it will cause a crash due to assertion failure in test environments.  
    FTMobileAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])  
  
    // Method two: Through FTLogger (recommended)  
    // If the SDK is not initialized successfully, calling methods in FTLogger to add custom logs will fail but there won't be an assertion failure causing a crash.  
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])  
    ```  
  
### Custom Logs Output to Console {#printCustomLogToConsole}  
  
Set `printCustomLogToConsole = YES`, enabling the output of custom logs to the console, you will see the following format logs in the xcode debug console:  
  
```  
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [IOS APP] [INFO] content ,{K=V,...,Kn=Vn}  
```  
  
`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`: Standard prefix for os_log output;  
  
`[IOS APP]`: Prefix used to distinguish custom logs output by the SDK;  
  
`[INFO]`: Level of custom logs;  
  
`content`: Content of custom logs;  
  
`{K=V,...,Kn=Vn}`: Custom attributes.  
  
## Trace Network Link Tracing  
  
You can enable automatic mode through `FTTraceConfig` configuration or support user-defined addition of trace-related data. The relevant APIs for custom additions are as follows:  
  
=== "Objective-C"  
  
    ```objectivec  
    NSString *key = [[NSUUID UUID]UUIDString];  
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];  
    // Manual operation required: Get traceHeader before the request and add it to the request header  
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
    if let traceHeader = FTExternalDataManager.shared().getTraceHeader(withKey: NSUUID().uuidString, url: url) {  
         let request = NSMutableURLRequest(url: url)  
         // Manual operation required: Get traceHeader before the request and add it to the request header  
         for (a,b) in traceHeader {  
             request.setValue(b as? String, forHTTPHeaderField: a as! String)  
         }  
         let task = URLSession.shared.dataTask(with: request as URLRequest) {  data,  response,  error in  
            // Your code  
         }  
         task.resume()  
    }  
    ```  
  
## Intercept URLSession Delegate to Customize Network Collection {#urlsession_interceptor}  
  
The SDK provides a class `FTURLSessionDelegate`, which can be used to customize **RUM Resource collection** and **tracing** for network requests initiated by a certain URLSession.  
  
* `FTURLSessionDelegate` supports setting `traceInterceptor` block to intercept `URLResquest` for custom tracing (Supported by SDK versions 1.5.9 and above), priority > `FTTraceConfig.traceInterceptor`.  
* `FTURLSessionDelegate` supports setting `provider` block to customize additional attributes that RUM Resource needs to collect, priority > ``FTRumConfig.resourcePropertyProvider``.  
* When used together with `FTRumConfig.enableTraceUserResource` and `FTTraceConfig.enableAutoTrace`, priority: **Custom > Automatic collection**.  
  
Below are three methods provided to meet different user scenarios.  
  
### Method One  
  
Directly set the delegate object of URLSession to an instance of `FTURLSessionDelegate`.  
  
=== "Objective-C"  
  
    ```objective-c  
    id<NSURLSessionDelegate> delegate = [[FTURLSessionDelegate alloc]init];  
    // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, such as `df_tag_name`.  
    delegate.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {  
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];  
                    return @{@"df_requestbody":body};  
                };  
    // Support custom trace, return TraceContext upon confirmation of interception, return nil if not intercepted  
    delegate.traceInterceptor = ^FTTraceContext * _Nullable(NSURLRequest *request) {  
            FTTraceContext *context = [FTTraceContext new];  
            context.traceHeader = @{@"trace_key":@"trace_value"};  
            context.traceId = @"trace_id";  
            context.spanId = @"span_id";  
            return context;  
        };             
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:delegate delegateQueue:nil];  
    ```  
  
=== "Swift"  
  
    ```swift  
    let delegate = FTURLSessionDelegate.init()  
    // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, such as `df_tag_name`.  
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
    // Support custom trace, return TraceContext upon confirmation of interception, return nil if not intercepted     
    delegate.traceInterceptor = { request in  
                let traceContext = FTTraceContext()  
                traceContext.traceHeader = ["trace_key":"trace_value"]  
                traceContext.spanId = "spanId"  
                traceContext.traceId = "traceId"  
                return traceContext  
            }         
    let session =  URLSession.init(configuration: URLSessionConfiguration.default, delegate:delegate   
    , delegateQueue: nil)  
    ```  
  
### Method Two  
  
Make the delegate object of URLSession inherit from `FTURLSessionDelegate` class.  
  
If the delegate object implements the following methods, ensure that the corresponding methods in the superclass are called within these methods.  
  
* `-URLSession:dataTask:didReceiveData:`  
* `-URLSession:task:didCompleteWithError:`  
* `-URLSession:task:didFinishCollectingMetrics:`  
  
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
            // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, such as `df_tag_name`.  
            self.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {  
            NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];  
            return @{@"df_requestbody":body};  
        };  
            // Support custom trace, return TraceContext upon confirmation of interception, return nil if not intercepted  
           self.traceInterceptor = ^FTTraceContext * _Nullable(NSURLRequest *request) {  
            FTTraceContext *context = [FTTraceContext new];  
            context.traceHeader = @{@"trace_key":@"trace_value"};  
            context.traceId = @"trace_id";  
            context.spanId = @"span_id";  
            return context;  
           };   
        }  
        return self;  
    }  
    -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics{  
        // Must call the superclass method  
        [super URLSession:session task:task didFinishCollectingMetrics:metrics];  
        // Your own logic  
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
            session = URLSession.init(configuration: configuration, delegate:self  
    , delegateQueue: nil)  
            override init() {  
            super.init()  
            // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, such as `df_tag_name`.  
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
            // Support custom trace, return TraceContext upon confirmation of interception, return nil if not intercepted  
            traceInterceptor = { request in  
                let traceContext = FTTraceContext()  
                traceContext.traceHeader = ["trace_key":"trace_value"]  
                traceContext.spanId = "spanId"  
                traceContext.traceId = "traceId"  
                return traceContext  
            }  
        }  
        }  
  
        override func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {  
            // Must call the superclass method  
            super.urlSession(session, task: task, didFinishCollecting: metrics)  
            // User's own logic  
            // ......  
        }  
    }  
    ```  
  
### Method Three  
  
Make the delegate object of URLSession conform to the `FTURLSessionDelegateProviding` protocol.  
  
* Implement the get method of the `ftURLSessionDelegate` property in the protocol  
* Forward the following URLSession delegate methods to `ftURLSessionDelegate`, so that the SDK can collect data.  
    * `-URLSession:dataTask:didReceiveData:`  
    * `-URLSession:task:didCompleteWithError:`  
    * `-URLSession:task:didFinishCollectingMetrics:`  
  
=== "Objective-C"  
  
    ```objective-c  
    @interface UserURLSessionDelegateClass:NSObject<NSURLSessionDataDelegate,FTURLSessionDelegateProviding>  
    @end  
    @implementation UserURLSessionDelegateClass  
    @synthesize ftURLSessionDelegate = _ftURLSessionDelegate;  
  
    - (nonnull FTURLSessionDelegate *)ftURLSessionDelegate {  
        if(!_ftURLSessionDelegate){  
            _ftURLSessionDelegate = [[FTURLSessionDelegate alloc]init];  
             // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, such as `df_tag_name`.  
            _ftURLSessionDelegate.provider =  ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {  
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];  
                    return @{@"df_requestbody":body};  
                };  
              // Support custom trace, return TraceContext upon confirmation of interception, return nil if not intercepted  
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
            // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, such as `df_tag_name`.  
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
            // Support custom trace, return TraceContext upon confirmation of interception, return nil if not intercepted  
            ftURLSessionDelegate.traceInterceptor = { request in  
                let traceContext = FTTraceContext()  
                traceContext.traceHeader = ["trace_key":"trace_value"]  
                traceContext.spanId = "spanId"  
                traceContext.traceId = "traceId"  
                return traceContext  
            }  
        }  
        // Below methods must be implemented  
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
  
## Binding and Unbinding Users  
  
### Usage Method  
  
=== "Objective-C"  
  
    ```objectivec  
    /// Bind user information  
    ///  
    /// - Parameters:  
    ///   - Id: User ID  
    - (void)bindUserWithUserID:(NSString *)userId;  
  
    /// Bind user information  
    ///  
    /// - Parameters:  
    ///   - Id: User ID  
    ///   - userName: User name  
    ///   - userEmailL: User email  
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail;  
  
    /// Bind user information  
    ///  
    /// - Parameters:  
    ///   - Id: User ID  
    ///   - userName: User name  
    ///   - userEmail: User email  
    ///   - extra: Extra user information  
    - (void)bindUserWithUserID:(NSString *)Id userName:(nullable NSString *)userName userEmail:(nullable NSString *)userEmail extra:(nullable NSDictionary *)extra;  
  
    /// Unbind current user  
    - (void)unbindUser;  
    ```  
  
=== "Swift"  
  
    ```swift  
    /// Bind user information  
    ///  
    /// - Parameters:  
    ///   - Id: User ID  
    open func bindUser(withUserID userId: String)  
  
    /// Bind user information  
    ///  
    /// - Parameters:  
    ///   - Id: User ID  
    ///   - userName: User name  
    ///   - userEmailL: User email  
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?)  
       
    /// Bind user information  
    ///  
    /// - Parameters:  
    ///   - Id: User ID  
    ///   - userName: User name  
    ///   - userEmail: User email  
    ///   - extra: Extra user information  
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)  
  
    /// Unbind current user  
    open func unbindUser()  
    ```  
  
### Code Example  
  
=== "Objective-C"  
  
    ```objectivec  
    // Can call this method after successful user login to bind user information  
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID];  
    // or  
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];  
    // or  
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];  
  
    // Can call this method after user logout to unbind user information  
    [[FTMobileAgent sharedInstance] unbindUser];  
    ```  
  
=== "Swift"  
  
    ```swift  
    // Can call this method after successful user login to bind user information  
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID)  
    // or  
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)  
    // or  
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])  
  
    // Can call this method after user logout to unbind user information  
    FTMobileAgent.sharedInstance().unbindUser()  
    ```  
  
## Closing the SDK  
  
Use `FTMobileAgent` to close the SDK.  
  
### Usage Method  
  
=== "Objective-C"  
  
    ```objective-c  
    /// Close running objects within the SDK  
    + (void)shutDown;  
    ```  
  
=== "Swift"  
  
    ```swift  
    /// Close running objects within the SDK  
    open class func shutDown()  
    ```  
  
### Code Example  
  
=== "Objective-C"  
  
    ```objective-c  
    // If dynamically changing SDK configurations, need to close first to avoid incorrect data generation  
    [FTMobileAgent  shutDown];  
    ```  
  
=== "Swift"  
  
    ```swift  
    // If dynamically changing SDK configurations, need to close first to avoid incorrect data generation  
    FTMobileAgent.shutDown()  
    ```  
  
## Clearing Cache Data of the SDK  
  
Use `FTMobileAgent` to clear unsent cache data.  
  
### Usage Method  
  
=== "Objective-C"  
  
    ```objective-c  
    /// Clear all data yet to be uploaded to the server  
    + (void)clearAllData;  
    ```  
  
=== "Swift"  
  
    ```swift  
    /// Clear all data yet to be uploaded to the server  
    open class func clearAllData()  
    ```  
  
### Code Example  
  
=== "Objective-C"  
  
    ```objective-c  
    [FTMobileAgent clearAllData];  
    ```  
  
=== "Swift"  
  
    ```swift  
    FTMobileAgent.clearAllData()  
    ```  
  
## Actively Synchronize Data  
  
Use `FTMobileAgent` to actively synchronize data.  
> Requires `FTMobileConfig.autoSync = NO` to manually perform data synchronization.  
  
### Usage Method  
  
=== "Objective-C"  
  
    ```objective-c  
    /// Actively synchronize data  
    - (void)flushSyncData;  
    ```  
  
=== "Swift"  
  
    ```swift  
    /// Actively synchronize data  
    func flushSyncData()  
    ```  
  
### Code Example  
  
=== "Objective-C"  
  
    ```objective-c  
    [[FTMobileAgent sharedInstance] flushSyncData];  
    ```  
  
=== "Swift"  
  
    ```swift  
    // If dynamically changing SDK configurations, need to close first to avoid incorrect data generation  
    FTMobileAgent.sharedInstance().flushSyncData()  
    ```  
  
## Adding Custom Tags  
  
Use `FTMobileAgent` to dynamically add tags while the SDK is running.  
  
### Usage Method  
  
=== "Objective-C"  
  
    ```objective-c  
    /// Add global tags for SDK, applicable to RUM and Log data  
    /// - Parameter context: Custom data  
    + (void)appendGlobalContext:(NSDictionary <NSString*,id>*)context;  
  
    /// Add custom tags for RUM, applicable to RUM data  
    /// - Parameter context: Custom data  
    + (void)appendRUMGlobalContext:(NSDictionary <NSString*,id>*)context;  
  
    /// Add global tags for Log, applicable to Log data  
    /// - Parameter context: Custom data  
    + (void)appendLogGlobalContext:(NSDictionary <NSString*,id>*)context;  
    ```  
  
=== "Swift"  
  
    ```swift  
    /// Add global tags for SDK, applicable to RUM and Log data  
    /// - Parameter context: Custom data  
    open class func appendGlobalContext(_ context: [String : Any])  
  
    /// Add custom tags for RUM, applicable to RUM data  
    /// - Parameter context: Custom data  
    open class func appendRUMGlobalContext(_ context: [String : Any])  
  
    /// Add global tags for Log, applicable to Log data  
    /// - Parameter context: Custom data  
    open class func appendLogGlobalContext(_ context: [String : Any])  
    ```  
  
### Code Example  
  
=== "Objective-C"  
  
    ```objective-c  
    [FTMobileAgent  appendGlobalContext:@{@"global_key":@"global_value"}];  
    [FTMobileAgent  appendLogGlobalContext:@{@"log_key":@"log_value"}];  
    [FTMobileAgent  appendRUMGlobalContext:@{@"rum_key":@"rum_value"}];  
    ```  
  
=== "Swift"  
  
    ```swift  
    let globalContext = ["global_key":"global_value"]  
    FTMobileAgent.appendGlobalContext(globalContext)  
    let rumGlobalContext = = ["rum_key":"rum_value"]  
    FTMobileAgent.appendRUMGlobalContext(rumGlobalContext)  
    let logGlobalContext = = ["log_key":"log_value"]  
    FTMobileAgent.appendLogGlobalContext(logGlobalContext)  
    ```  
  
## Uploading Symbol Files {#source_map}  
  
### Adding Run Script Phase in Xcode  
  
1. Add a custom Run Script Phase in Xcode: `Build Phases -> + -> New Run Script Phase`  
  
2. Copy the script into the run script phase of the Xcode project, the script requires setting parameters such as：＜app_id＞、＜datakit_address＞、＜env＞、＜dataway_token＞.  
  
3. Script: [FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)  
  
```sh  
# Parameters to be configured in the script  
#＜app_id＞  
FT_APP_ID="YOUR_APP_ID"  
#<datakit_address>  
FT_DATAKIT_ADDRESS="YOUR_DATAKIT_ADDRESS"  
#<env> Environment field. Attribute values: prod/gray/pre/common/local. Needs to be consistent with SDK settings  
FT_ENV="common"  
#<dataway_token> Token in the configuration file datakit.conf for dataway  
FT_TOKEN="YOUR_DATAWAY_TOKEN"  
```  
  
If you need to upload symbol files for multiple environments, you can refer to the method below.  
  
#### Multi-environment Configuration Parameters {#multi_env_param}  
  
Example: Using .xcconfig configuration file for multi-environment configuration  
  
**1. Create xcconfig configuration file, configure variables in the .xcconfig file**.  
  
Create xcconfig configuration file method can refer to: [Add Build Configuration File to Project](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project)  
  
```sh  
// If using cocoapods, need to add the path of pods .xcconfig to your .xcconfig file  
// Import pod corresponding .xcconfig  
#include "Pods/Target Support Files/Pods-GuanceDemo/Pods-GuanceDemo.pre.xcconfig"  
  
SDK_APP_ID = app_id_common  
SDK_ENV = common  
// URL // needs to add $()  
SDK_DATAKIT_ADDRESS = http:/$()/xxxxxxxx:9529  
SDK_DATAWAY_TOKEN = token  
```  
  
At this point, the user-defined parameters have been automatically added, you can view them via `Target —> Build Settings -> + -> Add User-Defined Setting`  
  
![](../img/multi-environment-configuration2.png)  
  
**2. Configure the script parameters**  
  
```sh  
# Parameters needed in the script  
#＜app_id＞  
FT_APP_ID=${SDK_APP_ID}  
#<datakit_address>  
FT_DATAKIT_ADDRESS=${SDK_DATAKIT_ADDRESS}  
#<dev> Environment field. Attribute values: prod/gray/pre/common/local. Needs to be consistent with SDK settings  
FT_ENV=${SDK_ENV}  
#<dataway_token> Token in the configuration file datakit.conf for dataway  
FT_TOKEN=${SDK_DATAWAY_TOKEN}  
```  
  
**3. Configure the SDK**  
  
Map parameters in the `Info.plist` file  
  
![](../img/multi-environment-configuration8.png)  
  
Retrieve parameters from `Info.plist` to configure the SDK  
  
```swift  
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {  
        let info = Bundle.main.infoDictionary!  
        let appid:String = info["SDK_APP_ID"] as! String  
        let env:String  = info["SDK_ENV"] as! String  
  
        let config = FTMobileConfig.init(datakitUrl: UserDefaults.datakitURL)  
        config.enableSDKDebugLog = true  
        config.autoSync = false  
        config.env = env  
        ....  
}  
```  
  
Detailed details can be referenced in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo) for multi-environment usage.  
  
### Terminal Running Script  
  
[Script: FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)  
  
**Command Format:**  
  
`sh FTdSYMUpload.sh <datakit_address> <app_id> <version> <env> <dataway_token> <dSYMBOL_src_dir> <dSYM_ZIP_ONLY>`  
  
> Example:  
>  
> sh FTdSYMUploader.sh  http://10.0.0.1:9529 appid_mock 1.0.6 prod tkn_mock /Users/mock/Desktop/dSYMs  
  
**Parameter Description:**  
  
- `<datakit_address>`: Address of the DataKit service, like `http://localhost:9529`  
- `<app_id>`: Corresponding to RUM `applicationId`  
- `<env>`: Corresponding to RUM `env`  
- `<version>`: Application `version`, `CFBundleShortVersionString` value  
- `<dataway_token>`: Token in the configuration file `datakit.conf for dataway  
- `<dSYMBOL_src_dir>`: Directory path containing all `.dSYM` files.  
- `<dSYM_ZIP_ONLY>`: Whether to only zip the dSYM files. Optional. 1=Do not upload, only zip dSYM, 0=Upload, you can search for `FT_DSYM_ZIP_FILE` in the script output log to view the Zip file path.

### Manual Upload

[Source Map Upload](../sourcemap/set-sourcemap.md#uplo)

## Widget Extension Data Collection

### Widget Extension Data Collection Support

* Logger custom logs
* Trace link tracing
* RUM data collection
    * Manual collection ([RUM User Data Tracking](#rum))
    * Automatic crash log collection, HTTP Resource data

Since HTTP Resource data is bound to Views, users need to manually collect View data.

### Widget Extension Collection Configuration

Use `FTExtensionConfig` to configure automatic switches and file sharing Group Identifier for Widget Extension data collection, other configurations use the main project SDK's existing settings.

| **Field**                   | **Type**  | **Required**           | **Description**                                       |
| -------------------------- | --------- | ------------------ | ---------------------------------------------- |
| groupIdentifier            | NSString  | Yes                 | File sharing Group Identifier                      |
| enableSDKDebugLog          | BOOL      | No (default NO)       | Set whether to allow SDK to print Debug logs               |
| enableTrackAppCrash        | BOOL      | No (default NO)       | Set whether to collect crash logs                       |
| enableRUMAutoTraceResource | BOOL      | No (default NO)       | Set whether to track user network requests (only applies to native http) |
| enableTracerAutoTrace      | BOOL      | No (default NO)       | Set whether to enable automatic http link tracing                 |
| memoryMaxCount             | NSInteger | No (default 1000 entries) | Maximum number of data saved in Widget Extension         |

Widget Extension SDK usage example:

```swift
let extensionConfig = FTExtensionConfig.init(groupIdentifier: "group.identifier")
extensionConfig.enableTrackAppCrash = true
extensionConfig.enableRUMAutoTraceResource = true
extensionConfig.enableTracerAutoTrace = true
extensionConfig.enableSDKDebugLog = true
FTExtensionManager.start(with: extensionConfig)
FTExternalDataManager.shared().startView(withName: "WidgetDemoEntryView")
```

At the same time, when setting `FTMobileConfig` in the main project, you must set `groupIdentifiers`.

=== "Objective-C"

    ```objective-c
    // Main project
     FTMobileConfig *config = [[FTMobileConfig alloc]initWithMetricsUrl:url];
     config.enableSDKDebugLog = YES;
     config.groupIdentifiers = @[@"group.com.ft.widget.demo"]; 
    ```

=== "Swift"

    ```swift
    let config = FTMobileConfig.init(metricsUrl: url)
    config.enableSDKDebugLog = true
    config.groupIdentifiers = ["group.com.ft.widget.demo"]
    ```

### Uploading Data Collected by Widget Extension

The Widget Extension SDK only implements data collection, the data upload logic is handled by the main project's SDK. The timing of synchronizing collected data to the main project is customized by the user.

#### Usage Method

=== "Objective-C"

    ```objective-c
    // Call in the main project
    /// Track cached data in App Extension groupIdentifier
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: Callback after tracking completion
    - (void)trackEventFromExtensionWithGroupIdentifier:(NSString *)groupIdentifier completion:(nullable void (^)(NSString *groupIdentifier, NSArray *events)) completion;
    ```

=== "Swift"

    ```swift
    /// Track cached data in App Extension groupIdentifier
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: Callback after tracking completion
    open func trackEventFromExtension(withGroupIdentifier groupIdentifier: String, completion: ((String, [Any]) -> Void)? = nil)
    ```

#### Code Example

=== "Objective-C"

    ```objective-c
    // In the main project
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

## WebView Data Monitoring
To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) on the accessed pages.

## Custom Tag Usage Example {#user-global-context}

### Compilation Configuration Method

You can create multiple Configurations and use preprocessor directives to set values.

1. Create multiple Configurations

![](../img/image_9.png)

2. Set predefined properties to differentiate different Configurations

![](../img/image_10.png)

3. Use preprocessor directives

```objectivec
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS for configuration predefined definitions
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
... //Other setup operations
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

You can also refer to the [Multi-environment Configuration Parameters](#multi_env_param) method for configuration.

### Runtime Read/Write File Method

Since the globalContext set after starting RUM will not take effect, users can save it locally and set it upon next app launch.

1. Save file locally, such as using `NSUserDefaults`, configure and add code to retrieve tag data when configuring the SDK.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... //Other setup operations
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. Add a method to change file data at any location.

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. Finally, restart the app for it to take effect.

### Adding Tags During SDK Runtime

After initializing the SDK, use `[FTMobileAgent appendGlobalContext:globalContext]`, `[FTMobileAgent appendRUMGlobalContext:globalContext]`, `[FTMobileAgent appendLogGlobalContext:globalContext]` to dynamically add tags, which will immediately take effect once set. Subsequently, the uploaded RUM or Log data will automatically include the tag data. This method is suitable for scenarios where tag data needs to be delayed, such as when tag data requires a network request to obtain.

```objective-c
//SDK Initialization Pseudo-code, get
[FTMobileAgent startWithConfigOptions:config];

-(void)getInfoFromNet:(Info *)info{
	NSDictionary *globalContext = @{@"delay_key", info.value}
	[FTMobileAgent appendGlobalContext:globalContext];
}
```

## tvOS Data Collection

> api >= tvOS 12.0

The initialization and usage of the SDK are consistent with iOS.

**Note that tvOS does not support:**

* `WebView` data detection

* `FTRumConfig.errorMonitorType` battery monitoring for devices

## Common Issues {#FAQ}

### About Crash Log Analysis {#crash-log-analysis}

In the **Debug** and **Release** modes during development, captured thread backtraces are symbolized.
However, when the release package does not carry the symbol table, key backtraces of the exception thread will display the image name instead of being converted into valid code symbols, resulting in 16-bit memory addresses in the obtained **crash log**, making it impossible to locate the crashing code. Therefore, it is necessary to parse the 16-bit memory addresses into corresponding classes and methods.

#### How to find dSYM files after compiling or packaging

* In Xcode, dSYM files are typically generated together with the compiled .app file and located in the same directory.
* If you have archived the project, you can select `Organizer` from Xcode's `Window` menu, then choose the corresponding archive file. Right-click the archive file and select `Show in Finder`, navigate to the corresponding `.xcarchive` file in Finder. Right-click the `.xcarchive` file and select `Show Package Contents`, then enter the `dSYMs` folder to find the corresponding dSYM file.

#### Why doesn't XCode generate dSYM files after compilation?

XCode Release compilation generates dSYM files by default, while Debug compilation does not generate them by default. Corresponding Xcode configuration is as follows:

 `Build Settings -> Code Generation -> Generate Debug Symbols -> Yes` 

![](../img/dsym_config1.png)


`Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File`

![](../img/dsym_config2.png)

#### How to upload symbol tables if bitCode is enabled?

When uploading your bitcode App to App Store, check the box to declare the generation of symbol files (dSYM files):

- Before configuring the symbol table file, download the corresponding dSYM file for that version from App Store, then process and upload the symbol table file according to input parameters via the script.
- Do not integrate the script into the Target of the Xcode project, nor use the locally generated dSYM file to generate the symbol table file because the symbol table information in the locally compiled dSYM file is hidden. If you upload the locally compiled dSYM file, the restored result will be similar to “__hiden#XXX” symbols.

#### How to retrieve the dSYM file corresponding to an App already published to the App Store?

| Application uploaded to App Store Connect Distribution options | dSym file                                                     |
| -------------------------------------------------- | ------------------------------------------------------------ |
| Don’t include bitcode<br>Upload symbols            | Retrieve through Xcode                                              |
| Include bitcode<br>Upload symbols                  | Retrieve through iTunes Connect<br />Retrieve through Xcode, requiring `.bcsymbolmap` for obfuscation handling. |
| Include bitcode<br>Don’t upload symbols            | Retrieve through Xcode, requiring `.bcsymbolmap` for obfuscation handling.       |
| Don’t include bitcode<br>Don’t upload symbols      | Retrieve through Xcode                                              |

##### Retrieving through Xcode

1. `Xcode -> Window -> Organizer` 

2. Select the `Archives` tab

    ![](../img/xcode_find_dsym2.png)
   
3. Find the released archive, right-click the corresponding archive and choose `Show in Finder`

    ![](../img/xcode_find_dsym3.png)

   

4. Right-click the selected archive and choose `Show Package Contents`

    ![](../img/xcode_find_dsym4.png)

   

5. Choose the `dSYMs` directory; the directory contains the downloaded dSYM files

    ![](../img/xcode_find_dsym5.png)

##### Retrieving through iTunes Connect

1. Login to [App Store Connect](https://appstoreconnect.apple.com);
2. Enter "My Apps (My Apps)"
3. In "App Store" or "TestFlight", select a specific version, click "Build Metadata". On this page, click the button "Download dSYM (Download dSYM)" to download the dSYM file.

##### Handling with `.bcsymbolmap` for Deobfuscation

When finding dSYM files through Xcode, you can see the BCSymbolMaps directory

![](../img/BCSymbolMaps.png)


Open the terminal and use the following command for deobfuscation handling

`xcrun dsymutil -symbol-map <BCSymbolMaps_path> <.dSYM_path>`

### Adding Global Variables to Avoid Conflicting Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to add a **project abbreviation** prefix to tag names, such as `df_tag_name`. You can [query source code](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTMobileSDK/FTSDKCore/BaseUtils/Base/FTConstants.m) for keys used in the project. When global variables in the SDK conflict with RUM and Log variables, RUM and Log will override the global variables in the SDK.