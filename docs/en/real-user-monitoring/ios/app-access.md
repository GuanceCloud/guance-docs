# iOS/tvOS Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect various iOS application Metrics data and analyze the performance of each iOS application endpoint in a visualized way.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites will be automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);  
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit must be configured as [publicly accessible with IP geolocation information database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#iOS-integration}

Log in to the <<< custom_key.brand_name >>> console, go to the **User Access Monitoring** page, click on the top-left **[Create Application](../index.md#create)** to start creating a new application.

![](../img/6.rum_ios.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img-shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![tvOS](https://img.shields.io/badge/dynamic/json?label=tvOS&color=brightgreen&query=$.tvos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1. Configure the `Podfile`.
    
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
    
        * [Download the repository locally and use it](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
          
          **`Podfile`:**
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
          `folder_path`: The path to the folder where `FTMobileSDK.podspec` is located.
    
          **`FTMobileSDK.podspec` file:**
          
          Modify `s.version` and `s.source` in the `FTMobileSDK.podspec` file.
          ```
          Pod::Spec.new do |s|
            s.name         = "FTMobileSDK"
            s.version      = "[latest_version]"  
            s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
          end
          ```
          
          `s.version`: Change to the specified version, preferably consistent with `SDK_VERSION` in `FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`.
          
          `s.source`: `tag => s.version`
    
    2. Run `pod install` in the `Podfile` directory to install the SDK.

=== "Carthage" 

    1. Configure the `Cartfile`.
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
       
        The generated xcframework is used the same way as an ordinary Framework. Add the compiled libraries to your project.
        
        `FTMobileAgent`: Add to the main project Target, supporting iOS and tvOS platforms.
        
        `FTMobileExtension`: Add to the Widget Extension Target.
    
    3. Add `-ObjC` to `TARGETS` -> `Build Setting` -> `Other Linker Flags`.
    
    4. When using Carthage integration, SDK versions supported:
       
        `FTMobileAgent`: >=1.3.4-beta.2 
    
        `FTMobileExtension`: >=1.4.0-beta.1

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, click the **+** under the `Packages` column.
    
    2. In the search box of the pop-up page, input `https://github.com/GuanceCloud/datakit-ios.git`.
    
    3. After Xcode successfully retrieves the package, the SDK configuration page will be displayed.
    
        `Dependency Rule`: It is recommended to select `Up to Next Major Version`.
    
        `Add To Project`: Choose the supported project.
        
        After filling out the configuration, click the `Add Package` button and wait for the loading to complete.
    
    4. In the pop-up `Choose Package Products for datakit-ios`, select the Target that needs to add the SDK, click the `Add Package` button. At this point, the SDK has been successfully added.
    
        `FTMobileSDK`: Add to the main project Target
        
        `FTMobileExtension`: Add to the Widget Extension Target
        
        If your project is managed by SPM, add the SDK as a dependency, adding `dependencies` to `Package.swift`.
    
        ```plaintext
        // Main project
        dependencies: [
            .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",
            .upToNextMajor(from: "[latest_version]"))]
        ```
    
    5. Swift Package Manager is supported from version 1.4.0-beta.1 and above.

### Adding Header Files

=== "Objective-C"

    ```
    //CocoaPods, SPM 
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
| datakitUrl | NSString | Yes | Datakit access address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, the device installing the SDK needs to access this address. **Note: Only one of datakit and dataway configurations should be selected** |
| datawayUrl | NSString | Yes | Public Dataway access address, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, the device installing the SDK needs to access this address. **Note: Only one of datakit and dataway configurations should be selected** |
| clientToken | NSString | Yes | Authentication token, must be used together with datawayUrl                               |
| enableSDKDebugLog | BOOL | No | Set whether to allow printing logs. Default `NO` |
| env | NSString | No | Set the collection environment. Default `prod`, supports customization, can also set via the provided `FTEnv` enumeration through `-setEnvWithType:` method |
| service | NSString | No | Set the name of the business or service it belongs to. Affects Log and RUM service field data. Default: `df_rum_ios` |
| globalContext | NSDictionary |     No | Add custom tags. Refer to [here](#key-conflict) for addition rules |
| groupIdentifiers | NSArray | No | Array of AppGroups Identifier corresponding to the Widget Extensions that need to be collected. If Widget Extensions data collection is enabled, then this must be set [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups), and configure the Identifier to this property |
| autoSync | BOOL | No | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use `[[FTMobileAgent sharedInstance] flushSyncData]` to manage data synchronization manually |
| syncPageSize | int | No | Set the number of entries per synchronization request. Range [5,), Note: The larger the number of entries requested, the more computational resources are consumed for data synchronization, default is 10 |
| syncSleepTime | int | No | Set the interval between synchronizations. Range [0,5000], default not set |
| enableDataIntegerCompatible | BOOL | No | Suggest enabling if coexistence with web data is required. This setting handles storage compatibility issues for web data types |
| compressIntakeRequests | BOOL | No | Compress synchronized data. Supported by SDK version 1.5.6 and above, default off |
| enableLimitWithDbSize       | BOOL             | No       | Enable the feature of limiting total cache size using DB.<br>**Note:** Enabling this will make `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` ineffective. Supported by SDK version 1.5.8 and above |
| dbCacheLimit                | long             | No       | DB cache limit size. Range [30MB,), default 100MB, unit byte, Supported by SDK version 1.5.8 and above |
| dbDiscardType               | FTDBCacheDiscard | No       | Set data discard rules in the database. Default `FTDBDiscard`<br/>`FTDBDiscard` discards appended data when the number exceeds the maximum value. `FTDBDiscardOldest` discards old data when the number exceeds the maximum value. Supported by SDK version 1.5.8 and above |

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
| appid | NSString | Yes | User access monitoring application ID uniquely identifies. Corresponds to setting RUM `appid`, enabling the collection function of `RUM`, [How to obtain appid](#iOS-integration) |
| samplerate | int | No | Sampling rate. Range [0,100], 0 means no collection, 100 means full collection, default value is 100. Scope includes all View, Action, LongTask, Error data within the same session_id |
| enableTrackAppCrash | BOOL | No | Set whether to collect crash logs. Default `NO` |
| enableTrackAppANR | BOOL | No | Collect ANR events where the app is unresponsive. Default `NO` |
| enableTrackAppFreeze | BOOL | No | Collect UI freeze events. Default `NO`<br>Can set freeze threshold via `-setEnableTrackAppFreeze:freezeDurationMs:` method |
| freezeDurationMs | long | No | Set UI freeze threshold, range [100,), unit milliseconds, default 250ms. Supported by SDK version 1.5.7 and above |
| enableTraceUserView | BOOL | No | Set whether to track user View operations. Default `NO` |
| enableTraceUserAction | BOOL | No | Set whether to track user Action operations. Default `NO` |
| enableTraceUserResource | BOOL | No | Set whether to track user network requests. Default `NO`, only applies to native http<br>Note: Network requests initiated via `[NSURLSession sharedSession]` cannot collect performance data;<br>SDK 1.5.9 and above support collecting network requests initiated via **Swift's URLSession async/await APIs**. |
| resourceUrlHandler | FTResourceUrlHandler | No | Custom resource collection rules. Default does not filter. Return: NO means to collect, YES means not to collect. |
| errorMonitorType | FTErrorMonitorType | No | Additional error event monitoring type. Adds monitoring information to the collected crash data. `FTErrorMonitorBattery` for battery level, `FTErrorMonitorMemory` for memory usage, `FTErrorMonitorCpu` for CPU occupancy |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No | View performance monitoring type. Adds corresponding monitoring item information to the collected **View** data. `FTDeviceMetricsMonitorMemory` monitors current application memory usage, `FTDeviceMetricsMonitorCpu` monitors CPU jump count, `FTDeviceMetricsMonitorFps` monitors screen frame rate |
| monitorFrequency | FTMonitorFrequency | No | View performance monitoring sampling cycle. Configure `monitorFrequency` to set the sampling cycle for **View** monitoring item information. `FTMonitorFrequencyDefault`500ms (default), `FTMonitorFrequencyFrequent`100ms, `FTMonitorFrequencyRare`1000ms. |
| enableResourceHostIP | BOOL | No | Whether to collect the IP address of the requested target domain name. Supported on `>= iOS 13.0` `>= tvOS 13.0` |
| globalContext | NSDictionary | No | Add custom tags for user monitoring data source differentiation. If tracking functionality is needed, the parameter `key` should be `track_id`, `value` any numerical value. Refer to [here](#key-conflict) for addition rule notes |
| rumCacheLimitCount | int                        | No | Maximum RUM cache volume. Default 100_000, SDK 1.5.8 and above support this parameter |
| rumDiscardType | FTRUMCacheDiscard          | No | Set RUM discard rules. Default `FTRUMCacheDiscard` <br/>`FTRUMCacheDiscard` discards appended data when RUM data exceeds the maximum value. `FTRUMDiscardOldest` discards old data when RUM data exceeds the maximum value. SDK 1.5.8 and above support this parameter |
| resourcePropertyProvider | FTResourcePropertyProvider | No | Add custom attributes to RUM Resource via block callback. SDK 1.5.10 and above support this parameter. Priority lower than [URLSession custom collection](#urlsession_interceptor) |

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
| samplerate | int | No | Sampling rate. Range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| enableCustomLog | BOOL | No | Whether to upload custom log. Default `NO` |
| printCustomLogToConsole | BOOL | No | Set whether to output custom logs to the console. Default `NO`, refer to [output format](#printCustomLogToConsole) for custom logs |
| logLevelFilter | NSArray | No | Set the status array of custom logs to be collected. Default collects all |
| enableLinkRumData | BOOL | No | Whether to link with RUM data. Default `NO` |
| globalContext | NSDictionary |     No | Add custom log tags. Refer to [here](#key-conflict) for addition rules |
| logCacheLimitCount | int | No | Local maximum log entry cache limit [1000,), the larger the log, the greater the disk cache pressure, default 5000 |
| discardType | FTLogCacheDiscard | No | Set log discard rules when the limit is exceeded. Default `FTDiscard` <br/>`FTDiscard` discards appended log data when the log data quantity exceeds the maximum value (5000). `FTDiscardOldest` discards old data when log data exceeds the maximum value. |

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
| samplerate | int | No | Sampling rate. Range [0,100], 0 means no collection, 100 means full collection, default value is 100. |
| networkTraceType | FTNetworkTraceType | No | Set the type of link tracing. Default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C). If choosing a corresponding link type when integrating OpenTelemetry, please check the supported types and agent related configurations |
| enableLinkRumData | BOOL | No | Whether to link with RUM data. Default `NO` |
| enableAutoTrace | BOOL | No | Set whether to enable automatic http trace. Default `NO`, currently only supports NSURLSession |
| traceInterceptor | FTTraceInterceptor | No | Supports determining whether to perform custom link tracing via URLRequest. Confirm interception and return `TraceContext`, return nil if not intercepted. SDK 1.5.10 and above support this parameter. Priority lower than [URLSession custom collection](#urlsession_interceptor) |

## RUM User Data Tracking {#rum}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition effects or manually use `FTExternalDataManager` to add these data. Example below:

### View

#### Usage Method

=== "Objective-C"

    ```objective-c
    /// Create a page
    ///
    /// Call before the `-startViewWithName` method. This method records the page load time. If the load time cannot be obtained, this method can be omitted.
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
    /// Call before the `-startViewWithName` method. This method records the page load time. If the load time cannot be obtained, this method can be omitted.
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
    /// RUM binds the possible triggered Resource, Error, LongTask events of this Action. Avoid adding multiple times within 0.1 s. Only one Action is associated with the same View at the same time. New Actions added while the previous Action has not ended will be discarded.
    /// This method of adding Action does not affect the Action added via `addAction:actionType:property`.
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom properties (optional)
    - (void)startAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    
    /// Add Action event without duration and discard logic.
    ///
    /// Does not affect the RUM Action started via `startAction:actionType:property:`.
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom properties (optional)
    - (void)addAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Start RUM Action.
    ///
    /// RUM binds the possible triggered Resource, Error, LongTask events of this Action. Avoid adding multiple times within 0.1 s. Only one Action is associated with the same View at the same time. New Actions added while the previous Action has not ended will be discarded.
    /// This method of adding Action does not affect the Action added via `addAction:actionType:property`.
    ///
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom properties (optional)
    open func startAction(_ actionName: String, actionType: String, property: [AnyHashable : Any]?)
    
    /// Add Action event without duration and discard logic.
    ///
    /// Does not affect the RUM Action started via `startAction:actionType:property:`.
    /// - Parameters:
    ///   - actionName: Event name
    ///   - actionType: Event type
    ///   - property: Event custom properties (optional)
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
    ///   - stack: Stack trace
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    - (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - state: Program running state
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    - (void)addErrorWithType:(NSString *)type state:(FTAppState)state  message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add Error event
    ///
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack trace
    open func addError(withType: String, message: String, stack: String)
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
    ///   - message: Error message
    ///   - stack: Stack trace
    ///   - property: Event custom properties (optional)
    open func addError(withType: String, message: String, stack: String, property: [AnyHashable : Any]?)
    
    /// Add Error event
    /// - Parameters:
    ///   - type: error type
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
    /// Add freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
    
    /// Add freeze event
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Event custom properties (optional)
    - (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Add freeze event
    ///
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    func addLongTask(withStack: String, duration: NSNumber)
    
    /// Add freeze event
    /// - Parameters:
    ///   - stack: Freeze stack
    ///   - duration: Freeze duration (nanoseconds)
    ///   - property: Event custom properties (optional)
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
    /// HTTP request start
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)startResourceWithKey:(NSString *)key;
    /// HTTP request start
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
    /// HTTP request end
    ///
    /// - Parameters:
    ///   - key: Request identifier
    - (void)stopResourceWithKey:(NSString *)key;
    /// HTTP request end
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    - (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
    ```
=== "Swift"

    ```swift
    /// HTTP request start
    ///
    /// - Parameters:
    ///   - key: Request identifier
    open func startResource(withKey key: String)
    
    /// HTTP request start
    /// - Parameters:
    ///   - key: Request identifier
    ///   - property: Event custom properties (optional)
    open func startResource(withKey key: String, property: [AnyHashable : Any]?)
    
    /// HTTP request end
    ///
```swift
    /// - Parameters:
    ///   - key: Request identifier
    open func stopResource(withKey key: String)
    
    /// HTTP request end
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
    // Step 1: Before the request starts
    [[FTExternalDataManager sharedManager] startResourceWithKey:key];
    
    // Step 2: When the request completes
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
    
    // If time data for each stage can be obtained 
    // FTResourceMetricsModel
    // Directly use the initialization method of FTResourceMetricsModel if NSURLSessionTaskMetrics data is obtained from ios native
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
    
    // Other platforms with all time data in nanoseconds
    FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
    
    // Step 4: Add resource. Pass nil for metrics if no time data is available
    [[FTExternalDataManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    // Step 1: Before the request starts
    FTExternalDataManager.shared().startResource(withKey: key)
    
    // Step 2: When the request completes
    FTExternalDataManager.shared().stopResource(withKey: resource.key)
    
    // Step 3: ① Concatenate Resource data
    let contentModel = FTResourceContentModel(request: task.currentRequest!, response: task.response as? HTTPURLResponse, data: resource.data, error: error)
    
    // ② If time data for each stage can be obtained 
    // FTResourceMetricsModel
    // Directly use the initialization method of FTResourceMetricsModel if NSURLSessionTaskMetrics data is obtained from ios native
    var metricsModel:FTResourceMetricsModel?
    if let metrics = resource.metrics {
       metricsModel = FTResourceMetricsModel(taskMetrics:metrics)
    }
    // All time data in nanoseconds for other platforms
    metricsModel = FTResourceMetricsModel()
    ...
    
    // Step 4: Add resource. Pass nil for metrics if no time data is available
    FTExternalDataManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logger Log Printing {#user-logger}

During SDK initialization [Log Configuration](#log-config), configure `enableCustomLog` to allow custom log addition.
> Currently, the log content is limited to 30 KB, and any exceeding characters will be truncated.
### Usage Method

=== "Objective-C"

    ```objectivec
    //  FTMobileAgent.h
    //  FTMobileSDK
    
    /// Log reporting
    /// @param content Log content, can be a json string
    /// @param status Event level and status
    -(void)logging:(NSString *)content status:(FTStatus)status;
    
    /// Log reporting
    /// @param content Log content, can be a json string
    /// @param status Event level and status
    /// @param property Event properties
    -(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;
    ```
    
    ```objective-c
    //
    //  FTLogger.h
    //  FTMobileSDK
    
    /// Add custom info type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)info:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add custom warning type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)warning:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add custom error type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)error:(NSString *)content  property:(nullable NSDictionary *)property;
    
    /// Add custom critical type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    -(void)critical:(NSString *)content property:(nullable NSDictionary *)property;
    
    /// Add custom ok type log
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
    ///   - content: Log content, can be a json string
    ///   - status: Event level and status
    open func logging(_ content: String, status: FTLogStatus)
    
    /// Add custom log
    /// - Parameters:
    ///   - content: Log content, can be a json string
    ///   - status: Event level and status
    ///   - property: Event custom properties (optional)
    open func logging(_ content: String, status: FTLogStatus, property: [AnyHashable : Any]?)
    }
    ```
    
    ```swift
    open class FTLogger : NSObject, FTLoggerProtocol {}
    public protocol FTLoggerProtocol : NSObjectProtocol {
    /// Add custom info type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func info(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom warning type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func warning(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom error type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func error(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom critical type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
    optional func critical(_ content: String, property: [AnyHashable : Any]?)
    
    /// Add custom ok type log
    /// - Parameters:
    ///   - content: Log content
    ///   - property: Custom properties (optional)
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
        /// OK
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
        /// OK
        case statusOk = 4
    }
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // Method One: Through FTMobileAgent
    // Note: Ensure that the SDK has been initialized successfully when using it, otherwise it will fail and crash in the testing environment.
    [[FTMobileAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // Method Two: Through FTLogger (Recommended)
    // If the SDK is not initialized successfully, adding custom logs via methods in FTLogger will fail but there will be no assertion failure or crash.
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Method One: Through FTMobileAgent
    // Note: Ensure that the SDK has been initialized successfully when using it, otherwise it will fail and crash in the testing environment.
    FTMobileAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // Method Two: Through FTLogger (Recommended)
    // If the SDK is not initialized successfully, adding custom logs via methods in FTLogger will fail but there will be no assertion failure or crash.
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### Custom Logs Output to Console {#printCustomLogToConsole}


Set `printCustomLogToConsole = YES`, enabling custom logs to be output to the console. The following format logs will be visible in the xcode debugging console:

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [IOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`: Standard prefix for os_log output;

`[IOS APP]`: Prefix to distinguish custom logs output by the SDK;

`[INFO]`: Level of the custom log;

`content`: Content of the custom log;

`{K=V,...,Kn=Vn}`: Custom properties.

## Trace Network Link Tracing

You can enable automatic mode through `FTTraceConfig` configuration, or support user-defined addition of Trace-related data. Relevant APIs for custom addition are as follows:

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

The SDK provides a class `FTURLSessionDelegate`, which can be used to customize **RUM Resource collection** and **link tracing** for network requests initiated by a specific URLSession.

* `FTURLSessionDelegate` supports setting `traceInterceptor` block to intercept `URLResquest` for custom link tracing (Supported by SDK version 1.5.9 and above), priority > `FTTraceConfig.traceInterceptor`.
* `FTURLSessionDelegate` supports setting `provider` block to customize additional attributes that need to be collected for RUM Resources, priority > `FTRumConfig.resourcePropertyProvider`.
* When used together with `FTRumConfig.enableTraceUserResource` and `FTTraceConfig.enableAutoTrace`, priority: **Custom > Automatic Collection**.

Below are three methods provided to meet different user scenarios.

### Method One

Directly set the delegate object of URLSession to an instance of `FTURLSessionDelegate`.

=== "Objective-C"

    ```objective-c
    id<NSURLSessionDelegate> delegate = [[FTURLSessionDelegate alloc]init];
    // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, e.g., `df_tag_name`.
    delegate.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
    // Support custom trace, return TraceContext if confirmed interception, return nil if not intercepted
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
    // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, e.g., `df_tag_name`.
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
    // Support custom trace, return TraceContext if confirmed interception, return nil if not intercepted   
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

Make the delegate object inherit from the `FTURLSessionDelegate` class.

If the delegate object implements the following methods, ensure that the corresponding methods in the parent class are called within these methods.

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
            // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, e.g., `df_tag_name`.
            self.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
            NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            return @{@"df_requestbody":body};
        };
            // Support custom trace, return TraceContext if confirmed interception, return nil if not intercepted
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
        // Make sure to call the parent class method
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
            session = URLSession.init(configuration: configuration, delegate:self, delegateQueue: nil)
            override init() {
            super.init()
            // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, e.g., `df_tag_name`.
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
            // Support custom trace, return TraceContext if confirmed interception, return nil if not intercepted
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
            // Make sure to call the parent class method
            super.urlSession(session, task: task, didFinishCollecting: metrics)
            // User's own logic
            // ......
        }
    }
    ```

### Method Three

Make the delegate object conform to the `FTURLSessionDelegateProviding` protocol.

* Implement the get method for the `ftURLSessionDelegate` property in the protocol.
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
             // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, e.g., `df_tag_name`.
            _ftURLSessionDelegate.provider =  ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
              // Support custom trace, return TraceContext if confirmed interception, return nil if not intercepted
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
            // Add custom RUM resource attributes, suggest adding project abbreviation prefix to tag names, e.g., `df_tag_name`.
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
            // Support custom trace, return TraceContext if confirmed interception, return nil if not intercepted
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
    ///   - extra: Additional user information
    open func bindUser(withUserID Id: String, userName: String?, userEmail: String?, extra: [AnyHashable : Any]?)
    
    /// Unbind current user
    open func unbindUser()
    ```

### Code Example

=== "Objective-C"

    ```objectivec
    // You can call this method after the user logs in successfully to bind user information
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // You can call this method after the user logs out to unbind user information
    [[FTMobileAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // You can call this method after the user logs in successfully to bind user information
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // You can call this method after the user logs out to unbind user information
    FTMobileAgent.sharedInstance().unbindUser()
    ```

## Closing the SDK

Use `FTMobileAgent` to close the SDK.

### Usage Method

=== "Objective-C"

    ```objective-c
    /// Shut down running objects within the SDK
    + (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// Shut down running objects within the SDK
    open class func shutDown()
    ```
### Code Example

=== "Objective-C"

    ```objective-c
    // If dynamically changing SDK configurations, you need to shut it down first to avoid incorrect data generation
    [FTMobileAgent  shutDown];
    ```  

=== "Swift"

    ```swift
    // If dynamically changing SDK configurations, you need to shut it down first to avoid incorrect data generation
    FTMobileAgent.shutDown()
    ```

## Clearing SDK Cache Data

Use `FTMobileAgent` to clear unsent cache data 

### Usage Method

=== "Objective-C"

	```objective-c
	/// Clear all data yet to be uploaded to the server
	+ (void)clearAllData;
	```

=== "Swift"


	``` swift
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

## Synchronizing Data Actively

Use `FTMobileAgent` to actively synchronize data.
> Active data synchronization is required only when FTMobileConfig.autoSync = NO.
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
    // If dynamically changing SDK configurations, you need to shut it down first to avoid incorrect data generation
    FTMobileAgent.sharedInstance().flushSyncData()
    ```

## Adding Custom Tags 

Use `FTMobileAgent` to dynamically add tags while the SDK is running.

### Usage Method

=== "Objective-C"

    ```objective-c
    /// Add global tags to the SDK, applicable to RUM, Log data
    /// - Parameter context: Custom data
    + (void)appendGlobalContext:(NSDictionary <NSString*,id>*)context;
    
    /// Add custom RUM tags, applicable to RUM data
    /// - Parameter context: Custom data
    + (void)appendRUMGlobalContext:(NSDictionary <NSString*,id>*)context;
    
    /// Add global tags to Log, applicable to Log data
    /// - Parameter context: Custom data
    + (void)appendLogGlobalContext:(NSDictionary <NSString*,id>*)context;
    ```

=== "Swift"

    ```swift
    /// Add global tags to the SDK, applicable to RUM, Log data
    /// - Parameter context: Custom data
    open class func appendGlobalContext(_ context: [String : Any])
    
    /// Add custom RUM tags, applicable to RUM data
    /// - Parameter context: Custom data
    open class func appendRUMGlobalContext(_ context: [String : Any])
    
    /// Add global tags to Log, applicable to Log data
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

1. Add a custom Run Script Phase in Xcode: ` Build Phases -> + -> New Run Script Phase`

2. Copy the script into the run script phase of the Xcode project, and set parameters such as ＜app_id＞、＜datakit_address＞、＜env＞、＜dataway_token＞ in the script.

3. Script: [FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

```sh
# Parameters to be configured in the script
#＜app_id＞
FT_APP_ID="YOUR_APP_ID"
#<datakit_address>
FT_DATAKIT_ADDRESS="YOUR_DATAKIT_ADDRESS"
#<env> Environment field. Property values: prod/gray/pre/common/local. Must be consistent with SDK settings
FT_ENV="common"
#<dataway_token> Token in the configuration file datakit.conf for dataway
FT_TOKEN="YOUR_DATAWAY_TOKEN"
# Whether to only zip dSYM files (optional, default 0 upload), 1=do not upload, only zip dSYM, 0=upload, you can search for FT_DSYM_ZIP_FILE in the script output logs to view the path of DSYM_SYMBOL.zip
FT_DSYM_ZIP_ONLY=0
```

If you need to upload symbol files for multiple environments, you can refer to the method below.

#### Multiple Environment Configuration {#multi_env_param}

Example: Using .xcconfig configuration file for multi-environment configuration

**1. Create xcconfig configuration file, configure variables in the .xcconfig file**.

Create xcconfig configuration file method can be referenced: [Adding a build configuration file to your project](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project)

```sh
// If using cocoapods, need to add the path of pods .xcconfig to your .xcconfig file
// Import corresponding .xcconfig of pod
#include "Pods/Target Support Files/Pods-GuanceDemo/Pods-GuanceDemo.pre.xcconfig"

SDK_APP_ID = app_id_common
SDK_ENV = common
// URL // needs to add $()
SDK_DATAKIT_ADDRESS = http:/$()/xxxxxxxx:9529
SDK_DATAWAY_TOKEN = token
```

At this point, the user-defined parameters have been automatically added and can be viewed via `Target —> Build Settings -> + -> Add User-Defined Setting`

![](../img/multi-environment-configuration2.png)

**2. Configure parameters in the script**

```sh
# Parameters to be configured in the script
#＜app_id＞
FT_APP_ID=${SDK_APP_ID}
#<datakit_address>
FT_DATAKIT_ADDRESS=${SDK_DATAKIT_ADDRESS}
#<dev> Environment field. Property values: prod/gray/pre/common/local. Must be consistent with SDK settings
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
        .....
}
```


Detailed details can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo) for multi-environment usage.

### Terminal Running Script

[Script: FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

**Command Format:**

`sh FTdSYMUpload.sh <datakit_address> <app_id> <version> <env> <dataway_token> <dSYMBOL_src_dir> <dSYM_ZIP_ONLY>`

> Example:
>
> sh FTdSYMUploader.sh  http://10.0.0.1:9529 appid_mock 1.0.6 prod tkn_mock /Users/mock/Desktop/dSYMs

**Parameter Description:**

- `<datakit_address>`: Address of the DataKit service, such as `http://localhost:9529`
- `<app_id>`: Corresponds to RUM's `applicationId`
- `<env>`: Corresponds to RUM's `env`
- `<version>`: Application's `version`, value of `CFBundleShortVersionString`
- `<dataway_token>`: Token in the configuration file `datakit.conf` for `dataway`
- `<dSYMBOL_src_dir>`: Directory path containing all `.dSYM` files.
- `<dSYM_ZIP_ONLY>`: Whether to only zip dSYM files. Optional. 1=do not upload, only zip dSYM, 0=upload, you can search for `FT_DSYM_ZIP_FILE` in the script output logs to view the Zip file path.

### Manual Upload

[Source Map Upload](../sourcemap/set-sourcemap.md#uplo)

## Widget Extension Data Collection

### Widget Extension Data Collection Support

* Logger custom logs
* Trace link tracing
* RUM data collection
    * Manual collection ([RUM User Data Tracking](#rum))
    * Automatically collect crash logs, HTTP Resource data

Since HTTP Resource data is bound to View, users need to manually collect View data.

### Widget Extension Collection Configuration

Use `FTExtensionConfig` to configure the automatic switch and file sharing Group Identifier for Widget Extension data collection, other configurations use the already set configurations in the main project SDK.

| **Field**                   | **Type**  | **Required**           | **Description**                                       |
| -------------------------- | --------- | ------------------ | ---------------------------------------------- |
| groupIdentifier            | NSString  | Yes                 | File sharing Group Identifier                      |
| enableSDKDebugLog          | BOOL      | No (default NO)       | Set whether to allow SDK to print Debug logs               |
| enableTrackAppCrash        | BOOL```swift
| No (default NO) | Set whether to collect crash logs |
| enableRUMAutoTraceResource | BOOL | No (default NO) | Set whether to track user network requests (only applies to native http) |
| enableTracerAutoTrace | BOOL | No (default NO) | Set whether to enable automatic http link tracing |
| memoryMaxCount | NSInteger | No (default 1000 entries) | Maximum number of data saved in Widget Extension |

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

    ````swift
    let config = FTMobileConfig.init(metricsUrl: url)
    config.enableSDKDebugLog = true
    config.groupIdentifiers = ["group.com.ft.widget.demo"]
    ````

### Uploading Data Collected by Widget Extension

The Widget Extension SDK only implements data collection; the data upload logic is handled by the main project's SDK. The timing for syncing collected data to the main project is customized by the user.

#### Usage Method

=== "Objective-C"

    ```objective-c
    // Call in the main project
    /// Track cached data in App Extension groupIdentifier
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: Callback after tracking is completed
    - (void)trackEventFromExtensionWithGroupIdentifier:(NSString *)groupIdentifier completion:(nullable void (^)(NSString *groupIdentifier, NSArray *events)) completion;
    ```

=== "Swift"

    ```swift
    /// Track cached data in App Extension groupIdentifier
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: Callback after tracking is completed
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
To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) on the accessed page.

## Custom Tag Usage Example {#user-global-context}

### Compilation Configuration Method

You can create multiple Configurations and use precompiled directives to set values.

1. Create multiple Configurations

![](../img/image_9.png)

2. Set predefined properties to distinguish different Configurations

![](../img/image_10.png)

3. Use precompiled directives

```objectivec
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS for configuration preset definitions
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

You can also refer to the [multi-environment configuration parameters](#multi_env_param) method for configuration.

### Runtime Read/Write File Method

Since RUM globalContext settings after startup will not take effect, users can save them locally and add code to retrieve tag data during the next app launch.

1. Save files locally via `NSUserDefaults`, configure and add code to retrieve tag data where the SDK is configured.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... // other setup operations
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

2. Add a method anywhere to change file data.

```objectivec
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"];
```

3. Finally, restart the application for it to take effect.

### Adding Tags During SDK Runtime

After initializing the SDK, use `[FTMobileAgent appendGlobalContext:globalContext]`, `[FTMobileAgent appendRUMGlobalContext:globalContext]`, `[FTMobileAgent appendLogGlobalContext:globalContext]` to dynamically add tags. These settings will take effect immediately. Subsequently, the data reported by RUM or Log will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be delayed, such as when tag data requires network requests to obtain.

```objective-c
//SDK initialization pseudo-code, retrieving
[FTMobileAgent startWithConfigOptions:config];

-(void)getInfoFromNet:(Info *)info{
	NSDictionary *globalContext = @{@"delay_key", info.value}
	[FTMobileAgent appendGlobalContext:globalContext];
}
```

## tvOS Data Collection

> api >= tvOS 12.0

The initialization and usage of the SDK are consistent with iOS.

**Note that tvOS does not support**:

* `WebView` data detection

* `FTRumConfig.errorMonitorType` battery monitoring for devices

## Common Issues {#FAQ}

### About Crash Log Analysis {#crash-log-analysis}

In **Debug** and **Release** modes during development, captured thread traces at the time of **Crash** are symbolized.
However, in the release package without symbol tables, key threads of the exception will display the image name and won't convert into valid code symbols. The obtained **crash log** information will all be 16-bit memory addresses and cannot locate the crashing code, so it is necessary to parse the 16-bit memory addresses into corresponding classes and methods.

#### How to find dSYM files after compiling or packaging

* In Xcode, dSYM files are typically generated along with the compiled .app file and located in the same directory.
* If you have archived the project, you can select `Organizer` from the `Window` menu in Xcode, then choose the corresponding archive file. Right-click the archive file and select `Show in Finder`. In Finder, locate the corresponding `.xcarchive` file. Right-click the `.xcarchive` file and choose `Show Package Contents`, then enter the `dSYMs` folder to find the corresponding dSYM file.

#### Why isn’t a dSYM file generated after Xcode compilation?

XCode Release compilation defaults to generating a dSYM file, while Debug compilation defaults to not generating one. Corresponding Xcode configurations are as follows:

 ` Build Settings -> Code Generation -> Generate Debug Symbols -> Yes` 

![](../img/dsym_config1.png)


` Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File`

![](../img/dsym_config2.png)




#### How to upload symbol tables if bitCode is enabled?

When you upload your bitcode App to App Store, check the option to declare symbol files (dSYM files) generation in the submission dialog box:

- Before configuring symbol table files, download the corresponding dSYM file for the version from App Store, then process and upload the symbol table file according to input parameters using the script.
- Do not integrate the script into the Target of the Xcode project, nor use the locally generated dSYM file to generate the symbol table file because the symbol table information of the locally compiled dSYM file is hidden. If the locally compiled dSYM file is uploaded, the restored result will be similar to symbols like “__hiden#XXX”.

#### How to recover dSYM files corresponding to apps already published to App Store?

| Application uploaded to App Store Connect Distribution options | dSym files                                                     |
| -------------------------------------------------- | ------------------------------------------------------------ |
| Don’t include bitcode<br>Upload symbols            | Recovered through Xcode                                              |
| Include bitcode<br>Upload symbols                  | Recovered through iTunes Connect<br />Recovered through Xcode, requiring `.bcsymbolmap` processing for obfuscation. |
| Include bitcode<br>Don’t upload symbols            | Recovered through Xcode, requiring `.bcsymbolmap` processing for obfuscation.       |
| Don’t include bitcode<br>Don’t upload symbols      | Recovered through Xcode                                              |

##### Recover through Xcode

1. `Xcode -> Window -> Organizer ` 

2. Select `Archives` tab

    ![](../img/xcode_find_dsym2.png)
   
3. Find the published archive, right-click the corresponding archive and choose `Show in Finder` operation

    ![](../img/xcode_find_dsym3.png)

   

4. Right-click the located archive file and choose `Show Package Contents` operation 

    ![](../img/xcode_find_dsym4.png)

   

5. Select the `dSYMs` directory; the directory contains the downloaded dSYM files.

    ![](../img/xcode_find_dsym5.png)

##### Recover through iTunes Connect

1. Login to [App Store Connect](https://appstoreconnect.apple.com);
2. Enter "My Apps (My Apps)"
3. In "App Store" or "TestFlight", select a specific version, click "Build Metadata". On this page, click the button "Download dSYM" to download the dSYM file.

##### Processing with `.bcsymbolmap` for Deobfuscation

When finding dSYM files through Xcode, you can see the BCSymbolMaps directory.

![](../img/BCSymbolMaps.png)


Open the terminal and use the following command for deobfuscation

`xcrun dsymutil -symbol-map <BCSymbolMaps_path> <.dSYM_path>`

### Adding Global Variables to Avoid Conflicting Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to add a **project abbreviation** prefix to tag names, e.g., `df_tag_name`. You can [query source code](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTMobileSDK/FTSDKCore/BaseUtils/Base/FTConstants.m) for keys used in the project. When global variables in the SDK appear identical to RUM and Log variables, RUM and Log will override the global variables in the SDK.
```