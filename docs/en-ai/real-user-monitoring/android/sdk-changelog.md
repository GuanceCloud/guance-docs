# Change Log
---
<div class="grid cards" markdown>
- [__ft-sdk__](#ft-sdk)
- [__ft-plugin__](#ft-plugin)
- [__ft-native__](#ft-native)  
- [__ft-plugin-legacy__](#ft-plugin-legacy)  
</div>

## **ft-sdk** {#ft-sdk}
### **1.6.9 (2025/03/07)** {#ft-sdk-1-6-9}
1. Modified the judgment mechanism of `isAppForeground` to adapt to privacy-sensitive information detection.
2. Added new `resource` data fields: `resource_first_byte_time`, `resource_dns_time`, `resource_download_time`, `resource_connect_time`, and `resource_ssl_time`. These support enhanced Resource timing display on Guance and align with APM flame graphs.
3. Optimized the synchronous retry mechanism and removed the configuration option for direct data discard using `FTSDKConfig.setDataSyncRetryCount(0)`.
4. Enabled `FTSDKConfig.enableDataIntegerCompatible` by default to ensure compatibility with web floating-point number types.
5. Fixed an issue where duplicate crash data was generated due to multiple initializations of RUM configurations.

### **1.6.8 (2025/01/21)** {#ft-sdk-1-6-8}
1. Fixed inaccurate FPS collection in scenarios with multiple initializations of RUM configurations.
2. Enhanced fault tolerance for upgrading old cache data.
3. Moved `FTRUMConfig.setOkHttpTraceHeaderHandler` to `FTTraceConfig.setOkHttpTraceHeaderHandler`.
4. Enhanced internal WebView SDK information, improving performance.

### **1.6.7 (2025/01/10)** {#ft-sdk-1-6-7}
1. Supported customizing `FTTraceInterceptor.HeaderHandler` to associate with RUM data.
2. Allowed modifying `FTTraceInterceptor.HeaderHandler` content via `FTRUMConfig.setOkHttpTraceHeaderHandler` and `FTResourceInterceptor.ContentHandlerHelper` content via `FTRUMConfig.setOkHttpResourceContentHandler`.
3. Optimized crash collection capabilities to handle OS-triggered `system.exit` scenarios.
4. Fixed an issue where empty tags caused data reporting failures.
5. Optimized ASM OkHttpListener EventListener coverage logic to preserve original project event parameter passing.

### **1.6.6 (2024/12/27)** {#ft-sdk-1-6-6}
1. Optimized network status and type retrieval, supporting Ethernet network type display.
2. Prevented frequent database closures when no network connection is available.
3. Fixed discrepancies between discarded log entries and set limits during RUM data discarding.
4. Adapted TV device key events, removing non-TV device tags.
5. Supported limiting RUM data cache entry count via `FTRUMConfig.setRumCacheLimitCount(int)` (default: 100,000).
6. Supported limiting total cache size via `FTSDKConfig.enableLimitWithDbSize(long dbSize)`, which disables `FTLoggerConfig.setLogCacheLimitCount(int)` and `FTRUMConfig.setRumCacheLimitCount(int)`.
7. Optimized Session refresh rules for devices without user interaction.

### **1.6.5 (2024/12/24)** {#ft-sdk-1-6-5}
1. Reduced WebView AOP parameter null warnings.
2. Optimized long session updates for apps running in the background.

### **1.6.4 (2024/12/03)** {#ft-sdk-1-6-4}
1. Improved app launch time statistics for API level 24 and above.
2. Supported setting detection time ranges via `FTRUMConfig.setEnableTrackAppUIBlock(true, blockDurationMs)`.

### **1.6.3 (2024/11/18)** {#ft-sdk-1-6-3}
1. Optimized high-frequency `addAction` performance.
2. Supported configuring `deflate` compression for synchronized data via `FTSDKConfig.setCompressIntakeRequests`.

### **1.6.2 (2024/10/24)** {#ft-sdk-1-6-2}
1. Added `addAction` method in RUM to support property extension attributes and frequent consecutive data reporting.

### **1.6.1 (2024/10/18)** {#ft-sdk-1-6-1}
1. Fixed thread not being reclaimed when calling custom `startView` in RUM.
2. Supported adding dynamic properties via `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, and `FTSdk.appendLogGlobalContext(globalContext)`.
3. Supported clearing unsent cached data via `FTSdk.clearAllData()`.
4. Extended the maximum limit of `setSyncSleepTime` to 5000 ms.

### **1.6.0 (2024/08/18)** {#ft-sdk-1-6-0}
1. Optimized data storage and synchronization performance.
   (Old versions upgrading to 1.6.0 need to configure `FTSDKConfig.setNeedTransformOldCache` for old data compatibility.)
2. Fixed an exception triggered by `Log.w(String,Throwable)` when using ft-plugin.

### **1.5.2 (2024/07/10)** {#ft-sdk-1-5-2}
1. Added local network error type prompts to supplement explanations for `resource_status=0` in Resource data.
2. Fixed issues with uncaughtException rethrowing when `setEnableTrackAppCrash(false)` was called.

### **1.5.1 (2024/06/19)** {#ft-sdk-1-5-1}
1. Added stack traces for other threads in Java crashes and ANRs.
2. Supported additional logcat configuration for Java crashes, Native crashes, and ANRs.
3. Fixed frequent session_id updates in long sessions without action updates.

### **1.5.0 (2024/06/03)** {#ft-sdk-1-5-0}
1. Added remote IP address resolution for RUM resource network requests.
2. Fixed thread safety issues in high-concurrency network requests after enabling RUM SampleRate.
3. Optimized fault tolerance for `ConnectivityManager.registerDefaultNetworkCallback`.
4. Added integer data compatibility mode for handling web data type conflicts.
5. Optimized widget resource ID acquisition in automatically collected Action click events.
6. Enhanced fault tolerance for SDK config read exceptions.

### **1.4.6 (2024/05/15)** {#ft-sdk-1-4-6}
1. Enhanced fault tolerance during SDK initialization.
2. Added Status.Debug type for new logs.
3. Adjusted console log level mappings: `Log.i` -> `info`, `Log.d` -> `debug`.
4. Supported custom status fields in FTLogger custom logs.

### **1.4.5 (2024/04/26)** {#ft-sdk-1-4-5}
1. Enhanced fault tolerance for repeated initializations.
2. Optimized C/C++ crash data synchronization logic to prevent deadlocks.
3. Optimized `startAction` property writing logic to avoid thread safety issues.

### **1.4.4 (2024/04/01)** {#ft-sdk-1-4-4}
1. Added database connection fault protection.
2. Fixed partial child process configuration issues when `setOnlySupportMainProcess` is true.
3. Fixed Crash rethrow issues when View collection is disabled in RUM.

### **1.4.3 (2024/03/22)** {#ft-sdk-1-4-3}
1. Supported uploading Dataway and Datakit addresses.
2. Supported sending RUM data types: Action, View, Resource, LongTask, Error.
   - View and Action page transitions and control clicks are automatically collected using ft-plugin.
   - Resource data is automatically collected only for Okhttp and requires ft-plugin.
   - Native Crashes and ANRs require ft-native.
3. Supported sending Log data, with automatic console writes requiring ft-plugin.
4. Supported HTTP header propagation for tracing, only for Okhttp and requiring ft-plugin.
5. Supported configurable data sync parameters: request entry count, sync interval, and log cache entry count.
6. Supported converting SDK internal logs to files.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/CHANGELOG.md)

## **ft-native** {#ft-native}
### **1.1.1 (2024/06/22)** {#ft-native-1-1-1}
1. Added logcat configuration functionality for Native Crashes and ANRs.

### **1.1.0 (2024/03/22)** {#ft-native-1-1-0}
1. Supported capturing ANR Crashes.
2. Supported capturing C/C++ Native Crashes.
3. Supported collecting application runtime state during crashes.
4. Supported callback triggers for ANR and Native Crashes.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-native/CHANGELOG.md)

## **ft-plugin ( AGP >=7.4.2 )** {#ft-plugin}
### **1.3.4 (2024/12/11)**:
1. Optimized error log output.
2. Fixed sourcemap symbol file generation issues when `minifyEnabled` was not enabled.
3. Supported generating sourcemaps without uploading via `generateSourceMapOnly true`.

### **1.3.3 (2024/09/04)**:
1. Optimized automatic native symbol so file upload, supporting custom nativeLibPath.

### **1.3.2 (2024/08/13)**:
1. Supported automatic capture of React Native WebView events.

### **1.3.1 (2024/07/04)**:
1. Added asmVersion configuration, supporting asm7 - asm9 (default: asm9).
2. Fixed loop calls in WebView custom methods post ASM injection, preventing WebView content loading issues (`loadUrl`, `loadData`, `loadDataWithBaseURL`, `postUrl`).
3. Supported IgnoreAOP declarations within classes to ignore entire class methods.
4. Added `ignorePackages` configuration to ignore ASM processing based on package paths.

### **1.3.0 (2024/03/22)**:
1. Supported automatic source map uploads for datakit and native symbols.
2. Supported capturing cold/hot starts, Activity transitions, and View, ListView, Dialog, Tab click events.
3. Supported injecting Webview Js listener methods.
4. Supported automatic Okhttp Trace and Resource data injection.
5. Supported Gradle 8.0, AGP 8.0.
6. Supported IgnoreAOP markers.
7. Supported compatibility with Alibaba Cloud's hotfix framework.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-plugin/CHANGELOG.md)

## **ft-plugin-legacy ( AGP <=7.4.2 )** {#ft-plugin-legacy}
### **1.1.8 (2024/08/13)**:
1. Supported automatic capture of React Native WebView events.

### **1.1.7 (2024/07/04)**:
1. Fixed loop calls in WebView subclass overridden methods post ASM injection, preventing WebView content loading issues (`loadUrl`, `loadData`, `loadDataWithBaseURL`, `postUrl`).
2. Supported IgnoreAOP declarations within classes to ignore entire class methods.
3. Added `ignorePackages` configuration to ignore ASM processing based on package paths.

### **1.1.6 (2024/03/22)**:
1. Supported automatic source map uploads for datakit and native symbols.
2. Supported capturing cold/hot starts, Activity transitions, and View, ListView, Dialog, Tab click events.
3. Supported injecting Webview Js listener methods.
4. Supported automatic Okhttp Trace and Resource data injection.
5. Supported AGP versions below 7.4.2.
6. Supported IgnoreAOP markers.
7. Supported compatibility with Alibaba Cloud's hotfix framework.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/plugin_legacy_support/ft-plugin/CHANGELOG.md)