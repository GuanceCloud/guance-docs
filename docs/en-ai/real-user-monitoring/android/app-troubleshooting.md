# Troubleshooting

## Compilation Troubleshooting

Errors occur during the compilation process, and you should first check the compilation environment.

### Runnable Compilation Environment 
#### ✅ Runnable Environment {#runnable}

* AGP `com.android.tools.build:gradle` version `3.5.0` or higher
* Gradle version `5.4.0` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

**Note**: As Android Studio versions update, this compatibility will change. If you encounter compilation errors even though your environment meets the above conditions, please contact our developers.
 
#### ⚠️ Compatible Running Environment {#compatible}
* AGP `com.android.tools.build:gradle` version `3.0.1` or higher
* Gradle version `4.8.1` or higher
* Java version `8.0` or higher
* Android minSdkVersion 21

> This environment does not support `ft-plugin`, and automatic data capture parts need to be manually integrated. For more manual integration details, refer to [here](app-access.md#manual-set).

### SDK Unable to Resolve Imports
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
The above error occurs because the Maven repository is not correctly configured. Please refer to the [configuration](app-access.md#gradle-setting) here.


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
If you encounter the above error during compilation, it is due to an AGP `3.0.0` compatibility issue. The [issue](https://github.com/gradle/gradle/issues/2384) explains this problem. You can resolve this by upgrading AGP to version `3.1.0` or higher, or using a newer SDK version. Upgrade the version in `app/build.gradle`.

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')// Any version 1.3.10 and above
}

```

#### API 'android.registerTransform' is Obsolete {#transform_deprecated}

`Transform` is marked as `Deprecated` in `AGP 7.0` and has been removed in `AGP 8.0`. `ft-plugin:1.2.0` has completed adaptation. Please upgrade to the corresponding version to fix this error. For specific instructions, see [integration configuration](app-access.md#gradle-setting)

#### AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

`AndroidComponentsExtension` is supported from AGP `7.4.2`. Compilation environments below this version will produce this error. Use `ft-plugin-legacy` to fix this error. Specific instructions are available [here](app-access.md#gradle-setting)

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException:  {#android_illegal_argument_exception}

* Invalid opcode 169

If you encounter this error while using `ft_plugin_legacy`, it is due to a bug in `asm-commons:7.0`. The original issue is [here](https://gitlab.ow2.org/asm/asm/-/issues/317873). You can resolve this by depending on `org.ow2.asm:asm-commons:7.2` or higher in the plugin configuration. Use `./gradlew buildEnvironment` to confirm the actual `asm-commons` version used.

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

Currently, the plugin version only supports build environments using `org.ow2.asm:asm7.x` or higher. Use `./gradlew buildEnvironment` to query the build environment and confirm this issue. This can be fixed by forcing a dependency on version 7.x or higher. It is recommended to use version 7.2 or higher.

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
         // Add dependencies
        classpath 'org.ow2.asm:asm:7.2'
        classpath 'org.ow2.asm:asm-commons:7.2'
    }
}
```


## SDK Initialization Exception Verification

Check `Logcat` to confirm if there are any logs with `Level` set to `Error` and `Tag` prefixed with `[FT-SDK]`

```kotlin
[FT-SDK] com.demo E Please install the SDK (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
``` 

## Enable Debug Mode {#debug_mode}
### ft-sdk Debug Mode
You can enable the debug feature of the SDK through the following configuration. After enabling, the console `LogCat` will output SDK debugging logs, which you can filter by `[FT-SDK]` to locate Guance SDK logs.

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
[FT-SDK]SyncTaskManager com.demo   D  <<<******************* Sync Poll Finish *******************

```

> **It is recommended to disable this configuration for Release versions**

### ft-plugin Debug Mode
You can enable Plugin debug logs through the following configuration. After enabling, you can find `[FT-Plugin]` output logs in the `Build` output logs. Use this to view the Plugin ASM injection status.

```groovy
FTExt {
    // Whether to display Plugin logs, default is false
    showLog = true
}
```
> **It is recommended to disable this configuration for Release versions**

## Convert SDK Internal Logs to Cache Files
```kotlin
// >= 1.4.6
// Default path: /data/data/{package_name}/files/LogInner.log
LogUtils.registerInnerLogCacheToFile()

// >= 1.4.5+ 
val cacheFile = File(filesDir, "LogCache.log")
LogUtils.registerInnerLogCacheToFile(cacheFile)
```
> **To ensure the completeness of internal logs, set this configuration before initializing the SDK**

## SDK Runs Normally But No Data
* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running normally

* Confirm that the SDK upload address `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting) and initialized properly. In [debug mode](#debug-mode), check the [logs](#data_sync) to diagnose upload issues.
	
* Ensure Datakit is uploading data to the corresponding workspace and is not offline. This can be confirmed by logging into Guance and checking the "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## Data Loss
### Partial Data Loss
* If RUM session data, Log, or a few Trace data points are lost, first check if `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config).
* Investigate network and load issues between the device sending data and the device running Datakit.
* Confirm that `FTSdk.shutDown` is correctly called. This method releases SDK data processing objects, including cached data.

### Resource Data Loss {#resource_missing}
#### Automatic Collection Not Properly Integrated
Resource auto-collection requires Plugin ASM bytecode injection to automatically configure OkHttpClient `Interceptor` and `EventListener`, injecting `FTTraceInterceptor`, `FTResourceInterceptor`, `FTResourceEventListener.FTFactory`. If not using Plugin, refer to [here](app-access.md#manual-set).

#### OkHttpClient.build() Called Before SDK Initialization
Plugin ASM injects code during `OkHttpClient.build()`. If called before SDK initialization, it leads to loading empty configurations, causing loss of Resource-related data. Inspect debug logs under debug mode for self-inspection.

```java
// SDK initialization log
[FT-SDK]FTSdk       com.ft  D  initFTConfig complete
[FT-SDK]FTSdk       com.ft  D  initLogWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initRUMWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initTraceWithConfig complete

// Log printed when OkHttpClient.Builder.build() is called
// (must be called after SDK initialization)
[FT-SDK]AutoTrack  	com.ft  D  trackOkHttpBuilder    
```

>If unable to adjust initialization order, choose [manual integration](app-access.md#manual-set)

#### Interceptor or EventListener Performs Secondary Processing on Data
After Plugin ASM inserts, `addInterceptor` is added to `OkHttpClient.Builder()` to include `FTTraceInterceptor` and `FTResourceInterceptor`. These interceptors use the HTTP request body contentLength for unique ID calculation. If third-party interceptors modify data size, it causes inconsistent ID calculations leading to data loss.

**Resolution:**

* **ft-sdk < 1.4.1**

	Adjust `addInterceptor` order to let SDK calculate IDs first. Disable `FTRUMConfig.enableTraceUserResource` and `FTTraceConfig.enableAutoTrace` to avoid redundant settings.

* **ft-sdk >= 1.4.1**

	The SDK adapts to this issue automatically.

### Error Data Loss for Crash Type Data
* Confirm whether other third-party SDKs with crash capture capabilities are also used. If so, initialize the Guance SDK after other SDKs.

## Missing Field Information in Data
### User Data Fields
* Confirm correct calls to [user data binding methods](app-access.md#userdata-bind-and-unbind). In debug mode, trace this via logs.

	```java
	[FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> Your data operations <-----
	
	[FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### Lost Custom Parameters or Incorrect Values
* Confirm correct context for calling `FTRUMConfig.addGlobalContext`, `FTLoggerConfig.addGlobalContext`. Use these for non-changing data within an app cycle. For dynamic scenarios, use [RUM](app-access.md#rum-trace) and [Log](app-access.md#log) interfaces manually.
* In debug mode, check `[FT-SDK]SyncTaskManager` logs to verify custom field parameters.

## Log Enablement Causes Lag Issues
If lag occurs, it may be due to excessive log collection. `FTLoggerConfig.enableConsoleLog` captures `android.util.Log`, Java, and Kotlin `println`. Adjust `FTLoggerConfig` [settings](app-access.md#log-config) like `sampleRate`, `logPrefix`, `logLevelFilters` to mitigate this issue.

## Okhttp EventListener Becomes Ineffective After SDK Integration
Plugin AOP ASM inserts `eventListenerFactory` into `OkHttpClient.Builder()`, overriding existing `eventListener` or `eventListenerFactory`.

**Resolution:**

* **ft-sdk < 1.4.1**

	Disable automatic Plugin AOP setting (`FTRUMConfig.setEnableTraceUserResource(false)`), then create a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) extending `FTResourceEventListener.FTFactory` and integrate manually.

* **ft-sdk >= 1.4.1**

	Create a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) extending `FTResourceEventListener.FTFactory`, and customize ASM-injected `eventListenerFactory` using `FTRUMConfig.setOkHttpEventListenerHandler`.

* **ft-sdk >= 1.6.7**

	The SDK adapts to this issue automatically.