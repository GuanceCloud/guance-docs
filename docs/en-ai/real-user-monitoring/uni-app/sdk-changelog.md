# Changelog
---

### **0.2.0 (2025/01/19)** {#0-2-0}
* Compatible with iOS [1.5.9](../ios/sdk-changelog.md#1-5-9)
* Android ft-sdk [1.6.7](../android/sdk-changelog.md#1-6-7), ft-native:1.1.1, ft-plugin-legacy 1.1.8
* Support direct transmission to Open Dataway
* Support hybrid development of uni-applets and native Apps
* `GCUniPlugin-MobileAgent`
    * Support for managing data synchronization timing independently via autoSync = false, flushSyncData(), default is automatic synchronization
    * Support setting data synchronization page size and synchronization interval time via syncPageSize, syncSleepTime
    * Support configuring deflate compression for synchronized data via compressIntakeRequests
    * Support enabling data synchronization cache limits via enableLimitWithDbSize = true, dbCacheLimit, and support using dbDiscardStrategy to set data discard policies when cache exceeds limits. After setting this, rumCacheLimitCount and logCacheLimitCount settings will be ineffective
* `GCUniPlugin-RUM` 
    * Support Native Crash monitoring via enableTrackNativeCrash
    * Support Native ANR monitoring via enableTrackNativeAppANR
    * Support Native Freeze monitoring via enableTrackNativeFreeze, and set the monitoring threshold via nativeFreezeDurationMs
    * Support limiting the maximum number of RUM data cache entries via rumCacheLimitCount, rumDiscardStrategy, default is 100,000
* `GCUniPlugin-Logger`
    * Support limiting the maximum number of RUM data cache entries via logCacheLimitCount, default is 5,000

[More logs](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/blob/develop/CHANGELOG.md)