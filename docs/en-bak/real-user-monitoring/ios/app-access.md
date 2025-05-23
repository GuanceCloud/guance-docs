# iOS Application Access

---

Guance Real User Monitoring can analyze the performance of each iOS application in a visual way by collecting the metrics data of each iOS application.

## Precondition

**Note**: If you have activated the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, and you can directly access the application. 

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md); 
- DataKit is configured to be [accessible to the public network and install the IP geographic information database](../../datakit/datakit-tools-how-to.md#install-ipdb).    

## Application Access {#iOS-integration}

Login to Guance Console, enter **Real User Monitoring** page,  click **[New Application](../index.md#create)** in the upper left corner to start creating a new application. 

![](../img/6.rum_ios.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![tvOS](https://img.shields.io/badge/dynamic/json?label=tvOS&color=brightgreen&query=$.tvos_api_support&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios)

**Source Code Address**：[https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**：[https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1.Configure the `Podfile` file.
    
    * Use Dynamic Library
    
      ```
      platform :ios, '10.0' 
      use_frameworks!
      def shared_pods
      pod 'FTMobileSDK', '[latest_version]'
      # If you need to collect widget Extension data
      pod 'FTMobileSDK/Extension', '[latest_version]'
      end
      //Main Project Target
      target 'yourProjectName' do
      shared_pods
      end
          
      //Widget Extension
      target 'yourWidgetExtensionName' do
      # If you need to collect widget Extension data
      shared_pods
      end
      ```
    
    * Use Static Library
    
      ```
      use_modular_headers!
      //Main Project Target
      target 'yourProjectName' do
      pod 'FTMobileSDK', '[latest_version]'
      end
      //Widget Extension
      target 'yourWidgetExtensionName' do
      pod 'FTMobileSDK/Extension', '[latest_version]'
      end
      ```
    
    * [Download the code repository for local use](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
      **`Podfile` file**
      ```
      use_modular_headers!
      //Main Project Target
      target 'yourProjectName' do
      pod 'FTMobileSDK', :path => '[folder_path]' 
      end
      //Widget Extension
      target 'yourWidgetExtensionName' do
      pod 'FTMobileSDK/Extension', :path => '[folder_path]'
      end
      ```
    
      `folder_path`：Path to the folder where 'FTMobileSDK.podspec' is located.
      
      **`FTMobileSDK.podspec` file**
      Modify `s.version` and `s.source` in the 'FTMobileSDK.podspec' file.
      `s.version` ：This parameter is recommended to be consistent with `SDK_VERSION` in `FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`.
      `s.source`：tag => s.version
      ```
      Pod::Spec.new do |s|
      s.name         = "FTMobileSDK"
      s.version      = "[latest_version]"  
      s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
      ```
    
    2.Run `pod install` in the `Podfile` directory to install the SDK.

=== "Carthage" 

    1.Configure the `Cartfile` file.
    
    ```
    github "GuanceCloud/datakit-ios" == [latest_version]
    ```
    
    2.Executes in the 'Cartfile' directory
    
    ```bash
    carthage update --platform iOS
    ```
    
    If you get the error "Building universal frameworks with common architectures is not possible. for: arm64" error,
    Follow the prompts to add the `--use-xcframeworks` parameter.
    
    ```bash
    carthage update --platform iOS --use-xcframeworks
    ```
    
    The generated xcframework is used in the same way as the normal Framework. Add the compile-generated library to the project project.
    
    `FTMobileAgent`：Add to the main project Target
    
    `FTMobileExtension`：Add to Widget Extension Target
    
    3.Select `TARGETS`  -> `Build Setting` ->  `Other Linker Flags`  add  `-ObjC`。
    
    4.support：
      `FTMobileAgent`：>=1.3.4-beta.2 
      `FTMobileExtension`: >=1.4.0-beta.1

=== "Swift Package Manager"

    1.Select `PROJECT` -> `Package Dependency` ，Click **+** under 'Packages'.
    
    2.Enter `https://github.com/GuanceCloud/datakit-ios.git` in the search box on the page that pops up.
    
    3.After Xcode successfully obtains the package, the SDK configuration page is displayed.
    
    `Dependency Rule` ：suggest you to choose `Up to Next Major Version` .
    
    `Add To Project` ：Select a supported project.
    
    Click the 'Add Package' button and wait for the load to complete.
    
    4.In the pop-up window 'Choose Package Products for datakit-ios', select the Target that needs to Add the SDK and click the' Add Package 'button. At this time, the SDK has been added successfully.
    
    `FTMobileSDK`：Add to the main project Target
    
    `FTMobileExtension`：Add to Widget Extension Target
    
    If your project is managed by SPM, add the SDK as a dependency and add 'dependencies' to 'Package.swift'.
    
    ```plaintext
    //  main project
    dependencies: [
    .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",.upToNextMajor(from: "[latest_version]"))
    ]
    ```
    
    5.support：>= 1.4.0-beta.1 .

### Add Header File

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

## SDK Initialization

### Basic Configuration {#base-setting}
=== "Objective-C"

    ```objective-c
    -(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
         // Use Datakit Address
         //FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatakitUrl:datakitUrl];
         // Use DataWay Address
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
           // Use Datakit Address
           //let config = FTMobileConfig(datakitUrl: url)
           // Use DataWay Address
         let config = FTMobileConfig(datawayUrl: datawayUrl, clientToken: clientToken)
         config.enableSDKDebugLog = true
         FTMobileAgent.start(withConfigOptions: config)
         //...
         return true
    }
    ```


| **Fields** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| datakitUrl | NSString | Yes | Datakit Access address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), the default port is 9529, the SDK device must be able to access this address. **Note: choose either DataKit or DataWay configuration, not both** |
| datawayUrl | NSString | Yes | The url of the Dataway address，example：http://10.0.0.1:9528，port 9528，Note: The installed SDK device must be able to access this address. **Note: choose either DataKit or DataWay configuration, not both**. |
| clientToken | NSString | Yes | Authentication token.It needs to be configured simultaneously with the datawayUrl |
| enableSDKDebugLog | BOOL | No | Whether to turn on debug mode.Default is `NO`, enable to print SDK run log |
| env | NSString | No | Set the acquisition environment.Default `prod`, support for custom. It can also be set using the `-setEnvWithType:` method based on the 'FTEnv' enumeration.<br/>`FTEnv`<br/>`FTEnvProd`： prod<br/>`FTEnvGray`： gray<br/>`FTEnvPre` ：pre <br/>`FTEnvCommon` ：common <br/>`FTEnvLocal`： local |
| service | NSString | No | Set Service Name.Impact the service field data in Log and RUM, which is set to `df_rum_ios` by default. |
| globalContext | NSDictionary |    No | Add SDK global properties.Adding rules can be found [here](#key-conflict) |
| groupIdentifiers | NSArray      | No | An array of AppGroups identifiers corresponding to the Widget Extensions to be collected.If Widget Extensions data collection is enabled, You must set [App Groups](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups), And configure the Identifier to this property |
| autoSync | BOOL | No | Whether to enable automatic synchronization. Default `YES`. When it is `NO`, use `[[FTMobileAgent sharedInstance] flushSyncData]` to manage data synchronization by yourself |
| syncPageSize | int | No | Set the number of synchronization request entries. Range [5,) Note: The larger the number of request entries, the more computing resources data synchronization occupies. The default value is 10 |
| syncSleepTime | int | No | Set the synchronization interval. Range [0,5000], not set by default |
| enableDataIntegerCompatible | BOOL | No | It is recommended to enable it when it needs to coexist with web data. This configuration is used to handle web data type storage compatibility issues. |
| compressIntakeRequests | BOOL | No | Compress the synchronized data. SDK 1.5.6 and above versions support this parameter |
| enableLimitWithDbSize | BOOL | No | Enable the function of using DB to limit the total cache size. <br>**Note:**After enabling, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will become invalid. SDK 1.5.8 and above versions support this parameter |
| dbCacheLimit | long | No | DB cache limit size. Range [30MB,), default 100MB, unit byte, SDK 1.5.8 and above support this parameter |
| dbDiscardType | FTDBCacheDiscard | No | Set the data discard rule in the database. Default `FTDBDiscard` <br/> `FTDBDiscard` discards additional data when the amount of data is greater than the maximum value. `FTDBDiscardOldest` discards old data when the amount of data is greater than the maximum value. SDK 1.5.8 or above supports this parameter |

### RUM Configuration {#rum-config}

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

| **Fields**               | **Type**     | **Required**                                | **Meaning**                                   |
| --- | --- | --- | --- |
| appid | NSString | No | Set `Rum AppId`.Corresponding to setting RUM `appid` to enable `RUM` collection, [get appid method]( |
| samplerate | int | No | Set acquisition rate.The collection rate ranges from >= 0 to <= 100. The default value is 100 |
| enableTrackAppCrash | BOOL | No | Set whether crash need to be collected.Default `NO` |
| enableTrackAppANR | BOOL | No | Collect ANR stuck unresponsive events.Default `NO` |
| enableTrackAppFreeze | BOOL | No | Collect UI jamming events.Default `NO` |
| freezeDurationMs | long | No | Set UI freeze threshold, value range [100,), unit is milliseconds, default is 250ms. SDK 1.5.7 and above versions support |
| enableTraceUserView | BOOL | No | Set whether to track user View actions.Default `NO` |
| enableTraceUserAction | BOOL | No | Set whether to track user Action actions.Default `NO` |
| enableTraceUserResource | BOOL | No | Set whether to track user network requests.Default `NO` |
| resourceUrlHandler | FTResourceUrlHandler | No | Configure Reousrce filter.No filtering by default. Return :NO for no filtering and YES for filtering. |
| errorMonitorType | FTErrorMonitorType | No | Error Event Monitoring Supplementary Type.Add monitoring information to the collected crash data.<br/>`FTErrorMonitorType`<br/>`FTErrorMonitorAll`：all<br/>`FTErrorMonitorBattery`：battery power<br/>`FTErrorMonitorMemory`：total memory, memory usage<br/>`FTErrorMonitorCpu`：CPU usage |
| deviceMetricsMonitorType | FTDeviceMetricsMonitorType | No | The performance monitoring type of the view.Add the monitoring item information to the collected **View** data.<br/>`FTDeviceMetricsMonitorType`<br/>`FTDeviceMetricsMonitorAll`:all<br/>`FTDeviceMetricsMonitorMemory`:average memory, maximum memory<br/>`FTDeviceMetricsMonitorCpu`：The maximum and average number of CPU ticks<br/>`FTDeviceMetricsMonitorFps`：fps minimum frame rate, average frame rate |
| monitorFrequency | FTMonitorFrequency | No | View's Performance Monitoring Sampling Period.Configure 'monitorFrequency' to set the sampling period for **View** monitor information.<br/>`FTMonitorFrequency`<br/>`FTMonitorFrequencyDefault`：500ms (default)<br/>`FTMonitorFrequencyFrequent`：100ms<br/>`FTMonitorFrequencyRare`：1000ms |
| enableResourceHostIP | BOOL | No | Whether to collect the IP address of the request target domain name address. Supported  `iOS >= 13.0` |
| globalContext | NSDictionary |    No | Add Rum global properties.Adding rules can be found [here](#key-conflict) |
| rumCacheLimitCount | int | No | Maximum RUM cache size. The default value is 100_000. SDK 1.5.8 and above support this parameter |
| rumDiscardType | FTRUMCacheDiscard | No | Set RUM discard rules. Default `FTRUMCacheDiscard` <br/> `FTRUMCacheDiscard` discards additional data when the amount of RUM data is greater than the maximum value. `FTRUMDiscardOldest` discards old data when the amount of RUM data is greater than the maximum value. SDK 1.5.8 or above supports this parameter |

### Log Configuration {#log-config}

=== "Objective-C"

    ```objective-c
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

| **Fields**        | **Type**          | **Required**                                 | **Meaning**                                       |
| --- | --- | --- | --- |
| samplerate | int | No | Set acquisition rate.The collection rate ranges from >= 0 to <= 100. The default value is 100 |
| enableCustomLog | BOOL | No | Whether to upload custom logs.Default `NO` |
| printCustomLogToConsole | BOOL | No | Sets whether to output custom logs to the console.Default `NO`<br/>Custom log [print format](#printCustomLogToConsole) |
| logLevelFilter | NSArray | No | Set the state array of the custom logs to be collected.Default full collection |
| enableLinkRumData | BOOL | No | Whether to associate logger data with rum.Default `NO` |
| discardType | FTLogCacheDiscard | No (the latest data is discarded by default) | Setting the log deprecation policy.Default `FTDiscard` <br/>`FTLogCacheDiscard`:<br/>`FTDiscard`：Default，When the number of log data exceeds the maximum value (5000), the appended data is discarded<br/>`FTDiscardOldest`：When the log data exceeds the maximum value, the old data is discarded |
| globalContext | NSDictionary |   No | Add log global properties.Adding rules can be found [here](#key-conflict) |

### Trace Configuration {#trace-config}

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

| **Fields**        | **Type** | **Required**         | **Meaning**                                       |
| --- | --- | --- | --- |
| samplerate | int | No | Set acquisition rate.The collection rate ranges from >= 0 to <= 100. The default value is 100 |
| networkTraceType | NS_ENUM | No | Set the type of tracing.Default is `DDTrace`, currently support `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if you access OpenTelemetry to choose the corresponding trace type, please pay attention to check the supported types and agent-related configuration |
| enableAutoTrace | BOOL | No | Set whether to enable automatic http trace.Default `NO`,currently only NSURLSession is supported |
| enableLinkRumData | BOOL | No | Whether to associate Trace data with rum.Default `NO` |

## RUM {#rum}

You can configure `FTRUMConfig` to enable automatic mode or add it manually. Rum related data can be passed in through the `FTExternalDataManager` singleton with the following API.

### View

#### Method

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
    - (void)viewDidAppear:(BOOL)animated{
      [super viewDidAppear:animated];
      // Scene 1：
      [[FTExternalDataManager sharedManager] startViewWithName:@"TestVC"];  
      
      // Secne 2：  extra property
      [[FTExternalDataManager sharedManager] startViewWithName:@"TestVC" property:@{@"custom_key":@"custom_value"}];  
    }
    -(void)viewDidDisappear:(BOOL)animated{
      [super viewDidDisappear:animated];
      // Scene 1：
      [[FTExternalDataManager sharedManager] stopView];  
      
      // Secne 2：  extra property
      [[FTExternalDataManager sharedManager] stopViewWithProperty:@{@"custom_key":@"custom_value"}];
    }
    ```

=== "Swift"

    ```swift
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Scene 1：
        FTExternalDataManager.shared().startView(withName: "TestVC")
        // Secne 2：  extra property
        FTExternalDataManager.shared().startView(withName: "TestVC",property: ["custom_key":"custom_value"])
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Scene 1：
        FTExternalDataManager.shared().stopView()
        // Secne 2：  extra property
        FTExternalDataManager.shared().stopView(withProperty: ["custom_key":"custom_value"])
    }
    ```

### Action

#### Method

=== "Objective-C"

    ```objective-c
    /// Start RUM Action.
    ///
    /// RUM will bind the Resource, Error, and LongTask events that may be triggered by the Action. Avoid adding multiple times within 0.1 seconds. The same View will only be associated with one Action at the same time. If the previous Action is not completed, the newly added Action will be discarded.
    /// This method has no effect on adding Actions with the `addAction:actionType:property` method.
    ///
    /// - Parameters:
    /// - actionName: action name
    /// - actionType: action type
    /// - property: extra property (optional)
    - (void)startAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    
    /// Add Action event. No duration, no discard logic
    ///
    /// Does not affect the RUM Action started by `startAction:actionType:property:`.
    /// - Parameters:
    /// - actionName: action name
    /// - actionType: action type
    /// - property: extra property (optional)
    - (void)addAction:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
    ```

=== "Swift"

    ```swift
    /// Start RUM Action.
    ///
    /// RUM will bind the Resource, Error, and LongTask events that may be triggered by the Action. Avoid adding multiple times within 0.1 seconds. The same View will only be associated with one Action at the same time. If the previous Action is not completed, the newly added Action will be discarded.
    /// This method has no effect on adding Actions with the `addAction:actionType:property` method.
    ///
    /// - Parameters:
    /// - actionName: action name
    /// - actionType: action type
    /// - property: extra property (optional)
    open func startAction(_ actionName: String, actionType: String, property: [AnyHashable : Any]?)
    
    /// Add Action event. No duration, no discard logic
    ///
    /// Does not affect the RUM Action started by `startAction:actionType:property:`.
    /// - Parameters:
    /// - actionName: action name
    /// - actionType: action type
    /// - property: extra property (optional)
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
    // Secne 1： 
    [[FTExternalDataManager sharedManager] addErrorWithType:@"type" message:@"message" stack:@"stack"];
    // Secne 2：  extra property
    [[FTExternalDataManager sharedManager] addErrorWithType:@"ios_crash" message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    // Secne 3：  extra property
    [[FTExternalDataManager sharedManager] addErrorWithType:@"ios_crash" state:FTAppStateUnknown message:@"crash_message" stack:@"crash_stack" property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // Secne 1： 
    FTExternalDataManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack")
    // Secne 2：  extra property
    FTExternalDataManager.shared().addError(withType: "custom_type", message: "custom_message", stack: "custom_stack",property: ["custom_key":"custom_value"])
    // Secne 3：  extra property     
    FTExternalDataManager.shared().addError(withType: "custom_type", state: .unknown, message: "custom_message", stack: "custom_stack", property: ["custom_key":"custom_value"])
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
    // Secne 1： 
    [[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
    // Secne 2：  extra property
    [[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000 property:@{@"custom_key":@"custom_value"}];
    ```

=== "Swift"

    ```swift
    // Secne 1： 
    FTExternalDataManager.shared().addLongTask(withStack: "stack string", duration: 1000000000)
    // Secne 2：  extra property
    FTExternalDataManager.shared().addLongTask(withStack: "stack string", duration: 1000000000 ,property: [["custom_key":"custom_value"]])
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
    //step 1： Before the network request starts
    [[FTExternalDataManager sharedManager] startResourceWithKey:key];
    
    //step 2：Request completed
    [[FTExternalDataManager sharedManager] stopResourceWithKey:key];
    
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
    [[FTExternalDataManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
    ```

=== "Swift"

    ```swift
    //step 1： Before the network request starts
    FTExternalDataManager.shared().startResource(withKey: key)
    
    //step 2：Request completed
    FTExternalDataManager.shared().stopResource(withKey: resource.key)
    
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
    FTExternalDataManager.shared().addResource(withKey: resource.key, metrics: metricsModel, content: contentModel)
    ```

## Logging {#user-logger}

### Method

=== "Objective-C"

    ```objectivec
    //  FTMobileAgent.h
    //  FTMobileSDK
    
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
    //  FTMobileSDK
    
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
    open class FTMobileAgent : NSObject {
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
    // Method 1：Use FTMobileAgent
    // Note: Ensure that the SDK has been successfully initialized at the time of use, otherwise failure will be asserted in the test environment resulting in a crash.
    [[FTMobileAgent sharedInstance] logging:@"test_custom" status:FTStatusInfo];
    
    // Method 2：Use FTLogger （recommend）
    // If the SDK is not initialized successfully, calling the methods in FTLogger to add custom logs will fail, but there will be no assertion failure crash.
    [[FTLogger sharedInstance] info:@"test" property:@{@"custom_key":@"custom_value"}];
    
    ```

=== "Swift"

    ```swift
    // Method 1：Use FTMobileAgent
    // Note: Ensure that the SDK has been successfully initialized at the time of use, otherwise failure will be asserted in the test environment resulting in a crash.
    FTMobileAgent.sharedInstance().logging("contentStr", status: .statusInfo, property:["custom_key":"custom_value"])
    
    // Method 2：Use FTLogger （recommend）
    // If the SDK is not initialized successfully, calling the methods in FTLogger to add custom logs will fail, but there will be no assertion failure crash.
    FTLogger.shared().info("contentStr", property: ["custom_key":"custom_value"])
    ```

### Print Custom Log To Console {#printCustomLogToConsole}


Set 'printCustomLogToConsole = YES' to enable the output of custom logs to the console. You will see logs in the following format in the xcode debug console:

```
2023-06-29 13:47:56.960021+0800 App[64731:44595791] [IOS APP] [INFO] content ,{K=V,...,Kn=Vn}
```

`2023-06-29 13:47:56.960021+0800 App[64731:44595791]`：os_log Specifies the standard prefix of log output (< xcode 15)；

`[IOS APP]`：The prefix is used to distinguish the custom log output by the SDK；

`[INFO]`：Customize the log level；

`content`：Customize log content；

`{K=V,...,Kn=Vn}`：Extra Property 。

## Network Link Tracing

You can `FTTraceConfig` configuration to turn on automatic mode, or manually add. Trace related data, through the `FTTraceManager` singleton, to pass in, the relevant API as follows.

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
    if let traceHeader = FTExternalDataManager.shared().getTraceHeader(withKey: NSUUID().uuidString, url: url) {
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

##  Custom tracing Network by forwarding URLSession Delegate

**Note: This method does not work with Swift URLSession async/await APIs**

SDK provides a class `FTURLSessionDelegate` that requires you to forward the URLSession delegate to `FTURLSessionDelegate` to help the SDK collect data about the Network.

The related data of collecting Network is divided into `RUM-Resource` and `Network link Tracing` in SDK.

**RUM-Resource**：

* `enableTraceUserResource` of `FTRUMConfig` can be enabled. The auto-tracking logic ignores the current `URLSession'`request;
* Support for adding custom properties.

**Network link Tracing**：

* `enableAutoTrace` of `FTTraceConfig` can be enabled. When setting up custom link tracking, the auto-tracking logic will ignore the current `URLSession` request.

Here are three usage examples to suit different user scenarios:

### Method 1

Set the URLSession delegate to an instance of `FTURLSessionDelegate`.

=== "Objective-C"

    ```objective-c
    id<NSURLSessionDelegate> delegate = [[FTURLSessionDelegate alloc]init];
    // To add custom RUM resource properties, it is recommended that the tag name be prefixed with the project abbreviation, such as' df_tag_name '.
    delegate.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
    // Provide a block to modify a URL request.Can be used for custom link tracing.
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
    // To add custom RUM resource properties, it is recommended that the tag name be prefixed with the project abbreviation, such as' df_tag_name '.
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
    // Provide a block to modify a URL request.Can be used for custom link tracing.
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

### Method 2

Set the URLSession delegate to be a subclass of `FTURLSessionDelegate`.

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
            // To add custom RUM resource properties, it is recommended that the tag name be prefixed with the project abbreviation, such as' df_tag_name '.
            self.provider = ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
            NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            return @{@"df_requestbody":body};
        };
            // Provide a block to modify a URL request.Can be used for custom link tracing.
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
        // must call super
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
            // To add custom RUM resource properties, it is recommended that the tag name be prefixed with the project abbreviation, such as' df_tag_name '.
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
            //Provide a block to modify a URL request .Can be used for custom link tracing.
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
            // must call super
            super.urlSession(session, task: task, didFinishCollecting: metrics)
            // Your own logic
            // ......
        }
    }
    ```

### Method 3

Make URLSession delegate object implementing ` FTURLSessionDelegateProviding ` agreement, Declare a `FTftURLSessionDelegate` property (readwrite) called `ftURLSessionDelegate` and implement the `get` method for `ftURLSessionDelegate`.

The class implementing `FTURLSessionDelegateProviding` must ensure that following method calls are forwarded to `ftURLSessionDelegate`:

`-URLSession:dataTask:didReceiveData:`

`-URLSession:task:didCompleteWithError:`

`-URLSession:task:didFinishCollectingMetrics:`

=== "Objective-C"

    ```objective-c
    @interface InstrumentationPropertyClass:NSObject<NSURLSessionDataDelegate,FTURLSessionDelegateProviding>
    @property (nonatomic, strong) FTURLSessionDelegate *ftURLSessionDelegate;
    @end
    @implementation InstrumentationPropertyClass
    
    - (nonnull FTURLSessionDelegate *)ftURLSessionDelegate {
        if(!_ftURLSessionDelegate){
            _ftURLSessionDelegate = [[FTURLSessionDelegate alloc]init];
            //To add custom RUM resource properties, it is recommended that the tag name be prefixed with the project abbreviation, such as' df_tag_name '.
            _ftURLSessionDelegate.provider =  ^NSDictionary * _Nullable(NSURLRequest *request, NSURLResponse *response, NSData *data, NSError *error) {
                    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
                    return @{@"df_requestbody":body};
                };
                // Tells the `ftURLSessionDelegate` to modify a URL request.Can be used for custom link tracing.
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
    // The following methods must be implemented
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
            // To add custom RUM resource properties, it is recommended that the tag name be prefixed with the project abbreviation, such as' df_tag_name '.
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
            // Tells the `ftURLSessionDelegate` to modify a URL request.Can be used for custom link tracing.
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
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
    // or
    [[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];
    
    // clear user data after log out
    [[FTMobileAgent sharedInstance] unbindUser];
    ```
=== "Swift"

    ```swift
    // bind user info after log in
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL)
    // or
    FTMobileAgent.sharedInstance().bindUser(withUserID: USERID, userName: USERNAME, userEmail: USEREMAIL,extra:[EXTRA_KEY:EXTRA_VALUE])
    
    // clear user data after log out
    FTMobileAgent.sharedInstance().unbindUser()
    ```

## Close SDK

Using `FTMobileAgent`  to close SDK

### Method

=== "Objective-C"

    ```objective-c
    /// Close the running object inside the SDK
    + (void)shutDown;
    ```

=== "Swift"

    ```swift
    /// Close the running object inside the SDK
    open class func shutDown()
    ```

### Code Example

=== "Objective-C"

    ```objective-c
    //If you dynamically change the SDK configuration, you need to close it first to avoid the generation of wrong data
    [FTMobileAgent  shutDown];
    ```  

=== "Swift"

    ```swift
    //If you dynamically change the SDK configuration, you need to close it first to avoid the generation of wrong data
    FTMobileAgent.shutDown()
    ```

## Clear All Data

Use `FTMobileAgent.clearAllData` to clear all data that has not been uploaded to the server 

### Method

=== "Objective-C" 

	```objective-c 
	/// Clear all data that has not been uploaded to the server 
	+ (void)clearAllData; 
	``` 

=== "Swift" 


	``` swift 
	/// Clear all data that has not been uploaded to the server 
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

## Actively Sync Data

Use `FTMobileAgent` to actively sync data. 
>When FTMobileConfig.autoSync = NO, you need to synchronize data yourself
### Method

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

### Code example 

=== "Objective-C" 

    ```objective-c 
    [[FTMobileAgent sharedInstance] flushSyncData]; 
    ```   

=== "Swift" 

    ```swift 
    //If you change the SDK configuration dynamically, you need to close it first to avoid the generation of incorrect data 
    FTMobileAgent.sharedInstance().flushSyncData() 
    ``` 

## Add Custom Tags {#user-global-context}

Use `FTMobileAgent` to dynamically add tags when the SDK is running
### Method
=== "Objective-C" 

    ```objective-c 
    /// Add SDK global tags, which act on RUM and Log data 
    /// - Parameter context: custom data 
    + (void)appendGlobalContext:(NSDictionary <NSString*,id>*)context; 
    
    /// Add RUM custom tag, acting on RUM data 
    /// - Parameter context: custom data 
    + (void)appendRUMGlobalContext:(NSDictionary <NSString*,id>*)context; 
    
    /// Add Log global tag, acting on Log data 
    /// - Parameter context: custom data 
    + (void)appendLogGlobalContext:(NSDictionary <NSString*,id>*)context; 
    ``` 

=== "Swift" 

    ```swift 
    /// Add SDK global tag, acting on RUM and Log data 
    /// - Parameter context: custom dataopen 
    class func appendGlobalContext(_ context: [String : Any]) 
    
    /// Add RUM custom tag, acting on RUM data 
    /// - Parameter context: custom dataopen 
    class func appendRUMGlobalContext(_ context: [String : Any]) 
    
    /// Add Log Global tag, applied to Log data 
    /// - Parameter context: custom data 
    open class func appendLogGlobalContext(_ context: [String : Any]) 
    ``` 

### Code Example 

=== "Objective-C" 

    ```objective-c 
    [FTMobileAgent appendGlobalContext:@{@"global_key":@"global_value"}]; 
    [FTMobileAgent appendLogGlobalContext:@{@"log_key":@"log_value"}]; 
    [FTMobileAgent appendRUMGlobalContext:@{@"rum_key":@"rum_value"}]; 
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

## Symbol Table Upload {#source_map}

###  Script integration into the Xcode project's Target

1.XCode add custom Run Script Phase：` Build Phases -> + -> New Run Script Phase`

2.Copy the script into the build-phase run script of the Xcode project, where you need to set parameters such as < app_id >, < datakit_address >, < env >, < dataway_token > .

3.[Script](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh)

```sh
#Parameters that need to be configured
#＜app_id＞
FT_APP_ID="YOUR_APP_ID"
# <datakit_address>
FT_DATAKIT_ADDRESS="YOUR_DATAKIT_ADDRESS"
# ＜env＞ environment field. value：prod/gray/pre/common/local。Need to be consistent with SDK settings
FT_ENV="common"
# <dataway_token> The token for dataway in the datakit.conf configuration file
FT_TOKEN="YOUR_DATAWAY_TOKEN"
#
#＜version＞ The version format of the script default configuration is: CFBundleShortVersionString, if you modify the default version format, please set this variable. Note: You need to make sure that what you fill in here is consistent with what you set in the SDK.
# FT_VERSION=""
```

#### Convenient Configuration Parameters for Multiple Environments

Example: Using preset macros and .xcconfig configuration files

**1. Create an xcconfig configuration file and configure variables in the .xcconfig file**.  

For the method of creating an xcconfig configuration file, please refer to: [Add a build configuration file to your project](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project) .

```sh
//If you use cocoapods, you need to add the .xcconfig path of pods to your .xcconfig file. If you don’t know what the path is, you can use the terminal to enter the project folder, execute pod install, the terminal will prompt the path, and set the path After copying, you can use it as follows.

#include "Pods/Target Support Files/Pods-testDemo/Pods-testDemo.debug.xcconfig"

SDK_APP_ID = app_id_common
SDK_ENV = common
SDK_DATAKIT_ADDRESS = http:\$()\xxxxxxxx:9529
SDK_DATAWAY_TOKEN = token
```

At this time, the user-defined parameters have been automatically added, and you can go to `Target —> Build Settings -> + -> Add User-Defined Setting` to view 

![](multi-environment-configuration2.png)

**2. Parameters in the configuration script**

```sh
#Parameters that need to be configured
#＜app_id＞
FT_APP_ID=${SDK_APP_ID}
#＜dea_address＞
FT_DATAKIT_ADDRESS=${SDK_DATAKIT_ADDRESS}
# ＜env＞ environment field. value：prod/gray/pre/common/local。Need to be consistent with SDK settings
FT_ENV=${SDK_ENV}
# The token for dataway in the datakit.conf configuration file
FT_TOKEN=${SDK_DATAWAY_TOKEN}
```

**3.Configure SDK** 

Map parameters in the `Info.plist` file .

![](../img/multi-environment-configuration8.png)

Get the parameters in `Info.plist` and configure the SDK .

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let info = Bundle.main.infoDictionary!
        let appid:String = info["SDK_APP_ID"] as! String
        let env:String  = info["SDK_ENV"] as! String

        print("SDK_APP_ID:\(appid)")
        print("SDK_ENV:\(env)")
}
```

For detailed details, please refer to the multi-environment usage in [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo). 

### Run the script in the terminal 

[Script: FTdSYMUpload.sh](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTdSYMUploader.sh) 

`sh FTdSYMUpload.sh <datakit_address> <app_id> <version> <env> <dataway_token> <dSYMBOL_src_dir>`

> Example: 
>
> sh FTdSYMUploader.sh http://10.0.0.1:9529 appid_mock 1.0.6 prod tkn_mock /Users/mock/Desktop/dSYMs 

**Parameter Description:** 

- `<datakit_address>`: DataKit service address, such as `http://localhost:9529` 
- `<app_id>`: Corresponding to RUM's `applicationId` 
- `<env>`: Corresponding to RUM's `env` 
- `<version>`: application's `version`, `CFBundleShortVersionString` value 
- `<dataway_token>`: token of `dataway` in the configuration file `datakit.conf` 
- `<dSYMBOL_src_dir>`: directory path containing all `.dSYM` files. 

### Manual upload

[Sourcemap Upload](../../datakit/rum.md#sourcemap)

## Widget Extension Data Collection

### Widget Extension Suppot

* Logger 

* Trace 
* RUM 
  * Manual acquisition  ([RUM](#rum) )
  * Automatically collects crash and HTTP Resource data

Note: Because HTTP Resource data is bound to the View, you need to manually collect the View data.

### Widget Extension Configuration

Use 'FTExtensionConfig' to configure the automatic switch for Widget Extension data collection and the file sharing Group Identifier. Other configurations use the configurations already set in the main project SDK.

| **Fields**                 | **Type**  | **Required**         | **description**                                          |
| -------------------------- | --------- | -------------------- | -------------------------------------------------------- |
| groupIdentifier            | NSString  | Yes                  | File sharing Group Identifier                            |
| enableSDKDebugLog          | BOOL      | No（Deafault NO）    | enable to print SDK run log                              |
| enableTrackAppCrash        | BOOL      | No（Deafault NO）    | Set whether crash need to be collected                   |
| enableRUMAutoTraceResource | BOOL      | No（Deafault NO）    | Set whether to track user network requests               |
| enableTracerAutoTrace      | BOOL      | No（Deafault NO）    | Set whether to enable automatic http trace               |
| memoryMaxCount             | NSInteger | No（Deafault  1000） | The maximum number of data saved in the Widget Extension |

example：

```swift
// In the widget extension
let extensionConfig = FTExtensionConfig.init(groupIdentifier: "group.identifier")
extensionConfig.enableTrackAppCrash = true
extensionConfig.enableRUMAutoTraceResource = true
extensionConfig.enableTracerAutoTrace = true
extensionConfig.enableSDKDebugLog = true
FTExtensionManager.start(with: extensionConfig)
FTExternalDataManager.shared().startView(withName: "WidgetDemoEntryView")
```

When setting 'FTMobileConfig' in the main project, you must configure 'groupIdentifiers'.

=== "Objective-C"

    ```objective-c
    // In the main project
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

### Widget Extension SDK  Collected Data  Uploade

The Widget Extension SDK only implements data collection, and the data upload logic is delivered to the SDK of the main project. The timing of synchronization of the collected data to the main project is user-defined.

#### Method

=== "Objective-C"

    ```objective-c
    //  In the main project
    /// Track Widget Extension sdk cached data 
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: completion callback
    - (void)trackEventFromExtensionWithGroupIdentifier:(NSString *)groupIdentifier completion:(nullable void (^)(NSString *groupIdentifier, NSArray *events)) completion;
    ```

=== "Swift"

    ```swift
    /// Track Widget Extension sdk cached data 
    /// - Parameters:
    ///   - groupIdentifier: groupIdentifier
    ///   - completion: completion callback
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

## WebView data monitoring 
WebView data monitoring requires integration of [Web Monitoring SDK](../web/app-access.md) in the WebView access page 

## Example of using custom tags {#user-global-context} 

### Compile configuration method 

You can create multiple Configurations and use pre-compiled instructions to set values 

1.Create multiple Configurations 

![](../img/image_9.png) 

2.Set preset properties to distinguish different Configurations

![](../img/image_10.png)

3.Use precompilation instruction 

```objectivec 
//Target -> Build Settings -> GCC_PREPROCESSOR_DEFINITIONS to configure preset definition 
#if PRE 
#define Track_id @"0000000001" 
#define STATIC_TAG @"preprod" 
#elif DEVELOP 
#define Track_id @"0000000002" 
#define STATIC_TAG @"common" 
#else 
#define Track_id @"0000000003" 
#define STATIC_TAG @"prod" 
#endif 
   
FTRumConfig *rumConfig = [[FTRumConfig alloc]init]; 
rumConfig.globalContext = @{@"track_id":Track_id,@"static_tag":STATIC_TAG}; 
... //Other setting operations 
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig]; 
```

You can also refer to the [Multi-environment Configuration Parameters](#multi_env_param) method for configuration. 

### Runtime Read and Write File Methods 

Because the globalContext set after RUM is started will not take effect, users can save it locally and set it to take effect the next time the application is started. 

1.Save the data locally by storing it in a file, such as NSUserDefaults. Configure the use of the SDK, and add code to obtain tag data in the configuration section.

```objectivec 
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE"; 

FTRumConfig *rumConfig = [[FTRumConfig alloc]init]; 
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag}; 
... //Other setting operations 
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig]; 
```

2.Perform a method for adding or modifying file data at any location.

```objectivec 
 [[NSUserDefaults standardUserDefaults] setValue:@"dynamic_tags" forKey:@"DYNAMIC_TAG"]; 
```

3.Finally, restart the app to take effect. 

### SDK runtime addition

After the SDK is initialized, use `[FTMobileAgent appendGlobalContext:globalContext]`, `[FTMobileAgent appendRUMGlobalContext:globalContext]`, `[FTMobileAgent appendLogGlobalContext:globalContext]` to dynamically add tags. Once set, they will take effect immediately. Subsequently, the data reported by RUM or Log will automatically add tag data. This usage method is suitable for scenarios where data acquisition is delayed, such as when tag data requires network requests. 

```objective-c 
// SDK initialization pseudo code, get 
[FTMobileAgent startWithConfigOptions:config]; 

-(void)getInfoFromNet:(Info *)info{ 
	NSDictionary *globalContext = @{@"delay_key", info.value} 
	[FTMobileAgent appendGlobalContext:globalContext]; 
} 
```

## tvOS Data Collection

> api >= tvOS 12.0 

SDK initialization and usage are consistent with the iOS side. 

**Note that tvOS does not support**: 

* `WebView` data detection 

* `FTRumConfig.errorMonitorType` device battery monitoring 

## Frequently Asked Questions {#FAQ}

### About Crash Log Analysis

In **Debug** and **Release** modes at development time, the thread tracebacks captured during **Crash** are symbolized. The release package does not come with a symbol table, and the key tracebacks of the exception threads will show the mirror names and will not be translated into valid code symbols. The relevant information in the **crash log** obtained are all hexadecimal memory addresses, which do not locate the crashed code, so the hexadecimal memory addresses need to be parsed into the corresponding classes and methods.

#### XCode does not generate a dSYM file after compilation?

XCode Release compilation generates dSYM files by default, while Debug compilation does not generate them by default.

 ` Build Settings -> Code Generation -> Generate Debug Symbols -> Yes` 

![](../img/dsym_config1.png)




` Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File`

![](../img/dsym_config2.png)




#### How can I upload a symbol table with bitCode turned on?

When you upload your bitcode App to the App Store, check the generation of the declaration symbol file (dSYM file) in the submit dialog.

- Before configuring the symbol table file, you need to download the dSYM file corresponding to that version from the App Store back locally, and then use a script to process the uploaded symbol table file based on the input parameters.
- There is no need to integrate the script into the Target of the Xcode project, and do not use the locally generated dSYM file to generate the symbol table file, as the symbol table information is hidden in the locally compiled dSYM file. If you upload a locally generated dSYM file, the result will be a symbol like "__hiden#XXX".

#### How do I retrieve the dSYM file corresponding to an App that has been published to the App Store?

| Apply Distribution options uploaded to App Store Connect | dSym File                                                    |
| -------------------------------------------------------- | ------------------------------------------------------------ |
| Don’t include bitcode<br>Upload symbols                  | Retrieve via Xcode                                           |
| Include bitcode<br>Upload symbols                        | Retrieve via iTunes Connect<br />To retrieve it via Xcode, you need to use `.bcsymbolmap` to obfuscate it. |
| Include bitcode<br>Don’t upload symbols                  | To retrieve it via Xcode, you need to use `.bcsymbolmap` to obfuscate it. |
| Don’t include bitcode<br>Don’t upload symbols            | Retrieve via Xcode                                           |

##### Retrieve via Xcode

1.`Xcode -> Window -> Organizer ` 

2.Select the `Archives` tab

![](../img/xcode_find_dsym2.png)

3.Find the published archive package, right-click on the corresponding archive package, and select `Show in Finder` operation

![](../img/xcode_find_dsym3.png)

4.Right-click on the located archive file and select the `Show Package Contents` action 

![](../img/xcode_find_dsym4.png)


5.Select the `dSYMs` directory, which contains the downloaded dSYM files

![](../img/xcode_find_dsym5.png)

##### Retrieve via iTunes Connect

1. Login to [App Store Connect](https://appstoreconnect.apple.com);
2. Go to "My Apps"
3. Select a version in the "App Store" or "TestFlight" and click on "Build Metadata" On this page, click on the button "Download dSYM" to download the dSYM file

##### .bcsymbolmap de-obfuscation

When you find the dSYM file via Xcode, you can see the BCSymbolMaps directory

![](../img/BCSymbolMaps.png)


Open a terminal and use the following command to de-obfuscate

`xcrun dsymutil -symbol-map <BCSymbolMaps_path> <.dSYM_path>`

### Avoid conflicts when adding custom tags {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to add a prefix of the project abbreviation to the tag name, such as `df_tag_name`. The `key` value used in the project can be found in the [source code](https://github.com/GuanceCloud/datakit-ios/blob/develop/FTMobileSDK/FTSDKCore/BaseUtils/Base/FTConstants.m). When the same variables as RUM and Log appear in the SDK global variables, RUM and Log will overwrite the global variables in the SDK.

