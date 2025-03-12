# Android Application Integration
---
<<< custom_key.brand_name >>> application monitoring can collect metrics data from various Android applications and analyze the performance of each Android application in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration} 

Log in to the <<< custom_key.brand_name >>> console, go to the **User Access Monitoring** page, click on the top-left **[Create Application](../index.md#create)** to start creating a new application.

- <<< custom_key.brand_name >>> provides **public DataWay** for direct reception of RUM data without the need to install the DataKit collector. Configuring `site` and `clientToken` parameters is sufficient.

![](../img/android_01.png)

- <<< custom_key.brand_name >>> also supports **local environment deployment** for receiving RUM data, which requires meeting the prerequisites.

![](../img/6.rum_android_1.png)


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the SDK's remote repository address in the `build.gradle` file at the root directory of the project

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //Add the SDK's remote repository address
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //Add Plugin dependency, requiring AGP 7.4.2 or above, Gradle 7.2.0 or above
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP versions below 7.4.2, use ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //Add the SDK's remote repository address
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	}
	```

=== "plugins DSL"

	```groovy
	//setting.gradle
	
	pluginManagement {
	    repositories {
	        google()
	        mavenCentral()
	        gradlePluginPortal()
	        //Add the SDK's remote repository address
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	dependencyResolutionManagement {
	    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
	    repositories {
	        google()
	        mavenCentral()
	        //Add the SDK's remote repository address
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//Add Plugin dependency, requiring AGP 7.4.2 or above, Gradle 7.2.0 or above
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		// For AGP versions below 7.4.2, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* In the `build.gradle` file of the main module `app` of the project, add dependencies for the `SDK`, usage of `Plugin`, and support for Java 8

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency for capturing native layer crash information, must be used with ft-sdk, cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended version, other versions have not been fully compatibility tested
    implementation 'com.google.code.gson:gson:2.8.5'

}
//Apply plugin
apply plugin: 'ft-plugin'
//Configure plugin usage parameters
FTExt {
    //Whether to display Plugin logs, default is false
    showLog = true
	
    //Set ASM version, supporting asm7 - asm9, default is asm9
    //asmVersion='asm7'

    //ASM ignore path configuration, paths with . and / are equivalent
    //ignorePackages=['com.ft','com/ft']

	//Native so specified path, just specify up to the abi file's parent directory
	// |-stripped_native_libs
	// 		|-release
	// 			|-out
	//			|-lib
	//				|-arm64-v8a
	//				|-armeabi-v7a
	//				|-...
    //nativeLibPath='/build/intermediates/merged_native_libs/release/out/lib'
}
android{
	//...omit some code
	defaultConfig {
        //...omit some code
        ndk {
            //When using ft-native to capture native layer crash information, select supported abi architectures based on the platforms adapted by the application.
            //Currently, ft-native includes abi architectures 'arm64-v8a',
            // 'armeabi-v7a', 'x86', 'x86_64'
            abiFilters 'armeabi-v7a'
        }
    }
    compileOptions {
        sourceCompatibility = 1.8
        targetCompatibility = 1.8
    }
}
```

> Refer to the latest versions of ft-sdk, ft-plugin, and ft-native above.

## Application Configuration {#application-setting}
Theoretically, the best place to initialize the SDK is in the `onCreate` method of `Application`. If your application has not yet created an `Application`, you need to create one and declare it in `AndroidManifest.xml`. Refer to the example [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

```xml
<application 
       android:name="YourApplication"> 
</application> 
```

## SDK Initialization {#init}

### Basic Configuration {#base-setting}
=== "Java"

	```java
	public class DemoApplication extends Application {

	    @Override
	    public void onCreate() {
			 //Local environment deployment, Datakit deployment
	        FTSDKConfig config = FTSDKConfig.builder(datakitUrl);

			//Using public DataWay
			FTSDKConfig config = FTSDKConfig.builder(datawayUrl, clientToken);

	        FTSdk.install(config);
	        // ...
	    }
	}
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {
			//Local environment deployment, Datakit deployment
			val config = FTSDKConfig.builder(datakitUrl)

			//Using public DataWay
			val config = FTSDKConfig.builder(datawayUrl, clientToken)

			FTSdk.install(config)
			//...
	    }
	}
    ```

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- | 
| datakitUrl | String | Yes | Datakit access URL, example: http://10.0.0.1:9529, default port is 9529. The device where the SDK is installed must be able to access this address. **Note: Choose either datakit or dataway configuration**|
| datawayUrl | String | Yes | Public Dataway access URL, example: http://10.0.0.1:9528, default port is 9528. The device where the SDK is installed must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | String | Yes | Authentication token, must be configured with datawayUrl |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`. Logs will only print when this is enabled |
| setEnv | EnvType | No | Set the collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set the collection environment, default is `prod`. **Note: Only configure one of String or EnvType types**|
| setOnlySupportMainProcess | Boolean | No | Whether to only support running in the main process, default is `true`. If execution is required in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable obtaining `Android ID`, default is `true`. If set to `false`, the `device_uuid` field data will not be collected. For market privacy review related [see here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add global attributes to the SDK, refer to [this](#key-conflict) for addition rules |
| setServiceName | String | No | Set the service name, affects Log and RUM service fields, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable auto synchronization, default is `true`. When set to `false`, use `FTSdk.flushSyncData()` to manage data synchronization manually |  
| setSyncPageSize | Int | No | Set the number of items per sync request, `SyncPageSize.MINI` 5 items, `SyncPageSize.MEDIUM` 10 items, `SyncPageSize.LARGE` 50 items, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set the number of items per sync request, range [5,), note that the larger the number of items, the more computing resources will be used, default is 10 **Note: Only configure one of setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set the intermittent time for synchronization, range [0,5000], default is not set  |
| enableDataIntegerCompatible | Void | No | This configuration is recommended when coexisting with web data. It handles web data type storage compatibility issues. Version 1.6.9 defaults to enabling this  |
| setNeedTransformOldCache | Boolean | No | Whether to support synchronizing old cache data from versions of ft-sdk below 1.6.0, default is false |
| setCompressIntakeRequests | Boolean | No | Compress sync data, supported by ft-sdk version 1.6.3 and above |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default is 100MB, unit is Byte. The larger the database, the greater the disk pressure. By default, this is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become ineffective. Supported by ft-sdk version 1.6.6 and above |

### RUM Configuration {#rum-config}

=== "Java"

	```java

	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .setRumAppId(RUM_APP_ID)
	            .setEnableTraceUserAction(true)
	            .setEnableTraceUserView(true)
	            .setEnableTraceUserResource(true)
	            .setSamplingRate(0.8f)
	            .setExtraMonitorTypeWithError(ErrorMonitorType.ALL.getValue())
	            .setDeviceMetricsMonitorType(DeviceMetricsMonitorType.ALL.getValue())
	            .setEnableTrackAppUIBlock(true)
	            .setEnableTrackAppCrash(true)
	            .setEnableTrackAppANR(true)
	);

	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .setRumAppId(RUM_APP_ID)
	                .setEnableTraceUserAction(true)
	                .setEnableTraceUserView(true)
	                .setEnableTraceUserResource(true)
	                .setSamplingRate(0.8f)
	                .setExtraMonitorTypeWithError(ErrorMonitorType.ALL.getValue())
	                .setDeviceMetricsMonitorType(DeviceMetricsMonitorType.ALL.getValue())
	                .setEnableTrackAppUIBlock(true)
	                .setEnableTrackAppCrash(true)
	                .setEnableTrackAppANR(true)
	        )
	```


| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setRumAppId | String | Yes | Sets the `Rum AppId`. Corresponds to setting the RUM `appid`, enabling RUM collection functionality, [method to obtain appid](#android-integration) |
| setSamplingRate | Float | No | Set the collection rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. Applies to all View, Action, LongTask, Error data within the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enables displaying error stack trace data in error analysis. <br> [About de-obfuscating content in crash logs](#retrace-log).<br><br>For ft-sdk versions 1.5.1 and above, `extraLogCatWithJavaCrash` and `extraLogCatWithNativeCrash` can be used to control whether logcat is displayed in Java Crash and Native Crash |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, adding additional monitoring data to Rum crash data, `ErrorMonitorType.BATTERY` for battery level, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, adding monitoring data during the View lifecycle, `DeviceMetricsMonitorType.BATTERY` monitors the highest output current of the current page, `DeviceMetricsMonitorType.MEMORY` monitors the current application's memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU jumps, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring frequency, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>For ft-sdk versions 1.5.1 and above, `extraLogCatWithANR` can be used to control whether logcat is displayed in ANR |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, for ft-sdk versions 1.6.4 and above, `blockDurationMs` can be used to control the detection time range [100,), unit is milliseconds, default is 1 second  |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user operations, currently only supports user startup and click operations, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically track user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Affects only the default collection when `EnableTraceUserResource` is true. For custom Resource collection, use `FTResourceEventListener.FTFactory(true)` to enable this feature. Additionally, a single Okhttp instance caches the IP for the same domain, and only generates once if the connected server IP does not change.|
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default is no filtering |
| setOkHttpEventListenerHandler | Callback| No | ASM sets a global Okhttp EventListener, default is not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets a global `FTResourceInterceptor.ContentHandlerHelper`, default is not set, supported by ft-sdk 1.6.7 and above, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom tags for distinguishing data sources in user monitoring. If tracking function is needed, the parameter `key` is `track_id` and `value` can be any value. Refer to [this](#key-conflict) for addition rules |
| setRumCacheLimitCount | int | No | Local cache limit for RUM count [10_000,), default is 100_000. Supported by ft-sdk 1.6.6 and above |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set discard rule for RUM data when it reaches the limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data, supported by ft-sdk 1.6.6 and above  |

### Log Configuration {#log-config}

=== "Java"

	```java
	FTSdk.initLogWithConfig(new FTLoggerConfig()
	    //.setEnableConsoleLog(true,"log prefix")
	    .setEnableLinkRumData(true)
	    .setEnableCustomLog(true)
	    //.setLogLevelFilters(new Status[]{Status.CRITICAL, Status.ERROR})
	    .setSamplingRate(0.8f));

	```

=== "Kotlin"

	```kotlin
	   FTSdk.initLogWithConfig(
	            FTLoggerConfig()
	              //.setEnableConsoleLog(true,"log prefix")
	                .setEnableLinkRumData(true)
	                .setEnableCustomLog(true)
	              //.setLogLevelFilters(arrayOf(Status.CRITICAL,Status.ERROR))
	                .setSamplingRate(0.8f)
	        )
	```

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setSamplingRate | Float | No | Set the collection rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level mapping<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning, <br> `prefix` is the control prefix filter parameter, default is no filtering. Note: Android console volume is very large, to avoid affecting application performance and reducing unnecessary resource waste, it is recommended to use `prefix` to filter out valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default is no filtering |
| addGlobalContext | Dictionary | No | Add global attributes to logs, refer to [this](#key-conflict) for addition rules |
| setLogCacheLimitCount | Int | No | Limit the maximum number of local cached log entries [1000,), larger logs mean greater disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set the discard rule for logs when they reach the limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data |

### Trace Configuration {#trace-config}

=== "Java"

	```java
	FTSdk.initTraceWithConfig(new FTTraceConfig()
	    .setSamplingRate(0.8f)
	    .setEnableAutoTrace(true)
	    .setEnableLinkRUMData(true));
	```

=== "Kotlin"

	```kotlin
	   FTSdk.initTraceWithConfig(
	            FTTraceConfig()
	                .setSamplingRate(0.8f)
	                .setEnableAutoTrace(true)
	                .setEnableLinkRUMData(true)
	        )
	```

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setSamplingRate | Float | No | Set the collection rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setTraceType | TraceType | No | Set the trace type, default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if integrating OpenTelemetry, choose the corresponding trace type and check supported types and agent configurations |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic HTTP trace, currently only supports automatic tracing for OKhttp, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets a global `FTTraceInterceptor.HeaderHandler`, default is not set, supported by ft-sdk 1.6.8 and above, example reference [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

`FTRUMConfig` configures `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition or manually use `FTRUMGlobalManager` to add these data, as shown below:

### Action

#### Usage Method

=== "Java"

	```java
		/**
	     *  Add Action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     */
	    public void startAction(String actionName, String actionType)


	    /**
	     * Add Action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     * @param property   Additional attribute parameters
	     */
	    public void startAction(String actionName, String actionType, HashMap<String, Object> property)


		/**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 */
		public void addAction(String actionName, String actionType)

		/**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param property Extended properties
		 */
		public void addAction(String actionName, String actionType, HashMap<String, Object> property)

		 /**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration
		 * @param property Extended properties
		 */
		public void addAction(String actionName, String actionType, long duration, HashMap<String, Object> property) 
    

	```

=== "Kotlin"

	```kotlin
		/**
	     *  Add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     */
		fun startAction(actionName: String, actionType: String)


		/**
	     * Add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     * @param property   Additional attribute parameters
	     */
	    fun startAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 */
		fun addAction(actionName: String, actionType: String)

		/**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param property Extended properties
		 */
		fun addAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration
		 * @param property Extended properties
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> `startAction` internally has a timing algorithm to calculate the duration, trying to correlate nearby occurring Resource, LongTask, Error data during the calculation period. It has a 100 ms frequent trigger protection and is recommended for user operation type data. If there is a need for frequent calls, use `addAction`. This data will not conflict with `startAction` and will not associate with current Resource, LongTask, Error data.


#### Code Example

=== "Java"

	```java
	// Scenario 1
	FTRUMGlobalManager.get().startAction("login", "action_type");

	// Scenario 2: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().startAction("login", "action_type", map);


	// Scenario 1
	FTRUMGlobalManager.get().addAction("login", "action_type");

	// Scenario 2: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addAction("login", "action_type", map);
	```

=== "Kotlin"

	```kotlin

	// Scenario 1
	FTRUMGlobalManager.get().startAction("login", "action_type")

	// Scenario 2: Dynamic parameters
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTRUMGlobalManager.get().startAction("login","action_type",map)


	// Scenario 1
	FTRUMGlobalManager.get().startAction("login", "action_type")

	// Scenario 2: Dynamic parameters
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTRUMGlobalManager.get().startAction("login","action_type",map)

	```

### View

#### Usage Method

=== "Java"

	```java

	    /**
	     * Start view
	     *
	     * @param viewName Current page name
	     */
	    public void startView(String viewName)


	    /**
	     * Start view
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters
	     */
	    public void startView(String viewName, HashMap<String, Object> property)


	    /**
	     * End view
	     */
	    public void stopView()

	    /**
	     * End view
	     *
	     * @param property Additional attribute parameters
	     */
	    public void stopView(HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin

		/**
	     * Start view
	     *
	     * @param viewName Current page name
	     */
		fun startView(viewName: String)

		 /**
	     * Start view
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters
	     */

		fun startView(viewName: String, property: HashMap<String, Any>)

		 /**
	     * End view
	     */
		fun stopView()

		 /**
	     * End view
	     *
	     * @param property Additional attribute parameters
	     */
		fun stopView(property: HashMap<String, Any>)

	```

#### Code Example

=== "Java"

	```java
	@Override
	protected void onResume() {
	    super.onResume();

	    // Scenario 1
	    FTRUMGlobalManager.get().startView("Current Page Name");

	    // Scenario 2: Dynamic parameters
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key", "ft_value");
	    map.put("ft_key_will_change", "ft_value");
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}

	@Override
	protected void onPause() {
	    super.onPause();

	    // Scenario 1
	    FTRUMGlobalManager.get().stopView();

	    // Scenario 2 : Dynamic parameters
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be changed to ft_value_change when stopView is called
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}
	```

=== "Kotlin"

	```kotlin
	override fun onResume() {
	     super.onResume()

	     // Scenario 1
	     FTRUMGlobalManager.get().startView("Current Page Name")

	     // Scenario 2: Dynamic parameters
	     val map = HashMap<String, Any>()
	     map["ft_key"] = "ft_value"
	     map["ft_key_will_change"] = "ft_value"
	     FTRUMGlobalManager.get().startView("Current Page Name", map)

	}

	override fun onPause() {
	     super.onPause()

	     // Scenario 1
	     FTRUMGlobalManager.get().stopView()


	     // Scenario 2 : Dynamic parameters
	     val map = HashMap<String, Any>()
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change this value will be changed to ft_value_change when stopView is called
	     FTRUMGlobalManager.get().startView("Current Page Name", map)

	}
	```

### Error

#### Usage Method

=== "Java"

	```java
	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state)


	     /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType, AppState state)

	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
		 * @param property  Additional properties
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType,
	                         AppState state, HashMap<String, Object> property)

		
		/**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     */
	    public void addError(String log, String message, String errorType, AppState state)


	     /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     */
	    public void addError(String log, String message, long dateline, String errorType, AppState state)

	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param property  Additional properties
	     */
	    public void addError(String log, String message, String errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     * @param property  Additional properties
	     */
	    public void addError(String log, String message, long dateline, String errorType,
	                         AppState state, HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin
		/**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param property  Additional properties
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState, property: HashMap<String, Any>)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     * @param property  Additional properties
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType,state: AppState, property: HashMap<String, Any>)


			/**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
		 * @param property  Additional properties
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState, property: HashMap<String, Any>)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running state
	     * @param dateline  Occurrence time, nanoseconds
		 * @param property  Additional properties
	     */
		fun addError(log: String, message```kotlin
		fun addError(log: String, message: String, dateline: Long, errorType: String,state: AppState, property: HashMap<String, Any>)

```

#### Code Example

=== "Java"

	```java
	// Scenario 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scenario 2: Delay recording the occurred error, generally the time is when the error occurred
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000L, ErrorType.JAVA, AppState.RUN);

	// Scenario 3: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN, map);
	```

=== "Kotlin"

	```kotlin

	// Scenario 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN)

	// Scenario 2: Delay recording the occurred error, generally the time is when the error occurred
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000, ErrorType.JAVA, AppState.RUN)

	// Scenario 3: Dynamic parameters
	val map = HashMap<String, Any>()
	map["ft_key"] = "ft_value"
	FTRUMGlobalManager.get().addError("error log", "error msg",ErrorType.JAVA,AppState.RUN,map)

	```
### LongTask

#### Usage Method

=== "Java"

	```java
	    /**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration, nanoseconds
	     */
	    public void addLongTask(String log, long duration)

	    /**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration, nanoseconds
	     */
	    public void addLongTask(String log, long duration, HashMap<String, Object> property)

	```

=== "Kotlin"

	```kotlin
	    /**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration, nanoseconds
	     */
		fun addLongTask(log: String, duration: Long)

		/**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration, nanoseconds
		 */

		fun addLongTask(log: String, duration: Long, property: HashMap<String, Any>)

	```

#### Code Example

=== "Java"

	```java
	// Scenario 1
	FTRUMGlobalManager.get().addLongTask("error log", 1000000L);

	// Scenario 2: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addLongTask("", 1000000L, map);
	```

=== "Kotlin"


	```kotlin

	// Scenario 1
	FTRUMGlobalManager.get().addLongTask("error log",1000000L)

	// Scenario 2: Dynamic parameters
	 val map = HashMap<String, Any>()
	 map["ft_key"] = "ft_value"
	 FTRUMGlobalManager.get().addLongTask("", 1000000L,map)

	```

### Resource

#### Usage Method

=== "Java"

	```java

	    /**
	     * Start resource
	     *
	     * @param resourceId Resource ID
	     */
	    public void startResource(String resourceId)

	    /**
	     * Start resource
	     *
	     * @param resourceId Resource ID
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * Stop resource
	     *
	     * @param resourceId Resource ID
	     */
	    public void stopResource(String resourceId)

	    /**
	     * Stop resource
	         *
	     * @param resourceId Resource ID
	     * @param property   Additional attribute parameters
	     */
	    public void stopResource(final String resourceId, HashMap<String, Object> property)


	    /**
	     * Set network transmission content
	     *
	     * @param resourceId
	     * @param params
	     * @param netStatusBean
	     */
	    public void addResource(String resourceId, ResourceParams params, NetStatusBean netStatusBean)

	```

=== "Kotlin"

	```kotlin

	/**
	 * Start resource
	 *
	 * @param resourceId Resource ID
	 */
	fun startResource(resourceId: String)

	/**
	 * Start resource
	 *
	 * @param resourceId Resource ID
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * Stop resource
	 *
	 * @param resourceId Resource ID
	 */
	fun stopResource(resourceId: String)

	/**
	 * Stop resource
	 *
	 * @param resourceId Resource ID
	 * @param property   Additional attribute parameters
	 */
	fun stopResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * Set network transmission content
	 *
	 * @param resourceId
	 * @param params
	 * @param netStatusBean
	 */
	fun addResource(resourceId: String, params: ResourceParams, netStatusBean: NetStatusBean)

	```

#### Code Example

=== "Java"

	```java

	// Scenario 1
	// Request start
	FTRUMGlobalManager.get().startResource("resourceId");

	//...

	// Request end
	FTRUMGlobalManager.get().stopResource("resourceId");

	// Finally, after the request ends, send related data metrics of the request
	ResourceParams params = new ResourceParams();
	params.setUrl("https://www.guance.com");
	params.setResponseContentType(response.header("Content-Type"));
	params.setResponseConnection(response.header("Connection"));
	params.setResponseContentEncoding(response.header("Content-Encoding"));
	params.setResponseHeader(response.headers().toString());
	params.setRequestHeader(request.headers().toString());
	params.setResourceStatus(response.code());
	params.setResourceMethod(request.method());

	NetStatusBean bean = new NetStatusBean();
	bean.setTcpStartTime(60000000);
	//...

	FTRUMGlobalManager.get().addResource("resourceId", params, bean);


	// Scenario 2 : Dynamic parameters usage
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be changed to ft_value_change when stopResource is called
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// Scenario 1
	// Request start
	FTRUMGlobalManager.get().startResource("resourceId")

	// Request end
	FTRUMGlobalManager.get().stopResource("resourceId")

	// Finally, after the request ends, send related data metrics of the request
	val params = ResourceParams()
	params.url = "https://www.guance.com"
	params.responseContentType = response.header("Content-Type")
	params.responseConnection = response.header("Connection")
	params.responseContentEncoding = response.header("Content-Encoding")
	params.responseHeader = response.headers.toString()
	params.requestHeader = request.headers.toString()
	params.resourceStatus = response.code
	params.resourceMethod = request.method

	val bean = NetStatusBean()
	bean.tcpStartTime = 60000000
	//...
	FTRUMGlobalManager.get().addResource("resourceId",params,bean)

	// Scenario 2 : Dynamic parameters usage
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)

	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change"
	)
	// ft_key_will_change this value will be changed to ft_value_change when stopResource is called

	FTRUMGlobalManager.get().stopResource(uuid, map)

	```

| **Method Name** | **Required** | **Description** |**Note** |
| --- | --- | --- | --- |
| NetStatusBean.fetchStartTime | No | Request start time | |
| NetStatusBean.tcpStartTime | No | TCP connection time |  |
| NetStatusBean.tcpEndTime | No | TCP end time |  |
| NetStatusBean.dnsStartTime | No | DNS start time |  |
| NetStatusBean.dnsEndTime | No | DNS end time | |
| NetStatusBean.responseStartTime | No | Response start time |  |
| NetStatusBean.responseEndTime | No | Response end time |  |
| NetStatusBean.sslStartTime | No | SSL start time |  |
| NetStatusBean.sslEndTime | No | SSL end time | |
| NetStatusBean.property| No | Additional properties | |
| ResourceParams.url | Yes | URL address | |
| ResourceParams.requestHeader | No | Request header parameters |  |
| ResourceParams.responseHeader | No | Response header parameters |  |
| ResourceParams.responseConnection | No | Response connection | |
| ResourceParams.responseContentType | No | Response ContentType | |
| ResourceParams.responseContentEncoding | No | Response ContentEncoding |  |
| ResourceParams.resourceMethod | No | Request method | GET, POST, etc. |
| ResourceParams.responseBody | No | Returned body content | |
| ResourceParams.property| No | Additional properties |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, which requires enabling `FTLoggerConfig.setEnableCustomLog(true)`
> Currently, log content is limited to 30 KB, and any exceeding characters will be truncated.

### Usage Method

=== "Java"

	```java
	    /**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    public void logBackground(String content, Status status)

	    /**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
		 * @param property Additional properties
	     */
	    public void logBackground(String content, Status status, HashMap<String, Object> property)

		/**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    public void logBackground(String content, String status)

	    /**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
		 * @param property Additional properties
	     */
	    public void logBackground(String content, String status, HashMap<String, Object> property)


	    /**
	     * Store multiple log entries locally in sync
	     *
	     * @param logDataList {@link LogData} list
	     */
	    public void logBackground(List<LogData> logDataList)


	```

=== "Kotlin"

	```kotlin

	    /**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    fun logBackground(content: String, status: Status)

	    /**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log properties
	     */
	    fun logBackground(content: String, status: Status, property: HashMap<String, Any>)

		/**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    fun logBackground(content: String, status: String)

	    /**
	     * Store a single log entry locally in sync
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log properties
	     */
	    fun logBackground(content: String, status: String, property: HashMap<String, Any>)

	    /**
	     * Store multiple log entries locally in sync
	     *
	     * @param logDataList Log data list
	     */
	    fun logBackground(logDataList: List<LogData>)

	```

#### Log Levels

| **Method Name** | **Meaning** |
| --- | --- |
| Status.DEBUG | Debug |
| Status.INFO | Info |
| Status.WARNING | Warning |
| Status.ERROR | Error |
| Status.CRITICAL | Critical |
| Status.OK | OK |

### Code Example


=== "Java"

	```java
	// Upload a single log
	FTLogger.getInstance().logBackground("test", Status.INFO);

	// Pass parameters to HashMap
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTLogger.getInstance().logBackground("test", Status.INFO, map);

	// Batch upload logs
	List<LogData> logList = new ArrayList<>();
	logList.add(new LogData("test", Status.INFO));
	FTLogger.getInstance().logBackground(logList);
	```

=== "Kotlin"

	```kotlin
	// Upload a single log
	FTLogger.getInstance().logBackground("test", Status.INFO)

	// Pass parameters to HashMap
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTLogger.getInstance().logBackground("test", Status.INFO,map)

	// Batch upload logs
	FTLogger.getInstance().logBackground(mutableListOf(LogData("test",Status.INFO)))
	```

## Tracer Network Link Tracing

Configure `FTTraceConfig` to enable `enableAutoTrace` to automatically add trace data, or manually use `FTTraceManager` to add `Propagation Header` in HTTP requests, as shown below:

=== "Java"

	```java
	String url = "https://www.guance.com";
	String uuid = "uuid";
	// Get trace header parameters
	Map<String, String> headers = FTTraceManager.get().getTraceHeader(uuid, url);

	OkHttpClient client = new OkHttpClient.Builder().addInterceptor(chain -> {
	    Request original = chain.request();
	    Request.Builder requestBuilder = original.newBuilder();
	    // Add trace header parameters to the request
	    for (String key : headers.keySet()) {
	        requestBuilder.header(key, headers.get(key));
	    }
	    Request request = requestBuilder.build();

	    Response response = chain.proceed(request);

	    if (response != null) {
	        Map<String, String> requestHeaderMap = new HashMap<>();
	        Map<String, String> responseHeaderMap = new HashMap<>();
	        for (Pair<String, String> header : response.request().headers()) {
	            requestHeaderMap.put(header.first, header.second);
	        }
	        for (Pair<String, String> header : response.headers()) {
	            responseHeaderMap.put(header.first, header.second);
	        }
	    }

	    return response;
	}).build();

	Request.Builder builder = new Request.Builder().url(url).method(RequestMethod.GET.name(), null);
	client.newCall(builder.build()).execute();
	```

=== "Kotlin"

	```kotlin
	val url = "https://www.guance.com"
	val uuid ="uuid"
	// Get trace header parameters
	val headers = FTTraceManager.get().getTraceHeader(uuid, url)

	val client: OkHttpClient = OkHttpClient.Builder().addInterceptor { chain ->

	                    val original = chain.request()
	                    val requestBuilder = original.newBuilder()
	                    // Add trace header parameters to the request
	                    for (key in headers.keys) {
	                        requestBuilder.header(key!!, headers[key]!!)
	                    }
	                    val request = requestBuilder.build()

	                    response = chain.proceed(request)

	                    if (response != null) {
	                        val requestHeaderMap = HashMap<String, String>()
	                        val responseHeaderMap = HashMap<String, String>()
	                        request.headers.forEach {
	                            requestHeaderMap[it.first] = it.second
	                        }
	                        response!!.headers.forEach {
	                            responseHeaderMap[it.first] = it.second

	                        }

	                    }

	                    response!!
	                }.build()

	 val builder: Request.Builder = Request.Builder().url(url).method(RequestMethod.GET.name, null)
	client.newCall(builder.build()).execute()
	```

## Customizing Resource and TraceHeader via OKHttp Interceptor {#okhttp_resource_trace_interceptor_custom}

When both `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace` are enabled, custom `Interceptor` configurations have higher priority.
 > For ft-sdk versions < 1.4.1, you need to disable `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`.
 > For ft-sdk versions > 1.6.7, custom Trace Headers can be associated with RUM data.

=== "Java"

	```java
	 new OkHttpClient.Builder()
	        .addInterceptor(new FTTraceInterceptor(new FTTraceInterceptor.HeaderHandler() {
	               @Override
	               public HashMap<String, String> getTraceHeader(Request request) {
	                   HashMap<String, String> map = new HashMap<>();
	                   map.put("custom_header","custom_value");
	                   return map;
	              }

				 // Supported by ft-sdk 1.6.7 and above
				  @Override
				  public String getSpanID() {
					return "span_id";
				 }
				// Supported by ft-sdk 1.6.7 and above
				 @Override
				 public String getTraceID() {
					return "trace_id";
				 }
	        }))
           .addInterceptor(new FTResourceInterceptor(new FTResourceInterceptor.ContentHandlerHelper() {
               @Override
               public void onRequest(Request request, HashMap<String, Object> extraData) {
                   String contentType = request.header("Content-Type");
                   extraData.put("df_request_header", request.headers().toString());
                   if ("application/json".equals(contentType) ||
                           "application/x-www-form-urlencoded".equals(contentType) ||
                           "application/xml".equals(contentType)) {
                       extraData.put("df_request_body", request.body());
                
            
               @Override
               public void onResponse(Response response, HashMap<String, Object> extraData) throws IOException {
                   String contentType = response.header("Content-Type");
                   extraData.put("df_response_header", response.headers().toString());
                   if ("application/json".equals(contentType) ||
                           "application/xml".equals(contentType)) {
                       // Read part of the body to avoid consuming large data
                       ResponseBody body = response.peekBody(33554432);
                       extraData.put("df_response_body", body.string());
                   }
            
               @Override
               public void onException(Exception e, HashMap<String, Object> extraData)
               }
           }))
           .eventListenerFactory(new FTResourceEventListener.FTFactory())
           .build();
	```
	
=== "Kotlin"

	```kotlin
	OkHttpClient.Builder()
    .addInterceptor(FTTraceInterceptor(object : FTTraceInterceptor.HeaderHandler {
        override fun getTraceHeader(request: Request): HashMap<String, String> {
            val map = HashMap<String, String>()
            map["custom_header"] = "custom_value"
            return map
        }
    }))
    .addInterceptor(FTResourceInterceptor(object : FTResourceInterceptor.ContentHandlerHelper {
        override fun onRequest(request: Request, extraData: HashMap<String, Any>) {
            val contentType = request.header("Content-Type")
            extraData["df_request_header"] = request.headers().toString()
            if ("application/json" == contentType ||
                "application/x-www-form-urlencoded" == contentType ||
                "application/xml" == contentType) {
                extraData["df_request_body"] = request.body()
            }
        }

        override fun onResponse(response: Response, extraData: HashMap<String, Any>) {
            val contentType = response.header("Content-Type")
            extraData["df_response_header"] = response.headers().toString()
            if ("application/json" == contentType ||
                "application/xml" == contentType) {
                // Copy part of the response body to avoid consuming large data
                val body = response.peekBody(33554432)
                extraData["df_response_body"] = body.string()
            }
        }

        override fun onException(e: Exception, extraData: HashMap<String, Any>) {
            // Handle exception
        }
    }))
    .eventListenerFactory(FTResourceEventListener.FTFactory())
    .build()
	```

## Binding and Unbinding User Information {#userdata-bind-and-unbind}
Use `FTSdk` to bind and unbind user information 

### Usage Method

=== "Java"

	```java

	   /**
	     * Bind user information
	     *
	     * @param id
	     */
	    public static void bindRumUserData(@NonNull String id)

	    /**
	     * Bind user information
	     */
	    public static void bindRumUserData(@NonNull UserData data)
	```

=== "Kotlin"

	``` kotlin
	/**
	     * Bind user information
	     *
	     * @param id User ID
	     */
	    fun bindRumUserData(id: String) {
	        // TODO: implement bindRumUserData method
	    }

	    /**
	     * Bind user information
	     *
	     * @param data User information
	     */
	    fun bindRumUserData(data: UserData) {
	        // TODO: implement bindRumUserData method
	    }
	```


#### UserData
| **Method Name** | **Meaning** | **Required** | **Note** |
| --- | --- | --- | --- |
| setId | Set user ID | No | |
| setName | Set username | No | |
| setEmail | Set email | No | |
| setExts | Set user extensions | No | Refer to [this](#key-conflict) for addition rules|

### Code Example

=== "Java"

	```java
	// Call this method after successful user login to bind user information
	FTSdk.bindRumUserData("001");

	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);

	// Call this method after user logout to unbind user information
	FTSdk.unbindRumUserData();

	```

=== "Kotlin"

	```kotlin
	// Call this method after successful user login to bind user information
	FTSdk.bindRumUserData("001")


	// Bind more user data
	val userData = UserData()
	userData.name = "test.user"
	userData.id = "test.id"
	userData.email = "test@mail.com"
	val extMap = HashMap<String, String>()
	extMap["ft_key"] = "ft_value"
	userData.exts = extMap
	FTSdk.bindRumUserData(userData)

	// Call this method after user logout to unbind user information
	FTSdk.unbindRumUserData()
	```


## Closing SDK
Use `FTSdk` to close the SDK 

### Usage Method
=== "Java"

	```java
	    /**
	     * Shutdown running objects within the SDK
	     */
	    public static void shutDown()

	```

=== "Kotlin"


	``` kotlin
	    /**
	     * Shutdown running objects within the SDK
	     */
	    fun shutDown()
	```

### Code Example
    
=== "Java"

	```java
	// If dynamically changing SDK configuration, you need to shut down first to avoid incorrect data generation
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	// If dynamically changing SDK configuration, you need to shut down first to avoid incorrect data generation
	FTSdk.shutDown()
	```

## Clearing SDK Cache Data
Use `FTSdk` to clear unsent cached data 

### Usage Method
=== "Java"

	```java
	    /**
		 * Clear unsent cached data
		 */
	    public static void clearAllData()

	```

=== "Kotlin"


	``` kotlin
	     /**
		  * Clear unsent cached data
		  */
	    fun clearAllData()
	```

### Code Example
    
=== "Java"

	```java
	FTSdk.clearAllData();
	```

=== "Kotlin"

	```kotlin
	FTSdk.clearAllData()
	```

## Synchronizing Data Actively
Use `FTSdk` to actively synchronize data.
> When `FTSdk.setAutoSync(false)` is set, manual data synchronization is required

### Usage Method

=== "Java"

	```java
	   /**
	     * Active data synchronization
	     */
	    public static void flushSyncData()
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Active data synchronization
	     */
	    fun flushSyncData()
	```

### Code Example

=== "Java"

	```java
	FTSdk.flushSyncData()
	```

=== "Kotlin"

	```kotlin
	FTSdk.flushSyncData()
	```



## Dynamically Enable and Disable AndroidID Acquisition
Use `FTSdk` to set whether to acquire Android ID in the SDK

### Usage Method

=== "Java"

	```java
	   /**
	     * Dynamically control acquiring Android ID
	     *
	     * @param enableAccessAndroidID true to apply, false not to apply
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Dynamically control acquiring Android ID
	     *
	     * @param enableAccessAndroidID true to apply, false not to apply
	     */
	    fun setEnableAccessAndroidID(enableAccessAndroidID:Boolean)
	```

### Code Example

=== "Java"

	```java
	// Enable acquiring Android ID
	FTSdk.setEnableAccessAndroidID(true);

	// Disable acquiring Android ID
	FTSdk.setEnableAccessAndroidID(false);
	```

=== "Kotlin"

	```kotlin
	// Enable acquiring Android ID
	FTSdk.setEnableAccessAndroidID(true)

	// Disable acquiring Android ID
	FTSdk.setEnableAccessAndroidID(false)
	```

## Adding Custom Tags

Use `FTSdk` to dynamically add tags during SDK runtime

### Usage Method

=== "Java"

	```java
	/**
	 * Dynamically set global tags
	 * @param globalContext
	 */
	public static void appendGlobalContext(HashMap<String,Object> globalContext)

	/**
	 * Dynamically set RUM global tags
	 * @param globalContext
	 */
	public static void appendRUMGlobalContext(HashMap<String,Object> globalContext)

	/**
	 * Dynamically set log global tags
	 * @param globalContext
	 */
	public static void appendLogGlobalContext(HashMap<String,Object> globalContext)

	```

=== "Kotlin"

	```kotlin
	/**
	 * Dynamically set global tags
	 * @param globalContext
	 */
	fun appendGlobalContext(globalContext: HashMap<String, Any>) 

	/**
	 * Dynamically set RUM global tags
	 * @param globalContext
	 */
	fun appendRUMGlobalContext(globalContext: HashMap<String, Any>) 

	/**
	 * Dynamically set log global tags
	 * @param globalContext
	 */
	fun appendLogGlobalContext(globalContext: HashMap<String, Any>)

	```

### Code Example

=== "Java"

	```java
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("global_key", "global_value");
	FTSdk.appendGlobalContext(globalContext);

	HashMap<String, Object> rumGlobalContext = new HashMap<>();
	rumGlobalContext.put("rum_key", "rum_value");
	FTSdk.appendRUMGlobalContext(rumGlobalContext);

	HashMap<String, Object> logGlobalContext = new HashMap<>();
	logGlobalContext.put("log_key", "log_value");
	FTSdk.appendLogGlobalContext(logGlobalContext);
	```

=== "Kotlin"

	```kotlin
	val globalContext = hashMapOf<String, Any>(
		"global_key" to "global_value"
	)
	FTSdk.appendGlobalContext(globalContext)

	val rumGlobalContext = hashMapOf<String, Any>(
		"rum_key" to "rum_value"
	)
	FTSdk.appendRUMGlobalContext(rumGlobalContext)

	val logGlobalContext = hashMapOf<String, Any>(
		"log_key" to "log_value"
	)
	FTSdk.appendLogGlobalContext(logGlobalContext)
	```

## R8 / Proguard Obfuscation Configuration {#r8_proguard}

```java
-dontwarn com.ft.sdk.**

### ft-sdk Library
-keep class com.ft.sdk.**{*;}

### ft-native Library
-keep class ftnative.*{*;}

### Prevent Action names from being obfuscated in View classes ###
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (Supported only by datakit [local deployment])
The `ft-plugin` version needs to support the latest symbol file upload rules starting from version `1.3.0`, supporting `productFlavor` multi-version management. The plugin will execute symbol file upload after `gradle task assembleRelease`. Detailed configuration can be referenced in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, no need to configure if generateSourceMapOnly=true
    datawayToken = 'dataway_token' 		// space token, no need to configure if generateSourceMapOnly=true
    appId = "appid_xxxxx"				// appid, no need to configure if generateSourceMapOnly=true
    env = 'common'						// environment, no need to configure if generateSourceMapOnly=true
	generateSourceMapOnly = false // Only generate sourcemap, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, supported by ft-plugin:1.3.4 and above

    prodFlavors { // prodFlavors configuration overrides outer settings
        prodTest {
            autoUploadMap = false
            autoUploadNativeDebugSymbol = false
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodTest"
            env = "gray"
        }
        prodPublish {
            autoUploadMap = true
            autoUploadNativeDebugSymbol = true
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodPublish"
            env = "prod"
        }
    }
}

```
### Manual Upload
Use `plugin` to enable `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or pack into a `zip` file manually, then upload to `datakit` or from <<< custom_key.brand_name >>> Studio. It is recommended to use the `zip` command line for packing to avoid including system hidden files in the `zip` package. Refer to [sourcemap upload](../sourcemap/set-sourcemap.md) for symbol uploading.

> For Unity Native Symbol files, refer to the [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ingore_aop}
Through Plugin AOP covering methods, add `@IngoreAOP` to ignore ASM insertion

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IngoreAOP{

        }
	```

## WebView Data Monitoring
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);

	```
=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	        )
	```
### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	            val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	            sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()

	        }
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained with network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init() 

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}

```

## Common Issues {#FAQ}
### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig
	            .builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init()

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext);
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext);
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init()

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init()

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init()

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
    HashMap<String, Object> globalContext = new HashMap<>();
    globalContext.put("delay_key", info.value);
    FTSdk.appendGlobalContext(globalContext);
}
```

## Symbol File Upload {#source_map}

### Plugin Upload (Supported only by datakit [local deployment])

The `ft-plugin` version needs to support the latest symbol file upload rules starting from version `1.3.0`, supporting `productFlavor` multi-version management. The plugin will execute symbol file upload after `gradle task assembleRelease`. Detailed configuration can be referenced in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

```groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, no need to configure if generateSourceMapOnly=true
    datawayToken = 'dataway_token' 		// space token, no need to configure if generateSourceMapOnly=true
    appId = "appid_xxxxx"				// appid, no need to configure if generateSourceMapOnly=true
    env = 'common'						// environment, no need to configure if generateSourceMapOnly=true
	generateSourceMapOnly = false // Only generate sourcemap, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, supported by ft-plugin:1.3.4 and above

    prodFlavors { // prodFlavors configuration overrides outer settings
        prodTest {
            autoUploadMap = false
            autoUploadNativeDebugSymbol = false
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodTest"
            env = "gray"
        }
        prodPublish {
            autoUploadMap = true
            autoUploadNativeDebugSymbol = true
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodPublish"
            env = "prod"
        }
    }
}
```

### Manual Upload

Use `plugin` to enable `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or pack into a `zip` file manually, then upload to `datakit` or from <<< custom_key.brand_name >>> Studio. It is recommended to use the `zip` command line for packing to avoid including system hidden files in the `zip` package. Refer to [symbol file upload](../sourcemap/set-sourcemap.md) for symbol uploading.

