# iOS/tvOS Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect metrics data from various iOS applications and analyze the performance of iOS applications in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geographic information database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#iOS-integration}

Log in to the <<< custom_key.brand_name >>> console, go to the **User Analysis** page, click the **[Create Application](../index.md#create)** in the top-left corner to start creating a new application.

![](../img/6.rum_ios.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img-shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img-shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![tvOS](https://img-shields.io/badge/dynamic/json?label=tvOS&color=brightgreen&query=$.tvos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios)

**Source Code Location**: [https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1. Configure the `Podfile` file.
    
        * Using Dynamic Library
          ```
          use_frameworks!
          def shared_pods
            pod 'FTMobileSDK', '[latest_version]'
            # If you need to collect widget Extension data
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
    
        * Using Static Library
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
    
        * [Using the repository downloaded locally](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
          
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
          `folder_path`: The path to the folder containing the `FTMobileSDK.podspec` file.
    
          **`FTMobileSDK.podspec` File:**
          
          Modify `s.version` and `s.source` in the `FTMobileSDK.podspec` file.
          ```
          Pod::Spec.new do |s|
            s.name         = "FTMobileSDK"
            s.version      = "[latest_version]"  
            s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
          end
          ```
          
          `s.version`: Change to the specified version, it is recommended to be consistent with the `SDK_VERSION` in `FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`.
          
          `s.source`: `tag => s.version`
    
    2. Run `pod install` in the `Podfile` directory to install the SDK.

=== "Carthage" 

    1. Configure the `Cartfile` file.
        ```
        github "GuanceCloud/datakit-ios" == [latest_version]
        ```
    
    2. Update dependencies.
    
        Depending on your target platform (iOS or tvOS), execute the corresponding `carthage update` command with the `--use-xcframeworks` parameter to generate XCFrameworks:
       
        * For iOS platform:
          ```
          carthage update --platform iOS --use-xcframeworks
          ```
        
        * For tvOS platform:
          ```
          carthage update --platform tvOS --use-xcframeworks
          ```
       
        The generated xcframework can be used similarly to ordinary Frameworks. Add the compiled libraries to your project.
        
        `FTMobileAgent`: Add to the main project Target, supporting both iOS and tvOS platforms.
        
        `FTMobileExtension`: Add to the Widget Extension Target.
    
    3. In `TARGETS` -> `Build Setting` -> `Other Linker Flags`, add `-ObjC`.
    
    4. When using Carthage integration, the supported SDK versions are:
       
        `FTMobileAgent`: >=1.3.4-beta.2 
    
        `FTMobileExtension`: >=1.4.0-beta.1

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, and click the **+** under the `Packages` section.
    
    2. Enter `https://github.com/GuanceCloud/datakit-ios.git` in the search box on the popped-up page.
    
    3. After Xcode successfully retrieves the package, it will display the SDK configuration page.
    
        `Dependency Rule`: It is recommended to choose `Up to Next Major Version`.
    
        `Add To Project`: Choose the supported project.
        
        Click the `Add Package` button after filling out the configuration and wait for the loading to complete.
    
    4. In the pop-up `Choose Package Products for datakit-ios`, select the Targets where you want to add the SDK, then click the `Add Package` button. At this point, the SDK has been added successfully.
    
        `FTMobileSDK`: Add to the main project Target
    
        `FTMobileExtension`: Add to the Widget Extension Target
    
        If your project is managed by SPM, add the SDK as a dependency, adding `dependencies` to `Package.swift`.
    
        ```plaintext
        // Main project
        dependencies: [
            .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",
            .upToNextMajor(from: "[latest_version]"))]
        ```
    
    5. Support Swift Package Manager starting from 1.4.0-beta.1.

### Adding Header Files

=== "Objective-C"

    ```
    // CocoaPods, SPM 
    #import "FTMobileSDK.h"
    // Carthage 
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
         // Use public DataWay deployment
        FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatawayUrl:datawayUrl clientToken:clientToken];
        config.enableSDKDebugLog = YES;
        // Start SDK
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
           // Use public DataWay deployment
         let config = FTMobileConfig(datawayUrl: datawayUrl, clientToken: clientToken)
         config.enableSDKDebugLog = true
         FTMobileAgent.start(withConfigOptions: config)
         //...
         return true
    }
    ```

| Property | **Type** | **Required** | **Description |
| --- | --- | --- | --- |
| datakitUrl | NSString | Yes | Datakit access URL, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, the device where the SDK is installed must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| datawayUrl | NSString | Yes | Public Dataway access URL, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, the device where the SDK is installed must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | NSString | Yes | Authentication token, must be used together with datawayUrl                               |
| enableSDKDebugLog | BOOL | No | Set whether to allow logging. Default `NO` |
| env | NSString | No | Set the collection environment. Default `prod`, supports customization, can also set according to the provided `FTEnv` enumeration through `-setEnvWithType:` method |
| service | NSString | No | Set the name of the business or service. Affects the `service` field data in Logs and RUM. Default: `df_rum_ios` |
| globalContext | NSDictionary |     No | Add custom tags. Refer to [here](#key-conflict) for addition rules |
| groupIdentifiers | NSArray | No | Array of AppGroups Identifier for the Widget Extensions that need to be collected. If Widget Extensions data collection is enabled, you must set [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups) and configure the Identifier to this property |
| autoSync | BOOL | No | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use `[[FTMobileAgent sharedInstance] flushSyncData]` to manage data synchronization manually |
| syncPageSize | int | No | Set the number of entries per sync request. Range [5,). Note: The larger the number of entries requested, the more computing resources are used for data synchronization. Default is 10 |
| syncSleepTime | int | No | Set the interval between syncs. Range [0,5000], default not set |
| enableDataIntegerCompatible | BOOL | No | Enable if coexistence with web data is required. This setting handles web data type storage compatibility issues. |
| compressIntakeRequests | BOOL | No | Compress sync data. Supported by SDK version 1.5.6 and above |
| enableLimitWithDbSize | BOOL | No | Enable DB cache size limit feature.<br>**Note:** When enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will become invalid. Supported by SDK version 1.5.8 and above |
| dbCacheLimit | long | No | DB cache size limit. Range [30MB,), default 100MB, unit byte, supported by SDK version 1.5.8 and above |
| dbDiscardType | FTDBCacheDiscard | No | Set the rule for discarding data in the database. Default `FTDBDiscard` <br/>`FTDBDiscard` discards appended data when the data count exceeds the maximum value. `FTDBDiscardOldest` discards old data when the count exceeds the maximum value. Supported by SDK version 1.5.8 and above |

### RUM Configuration {#rum-config}

=== "Objective-C"

    ```objective-c
        // Enable rum
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

| **Property** | **Type** | **Required** | **Description |
| --- | --- | --- | --- |
| appid | NSString | Yes | Unique identifier for the user analysis application ID. Corresponding to the RUM `appid`, enabling the collection function of RUM requires setting this value, [method to obtain appid](#iOS-integration) |
| samplerate | int | No | Sampling rate. Value range [0,100], 0 means no collection, 100 means full collection, default value is 100. Applies to all View, Action, LongTask, Error data within the same session_id |
| enableTrackAppCrash | BOOL | No | Set whether to collect crash logs. Default `NO` |
| enableTrackAppANR | BOOL | No | Collect ANR unresponsive events. Default `NO` |
| enableTrackAppFreeze | BOOL | No | Collect UI freeze events. Default `NO`<br>Can set freeze threshold via `-setEnableTrackAppFreeze:freezeDurationMs:` method |
| freezeDurationMs | long | No | Set the threshold for UI freeze duration. Value range [100,), unit milliseconds, default 250ms. Supported by SDK version 1.5.7 and above |
| enableTraceUserView | BOOL | No | Set whether to track user View operations. Default `NO` |
| enableTraceUserAction | BOOL | No | Set whether to track user Action operations. Default `NO` |
| enableTraceUserResource | BOOL | No | Set whether to track user network requests. Default `NO`, only applies to native http <br>Note: Network requests initiated via `[NSURLSession sharedSession]` cannot collect performance data;<br>SDK version 1.5.9 and above support collecting network requests initiated via **Swift's URLSession async/await APIs**. |
| resourceUrlHandler | FTResourceUrlHandler | No | Custom resource collection rules. Default does not filter. Returns: NO indicates to collect, YES indicates not to collect. |
| errorMonitorType | FTErrorMonitorType | No | Additional error event monitoring types. Adds monitored information to the collected crash data. `FTErrorMonitorBattery` for battery level, `FTErrorMonitorMemory` for memory usage, `FTErrorMonitorCpu` for CPU occupancy. |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No | Performance monitoring types for views. Adds corresponding monitoring items to the collected **View** data. `FTDeviceMetricsMonitorMemory` monitors current application memory usage, `FTDeviceMetricsMonitorCpu` monitors CPU jumps, `FTDeviceMetricsMonitorFps` monitors screen frame rate. |
| monitorFrequency | FTMonitorFrequency | No | Performance monitoring sampling period for views. Set `monitorFrequency` to configure the sampling period for **View** monitoring items. `FTMonitorFrequencyDefault` 500ms (default), `FTMonitorFrequencyFrequent` 100ms, `FTMonitorFrequencyRare` 1000ms. |
| enableResourceHostIP | BOOL | No | Whether to collect the IP address of the target domain of the request. Supported by `>= iOS 13.0` `>= tvOS 13.0` |
| globalContext | NSDictionary | No | Add custom tags for distinguishing user monitoring data sources. If tracking functionality is needed, the `key` should be `track_id`, and `value` can be any numerical value. Refer to [here](#key-conflict) for additional notes on adding rules. |
| rumCacheLimitCount | int | No | Maximum RUM cache size. Default 100_000, supported by SDK version 1.5.8 and above |
| rumDiscardType | FTRUMCacheDiscard | No | Set the RUM discard rule. Default `FTRUMCacheDiscard` <br/>`FTRUMCacheDiscard` discards appended data when RUM data count exceeds the maximum value. `FTRUMDiscardOldest` discards old data when RUM data count exceeds the maximum value. Supported by SDK version 1.5.8 and above |
| resourcePropertyProvider | FTResourcePropertyProvider | No | Add custom attributes to RUM Resource via block callback. Priority lower than [URLSession Custom Collection](#urlsession_interceptor). Supported by SDK version 1.5.10 and above |

### Log Configuration {#log-config}

=== "Objective-C"

    ```objective-c
        // Enable logger
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

| Property | **Type** | **Required** | **Description |
| --- | --- | --- | --- |
| samplerate | int | No | Sampling rate. Value range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| enableCustomLog | BOOL | No | Whether to upload custom logs. Default `NO` |
| printCustomLogToConsole | BOOL | No | Set whether to output custom logs to the console. Default `NO`, custom logs [output format](#printCustomLogToConsole) |
| logLevelFilter | NSArray | No | Set the status array for custom logs to collect. Default is full collection |
| enableLinkRumData | BOOL | No | Whether to associate with RUM data. Default `NO` |
| globalContext | NSDictionary |     No | Add custom tags to logs. Refer to [here](#key-conflict) for addition rules |
| logCacheLimitCount | int | No | Maximum local cache log entry limit [1000,), the larger the log, the greater the disk cache pressure, default is 5000 |
| discardType | FTLogCacheDiscard | No | Set the log discard rule when the log reaches the limit. Default `FTDiscard` <br/>`FTDiscard` discards appended data when log data count exceeds the maximum value (5000). `FTDiscardOldest` discards old data when log data count exceeds the maximum value. |

### Trace Configuration {#trace-config}

=== "Objective-C"

    ```objective-c
       // Enable trace
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

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| samplerate | int | No | Sampling rate. Value range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| networkTraceType | FTNetworkTraceType | No | Set the type of link tracing. Default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C). When integrating with OpenTelemetry, please refer to the supported types and agent configurations |
| enableLinkRumData | BOOL | No | Whether to associate with RUM data. Default `NO` |
| enableAutoTrace | BOOL | No | Set whether to enable automatic HTTP trace. Default `NO`, currently only supports NSURLSession |
| traceInterceptor | FTTraceInterceptor | No | Supports determining whether to perform custom link tracing via URLRequest. Confirm interception and return `TraceContext`, otherwise return nil. Supported by SDK version 1.5.10 and above. Priority lower than [URLSession Custom Collection](#urlsession_interceptor) |

## RUM User Data Tracking {#rum}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition or manually use `FTExternalDataManager` to add these data. Examples are shown below:

### View

#### Usage Method

=== "Objective-C"

    ```objective-c
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method, this method records the page load time. If the load time cannot be obtained, this method can be omitted.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page load time (nanoseconds)
    -(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
    
    /// Enter a page
    ///
    /// - Parameters:
    ///  - viewName: Page name
    -(void)startViewWithName:(NSString *)viewName;
    
    /// Enter a page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Custom properties for the event (optional)
    -(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
    
    /// Leave a page
    -(void)stopView;
    
    /// Leave a page
    /// - Parameter property: Custom properties for the event (optional)
    -(void)stopViewWithProperty:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method, this method records the page load time. If the load time cannot be obtained, this method can be omitted.
    /// - Parameters:
    ///  - viewName: Page name
    ///  - loadTime: Page load time (ns)
    open func onCreateView(_ viewName: String, loadTime: NSNumber)
    
    /// Enter a page
    ///
    /// - Parameters:
    ///  - viewName: Page name
    open func startView(withName viewName: String)
    
    /// Enter a page
    /// - Parameters:
    ///  - viewName: Page name
    ///  - property: Custom properties for the event (optional)
    open func startView(withName viewName: String, property: [AnyHashable : Any]?)
    
    /// Leave a page
    open func stopView() 
    
    /// Leave a page
    /// - Parameter property: Custom properties for the event (optional)
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
    /// RUM binds this Action to potential Resource, Error, LongTask events. Avoid adding multiple times within 0.1 seconds, only one Action can be associated with the same View at the same time. New Actions added while the previous Action has not ended will be discarded.
    /// Adding Actions with `addAction:actionType:property` does not affect each other.
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Custom properties for the event (optional)
    - (void)startAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    
    /// Add Action event. No duration, no discard logic
    ///
    /// Adding Actions with `startAction:actionType:property:` does not affect each other.
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Custom properties for the event (optional)
    - (void)addAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Start RUM Action.
    ///
    /// RUM binds this Action to potential Resource, Error, LongTask events. Avoid adding multiple times within 0.1 seconds, only one Action can be associated with the same View at the same time. New Actions added while the previous Action has not ended will be discarded.
    /// Adding Actions with `addAction:actionType:property` does not affect each other.
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Custom properties for the event (optional)
    open func startAction(_ actionName: String, actionType: String, property: [AnyHashable : Any]?)
    
    /// Add Action event. No duration, no discard logic
    ///
    /// Adding Actions with `startAction:actionType:property:` does not affect each other.
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Custom properties for the event (optional)
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
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
    
    /// Add Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Custom properties for the event (optional)
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    
    /// Add Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - state: Application running state
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Custom properties for the event (optional)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add Error event
    ///
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    open func addError(withType: String, message: String, stack: String)
    
    /// Add Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Custom properties for the event (optional)
    open func addError(withType: String, message: String, stack: String, property: [AnyHashable : Any]?)
    
    /// Add Error event
    /// - Parameters:
    ///   - type: Error type
    ///   - state: Application running state
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Custom properties for the event (optional)
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
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
    
    /// Add Freeze event
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Custom properties for the event (optional)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add Freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    func addLongTask(withStack: String, duration: NSNumber)
    
    /// Add Freeze event
    /// - Parameters:
    ///   - stack: Freeze stack trace
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Custom properties for the event (optional)
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
    /// Start HTTP request
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)startResourceWithKey:(NSString *)key;
    /// Start HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Custom properties for the event (optional)
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// Add request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Related performance attributes of the request
    ///   - content: Related data of the request
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    /// End HTTP request
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)stopResourceWithKey:(NSString *)key;
    /// End HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Custom properties for the event (optional)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// Start HTTP request
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func startResource(withKey key: String)
    
    /// Start HTTP request
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Custom properties for the event (optional)
    - (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    
    /// Add request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Related performance attributes of the request
    ///   - content: Related data of the request
    - (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
    
    /// End HTTP request
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)stopResourceWithKey:(NSString *)key;
    
    /// End HTTP request with custom properties
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Custom properties for the event (optional)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Start HTTP request
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func startResource(withKey key: String)
    
    /// Start HTTP request with custom properties
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Custom properties for the event (optional)
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// End HTTP request
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func stopResource(withKey key: String)
    
    /// End HTTP request with custom properties
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Custom properties for the event (optional)
    open func stopResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// Add request data
    ///
    /// - Parameters:
    ///   - key: Request identifier
    ///   - metrics: Related performance attributes of the request
    ///   - content: Related data of the request
    open func addResource(withKey key: String, metrics: FTResourceMetricsModel?, content: FTResourceContentModel)
    ```

#### Code Example

=== "Objective-C"

    ```objectivec
    // Step 1: Before starting the request
    [[FTExternalDataManager sharedManager] startResourceWithKey:key];
    
    // Step 2: After completing the request
    [[FTExternalDataManager sharedManager] stopResourceWithKey:key];
    
    // Step 3: Concatenate Resource data
    // FTResourceContentModel data
    FTResourceContentModel *content = [[FTResourceContentModel alloc]init];
    content.httpMethod = request.HTTPMethod;
    content.requestHeader = request.allHTTPHeaderFields;
    content.responseHeader = httpResponse.allHeaderFields;
    content.httpStatusCode = httpResponse.statusCode;
    content.responseBody = responseBody;
    // iOS native
    content.error = error;
    
    // If time data for each stage can be obtained 
    // FTResourceMetricsModel
    // For iOS native, obtain NSURLSessionTaskMetrics data and use FTResourceMetricsModel's initializer method directly
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
    
    // For other platforms, all time data is in nanoseconds
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
    
    // Step 4: Add resource if no time data, pass nil for metrics
    [[FTExternalDataManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    // Step 1: Before starting the request
    FTExternalDataManager.shared().startResource(withKey: key)
    
    // Step 2: After completing the request
    FTExternalDataManager.shared().stopResource(withKey: resource.key)
    
    // Step 3: ① Concatenate Resource data
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)
    
    // ② If time data for each stage can be obtained 
    // FTResourceMetricsModel
    // For iOS native, obtain NSURLSessionTaskMetrics data and use FTResourceMetricsModel's initializer method directly
    var metricsModel:FTResourceMetricsModel?
    if let metrics = resource.metrics {
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)
    }
    // For other platforms, all time data is in nanoseconds
    metricsModel = FTResourceMetricsModel()
    ...
    
    // Step 4: Add resource if no time data, pass nil for metrics
    FTExternalDataManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logger Logging {#user-logger}

When initializing the SDK in [Log Configuration](#log-config), configure `enableCustomLog` to allow adding custom logs.
> Currently, log content is limited to 30 KB, and any exceeding part will be truncated.

### Usage Method

=== "Objective-C"

    ```objectivec
    //  FTMobileAgent.h
    //  FTMobileSDK
    
    /// Log reporting
    /// @param content Log content, can be a JSON string
    /// @param status Event level and status
    -(void)logging:(NSString *)content status:(FTStatus)status;
    
    /// Log reporting
    /// @param content Log content, can be a JSON string
    /// @param status Event level and status
    /// @param property Event properties
    -(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;
    ```
    
    ```objective-c
    //
    //  FTLogger.h
    //  FTMobileSDK
    
    /// Add info type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add warning type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add error type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;
    
    /// Add critical type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add ok type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)ok:(NSString *)content property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    open class FTMobileAgent : NSObject {
    /// Add custom log
    ///
    /// - Parameters:
    ///   - content: Log content, can be a JSON string
    ///   - status: Event level and status
    open func logging(_ content: String, status: FTLogStatus)
    
    /// Add custom log
    /// - Parameters:
    ///   - content: Log content, can be a JSON string
    ///   - status: Event level and status
    ///   - property: Custom properties (optional)
    open func logging(_ content: String, status: FTLogStatus, property: [AnyHashable : Any]?)
    }
    ```
    
    ```swift
    open class FTLogger : NSObject, FTLoggerProtocol {}
    public protocol FTLoggerProtocol : NSObjectProtocol {
    /// Add info type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func info(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add warning type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func warning(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add error type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func error(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add critical type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func critical(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add ok type custom log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func ok(_ content: String, property: [AnyHashable : Any]?)
    }
    ```

#### Log Level

=== "Objective-C"

    ```objective-c
    /// Event level and status, default: FTStatusInfo
    typedef NS_ENUM(NSInteger, FTLogStatus) {
        /// Info
        FTStatusInfo         = 0,
        /// Warning
        FTStatusWarning,
        /// Error
        FTStatusError,
        /// Critical
        FTStatusCritical,
        /// Ok
        FTStatusOk,
    };
    ```
=== "Swift"

    ```swift
    /// Event level and status, default: FTStatusInfo
    public enum FTLogStatus : Int, @unchecked Sendable {
        /// Info
        case statusInfo = 0
        /// Warning
        case statusWarning = 1
        /// Error
        case statusError = 2
        /// Critical
        case statusCritical = 3
        /// Ok
        case statusOk = 4
    }
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // Method one: Through FTMobileAgent
    // Note: Ensure that the SDK has been initialized successfully when using it, otherwise it will fail and crash in the test environment.
    [[FTMobileAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // Method two: Through FTLogger (recommended)
    // If the SDK initialization fails, adding custom logs via FTLogger methods will fail but will not cause an assertion failure and crash.
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Method one: Through FTMobileAgent
    // Note: Ensure that the SDK has been initialized successfully when using it, otherwise it will fail and crash in the test environment.
    FTMobileAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // Method two: Through FTLogger (recommended)
    // If the SDK initialization fails, adding custom logs via FTLogger methods will fail but will not cause an assertion failure and crash.
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### Custom Logs Output to Console {#printCustomLogToConsole}

Set `printCustomLogToConsole = YES` to enable custom logs output to the console. You will see the following format logs in the Xcode debug console:

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [IOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`: Standard prefix for os_log output;

`[IOS APP]`: Prefix to distinguish SDK output custom logs;

`[INFO]`: Custom log level;

`content`: Custom log content;

`{K=V,...,Kn=Vn}`: Custom properties.

## Trace Network Link Tracing

You can configure `FTTraceConfig` to enable automatic mode or manually add related Trace data. The relevant APIs are provided below:

=== "Objective-C"

    ```objectivec
    NSString *key = [[NSUUID UUID]UUIDString];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    // Manually get traceHeader before the request and add it to the request header
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
         // Manually get traceHeader before the request and add it to the request header
         for (a,b) in traceHeader {
             request.setValue(b as? String, forHTTPHeaderField: a as! String)
         }
         let task = URLSession.shared.dataTask(with: request as URLRequest) {  data,  response,  error in
            // Your code
         }
         task.resume()
    }
    ```

## Intercept URLSession Delegate for Custom Network Collection {#urlsession_interceptor}

The SDK provides a class `FTURLSessionDelegate`, which can be used to customize **RUM Resource collection** and **trace tracking** for network requests initiated by a specific URLSession.

* `FTURLSessionDelegate` supports intercepting `URLResquest` via the `traceInterceptor` block to perform custom trace tracking (supported by SDK version 1.5.9 and above). This has higher priority than `FTTraceConfig.traceInterceptor`.
* `FTURLSessionDelegate` supports setting the `provider` block to customize additional attributes for RUM Resource collection, with higher priority than `FTRumConfig.resourcePropertyProvider`.
* When used together with `FTRumConfig.enableTraceUserResource` and `FTTraceConfig.enableAutoTrace`, the priority order is: **Custom > Auto Collection**.

Below are three methods to meet different user scenarios.

### Method One

Directly set the URLSession delegate object to an instance of `FTURLSessionDelegate`.

=== "Objective-C"

    ```objective-c
    id<NSURLSessionDelegate> delegate = [[FTURLSessionDelegate alloc]init];
    // Add custom RUM resource attributes, it is recommended to add project abbreviation prefix to tag names, e.g., `df_tag_name`.
    delegate.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
    // Support custom trace, confirm interception and return TraceContext, return nil if not intercepted
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
    // Add custom RUM resource attributes, it is recommended to add project abbreviation prefix to tag names, e.g., `df_tag_name`.
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
    // Support custom trace, confirm interception and return TraceContext, return nil if not intercepted   
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

Make the URLSession delegate object inherit from the `FTURLSessionDelegate` class.

If the delegate object implements the following methods, ensure you call the corresponding super methods within them.

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
            // Add custom RUM resource attributes, it is recommended to add project abbreviation prefix to tag names, e.g., `df_tag_name`.
            self.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
            NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            return @{@"df_requestbody":body};
        };
            // Support custom trace, confirm interception and return TraceContext, return nil if not intercepted
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
        // Make sure to call the superclass method
        [super URLSession:session task:task didFinishCollectingMetrics:metrics];
        // Your logic
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
            // Add custom RUM resource attributes, it is recommended to add project abbreviation prefix to tag names, e.g., `df_tag_name`.
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
            // Support custom trace, confirm interception and return TraceContext, return nil if not intercepted
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
            // Make sure to call the superclass method
            super.urlSession(session, task: task, didFinishCollecting: metrics)
            // User's own logic
            // ......
        }
    }
    ```

### Method Three

Make the URLSession delegate object conform to the `FTURLSessionDelegateProviding` protocol.

* Implement the getter method for the `ftURLSessionDelegate` property in the protocol.
* Forward the following URLSession delegate methods to `ftURLSessionDelegate` so that the SDK can collect data.
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
             // Add custom RUM resource attributes, it is recommended to add project abbreviation prefix to tag names, e.g., `df_tag_name`.
            _ftURLSessionDelegate.provider =  ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
              // Support custom trace, confirm interception and return TraceContext, return nil if not intercepted
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
            // Add custom RUM resource attributes, it is recommended to add project abbreviation prefix to tag names, e.g., `df_tag_name`.
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
            // Support custom trace, confirm interception and return TraceContext, return nil if not intercepted
            ftURLSessionDelegate.traceInterceptor = { request in
                let traceContext = FTTraceContext()
                traceContext.traceHeader = ["trace_key":"trace_value"]
                traceContext.spanId = "spanId"
                traceContext.traceId = "traceId"
                return traceContext
            }
        }
        // The following methods must be implemented
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
    // Call this method after a successful user login to bind user information
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // Call this method after a user logs out to unbind user information
    [[FTMobileAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // Call this method after a successful user login to bind user information
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // Call this method after a user logs out to unbind user information
    FTMobileAgent.sharedInstance().unbindUser()
    ```

## Shutdown SDK

Use `FTMobileAgent` to shut down the SDK.

### Usage Method

=== "Objective-C"

    ```objective-c
    /// Shutdown running objects inside the SDK
    + (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// Shutdown running objects inside the SDK
    open class func shutDown()
    ```
### Code Example

=== "Objective-C"

    ```objective-c
    // If dynamically changing the SDK configuration, shutdown first to avoid incorrect data generation
    [FTMobileAgent  shutDown];
    ```  

=== "Swift"

    ```swift
    // If dynamically changing the SDK configuration, shutdown first to avoid incorrect data generation
    FTMobileAgent.shutDown()
    ```

## Clear SDK Cache Data

Use `FTMobileAgent` to clear unsent cached data.

### Usage Method

=== "Objective-C"

	```objective-c
	/// Clear all unsent data to the server
	+ (void)clearAllData;
	```

=== "Swift"


	``` swift
	/// Clear all unsent data to the server
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

## Sync Data Actively

Use `FTMobileAgent` to sync data actively.
> Only need to manually sync data when `FTMobileConfig.autoSync = NO`
### Usage Method

=== "Objective-C"

    ```objective-c
    /// Sync data actively
    - (void)flushSyncData;
    ```

=== "Swift"

    ```swift
    /// Sync data actively
    func flushSyncData()
    ```

### Code Example

=== "Objective-C"

    ```objective-c
    [[FTMobileAgent sharedInstance] flushSyncData];
    ```  

=== "Swift"

    ```swift
    // If dynamically changing the SDK configuration, shutdown first to avoid incorrect data generation
    FTMobileAgent.sharedInstance().flushSyncData()
    ```

## Add Custom Tags 

Use `FTMobileAgent` to dynamically add tags while the SDK is running.

### Usage Method

=== "Objective-C"

    ```objective-c
    /// Add global tags for the SDK, applied to RUM and Log data
    /// - Parameter context: Custom data
    + (void)appendGlobalContext:(NSDictionary <NSString*,id>*)context;
    
    /// Add custom RUM tags, applied to RUM data
    /// - Parameter context: Custom data
    + (void)appendRUMGlobalContext:(NSDictionary <NSString*,id>*)context;
    
    /// Add global Log tags, applied to Log data
    /// - Parameter context: Custom data
    + (void)appendLogGlobalContext:(NSDictionary <NSString*,id>*)context;
    ```

=== "Swift"

    ```swift
    /// Add global tags for the SDK, applied to RUM and Log data
    /// - Parameter context: Custom data
    open class func appendGlobalContext(_ context: [String : Any])
    
    /// Add custom RUM tags, applied to RUM data
    /// - Parameter context: Custom data
    open class func appendRUMGlobalContext(_ context: [String : Any])
    
    /// Add global Log tags, applied to Log data
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
    let rumGlobalContext = ["rum_key":"rum_value"]
    FTMobileAgent.appendRUMGlobalContext(rumGlobalContext)
    let logGlobalContext = ["log_key":"log_value"]
    FTMobileAgent.appendLogGlobalContext(logGlobalContext)
    ```

## Symbol File Upload {#source_map}

### Adding Run Script Phase in Xcode

1. Add a custom Run Script Phase in Xcode: `Build Phases -> + -> New Run Script Phase`

2. Copy the script into the run script phase of your Xcode project, and set parameters like `<app_id>`, `<datakit_address>`, `<env>`, `<dataway_token>` in the script.

3. Script: [FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

```sh
# Parameters that need to be configured in the script
#＜app_id＞
FT_APP_ID="YOUR_APP_ID"
#<datakit_address>
FT_DATAKIT_ADDRESS="YOUR_DATAKIT_ADDRESS"
#<env> Environment field. Values: prod/gray/pre/common/local. Must match the SDK settings
FT_ENV="common"
#<dataway_token> Token from the dataway section in the `datakit.conf` file
FT_TOKEN="YOUR_DATAWAY_TOKEN"
# Whether to only zip dSYM files (optional, default 0 upload), 1=do not upload, only zip dSYM, 0=upload, you can find the DSYM_SYMBOL.zip file path by searching for `FT_DSYM_ZIP_FILE` in the script logs
FT_DSYM_ZIP_ONLY=0
```

If you need to upload symbol files for multiple environments, refer to the following approach.

#### Multi-environment Configuration Parameters {#multi_env_param}

Example: Using `.xcconfig` files for multi-environment configuration

**1. Create xcconfig files and configure variables in the `.xcconfig` file**

Creating xcconfig files can be done by referring to: [Adding a Build Configuration File to Your Project](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project)

```sh
// If using CocoaPods, add the path of the Pods' .xcconfig file to your .xcconfig file
// Import corresponding .xcconfig of Pods
#include "Pods/Target Support Files/Pods-GuanceDemo/Pods-GuanceDemo.pre.xcconfig"

SDK_APP_ID = app_id_common
SDK_ENV = common
// URL // Needs to include $()
SDK_DATAKIT_ADDRESS = http:/$()/xxxxxxxx:9529
SDK_DATAWAY_TOKEN = token
```

At this point, user-defined parameters have been automatically added and can be viewed through `Target —> Build Settings -> + -> Add User-Defined Setting`

![](../img/multi-environment-configuration2.png)

**2. Configure parameters in the script**

```sh
# Parameters that need to be configured in the script
#＜app_id＞
FT_APP_ID=${SDK_APP_ID}
#<datakit_address>
FT_DATAKIT_ADDRESS=${SDK_DATAKIT_ADDRESS}
#<env> Environment field. Values: prod/gray/pre/common/local. Must match the SDK settings
FT_ENV=${SDK_ENV}
#<dataway_token> Token from the dataway section in the `datakit.conf` file
FT_TOKEN=${SDK_DATAWAY_TOKEN}
```

**3. Configure the SDK**

Map parameters in the `Info.plist` file

![](../img/multi-environment-configuration8.png)

Get parameters from `Info.plist` to configure the SDK

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let info = Bundle.main.infoDictionary!
        let appid:String = info["SDK_APP_ID"] as! String
        let env:String  = info["SDK_ENV"] as! String

        let config = FTMobileConfig.init(datakitUrl: UserDefaults.datakitURL)
        config.enableSDKDebugLog = true
        config.autoSync = false
        config.env = env
        .....
}
```

Detailed configurations can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo) for multi-environment usage.

### Terminal Script Execution

[Script: FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

**Command Format:**

`sh FTdSYMUpload.sh <datakit_address> <app_id> <version> <env> <dataway_token> <dSYMBOL_src_dir> <dSYM_ZIP_ONLY>`

> Example:
>
> sh FTdSYMUploader.sh  http://10.0.0.1:9529 appid_mock 1.0.6 prod tkn_mock /Users/mock/Desktop/dSYMs

**Parameter Description:**

- `<datakit_address>`: Address of the DataKit service, such as `http://localhost:9529`
- `<app_id>`: Corresponds to the RUM `applicationId`
- `<env>`: Corresponds to the RUM `env`
- `<version>`: Application version, value of `CFBundleShortVersionString`
- `<dataway_token>`: Token from the `dataway` section in the `datakit.conf` file
- `<dSYMBOL_src_dir>`: Path to the directory containing all `.dSYM` files.
- `<dSYM_ZIP_ONLY>`: Whether to only zip dSYM files. Optional. 1=do not upload, only zip dSYM; 0=upload, you can find the Zip file path by searching for `FT_DSYM_ZIP_FILE` in the script logs.

### Manual Upload

Refer to [Sourcemap Upload](../sourcemap/set-sourcemap.md#uplo)

## Widget Extension Data Collection

### Widget Extension Data Collection Support

* Logger Custom Logs
* Trace Link Tracing
* RUM Data Collection
    * Manual Collection ([RUM User Data Tracking](#rum))
    * Automatic Collection of Crash Logs and HTTP Resource Data

Since HTTP Resource data is bound to Views, users need to manually collect View data.

### Widget Extension Collection Configuration

Use `FTExtensionConfig` to configure automatic switches and file sharing Group Identifier for Widget Extension data collection. Other configurations use the main project SDK settings.

| **Field**                   | **Type**  | **Required**           | **Description**                                       |
| -------------------------- | --------- | ------------------ | ---------------------------------------------- |
| groupIdentifier            | NSString  | Yes                 | File sharing Group Identifier                      |
| enableSDKDebugLog          | BOOL      | No (default NO)       | Set whether to allow SDK to print Debug logs               |
| enableTrackAppCrash        | BOOL      | No (default NO)       | Set whether to collect crash logs                       |
| enableRUMAutoTraceResource | BOOL      | No (default NO)       | Set whether to track user network requests (only for native http) |
| enableTracerAutoTrace      | BOOL      | No (default NO)       | Set whether to enable automatic HTTP trace                |
| memoryMaxCount             | NSInteger | No (default 1000 entries) | Maximum number of data entries saved in Widget Extension         |

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

In the main project, ensure that `FTMobileConfig` is set with `groupIdentifiers`.

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

### Uploading Collected Data from Widget Extension

The Widget Extension SDK only implements data collection, and the data upload logic is handled by the main project's SDK. The timing for syncing collected data to the main project is customized by the user.

#### Usage Method

=== "Objective-C"

    ```objective-c
    // Call in the main project
    /// Track cached data in App Extension groupIdentifier
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: Callback after tracking is complete
    - (void)trackEventFromExtensionWithGroupIdentifier:(NSString *)groupIdentifier completion:(nullable void (^)(NSString *groupIdentifier, NSArray *events)) completion;
    ```

=== "Swift"

    ```swift
    /// Track cached data in App Extension groupIdentifier
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: Callback after tracking is complete
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
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) into the accessed web pages.

## Custom Tag Usage Examples {#user-global-context}

### Compilation Configuration Method

You can create multiple Configurations and use preprocessor directives to set values.

1. Create multiple Configurations

![](../img/image_9.png)

2. Set preset properties to distinguish different Configurations

![](../img/image_10.png)

3. Use preprocessor directives

```objectivec
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS for configuration
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
... // other setup operations
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

You can also refer to the [Multi-environment Configuration Parameters](#multi_env_param) method for configuration.

### Runtime Read/Write File Method

Because RUM starts with globalContext settings that will not take effect, users can save changes locally, such as using `NSUserDefaults`, and set them when configuring the SDK for the next app launch.

1. Save custom tag data to a local file, e.g., `NSUserDefaults`, and add code to retrieve tag data during SDK configuration.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... // other setup operations
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. Add methods to change file data at any location.

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. Finally, restart the application to take effect.

### Adding Tags During SDK Runtime

After initializing the SDK, use `[FTMobileAgent appendGlobalContext:globalContext]`, `[FTMobileAgent appendRUMGlobalContext:globalContext]`, and `[FTMobileAgent appendLogGlobalContext:globalContext]` to dynamically add tags. These settings will take effect immediately. Subsequently, RUM or Log data reported will automatically include tag data. This method is suitable for scenarios where tag data needs to be obtained via network request.

```objective-c
// Pseudo-code for SDK initialization, get
[FTMobileAgent startWithConfigOptions:config];

-(void)getInfoFromNet:(Info *)info{
	NSDictionary *globalContext = @{@"delay_key", info.value}
	[FTMobileAgent appendGlobalContext:globalContext];
}
```

## tvOS Data Collection

> API >= tvOS 12.0

The initialization and usage of the SDK are consistent with iOS.

**Note that tvOS does not support**:

* `WebView` data detection

* `FTRumConfig.errorMonitorType` for device battery monitoring

## Common Issues {#FAQ}

### About Crash Log Analysis {#crash-log-analysis}

During development in **Debug** and **Release** modes, captured thread traces when a **Crash** occurs are symbolicated. However, for release packages without symbol tables, key threads in the crash log show up as hexadecimal memory addresses and cannot pinpoint the crashing code. Therefore, it is necessary to parse the 16-bit hexadecimal memory addresses back to the corresponding classes and methods.

#### How to Find dSYM Files After Compilation or Packaging

* In Xcode, dSYM files are typically generated alongside the compiled .app file and located in the same directory.
* If you have archived your project, you can find the archive in Xcode’s `Window` menu by selecting `Organizer`, then choose the corresponding archive. Right-click on the archive and select `Show in Finder`. In Finder, locate the corresponding `.xcarchive` file. Right-click on the `.xcarchive` file and choose `Show Package Contents`, then navigate to the `dSYMs` folder to find the corresponding dSYM file.

#### Why Are There No dSYM Files Generated After Xcode Compilation?

Xcode Release builds generate dSYM files by default, while Debug builds do not. Corresponding Xcode settings are as follows:

`Build Settings -> Code Generation -> Generate Debug Symbols -> Yes` 

![](../img/dsym_config1.png)


`Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File`

![](../img/dsym_config2.png)

#### How to Upload Symbol Tables When BitCode is Enabled?

When you upload your bitcode-enabled App to the App Store, check the box to declare symbol file (dSYM file) generation in the submission dialog:

- Before configuring symbol table files, download the corresponding dSYM file for the version from App Store. Do not integrate the script into the Target of the Xcode project, nor use the locally generated dSYM file to generate symbol table files because the symbol information in the locally compiled dSYM file is hidden. If you upload the locally generated dSYM file, the deobfuscated results will be similar to “__hidden#XXX”.

#### How to Retrieve dSYM Files for Apps Already Released to the App Store?

| Distribution Options in App Store Connect | dSym File                                                     |
| -------------------------------------------------- | ------------------------------------------------------------ |
| Don’t include bitcode<br>Upload symbols            | Through Xcode                                                |
| Include bitcode<br>Upload symbols                  | Through iTunes Connect<br />Through Xcode, requiring `.bcsymbolmap` for obfuscation handling. |
| Include bitcode<br>Don’t upload symbols            | Through Xcode, requiring `.bcsymbolmap` for obfuscation handling.       |
| Don’t include bitcode<br>Don’t upload symbols      | Through Xcode                                                |

##### Retrieving via Xcode

1. `Xcode -> Window -> Organizer`

2. Select the `Archives` tab

    ![](../img/xcode_find_dsym2.png)
   
3. Find the released archive, right-click on the corresponding archive and choose `Show in Finder`

    ![](../img/xcode_find_dsym3.png)

   

4. Right-click on the located archive file and choose `Show Package Contents`

    ![](../img/xcode_find_dsym4.png)

   

5. Choose the `dSYMs` directory; the directory contains the downloaded dSYM files

    ![](../img/xcode_find_dsym5.png)

##### Retrieving via iTunes Connect

1. Log in to [App Store Connect](https://appstoreconnect.apple.com);
2. Go to "My Apps"
3. In "App Store" or "TestFlight", choose a specific version, click "Build Metadata". On this page, click the button "Download dSYM" to download the dSYM file.

##### Handling `.bcsymbolmap` Deobfuscation

When finding dSYM files through Xcode, you can see the BCSymbolMaps directory

![](../img/BCSymbolMaps.png)

Open the terminal and use the following command for deobfuscation

`xcrun dsymutil -symbol-map <BCSymbolMaps_path> <.dSYM_path>`

### Adding Global Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix tag names with an abbreviation of the project, such as `df_tag_name`. You can [query source code](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTMobileSDK/FTSDKCore/BaseUtils/Base/FTConstants.m) for key values used in the project. When global variables in the SDK conflict with RUM or Log variables, RUM or Log will override the global variables in the SDK.

## Conclusion

This document provides comprehensive guidance on integrating the Guance SDK into iOS/tvOS applications, including prerequisites, installation steps, SDK initialization, configuration options for RUM, Log, and Trace functionalities, and advanced topics like customizing data collection and handling crashes. It also covers best practices for ensuring accurate and efficient data collection and troubleshooting common issues. By following these instructions, developers can effectively monitor and analyze the performance and behavior of their iOS/tvOS applications using Guance's powerful monitoring capabilities.