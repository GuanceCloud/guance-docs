# Troubleshooting

## Compilation Troubleshooting

Errors occur during the compilation process, and you need to check the compilation environment first.

### Runnable Compilation Environment 
#### ✅ Runnable Environment {#runnable}

* AGP `com.android.tools.build:gradle` version `3.5.0` or above
* Gradle version `5.4.0` or above
* Java version `8.0` or above
* Android minSdkVersion 21

**Note**: As the Android Studio version updates, the compatibility of these versions may also change. If you encounter a situation where the compilation environment meets the above conditions but still encounters compilation errors, please contact our developers.
 
#### ⚠️ Compatible Running Environment {#compatible}
* AGP `com.android.tools.build:gradle` version `3.0.1` or above
* Gradle version `4.8.1` or above
* Java version `8.0` or above
* Android minSdkVersion 21

> This environment does not support `ft-plugin`, and the data auto-capture part needs manual integration. For more information on manual integration, refer to [here](app-access.md#manual-set).

### SDK Unable to Resolve Import
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
The above error occurs because the maven repository is not correctly set. Refer to the [configuration](app-access.md#gradle-setting) here.


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
If the above error occurs during the compilation process, it is due to the AGP `3.0.0` compatibility issue. This issue is explained [here](https://github.com/gradle/gradle/issues/2384). You can resolve this by upgrading AGP to version `3.1.0` or higher, or by using a newer version of the SDK. Upgrade the version in `app/build.gradle`.

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')// Any version above 1.3.10 will work
}

```

#### API 'android.registerTransform' is obsolete {#transform_deprecated}

In `AGP 7.0`, `Transform` has been marked as `Deprecated` and was removed in `AGP 8.0`. `ft-plugin:1.2.0` has already adapted to this change. Please upgrade the corresponding version to fix this error. For more details, see [Integration Configuration](app-access.md#gradle-setting)

#### AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

`AndroidComponentsExtension` is a method supported by AGP `7.4.2`. Compiling environments below this version will produce this error. You can use the `ft-plugin-legacy` version to fix this error. For more details, see [Integration Configuration](app-access.md#gradle-setting)

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException: {#android_illegal_argument_exception}

* Invalid opcode 169

If this error occurs while using `ft_plugin_legacy`, it is a bug in the `asm-commons:7.0` version. The original issue is [here](https://gitlab.ow2.org/asm/asm/-/issues/317873). This can be resolved by depending on `org.ow2.asm:asm-commons:7.2` or higher in the plugin configuration. Use `./gradlew buildEnvironment` to confirm the actual `asm-commons` version being used.

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

Currently, the plugin version only supports build environments using `org.ow2.asm:asm7.x` or higher. You can query the build environment using `./gradlew buildEnvironment` to confirm this issue. This can be fixed by forcing a dependency on a version 7.x or higher. It is recommended to use version 7.2 or higher.

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

Check `Logcat` to confirm if there are logs with `Level` as `Error` and `Tag` prefixed with `[FT-SDK]`.

```kotlin
[FT-SDK] com.demo E Please install the SDK first (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
``` 

## Enable Debug Mode {#debug_mode}
### ft-sdk Debug Mode
You can enable the debug feature of the SDK through the following configuration. After enabling, the console `LogCat` will output the SDK debug logs, and you can filter the `[FT-SDK]` characters to locate the <<< custom_key.brand_name >>> SDK logs.

```kotlin
  val config = FTSDKConfig.builder(datakitUrl).setDebug(true)
  FTSdk.install(config)
```

#### Log Example {#log_sample}
##### Data Synchronization {#data_sync}
```java
// Check if the upload address is correct in the SDK configuration
[FT-SDK]FTHttpConfigManager com.demo D serverUrl ==>
									Datakit Url:http://10.0.0.1:9529
// Below are connection error logs
[FT-SDK]SyncTaskManager com.demo   E Network not available Stop poll
[FT-SDK]SyncTaskManager com.demo   E ↵
			1:Sync Fail-[code:10003,response:failed to connect to 10.0.0.1 (port 9529) from ↵
			10.0.2.16 (port 47968) after 10000ms, check if the local network connection is normal]

// Below are normal synchronization logs
[FT-SDK]SyncTaskManager com.demo   D Sync Success-[code:200,response:]

```

> **It is recommended to turn off this configuration when releasing the Release version**

### ft-plugin Debug Mode
You can enable the debug logs of the Plugin through the following configuration. After enabling, you can find the `[FT-Plugin]` output logs in the `Build` output logs. Use this to view the Plugin ASM writing situation.

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
> **To ensure the integrity of internal logs, this configuration should be set before initializing the SDK**

## SDK Runs Normally But No Data
* [Troubleshoot Datakit](../../datakit/why-no-data.md) whether it runs normally

* Confirm that the SDK upload address `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting), and initialized correctly. In [debug mode](#debug-mode), check the [logs](#data_sync) to determine upload issues.
	
* Whether datakit uploads data to the corresponding workspace and is not in an offline state. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking 「Infrastructure」.

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## Data Loss
### Partial Data Loss
* If RUM session data or some Log, Trace data are lost, first check if `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config).
* Investigate device network issues with uploading data and the network and load of devices running datakit.
* Confirm the proper call of `FTSdk.shutDown`, which releases the SDK data processing objects, including cached data.

### Resource Data Loss {#resource_missing}
#### Automatic Collection, Not Properly Integrated With ft-plugin
Automatic collection of Resources requires the help of Plugin ASM bytecode insertion, automatically setting `Interceptor` and `EventListener` for OkHttpClient, inserting `FTTraceInterceptor`, `FTResourceInterceptor`, `FTResourceEventListener.FTFactory`. If Plugin is not used, refer to [here](app-access.md#manual-set).

#### OkHttpClient.build() Called Before SDK Initialization
Plugin ASM inserts automatically when `OkHttpClient.build()` is called. If called before SDK initialization, it leads to loading an empty configuration, resulting in the loss of Resource-related data. This scenario can be self-inspected based on debug mode logs.

```java
//SDK initialization log
[FT-SDK]FTSdk       com.ft  D  initFTConfig complete
[FT-SDK]FTSdk       com.ft  D  initLogWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initRUMWithConfig complete
[FT-SDK]FTSdk       com.ft  D  initTraceWithConfig complete

//SDK OkHttpClient.Builder.build() call log
// (Must be called after SDK initialization)
[FT-SDK]AutoTrack  	com.ft  D  trackOkHttpBuilder    
```

>If it's impossible to adjust the initialization call order, choose [manual integration](app-access.md#manual-set).

#### Using Interceptor or EventListener That Processes Data Twice
After Plugin ASM inserts, it adds `addInterceptor` to `OkHttpClient.Builder()` in the original project code, adding `FTTraceInterceptor` and `FTResourceInterceptor`. These use the body contentLength from HTTP requests to calculate unique IDs, linking Resource data at various stages via this ID. If integrators add `addInterceptor` and modify the data size, causing inconsistent ID calculations across stages, it results in data loss.

**Resolution Method:**

* **ft-sdk < 1.4.1**

	Through [customizing](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72) the position order of `addInterceptor`, allowing the SDK method to calculate the ID first resolves this issue. To avoid duplicate settings, the custom method should disable the `enableTraceUserResource` in `FTRUMConfig` and `enableAutoTrace` in `FTTraceConfig`.

* **ft-sdk >= 1.4.1** 

	The SDK adapts automatically to this issue under non-manual settings scenarios. If manually set, ensure the observed `Interceptor` is in an earlier position.


### Error Data Loss Crash Type Data
* Confirm whether other third-party SDKs with Crash capture functionality are used simultaneously. If so, place the initialization method of the observation SDK after other SDKs.

## Missing Field Information in Data
### User Data Fields
* Confirm the correct call of [user data binding methods](app-access.md#userdata-bind-and-unbind). In debug mode, you can trace this issue via logs.
	
	```java
	[FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> Your data operations <-----
	
	[FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### Lost Custom Parameters or Incorrect Numerical Values
* Confirm the calls are made in the correct context, such as `FTRUMConfig.addGlobalContext`, `FTLoggerConfig.addGlobalContext`, suitable for scenarios within an application lifecycle that do not change, like app distributors or different Flavor attributes. If real-time responses are needed based on dynamic scenarios, manually call the [RUM](app-access.md#rum-trace) and [Log](app-access.md#log) interfaces.
* In debug mode, check the `[FT-SDK]SyncTaskManager` logs to verify the correctness of custom field parameters.

## Log Opening enableConsoleLog Causes Lag Issues
Possible reasons include excessively large log data collected by `FTLoggerConfig.enableConsoleLog`. Its principle is capturing compiled `android.util.Log`, Java and Kotlin `println`. Adjust parameters under `FTLoggerConfig` [configuration](app-access.md#log-config) such as `sampleRate`, `logPrefix`, `logLevelFilters` to eliminate or alleviate this problem.

## Okhttp EventListener Integration Becomes Ineffective After SDK Integration
After Plugin AOP ASM inserts, it adds `eventListenerFactory` to `OkHttpClient.Builder()`, covering the original `eventListener` or `eventListenerFactory`.

**Resolution Method:**

* **ft-sdk < 1.4.1**

	Turn off automatic Plugin AOP settings `FTRUMConfig setEnableTraceUserResource(false)`, and customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting from `FTResourceEventListener.FTFactory`, integrating via [custom](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72) method.

* **ft-sdk >= 1.4.1**

	Customize a [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) inheriting from `FTResourceEventListener.FTFactory`, setting `FTRUMConfig.setOkHttpEventListenerHandler` to customize the `eventListenerFactory` written by ASM.

* **ft-sdk >= 1.6.7**

	The SDK adapts automatically to this issue under non-manual settings scenarios.