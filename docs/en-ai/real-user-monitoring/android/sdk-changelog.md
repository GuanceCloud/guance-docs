# Changelog
---
<div class="grid cards" markdown>
- [__ft-sdk__](#ft-sdk)
- [__ft-plugin__](#ft-plugin)
- [__ft-native__](#ft-native)  
- [__ft-plugin-legacy__](#ft-plugin-legacy)  
</div>

## **ft-sdk** {#ft-sdk}
### **1.6.8 (2025/01/21)** {#ft-sdk-1-6-8}
1. Fixed the issue of inaccurate FPS collection when initializing RUM configuration multiple times.
2. Enhanced compatibility with old version cache data upgrades.
3. Moved `FTRUMConfig.setOkHttpTraceHeaderHandler` to `FTTraceConfig.setOkHttpTraceHeaderHandler`.
4. Enhanced WebView SDK internal information for better performance.

### **1.6.7 (2025/01/10)** {#ft-sdk-1-6-7}
1. Supported custom association of `FTTraceInterceptor.HeaderHandler` with RUM data.
2. Allowed changing the content of `FTTraceInterceptor.HeaderHandler` written by ASM via `FTRUMConfig.setOkHttpTraceHeaderHandler`, and changing the content of `FTResourceInterceptor.ContentHandlerHelper` written by ASM via `FTRUMConfig.setOkHttpResourceContentHandler`.
3. Improved crash collection capabilities, adapting to scenarios where `system.exit` triggers crashes that cannot be collected.
4. Fixed an issue where empty tag characters caused data to fail to report properly.
5. Optimized the coverage logic of ASM OkHttpListener EventListener to support retaining original project EventListener event parameters.
### **1.6.6 (2024/12/27)** {#ft-sdk-1-6-6}
1. Enhanced network status and type acquisition, supporting Ethernet network types.
2. Optimized frequent database closure issues in no-network states.
3. Fixed discrepancies between the number of discarded logs and RUM old data entries and the set entry numbers.
4. Adapted TV device key events, removing non-TV device tags.
5. Supported limiting RUM data cache entry count using `FTRUMConfig.setRumCacheLimitCount(int)`, defaulting to 100,000.
6. Supported total cache size limitation using `FTSDKConfig enableLimitWithDbSize(long dbSize)`, rendering `FTLoggerConfig.setLogCacheLimitCount(int)` and `FTRUMConfig.setRumCacheLimitCount(int)` ineffective after enabling.
7. Optimized Session refresh rules under device idle scenarios.
### **1.6.5 (2024/12/24)** {#ft-sdk-1-6-5}
1. Reduced null parameter warnings in Webview during AOP processes.
2. Optimized long session update mechanisms for applications running in the background.
### **1.6.4 (2024/12/03)** {#ft-sdk-1-6-4}
1. Optimized API 24+ app startup time statistics.
2. Supported setting detection time ranges via `FTRUMConfig.setEnableTrackAppUIBlock(true, blockDurationMs)`.
### **1.6.3 (2024/11/18)** {#ft-sdk-1-6-3}
1. Optimized high-frequency `addAction` call performance.
2. Supported configuring `deflate` compression for synchronized data using `FTSDKConfig.setCompressIntakeRequests`.
### **1.6.2 (2024/10/24)** {#ft-sdk-1-6-2}
1. Added a new `addAction` method to RUM, supporting property expansion attributes and frequent continuous data reporting.
### **1.6.1 (2024/10/18)** {#ft-sdk-1-6-1}
1. Fixed thread not being recycled for monitoring metrics `FTMetricsMTR` when calling custom `startView` in RUM.
2. Supported adding dynamic properties via `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, and `FTSdk.appendLogGlobalContext(globalContext)`.
3. Supported clearing unsent cached data using `FTSdk.clearAllData()`.
4. Extended the maximum limit of `setSyncSleepTime` to 5000 ms.
### **1.6.0 (2024/08/18)** {#ft-sdk-1-6-0}
1. Optimized data storage and synchronization performance.
   (Old versions upgrading to 1.6.0 require configuring `FTSDKConfig.setNeedTransformOldCache` for backward compatibility.)
2. Fixed exceptions caused by calling `Log.w(String,Throwable)` when using ft-plugin.
### **1.5.2 (2024/07/10)** {#ft-sdk-1-5-2}
1. Added local network error type prompts to `Error network_error` for Resource data with `resource_status=0`.
2. Fixed uncaughtException rethrow passing issues when `setEnableTrackAppCrash(false)` is called.
### **1.5.1 (2024/06/19)** {#ft-sdk-1-5-1}
1. Added stack traces from other threads for Java Crashes and ANRs.
2. Added logcat configuration functionality for Java Crashes, Native Crashes, and ANRs.
3. Fixed frequent session_id updates in long sessions without action updates.
### **1.5.0 (2024/06/03)** {#ft-sdk-1-5-0}
1. Added remote IP address resolution for RUM resource network requests.
2. Fixed thread safety issues in high-concurrency network requests after enabling RUM SampleRate.
3. Optimized fault tolerance for `ConnectivityManager.registerDefaultNetworkCallback`.
4. Added integer data compatibility mode for handling web data type conflicts.
5. Optimized widget resource name id acquisition in automatically collected Action clicks.
6. Optimized fault tolerance for SDK config reading exceptions.
### **1.4.6 (2024/05/15)** {#ft-sdk-1-4-6}
1. Optimized SDK initialization fault tolerance.
2. Added Status.Debug log type.
3. Adjusted console log level mapping: `Log.i` -> `info`, `Log.d` -> `debug`.
4. Supported custom status fields for FTLogger logs.
### **1.4.5 (2024/04/26)** {#ft-sdk-1-4-5}
1. Optimized duplicate initialization compatibility.
2. Avoided deadlocks in c/c++ crash data synchronization.
3. Optimized startAction Property attribute writing logic to prevent thread safety access issues.
### **1.4.4 (2024/04/01)** {#ft-sdk-1-4-4}
1. Added database connection fault tolerance.
2. Fixed partial child process configurations not taking effect when `setOnlySupportMainProcess` was true.
3. Fixed RUM View collection not triggering rethrow for crashes.
### **1.4.3 (2024/03/22)** {#ft-sdk-1-4-3}
1. Supported uploading Dataway and Datakit addresses.
2. Supported sending RUM data types: Action, View, Resource, LongTask, Error.
   - View and Action page transitions and control clicks are automatically collected using ft-plugin.
   - Resource data is automatically collected only for Okhttp and requires ft-plugin.
   - Native Crash and ANR in Error require ft-native.
3. Supported sending Log data with automatic console writing using ft-plugin.
4. Supported HTTP header propagation only for Okhttp and required ft-plugin.
5. Supported data synchronization parameter configurations, including request entry data, synchronization intervals, and log cache entry counts.
6. Supported converting internal SDK logs to files.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/CHANGELOG.md)

## **ft-native** {#ft-native}
### **1.1.1 (2024/06/22)** {#ft-native-1-1-1}
1. Added logcat configuration for Native Crashes and ANRs.
### **1.1.0 (2024/03/22)** {#ft-native-1-1-0}
1. Supported capturing ANR Crashes.
2. Supported capturing C/C++ Native Crashes.
3. Supported collecting application runtime status on crashes.
4. Supported callback calls triggered by ANR and Native Crashes.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-native/CHANGELOG.md)

## **ft-plugin ( AGP >=7.4.2 )** {#ft-plugin}
### **1.3.4 (2024/12/11)**:
1. Optimized error log output.
2. Fixed sourcemap symbol file generation issues when `minifyEnabled` was not enabled.
3. Supported generating sourcemaps without uploading via `generateSourceMapOnly true`.
### **1.3.3 (2024/09/04)**:
1. Optimized native symbol so automatic upload, supporting custom nativeLibPath.
### **1.3.2 (2024/08/13)**:
1. Supported automatic capture of React Native WebView events.
### **1.3.1 (2024/07/04)**:
1. Added asmVersion configuration support, ranging from asm7 to asm9, defaulting to asm9.
2. Fixed infinite loops preventing WebView content loading after ASM writes for custom methods (`loadUrl`, `loadData`, `loadDataWithBaseURL`, `postUrl`).
3. Supported IgnoreAOP declarations within classes for ignoring all methods.
4. Added `ignorePackages` configuration for package path-based ASM ignores.
### **1.3.0 (2024/03/22)**:
1. Supported automatic upload of datakit source maps and native symbols.
2. Supported capturing Application cold/hot starts, Activity page transitions, and View, ListView, Dialog, Tab click events.
3. Supported writing Webview Js listeners.
4. Supported automatic writing of Okhttp Trace and Resource data.
5. Supported Gradle 8.0, AGP 8.0.
6. Supported IgnoreAOP ignore marks.
7. Supported compatibility with Alibaba Cloud's hotfix framework.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-plugin/CHANGELOG.md)

## **ft-plugin-legacy ( AGP <=7.4.2 )** {#ft-plugin-legacy}
### **1.1.8 (2024/08/13)**:
1. Supported automatic capture of React Native WebView events.
### **1.1.7 (2024/07/04)**:
1. Fixed infinite loops preventing WebView content loading after ASM writes for subclass overridden methods (`loadUrl`, `loadData`, `loadDataWithBaseURL`, `postUrl`).
2. Supported IgnoreAOP declarations within classes for ignoring all methods.
3. Added `ignorePackages` configuration for package path-based ASM ignores.
### **1.1.6 (2024/03/22)**:
1. Supported automatic upload of datakit source maps and native symbols.
2. Supported capturing Application cold/hot starts, Activity page transitions, and View, ListView, Dialog, Tab click events.
3. Supported writing Webview Js listeners.
4. Supported automatic writing of Okhttp Trace and Resource data.
5. Supported AGP versions below 7.4.2.
6. Supported IgnoreAOP ignore marks.
7. Supported compatibility with Alibaba Cloud's hotfix framework.

[More Logs](https://github.com/GuanceCloud/datakit-android/blob/plugin_legacy_support/ft-plugin/CHANGELOG.md)