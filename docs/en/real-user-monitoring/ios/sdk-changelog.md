# Changelog

---
## **1.5.14 (2025/03/07)** {#1-5-14}

1. Added new RUM `Resource` data fields `resource_first_byte_time`, `resource_dns_time`, `resource_download_time`, `resource_connect_time`, `resource_ssl_time`, `resource_redirect_time`, supporting enhanced display of Resource timing in Guance and alignment with APM flame graphs.

2. Enabled `FTMobileConfig.enableDataIntegerCompatible` by default.

3. Added support for disabling SDK internal URLSession Method Swizzling via the macro definition `FT_DISABLE_SWIZZLING_RESOURCE`.

4. Optimized data synchronization, added retry logic for failed transmissions.

## **1.5.13** (2025/02/27) {#1-5-13}

1. Optimized page collection logic to prevent missing RUM View collection due to special views.

## **1.5.12** (2025/02/10) {#1-5-12}

1. Adjusted file storage path configuration to fix database creation failure issues in tvOS environment.
2. Updated the default `service` and log `source` in the tvOS environment to `df_rum_tvos` and `df_rum_tvos_log` respectively.
3. Fixed inaccurate calculation of `duration` in RUM Action events.

## **1.5.11 (2025/02/05)** {#1-5-11}

1. Optimized RUM Resource collection to prevent SDK internal requests from being collected when automatic Resource collection is enabled.
2. Fixed Widget Extension skyWalking type trace failures.

## **1.5.10 (2025/01/21)** {#1-5-10}

1. Supported intercepting Requests through `FTTraceConfig.traceInterceptor` for custom Trace, and adding custom properties to RUM Resources using `FTRumConfig.resourcePropertyProvider`.
2. Fixed exceptions caused by dynamic global attribute addition methods under multi-threaded access.
3. Optimized WebView data transmission.

## **1.5.9 (2025/01/08)** {#1-5-9}

1. Added support for intercepting `URLRequest` through the `FTURLSessionDelegate.traceInterceptor` block for custom tracing and modifying spanId and traceId in traces.
2. Supported collecting network requests initiated via swift async/await URLSession API in RUM Resources.
3. Fixed errors in associating LongTask and ANR with Views.

## **1.5.8 (2024/12/23)** {#1-5-8}

1. Added support for tvOS.
2. Supported limiting the maximum number of cached RUM entries via `FTRUMConfig.rumCacheLimitCount` and setting discard policies via `FTRUMConfig.rumDiscardType`.
3. Supported restricting total cache size via `FTMobileConfig.enableLimitWithDbSize`. When enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` become ineffective. Supported setting db discard policies via `FTMobileConfig.dbDiscardType` and db cache limits via `FTMobileConfig.dbCacheLimit`.

## **1.5.7 (2024/12/04)** {#1-5-7}

1. Supported setting freeze detection thresholds via `FTRUMConfig.freezeDurationMs`.
2. Optimized the SDK's `shutDown` method to avoid deadlocks or WatchDog crashes caused by main thread synchronous waiting.

## **1.5.6 (2024/11/13)** {#1-5-6}

1. Supported configuring deflate compression for synchronized data via `FTMobileConfig.compressIntakeRequests`.
2. Added `addAction:actionType:property` and `startAction:actionType:property:` methods to RUM, optimizing RUM Action collection logic.
3. Fixed crashes caused by deprecated NSFileHandle APIs.

## **1.5.5 (2024/11/06)** {#1-5-5}

1. Fixed crashes caused by out-of-bounds arrays in `FTResourceMetricsModel`.

## **1.5.4 (2024/10/18)** {#1-5-4}

1. Added dynamic settings for global, log, and RUM globalContext attributes.
2. Added a method to clear all unsynced data.
3. Increased the maximum interval between syncs to 5000 milliseconds.

## **1.5.3 (2024/10/09)** {#1-5-3}

1. Fixed memory access errors caused by incorrect property modifiers during LongTask and ANR collection.
2. Replaced method signature validation assertions in `FTSwizzler` with internal warning logs.
3. Optimized decimal precision of collected data.

## **1.5.2 (2024/08/21)** {#1-5-2}

1. Fixed the missing `#include <arm/_mcontext.h>` header file issue when compiling with Xcode 16.
2. Filtered out directly cached or unknown type Resources during automatic RUM-Resource collection to prevent duplication.
3. Fixed UITabBarController subview loadingTime calculation logic.

## **1.5.1 (2024/08/02)** {#1-5-1}

1. Fixed line protocol data escaping algorithm issues causing sync failures due to newline characters.
2. Standardized error messages for errors of type `network_error` to use English descriptions for HTTP status codes.
3. Optimized data sync logic and fixed crashes caused by accessing released `uploadDelayTimer` in multi-threaded environments.
4. Fixed crashes caused by incorrect encoding formats when converting OC and C strings during crash data collection.

## **1.5.0 (2024/06/03)** {#1-5-0}

1. Added remote IP address resolution for RUM resource network requests.
2. Added integer compatibility mode for line protocol data to handle web data type conflicts.
3. Added custom status methods for logging.
4. Optimized log writing and data sync.
5. Handled NSDictionary parameters passed to the SDK to prevent JSON conversion failures and data loss.

## **1.4.14 (2024/05/29)** {#1-4-14}

1. Fixed memory access errors caused by accessing destroyed Class objects in `FTSwizzler`.
2. Fixed data consistency and operation conflict issues when NSMutableDictionary-type parameters were passed as mutable objects.

## **1.4.13 (2024/05/15)** {#1-4-13}

1. Optimized RUM LongTask and ANR collection, fixing inaccurate stack trace collection and adding support for fatal freezes.
2. Fixed crashes caused by simultaneous multi-threaded operations on NSMutableSet in `FTSwizzler`.
3. Fixed missing version information in SDK Framework info.plist.
4. Fixed performance metric collection failures for Resources when custom NSURLSession did not set delegate.
5. Optimized internal log-to-file functionality, adding methods to specify file paths.

## **1.4.12 (2024/04/26)** {#1-4-12}

1. Fixed memory leaks caused by calling the shutDown method.
2. Fixed crashes caused by conflicts with other libraries during RUM-Resource collection.
3. Fixed uncaught exception handler passing issues.
4. Fixed data anomalies caused by multiple SDK initializations.

## **1.4.11 (2024/03/28)** {#1-4-11}

1. Added support for data sync parameter configuration, including request item data, sync interval time, and log cache entry count.
2. Added internal log-to-file methods.
3. Fixed errors in obtaining RUM data associated with logs.
4. Optimized time-consuming operations.
5. Fixed crashes caused by WebView jsBridge, changing WebView references to weak references.

[More Logs](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)