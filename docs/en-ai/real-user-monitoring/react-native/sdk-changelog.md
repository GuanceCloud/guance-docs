# Changelog
## 0.3.11 (2025/02/05)

* Optimization of configuration for hybrid development SDK with native and React Native
    * Support for automatically collecting React Native control click events via the `FTRumActionTracking.startTracking()` method, and automatically collecting React Native error logs via the `FTRumErrorTracking.startTracking()` method
    * When enabling automatic collection of RUM Resources, new methods are added: `FTReactNativeUtils.filterBlackResource(url)` for iOS and `ReactNativeUtils.isReactNativeDevUrl(url)` for Android to filter out symbolic requests from React Native and Expo log requests in the development environment, reducing redundant data
* Adaptation to iOS SDK [1.5.11](../ios/sdk-changelog.md/#1-5-11)

## **0.3.10 (2025/01/21)**

* Modified the way native SDK header files are referenced in the iOS bridge code

* Added functionality to limit the number of RUM entries, supporting limitation of the maximum cache entry data via `FTRUMConfig.rumCacheLimitCount` and setting discard strategies for new or old data via `FTRUMConfig.rumDiscardStrategy`

* Added support for limiting total cache size via `FTMobileConfig.enableLimitWithDbSize`. Once enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be invalid. Discard strategies can be set via `FTMobileConfig.dbDiscardStrategy`, and cache size limits can be configured via `FTMobileConfig.dbCacheLimit`

* Adapted to iOS SDK versions [1.5.8](../ios/sdk-changelog.md/#1-5-8), [1.5.9](../ios/sdk-changelog.md/#1-5-9), and [1.5.10](../ios/sdk-changelog.md/#1-5-10)
* Adapted to Android SDK ft-sdk versions [1.6.6](../android/sdk-changelog.md/#ft-sdk-1-6-6), [1.6.7](../android/sdk-changelog.md/#ft-sdk-1-6-7), and [1.6.8](../android/sdk-changelog.md/#ft-sdk-1-6-8)

## **0.3.9 (2024/12/24)**

* To improve compatibility with React Android, changed part of the Android React Native Bridge from Kotlin to Java
* Adapted to Android SDK ft-sdk [1.6.5](../android/sdk-changelog.md/#ft-sdk-1-6-5)

## **0.3.7 (2024/12/04)**

* Fixed issues with incorrect data type annotations for Android RN errors
* Supported setting freeze detection thresholds via `FTRUMConfig.nativeFreezeDurationMs`
* Supported configuring `deflate` compression for synchronized data via `FTMobileConfig.compressIntakeRequests`
* Adapted to iOS SDK versions [1.5.6](../ios/sdk-changelog.md/#1-5-6) and [1.5.7](../ios/sdk-changelog.md/#1-5-7)
* Adapted to Android SDK ft-sdk versions [1.6.2](../android/sdk-changelog.md/#ft-sdk-1-6-2), [1.6.3](../android/sdk-changelog.md/#ft-sdk-1-6-3), and [1.6.4](../android/sdk-changelog.md/#ft-sdk-1-6-4)

## **0.3.6 (2024/11/06)**

* Adapted to iOS SDK [1.5.5](../ios/sdk-changelog.md/#1-5-5)

## **0.3.5 (2024/10/23)**

* Supported collecting Native Errors, ANR, and Freeze
* Modified the default error types for automatically collected React Native errors
* For components with an `onPress` attribute, added support for defining whether to collect click events via the custom attribute `ft-enable-track` when `enableAutoTrackUserAction` is enabled, and adding extra Action properties via `ft-extra-property`

## **0.3.4 (2024/10/19)**

* Supported dynamically adding globalContext properties globally
* Supported custom error types via `FTReactNativeRUM.addErrorWithType()`
* Supported shutting down the SDK via `FTMobileReactNative.shutDown()`
* Supported clearing unsent cached data via `FTMobileReactNative.clearAllData()`
* Fixed the issue where parameters `stack` and `message` were assigned incorrectly when automatically collecting React Native errors
* Adapted to Android SDK ft-sdk [1.6.1](../android/sdk-changelog.md/#ft-sdk-1-6-1)
* Adapted to iOS SDK [1.5.4](../ios/sdk-changelog.md/#1-5-4)

## **0.3.3 (2024/10/09)**

* Adapted to iOS SDK [1.5.3](../ios/sdk-changelog.md/#1-5-3)

## **0.3.2 (2024/08/28)**

* Fixed the issue where `FTMobileConfig.env` configuration was ineffective on Android

## **0.3.1 (2024/08/21)**

* Compatibility fix for using `react/jsx-runtime` with React versions below 16.14.0
* Android compatibility with React Native 0.63 low versions
* Modified the regular expression for filtering URLs pointing to localhost to increase matching scope
* Adapted to iOS SDK [1.5.2](../ios/sdk-changelog.md/#1-5-2)
## **0.3.0 (2024/08/16)**

* Added support for data synchronization parameter configuration, including request entry data, synchronization interval time, and log cache entry count
* Added remote IP address resolution functionality for RUM resource network requests
* Added integer data compatibility mode for line protocol to handle web data type conflicts
* Added custom status methods for logs
* Modified action collection methods for React Native to address the issue of intercepting click events from `React.createElement` in React 17
* In Debug scenarios, filtered out hot update connections pointing to localhost (localhost) for RUM Resource collection
* Fixed underlying Double adaptation issues on Android

[More Logs](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)