> For Unity Native Symbol files, refer to the [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
    HashMap<String, Object> globalContext = new HashMap<>();
    globalContext.put("delay_key", info.value);
    FTSdk.appendGlobalContext(globalContext);
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
    HashMap<String, Object> globalContext = new HashMap<>();
    globalContext.put("delay_key", info.value);
    FTSdk.appendGlobalContext(globalContext);
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if(agreeProtocol){
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
    HashMap<String, Object> globalContext = new HashMap<>();
    globalContext.put("delay_key", info.value);
    FTSdk.appendGlobalContext(globalContext);
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if (agreeProtocol) {
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if (agreeProtocol) {
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Symbol File Upload {#source_map}

### Plugin Upload (Supported only by datakit [local deployment])

The `ft-plugin` version needs to support the latest symbol file upload rules starting from version `1.3.0`, supporting `productFlavor` multi-version management. The plugin will execute symbol file upload after `gradle task assembleRelease`. Detailed configuration can be referenced in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

```groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, no need to configure if generateSourceMapOnly=true
    datawayToken = 'dataway_token' 		// space token, no need to configure if generateSourceMapOnly=true
    appId = "appid_xxxxx"				// appid, no need to configure if generateSourceMapOnly=true
    env = 'common'						// environment, no need to configure if generateSourceMapOnly=true
	generateSourceMapOnly = false // Only generate sourcemap, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, supported by ft-plugin:1.3.4 and above

    prodFlavors { // prodFlavors configuration overrides outer settings
        prodTest {
            autoUploadMap = false
            autoUploadNativeDebugSymbol = false
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodTest"
            env = "gray"
        }
        prodPublish {
            autoUploadMap = true
            autoUploadNativeDebugSymbol = true
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodPublish"
            env = "prod"
        }
    }
}
```

### Manual Upload

Use `plugin` to enable `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or pack into a `zip` file manually, then upload to `datakit` or from <<< custom_key.brand_name >>> Studio. It is recommended to use the `zip` command line for packing to avoid including system hidden files in the `zip` package. Refer to [symbol file upload](../sourcemap/set-sourcemap.md) for symbol uploading.

> For Unity Native Symbol files, refer to the [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
    HashMap<String, Object> globalContext = new HashMap<>();
    globalContext.put("delay_key", info.value);
    FTSdk.appendGlobalContext(globalContext);
}
```

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, for example `df_tag_name`. You can check the source code for `key` values used in the project [here](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables as RUM and Log, RUM and Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration

To better correlate data from the same user, the SDK uses Android ID. If you need to list your app in an app store, you need to handle market privacy reviews using the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to the privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed SDK Initialization

If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If already agreed to the protocol, initialize in Application
			if (agreeProtocol) {
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// Not read privacy statement
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();
	
			    // If agreed to the privacy statement
				if (agreeProtocol) {
					FTSdk.init(); // Pseudo-code for SDK initialization
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}

For `flutter`, `react-native`, and `unity`, a similar delayed initialization method can be used to handle app store privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file uploads.

Currently, we have an alternative integration solution for such scenarios, as follows:

* Application launch events should call `FTAutoTrack.startApp(null)` before initializing the SDK. Refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	// Application
	override fun onCreate() {
	    super.onCreate()
	    // Must be called before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For event handlers like button clicks, manually add them at the trigger location. For example, for a Button onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});
	```

=== "Kotlin"

	```kotlin
	view.setOnClickListener {
		FTRUMGlobalManager.get().startAction("[action button]", "click")
	}
	```

* For `OKhttp`, integrate `Resource` and `Trace` through `addInterceptor` and `eventListener`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* For other network frameworks, use `FTRUMGlobalManager` methods `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Permissions Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, impacts the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ignore_aop}

Through Plugin AOP covering methods, add `@IgnoreAOP` to ignore ASM insertion.

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IgnoreAOP {

        }
	```

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the visited page.

## Custom Tag Usage Example {#track}

### Compile-time Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish tags

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. In the `RUM` configuration, add corresponding `BuildConfig` constants

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… Add other configurations
	)
	```

### Runtime File Reading and Writing Method

1. Through file-type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to obtain tag data in the configuration section.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… Add other configurations
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	// Configure RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… Add other configurations
	)
	```

2. Add methods to change file data at any location.

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	    val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()
	}
	```

3. Finally, restart the application. Detailed instructions can be found in the [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After initializing the SDK, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained via network requests.

```java
// Pseudo-code for SDK initialization, set tags after obtaining parameters from the network

FTSdk.init();

getInfoFromNet(info){
    HashMap<String, Object> globalContext = new HashMap<>();
    globalContext.put("delay_key", info.value);
    FTSdk.appendGlobalContext(globalContext);
}
```

## Summary

This document provides detailed steps for integrating the Guance Android SDK into your application, including prerequisites, installation, configuration, and advanced features such as RUM, Trace, and Logger. Additionally, it covers best practices for handling common issues, adapting to market privacy reviews, and integrating without using `ft-plugin`. Follow these guidelines to ensure proper setup and optimal performance of the SDK in your Android application.