# Changelog

---
## **1.5.10 (2025/01/21)** {#1-5-10}

1. Support custom Trace interception of Requests via `FTTraceConfig.traceInterceptor`, and adding custom attributes to RUM Resources via `FTRumConfig.resourcePropertyProvider`

2. Fixed an issue with the global attribute addition method causing exceptions under multi-threaded access

3. Optimized data information passed into WebView

## **1.5.9 (2025/01/08)** {#1-5-9}

1. Added support for intercepting `URLRequest` through the `FTURLSessionDelegate.traceInterceptor` block, allowing customization of trace and modification of spanId and traceId within the trace
2. RUM Resource now supports capturing network requests initiated by Swift async/await URLSession API
3. Fixed errors in associating LongTask and ANR with Views

## **1.5.8 (2024/12/23)** {#1-5-8}

1. Added support for tvOS
2. Support limiting the maximum number of cached RUM entries via `FTRUMConfig.rumCacheLimitCount`, and setting discard policies via `FTRUMConfig.rumDiscardType`
3. Support limiting total cache size via `FTMobileConfig.enableLimitWithDbSize`. Once enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be disabled. Supports setting db discard policy via `FTMobileConfig.dbDiscardType` and db cache limit size via `FTMobileConfig.dbCacheLimit`

## **1.5.7 (2024/12/04)** {#1-5-7}

1. Support setting freeze detection threshold via `FTRUMConfig.freezeDurationMs`
2. Optimized the SDK's `shutDown` method to prevent main thread synchronous waiting which can cause freezes or WatchDog crashes

## **1.5.6 (2024/11/13)** {#1-5-6}

1. Support deflate compression configuration for synchronized data via `FTMobileConfig.compressIntakeRequests`
2. Added `addAction:actionType:property` and `startAction:actionType:property:` methods to RUM, optimizing RUM Action collection logic
3. Fixed crashes caused by using deprecated NSFileHandle APIs

## **1.5.5 (2024/11/06)** {#1-5-5}

1. Fixed crashes caused by array out-of-bounds issues in `FTResourceMetricsModel`

## **1.5.4 (2024/10/18)** {#1-5-4}

1. Added dynamic setting methods for global, log, and RUM globalContext properties
2. Added a method to clear all unsynchronized data from the server
3. Adjusted the maximum supported synchronization interval to 5000 milliseconds

## **1.5.3 (2024/10/09)** {#1-5-3}

1. Fixed memory access errors during LongTask and ANR collection due to incorrect attribute modifiers
2. Replaced method signature validation assertions in `FTSwizzler` with internal warning logs
3. Optimized decimal precision of collected data

## **1.5.2 (2024/08/21)** {#1-5-2}

1. Fixed the missing `#include <arm/_mcontext.h>` header file issue when compiling with Xcode 16
2. Automatically filter out directly locally cached or unknown type resources during RUM-Resource collection to prevent duplicates
3. Fixed UITabBarController subview loadingTime calculation logic

## **1.5.1 (2024/08/02)** {#1-5-1}

1. Fixed line protocol data escaping algorithm issues that caused data synchronization failures due to newline characters
2. Optimized error messages for `network_error` types, uniformly using English descriptions for network request error codes
3. Optimized data synchronization logic, fixing crashes caused by accessing released `uploadDelayTimer` in multi-threaded environments
4. Fixed crashes caused by encoding format errors when converting between OC and C strings during crash information collection

## **1.5.0 (2024/06/03)** {#1-5-0}

1. Added remote IP address resolution functionality for RUM resource network requests
2. Added integer data compatibility mode for line protocol to handle web data type conflicts
3. Added custom status method for logs
4. Optimized log data writing and data synchronization
5. Prevented data loss caused by JSON conversion failures for NSDictionary parameters passed to the SDK

## **1.4.14 (2024/05/29)** {#1-4-14}

1. Fixed memory access errors caused by accessing destroyed Class objects in `FTSwizzler`
2. Fixed potential data consistency and operation conflict issues when passing mutable objects as NSDictionary parameters to the SDK

## **1.4.13 (2024/05/15)** {#1-4-13}

1. Optimized RUM LongTask and ANR collection, fixed inaccurate stack information collection for LongTasks, and added support for collecting fatal freezes
2. Fixed crashes caused by simultaneous multi-threaded operations on NSMutableSet in `FTSwizzler`
3. Fixed missing version information in the SDK Framework info.plist
4. Fixed performance metric collection failure for Resources when a custom NSURLSession did not set a delegate
5. Optimized the internal logging to file feature, adding a method to specify file paths

## **1.4.12 (2024/04/26)** {#1-4-12}

1. Fixed memory leaks caused by calling the shutDown method in the SDK
2. Fixed crashes caused by conflicts with other libraries during RUM-Resource collection
3. Fixed the issue where UncaughtExceptionHandler was not passed during crash collection
4. Fixed data anomalies caused by multiple initializations of the SDK

## **1.4.11 (2024/03/28)** {#1-4-11}

1. Added support for configuring data synchronization parameters, including request entry data, synchronization intervals, and log cache entry counts
2. Added a method to convert internal logs to files
3. Fixed errors in obtaining RUM data associated with logs
4. Optimized time-consuming operations
5. Fixed crashes caused by WebView jsBridge, changing WebView references to weak references

[More Logs](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)