# Android Application Integration
---
Guance application monitoring can collect metrics data from various Android applications and analyze the performance of each Android application end in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration}

Log in to the Guance console, go to the **User Analysis** page, click on the top-left **[Create New Application](../index.md#create)** to start creating a new application.

- Guance provides **public DataWay** to receive RUM data directly without installing the DataKit collector. Configuring `site` and `clientToken` parameters is sufficient.

![](../img/android_01.png)

- Guance also supports receiving RUM data through **local environment deployment**, which requires meeting the prerequisites.

![](../img/6.rum_android_1.png)


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.guance.com/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

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
	        //Add Plugin dependency, dependent on AGP 7.4.2 or higher, Gradle 7.2.0 or higher
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
		//Add Plugin dependency, dependent on AGP 7.4.2 or higher, Gradle 7.2.0 or higher
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		//For AGP versions below 7.4.2, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* Add the `SDK` dependency and `Plugin` usage, as well as Java 8 support in the `build.gradle` file of the main module `app` of the project

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency to capture native layer crash information, must be used with ft-sdk, cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended to use this version, other versions have not been fully compatibility tested
    implementation 'com.google.code.gson:gson:2.8.5'

}
//Apply plugin
apply plugin: 'ft-plugin'
//Configure plugin usage parameters
FTExt {
    //Whether to display Plugin logs, default is false
    showLog = true
	
    //Set ASM version, supports asm7 - asm9, default is asm9
    //asmVersion='asm7'

    //ASM ignore path configuration, paths with . and / are equivalent
    //ignorePackages=['com.ft','com/ft']

	//Native so specified path, just need to specify the upper directory of the abi files
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
            //When using ft-native to capture native layer crash information, should choose supported abi architectures based on different platforms the application adapts to
            //Currently ft-native includes abi architectures 'arm64-v8a',
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

> Check the latest version above for ft-sdk, ft-plugin, and ft-native versions

## Application Configuration {#application-setting}
Theoretically, the best place to initialize the SDK is in the `onCreate` method of `Application`. If your application has not yet created an `Application`, you need to create one and declare it in `AndroidManifest.xml`. Refer to [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml) for an example.

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

| **Method Name** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- | 
| datakitUrl | String | Yes | Datakit access URL, example: http://10.0.0.1:9529, port defaults to 9529, the device where SDK is installed needs to be able to access this address. **Note: either datakit or dataway configuration is chosen**|
| datawayUrl | String | Yes | Public Dataway access URL, example: http://10.0.0.1:9528, port defaults to 9528, the device where SDK is installed needs to be able to access this address. **Note: either datakit or dataway configuration is chosen** |
| clientToken | String | Yes | Authentication token, must be configured along with datawayUrl  |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, enabling this allows printing SDK runtime logs |
| setEnv | EnvType | No | Set collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set collection environment, default is `prod`. **Note: only configure one of String or EnvType**|
| setOnlySupportMainProcess | Boolean | No | Whether to only support running in the main process, default is `true`, if you need to execute in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable getting `Android ID`, default is `true`, setting to `false` will prevent the `device_uuid` field from being collected, refer to market privacy audit related [here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add global properties for the SDK, refer to rules [here](#key-conflict) |
| setServiceName | String | No | Set service name, affects the `service` field data in Log and RUM, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable auto synchronization, default is `true`. When set to false, use `FTSdk.flushSyncData()` to manage data synchronization yourself |  
| setSyncPageSize | Int | No | Set the number of entries per sync request, `SyncPageSize.MINI` 5 entries, `SyncPageSize.MEDIUM` 10 entries, `SyncPageSize.LARGE` 50 entries, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set the number of entries per sync request, range [5,), note that the larger the number of entries requested, the more computing resources it consumes, default is 10 **Note: only configure one of setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set the interval between sync requests, range [0,5000], default is not set  |
| enableDataIntegerCompatible | Void | No | It is recommended to enable this when coexisting with web data. This configuration handles storage compatibility issues with web data types  |
| setNeedTransformOldCache | Boolean | No | Whether to support synchronizing old cache data from versions of ft-sdk below 1.6.0, default is false |
| setCompressIntakeRequests | Boolean | No | Compress sync data, supported by ft-sdk 1.6.3 and above |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default is 100MB, unit is byte, larger databases increase disk pressure. Supported by ft-sdk 1.6.6 and above |

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
| setRumAppId | String | Yes | Set `Rum AppId`. Corresponds to setting the RUM `appid`, which enables the RUM collection function, [method to get appid](#android-integration) |
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling this will display error stack trace data in error analysis.<br> [Regarding conversion of obfuscated content in crash logs](#retrace-log).<br><br>For ft-sdk 1.5.1 and above, you can set whether to display logcat in Java Crash and Native Crash using `extraLogCatWithJavaCrash` and `extraLogCatWithNativeCrash` |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, adding additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery level, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, during the View lifecycle, add monitoring data, `DeviceMetricsMonitorType.BATTERY` monitors the highest output current of the current page, `DeviceMetricsMonitorType.MEMORY` monitors the current application's memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU frequency, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring cycle, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>For ft-sdk 1.5.1 and above, you can set whether to display logcat in ANR using `extraLogCatWithANR` |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, for ft-sdk 1.6.4 and above you can control the detection time range [100,) in milliseconds, default is 1 second  |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user actions, currently only supports user launch and click actions, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically track user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the target domain of the request. Scope: only affects the default collection when `EnableTraceUserResource` is true. For custom Resource collection, use `FTResourceEventListener.FTFactory(true)` to enable this feature. Additionally, a single Okhttp has an IP cache mechanism for the same domain, so only one instance will be generated as long as the IP does not change for the same `OkhttpClient` |
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default does not filter |
| setOkHttpEventListenerHandler | Callback| No | ASM set global Okhttp EventListener, default is not set |
| setOkHttpResourceContentHandler | Callback| No | ASM set global `FTResourceInterceptor.ContentHandlerHelper`, default is not set, supported by ft-sdk 1.6.7 and above, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom tags to distinguish user monitoring data sources, if tracking function is needed, parameter `key` is `track_id`, `value` can be any value, refer to rules [here](#key-conflict) |
| setRumCacheLimitCount | int | No | Local cache limit count for RUM [10000,), default is 100_000. Supported by ft-sdk 1.6.6 and above |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set discard rule for data when RUM reaches its limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards added data, `DISCARD_OLDEST` discards old data, supported by ft-sdk 1.6.6 and above |

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
| setSampleRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level mapping<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning, <br> `prefix` is the filtering parameter for the log prefix, default does not set filtering. Note: Android console volume is large, to avoid affecting application performance and reduce unnecessary resource waste, it is recommended to use `prefix` to filter out valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default does not set |
| addGlobalContext | Dictionary | No | Add global properties for logs, refer to rules [here](#key-conflict) |
| setLogCacheLimitCount | Int | No | Maximum number of log entries cached locally [1000,), larger logs mean greater disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set discard rule for logs when they reach their limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards added data, `DISCARD_OLDEST` discards old data |

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
| setSampleRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setTraceType | TraceType | No | Set the type of tracing, default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if integrating with OpenTelemetry, please check the supported types and agent configurations when choosing the corresponding trace type |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic HTTP trace, currently only supports automatic tracing for OKhttp, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM set global `FTTraceInterceptor.HeaderHandler`, default is not set, supported by ft-sdk 1.6.8 and above, example reference [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data collection or manually use `FTRUMGlobalManager` to add these data, as shown below:

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
		 * @param property Extension attributes
		 */
		public void addAction(String actionName, String actionType, HashMap<String, Object> property)

		 /**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration
		 * @param property Extension attributes
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
		 * @param property Extension attributes
		 */
		fun addAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration
		 * @param property Extension attributes
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> `startAction` internally has a timing algorithm that tries to associate nearby occurring Resource, LongTask, Error data during the calculation period. There is a 100 ms frequent trigger protection, it is recommended to use it for user operation type data. If there is a need for frequent calls, please use `addAction`, this data will not conflict with `startAction` and will not be associated with current Resource, LongTask, Error data.


#### Code Example

=== "Java"

	```java
	// Scene 1
	FTRUMGlobalManager.get().startAction("login", "action_type");

	// Scene 2: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().startAction("login", "action_type", map);


	// Scene 1
	FTRUMGlobalManager.get().addAction("login", "action_type");

	// Scene 2: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addAction("login", "action_type", map);
	```

=== "Kotlin"

	```kotlin

	// Scene 1
	FTRUMGlobalManager.get().startAction("login", "action_type")

	// Scene 2: Dynamic parameters
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTRUMGlobalManager.get().startAction("login","action_type",map)


	// Scene 1
	FTRUMGlobalManager.get().startAction("login", "action_type")

	// Scene 2: Dynamic parameters
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
	     * Stop view
	     */
	    public void stopView()

	    /**
	     * Stop view
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
	     * Stop view
	     */
		fun stopView()

		 /**
	     * Stop view
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

	    // Scene 1
	    FTRUMGlobalManager.get().startView("Current Page Name");

	    // Scene 2: Dynamic parameters
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key", "ft_value");
	    map.put("ft_key_will_change", "ft_value");
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}

	@Override
	protected void onPause() {
	    super.onPause();

	    // Scene 1
	    FTRUMGlobalManager.get().stopView();

	    // Scene 2 : Dynamic parameters
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be changed to ft_value_change when stopView is called
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}
	```

=== "Kotlin"

	```kotlin
	override fun onResume() {
	     super.onResume()

	     // Scene 1
	     FTRUMGlobalManager.get().startView("Current Page Name")

	     // Scene 2: Dynamic parameters
	     val map = HashMap<String, Any>()
	     map["ft_key"] = "ft_value"
	     map["ft_key_will_change"] = "ft_value"
	     FTRUMGlobalManager.get().startView("Current Page Name", map)

	}

	override fun onPause() {
	     super.onPause()

	     // Scene 1
	     FTRUMGlobalManager.get().stopView()


	     // Scene 2 : Dynamic parameters
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
	// Scene 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scene 2: Delay recording errors that