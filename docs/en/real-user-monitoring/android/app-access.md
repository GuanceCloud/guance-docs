# Android Application Integration
---

By collecting metrics data from Android applications, analyze application performance in a visualized manner.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been enabled, the prerequisites have been automatically configured, and you can directly connect the application.

- Install [DataKit](../../datakit/datakit-install.md);  
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit is configured to be [publicly accessible on the internet and IP geographical information database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration} 

1. Go to **User Analysis > Create Application > Android**;
2. Enter the application name;
3. Input the application ID;
4. Select the application integration method:

    - Public DataWay: Directly receives RUM data without installing the DataKit collector.  
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the remote repository address of the `SDK` in the `build.gradle` file at the root directory of the project

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //Add the remote repository address of the SDK
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //Add the plugin dependency for AGP 7.4.2 or higher and Gradle 7.2.0 or higher
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP versions below 7.4.2, use ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //Add the remote repository address of the SDK
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
	        //Add the remote repository address of the SDK
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
	        //Add the remote repository address of the SDK
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//Add the plugin dependency for AGP 7.4.2 or higher and Gradle 7.2.0 or higher
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		// For AGP versions below 7.4.2, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* Add `SDK` dependencies and `Plugin` usage as well as Java 8 support in the `build.gradle` file of the main module `app` of the project

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency to capture native layer crash information, needs to be used with ft-sdk and cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended to use this version; other versions have not undergone sufficient compatibility testing
    implementation 'com.google.code.gson:gson:2.8.5'

}
//Apply the plugin
apply plugin: 'ft-plugin'   //If using legacy version compatible ft-plugin-legacy, no changes needed
//Configure plugin parameters
FTExt {
    //Whether to display Plugin logs, default is false
    showLog = true
	
    //Set ASM version, supports asm7 - asm9, default is asm9
    //asmVersion='asm7'

    //ASM ignore path configuration, paths are equivalent with . and /
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
	//... Omitted part of the code
	defaultConfig {
        //... Omitted part of the code
        ndk {
            //When using ft-native to capture native layer crash information, choose supported abi architectures based on the application's compatibility with different platforms.
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

> Latest versions can be found above under ft-sdk, ft-plugin, and ft-native version names

## Application Configuration {#application-setting}

Theoretically, the best place for SDK initialization is in the `onCreate` method of `Application`. If your application has not yet created an `Application`, you need to create one and declare it in `AndroidManifest.xml`. Example reference [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

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

| **Method Name** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- | 
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, default port 9529, the device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration**|
| datawayUrl | String | Yes | Public Dataway access URL address, example: http://10.0.0.1:9528, default port 9528, the device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | String | Yes | Authentication token, needs to be configured simultaneously with datawayUrl  |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, enabling it will allow printing of SDK runtime logs |
| setEnv | EnvType | No | Set the collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set the collection environment, default is `prod`. **Note: Only configure one of String or EnvType types**|
| setOnlySupportMainProcess | Boolean | No | Whether to only run in the main process, default is `true` , if execution is required in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable getting `Android ID`, default is `true`, setting it to `false` will prevent the `device_uuid` field from being collected, market privacy audit related [view here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add SDK global attributes, refer to [here](#key-conflict) for addition rules |
| setServiceName | String | No | Set the service name, affects the `service` field data in Logs and RUM, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable automatic synchronization, default is `true`. When set to `false`, use `FTSdk.flushSyncData()` to manage data synchronization manually |  
| setSyncPageSize | Int | No | Set the number of items per sync request, `SyncPageSize.MINI` 5 items, `SyncPageSize.MEDIUM` 10 items, `SyncPageSize.LARGE` 50 items, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set the number of items per sync request, range [5,), note that the larger the number of items, the more computational resources will be consumed by data synchronization, default is 10 **Note: Only configure one of setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set the interval time for synchronization, range [0,5000], default is not set  |
| enableDataIntegerCompatible | Void | No | Suggested to enable when coexisting with web data. This configuration handles storage compatibility issues with web data types. Version 1.6.9 defaults to enabling this |
| setNeedTransformOldCache | Boolean | No | Whether to need compatibility with old cache data from versions below ft-sdk 1.6.0, default is `false` |
| setCompressIntakeRequests | Boolean | No | Compress sync data, ft-sdk version 1.6.3 and above supports this method |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default is 100MB, unit Byte, the larger the database, the greater the disk pressure, default is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become invalid. ft-sdk version 1.6.6 and above supports this method |

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


| **Method Name** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| setRumAppId | String | Yes | Set `Rum AppId`. Corresponds to setting the RUM `appid`, enabling the RUM collection function, [method to obtain appid](#android-integration) |
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data within the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling it will display error stack data in error analysis.<br> [Regarding the conversion of obfuscated content in crash logs](#retrace-log).<br><br>ft-sdk version 1.5.1 and above, through `extraLogCatWithJavaCrash`, `extraLogCatWithNativeCrash` settings can be made to display logcat in Java Crash and Native Crash|
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, add additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery level, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU usage |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, add monitoring data during the View cycle, `DeviceMetricsMonitorType.BATTERY` monitors the highest output current on the current page, `DeviceMetricsMonitorType.MEMORY` monitors the current application memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU fluctuations, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring frequency, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>ft-sdk version 1.5.1 and above, through `extraLogCatWithANR` settings can be made to display logcat in ANR |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, ft-sdk version 1.6.4 and above can control the detection time range [100,) in milliseconds, default is 1 second |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user operations, currently only supports user startup and click operations, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically trace user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Scope: Only affects default collection when `EnableTraceUserResource` is set to true. For custom Resource collection, use `FTResourceEventListener.FTFactory(true)` to enable this feature. Additionally, Okhttp caches IPs for the same domain, so with the same `OkhttpClient`, if the connection to the server IP does not change, only one generation occurs |
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default is no filtering |
| setOkHttpEventListenerHandler | Callback| No | ASM sets a global Okhttp EventListener, default is not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets a global `FTResourceInterceptor.ContentHandlerHelper`, default is not set, ft-sdk version 1.6.7 and above supports, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom tags for distinguishing user monitoring data sources. If tracking functionality is needed, the parameter `key` should be `track_id`, `value` should be any numerical value, refer to [here](#key-conflict) for attention points regarding addition rules |
| setRumCacheLimitCount | int | No | Local cache RUM limit count [10_000,), default is 100_000. ft-sdk version 1.6.6 and above supports |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set the discard rule for data exceeding the RUM limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data, ft-sdk version 1.6.6 and above supports  |

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

| **Method Name** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level correspondence<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning, <br> `prefix` is the control prefix filter parameter, default is no filter setting. Note: Android console volume is large, to avoid affecting application performance and reducing unnecessary resource waste, suggest using `prefix` to filter out valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default is no setting |
| addGlobalContext | Dictionary | No | Add log global attributes, refer to [here](#key-conflict) for addition rules |
| setLogCacheLimitCount | Int | No | Local cache maximum log entry limit [1000,), the larger the log, the greater the disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set log discard rule for logs exceeding the limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data |

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

| **Method Name** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setTraceType | TraceType | No | Set the type of trace, default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if accessing OpenTelemetry, please consult supported types and agent configurations when selecting the corresponding trace type |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic HTTP trace, currently only supports automatic tracing for OKhttp, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets a global `FTTraceInterceptor.HeaderHandler`, default is not set, ft-sdk version 1.6.8 and above supports, example reference [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition effects or manually use `FTRUMGlobalManager` to add these data, examples are as follows:

### Action

#### Usage Method

=== "Java"

	```java

	    /**
	     * Add Action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     * @param property   Additional attribute parameters (optional)
	     */
	    public void startAction(String actionName, String actionType, HashMap<String, Object> property)


		 /**
		 * Add Action, this kind of data cannot be associated with Error, Resource, LongTask data
	     *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration (optional)
		 * @param property Expansion attribute (optional)
		 */
		public void addAction(String actionName, String actionType, long duration, HashMap<String, Object> property) 
    

	```

=== "Kotlin"

	```kotlin

		/**
	     * Add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     * @param property   Additional attribute parameters (optional)
	     */
	    fun startAction(actionName: String, actionType: String, property: HashMap<String, Any>)


		/**
		 * Add Action
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration (optional)
		 * @param property Expansion attribute (optional)
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> `startAction` internally calculates timing algorithms, during which it attempts to associate nearby occurring Resource, LongTask, Error data. There is a protection against frequent triggering every 100 ms, suggesting its use for user operation type data. If there is a need for frequent calls, use `addAction`, this data will not conflict with `startAction` and will not associate with current Resource, LongTask, Error data


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
	     * View start
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters (optional)
	     */
	    public void startView(String viewName, HashMap<String, Object> property)


	    /**
	     * View end
	     *
	     * @param property Additional attribute parameters (optional)
	     */
	    public void stopView(HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin

		 /**
	     * View start
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters (optional)
	     */

		fun startView(viewName: String, property: HashMap<String, Any>)


		 /**
	     * View end
	     *
	     * @param property Additional attribute parameters (optional)
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
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be modified to ft_value_change when stopView
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
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change this value will be modified to ft_value_change when stopView
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
	     * @param errorType Error type, ErrorType
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds (optional)
	     * @param property  Additional attributes (optional)
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType,
	                         AppState state, HashMap<String, Object> property)
	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type, String
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds (optional)
	     * @param property  Additional attributes (optional)
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
	     * @param errorType Error type, ErrorType
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds (optional)
		 * @param property  Additional attributes (optional)
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType,state: AppState, property: HashMap<String, Any>)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type, String
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds (optional)
		 * @param property  Additional attributes (optional)
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String,state: AppState, property: HashMap<String, Any>)

	```

#### Code Example

=== "Java"

	```java
	// Scenario 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scenario 2: Delay recording occurred errors, generally the time when the error occurs
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000L, ErrorType.JAVA, AppState.RUN);

	// Scenario 3：Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN, map);
	```

=== "Kotlin"

	```kotlin

	// Scenario 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN)

	// Scenario 2: Delay recording occurred errors, generally the time when the error occurs
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000, ErrorType.JAVA, AppState.RUN)

	// Scenario 3：Dynamic parameters
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
		 * @param property   Additional attribute parameters (optional)
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
		 * @param property   Additional attribute parameters (optional)
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
	     * Resource start
	     *
	     * @param resourceId Resource Id
		 * @param property   Additional attribute parameters (optional)
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * Resource termination
	     *
	     * @param resourceId Resource Id
	     * @param property   Additional attribute parameters (optional)
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
	 * Resource start
	 *
	 * @param resourceId Resource Id (optional)
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>)


	/**
	 * Resource termination
	 *
	 * @param resourceId Resource Id
	 * @param property   Additional attribute parameters (optional)
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

	// Finally, send request-related data indicators after the request ends
	ResourceParams params = new ResourceParams();
	params.setUrl("https://<<< custom_key.brand_main_domain >>>");
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


	// Scenario 2 ：Using dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be modified to ft_value_change when stopResource
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// Scenario 1
	//Request starts
	FTRUMGlobalManager.get().startResource("resourceId")

	//Request ends
	FTR```kotlin
UMGlobalManager.get().stopResource("resourceId")

//Finally, send request-related data indicators after the request ends
val params = ResourceParams()
params.url = "https://<<< custom_key.brand_main_domain >>>"
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
FTRUMGlobalManager.get().addResource("resourceId", params, bean)

//Scenario 2: Using dynamic parameters
val map = hashMapOf<String, Any>(
        "ft_key" to "ft_value",
        "ft_key_will_change" to "ft_value"
)
FTRUMGlobalManager.get().startResource("resourceId", map)

//...
val map = hashMapOf<String, Any>(
        "ft_key_will_change" to "ft_value_change"
)
//ft_key_will_change this value will be modified to ft_value_change when stopResource

FTRUMGlobalManager.get().stopResource(uuid, map)

```

| **Method Name** | **Required** | **Meaning** | **Description** |
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
| NetStatusBean.property| No | Additional attributes | |
| ResourceParams.url | Yes | URL address | |
| ResourceParams.requestHeader | No | Request header parameters |  |
| ResourceParams.responseHeader | No | Response header parameters |  |
| ResourceParams.responseConnection | No | Response connection | |
| ResourceParams.responseContentType | No | Response ContentType | |
| ResourceParams.responseContentEncoding | No | Response ContentEncoding |  |
| ResourceParams.resourceMethod | No | Request method | GET, POST etc. |
| ResourceParams.responseBody | No | Returned body content | |
| ResourceParams.property| No | Additional attributes |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, requiring enabling `FTLoggerConfig.setEnableCustomLog(true)`
> Current log content limit is 30 KB, exceeding characters will be truncated.

### Usage Method

=== "Java"

	```java

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level, enum Status
		 * @param property Additional attributes (optional)
	     */
	    public void logBackground(String content, Status status, HashMap<String, Object> property)

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level, String
		 * @param property Additional attributes (optional)
	     */
	    public void logBackground(String content, String status, HashMap<String, Object> property)

	    /**
	     * Store multiple log data locally for synchronization
	     *
	     * @param logDataList {@link LogData} list
	     */
	    public void logBackground(List<LogData> logDataList)

	```

=== "Kotlin"

	```kotlin

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log attributes (optional)
	     */
	    fun logBackground(content: String, status: Status, property: HashMap<String, Any>)


	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log attributes (optional)
	     */
	    fun logBackground(content: String, status: String, property: HashMap<String, Any>)

	    /**
	     * Store multiple log data locally for synchronization
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
| Status.OK | Recovered |

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
	//Upload a single log
	FTLogger.getInstance().logBackground("test", Status.INFO)

	//Pass parameters to HashMap
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTLogger.getInstance().logBackground("test", Status.INFO,map)

	//Batch upload logs
	FTLogger.getInstance().logBackground(mutableListOf(LogData("test",Status.INFO)))
	```

## Tracer Network Trace Link

Configure `FTTraceConfig` to enable `enableAutoTrace` to automatically add trace data or manually use `FTTraceManager` in HTTP requests with `Propagation Header`, as follows:

=== "Java"

	```java
	String url = "https://<<< custom_key.brand_main_domain >>>";
	String uuid = "uuid";
	// Get trace header parameters
	Map<String, String> headers = FTTraceManager.get().getTraceHeader(uuid, url);

	OkHttpClient client = new OkHttpClient.Builder().addInterceptor(chain -> {
	    Request original = chain.request();
	    Request.Builder requestBuilder = original.newBuilder();
	    // Add trace header parameters in the request
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
	val url = "https://<<< custom_key.brand_main_domain >>>"
	val uuid ="uuid"
	//Get trace header parameters
	val headers = FTTraceManager.get().getTraceHeader(uuid, url)

	val client: OkHttpClient = OkHttpClient.Builder().addInterceptor { chain ->

	                    val original = chain.request()
	                    val requestBuilder = original.newBuilder()
	                    //Add trace header parameters in the request
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

When both `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace` configurations are enabled, custom `Interceptor` configurations have priority.
> For ft-sdk versions < 1.4.1, disable `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`.
> For ft-sdk versions > 1.6.7, support associating custom Trace Headers with RUM data

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

				 // Supported in versions 1.6.7 and above
				  @Override
				  public String getSpanID() {
					return "span_id";
				 }
				// Supported in versions 1.6.7 and above
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
                       // Copy part of the body to avoid consuming large data
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
            // Handle exception situation
        }
    }))
    .eventListenerFactory(FTResourceEventListener.FTFactory())
    .build()
	```

## Binding and Unbinding User Information {#userdata-bind-and-unbind}
Use `FTSdk` for binding and unbinding user information 

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
| **Method Name** | **Meaning** | **Required** | **Description** |
| --- | --- | --- | --- |
| setId | Set user ID | No | |
| setName | Set username | No | |
| setEmail | Set email | No | |
| setExts | Set user extensions | No | Refer to [here](#key-conflict) for addition rules|

### Code Example

=== "Java"

	```java
	// You can call this method after successful user login to bind user information
	FTSdk.bindRumUserData("001");

	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);

	// You can call this method after user logout to unbind user information
	FTSdk.unbindRumUserData();

	```

=== "Kotlin"

	```kotlin
	//You can call this method after successful user login to bind user information
	FTSdk.bindRumUserData("001")


	//Bind more user data
	val userData = UserData()
	userData.name = "test.user"
	userData.id = "test.id"
	userData.email = "test@mail.com"
	val extMap = HashMap<String, String>()
	extMap["ft_key"] = "ft_value"
	userData.setExts(extMap)
	FTSdk.bindRumUserData(userData)

	//You can call this method after user logout to unbind user information
	FTSdk.unbindRumUserData()
	```


## Closing SDK
Use `FTSdk` to close the SDK 

### Usage Method
=== "Java"

	```java
	    /**
	     * Close running objects within the SDK
	     */
	    public static void shutDown()

	```

=== "Kotlin"


	``` kotlin
	    /**
	     * Close running objects within the SDK
	     */
	    fun shutDown()
	```

### Code Example
    
=== "Java"

	```java
	//If dynamically changing SDK configuration, need to close first to avoid incorrect data generation
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	//If dynamically changing SDK configuration, need to close first to avoid incorrect data generation
	FTSdk.shutDown()
	```

## Clearing Cached Data in SDK
Use `FTSdk` to clear uncaptured cached data 

### Usage Method
=== "Java"

	```java
	    /**
		 * Clear uncaptured cached data
		 */
	    public static void clearAllData()

	```

=== "Kotlin"


	``` kotlin
	     /**
		  * Clear uncaptured cached data
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

## Actively Synchronizing Data
Use `FTSdk` to actively synchronize data.
> FTSdk.setAutoSync(false) requires manual data synchronization

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



## Dynamically Enable or Disable Getting AndroidID
Use `FTSdk` to set whether to get Android ID in the SDK

### Usage Method

=== "Java"

	```java
	   /**
	     * Dynamically control getting Android ID
	     *
	     * @param enableAccessAndroidID Apply if true, do not apply if false
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Dynamically control getting Android ID
	     *
	     * @param enableAccessAndroidID Apply if true, do not apply if false
	     */
	    fun setEnableAccessAndroidID(enableAccessAndroidID:Boolean)
	```

### Code Example

=== "Java"

	```java
	// Enable getting Android ID
	FTSdk.setEnableAccessAndroidID(true);

	// Disable getting Android ID
	FTSdk.setEnableAccessAndroidID(false);
	```

=== "Kotlin"

	```kotlin
	//Enable getting Android ID
	FTSdk.setEnableAccessAndroidID(true)

	//Disable getting Android ID
	FTSdk.setEnableAccessAndroidID(false)
	```

## Adding Custom Tags

Use `FTSdk` to dynamically add tags while the SDK is running

### Usage Method

=== "Java"

	```java
	/**
	 * Dynamically set global tag
	 * @param globalContext
	 */
	public static void appendGlobalContext(HashMap<String,Object> globalContext)

	/**
	 * Dynamically set RUM global tag
	 * @param globalContext
	 */
	public static void appendRUMGlobalContext(HashMap<String,Object> globalContext)

	/**
	 * Dynamically set log global tag
	 * @param globalContext
	 */
	public static void appendLogGlobalContext(HashMap<String,Object> globalContext)

	```

=== "Kotlin"

	```kotlin
	/**
	 * Dynamically set global tag
	 * @param globalContext
	 */
	fun appendGlobalContext(globalContext: HashMap<String, Any>) 

	/**
	 * Dynamically set RUM global tag
	 * @param globalContext
	 */
	fun appendRUMGlobalContext(globalContext: HashMap<String, Any>) 

	/**
	 * Dynamically set log global tag
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

### Prevent Action from obfuscating action_name during acquisition###
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (Only supports datakit【local deployment】)
`ft-plugin` version needs to be `1.3.0` or higher to support the latest symbol file upload rules, supporting `productFlavor` multi-version management. The plugin executes symbol file upload after `gradle task assembleRelease`. Detailed configurations can refer to [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, generateSourceMapOnly=true does not require configuration
    datawayToken = 'dataway_token' 		// space token, generateSourceMapOnly=true does not require configuration
    appId = "appid_xxxxx"				// appid, generateSourceMapOnly=true does not require configuration
    env = 'common'						// environment, generateSourceMapOnly=true does not require configuration
	generateSourceMapOnly = false //only generate sourcemap, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, ft-plugin:1.3.4 and above versions support

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
Use `plugin` to enable `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or package into a `zip` file yourself, then upload to `datakit` or from <<< custom_key.brand_name >>> Studio, recommend using `zip` command line for packaging to avoid including some system hidden files in the `zip` package. Symbol upload refers to [sourcemap upload](../sourcemap/set-sourcemap.md)

> Unity Native Symbol files refer to [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Explanation

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise analysis of data information, affects cellular network information acquisition in the SDK |

> Regarding how to request dynamic permissions, refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignore {#ingore_aop}
Through Plugin AOP method coverage, add `@IngoreAOP` to ignore ASM insertion

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
For WebView data monitoring, integrate the [Web Monitoring SDK](../web/app-access.md) in the pages accessed by WebView

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

2. Add corresponding `BuildConfig` constants in `RUM` configuration

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

1. Use file-type data storage, such as `SharedPreferences`, configure `SDK` usage, and add code to obtain tag data at the configuration location.

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

	//Configure RUM
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

3. Finally restart the application, detailed details please see [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After the SDK initialization is complete, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, it takes effect immediately. Subsequently, RUM or Log data reported will automatically add tag data. This usage method suits scenarios where tag data needs to be obtained with network requests later.

```java
//SDK initialization pseudocode, set tags after obtaining parameters from the network

FTSdk.init() 

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}

```


## Common Issues {#FAQ}
### Add Local Variables to Avoid Conflict Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix tags with a **project abbreviation**, such as `df_tag_name`. In the project, you can [query source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java) for `key` values. When global variables in the SDK appear identical to RUM, Log variables, RUM, Log will overwrite the global variables in the SDK.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
The SDK uses Android ID better to associate data from the same user. If you need to list your app on the market, you need to handle market privacy audits through the following methods.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false during initialization setup
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

	        //Set setEnableAccessAndroidID to false during initialization setup
	        val config = FTSDKConfig
	            .builder(DATAKIT_URL)
	            .setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	//Enable after user agrees to privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```
#### Method 2: Delay Initialization of SDK
If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    //If already agreed to protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); //SDK initialization pseudocode
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			//Not read privacy statement
			if ( notReadProtocol ) {
			    //Show privacy statement dialog
				showProtocolView();
	
			    //If agree to privacy statement
				if( agreeProtocol ){
					FTSdk.init(); //SDK initialization pseudocode
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
	        // If already agreed to protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() //SDK initialization pseudocode
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
	
	            // If agree to privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() //SDK initialization pseudocode
	            }
	        }
	    }
	}
	```
#### Third-party Frameworks {#third-party}
`flutter`, `react-native`, `uni-app`, `unity` can adopt similar native Android delayed initialization methods to handle market privacy audits.

### Jetpack Compose Support {#compose-support}
Currently, there is no automatic collection support for compose components generated pages. However, you can manually track click events and page navigation events using the custom interfaces for `Action` and `View`, refer to [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/compose/MainScreen.kt)

### How to Integrate SDK Without Using ft-plugin {#manual-set}
<<< custom_key.brand_name >>> uses Androig Grale Plugin Transformation to achieve code injection, thereby realizing automatic data collection. However, due to some compatibility issues, there may be situations where `ft-plugin` cannot be used. Affected include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log automatic capture**, and automatic upload of symbol files.

Currently, we have another integration solution for such situations:

* Application launch event, refer to source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Needs to be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    //Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	  //Application
	    override fun onCreate() {
	        super.onCreate()
		//Needs to be called before SDK initialization
	        FTAutoTrack.startApp(null)
	        //Set SDK configuration
	        setSDK(this)

	    }
	```

* Events like button clicks need to be added manually at the trigger location, for example, Button onClick event, refer to source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* `OKhttp` connects `Resource` and `Trace` through `addInterceptor`, `eventListener`, refer to the following example, source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* Other network frameworks need to implement `FTRUMGlobalManager`'s `startResource`, `stopResource`, `addResource`, `FTTraceManager.getTraceHeader` manually. For specific implementation methods, refer to source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt)</translated_content>
```