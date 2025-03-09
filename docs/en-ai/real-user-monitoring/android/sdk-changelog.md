# Change Log
---
<div class="grid cards" markdown>
- [__ft-sdk__](#ft-sdk)
- [__ft-plugin__](#ft-plugin)
- [__ft-native__](#ft-native)  
- [__ft-plugin-legacy__](#ft-plugin-legacy)  
</div>

## **ft-sdk** {#ft-sdk}
### **1.6.8 (2025/01/21)** {#ft-sdk-1-6-8}
1. Fixed the issue of inaccurate FPS collection when RUM configuration is initialized multiple times.
2. Enhanced fault tolerance for upgrading old version cache data.
3. Moved `FTRUMConfig.setOkHttpTraceHeaderHandler` to `FTTraceConfig.setOkHttpTraceHeaderHandler`.
4. Enhanced internal information of WebView SDK to improve performance.

### **1.6.7 (2025/01/10)** {#ft-sdk-1-6-7}
1. Supported custom association of `FTTraceInterceptor.HeaderHandler` with RUM data.
2. Allowed modification of ASM-written `FTTraceInterceptor.HeaderHandler` content via `FTRUMConfig.setOkHttpTraceHeaderHandler`, and modification of ASM-written `FTResourceInterceptor.ContentHandlerHelper` content via `FTRUMConfig.setOkHttpResourceContentHandler`.
3. Improved crash collection capabilities to handle scenarios where `system.exit` triggers crashes that cannot be collected.
4. Fixed an issue where tags occasionally appeared as empty strings, preventing data from being reported properly.
5. Optimized the coverage logic of ASM OkHttpListener EventListener to support retaining original project EventListener event parameters.
### **1.6.6 (2024/12/27)** {#ft-sdk-1-6-6}
1. Optimized network status and type acquisition, supporting ethernet type display.
2. Prevented frequent database closures in no-network states.
3. Fixed discrepancies between data entry counts and set entry counts when discarding logs and RUM old data.
4. Adapted TV device key events, removing non-TV device tags.
5. Supported limiting RUM data cache entry count via `FTRUMConfig.setRumCacheLimitCount(int)` with a default of 100,000.
6. Supported limiting total cache size via `FTSDKConfig.enableLimitWithDbSize(long dbSize)`. Once enabled, `FTLoggerConfig.setLogCacheLimitCount(int)` and `FTRUMConfig.setRumCacheLimitCount(int)` will be disabled.
7. Optimized Session refresh rules for devices without user interaction.
### **1.6.5 (2024/12/24)** {#ft-sdk-1-6-5}
1. Reduced warnings about null parameters during AOP processing in Webview.
2. Improved long Session update mechanisms when the app is in the background.
### **1.6.4 (2024/12/03)** {#ft-sdk-1-6-4}
1. Optimized App startup time statistics for API 24 and above.
2. Supported setting detection time range via `FTRUMConfig.setEnableTrackAppUIBlock(true, blockDurationMs)`.
### **1.6.3 (2024/11/18)** {#ft-sdk-1-6-3}
1. Improved performance of high-frequency calls to `addAction`.
2. Supported configuring `deflate` compression for synchronized data via `FTSDKConfig.setCompressIntakeRequests`.
### **1.6.2 (2024/10/24)** {#ft-sdk-1-6-2}
1. Added `addAction` method to RUM, supporting property extensions and frequent consecutive data reporting.
### **1.6.1 (2024/10/18)** {#ft-sdk-1-6-1}
1. Fixed an issue where calling `startView` alone caused `FTMetricsMTR` threads not to be reclaimed.
2. Supported adding dynamic properties via `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, and `FTSdk.appendLogGlobalContext(globalContext)`.
3. Supported clearing unsent cached data via `FTSdk.clearAllData()`.
4. Extended the maximum limit of `setSyncSleepTime` to 5000 ms.
### **1.6.0 (2024/08/18)** {#ft-sdk-1-6-0}
1. Optimized data storage and synchronization performance.
   (Old versions upgrading to 1.6.0 require configuring `FTSDKConfig.setNeedTransformOldCache` for compatibility with old data synchronization.)
2. Fixed an exception triggered by calling `Log.w(String, Throwable)` when using ft-plugin.
### **1.5.2 (2024/07/10)** {#ft-sdk-1-5-2}
1. Added local network error type prompts to Error network_error to supplement Resource data where resource_status=0.
2. Fixed issues with rethrowing uncaughtException when `setEnableTrackAppCrash(false)` was called.
### **1.5.1 (2024/06/19)** {#ft-sdk-1-5-1}
1. Added stack traces from other threads for Java Crashes and ANRs.
2. Added logcat configuration features for Java Crashes, Native Crashes, and ANRs.
3. Fixed frequent session_id updates in long sessions without action updates.
### **1.5.0 (2024/06/03)** {#ft-sdk-1-5-0}
1. Added remote IP address parsing functionality to RUM resource network requests.
2. Fixed thread safety issues with high-concurrency network requests after enabling RUM SampleRate.
3. Optimized fault tolerance for `ConnectivityManager.registerDefaultNetworkCallback`.
4. Added integer data compatibility mode for handling web data type conflicts.
5. Optimized control element resource name id acquisition in automatically collected Action clicks.
6. Improved fault tolerance for SDK config read exceptions.
### **1.4.6 (2024/05/15)** {#ft-sdk-1-4-6}
1. Optimized SDK initialization fault tolerance.
2. Added Status.Debug type for new logs.
3. Adjusted console log level mappings: `Log.i` -> `info`, `Log.d` -> `debug`.
4. Supported custom status fields in FTLogger custom logs.
### **1.4.5 (2024/04/26)** {#ft-sdk-1-4-5}
1. Optimized repeated initialization compatibility.
2. Improved C/C++ crash data synchronization logic to prevent deadlocks in certain scenarios.
3. Optimized Property attribute writing logic in `startAction` to avoid thread safety issues.
### **1.4.4 (2024/04/01)** {#ft-sdk-1-4-4}
1. Added database connection fault protection.
2. Fixed partial child process configurations not taking effect when `setOnlySupportMainProcess` was true.
3. Fixed issues where Crash would not rethrow if View collection was not enabled in RUM.
### **1.4.3 (2024/03/22)** {#ft-sdk-1-4-3}
1. Supported uploading Dataway and Datakit addresses.
2. Supported sending RUM data types: Action, View, Resource, LongTask, Error.
   - View and Action page transitions and control clicks are automatically collected using ft-plugin.
   - Resource data is automatically collected only for Okhttp and requires ft-plugin.
   - Errors such as Native Crashes and ANRs require ft-native.
3. Supported sending Log data with automatic console writes, requiring ft-plugin.
4. Supported HTTP header propagation in trace chains, only for Okhttp and requiring ft-plugin.
5. Supported data synchronization parameter configuration, including request entry data, synchronization intervals, and log cache entry counts.
6. Supported converting SDK internal logs to files.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/CHANGELOG.md)

## **ft-native** {#ft-native}
### **1.1.1 (2024/06/22)** {#ft-native-1-1-1}
1. Added logcat configuration features for Native Crashes and ANRs.
### **1.1.0 (2024/03/22)** {#ft-native-1-1-0}
1. Supported capturing ANR Crashes.
2. Supported capturing C/C++ Native Crashes.
3. Supported collecting application runtime state during crashes.
4. Supported triggering callbacks on ANR and Native Crashes.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-native/CHANGELOG.md)

## **ft-plugin (AGP >=7.4.2)** {#ft-plugin}
### **1.3.4 (2024/12/11)**:
1. Optimized error log output.
2. Fixed sourcemap symbol file generation issues when `minifyEnabled` was not enabled.
3. Supported generating sourcemaps without uploading via `generateSourceMapOnly true`.

### **1.3.3 (2024/09/04)**:
1. Optimized automatic native symbol so file upload, supporting custom `nativeLibPath`.

### **1.3.2 (2024/08/13)**:
1. Supported automatic capture of React Native WebView events.

### **1.3.1 (2024/07/04)**:
1. Added `asmVersion` configuration, supporting asm7 - asm9 with a default of asm9.
2. Fixed loop calls preventing WebView content loading after ASM writes for custom methods (`loadUrl`, `loadData`, `loadDataWithBaseURL`, `postUrl`).
3. Supported IgnoreAOP declarations within classes to ignore all methods.
4. Added `ignorePackages` configuration to ignore ASM via package paths.

### **1.3.0 (2024/03/22)**:
1. Supported automatic datakit source map uploads and native symbol uploads.
2. Supported capturing cold/hot Application starts, Activity page transitions, and View, ListView, Dialog, Tab click events.
3. Supported writing Webview Js listener methods.
4. Supported automatic writing of Okhttp Trace and Resource data.
5. Supported Gradle 8.0 and AGP 8.0.
6. Supported IgnoreAOP ignore markers.
7. Supported compatibility with Alibaba Cloud hotfix framework.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-plugin/CHANGELOG.md)

## **ft-plugin-legacy (AGP <=7.4.2)** {#ft-plugin-legacy}
### **1.1.8 (2024/08/13)**:
1. Supported automatic capture of React Native WebView events.

### **1.1.7 (2024/07/04)**:
1. Fixed loop calls preventing WebView content loading after ASM writes for subclass methods (`loadUrl`, `loadData`, `loadDataWithBaseURL`, `postUrl`).
2. Supported IgnoreAOP declarations within classes to ignore all methods.
3. Added `ignorePackages` configuration to ignore ASM via package paths.

### **1.1.6 (2024/03/22)**:
1. Supported automatic datakit source map uploads and native symbol uploads.
2. Supported capturing cold/hot Application starts, Activity page transitions, and View, ListView, Dialog, Tab click events.
3. Supported writing Webview Js listener methods.
4. Supported automatic writing of Okhttp Trace and Resource data.
5. Supported AGP versions below 7.4.2.
6. Supported IgnoreAOP ignore markers.
7. Supported compatibility with Alibaba Cloud hotfix framework.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/plugin_legacy_support/ft-plugin/CHANGELOG.md)