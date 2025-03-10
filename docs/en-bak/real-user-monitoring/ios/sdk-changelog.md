# Change Log 

---

## **1.5.8 (2024/12/23)** {#1-5-8} 

1. Add tvOS Support. 
2. Add `FTRUMConfig.rumCacheLimitCount` configuration to limit the RUM maximum number of cached items, and
   add `FTRUMConfig.rumDiscardType` configuration to set a discard policy 
3.  Add `FTMobileConfig.enableLimitWithDbSize` configuration to limit the total cache size. Once enabled, 
   `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount`  will become invalid. 
   Support setting db discard policy through `FTMobileConfig.dbDiscardType` and 
   setting db cache limit size through `FTMobileConfig.dbCacheLimit` 

## **1.5.7 (2024/12/04)** {#1-5-7}

1. Support setting the freeze detection threshold through `FTRUMConfig.freezeDurationMs`
2. Optimize SDK `shutDown` method to avoid freezing or WatchDog crash caused by main thread synchronous waiting 

## **1.5.6 (2024/11/13)** {#1-5-6}

1. Support the use of `FTMobileConfig.compressIntakeRequests` to configure deflate compression of synchronized data
2. RUM adds `addAction:actionType:property` and `startAction:actionType:property:` methods to 
   optimize RUM Action collection logic
3. Fix the crash caused by using NSFileHandle deprecated API 

## **1.5.5 (2024/11/06)** {#1-5-5}

1. Fix the crash caused by array out of bounds in `FTResourceMetricsModel` 

## **1.5.4 (2024/10/18)** {#1-5-4} 

1. Add global, log, RUM globalContext property dynamic setting method
2. Added a clear data method to support deleting all data that has not been uploaded to the server. 
3. Adjusted the maximum time interval supported by synchronization intervals to 5000 milliseconds 

## **1.5.3 (2024/10/09)** {#1-5-3} 

1. Fixed the memory access error crash caused by incorrect use of attribute modifiers when collecting LongTask and Anr 
2. Use internal warning logs to replace the method signature verification assertion in `FTSwizzler` 
3. Optimize the decimal precision of collected data 

## **1.5.2 (2024/08/21)** {#1-5-2} 

1. Fixed the problem of missing `#include <arm/_mcontext.h>` header file in Xcode 16 compilation 
2. When automatically collecting RUM-Resource, filter out Resources directly obtained from the local cache or obtained with unknown types to prevent duplicate collection 
3. Fix the UITabBarController subview loadingTime calculation logic 

## **1.5.1 (2024/08/02)** {#1-5-1} 

1. Fix the line protocol data escape algorithm to solve the problem of data synchronization failure caused by line breaks. 
2. Optimize the error message of the error type `network_error`, and use English to describe the network request error code. 
3. Optimize the data synchronization logic and fix the crash caused by multi-threaded access to the released `uploadDelayTimer`. 
4. Fix the crash caused by the encoding format error when converting OC and C strings when collecting crash information. 

## **1.5.0 (2024/06/03)** {#1-5-0} 

1. Add remote IP address resolution function to RUM resource network request. 
2. Add line protocol Integer data compatibility mode to handle web data type conflict. 
3. Add custom status method to log. 
4. Optimize log data writing and data synchronization 
5. Format the NSDictionary type parameters passed to the SDK to prevent data loss caused by json conversion failure 

## **1.4.14 (2024/05/29)** {#1-4-14} 

1. Fixed a memory access error crash caused by accessing a destroyed Class object in `FTSwizzler`
2. Fixed data consistency and operation conflict issues that may occur when the NSDictionary type parameter passed to the SDK is actually a mutable object 

## **1.4.13 (2024/05/15)** {#1-4-13} 

1. Optimized RUM LongTask and Anr collection, fixed the inaccurate collection of LongTask stack information, and added support for fatal collection freezes
2. Fixed a crash in `FTSwizzler` caused by multi-threaded simultaneous operation of NSMutableSet
3. Fixed the missing version information issue in the packaged SDK Framework info.plist
4. Fixed the failure to collect Resource performance indicators when the custom NSURLSession does not set the delegate
5. Optimized the SDK internal log conversion to file function, and added a method to specify the file path 

## **1.4.12 (2024/04/26)** {#1-4-12}

1. Fixed the memory leak problem caused by SDK calling the shutdown method 
2. Fixed the crash caused by conflicts with other libraries when collecting RUM-Resource
3. Fixed the problem of UncaughtExceptionHandler not being passed in the crash collection
4. Fixed the data exception caused by multiple SDK initialization 

## **1.4.11(2024/03/28)** {#1-4-11} 

1. Added support for data synchronization parameter configuration, request entry data, synchronization interval time, and number of log cache entries
2. Added internal log file conversion method
3. Fixed the error of log-associated RUM data acquisition
4. Optimized time-consuming operations
5. Fixed the crash caused by WebView jsBridge, and changed the reference to WebView to weak reference 

[More logs](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)
