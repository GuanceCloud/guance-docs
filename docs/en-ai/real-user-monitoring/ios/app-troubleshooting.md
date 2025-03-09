# Troubleshooting

## SDK Initialization Exception Check

In the Debug environment, after configuring the <<< custom_key.brand_name >>> SDK and running the application for the first time, please check your debugger console in Xcode. The SDK uses assertions to verify multiple configuration settings and crashes with relevant warnings if there are configuration errors.

For example: If the datakit metrics write address is not set during SDK configuration, the program will crash and output a warning ⚠️ in the console.

```objective-c
*** Assertion failure in +[FTMobileAgent startWithConfigOptions:], FTMobileAgent.m:53
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Please set the datakit metrics write address'
```

## Enabling Debug Mode {#debug-mode}

It is recommended to enable the `enableSDKDebugLog = YES` option in `FTMobileConfig` in the Debug environment and disable it in the Release environment. SDK debug logs are prefixed with **[FTLog]** and can be filtered using [FTLog].

**Note**: If the `scheme` has `OS_ACTIVITY_MODE=disable` set, SDK debug logs will not be output correctly. It is recommended to disable this setting during debugging.

> **It is recommended to disable Debug mode when releasing the Release version**

### Log Example {#log_sample}
#### Data Synchronization {#data_sync}
```objective-c
// Below are normal synchronization logs
[FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:] [line 143] ↵
                                                Start reporting events (Number of events reported this time: 2)
[FTLog][INFO] -[FTRequestLineBody getRequestBodyWithEventArray:] [line 149]
Upload Datas Type: RUM
Line RequestDatas:
...... datas ......
[FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:]_block_invoke [line 157] ↵
                                                Upload Response statusCode : 200

// Before version 1.3.10, `Upload Response statusCode : 200` would not be printed,
// you can check the console for error logs; no error log means successful upload.
// Error logs:
// Network failure: ..... or Server anomaly, try again later ......

```

Before version 1.3.10, `Upload Response statusCode : 200` would not be printed. You can check the console for error logs; no error log means successful upload.

Error logs: `Network failure: ......` or `Server anomaly, try again later ......`

## Converting SDK Internal Logs to Cache Files

```objective-c
// Default path: 1.4.11-1.4.12 /Library/Caches/FTLogs/FTLog xxxx-xx-xx--xx/xx/xx/xxx.log
//               >= 1.4.13 /Documents/FTLogs/FTLog.log

// >= 1.4.11
[[FTLog sharedInstance] registerInnerLogCacheToLogsDirectory:nil fileNamePrefix:nil];

// >= 1.4.13
// Method one: Default path
[[FTLog sharedInstance] registerInnerLogCacheToDefaultPath]
// Method two: Specified path
NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ExampleName.log"];
[[FTLog sharedInstance] registerInnerLogCacheToLogsFilePath:filePath];
```

> **To ensure the completeness of internal logs, this configuration must be set before SDK initialization**

## SDK Is Running Normally But No Data

* [Troubleshoot Datakit](../../datakit/why-no-data.md) to see if it is running normally.

