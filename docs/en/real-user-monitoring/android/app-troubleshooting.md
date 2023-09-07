# Troubleshooting
## Compile 
An error occurred during the compilation process. First, check the compilation environment.

### Runnable Compilation Environment. 
#### ✅ Runnable 
* AGP (`com.android.tools.build:gradle`) version is `3.5.0` or higher.
* Gradle version is `5.4.0` or higher.
* Java version is `8.0` or higher.
* Android `minSdkVersion` is 21.

> As Android Studio versions update, compatibility of these versions might change. If you encounter compilation errors even with a compilation environment meeting the above conditions, please reach out to our developers for assistance.

#### ⚠️ Compatible 
* AGP (`com.android.tools.build:gradle`) version is `3.0.1` or higher.
* Gradle version is `4.8.1` or higher.
* Java version is `8.0` or higher.
* Android `minSdkVersion` is 21.

> In this environment, the `ft-plugin` cannot be used. Certain portions that require automatic data capture need to be manually integrated. For more information on manual integration, please refer to [this link](app-access.md#manual-set).

### Fail to Apply SDK
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
The error you encountered is likely due to the Maven repository not being correctly set up. Please refer to the [configuration guide](app-access.md#gradle-setting) provided here for proper setup. 

### Compile Error

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
If you encounter the mentioned error during the compilation process, it's likely due to compatibility issues with AGP `3.0.0`. The provided [issue](https://github.com/gradle/gradle/issues/2384) explains this problem. To resolve it, you can upgrade to AGP version `3.1.0` or higher, or use a newer version of the SDK. You can update the version in `app/build.gradle` to address this issue.

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')//above 1.3.10 
}

```

####  API 'android.registerTransform' is obsolete {#transform_deprecated}

In AGP `7.0`, the `Transform` mechanism has been marked as deprecated and has been removed in AGP `8.0`. The `ft-plugin:1.2.0` version has been adapted to this change. To fix this error, please upgrade to the corresponding version. For detailed instructions, refer to the [integration configuration guide](app-access.md#gradle-setting).

####  AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

The `AndroidComponentsExtension` is a method supported by AGP `7.4.2`. If your compilation environment is below this version, you might encounter this error. To resolve this, you can use the `ft-plugin-legacy` version. For detailed instructions, refer to the [integration configuration guide](app-access.md#gradle-setting).

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException:  {#android_illegal_argument_exception}

* Invalid opcode 169

If you encounter this error while using `ft_plugin_legacy`, it might be due to a bug in the `asm-commons:7.0` version. The original issue is found [here](https://gitlab.ow2.org/asm/asm/-/issues/317873). To resolve this, you can add a dependency on `org.ow2.asm:asm-commons:7.2` or a higher version in your plugin configuration. You can confirm the actual version of `asm-commons` being used by running `./gradlew buildEnvironment`.

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
        // add here
        classpath 'org.ow2.asm:asm-commons:7.2' 
    }
}
```

* The `org.ow2.asm:asm` version is below 7.0.

Currently, the plugin version only supports build environments using `org.ow2.asm:asm7.x` or higher versions. You can use `./gradlew buildEnvironment` to check your build environment and confirm this issue. To resolve this, you can forcefully depend on a version above 7.x. It is recommended to use version 7.2 or higher.

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
         // add here
        classpath 'org.ow2.asm:asm:7.2'
        classpath 'org.ow2.asm:asm-commons:7.2'
    }
}
```

## Check for SDK Initialization Error
Check the `Logcat` to confirm the presence of logs with a `Level` of `Error` and a `Tag` prefixed with `[FT-SDK]`. 

```kotlin
14:46:04.825 [FT-SDK] com.demo E 请先安装SDK(在应用启动时调用 FTSdk.install(FTSDKConfig ftSdkConfig))
``` 

## Enable Debug Mode
You can enable the SDK's debug functionality through the following configuration. Once enabled, the console's `LogCat` will output SDK debug logs. You can filter by the `[FT-SDK]` keyword to locate the Guance SDK logs.

```kotlin
  val config = FTSDKConfig.setDebug(true);
  FTSdk.install(config)
