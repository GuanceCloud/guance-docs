# Troubleshooting

## Compilation Troubleshooting

Compilation errors occur, and the first step is to check the compilation environment.

### Runnable Compilation Environment 
#### ✅ Runnable Environment {#runnable}

* AGP `com.android.tools.build:gradle` version `3.5.0` or higher
* Gradle version `5.4.0` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

**Note**: As Android Studio versions are updated, the compatibility of these versions may change. If you encounter compilation errors even though your environment meets the above conditions, please contact our developers.

#### ⚠️ Compatible Running Environment {#compatible}
* AGP `com.android.tools.build:gradle` version `3.0.1` or higher
* Gradle version `4.8.1` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

> This environment does not support `ft-plugin`, and data auto-capture needs to be manually integrated. For more information on manual integration, refer to [here](app-access.md#manual-set).

### SDK Unable to Resolve Imports
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
The above errors occur because the Maven repository is not correctly configured. Please refer to the [configuration](app-access.md#gradle-setting) here.


### Compilation Errors

#### Desugaring Error

```java
>Task :app:transformClassesWithStackFramesFixerForDebug
	Exception in thread "main" java.lang.IllegalStateException: Expected a load for Ljava/lang/String; to set up parameter 0 for com/ft/sdk/FTRUMGlobalManager$$Lambda$11 but got 95
		at com.google.common.base.Preconditions.checkState (Preconditions.java:756)
		at com.google.devtools.build. android.desugar.LambdaDesugaring$InvokedynamicRewriter .attemptAllocationBeforeArgumentLoadsLambdaDesugaring.java:535)
		at com.google.devtools.build.android.desugar.LambdaDesugaring$InvokedynamicRewriter.visitInvokeDynamicInsn
		(LambdaDesugaring.java: 420)
		at org.objectweb.asm.ClassReader.a(Unknown Source)
		at org.objectweb.asm.ClassReader.b(Unknown Source)
		at org.objectweb.asm.ClassReader.accept(Unknown Source)
		at org.objectweb.asm.ClassReader.accept(Unknown Source)
		at com.google.devtools.build. android.desugar. Desugar.desugarClassesInInput (Desugar.java:401) at com.google.devtools.build.android.desugar.Desugar.desugar0neInput(Desugar.java:326) at com.google.devtools.build.android.desugar. Desugar.desugar (Desugar.java:280) at com.google.devtools.build.android.desugar. Desugar.main (Desugar.java:584)
```
If the above error occurs during compilation, it is due to an AGP `3.0.0` compatibility issue. The [issue](https://github.com/gradle/gradle/issues/2384) explains this problem. You can resolve it by upgrading AGP to version `3.1.0` or higher, or using a newer version of the SDK. Upgrade the version in `app/build.gradle`.

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')//1.3.10 or higher
}

```

#### API 'android.registerTransform' is Obsolete {#transform_deprecated}

`Transform` has been marked as `Deprecated` in `AGP 7.0` and removed in `AGP 8.0`. `ft-plugin:1.2.0` has completed adaptation, please upgrade the corresponding version to fix this error. For specific instructions, see [integration configuration](app-access.md#gradle-setting)

#### AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

`AndroidComponentsExtension` is a method supported by AGP `7.4.2`. Environments below this version will generate this error. You can use the `ft-plugin-legacy` version to fix this error. For detailed instructions, see [integration configuration](app-access.md#gradle-setting)

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException:  {#android_illegal_argument_exception}

* Invalid opcode 169

If this error occurs while using `ft_plugin_legacy`, it is due to a bug in `asm-commons:7.0`. The original issue is [here](https://gitlab.ow2.org/asm/asm/-/issues/317873). This can be resolved by depending on `org.ow2.asm:asm-commons:7.2` or higher in the plugin configuration. Use `./gradlew buildEnvironment` to confirm the actual `asm-commons` version being used.

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
        // Add dependency
        classpath 'org.ow2.asm:asm-commons:7.2' 
    }
}
```

* org.ow2.asm:asm version lower than 7.0

Currently, the plugin only supports build environments using `org.ow2.asm:asm7.x` or higher. Use `./gradlew buildEnvironment` to query the build environment and confirm this issue. This can be fixed by forcing a dependency on version 7.x or higher. It is recommended to use version 7.2 or higher.

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
         // Add dependency
        classpath 'org.ow2.asm:asm:7.2'
        classpath 'org.ow2.asm:asm-commons:7.2'
    }
}
```

## SDK Initialization Exception Verification

Check `Logcat` to confirm if there are any logs with `Level` as `Error` and `Tag` prefixed with `[FT-SDK]`

```kotlin
[FT-SDK] com.demo E Please install the SDK first (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
``` 

## Enable Debug Mode {#debug_mode}
### ft-sdk Debug Mode
You can enable the debug functionality of the SDK through the following configuration. Once enabled, the console `LogCat` will output SDK debug logs, which you can filter by `[FT-SDK]` to locate <<< custom_key.brand_name >>> SDK logs.

```kotlin
  val config = FTSDKConfig.builder(datakitUrl).setDebug(true)
  FTSdk.install(config)
```

#### Log Example {#log_sample}
##### Data Synchronization {#data_sync}
```java
// Check if the upload URL is correctly configured in the SDK
[FT-SDK]FTHttpConfigManager com.demo D  serverUrl ==>
									Datakit Url:http://10.0.0.1:9529
// Below are connection error logs
[FT-SDK]SyncTaskManager com.demo   E  Network not available Stop poll
[FT-SDK]SyncTaskManager com.demo   E  ↵
			1:Sync Fail-[code:10003,response:failed to connect to 10.0.0.1 (port 9529) from ↵
			10.0.2.16 (port 47968) after 10000ms, check if the local network connection is normal]

// Below are successful synchronization logs
[FT-SDK]SyncTaskManager com.demo   D  Sync Success-[code:200,response:]

```

> **It is recommended to disable this configuration for Release versions**

### ft-plugin Debug Mode
You can enable Plugin debug logs through the following configuration. Once enabled, you can find `[FT-Plugin]` logs in the `Build` output logs. This can help you view the Plugin ASM writing situation.

```groovy
FTExt {
    // Whether to display Plugin logs, default is false
    showLog = true
}
```
> **It is recommended to disable this configuration for Release versions**

## SDK Internal Logs Converted to Cache Files
```kotlin
// >= 1.4.6
// Default path: /data/data/{package_name}/files/LogInner.log
LogUtils.registerInnerLogCacheToFile()

// >= 1.4.5+ 
val cacheFile = File(filesDir, "LogCache.log")
LogUtils.registerInnerLogCacheToFile(cacheFile)
```
> **To ensure the integrity of internal logs, this configuration should be set before initializing the SDK**

## SDK Runs Normally But No Data
* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running properly

* Confirm that the SDK upload address `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting) and initialized correctly. In [debug mode](#debug-mode), check the [logs](#data_sync) to diagnose upload issues.
	
* Verify whether datakit is uploading data to the corresponding workspace and whether it is offline. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking the "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## Data Loss
### Partial Data Loss
* If data from a particular RUM session or Log, Trace data is missing, first check if `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config).
* Investigate network and load issues between the device uploading data and the device running datakit.
* Ensure `FTSdk.shutDown` is called correctly, as this method releases SDK data processing objects, including cached data.

### Resource Data Loss {#resource_missing}
#### Automatic Collection Not Properly Integrated with ft-plugin
Resource automatic collection requires Plugin ASM bytecode injection to automatically configure OkHttpClient `Interceptor` and `EventListener`, injecting `FTTraceInterceptor`, `FTResourceInterceptor`, `FTResourceEventListener.FTFactory`. If not using Plugin, refer to [here](app-access.md#manual-set)

#### OkHttpClient.build() Called Before SDK Initialization
Plugin ASM injects automatically when `OkHttpClient.build()` is called. If called before SDK initialization, it will load empty configurations, leading to loss of Resource-related data. This scenario can be self-inspected using debug mode logs.

```java
// SDK initialization log
[FT-SDK]FTSdk       com.ft  D  initFTConfig complete
[FT-SDK]FTSdk       com.ft  D  initLogWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initRUMWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initTraceWithConfig complete

// SDK OkHttpClient.Builder.build() call log
// (must be called after SDK initialization)
[FT-SDK]AutoTrack  	com.ft  D  trackOkHttpBuilder    
```

>If unable to adjust the initialization order, choose [manual integration](app-access.md#manual-set)

#### Data Processed Twice Using Interceptor or EventListener 
After Plugin ASM inserts, it adds `addInterceptor` in `OkHttpClient.Builder()` to add `FTTraceInterceptor` and `FTResourceInterceptor`, where the body contentLength of HTTP requests participates in unique id calculation. `Resource` data across different stages is linked via this id. If integrating parties also add `addInterceptor` and process data, changing its size, it results in inconsistent id calculations, causing data loss.

**Resolution:**

* **ft-sdk < 1.4.1**

	By adjusting the [custom](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72) `addInterceptor` order to let the SDK calculate the id first, this issue can be resolved. To avoid duplicate settings, disable `FTRUMConfig.enableTraceUserResource` and `FTTraceConfig.enableAutoTrace`.

* **ft-sdk >= 1.4.1**

	The SDK automatically adapts to this issue.

### Error Data Loss (Crash Type Data)
* Confirm whether other third-party SDKs with crash capture functionality are used simultaneously. If so, initialize the observation SDK after other SDKs.

## Missing Specific Field Information in Data
### User Data Fields
* Confirm correct calls to [user data binding methods](app-access.md#userdata-bind-and-unbind). In debug mode, you can track this issue through logs.

	```java
	[FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> Your data operations <-----
	
	[FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### Missing Custom Parameters or Incorrect Values
* Confirm calls in the correct context, `FTRUMConfig.addGlobalContext`, `FTLoggerConfig.addGlobalContext` suitable for scenarios within an application cycle that do not change, such as app distributors or different Flavor attributes. For dynamic scenes requiring real-time response, use manual calls to [RUM](app-access.md#rum-trace) and [Log](app-access.md#log) interfaces.
* In debug mode, check `[FT-SDK]SyncTaskManager` logs to validate the correctness of custom field parameters.

## Log Enablement Causes Lag (`enableConsoleLog`)
If lag occurs, it may be due to excessive log collection data. `FTLoggerConfig.enableConsoleLog` captures `android.util.Log`, Java, and Kotlin `println`. Adjust `FTLoggerConfig` [settings](app-access.md#log-config) like `sampleRate`, `logPrefix`, `logLevelFilters` to mitigate or eliminate this issue.

## Okhttp EventListener Becomes Ineffective After Integrating SDK
After Plugin AOP ASM insertion, `eventListenerFactory` is added in `OkHttpClient.Builder()`, overriding the original `eventListener` or `eventListenerFactory`.

**Resolution:**

* **ft-sdk < 1.4.1**

	Disable automatic Plugin AOP settings `FTRUMConfig.setEnableTraceUserResource(false)` and customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting `FTResourceEventListener.FTFactory`, using [custom](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72) integration.

* **ft-sdk >= 1.4.1**

	Customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting `FTResourceEventListener.FTFactory` and set `FTRUMConfig.setOkHttpEventListenerHandler` to customize the ASM-injected `eventListenerFactory`.

* **ft-sdk >= 1.6.7**

	The SDK automatically adapts to this issue.