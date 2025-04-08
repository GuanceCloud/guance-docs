# Troubleshooting

## Compilation Troubleshooting

Errors occur during the compilation process, and it is necessary to first check the compilation environment.

### Runnable Compilation Environment 
#### ✅ Runnable Environment {#runnable}

* AGP `com.android.tools.build:gradle` version `3.5.0` or higher
* Gradle version `5.4.0` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

**Note**: As the Android Studio version updates, the compatibility of these versions may also change. If you encounter a compilation error even though your environment meets the above conditions, please contact our developers.

#### ⚠️ Compatible Running Environment {#compatible}
* AGP `com.android.tools.build:gradle` version `3.0.1` or higher
* Gradle version `4.8.1` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

> This environment does not support `ft-plugin`, and manual integration is required for the automatic data capture part. For more information on manual integration, refer to [here](app-access.md#manual-set).

### SDK Unable to Resolve Import
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
The above errors occur because the maven repository is not correctly set up. Please refer to the [configuration](app-access.md#gradle-setting) here.


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
If the above error occurs during the compilation process, this is due to an AGP `3.0.0` compatibility issue. The [issue](https://github.com/gradle/gradle/issues/2384) explains this problem. You can resolve this by upgrading AGP to version `3.1.0` or higher, or using a newer version of the SDK, which can be upgraded in `app/build.gradle`.

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')// All versions above 1.3.10 are acceptable
}

```

#### API 'android.registerTransform' is obsolete {#transform_deprecated}

In `AGP 7.0`, `Transform` has been marked as `Deprecated` and will be removed in `AGP 8.0`. `ft-plugin:1.2.0` has completed the adaptation, so please upgrade to the corresponding version to fix this error. For more details, see [Integration Configuration](app-access.md#gradle-setting).

#### AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

`AndroidComponentsExtension` is a method supported by AGP `7.4.2`. Compilation environments below this version will generate this error. You can use the `ft-plugin-legacy` version to fix this error. For more details, see [Integration Configuration](app-access.md#gradle-setting).

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException: {#android_illegal_argument_exception}

* Invalid opcode 169

If this error occurs while using `ft_plugin_legacy`, this is a bug in the `asm-commons:7.0` version. The original issue is [here](https://gitlab.ow2.org/asm/asm/-/issues/317873). This can be resolved by depending on `org.ow2.asm:asm-commons:7.2` or higher in the plugin configuration. You can confirm the real `asm-commons` version being used with `./gradlew buildEnvironment`.

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

The current plugin version only supports build environments using `org.ow2.asm:asm7.x` or higher. You can query the build environment with `./gradlew buildEnvironment` to confirm this issue. This issue can be fixed by forcing a dependency on version 7.x or higher, and it is recommended to use version 7.2 or higher.

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

Check `Logcat` to confirm whether there are logs with `Level` as `Error` and `Tag` prefixed with `[FT-SDK]`.

```kotlin
[FT-SDK] com.demo E Please install the SDK first (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
```

## Enable Debugging {#debug_mode}
### ft-sdk Debug Mode
You can enable the debug functionality of the SDK through the following configuration. After enabling, the console `LogCat` will output SDK debugging logs. You can filter for the `[FT-SDK]` string to locate <<< custom_key.brand_name >>> SDK logs.

```kotlin
  val config = FTSDKConfig.builder(datakitUrl).setDebug(true)
  FTSdk.install(config)
```

#### Log Example {#log_sample}
##### Data Synchronization {#data_sync}
```java
// Check if the upload address is correctly configured in SDK settings
[FT-SDK]FTHttpConfigManager com.demo D serverUrl ==>
									Datakit Url:http://10.0.0.1:9529
// Below are connection error logs
[FT-SDK]SyncTaskManager com.demo   E Network not available Stop poll
[FT-SDK]SyncTaskManager com.demo   E ↵
			1:Sync Fail-[code:10003,response:failed to connect to 10.0.0.1 (port 9529) from ↵
			10.0.2.16 (port 47968) after 10000ms, check local network connection]

// Below are normal synchronization logs
[FT-SDK]SyncTaskManager com.demo   D Sync Success-[code:200,response:]

```

> **It is recommended to turn off this configuration when releasing the Release version**

### ft-plugin Debug Mode
You can enable Plugin debug logs through the following configuration. After enabling, you can find `[FT-Plugin]` output logs in the `Build` output logs. Use this to view the Plugin ASM writing situation.

```groovy
FTExt {
    // Whether to display Plugin logs, default is false
    showLog = true
}
```
> **It is recommended to turn off this configuration when releasing the Release version**

## SDK Internal Logs Converted to Cache Files
```kotlin
// >= 1.4.6
// Default path: /data/data/{package_name}/files/LogInner.log
LogUtils.registerInnerLogCacheToFile()

// >= 1.4.5+ 
val cacheFile = File(filesDir, "LogCache.log")
LogUtils.registerInnerLogCacheToFile(cacheFile)
```
> **To ensure the integrity of internal logs, this configuration must be set before initializing the SDK**

## SDK Runs Normally But No Data
* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it runs normally

* Confirm that the SDK upload address `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting) and initialized correctly. In [debug mode](#debug-mode), check the [logs](#data_sync) to determine upload issues.
	
* Check if datakit uploads data to the corresponding workspace and whether it is in offline status. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking 「Infrastructure」.

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## Data Loss
### Partial Data Loss
* If some Session data from RUM or Log, or several pieces of data from Trace are lost, first check if `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config).
* Investigate device network issues with uploading data and datakit installation network and load problems.
* Confirm correct invocation of `FTSdk.shutDown`, which releases SDK data processing objects, including cached data.

### Resource Data Loss {#resource_missing}
#### Automatic collection without correctly integrating ft-plugin
Automatic Resource collection requires assistance from Plugin ASM bytecode injection to automatically configure OkHttpClient `Interceptor` and `EventListener`, injecting `FTTraceInterceptor`, `FTResourceInterceptor`, `FTResourceEventListener.FTFactory`. If the Plugin is not used, please refer to [here](app-access.md#manual-set).

#### OkHttpClient.build() called before SDK initialization
Plugin ASM injects automatically when `OkHttpClient.build()` is called. If this happens before SDK initialization, it leads to loading empty configurations, resulting in loss of Resource-related data. In such scenarios, you can self-inspect based on the debug logs.

```java
// SDK initialization log
[FT-SDK]FTSdk       com.ft  D initFTConfig complete
[FT-SDK]FTSdk       com.ft  D initLogWithConfig complete
[FT-SDK]FTSdk       com.ft  D initRUMWithConfig complete
[FT-SDK]FTSdk       com.ft  D initTraceWithConfig complete

// Logs printed when `OkHttpClient.Builder.build()` is called
// (must be called after SDK initialization)
[FT-SDK]AutoTrack   com.ft  D trackOkHttpBuilder    
```

>If it's impossible to adjust the initialization call order, choose [manual integration](app-access.md#manual-set).

#### Data processed twice using Interceptor or EventListener
After Plugin ASM inserts, it adds `addInterceptor` to `OkHttpClient.Builder()`, adding `FTTraceInterceptor` and `FTResourceInterceptor`. These interceptors use the body contentLength from HTTP requests to calculate unique IDs, and `Resource` data across various stages is associated via this ID. Therefore, if the integrator uses `Okhttp` and also adds `addInterceptor` while modifying the data size, it causes inconsistent ID calculations across stages, leading to data loss.

**Handling Method:**

* **ft-sdk < 1.4.1**

	Customize the `addInterceptor` order to allow the SDK method to calculate the ID first, resolving this issue. To avoid redundant settings, close the `enableTraceUserResource` in `FTRUMConfig` and `enableAutoTrace` in `FTTraceConfig` for custom approaches.

* **ft-sdk >= 1.4.1**

	The SDK adapts to this issue under non-manual setting scenarios. If manual settings have been made, ensure that the observed `Interceptor` is placed earlier.

### Error Data Loss - Crash Type Data
* Confirm whether other third-party SDKs with crash capturing capabilities are used simultaneously. If so, place the initialization method of the observing SDK after other SDKs.

## Data Missing Specific Field Information
### User Data Fields
* Confirm correct invocation of [user data binding methods](app-access.md#userdata-bind-and-unbind). In debug mode, you can trace this issue through logs.

	```java
	[FT-SDK]FTRUMConfigManager com.demo D bindUserData xxxx
	
	///---> Your data operations <-----
	
	[FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### Lost Custom Parameters or Incorrect Values
* Confirm correct invocation in appropriate scenarios, such as `FTRUMConfig.addGlobalContext`, `FTLoggerConfig.addGlobalContext` for data that doesn't change within an application lifecycle, e.g., app channel distributors or different Flavor attributes. If dynamic scenes need real-time responses, manually invoke [RUM](app-access.md#rum-trace) and [Log](app-access.md#log) interfaces.
* In debug mode, check `[FT-SDK]SyncTaskManager` logs to validate the correctness of custom field parameters.

## Log Enablement Causes Lag with enableConsoleLog
If lag occurs, it might be due to excessive log data collection. The principle behind `FTLoggerConfig.enableConsoleLog` is capturing compiled `android.util.Log`, Java, and Kotlin `println`. It is recommended to adjust `FTLoggerConfig` [settings](app-access.md#log-config) like `sampleRate`, `logPrefix`, `logLevelFilters` to eliminate or alleviate this issue.

## Okhttp EventListener Integration Becomes Ineffective After SDK Integration
After Plugin AOP ASM insertion, `eventListenerFactory` is added to `OkHttpClient.Builder()`, overriding the original `eventListener` or `eventListenerFactory`.

**Handling Method:**

* **ft-sdk < 1.4.1**

	Disable automatic Plugin AOP auto-settings by calling `FTRUMConfig setEnableTraceUserResource(false)`, and customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting from `FTResourceEventListener.FTFactory`, then integrate using a [custom approach](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72).

* **ft-sdk >= 1.4.1**

	Customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting from `FTResourceEventListener.FTFactory`, and set `FTRUMConfig.setOkHttpEventListenerHandler` to customize the `eventListenerFactory` injected by ASM.

* **ft-sdk >= 1.6.7**

	The SDK adapts to this issue under non-manual setting scenarios.