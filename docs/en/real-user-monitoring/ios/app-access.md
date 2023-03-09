# iOS Application Access
---

## Overview

Guance Real User Monitoring can analyze the performance of each iOS application in a visual way by collecting the metrics data of each iOS application.

## Precondition

- Installing DataKit ([DataKit Installation Documentation](... /... /datakit/datakit-install.md))

## iOS Application Access

Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

- Application Name (required): The name of the application used to identify the current implementation of user access monitoring.
- Application ID (required): The unique identification of the application in the current workspace, which is used for SDK data collection and upload matching, and corresponds to the field: app_id after data entry. This field only supports English, numeric, underscore input, up to 48 characters.

![](../img/13.rum_access_3.png)
## Installation

![](https://img.shields.io/cocoapods/p/FTMobileAgent#crop=0&crop=0&crop=1&crop=1&id=xs5E2&originHeight=20&originWidth=82&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/cocoapods/v/FTMobileSDK#crop=0&crop=0&crop=1&crop=1&id=Uyl38&originHeight=20&originWidth=122&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/cocoapods/l/FTMobileSDK#crop=0&crop=0&crop=1&crop=1&id=SxRum&originHeight=20&originWidth=98&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/badge/iOS-api%20%3E=%20iOS%2010-brightgreen#crop=0&crop=0&crop=1&crop=1&id=uFhFJ&originHeight=20&originWidth=118&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=) 

**Demo**：[https://github.com/GuanceCloud/datakit-ios/demo](https://github.com/GuanceCloud/datakit-ios/tree/develop/demo)

**Source Code Address**：[https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

### Installation with Source Code

1. Get the source code of the SDK from GitHub according to the specified tag.

   ```
   git clone --branch 1.3.10-beta.2 https://github.com/GuanceCloud/datakit-ios.git
   ```

2. Import the SDK source code into the App project.Import the  folder of **FTMobileAgent** and **BaseUtils** into the project, and check `Copy items if needed` and  `Create groups`.

### Installation with CocoaPods

1.Configure the `Podfile` file.

```objectivec
target 'yourProjectName' do

# Pods for your project
pod 'FTMobileSDK', '1.3.10-beta.2'
    
end
```

2.Run `pod install` in the `Podfile` directory to install the SDK.

### Installation with Carthage

1.Configure the `Cartfile` file.

```
github "GuanceCloud/datakit-ios" == 1.3.10-beta.2
```

2.Execute `carthage update --platform iOS` in the `Cartfile` directory and drag `FTMobileSDK.framework` into your project to use it. If you get the error "Building universal frameworks with common architectures is not possible. for: arm64" error, please execute `carthage update --platform iOS --use-xcframeworks` command to generate `FTMobileSDK.xcframework ` and use it in the same way as the common Framework, please drag and drop it into your project.

3.Debug mode, in order to facilitate SDK debugging, it is recommended to use the debug mode static library. Add `--configuration Debug` after the command to get the debug mode static library.

4.Add `-ObjC ` in ` TARGETS `-> ` Build Setting `-> ` Other Linker Flags `.

5.Currently, only version 1.3.4-beta.2 and above are supported.

### Add Header File

```objectivec
// Carthage 
#import <FTMobileAgent/FTMobileAgent.h>
...
// Source Code or CocoaPods 
#import "FTMobileAgent.h"
```

## SDK Initialization

### Basic Configuration

```objectivec
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // SDK FTMobileConfig 
    FTMobileConfig *config = [[FTMobileConfig alloc]initWithMetricsUrl:@"Your App metricsUrl"];
    config.enableSDKDebugLog = YES;
    // Start SDK
    [FTMobileAgent startWithConfigOptions:config];
    
   //...
    return YES;
}
```

| **Fields** | **Type** | **Description** | **Required** |
| --- | --- | --- | --- |
| metricsUrl | NSString | Data Reporting Address | Yes |
| enableSDKDebugLog | BOOL | Set whether to allow printing of logs | No (default NO) |
| env | NS_ENUM | Environment | No (default FTEnvProd) |
| XDataKitUUID | NSString | Request HTTP request header X-Datakit-UUID Data collection side Automatically configured if not set by user | No |
| globalContext | NSDictionary | [Add custom tags](#user-global-context) |    No |
| service | NSString | Set the name of the business or service to which it belongs, and affect the service field data in Log and RUM. default：`df_rum_ios` | No |

#### Env Environment

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

### RUM Configuration

```objectivec
    //start rum
    FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
    rumConfig.appid = appid;
    rumConfig.enableTrackAppCrash = YES;
    rumConfig.enableTrackAppANR = YES;
    rumConfig.enableTrackAppFreeze = YES;
    rumConfig.enableTraceUserAction = YES;
	  rumConfig.enableTraceUserVIew = YES;
    rumConfig.deviceMetricsMonitorType = FTDeviceMetricsMonitorAll;
    [[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

| **Fields**               | **Type**     | **Description**                                              | **Required**                                |
| --- | --- | --- | --- |
| appid | NSString | The Guance rum application unique ID identifier is automatically generated when the monitor is created on top of the Guance console. | No (Enable RUM Required) |
| samplerate | int | Sampling collection rate | No (default 100) |
| enableTrackAppCrash | BOOL | Set whether crash logs need to be collected | No (default NO) |
| enableTrackAppANR | BOOL | Collect ANR stuck unresponsive events | No (default NO) |
| enableTrackAppFreeze | BOOL | Collect UI jamming events | No (default NO) |
| enableTraceUserAction | BOOL | Set whether to track user Action actions | No (default NO) |
| enableTraceUserView | BOOL | Set whether to track user View actions | No (default NO) |
| errorMonitorType | NS_OPTIONS | Error Event Monitoring Supplementary Type                    | No |
| deviceMetricsMonitorType | NS_OPTIONS | The performance monitoring type of the view | No (monitoring is not turned on if not set) |
| monitorFrequency | NS_OPTIONS | View's Performance Monitoring Sampling Period | No |
| globalContext | NSDictionary | [Add custom tags](#user-global-context) |    No |

#### Monitoring Data Configuration

Configuring the `errorMonitorType` property of `FTRumConfig` will add the corresponding information to the collected crash data. The types that can be captured are as follows.

```objectivec
/**
 *
 * @constant
 *  FTMonitorInfoTypeBattery  - battery power
 *  FTMonitorInfoTypeMemory   - total memory, memory usage
 *  FTMonitorInfoTypeCpu      - CPU usage
 */
typedef NS_OPTIONS(NSUInteger, FTMonitorInfoType) {
    FTMonitorInfoTypeAll          = 0xFFFFFFFF,
    FTMonitorInfoTypeBattery      = 1 << 1,
    FTMonitorInfoTypeMemory       = 1 << 2,
    FTMonitorInfoTypeCpu          = 1 << 3,
};
```

Configuring the `deviceMetricsMonitorType` property of `FTRumConfig` will add the corresponding monitor information to the collected **View** data, and you can configure `monitorFrequency` to set the monitoring sampling period. The types and sampling periods that can be captured are as follows.

```objective-c
/**
 * Page performance monitoring items
 * @constant
 *  FTDeviceMetricsMonitorMemory   - average memory, maximum memory
 *  FTDeviceMetricsMonitorCpu      - The maximum and average number of CPU ticks
 *  FTDeviceMetricsMonitorFps      - fps minimum frame rate, average frame rate
 */
typedef NS_OPTIONS(NSUInteger, FTDeviceMetricsMonitorType){
    FTDeviceMetricsMonitorAll      = 0xFFFFFFFF,
    FTDeviceMetricsMonitorCpu      = 1 << 1,
    FTDeviceMetricsMonitorMemory   = 1 << 2,
    FTDeviceMetricsMonitorFps      = 1 << 3,
};

/**
 * Monitoring item sampling period
 * @constant
 *  FTMonitorFrequencyDefault   - 500ms (default)
 *  FTMonitorFrequencyFrequent  - 100ms
 *  FTMonitorFrequencyRare      - 1000ms
 */
typedef NS_OPTIONS(NSUInteger, FTMonitorFrequency) {
    FTMonitorFrequencyDefault,
    FTMonitorFrequencyFrequent,
    FTMonitorFrequencyRare,
};
```

### Log Configuration

```objectivec
    //start logger
    FTLoggerConfig *loggerConfig = [[FTLoggerConfig alloc]init];
    loggerConfig.enableCustomLog = YES;
    loggerConfig.enableLinkRumData = YES;
    loggerConfig.enableConsoleLog = YES;
    [[FTMobileAgent sharedInstance] startLoggerWithConfigOptions:loggerConfig];
    
```

| **Fields**        | **Type**          | **Description**                                              | **Required**                                 |
| --- | --- | --- | --- |
| samplerate | int | Sampling collection rate | No (default 100) |
| enableConsoleLog | BOOL | Set whether you want to capture console logs | No (default NO) |
| prefix | NSString | Set the collection console log filter string | No (default full collection) |
| enableCustomLog | BOOL | Whether to upload custom logs | No (default NO) |
| logLevelFilter | NSArray | Set the state array of the custom logs to be collected | No (default full collection) |
| enableLinkRumData | BOOL | Whether to associate logger data with rum | No (default NO) |
| discardType | FTLogCacheDiscard | Setting the log deprecation policy | No (the latest data is discarded by default) |
| globalContext | NSDictionary | [Add custom tags](#user-global-context) |   No |

#### Log Discarding Strategy

**Upload mechanism** : After the log data is collected, it will be stored in the local database, waiting for the opportunity to upload. The amount of log data stored in the database is limited to 5,000. If data is accumulated due to network abnormalities and other reasons, after storing 5,000 logs, the data will be discarded according to the discarding policy you set.

```objectivec
typedef NS_ENUM(NSInteger, FTLogCacheDiscard)  {
    FTDiscard,        //default，When the number of log data is greater than the maximum value (5000), new data will not be written
    FTDiscardOldest   //When the number of log data is greater than the maximum value, the old data is discarded
};

/**
 * Set log discard policy
 */
@property (nonatomic, assign) FTLogCacheDiscard  discardType;
```

#### Collect Console Logs

In general, because the output of NSLog will consume system resources, and the output data may also expose the confidential data in the app, so all the output will be blocked when the official version is released. In this case, if you turn on the collection of console logs, the logs printed in the project will not be captured. It is recommended to use [custom report log](#user-logger) to upload the logs you want to see. 

- Enable collect console log

```objectivec
/**
 * Set whether to collect console logs. Default: NO
 */
 @property (nonatomic, assign) BOOL enableConsoleLog;
```

- Set filter conditions for collecting console logs

```objectivec
/**
 * Set the filter string for collecting console logs. Console logs containing this string will be collected. The default is full collection.
 */
@property (nonatomic, copy) NSString *prefix;
```

## Trace Configuration 

```objectivec
    //set trace configuration
    FTTraceConfig *traceConfig = [[FTTraceConfig alloc]init];
    traceConfig.enableLinkRumData = YES;
	  traceConfig.enableAutoTrace = YES;
    traceConfig.networkTraceType = FTNetworkTraceTypeDDtrace;
    [[FTMobileAgent sharedInstance] startTraceWithConfigOptions:traceConfig];
```

| **Fields**        | **Type** | **Description**                                              | **Required**         |
| --- | --- | --- | --- |
| samplerate | int | Sampling collection rate | No (default 100) |
| networkTraceType | NS_ENUM | When setting the link tracking type for network request information collection, if you select the corresponding link type for accessing OpenTelemetry, please pay attention to the supported type and agent-related configuration. | No (default DDtrace) |
| enableLinkRumData | BOOL | Whether to associate Trace data with rum | No (default NO) |
| enableAutoTrace | BOOL | Set whether to enable automatic http trace, currently only NSURLSession is supported | No (default NO) |

#### Trace Tracking Type

```objectivec
/**
 * @enum
 * Network Link Tracking Types
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

## RUM

You can configure `FTRUMConfig` to enable automatic mode or add it manually. Rum related data can be passed in through the `FTExternalDataManager` singleton with the following API.

### View

```objectivec
[[FTExternalDataManager sharedManager] onCreateView:@"TestVC" loadTime:@1000000000];

[[FTExternalDataManager sharedManager] startViewWithName:@"TestVC"];

[[FTExternalDataManager sharedManager] stopView];
```

```objectivec
/**
 * Create a view and record the loading time of the view
 * 
 * Need to be used before -startView and -stopView methods
 * @param viewName     The name of this View
 * @param loadTime     The loading time of  this view （ns）
 */
-(void)onCreateView:(NSString *)viewName loadTime:(NSNumber *)loadTime;
/**
 * enter the view
 * @param viewName     The name of this View
 */
-(void)startViewWithName:(NSString *)viewName;
/**
 * enter the view
 * @param viewName  The name of this View
 * @param property  event property(optional)
 */
-(void)startViewWithName:(NSString *)viewName property:(nullable NSDictionary *)property;
/**
 * leave the view
 */
-(void)stopView;
/**
 * leave the view
 * @param property  event property(optional)
 */
-(void)stopViewWithProperty:(nullable NSDictionary *)property;
```

### Action

```objective-c
[[FTExternalDataManager sharedManager] addActionName:@"" actionType:@""];
```

```objectivec
/**
 * Add Action Event
 * @param actionName The name of this action event
 * @param actionType The type of this action event
 */
- (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType;
/**
 * Add Action Event
 * @param actionName The name of this action event
 * @param actionType The type of this action event
 * @param property   event property(optional)
 */
- (void)addActionName:(NSString *)actionName actionType:(NSString *)actionType property:(nullable NSDictionary *)property;
```

### Error

```objectivec
[[FTExternalDataManager sharedManager] addErrorWithType:@"type" situation:RUN message:@"message" stack:@"stack"];
```

```objectivec
/**
 * Add Error Event
 * @param type       The type of this error event 
 * @param message    error message
 * @param stack      error stack
 */
- (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack;
/**
 * Add Error Event
 * @param type       error type
 * @param message    error message
 * @param stack      error message
 * @param property   event property(optional)
 */
- (void)addErrorWithType:(NSString *)type message:(NSString *)message stack:(NSString *)stack property:(nullable NSDictionary *)property;
```

### LongTask

```objectivec
[[FTExternalDataManager sharedManager] addLongTaskWithStack:@"stack string" duration:@1000000000];
```

```objectivec
/**
 * Add a LongTask event
 * @param stack      Stack information when a freeze occurs
 * @param duration   The duration of the freeze （ns）
 */
- (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration;
/**
 * Add a LongTask event
 * @param stack      Stack information when a freeze occurs
 * @param duration   The duration of the freeze （ns）
 * @param property   event property(optional)
 */
- (void)addLongTaskWithStack:(NSString *)stack duration:(NSNumber *)duration property:(nullable NSDictionary *)property;
```

### Resource

```objectivec
//step 1： Before the network request starts
[[FTExternalDataManager sharedManager] startResourceWithKey:key];

//step 2：Request completed
[[FTExternalDataManager sharedManager] stopResourceWithKey:key];

//step 3：Add resource data
//FTResourceContentModel 
  FTResourceContentModel *content = [[FTResourceContentModel alloc]init];
  content.httpMethod = request.HTTPMethod;
  content.requestHeader = request.allHTTPHeaderFields;
  content.responseHeader = httpResponse.allHeaderFields;
  content.httpStatusCode = httpResponse.statusCode;
  content.responseBody = responseBody;
  //ios native
  content.error = error;

 //If the performance data of the network request can be obtained
 //FTResourceMetricsModel
 //ios native. Get NSURLSessionTaskMetrics data, directly use the initialization method of FTResourceMetricsModel
  FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]initWithTaskMetrics:metrics];
  
 //other platforms. All time data in nanoseconds
  FTResourceMetricsModel *metricsModel = [[FTResourceMetricsModel alloc]init];
  [metricsModel setDnsStart:dstart end:dend];
  [metricsModel setTcpStart:tstart end:tend];
  [metricsModel setSslStart:sstart end:send];
  [metricsModel setTtfbStart:ttstart end:ttend];
  [metricsModel setTransStart:trstart end:trend];
  [metricsModel setFirstByteStart:fstart end:fend];
  [metricsModel setDurationStart:dstart end:dend];

 // step 4：add resource： If there is no performance data, the metrics parameter is set to nil
 [[FTExternalDataManager sharedManager] addResourceWithKey:key metrics:metricsModel content:content];
```

```objectivec
/**
 * Request start
 * @param key       request ID
 */
- (void)startResourceWithKey:(NSString *)key;
/**
 * Request start
 * @param key       request ID
 * @param property  event property(optional)
 */
- (void)startResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
/**
 * Request End
 * @param key       request ID
 */
- (void)stopResourceWithKey:(NSString *)key;
/**
 * Request End
 * @param key       request ID
 * @param property  event property(optional)
 */
- (void)stopResourceWithKey:(NSString *)key property:(nullable NSDictionary *)property;
/**
 * Add request data
 * @param key       request ID
 * @param metrics   request performance attributes
 * @param content   request data
 */
- (void)addResourceWithKey:(NSString *)key metrics:(nullable FTResourceMetricsModel *)metrics content:(FTResourceContentModel *)content;
```

#### Resource url filter

When the automatic collection is enabled, the internal processing will not collect the data reporting address of the SDK. You can also set filter conditions through the Open API to collect the network addresses you need.

```objective-c
[[FTMobileAgent sharedInstance] isIntakeUrl:^BOOL(NSURL * _Nonnull url) {
        // Your collection judgment logic
        return YES;//return NO; (YES collect，NO do not collect)
 }];
```

```objective-c
//  FTMobileAgent+Public.h
//  FTMobileAgent
/**
 * @abstract
 * Determine whether the URL is collected
 */
- (void)isIntakeUrl:(BOOL(^)(NSURL *url))handler;
```

## Logging{#user-logger}

```objectivec
[[FTMobileAgent sharedInstance] logging:@"TestLoggingBackground" status:FTStatusInfo];
```

```objectivec
typedef NS_ENUM(NSInteger, FTStatus) {
    FTStatusInfo         = 0,
    FTStatusWarning,
    FTStatusError,
    FTStatusCritical,
    FTStatusOk,
};
/**
 * Add custom logs
 * @param content  Log content, which can be a json string
 * @param status   Event Level and Status (info、warning、error、critical、ok). 

 */
-(void)logging:(NSString *)content status:(FTStatus)status;

/// Add custom logs
/// @param content Log content, which can be a json string
/// @param status   Event Level and Status (info、warning、error、critical、ok). 
/// @param property event property(optional)
-(void)logging:(NSString *)content status:(FTLogStatus)status property:(nullable NSDictionary *)property;
```

## Tracing

You can `FTTraceConfig` configuration to turn on automatic mode, or manually add. Trace related data, through the `FTTraceManager` singleton, to pass in, the relevant API as follows.

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

```objectivec
/**
 * Get trace request headers
 * @param key Request ID
 */
- (NSDictionary *)getTraceHeaderWithKey:(NSString *)key url:(NSURL *)url;

```

## User Binding and Cancellation

```objective-c
/**
 * Bind user information
 * @param Id        user id
 * @param userName  user name
 * @param userEmail user email
 * @param extra     user extra info
*/
[[FTMobileAgent sharedInstance] bindUserWithUserID:USERID];
//or
[[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL];
//or
[[FTMobileAgent sharedInstance] bindUserWithUserID:USERID userName:USERNAME userEmail:USEREMAIL extra:@{EXTRA_KEY:EXTRA_VALUE}];

//Unbind user
[[FTMobileAgent sharedInstance] logout];
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
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
```

### Dynamic Use

Since the globalContext set after RUM is started will not take effect, users can save it locally and set it to take effect the next time the application is started.

1. Save it locally by saving a file, e.g. `NSUserDefaults`, configure it using `SDK` and add the code to get the tag data in the configuration.

```objectivec
NSString *dynamicTag = [[NSUserDefaults standardUserDefaults] valueForKey:@"DYNAMIC_TAG"]?:@"NO_VALUE";

FTRumConfig *rumConfig = [[FTRumConfig alloc]init];
rumConfig.globalContext = @{@"dynamic_tag":dynamicTag};
... //other set
[[FTMobileAgent sharedInstance] startRumWithConfigOptions:rumConfig];
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

4. Custom tags configured in `FTMobileConfig` will be added to all types of data.

For more details, please see [SDK Demo](https://github.com/DataFlux-cn/datakit-ios/tree/develop/demo).

## Crash Log Symbolization

### Upload Symbol Table

#### Method 1: Script integration into the Xcode project's Target

1. XCode add custom Run Script Phase：` Build Phases -> + -> New Run Script Phase`
2. Copy the script into the build-phase run script of the Xcode project, where you need to set parameters such as < app_id >, < dea_address >, < env >, < version > (the default configured version format of the script is ` CFBundleShortVersionString `).
3. [Script](https://github.com/GuanceCloud/datakit-ios/blob/develop/demo/FTdSYMUploader.sh)

```sh
#Parameters that need to be configured
#＜app_id＞
FT_APP_ID="YOUR_APP_ID"
#＜dea_address＞
FT_DEA_ADDRESS="YOUR_DEA_ADDRESS"
# ＜env＞ environment field. value：prod/gray/pre/common/local。Need to be consistent with SDK settings
FT_ENV="common"
#
#＜version＞ The version format of the script default configuration is: CFBundleShortVersionString, if you modify the default version format, please set this variable. Note: You need to make sure that what you fill in here is consistent with what you set in the SDK.
# FT_VERSION=""
```

##### Convenient Configuration Parameters for Multiple Environments

Example: Using preset macros and .xcconfig configuration files

1. Add preset macros: `Target —> Build Settings -> + -> Add User-Defined Setting` 

![](../img/multi-environment-configuration1.png)

![](../img/multi-environment-configuration2.png)


2. Use multiple Xcconfig to implement multiple environments, new Xcconfig

![](../img/multi-environment-configuration3.png)


Configure the preset macros in the .xcconfig file.

```sh
//If you use cocoapods, you need to add the .xcconfig path of pods to your .xcconfig file. If you don’t know what the path is, you can use the terminal to enter the project folder, execute pod install, the terminal will prompt the path, and set the path After copying, you can use it as follows.

#include "Pods/Target Support Files/Pods-testDemo/Pods-testDemo.debug.xcconfig"

SDK_APP_ID = app_id_common
SDK_ENV = common
SDK_DEA_ADDRESS = http:\$()\xxxxxxxx:9531 
```

3. Configuring a custom build environment

![](../img/multi-environment-configuration4.png)



![](../img/multi-environment-configuration5.png)


4. Use

**In the script**

```sh
#Parameters that need to be configured
#＜app_id＞
FT_APP_ID=SDK_APP_ID
#＜dea_address＞
FT_DEA_ADDRESS=SDK_DEA_ADDRESS
# ＜env＞ environment field. value：prod/gray/pre/common/local。Need to be consistent with SDK settings
FT_ENV=SDK_ENV
```

**In a document for a project** 

Method 1: Configure the specified file: -D'SDK_APP_ID=@"$(SDK_APP_ID)"'

![](../img/multi-environment-configuration6.png)



In the specified file you can use

![](../img/multi-environment-configuration7.png)



Method 2: Mapping to the `Info.plist` file

![](../img/multi-environment-configuration8.png)



In the file you can use

![](../img/multi-environment-configuration9.png)


For more details, please see [SDK Demo](https://github.com/DataFlux-cn/datakit-ios/tree/develop/demo).

#### Method 2: Terminal run script

Find the .dSYM file in a folder, enter the basic application information, the parent directory path of the .dSYM file, and the output file directory at the command line.

`sh FTdSYMUpload.sh <dea_address> <app_id> <version> <env> <dSYMBOL_src_dir> <dSYMBOL_dest_dir>`

#### Method 3: Manual upload

[Sourcemap Upload](../../datakit/rum.md#sourcemap)

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

1. `Xcode -> Window -> Organizer ` 

2. Select the `Archives` tab

   ![](../img/xcode_find_dsym2.png)
   
3. Find the published archive package, right-click on the corresponding archive package, and select Show in Finder operation

   ![](../img/xcode_find_dsym3.png)
   
   
   
4. Right-click on the located archive file and select the Show Package Contents action 

   ![](../img/xcode_find_dsym4.png)
   
   
   
5. Select the dSYMs directory, which contains the downloaded dSYM files

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



