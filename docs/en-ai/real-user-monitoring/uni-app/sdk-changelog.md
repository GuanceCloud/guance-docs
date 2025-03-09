# Changelog
---

### **0.2.0 (2025/01/19)** {#0-2-0}
* Compatible with iOS [1.5.9](../ios/sdk-changelog.md#1-5-9)
* Android ft-sdk [1.6.7](../android/sdk-changelog.md#1-6-7), ft-native:1.1.1, ft-plugin-legacy 1.1.8
* Supports direct transmission to Open Dataway
* Supports hybrid development of uni-applets and native Apps
* `GCUniPlugin-MobileAgent`
    * Supports managing data synchronization timing independently via autoSync = false, flushSyncData(). Automatic synchronization is enabled by default.
    * Supports setting data synchronization page size and synchronization interval time via syncPageSize, syncSleepTime.
    * Supports configuring deflate compression for synchronized data via compressIntakeRequests.
    * Supports enabling data synchronization cache limits via enableLimitWithDbSize = true, dbCacheLimit, and supports using dbDiscardStrategy to set data discard policies when cache exceeds the limit. After setting this, rumCacheLimitCount and logCacheLimitCount settings will be ineffective.
* `GCUniPlugin-RUM` 
    * Supports enabling Native Crash monitoring via enableTrackNativeCrash.
    * Supports enabling Native ANR monitoring via enableTrackNativeAppANR.
    * Supports enabling Native Freeze monitoring via enableTrackNativeFreeze, and setting the detection threshold via nativeFreezeDurationMs.
    * Supports limiting the maximum number of RUM data cache entries via rumCacheLimitCount, rumDiscardStrategy, defaulting to 100,000.
* `GCUniPlugin-Logger`
    * Supports limiting the maximum number of RUM data cache entries via logCacheLimitCount, defaulting to 5,000.

[More logs](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/blob/develop/CHANGELOG.md)