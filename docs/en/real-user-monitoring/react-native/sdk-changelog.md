# Changelog
## **0.3.12 (2025/03/07)**
* Added RUM `Resource` data fields `resource_first_byte_time`, `resource_dns_time`, `resource_download_time`, `resource_connect_time`, `resource_ssl_time`, `resource_redirect_time`, enabling enhanced display of Resource timing on Guance and aligning with the time axis in APM flame graphs.
* `FTMobileConfig.enableDataIntegerCompatible` is now enabled by default.
* Adapted to Android ft-sdk [1.6.9](../android/sdk-changelog.md/#ft-sdk-1-6-9), iOS [1.5.12](../ios/sdk-changelog.md/#1-5-12), [1.5.13](../ios/sdk-changelog.md/#1-5-13), [1.5.14](../ios/sdk-changelog.md/#1-5-14)

## **0.3.11 (2025/02/05)**

* Optimization of configuration for native and React Native hybrid development SDKs:
    * Supports automatic collection of React Native component click events via the `FTRumActionTracking.startTracking()` method, and automatic collection of React Native error logs via the `FTRumErrorTracking.startTracking()` method.
    * When enabling automatic RUM Resource collection, added methods `FTReactNativeUtils.filterBlackResource(url)` for iOS and `ReactNativeUtils.isReactNativeDevUrl(url)` for Android to filter out symbolic requests and Expo log requests from the development environment, reducing redundant data.
* Adapted to iOS SDK [1.5.11](../ios/sdk-changelog.md/#1-5-11)

## **0.3.10 (2025/01/21)**

* Modified the way native SDK header files are referenced in iOS bridge code.

* Added a feature to limit the number of RUM entries, supporting limitation of SDK cache entry data via `FTRUMConfig.rumCacheLimitCount`. Users can specify whether to discard new or old data using `FTRUMConfig.rumDiscardStrategy`.

* Added support to limit total cache size via `FTMobileConfig.enableLimitWithDbSize`. Once enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be disabled. Users can set db discard strategy via `FTMobileConfig.dbDiscardStrategy` and db cache limit size via `FTMobileConfig.dbCacheLimit`.

* Adapted to iOS SDK [1.5.8](../ios/sdk-changelog.md/#1-5-8), [1.5.9](../ios/sdk-changelog.md/#1-5-9), [1.5.10](../ios/sdk-changelog.md/#1-5-10)
* Adapted to Android SDK ft-sdk [1.6.6](../android/sdk-changelog.md/#ft-sdk-1-6-6), [1.6.7](../android/sdk-changelog.md/#ft-sdk-1-6-7), [1.6.8](../android/sdk-changelog.md/#ft-sdk-1-6-8)

## **0.3.9 (2024/12/24)**

* Improved React Android compatibility by changing parts of the Android React Native Bridge from Kotlin to Java.
* Adapted to Android SDK ft-sdk [1.6.5](../android/sdk-changelog.md/#ft-sdk-1-6-5)

## **0.3.7 (2024/12/04)**

* Fixed issues with incorrect data type annotations in Android RN errors.
* Supported setting freeze detection threshold via `FTRUMConfig.nativeFreezeDurationMs`.
* Supported configuring `deflate` compression for synchronized data using `FTMobileConfig.compressIntakeRequests`.
* Adapted to iOS SDK [1.5.6](../ios/sdk-changelog.md/#1-5-6), [1.5.7](../ios/sdk-changelog.md/#1-5-7)
* Adapted to Android SDK ft-sdk [1.6.2](../android/sdk-changelog.md/#ft-sdk-1-6-2), [1.6.3](../android/sdk-changelog.md/#ft-sdk-1-6-3), [1.6.4](../android/sdk-changelog.md/#ft-sdk-1-6-4)

## **0.3.6 (2024/11/06)**

* Adapted to iOS SDK [1.5.5](../ios/sdk-changelog.md/#1-5-5)

## **0.3.5 (2024/10/23)**

* Supported collecting Native Error, ANR, Freeze.
* Changed the default error type for automatically collected React Native errors.
* For components with an `onPress` attribute, added support to define whether to collect click events through the custom attribute `ft-enable-track` when `enableAutoTrackUserAction` is enabled, and to add extra Action properties via `ft-extra-property`.

## **0.3.4 (2024/10/19)**

* Supported globally dynamically adding globalContext attributes.
* Supported custom error types via `FTReactNativeRUM.addErrorWithType()`.
* Supported shutting down the SDK via `FTMobileReactNative.shutDown()`.
* Supported clearing unsent cached data via `FTMobileReactNative.clearAllData()`.
* Fixed the issue where parameters `stack` and `message` were assigned incorrectly during automatic collection of React Native errors.
* Adapted to Android SDK ft-sdk [1.6.1](../android/sdk-changelog.md/#ft-sdk-1-6-1)
* Adapted to iOS SDK [1.5.4](../ios/sdk-changelog.md/#1-5-4)

## **0.3.3 (2024/10/09)**

* Adapted to iOS SDK [1.5.3](../ios/sdk-changelog.md/#1-5-3)

## **0.3.2 (2024/08/28)**

* Fixed the issue where configuring `FTMobileConfig.env` was ineffective on Android.

## **0.3.1 (2024/08/21)**

* Compatibility fix for React versions below 16.14.0 using `react/jsx-runtime`.
* Android compatibility with React Native 0.63 low versions.
* Modified the regular expression to filter URLs pointing to localhost, expanding the matching scope.
* Adapted to iOS SDK [1.5.2](../ios/sdk-changelog.md/#1-5-2)

## **0.3.0 (2024/08/16)**

* Added support for configuring data synchronization parameters, including request entry data, intermittent synchronization time, and log cache entry count.
* Added remote IP address resolution functionality for RUM resource network requests.
* Added Integer data compatibility mode for line protocol to handle web data type conflicts.
* Added a custom status method for logs.
* Modified the React Native action collection method to adapt to React 17's inability to intercept click events from `React.createElement`.
* In Debug mode, filtered out hot reload connections pointing to localhost for RUM Resource collection.
* Fixed underlying Double compatibility issues on Android.

[More Logs](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)