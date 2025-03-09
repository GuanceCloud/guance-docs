# Android Application Integration
---
<<< custom_key.brand_name >>> application monitoring can collect metrics data from various Android applications and analyze the performance of each Android application in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geographic information database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration}

Log in to the <<< custom_key.brand_name >>> console, enter the **User Access Monitoring** page, click on the top-left corner **[Create Application](../index.md#create)** to start creating a new application.

- <<< custom_key.brand_name >>> provides **public DataWay** for direct reception of RUM data without installing the DataKit collector. Configuring the `site` and `clientToken` parameters is sufficient.

![](../img/android_01.png)

- <<< custom_key.brand_name >>> also supports receiving RUM data via **local environment deployment**, which requires meeting the prerequisites.

![](../img/6.rum_android_1.png)


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the SDK remote repository address in the `build.gradle` file at the root directory of the project

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //Add SDK remote repository address
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //Add Plugin dependency, requiring AGP 7.4.2 or higher and Gradle 7.2.0 or higher
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP 7.4.2 or lower versions, use ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //Add SDK remote repository address
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
	        //Add SDK remote repository address
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
	        //Add SDK remote repository address
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//Add Plugin dependency, requiring AGP 7.4.2 or higher and Gradle 7.2.0 or higher
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		// For AGP 7.4.2 or lower versions, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* In the main module `app`'s `build.gradle` file, add the SDK dependency and `Plugin` usage along with Java 8 support

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency to capture native layer crash information, must be used with ft-sdk, cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended version, other versions have not been fully tested for compatibility
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

	// Native so specified path, only need to specify the upper directory of the abi file
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
	//... omitted part of the code
	defaultConfig {
        //... omitted part of the code
        ndk {
            //When using ft-native to capture native layer crashes, choose supported abi architectures based on the platform compatibility of the application.
            //Currently, ft-native includes abi architectures such as 'arm64-v8a',
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

> Check the latest versions above for ft-sdk, ft-plugin, and ft-native.

## Application Configuration {#application-setting}
Theoretically, the best place to initialize the SDK is in the `Application`'s `onCreate` method. If your application has not yet created an `Application`, you need to create one and declare it in `AndroidManifest.xml`. Refer to the example [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

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

			//Use public DataWay
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

			//Use public DataWay
			val config = FTSDKConfig.builder(datawayUrl, clientToken)

			FTSdk.install(config)
			//...
	    }
	}
    ```

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- | 
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, default port 9529, the device installing the SDK needs to be able to access this address. **Note: Choose either datakit or dataway configuration**|
| datawayUrl | String | Yes | Public Dataway access URL address, example: http://10.0.0.1:9528, default port 9528, the device installing the SDK needs to be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | String | Yes | Authentication token, needs to be configured with datawayUrl |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, logs will be printed when enabled |
| setEnv | EnvType | No | Set the collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set the collection environment, default is `prod`. **Note: Only configure one of String or EnvType types**|
| setOnlySupportMainProcess | Boolean | No | Whether to support running only in the main process, default is `true`, if you need to run in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable obtaining `Android ID`, default is `true`, set to `false` means the `device_uuid` field data will not be collected, refer to market privacy review related [here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add global attributes to the SDK, refer to the rules [here](#key-conflict) |
| setServiceName | String | No | Set the service name, affecting the `service` field data in Log and RUM, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable auto-sync, default is `true`. When set to `false`, use `FTSdk.flushSyncData()` to manage data synchronization manually |
| setSyncPageSize | Int | No | Set the number of entries per sync request, `SyncPageSize.MINI` 5 entries, `SyncPageSize.MEDIUM` 10 entries, `SyncPageSize.LARGE` 50 entries, default `SyncPageSize.MEDIUM` |
| setCustomSyncPageSize | Enum | No | Set the number of entries per sync request, range [5,), note that larger entry numbers mean more computing resources are required for data synchronization, default is 10 **Note: Only configure one of setSyncPageSize or setCustomSyncPageSize** |
| setSyncSleepTime | Int | No | Set the interval time between syncs, range [0,5000], default is not set |
| enableDataIntegerCompatible | Void | No | It is recommended to enable this when coexisting with web data. This configuration handles storage compatibility issues with web data types |
| setNeedTransformOldCache | Boolean | No | Whether to be compatible with old cache data from ft-sdk versions below 1.6.0, default is `false` |
| setCompressIntakeRequests | Boolean | No | Compress sync data, supported by ft-sdk versions 1.6.3 and above |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default is 100MB, unit Byte, larger databases increase disk pressure, default is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become ineffective. Supported by ft-sdk versions 1.6.6 and above |

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
| setRumAppId | String | Yes | Set the `Rum AppId`. Corresponding to setting the RUM `appid`, this will enable RUM data collection, [method to obtain appid](#android-integration) |
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Applies to all View, Action, LongTask, Error data within the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling this will display error stack trace data in error analysis.<br> [Regarding deobfuscation of obfuscated content in crash logs](#retrace-log).<br><br>For ft-sdk versions 1.5.1 and above, you can set whether to display logcat in Java Crash and Native Crash using `extraLogCatWithJavaCrash` and `extraLogCatWithNativeCrash` |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, adding additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery level, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, during the View lifecycle, add monitoring data, `DeviceMetricsMonitorType.BATTERY` monitors the highest output current on the current page, `DeviceMetricsMonitorType.MEMORY` monitors the application's memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU jumps, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring frequency, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>For ft-sdk versions 1.5.1 and above, you can set whether to display logcat in ANR using `extraLogCatWithANR` |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, for ft-sdk versions 1.6.4 and above, you can control the detection time range [100,) in milliseconds, default is 1 second |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user actions, currently only supports user startup and click actions, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically track user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Affects the default collection when `EnableTraceUserResource` is set to `true`. To enable this function for custom Resource collection, use `FTResourceEventListener.FTFactory(true)`. Additionally, single Okhttp has an IP cache mechanism for the same domain, where the IP remains unchanged for the same `OkhttpClient`, resulting in only one generation |
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default is no filtering |
| setOkHttpEventListenerHandler | Callback| No | ASM sets a global Okhttp EventListener, default is not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets a global `FTResourceInterceptor.ContentHandlerHelper`, default is not set, supported by ft-sdk versions 1.6.7 and above, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom tags to distinguish user monitoring data sources, if you need to use tracking features, the parameter `key` is `track_id` and `value` is any value, refer to the rules [here](#key-conflict) |
| setRumCacheLimitCount | int | No | Local cache RUM limit count [10_000,), default is 100_000. Supported by ft-sdk versions 1.6.6 and above |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set the discard rule for RUM data when it reaches the limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data, supported by ft-sdk versions 1.6.6 and above |

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
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level mapping<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning,<br> `prefix` is the filter parameter for the log prefix, default is no filter. Note: The volume of Android console logs is large, to avoid impacting application performance and wasting unnecessary resources, it is recommended to filter out valuable logs using `prefix` |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default is no filter |
| addGlobalContext | Dictionary | No | Add global attributes to logs, refer to the rules [here](#key-conflict) |
| setLogCacheLimitCount | Int | No | Local cache maximum log entry limit [1000,), larger logs mean greater disk cache pressure, default is 5000   |
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
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setTraceType | TraceType | No | Set the tracing type, default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if integrating with OpenTelemetry, please refer to the supported types and agent configurations |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic HTTP trace, currently only supports automatic tracing for OKhttp, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets a global `FTTraceInterceptor.HeaderHandler`, default is not set, supported by ft-sdk versions 1.6.8 and above, refer to [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition or manually use `FTRUMGlobalManager` to add these data, as shown below:

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
		 * @param property Extension properties
		 */
		public void addAction(String actionName, String actionType, HashMap<String, Object> property)

		 /**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration time
		 * @param property Extension properties
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
		 * @param property Extension properties
		 */
		fun addAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration time
		 * @param property Extension properties
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> `startAction` internally has an algorithm to calculate the duration, trying to associate nearby occurring Resource, LongTask, Error data during the calculation period, with a 100 ms frequent trigger protection. It is recommended to use this for user operation type data. If there is a need for frequent calls, use `addAction`, this data will not conflict with `startAction` and will not be associated with current Resource, LongTask, Error data.


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
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change will change to ft_value_change when stopView is called
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
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change will change to ft_value_change when stopView is called
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
		 * @param property  Additional attributes
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
	     * @param property  Additional attributes
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
	     * @param property  Additional attributes
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
	     * @param property  Additional attributes
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
	     * @param property  Additional attributes
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
		 * @param property  Additional attributes
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
		 * @param property  Additional attributes
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String,state: AppState, property: HashMap<String, Any>)

	```

#### Code Example

=== "Java"

	```java
	// Scenario 1:
	FSure, continuing from where we left off:

#### Code Example

=== "Java"

	```java
	// Scenario 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scenario 2: Delay recording occurred errors, this time is generally the time when the error occurred
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

	// Scenario 2: Delay recording occurred errors, this time is generally the time when the error occurred
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
	     * @param resourceId Resource Id
	     */
	    public void startResource(String resourceId)

	    /**
	     * Start resource
	     *
	     * @param resourceId Resource Id
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * Stop resource
	     *
	     * @param resourceId Resource Id
	     */
	    public void stopResource(String resourceId)

	    /**
	     * Stop resource
	         *
	     * @param resourceId Resource Id
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
	 * @param resourceId Resource Id
	 */
	fun startResource(resourceId: String)

	/**
	 * Start resource
	 *
	 * @param resourceId Resource Id
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * Stop resource
	 *
	 * @param resourceId Resource Id
	 */
	fun stopResource(resourceId: String)

	/**
	 * Stop resource
	 *
	 * @param resourceId Resource Id
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
	// Request starts
	FTRUMGlobalManager.get().startResource("resourceId");

	//...

	// Request ends
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


	// Scenario 2 : Using dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change will change to ft_value_change when stopResource is called
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// Scenario 1
	// Request starts
	FTRUMGlobalManager.get().startResource("resourceId")

	// Request ends
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

	// Scenario 2 : Using dynamic parameters
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)

	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change"
	)
	// ft_key_will_change will change to ft_value_change when stopResource is called

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
| ResourceParams.responseContentType | No | Response Content-Type | |
| ResourceParams.responseContentEncoding | No | Response Content-Encoding |  |
| ResourceParams.resourceMethod | No | Request method | GET, POST, etc. |
| ResourceParams.responseBody | No | Response body content | |
| ResourceParams.property| No | Additional properties |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, you need to enable `FTLoggerConfig.setEnableCustomLog(true)`
> Currently, log content is limited to 30 KB, and any exceeding part will be truncated.

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
		 * @param property Additional attributes
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
		 * @param property Additional attributes
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
	     * @param property Log attributes
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
	     * @param property Log attributes
	     */
	    fun logBackground(content: String, status: String, property: HashMap<String, Any>)

	    /**
	     * Store multiple log entries locally in sync
	     *
	     * @param logDataList List of log data
	     */
	    fun logBackground(logDataList: List<LogData>)

	```

#### Log Levels

| **Method Name** | **Description** |
| --- | --- |
| Status.DEBUG | Debug |
| Status.INFO | Info |
| Status.WARNING | Warning |
| Status.ERROR | Error |
| Status.CRITICAL | Critical |
| Status.OK | Recovery |

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

## Tracer Network Trace

Configure `FTTraceConfig` to enable `enableAutoTrace` to automatically add trace data or manually use `FTTraceManager` to add `Propagation Header` in Http requests, as shown below:

=== "Java"

	```java
	String url = "https://www.guance.com";
	String uuid = "uuid";
	// Get trace headers
	Map<String, String> headers = FTTraceManager.get().getTraceHeader(uuid, url);

	OkHttpClient client = new OkHttpClient.Builder().addInterceptor(chain -> {
	    Request original = chain.request();
	    Request.Builder requestBuilder = original.newBuilder();
	    // Add trace headers to the request
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
	// Get trace headers
	val headers = FTTraceManager.get().getTraceHeader(uuid, url)

	val client: OkHttpClient = OkHttpClient.Builder().addInterceptor { chain ->

	                    val original = chain.request()
	                    val requestBuilder = original.newBuilder()
	                    // Add trace headers to the request
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

## Custom Resource and TraceHeader via OKHttp Interceptor {#okhttp_resource_trace_interceptor_custom}

 Configuring `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`, if both are enabled, the custom `Interceptor` configuration has higher priority.
 > For ft-sdk < 1.4.1, you need to disable `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`.
 > For ft-sdk > 1.6.7, support associating custom Trace Header with RUM data.

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

				 // Supported by versions 1.6.7 and above
				  @Override
				  public String getSpanID() {
					return "span_id";
				 }
				// Supported by versions 1.6.7 and above
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
                       // Copy read partial body to avoid large data consumption
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
                // Copy partial response body to avoid large data consumption
                val body = response.peekBody(33554432)
                extraData["df_response_body"] = body.string()
            }
        }

        override fun onException(e: Exception, extraData: HashMap<String, Any>) {
            // Handle exception scenarios
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
| **Method Name** | **Description** | **Required** | **Note** |
| --- | --- | --- | --- |
| setId | Set user ID | No | |
| setName | Set username | No | |
| setEmail | Set email | No | |
| setExts | Set user extensions | No | Refer to the rules [here](#key-conflict)|

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
	userData.setExts(extMap)
	FTSdk.bindRumUserData(userData)

	// Call this method after user logout to unbind user information
	FTSdk.unbindRumUserData()
	```


## Shutdown SDK
Use `FTSdk` to shut down the SDK

### Usage Method
=== "Java"

	```java
	    /**
	     * Shut down running objects within the SDK
	     */
	    public static void shutDown()

	```

=== "Kotlin"


	``` kotlin
	    /**
	     * Shut down running objects within the SDK
	     */
	    fun shutDown()
	```

### Code Example
    
=== "Java"

	```java
	// If changing SDK configurations dynamically, shut down first to avoid incorrect data generation
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	// If changing SDK configurations dynamically, shut down first to avoid incorrect data generation
	FTSdk.shutDown()
	```

## Clear SDK Cache Data
Use `FTSdk` to clear unsent cache data

### Usage Method
=== "Java"

	```java
	    /**
		 * Clear unsent cache data
		 */
	    public static void clearAllData()

	```

=== "Kotlin"


	``` kotlin
	     /**
		  * Clear unsent cache data
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

## Active Data Sync
Use `FTSdk` to actively synchronize data.
> When `FTSdk.setAutoSync(false)` is set, manual data synchronization is required.

### Usage Method

=== "Java"

	```java
	   /**
	     * Actively synchronize data
	     */
	    public static void flushSyncData()
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Actively synchronize data
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

## Dynamically Enable or Disable AndroidID Acquisition
Use `FTSdk` to set whether to acquire Android ID within the SDK

### Usage Method

=== "Java"

	```java
	   /**
	     * Dynamically control Android ID acquisition
	     *
	     * @param enableAccessAndroidID true to enable, false to disable
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Dynamically control Android ID acquisition
	     *
	     * @param enableAccessAndroidID true to enable, false to disable
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

### ft-sdk library
-keep class com.ft.sdk.**{*;}

### ft-native library
-keep class ftnative.*{*;}

### Prevent Action names from being obfuscated when retrieving
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (only supports datakit【local deployment】)
The `ft-plugin` version needs to be 1.3.0 or higher to support the latest symbol file upload rules, supporting `productFlavor` multi-version management. The plugin will execute uploading symbol files after `gradle task assembleRelease`. Detailed configuration can be referenced from [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, no need to configure when generateSourceMapOnly=true
    datawayToken = 'dataway_token' 		// space token, no need to configure when generateSourceMapOnly=true
    appId = "appid_xxxxx"				// appid, no need to configure when generateSourceMapOnly=true
    env = 'common'						// environment, no need to configure when generateSourceMapOnly=true
	generateSourceMapOnly = false // Only generate sourcemap, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, supported by ft-plugin version 1.3.4 and above

    prodFlavors { //prodFlavors configuration overrides outer settings
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
Use `plugin` to set `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or package into a `zip` file yourself, then upload to `datakit` or upload from <<< custom_key.brand_name >>> Studio, recommended to use `zip` command line for packaging to avoid including system hidden files in the `zip` package. Refer to [symbol file upload](../sourcemap/set-sourcemap.md)

> Unity Native Symbol files please refer to [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Description

| **Name** | **Required** | **Reason for Use** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | To obtain device information of the phone for precise data analysis, affects the acquisition of cellular network information in the SDK |

> For details on how to request dynamic permissions, refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ingore_aop}
Add `@IngoreAOP` to methods covered by Plugin AOP to ignore ASM insertion

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
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the page accessed by WebView

## Custom Tag Usage Example {#track}

### Build Configuration Method

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

2. Add corresponding `BuildConfig` constants in RUM configuration

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
### Runtime Read/Write File Method

1. Through file type data storage, such as `SharedPreferences`, configure the use of `SDK` and add code to retrieve tag data in the configuration location.

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

3. Finally, restart the application, detailed steps can be found in [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After SDK initialization, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it will take effect immediately. Subsequent reported RUM or Log data will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained through network requests.

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
### Adding Local Variables to Avoid Conflict Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with the project abbreviation, such as `df_tag_name`. Project keys can be [queried from source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables have the same variable as RUM or Log, RUM or Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](https://docs.guance.com/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
To better associate data from the same user, the SDK uses Android ID. If you need to publish your app on an app market, you need to handle market privacy audits as follows.

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

	// Enable after user agrees to privacy policy
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

	// Enable after user agrees to privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```
#### Method 2: Delayed Initialization of SDK
If you need to delay loading the SDK in the application, it is recommended to initialize as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If agreement has been accepted, initialize in Application
			if(agreeProtocol) {
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// If privacy statement has not been read
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();

			    // If user agrees to privacy statement
				if(agreeProtocol) {
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
	        super.onCreate()
	        // If agreement has been accepted, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        super.onCreate(savedInstanceState)
	        // If privacy statement has not been read
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()

	            // If user agrees to privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}
For `flutter`, `react-native`, and `unity`, you can use a similar delayed initialization method as described above to handle app market privacy audits.

### How to Integrate SDK Without Using ft-plugin {#manual-set}
<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection, enabling automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. This affects **RUM** `Action`, `Resource`, and automatic capture of `android.util.Log` and Java/Kotlin `println` **console logs**, as well as automatic upload of symbol files.

Currently, for such situations, we have an alternative integration solution as follows:

* For Application launch events, refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Call before SDK initialization
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
		// Call before SDK initialization
	        FTAutoTrack.startApp(null)
	        // Set SDK configuration
	        setSDK(this)

	    }
	```

* For button click events, etc., add them manually at the trigger location. For example, adding `startAction` for a Button's onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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
		view.setOnClickListener{
			FTRUMGlobalManager.get().startAction("[action button]", "click")
		}
	```

* For `OKhttp`, integrate `Resource` and `Trace` via `addInterceptor` and `eventListener`. Example below, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* For other network frameworks, you need to implement `FTRUMGlobalManager`'s `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader` manually. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Common Issues {#FAQ}

### Adding Local Variables to Avoid Conflict Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with a project abbreviation, such as `df_tag_name`. Project keys can be [queried from source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables have the same variable as RUM or Log, RUM or Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](https://docs.guance.com/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration
To better associate data from the same user, the SDK uses Android ID. If you need to publish your app on an app market, you need to handle market privacy audits as follows.

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

	// Enable after user agrees to privacy policy
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

	// Enable after user agrees to privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

#### Method 2: Delayed Initialization of SDK
If you need to delay loading the SDK in the application, it is recommended to initialize as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If agreement has been accepted, initialize in Application
			if(agreeProtocol) {
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// If privacy statement has not been read
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();

			    // If user agrees to privacy statement
				if(agreeProtocol) {
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
	        super.onCreate()
	        // If agreement has been accepted, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        super.onCreate(savedInstanceState)
	        // If privacy statement has not been read
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()

	            // If user agrees to privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}
For `flutter`, `react-native`, and `unity`, you can use a similar delayed initialization method as described above to handle app market privacy audits.

### How to Integrate SDK Without Using ft-plugin {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection, enabling automatic data collection. However, due to compatibility issues, there may be cases where `ft-plugin` cannot be used. This affects **RUM** `Action`, `Resource`, and automatic capture of `android.util.Log` and Java/Kotlin `println` **console logs**, as well as automatic upload of symbol files.

Currently, for such situations, we have an alternative integration solution as follows:

* For Application launch events, refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Call before SDK initialization
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
	    // Call before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For button click events, etc., add them manually at the trigger location. For example, adding `startAction` for a Button's onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* For `OKhttp`, integrate `Resource` and `Trace` via `addInterceptor` and `eventListener`. Example below, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* For other network frameworks, you need to manually implement `FTRUMGlobalManager`'s `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

### Adding Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with a project abbreviation, such as `df_tag_name`. Project keys can be [queried from source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables have the same variable as RUM or Log, RUM or Log will overwrite the SDK's global variables.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible)

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}

#### Privacy Statement
[Go to view](https://docs.guance.com/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration
To better associate data from the same user, the SDK uses Android ID. If you need to publish your app on an app market, you need to handle market privacy audits as follows.

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

	// Enable after user agrees to privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        // Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig.builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)
	            .build()

	        FTSdk.install(config)

	        //...
	    }
	}

	// Enable after user agrees to privacy policy
	FTSdk.setEnableAccessAndroidID(true)
	```

#### Method 2: Delayed Initialization of SDK
If you need to delay loading the SDK in the application, it is recommended to initialize as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    // If agreement has been accepted, initialize in Application
			if(agreeProtocol) {
				FTSdk.init(); // Pseudo-code for SDK initialization
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			// If privacy statement has not been read
			if (notReadProtocol) {
			    // Show privacy statement dialog
				showProtocolView();

			    // If user agrees to privacy statement
				if(agreeProtocol) {
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
	        super.onCreate()
	        // If agreement has been accepted, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() // Pseudo-code for SDK initialization
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        super.onCreate(savedInstanceState)
	        // If privacy statement has not been read
	        if (notReadProtocol) {
	            // Show privacy statement dialog
	            showProtocolView()

	            // If user agrees to privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() // Pseudo-code for SDK initialization
	            }
	        }
	    }
	}
	```

#### Third-party Frameworks {#third-party}
For `flutter`, `react-native`, and `unity`, you can use a similar delayed initialization method as described above to handle app market privacy audits.

### Not Using ft-plugin Integration Method {#manual-set}

<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection, thereby enabling automatic data collection. However, due to some compatibility issues, there may be cases where `ft-plugin` cannot be used. This affects **RUM** `Action`, `Resource`, and automatic capture of `android.util.Log` and Java/Kotlin `println` **console logs**, as well as automatic upload of symbol files.

Currently, for such cases, we have another integration solution as follows:

* Application launch events, refer to the source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Call before SDK initialization
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
	    // Call before SDK initialization
	    FTAutoTrack.startApp(null)
	    // Set SDK configuration
	    setSDK(this)
	}
	```

* For button click events, etc., add them manually at the trigger location. For example, adding `startAction` for a Button's onClick event, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* For `OKhttp`, integrate `Resource` and `Trace` via `addInterceptor` and `eventListener`. Example below, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* For other network frameworks, you need to manually implement using `FTRUMGlobalManager`'s `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. Refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).

## Summary

This document provides comprehensive guidance on integrating <<< custom_key.brand_name >>> SDK into Android applications, covering prerequisites, installation, initialization, RUM configuration, log configuration, trace configuration, and more. It also includes sections on handling privacy audits, manual SDK integration without `ft-plugin`, and common issues. By following these steps, developers can effectively monitor and analyze their Android applications using <<< custom_key.brand_name >>>.

Feel free to reach out if you have any further questions or need additional assistance!