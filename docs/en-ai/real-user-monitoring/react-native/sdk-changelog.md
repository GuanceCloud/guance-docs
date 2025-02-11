# Changelog
## **0.3.10 (2025/01/21)**

* Modified the way iOS bridge code references native SDK header files.

* Added RUM entry count limit functionality, supporting limiting the maximum cache entry data via `FTRUMConfig.rumCacheLimitCount`, and supporting setting discard strategies for new or old data using `FTRUMConfig.rumDiscardStrategy`.

* Added support for limiting total cache size via `FTMobileConfig.enableLimitWithDbSize`. Once enabled, `FTLoggerConfig.logCacheLimitCount` and `FTRUMConfig.rumCacheLimitCount` will be invalidated. Supports setting db discard strategies via `FTMobileConfig.dbDiscardStrategy` and setting db cache limits via `FTMobileConfig.dbCacheLimit`.

* Adapted to iOS SDK [1.5.8](../ios/sdk-changelog.md/#1-5-8), [1.5.9](../ios/sdk-changelog.md/#1-5-9), [1.5.10](../ios/sdk-changelog.md/#1-5-10).
* Adapted to Android SDK ft-sdk [1.6.6](../android/sdk-changelog.md/#ft-sdk-1-6-6), [1.6.7](../android/sdk-changelog.md/#ft-sdk-1-6-7), [1.6.8](../android/sdk-changelog.md/#ft-sdk-1-6-8).

## **0.3.9 (2024/12/24)**

* To improve React Android compatibility, changed the language of part of the Android React Native Bridge from Kotlin to Java.
* Adapted to Android SDK ft-sdk [1.6.5](../android/sdk-changelog.md/#ft-sdk-1-6-5).

## **0.3.7 (2024/12/04)**

* Fixed issues with incorrect data type annotations in Android RN.
* Supported setting freeze detection threshold via `FTRUMConfig.nativeFreezeDurationMs`.
* Supported configuring `deflate` compression for synchronized data using `FTMobileConfig.compressIntakeRequests`.
* Adapted to iOS SDK [1.5.6](../ios/sdk-changelog.md/#1-5-6), [1.5.7](../ios/sdk-changelog.md/#1-5-7).
* Adapted to Android SDK ft-sdk [1.6.2](../android/sdk-changelog.md/#ft-sdk-1-6-2), [1.6.3](../android/sdk-changelog.md/#ft-sdk-1-6-3), [1.6.4](../android/sdk-changelog.md/#ft-sdk-1-6-4).

## **0.3.6 (2024/11/06)**

* Adapted to iOS SDK [1.5.5](../ios/sdk-changelog.md/#1-5-5).

## **0.3.5 (2024/10/23)**

* Supported collecting Native Error, ANR, Freeze.
* Changed the default error types collected automatically by react-native.
* For components with an `onPress` attribute, added support for defining whether to collect click events when `enableAutoTrackUserAction` is enabled via a custom attribute `ft-enable-track`, and adding extra Action properties via `ft-extra-property`.

## **0.3.4 (2024/10/19)**

* Supported dynamically adding globalContext attributes globally.
* Supported custom error types through `FTReactNativeRUM.addErrorWithType()`.
* Supported shutting down the SDK via `FTMobileReactNative.shutDown()`.
* Supported clearing unsent cached data via `FTMobileReactNative.clearAllData()`.
* Fixed the issue where parameters `stack` and `message` were assigned incorrectly when automatically collecting react-native errors.
* Adapted to Android SDK ft-sdk [1.6.1](../android/sdk-changelog.md/#ft-sdk-1-6-1).
* Adapted to iOS SDK [1.5.4](../ios/sdk-changelog.md/#1-5-4).

## **0.3.3 (2024/10/09)**

* Adapted to iOS SDK [1.5.3](../ios/sdk-changelog.md/#1-5-3).

## **0.3.2 (2024/08/28)**

* Fixed the issue where `FTMobileConfig.env` configuration was ineffective on Android.

## **0.3.1 (2024/08/21)**

* Compatibility fix for using `react/jsx-runtime` with React versions below 16.14.0.
* Android compatibility with react native 0.63 low version.
* Modified the regular expression to filter URLs pointing to localhost, expanding the matching scope.
* Adapted to iOS SDK [1.5.2](../ios/sdk-changelog.md/#1-5-2).

## **0.3.0 (2024/08/16)**

* Added support for configuring data synchronization parameters, including request entry data, synchronization interval time, and log cache entry count.
* Added remote IP address resolution functionality for RUM resource network requests.
* Added line protocol Integer data compatibility mode to handle web data type conflicts.
* Added custom status methods for logs.
* Modified action collection methods in react-native to adapt to the inability to intercept click events from `React.createElement` in React 17.
* Filtered out hot reload connections pointing to localhost for RUM resources in Debug scenarios.
* Fixed underlying Double adaptation issues on Android.

[More Logs](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)