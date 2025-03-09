# Changelog

---
## **1.5.12** (2025/02/10) {#1-5-12}

1. Adjusted file storage path configuration to fix the issue of database creation failure in the tvOS environment.
2. Updated the default `service` and log `source` for the tvOS environment, set to `df_rum_tvos` and `df_rum_tvos_log` respectively.
3. Fixed the inaccurate calculation of `duration` in RUM Action events.

## **1.5.11 (2025/02/05)** {#1-5-11}

1. Optimized RUM Resource collection to prevent SDK internal requests from being collected when automatic RUM Resource collection is enabled.
2. Fixed the issue of skyWalking type link tracing failing in Widget Extension.

## **1.5.10 (2025/01/21)** {#1-5-10}

1. Supported intercepting Request custom Trace via `FTTraceConfig.traceInterceptor`, and adding custom properties to RUM Resources via `FTRumConfig.resourcePropertyProvider`.
2. Fixed exceptions caused by dynamically adding global attributes under multi-threaded access.
3. Optimized data information passed to WebView.

## **1.5.9 (2025/01/08)** {#1-5-9}

1. Added support for intercepting `URLRequest` via the `FTURLSessionDelegate.traceInterceptor` block for custom link tracing, changing spanId and traceId in the link.
2. RUM Resource now supports collecting network requests initiated through Swift async/await URLSession API.
3. Fixed issues with LongTask and Anr association with View errors.

## **1.5.8 (2024/12/23)** {#1-5-8}

1. Added support for tvOS.
2. Supported limiting the maximum number of RUM cache entries via `FTRUMConfig.rumCacheLimitCount`, and setting discard policies via `FTRUMConfig.rumDiscardType`.
3. Supported limiting total cache size via `FTMobileConfig.enableLimitWithDbSize`. When enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be disabled. Supported setting db discard policies via `FTMobileConfig.dbDiscardType` and db cache limit size via `FTMobileConfig.dbCacheLimit`.

## **1.5.7 (2024/12/04)** {#1-5-7}

1. Supported setting freeze detection threshold via `FTRUMConfig.freezeDurationMs`.
2. Optimized the `shutDown` method of the SDK to avoid blocking or WatchDog crashes due to main thread synchronous waits.

## **1.5.6 (2024/11/13)** {#1-5-6}

1. Supported configuring deflate compression for synchronized data via `FTMobileConfig.compressIntakeRequests`.
2. Added `addAction:actionType:property` and `startAction:actionType:property:` methods to RUM, optimizing RUM Action collection logic.
3. Fixed crash issues caused by using deprecated NSFileHandle APIs.

## **1.5.5 (2024/11/06)** {#1-5-5}

1. Fixed a crash caused by array out-of-bounds in `FTResourceMetricsModel`.

## **1.5.4 (2024/10/18)** {#1-5-4}

1. Added dynamic setting methods for global, log, and RUM globalContext attributes.
2. Added a data clearing method to delete all unsynced data.
3. Adjusted the maximum supported synchronization interval to 5000 milliseconds.

## **1.5.3 (2024/10/09)** {#1-5-3}

1. Fixed memory access errors during LongTask and Anr collection due to incorrect attribute modifiers.
2. Replaced method signature validation assertions in `FTSwizzler` with internal warning logs.
3. Optimized decimal precision of collected data.

## **1.5.2 (2024/08/21)** {#1-5-2}

1. Fixed the missing `#include <arm/_mcontext.h>` header file issue when compiling with Xcode 16.
2. Filtered out directly cached or unknown-type Resources during automatic RUM-Resource collection to prevent duplication.
3. Fixed the calculation logic for loadingTime of UITabBarController child views.

## **1.5.1 (2024/08/02)** {#1-5-1}

1. Fixed the line protocol data escape algorithm to resolve data synchronization failures caused by newline characters.
2. Standardized error messages for errors of type `network_error` to use English descriptions of network request error codes.
3. Optimized data synchronization logic, fixing crashes caused by accessing released `uploadDelayTimer` in multi-threaded scenarios.
4. Fixed crashes caused by encoding format mismatches between OC and C strings when collecting crash information.

## **1.5.0 (2024/06/03)** {#1-5-0}

1. Added remote IP address resolution functionality to RUM resource network requests.
2. Added integer data compatibility mode for line protocol to handle web data type conflicts.
3. Added custom status methods to logs.
4. Optimized log data writing and synchronization.
5. Handled NSDictionary parameters passed to the SDK to prevent JSON conversion failures and data loss.

## **1.4.14 (2024/05/29)** {#1-4-14}

1. Fixed memory access errors caused by accessing destroyed Class objects in `FTSwizzler`.
2. Resolved data consistency and operation conflict issues when passing mutable objects as NSDictionary parameters to the SDK.

## **1.4.13 (2024/05/15)** {#1-4-13}

1. Optimized RUM LongTask and Anr collection, fixed inaccurate stack trace collection for LongTasks, and added support for collecting fatal freezes.
2. Fixed crashes caused by simultaneous multi-threaded operations on NSMutableSet in `FTSwizzler`.
3. Fixed missing version information in the SDK Framework info.plist.
4. Fixed performance metric collection failures for Resources when a custom NSURLSession delegate was not set.
5. Optimized the conversion of internal logs to files and added methods to specify file paths.

## **1.4.12 (2024/04/26)** {#1-4-12}

1. Fixed memory leaks caused by calling the shutDown method in the SDK.
2. Fixed crashes caused by conflicts with other libraries during RUM-Resource collection.
3. Fixed the issue where UncaughtExceptionHandler was not passed during crash collection.
4. Fixed data anomalies caused by multiple initializations of the SDK.

## **1.4.11 (2024/03/28)** {#1-4-11}

1. Added support for configuring data synchronization parameters, including request entry data, synchronization intervals, and log cache entry counts.
2. Added methods to convert internal logs to files.
3. Fixed errors in retrieving RUM data associated with logs.
4. Optimized time-consuming operations.
5. Fixed crashes caused by WebView jsBridge, changed WebView references to weak references.

[More Logs](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)