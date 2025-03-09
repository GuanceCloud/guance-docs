# Troubleshooting

## Compilation Troubleshooting

Compilation errors occur, and the first step is to check the compilation environment.

### Runnable Compilation Environment 
#### ✅ Supported Environment {#runnable}

* AGP `com.android.tools.build:gradle` version `3.5.0` or higher
* Gradle version `5.4.0` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

**Note**: As Android Studio versions update, this compatibility may change. If you encounter compilation issues despite meeting the above conditions, please contact our developers.
 
#### ⚠️ Compatible Environment {#compatible}
* AGP `com.android.tools.build:gradle` version `3.0.1` or higher
* Gradle version `4.8.1` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

> This environment does not support `ft-plugin`, and manual integration is required for data auto-capture. For more details on manual integration, refer to [here](app-access.md#manual-set).

### SDK Import Issues
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
The above errors occur because the Maven repository is not correctly set up. Please refer to the [configuration](app-access.md#gradle-setting) here.


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
If you encounter the above error during compilation, it is due to an AGP `3.0.0` compatibility issue. This [issue](https://github.com/gradle/gradle/issues/2384) explains the problem. You can resolve it by upgrading AGP to version `3.1.0` or higher, or using a newer SDK version. Upgrade the version in `app/build.gradle`.

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')// Any version 1.3.10 and above
}

```

#### API 'android.registerTransform' is obsolete {#transform_deprecated}

`Transform` has been marked as `Deprecated` in `AGP 7.0` and removed in `AGP 8.0`. `ft-plugin:1.2.0` has been adapted to fix this issue. Please upgrade to the corresponding version to resolve this error. Refer to [integration configuration](app-access.md#gradle-setting) for more details.

#### AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

`AndroidComponentsExtension` is supported starting from AGP `7.4.2`. Environments below this version will produce this error. You can use `ft-plugin-legacy` to fix this error. Refer to [integration configuration](app-access.md#gradle-setting) for more details.

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException:  {#android_illegal_argument_exception}

* Invalid opcode 169

If you encounter this error while using `ft_plugin_legacy`, it's a bug in `asm-commons:7.0`. The original issue is [here](https://gitlab.ow2.org/asm/asm/-/issues/317873). You can resolve this by depending on `org.ow2.asm:asm-commons:7.2` or higher in the plugin configuration. Use `./gradlew buildEnvironment` to confirm the actual `asm-commons` version being used.

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
        // Add dependency
        classpath 'org.ow2.asm:asm-commons:7.2' 
    }
}
```

* org.ow2.asm:asm version below 7.0

Currently, the plugin only supports build environments using `org.ow2.asm:asm7.x` or higher. You can query the build environment using `./gradlew buildEnvironment` to confirm this issue. You can resolve this by forcing a dependency on version 7.x or higher, with a recommendation to use version 7.2 or higher.

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

Check `Logcat` to confirm if there are logs with `Level` as `Error` and `Tag` prefixed with `[FT-SDK]`

```kotlin
[FT-SDK] com.demo E Please install the SDK first (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
``` 

## Enable Debug Mode {#debug_mode}
### ft-sdk Debug Mode
You can enable the debug functionality of the SDK through the following configuration. Once enabled, the console `LogCat` will output SDK debugging logs, which you can filter by `[FT-SDK]` to locate <<< custom_key.brand_name >>> SDK logs.

```kotlin
  val config = FTSDKConfig.builder(datakitUrl).setDebug(true)
  FTSdk.install(config)
```

#### Log Sample {#log_sample}
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
[FT-SDK]SyncTaskManager com.demo   D  

```

> **It is recommended to disable this configuration for Release versions**

### ft-plugin Debug Mode
You can enable Plugin debug logs through the following configuration. Once enabled, you can find `[FT-Plugin]` output logs in the `Build` output logs. Use this to view the Plugin ASM injection status.

```groovy
FTExt {
    // Whether to display Plugin logs, default is false
    showLog = true
}
```
> **It is recommended to disable this configuration for Release versions**

## Converting SDK Internal Logs to Cache Files
```kotlin
// >= 1.4.6
// Default path: /data/data/{package_name}/files/LogInner.log
LogUtils.registerInnerLogCacheToFile()

// >= 1.4.5+ 
val cacheFile = File(filesDir, "LogCache.log")
LogUtils.registerInnerLogCacheToFile(cacheFile)
```
> **To ensure the integrity of internal logs, set this configuration before initializing the SDK**

## SDK Running Normally But No Data
* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running normally

* Confirm that the SDK upload URL `datakitUrl` or `datawayUrl` [is configured correctly](app-access.md#base-setting) and initialized properly. In [debug mode](#debug-mode), check the [logs](#data_sync) to diagnose upload issues.
	
* Verify whether Datakit is uploading data to the corresponding workspace and whether it is offline. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## Data Loss
### Partial Data Loss
* If RUM session data, log entries, or a few Trace data points are missing, first check if `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config).
* Investigate network and load issues between the device sending data and the Datakit installation.
* Ensure `FTSdk.shutDown` is correctly called to release SDK data processing objects, including cached data.

### Resource Data Loss {#resource_missing}
#### Automatic Collection Not Properly Integrated with ft-plugin
Resource automatic collection requires Plugin ASM bytecode injection to automatically configure OkHttpClient `Interceptor` and `EventListener`, injecting `FTTraceInterceptor`, `FTResourceInterceptor`, `FTResourceEventListener.FTFactory`. If not using Plugin, refer to [here](app-access.md#manual-set).

#### OkHttpClient.build() Called Before SDK Initialization
Plugin ASM injects code during `OkHttpClient.build()` calls. If this occurs before SDK initialization, it results in empty configurations and lost Resource data. Debug logs in debug mode can help self-inspect this scenario.

```java
// SDK initialization logs
[FT-SDK]FTSdk       com.ft  D  initFTConfig complete
[FT-SDK]FTSdk       com.ft  D  initLogWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initRUMWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initTraceWithConfig complete

// Logs printed when OkHttpClient.Builder.build() is called
// (must be called after SDK initialization)
[FT-SDK]AutoTrack  	com.ft  D  trackOkHttpBuilder    
```

>If unable to adjust initialization order, choose [manual integration](app-access.md#manual-set)

#### Data Processed Twice Using Interceptor or EventListener 
After Plugin ASM inserts `addInterceptor` into `OkHttpClient.Builder()`, adding `FTTraceInterceptor` and `FTResourceInterceptor`, it uses the HTTP request body contentLength for unique ID calculation. If additional interceptors modify the data size, causing inconsistent IDs across stages, data loss occurs.

**Resolution:**

* **ft-sdk < 1.4.1**

	Adjust the order of `addInterceptor` calls so the SDK calculates the ID first. Disable `enableTraceUserResource` in `FTRUMConfig` and `enableAutoTrace` in `FTTraceConfig` to avoid duplicate settings.

* **ft-sdk >= 1.4.1** 

	The SDK adapts to handle this compatibility issue.

### Error Data Loss (Crash Type Data)
* Ensure no other third-party SDK with crash capture functionality is used simultaneously. If so, initialize the observation SDK after other SDKs.

## Missing Field Information in Data
### User Data Fields
* Confirm correct calls to [user data binding methods](app-access.md#userdata-bind-and-unbind). In debug mode, verify via logs:

	```java
	[FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> Your data operations <-----
	
	[FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### Missing Custom Parameters or Incorrect Values
* Ensure correct context for calling `FTRUMConfig.addGlobalContext` and `FTLoggerConfig.addGlobalContext`, suitable for application-wide contexts like channels or flavors. For dynamic scenarios, use [RUM](app-access.md#rum-trace) and [Log](app-access.md#log) interfaces manually.
* In debug mode, review `[FT-SDK]SyncTaskManager` logs to validate custom field parameters.

## Log Enablement (`enableConsoleLog`) Causes Lagging Issues
Possible reasons include large log data captured by `FTLoggerConfig.enableConsoleLog`, which grabs `android.util.Log`, Java, and Kotlin `println`. Adjust `FTLoggerConfig` [settings](app-access.md#log-config) like `sampleRate`, `logPrefix`, and `logLevelFilters` to mitigate or resolve this issue.

## Okhttp EventListener Integration Becomes Ineffective After SDK Integration
After Plugin AOP ASM injection, `eventListenerFactory` is added to `OkHttpClient.Builder()`, overriding original `eventListener` or `eventListenerFactory`.

**Resolution:**

* **ft-sdk < 1.4.1**

	Disable automatic Plugin AOP settings by setting `FTRUMConfig setEnableTraceUserResource(false)`, then customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting from `FTResourceEventListener.FTFactory` and integrate it manually.

* **ft-sdk >= 1.4.1**

	Customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting from `FTResourceEventListener.FTFactory` and set `FTRUMConfig.setOkHttpEventListenerHandler` to customize the ASM-injected `eventListenerFactory`.

* **ft-sdk >= 1.6.7**

	The SDK handles this compatibility issue internally.