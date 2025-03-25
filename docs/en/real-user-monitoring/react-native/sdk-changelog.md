# Change Log
## **0.3.13 (2025/03/21)**
* Adjusted Android Java 8 compatibility, removed kotlin library dependencies

## **0.3.12 (2025/03/07)**
* Added RUM `Resource` data fields `resource_first_byte_time`, `resource_dns_time`, `resource_download_time`, `resource_connect_time`, `resource_ssl_time`, `resource_redirect_time`, supporting enhanced Resource timing display on Guance and aligning time axes in APM flame graphs
* `FTMobileConfig.enableDataIntegerCompatible` is now enabled by default
* Adapted to Android ft-sdk [1.6.9](../android/sdk-changelog.md/#ft-sdk-1-6-9), iOS [1.5.12](../ios/sdk-changelog.md/#1-5-12), [1.5.13](../ios/sdk-changelog.md/#1-5-13), [1.5.14](../ios/sdk-changelog.md/#1-5-14)

## **0.3.11 (2025/02/05)**

* Optimization of SDK configuration for native and React Native hybrid development
    * Support for automatically collecting React Native control click events via the `FTRumActionTracking.startTracking()` method and React Native error logs via the `FTRumErrorTracking.startTracking()` method
    * When enabling automatic collection of RUM Resources, added methods `FTReactNativeUtils.filterBlackResource(url)` for iOS and `ReactNativeUtils.isReactNativeDevUrl(url)` for Android to filter React Native symbolized requests and Expo log requests during development, reducing redundant data
* Adapted to iOS SDK [1.5.11](../ios/sdk-changelog.md/#1-5-11)

## **0.3.10 (2025/01/21)**

* Modified the way native SDK header files are referenced in iOS bridge code

* Added functionality to limit the number of RUM entries, allowing limits on the maximum cached data entries through `FTRUMConfig.rumCacheLimitCount` and specifying whether to discard new or old data through `FTRUMConfig.rumDiscardStrategy`

* Added support for limiting total cache size via `FTMobileConfig.enableLimitWithDbSize`. After enabling this, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be invalidated. Supports setting db discard strategies via `FTMobileConfig.dbDiscardStrategy` and db cache limit sizes via `FTMobileConfig.dbCacheLimit`

* Adapted to iOS SDK [1.5.8](../ios/sdk-changelog.md/#1-5-8), [1.5.9](../ios/sdk-changelog.md/#1-5-9), [1.5.10](../ios/sdk-changelog.md/#1-5-10)
* Android SDK ft-sdk [1.6.6](../android/sdk-changelog.md/#ft-sdk-1-6-6), [1.6.7](../android/sdk-changelog.md/#ft-sdk-1-6-7), [1.6.8](../android/sdk-changelog.md/#ft-sdk-1-6-8)

## **0.3.9 (2024/12/24)**

* To improve React Android compatibility, changed part of the Android React Native Bridge from Kotlin to Java
* Adapted to Android SDK ft-sdk [1.6.5](../android/sdk-changelog.md/#ft-sdk-1-6-5)

## **0.3.7 (2024/12/04)**

* Fixed the issue of incorrect data type annotations for Android RN errors
* Supported setting the freeze detection threshold via `FTRUMConfig.nativeFreezeDurationMs`
* Supported configuring `deflate` compression for synchronized data using `FTMobileConfig.compressIntakeRequests`
* Adapted to iOS SDK [1.5.6](../ios/sdk-changelog.md/#1-5-6), [1.5.7](../ios/sdk-changelog.md/#1-5-7)
* Adapted to Android SDK ft-sdk [1.6.2](../android/sdk-changelog.md/#ft-sdk-1-6-2), [1.6.3](../android/sdk-changelog.md/#ft-sdk-1-6-3), [1.6.4](../android/sdk-changelog.md/#ft-sdk-1-6-4)

## **0.3.6 (2024/11/06)**

* Adapted to iOS SDK [1.5.5](../ios/sdk-changelog.md/#1-5-5)

## **0.3.5 (2024/10/23)**

* Supported collecting Native Errors, ANRs, and Freezes
* Changed the default error type for automatically collected react-native errors
* For components with an `onPress` attribute, added support to define whether to collect click events via the custom property `ft-enable-track` after enabling `enableAutoTrackUserAction`, and to add extra Action properties via `ft-extra-property`

## **0.3.4 (2024/10/19)**

* Supported globally dynamically adding globalContext attributes
* Supported custom error types via `FTReactNativeRUM.addErrorWithType()`
* Supported shutting down the SDK via `FTMobileReactNative.shutDown()`
* Supported clearing unsent cached data via `FTMobileReactNative.clearAllData()`
* Fixed the issue where parameters `stack` and `message` were assigned incorrectly when automatically collecting react-native Errors
* Adapted to Android SDK ft-sdk [1.6.1](../android/sdk-changelog.md/#ft-sdk-1-6-1)
* Adapted to iOS SDK [1.5.4](../ios/sdk-changelog.md/#1-5-4)

## **0.3.3 (2024/10/09)**

* Adapted to iOS SDK [1.5.3](../ios/sdk-changelog.md/#1-5-3)

## **0.3.2 (2024/08/28)**

* Fixed the issue where Android configuration `FTMobileConfig.env` was ineffective

## **0.3.1 (2024/08/21)**

* Compatibility fix for React versions below 16.14.0 when using `react/jsx-runtime`
* Android compatible with react native 0.63 lower version
* Modified the regular expression filtering URLs pointing to localhost, increasing the matching scope
* Adapted to iOS SDK [1.5.2](../ios/sdk-changelog.md/#1-5-2)
## **0.3.0 (2024/08/16)**

* Added support for data synchronization parameter configurations, request entry data, intermittent synchronization times, and log cache entry counts
* Added remote IP address resolution functionality for RUM resource network requests
* Added line protocol Integer data compatibility mode to handle web data type conflicts
* Added custom status methods for logs
* Modified the react-native action collection method to adapt to the inability to intercept click events from React.createElement in React 17
* In Debug scenarios, filtered out hot-reload connections pointing to localhost for RUM Resource collection
* Corrected Android underlying Double adaptation issues

[More Logs](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)