```
> **It is recommended to disable this configuration when releasing the version.**

## Running normally but no data
* [Ensure Datakit](../../datakit/why-no-data.md) is running properly. 

* Confirm that the SDK's upload address `metricsUrl` is [configured correctly](app-access.md#base-setting) and initialized properly. In debug mode, you can use the following logs to identify issues with the upload address configuration.

	```java
	// Check datakit address
	11:15:38.137 [FT-SDK]FTHttpConfigManager com.demo D serverUrl:http://10.0.0.1:9529
	
	// Network connect error log
	10:51:48.879 [FT-SDK]OkHttpEngine  com.demo E failed to connect to /10.0.0.1.166 (port 9529) from /10.0.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常
    10:51:48.880 [FT-SDK]SyncTaskManager com.demo E 同步数据失败-[code:2,response:failed to connect to /10.0.0.1 (port 9529) from /10.100.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常]
	
	// Sync data success
	10:51:48.996 [FT-SDK]NetProxy com.demo D HTTP-response:[code:200,response:]
    10:51:48.996 [FT-SDK]SyncTaskManager com.demo D **********************同步数据成功**********************
	
	```
	
* Check if Datakit is uploading data to the corresponding workspace and whether it's in an offline state. You can confirm this by logging into Guance and checking the "Infrastructure" section.

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## Data Loss
### Partial Data Loss
* If you're missing certain Session data in RUM or logs in Trace, first make sure that you haven't set `sampleRate < 1` in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), or [FTTraceConfig](app-access.md#trace-config).
* Investigate network issues on devices uploading data and on devices running Datakit.
* Confirm that you're correctly calling `FTSdk.shutDown`. This method releases SDK data processing objects, including cached data.

### Resource Data Loss {#resource_missing}

####OkHttpClient.build() before SDK initialization
The writing of Plugin AOP ASM occurs automatically during the `OkHttpClient.build()` invocation. It writes the `FTTraceInterceptor`, `FTResourceInterceptor`, and `FTResourceEventListener.FTFactory`. If this process occurs before SDK initialization, it can lead to loading an empty configuration, resulting in the loss of Resource-related data.

#### Data undergoes secondary processing using Interceptors or EventListener

After Plugin AOP ASM insertion, the `OkHttpClient.Builder()` in the original project code is modified to include `addInterceptor`. This adds both `FTTraceInterceptor` and `FTResourceInterceptor`. The `Resource` data from different stages is connected contextually through a unique ID calculated using the `contentLength` of the HTTP request's body. If the integration modifies the data size by adding a secondary interceptor using `addInterceptor` in `Okhttp`, it can result in inconsistent ID calculations across stages and lead to data loss.

To solve this issue, you can ensure that the SDK's methods calculate the ID first by customizing the order of `addInterceptor`. For a detailed example of using a custom `EventListener` and `Interceptor` with `OKHttp`, refer to the [ManualActivity](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72) in the demo repository.

## Loss with Specific Field
### User Data
* Confirm that you're correctly calling the [user data binding methods](app-access.md#userdata-bind-and-unbind). In debug mode, you can track this issue through logs.
	
	```java
	13:41:00.749 [FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> Your Track Data <-----
	
	13:41:10.749 [FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### Custom Parameters or Incorrect Values
* Confirm that you're calling `FTRUMConfig.addGlobalContext` and `FTLoggerConfig.addGlobalContext` in the appropriate scenarios. These methods are suitable for data that remains constant throughout an application's lifecycle, such as application channel information or different Flavor attributes. If you need to respond dynamically to changing scenarios, use the manual calls for [RUM](app-access.md#rum-trace) and [Log](app-access.md#log) interfaces.
* In debug mode, check the `[FT-SDK]SyncTaskManager` logs. These logs can help verify the correctness of custom field parameters.


## Low performace with Log 'enableConsoleLog' 
If the issue is possibly due to the collected log data being too large, consider adjusting the `FTLoggerConfig` [configuration](app-access.md#log-config) parameters such as `sampleRate`, `logPrefix`, and `logLevelFilters` to eliminate or mitigate the problem. The `FTLoggerConfig.enableConsoleLog` works by intercepting `android.util.Log` and Java/Kotlin `println`. Adjust these parameters as needed to address the issue.

## Okhttp 'EventListener' no working after integrating
After Plugin AOP ASM insertion, the `OkHttpClient.Builder()` in the original project code is modified to include `eventListenerFactory`. This might override the existing `eventListener` or `eventListenerFactory`. To address this, you can disable the automatic AOP setup using `FTRUMConfig setEnableTraceUserResource(false)`, and then customize a `CustomEventListenerFactory` that inherits from `FTResourceEventListener.FTFactory`. For more details, refer to the [CustomEventListener](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) example in the demo repository.