* Confirm that the SDK upload address `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting) and initialized correctly. In [debug mode](#debug-mode), check the [logs](#data_sync) to determine upload issues.

* Verify whether datakit is uploading data to the corresponding workspace and is not offline. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking "Infrastructure".

  ![](../img/17.trouble_shooting_android_datakit_check.png)

## Successful Data Collection Verification

#### Logger 

`enableConsoleLog`: Whether to allow collection of console logs

`enableCustomLog`: Allow reporting of custom logs

To enable Logger functionality, ensure at least one of the above configurations is enabled.

When SDK collects logs, you can see SDK debug logs in the Xcode debugger console.

```objc
[FTLog][INFO] -[FTRecordModel initWithSource:op:tags:fields:tm:] [line 36] write data = {
    op = Logging;
    opdata =     {
        fields =         {
            message = "xxxxx Collected Log Content XXXXX";
        };
        source = "df_rum_ios_log";
        tags =         {
             ...... 
        }
   }
}
```

Seeing **op = Logging;** indicates that the Logger function is working properly and data has been successfully collected.

#### RUM 

Resource data and Action data (except launch action) are bound to View. Ensure View is being collected to collect data properly.

View collection: Set `FTRumConfig`'s `enableTraceUserView = YES` to enable automatic collection or use `-startViewWithName` for manual collection.

Check SDK debug logs in the Xcode debugger console.

```objc
[FTLog][INFO] -[FTRecordModel initWithSource:op:tags:fields:tm:] [line 36] write data = {
    op = RUM;
    opdata =     {
        fields =       {
            .......
        };
        source = action;
        tags =         {
            ........
        }       
   }
}
```

Seeing **op = RUM;** indicates that the RUM function is working properly and data has been successfully collected.

#### Trace

If `enableLinkRumData = YES`, you can see this in the RUM Resource data. Check SDK debug logs in the Xcode debugger console.

```tex
[FTLog][INFO] -[FTRecordModel initWithSource:op:tags:fields:tm:] [line 36] write data = {
    op = RUM;
    opdata =     {
        fields =         {
            duration = 5873084;
            "request_header" = "Accept:*/*\nx-datadog-parent-id:12914452039873665275\nx-datadog-trace-id:6849912365449426814\nx-datadog-origin:rum\nAccept-Language:en-US,en;q=0.9\nAccept-Encoding:gzip, deflate\nx-datadog-sampling-priority:2";
            ......
        };
        source = resource;
        tags =         {
            ......
            "span_id" = 12914452039873665275;
            "trace_id" = 6849912365449426814;
            ......
        };
    };
```

Finding **op = RUM;** and **source = resource;** data with `span_id` and `trace_id` in **tags** indicates that the Trace function is working properly.

## Data Loss

### Partial Data Loss
1. If some RUM Session data or Log, Trace data is lost

   First, exclude whether `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config).

2. If RUM Resource events or Action events (except launch action) are lost

   Check if View auto-collection is enabled or if Open API is used for manual collection. Resource events or Action events are bound to View, so ensure View is being collected.

3. In SDK versions <= 1.4.14, if partial data is lost and such debug logs are seen in the Xcode debugger console:

```tex
*********This data format is incorrect********
(null)*** 1717051153966272768
******************
```

Ensure the `NSDictionary` parameters passed to the SDK meet the following requirements:

- All dictionary keys are NSString

- All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull

- NSNumber is not NaN or infinite

It is recommended to use NSString for all key-value pairs.

4. Investigate network and load issues with devices uploading data and datakit devices.

### Error Data Loss (Crash Type Data)

* Check if Crash collection is enabled

* Ensure SDK initialization is completed before a crash occurs

* Check if other third-party components with crash capture capabilities are used; if so, initialize FTMobileSDK after these components

* In the Xcode debugging phase

  The SDK uses **UNIX signals** and **Mach exceptions** to capture crashes, both of which are affected by Xcode's default `Debug executable`. It intercepts these exceptions before the SDK does. Therefore, to capture crashes during debugging, manually disable the `Debug executable` feature or test without Xcode connected.
  **Note:** Disabling `Debug executable` will disable breakpoint debugging.

  ![troubleshooting_debug_executable](../img/troubleshooting_debug_executable.png)

## Version Compatibility Issues

### Missing Performance Metrics in RUM Resource Events

The SDK supports iOS 9 and above. Performance metrics in RUM Resource events require system APIs supported from iOS 10 onwards. Thus, if the user's device runs an iOS version below 10, the collected Resource events will lack performance metrics.

### Carrier Property in RUM Error Data Shows `--`

In iOS 16.4 and above, `CTCarrier` in `CoreTelephony` is deprecated and has no replacement API. Using deprecated methods returns static value `--`.

## WebView

### **[xxViewController retain]: message sent to deallocated instance xxx**

**Affected Versions: SDK versions less than or equal to 1.4.10**

**Cause**: When using WebView, observers were added to WebView but not removed before they were released. Since SDK internally strongly references WebView, WebView was not released, leading to `EXC_BAD_ACCESS` errors when KeyPath changes notified the already-released observer.

**Fix Recommendations**:

* Upgrade SDK version

* Or remove observers before they are released.

```objc
   - (void)createWebView{
     [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
   }
   -(void)dealloc{
     [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"]
   }
```