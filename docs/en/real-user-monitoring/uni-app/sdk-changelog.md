# Change Log
---
### **0.2.1 (03/18/2025)** {#0-2-1}
* Android fixes the incorrect startup time rule when `offlinePackage` is set to `false`
* Android fixes the crash issue that occurs when enabling `compressIntakeRequests` in pure uniapp projects
* `GCUniPlugin-MobileAgent enableDataIntegerCompatible` is enabled by default
* Compatibility updates for iOS [1.5.10](../ios/sdk-changelog.md/#1-5-10), [1.5.11](../ios/sdk-changelog.md/#1-5-11), [1.5.12](../ios/sdk-changelog.md/#1-5-12), [1.5.13](../ios/sdk-changelog.md/#1-5-13), [1.5.14](../ios/sdk-changelog.md/#1-5-14), Android ft-sdk [1.6.8](../android/sdk-changelog.md#1-6-8), [1.6.9](../android/sdk-changelog.md#1-6-9)

---

### **0.2.0 (01/19/2025)** {#0-2-0}
* Compatibility update for iOS [1.5.9](../ios/sdk-changelog.md#1-5-9)
* Android ft-sdk [1.6.7](../android/sdk-changelog.md#1-6-7), ft-native:1.1.1, ft-plugin-legacy 1.1.8
* Support for direct transmission via Open Dataway
* Support for hybrid development of uni Mini Programs and native Apps
* `GCUniPlugin-MobileAgent`
    * Support for managing data synchronization timing autonomously through autoSync = false and flushSyncData(), with automatic synchronization as the default
    * Support for setting data synchronization page size and synchronization interval time via syncPageSize and syncSleepTime
    * Support for configuring deflate compression on synchronized data through compressIntakeRequests
    * Support for enabling data synchronization cache limits through enableLimitWithDbSize = true and dbCacheLimit,
      and support for setting data discard strategies when cache exceeds limits using dbDiscardStrategy. After setting this,
      rumCacheLimitCount and logCacheLimitCount settings will become ineffective
* `GCUniPlugin-RUM`
    * Support for enabling Native Crash monitoring through enableTrackNativeCrash
    * Support for enabling Native ANR monitoring through enableTrackNativeAppANR
    * Support for enabling Native Freeze monitoring through enableTrackNativeFreeze and setting the monitoring threshold range via nativeFreezeDurationMs
    * Support for limiting RUM data cache entries through rumCacheLimitCount and rumDiscardStrategy, with a default limit of 100,000
* `GCUniPlugin-Logger`
    * Support for limiting RUM data cache entries through logCacheLimitCount, with a default limit of 5000

[More Logs](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/blob/develop/CHANGELOG.md)