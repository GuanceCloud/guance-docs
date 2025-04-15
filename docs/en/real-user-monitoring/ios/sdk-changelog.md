# Release Notes

---
## **1.5.15 (2025/04/14)** {#1-5-15}

1. Fix the issue of Swift Package Manager build errors

## **1.5.14 (2025/03/07)** {#1-5-14}

1. Add new RUM `Resource` data fields: `resource_first_byte_time`, `resource_dns_time`, `resource_download_time`, `resource_connect_time`, `resource_ssl_time`, `resource_redirect_time`. These support enhanced display of Resource timing in Guance and alignment with APM flame graphs.

2. Enable `FTMobileConfig.enableDataIntegerCompatible` by default.

3. Add support for disabling SDK URLSession Method Swizzling via macro definition `FT_DISABLE_SWIZZLING_RESOURCE`.

4. Optimize data synchronization and add retry logic for failed transmissions.

## **1.5.13** (2025/02/27) {#1-5-13}

1. Optimize page collection logic to prevent missing RUM View collections caused by special views.

## **1.5.12** (2025/02/10) {#1-5-12}

1. Adjust file storage path configuration to fix database creation failure issues in tvOS environments.
2. Update default `service` and log `source` in tvOS environment to `df_rum_tvos` and `df_rum_tvos_log`.
3. Fix inaccurate calculation of `duration` in RUM Action events.

## **1.5.11 (2025/02/05)** {#1-5-11}

1. Optimize RUM Resource collection to prevent collecting internal SDK requests when automatic collection is enabled.
2. Fix the issue of skyWalking type link tracing failing in Widget Extensions.

## **1.5.10 (2025/01/21)** {#1-5-10}

1. Support intercepting custom Traces via `FTTraceConfig.traceInterceptor` and adding custom attributes to RUM Resources via `FTRumConfig.resourcePropertyProvider`.
2. Fix exceptions in dynamic addition of global attributes under multi-threaded access.
3. Optimize WebView data transmission.

## **1.5.9 (2025/01/08)** {#1-5-9}

1. Add support for intercepting `URLRequest` through the `FTURLSessionDelegate.traceInterceptor` block to perform custom link tracing and modify spanId and traceId within links.
2. RUM Resources can now collect network requests initiated using the swift async/await URLSession API.
3. Fix the error of associating LongTask and Anr with Views.

## **1.5.8 (2024/12/23)** {#1-5-8}

1. Add support for tvOS.
2. Support limiting the maximum number of cached entries in RUM via `FTRUMConfig.rumCacheLimitCount` and setting discard strategies via `FTRUMConfig.rumDiscardType`.
3. Support restricting total cache size via `FTMobileConfig.enableLimitWithDbSize`. After enabling, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be invalidated. Support setting db discard strategies via `FTMobileConfig.dbDiscardType` and db cache limits via `FTMobileConfig.dbCacheLimit`.

## **1.5.7 (2024/12/04)** {#1-5-7}

1. Support setting freeze detection thresholds via `FTRUMConfig.freezeDurationMs`.
2. Optimize the `shutDown` method of the SDK to avoid blocking or WatchDog crashes on the main thread.

## **1.5.6 (2024/11/13)** {#1-5-6}

1. Support configuring deflate compression for synchronized data via `FTMobileConfig.compressIntakeRequests`.
2. Add `addAction:actionType:property` and `startAction:actionType:property:` methods to RUM, optimizing the RUM Action collection logic.
3. Fix crash issues caused by deprecated NSFileHandle APIs.

## **1.5.5 (2024/11/06)** {#1-5-5}

1. Fix crash issues caused by out-of-bounds arrays in `FTResourceMetricsModel`.

## **1.5.4 (2024/10/18)** {#1-5-4}

1. Add dynamic setting methods for global, log, and RUM globalContext properties.
2. Add a data clearing method to delete all unsynchronized data.
3. Extend the maximum interval for synchronization pauses to 5000 milliseconds.

## **1.5.3 (2024/10/09)** {#1-5-3}

1. Fix memory access crashes during LongTask and Anr collection caused by incorrect attribute modifiers.
2. Replace method signature validation assertions in `FTSwizzler` with internal warning logs.
3. Optimize decimal precision in collected data.

## **1.5.2 (2024/08/21)** {#1-5-2}

1. Fix the issue of missing `#include <arm/_mcontext.h>` header files when compiling with Xcode 16.
2. Automatically filter out local cache resources or resources of unknown types during RUM-Resource collection to prevent duplication.
3. Fix the loadingTime calculation logic for UITabBarController child views.

## **1.5.1 (2024/08/02)** {#1-5-1}

1. Fix line protocol data escape algorithm issues that cause synchronization failures due to newline characters.
2. Standardize network request error codes with English descriptions for errors of type `network_error`.
3. Optimize data synchronization logic and fix crashes caused by accessing released `uploadDelayTimer` objects in multi-threaded environments.
4. Fix crashes caused by encoding format errors when converting OC and C strings during crash data collection.

## **1.5.0 (2024/06/03)** {#1-5-0}

1. Add remote IP address resolution functionality for RUM resource network requests.
2. Add compatibility mode for Integer data in line protocols to handle web data type conflicts.
3. Add custom status methods for logs.
4. Optimize log data writing and data synchronization.
5. Process NSDictionary parameters passed into the SDK to prevent JSON conversion failures and data loss.

## **1.4.14 (2024/05/29)** {#1-4-14}

1. Fix memory access crashes caused by accessing destroyed Class objects in `FTSwizzler`.
2. Resolve data consistency and operation conflict issues when passing mutable NSDictionary objects to the SDK.

## **1.4.13 (2024/05/15)** {#1-4-13}

1. Optimize RUM LongTask and Anr collection, fix inaccurate stack information collection for LongTasks, and add support for collecting fatal freezes.
2. Fix crashes caused by simultaneous multi-threaded operations on NSMutableSet in `FTSwizzler`.
3. Fix missing version information in the info.plist of the SDK Framework package.
4. Fix performance metric collection failures for Resources when custom NSURLSessions are used without delegates.
5. Optimize the internal log-to-file feature of the SDK and add methods for specifying file paths.

## **1.4.12 (2024/04/26)** {#1-4-12}

1. Fix memory leak issues caused by calling the shutDown method in the SDK.
2. Fix crashes caused by conflicts with other libraries during RUM-Resource collection.
3. Fix the issue of UncaughtExceptionHandler not being passed during crash collection.
4. Fix data anomalies caused by multiple initializations of the SDK.

## **1.4.11 (2024/03/28)** {#1-4-11}

1. Add support for data synchronization parameter configurations including request entry data, synchronization pause intervals, and log cache entry counts.
2. Add internal log-to-file methods.
3. Fix errors in obtaining RUM-related log data.
4. Optimize time-consuming operations.
5. Fix crashes caused by WebView jsBridge; change WebView references to weak references.

[More Logs](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)