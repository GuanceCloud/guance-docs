# Android Application Integration
---
<<< custom_key.brand_name >>> application monitoring can collect various Android application Metrics data and analyze the performance of each Android application endpoint in a visualized way.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [publicly accessible with IP geolocation information database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration} 

Log in to the <<< custom_key.brand_name >>> console, navigate to the **User Analysis** page, click the top-left **[Create]** to start creating a new application.

- <<< custom_key.brand_name >>> provides a **public DataWay** to receive RUM data directly without installing the DataKit collector. Configuring `site` and `clientToken` parameters is sufficient.

![](../img/android_01.png)

- <<< custom_key.brand_name >>> also supports receiving RUM data via **local environment deployment**, which requires meeting the prerequisites.

![](../img/6.rum_android_1.png)


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the remote repository address of the `SDK` in the root directory's `build.gradle` file.

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //Add the SDK remote repository address
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //Add Plugin plugin, AGP 7.4.2 or above, Gradle 7.2.0 or above required
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP 7.4.2 versions below, use ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //Add the SDK remote repository address
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
	        //Add the SDK remote repository address
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
	        //Add the SDK remote repository address
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//Add Plugin plugin, AGP 7.4.2 or above, Gradle 7.2.0 or above required
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		//For AGP 7.4.2 versions below, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* Add `SDK` dependencies and `Plugin` usage along with Java 8 support in the main module `app`'s `build.gradle` file.

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency to capture native layer crash information, must be used with ft-sdk
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended version, other versions may not be fully compatible
    implementation 'com.google.code.gson:gson:2.8.5'

}
//Apply plugin
apply plugin: 'ft-plugin'
//Configure plugin usage parameters
FTExt {
    //Whether to display Plugin logs, default is false
    showLog = true
	
    //Set ASM version, supporting asm7 - asm9, default asm9
    //asmVersion='asm7'

    //ASM ignore path configuration, paths '.' and '/' are equivalent
    //ignorePackages=['com.ft','com/ft']

	//Native so specified path, only need to specify the upper directory of the abi file
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
	//...Omitted some code
	defaultConfig {
        //...Omitted some code
        ndk {
            //When using ft-native to capture native layer crash information, select supported abi architectures based on the different platforms adapted by the application.
            //Currently, the included abi architectures in ft-native are 'arm64-v8a',
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

> Check the latest version names for ft-sdk, ft-plugin, and ft-native above.

## Application Configuration {#application-setting}
Theoretically, the best place to initialize the SDK is in the `onCreate` method of `Application`. If your application hasn't created an `Application`, you need to create one and declare it in the `AndroidManifest.xml` under `Application`. Example reference [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

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
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, port defaults to 9529, the device where the SDK is installed needs to be able to access this address. **Note: Choose either datakit or dataway configuration**|
| datawayUrl | String | Yes | Public Dataway access URL address, example: http://10.0.0.1:9528, port defaults to 9528, the device where the SDK is installed needs to be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | String | Yes | Authentication token, must be configured together with datawayUrl  |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, enabling it will allow printing SDK operation logs |
| setEnv | EnvType | No | Set collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set collection environment, default is `prod`. **Note: Only configure one of String or EnvType types**|
| setOnlySupportMainProcess | Boolean | No | Whether to only support running in the main process, default is `true`, if execution is needed in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable obtaining `Android ID`, default is `true`, setting to `false` will prevent the collection of the `device_uuid` field, related to market privacy audits [view here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add global properties to the SDK, addition rules refer to [here](#key-conflict) |
| setServiceName | String | No | Set service name, affects Log and RUM `service` field data, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable automatic synchronization, default is `true`. When set to `false`, use `FTSdk.flushSyncData()` to manage data synchronization manually |  
| setSyncPageSize | Int | No | Set the number of entries per sync request, `SyncPageSize.MINI` 5 entries, `SyncPageSize.MEDIUM` 10 entries, `SyncPageSize.LARGE` 50 entries, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set the number of entries per sync request, range [5,), note that the larger the number of entries, the more computational resources are consumed, default is 10 **Note: Only configure one of setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set the intermittent time for synchronization, range [0,5000], default not set |
| enableDataIntegerCompatible | Void | No | Suggested to enable when coexisting with web data. This configuration handles storage compatibility issues for web data types. Version 1.6.9 enables this by default |
| setNeedTransformOldCache | Boolean | No | Whether to transform old cache data from ft-sdk versions below 1.6.0, default is `false` |
| setCompressIntakeRequests | Boolean | No | Compress sync data, versions 1.6.3 and above of ft-sdk support this method |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default 100MB, unit Byte, the larger the database, the greater the disk pressure, default is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become ineffective. Versions 1.6.6 and above of ft-sdk support this method |

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
| setRumAppId | String | Yes | Set `Rum AppId`. Corresponding to RUM `appid`, this will enable the RUM collection function, [method to obtain appid](#android-integration) |
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data within the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling it will display error stack data in error analysis.<br> [Regarding conversion of obfuscated content in crash logs](#retrace-log).<br><br>ft-sdk 1.5.1 and above versions can set whether logcat is displayed in Java Crash and Native Crash through `extraLogCatWithJavaCrash` and `extraLogCatWithNativeCrash` |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, add additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery level, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, add monitoring data during the View lifecycle, `DeviceMetricsMonitorType.BATTERY` monitors the highest current output on the current page, `DeviceMetricsMonitorType.MEMORY` monitors the application memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU jumps , `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring cycle, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>ft-sdk 1.5.1 and above versions can set whether logcat is displayed in ANR through `extraLogCatWithANR` |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI blocking detection, default is `false`, ft-sdk 1.6.4 and above versions can control the detection time range [100,) in milliseconds, default is 1 second |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user operations, currently only supports user startup and click operations, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically track user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Scope: Only affects default collection when `EnableTraceUserResource` is true. For custom Resource collection, use `FTResourceEventListener.FTFactory(true)` to enable this feature. Additionally, there is an IP caching mechanism for single Okhttp with the same domain, and the connection IP to the server will only generate once under the premise of no change in the same `OkhttpClient` |
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default does not filter |
| setOkHttpEventListenerHandler | Callback| No | ASM sets global Okhttp EventListener, default does not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets global `FTResourceInterceptor.ContentHandlerHelper`, default does not set, ft-sdk 1.6.7 and above supports, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom tags for distinguishing data sources in user monitoring. If tracking functionality is needed, parameter `key` should be `track_id`, `value` as any number, refer to [here](#key-conflict) for addition rules |
| setRumCacheLimitCount | int | No | Local cache limit count for RUM [10_000,), default is 100_000. ft-sdk 1.6.6 and above supports |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set discard rule for data when RUM reaches its limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data, ft-sdk 1.6.6 and above supports |

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
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log levels correspond<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning,<br> `prefix` is the filtering parameter for the control prefix, default does not set filtering. Note: Android console volume is very large, to avoid affecting application performance and reducing unnecessary resource waste, it is suggested to use `prefix` to filter out valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default is not set |
| addGlobalContext | Dictionary | No | Add global properties to log, addition rules refer to [here](#key-conflict) |
| setLogCacheLimitCount | Int | No | Local cache maximum log entry limit [1000,), larger logs mean greater disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set discard rule for logs when they reach their limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data |

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
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setTraceType | TraceType | No | Set the trace type, default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if accessing OpenTelemetry and choosing corresponding trace types, please refer to supported types and agent configurations |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic http trace, currently only supports OKhttp automatic tracing, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets global `FTTraceInterceptor.HeaderHandler`, default is not set, ft-sdk 1.6.8 and above supports, example reference [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition effects or manually use `FTRUMGlobalManager` to add these data, examples are as follows:

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
	     * @param property   Additional attributes
	     */
	    public void startAction(String actionName, String actionType, HashMap<String, Object> property)


		/**
		 * Add Action, this kind of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 */
		public void addAction(String actionName, String actionType)

		/**
		 * Add Action, this kind of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param property Extended attributes
		 */
		public void addAction(String actionName, String actionType, HashMap<String, Object> property)

		 /**
		 * Add Action, this kind of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration
		 * @param property Extended attributes
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
	     * @param property   Additional attributes
	     */
	    fun startAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action, this kind of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 */
		fun addAction(actionName: String, actionType: String)

		/**
		 * Add Action, this kind of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param property Extended attributes
		 */
		fun addAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration
		 * @param property Extended attributes
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> `startAction` internally has a timing algorithm that tries to associate nearby occurring Resource, LongTask, Error data during the calculation period. It has a 100 ms frequent trigger protection and is recommended for user operation type data. If frequent calls are needed, use `addAction`, this data will not conflict with `startAction` and will not associate with current Resource, LongTask, Error data.


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
	     * View start
	     *
	     * @param viewName Current page name
	     */
	    public void startView(String viewName)


	    /**
	     * View start
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters
	     */
	    public void startView(String viewName, HashMap<String, Object> property)


	    /**
	     * View end
	     */
	    public void stopView()

	    /**
	     * View end
	     *
	     * @param property Additional attribute parameters
	     */
	    public void stopView(HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin

		/**
	     * View start
	     *
	     * @param viewName Current page name
	     */
		fun startView(viewName: String)

		 /**
	     * View start
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters
	     */

		fun startView(viewName: String, property: HashMap<String, Any>)

		 /**
	     * View end
	     */
		fun stopView()

		 /**
	     * View end
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
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be changed to ft_value_change when stopView
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
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change this value will be changed to ft_value_change when stopView
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
	FTRUMGlobalManager.get().addError```java
	// Scene 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scene 2: Delay recording the error that occurred, this time is generally the time when the error occurred
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000L, ErrorType.JAVA, AppState.RUN);

	// Scene 3: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN, map);
	```

=== "Kotlin"

	```kotlin

	// Scene 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN)

	// Scene 2: Delay recording the error that occurred, this time is generally the time when the error occurred
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000, ErrorType.JAVA, AppState.RUN)

	// Scene 3: Dynamic parameters
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
	// Scene 1
	FTRUMGlobalManager.get().addLongTask("error log", 1000000L);

	// Scene 2: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addLongTask("", 1000000L, map);
	```

=== "Kotlin"


	```kotlin

	// Scene 1
	FTRUMGlobalManager.get().addLongTask("error log",1000000L)

	// Scene 2: Dynamic parameters
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
	     */
	    public void startResource(String resourceId)

	    /**
	     * Resource start
	     *
	     * @param resourceId Resource Id
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * Resource end
	     *
	     * @param resourceId Resource Id
	     */
	    public void stopResource(String resourceId)

	    /**
	     * Resource end
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
	 * Resource start
	 *
	 * @param resourceId Resource Id
	 */
	fun startResource(resourceId: String)

	/**
	 * Resource start
	 *
	 * @param resourceId Resource Id
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * Resource end
	 *
	 * @param resourceId Resource Id
	 */
	fun stopResource(resourceId: String)

	/**
	 * Resource end
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

	// Scene 1
	// Request start
	FTRUMGlobalManager.get().startResource("resourceId");

	//...

	// Request end
	FTRUMGlobalManager.get().stopResource("resourceId");

	// Finally, after the request ends, send relevant data metrics of the request
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


	// Scene 2: Dynamic parameter usage
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be changed to ft_value_change at stopResource
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// Scene 1
	//Request start
	FTRUMGlobalManager.get().startResource("resourceId")

	//Request end
	FTRUMGlobalManager.get().stopResource("resourceId")

	//Finally, after the request ends, send relevant data metrics of the request
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
	FTRUMGlobalManager.get().addResource("resourceId",params,bean)

	// Scene 2: Dynamic parameter usage
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)

	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change"
	)
	// ft_key_will_change this value will be changed to ft_value_change at stopResource

	FTRUMGlobalManager.get().stopResource(uuid, map)

	```

| **Method Name** | **Required** | **Meaning** |**Description** |
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
| ResourceParams.responseContentType | No | Response Content Type | |
| ResourceParams.responseContentEncoding | No | Response Content Encoding |  |
| ResourceParams.resourceMethod | No | Request method | GET, POST etc. |
| ResourceParams.responseBody | No | Return body content | |
| ResourceParams.property| No | Additional attributes |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, which requires enabling `FTLoggerConfig.setEnableCustomLog(true)`
> Currently, the log content is limited to 30 KB, and any exceeding characters will be truncated.

### Usage Method

=== "Java"

	```java
	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    public void logBackground(String content, Status status)

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
		 * @param property Additional attributes
	     */
	    public void logBackground(String content, Status status, HashMap<String, Object> property)

		/**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    public void logBackground(String content, String status)

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
		 * @param property Additional attributes
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
	     */
	    fun logBackground(content: String, status: Status)

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log attributes
	     */
	    fun logBackground(content: String, status: Status, property: HashMap<String, Any>)

		/**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    fun logBackground(content: String, status: String)

	    /**
	     * Store a single log data locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log attributes
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
	//Upload a single log
	FTLogger.getInstance().logBackground("test", Status.INFO)

	//Pass parameters to HashMap
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTLogger.getInstance().logBackground("test", Status.INFO,map)

	//Batch upload logs
	FTLogger.getInstance().logBackground(mutableListOf(LogData("test",Status.INFO)))
	```

## Tracer Network Trace Tracking

Configure `FTTraceConfig` with `enableAutoTrace` to automatically add trace data, or manually use `FTTraceManager` to add `Propagation Header` in Http requests, as shown below:

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

## Customizing Resource and TraceHeader through OKHttp Interceptor {#okhttp_resource_trace_interceptor_custom}

The configuration of `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`, if both are enabled simultaneously, will prioritize loading the custom `Interceptor` configuration.
 > For ft-sdk < 1.4.1, you need to disable `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`.
 > ft-sdk > 1.6.7 supports associating custom Trace Headers with RUM data

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

				 // Supported from 1.6.7 onwards
				  @Override
				  public String getSpanID() {
					return "span_id";
				 }
				// Supported from 1.6.7 onwards
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

## User Data Binding and Unbinding {#userdata-bind-and-unbind}
Use `FTSdk` for user binding and unbinding 

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
| setExts | Set user extensions | No | Addition rules refer to [here](#key-conflict)|

### Code Example

=== "Java"

	```java
	// You can call this method after a successful user login to bind user information
	FTSdk.bindRumUserData("001");

	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);

	// You can call this method after the user logs out to unbind user information
	FTSdk.unbindRumUserData();

	```

=== "Kotlin"

	```kotlin
	//You can call this method after a successful user login to bind user information
	FTSdk.bindRumUserData("001")


	//Bind more user data
	val userData = UserData()
	userData.name = "test.user"
	userData.id = "test.id"
	userData("test@mail.com")
	val extMap = HashMap<String, String>()
	extMap["ft_key"] = "ft_value"
	userData.setExts(extMap)
	FTSdk.bindRumUserData(userData)

	//You can call this method after the user logs out to unbind user information
	FTSdk.unbindRumUserData()
	```


## Closing SDK
Use `FTSdk` to close the SDK 

### Usage Method
=== "Java"

	```java
	    /**
	     * Close running objects within SDK
	     */
	    public static void shutDown()

	```

=== "Kotlin"


	``` kotlin
	    /**
	     * Close running objects within SDK
	     */
	    fun shutDown()
	```

### Code Example
    
=== "Java"

	```java
	// If dynamically changing SDK configuration, need to close first to avoid incorrect data generation
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	//If dynamically changing SDK configuration, need to close first to avoid incorrect data generation
	FTSdk.shutDown()
	```

## Clearing SDK Cache Data
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

## Active Data Synchronization
Use `FTSdk` to actively synchronize data.
> When `FTSdk.setAutoSync(false)`, manual data synchronization is required.

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
Use `FTSdk` to set whether to acquire Android ID in the SDK

### Usage Method

=== "Java"

	```java
	   /**
	     * Dynamically control acquiring Android ID
	     *
	     * @param enableAccessAndroidID True to apply, false not to apply
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Dynamically control acquiring Android ID
	     *
	     * @param enableAccessAndroidID True to apply, false not to apply
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
	//Enable acquiring Android ID
	FTSdk.setEnableAccessAndroidID(true)

	//Disable acquiring Android ID
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

### Prevent Action name class names from being obfuscated during acquisition
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (Only supported for datakit[local deployment])
`ft-plugin` version needs `1.3.0` or above to support the latest symbol file upload rules, supporting `productFlavor` multi-version management, plugin will execute symbol file upload after `gradle task assembleRelease`, detailed configuration can be referenced [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, no need to configure when generateSourceMapOnly=true
    datawayToken = 'dataway_token' 		// space token, no need to configure when generateSourceMapOnly=true
    appId = "appid_xxxxx"				// appid, no need to configure when generateSourceMapOnly=true
    env = 'common'						// environment, no need to configure when generateSourceMapOnly=true
	generateSourceMapOnly = false // Only generate sourcemap, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, ft-plugin:1.3.4 and above versions support

    prodFlavors { //prodFlavors configuration overrides outer layer settings
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
Use `plugin` with `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or package into a `zip` file manually, then upload to `datakit` or upload from <<< custom_key.brand_name >>> Studio, recommend using `zip` command line for packaging to avoid including some system hidden files into the `zip` package, symbol upload reference [sourcemap upload](../sourcemap/set-sourcemap.md)

> Unity Native Symbol files reference [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitates precise data analysis, affects cellular network information acquisition in SDK |

> For details on how to request dynamic permissions, refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

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
For WebView data monitoring, the page accessed by WebView needs to integrate [Web Monitoring SDK](../web/app-access.md)

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

1. Use file-type data storage, such as `SharedPreferences`, configure `SDK` usage, and add code to retrieve tag data in the configuration location.

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

3. Finally restart the application, detailed steps can be found in [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After the SDK initialization is complete, using `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` allows dynamic addition of tags, which takes effect immediately upon setting. Subsequently, the reported RUM or Log data will automatically include tag data. This usage method suits scenarios where tag data needs to be obtained with network requests delayed.

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
### Add Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix tag names with a **project abbreviation**, such as `df_tag_name`. Values for `key` can be [checked in source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When global variables in the SDK conflict with RUM, Log variables, RUM, Log will override the global variables in the SDK.

### SDK Compatibility

* [Runnable Environments](app-troubleshooting.md#runnable)
* [Compatible Environments](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to check](<<< homepage >>>/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
The SDK uses Android ID to better associate data from the same user. If needed for app store listings, follow these ways to adapt to market privacy audits.

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

	        //Set setEnableAccessAndroidID to false during initialization
	        val config = FTSDKConfig
	            .builder(DATAKIT_URL)
	            . setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	//Enable after user agrees to privacy policy
	FTSdk.setEnableAccessAndroidID(true);
	```
#### Method 2: Delayed Initialization of SDK
If you need to delay loading the SDK in your app, it's suggested to initialize it as follows.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    //If```java
		    //If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); //SDK initialization pseudo-code
			}
		}
	}
	
	// Privacy Statement Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			//Not read privacy statement
			if ( notReadProtocol ) {
			    //Show privacy statement popup
				showProtocolView();
	
			    //If agree to privacy statement
				if( agreeProtocol ){
					FTSdk.init(); //SDK initialization pseudo-code
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
	            FTSdk.init() //SDK initialization pseudo-code
	        }
	    }
	}
	
	// Privacy Statement Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not read privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement popup
	            showProtocolView()
	
	            // If agree to privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() //SDK initialization pseudo-code
	            }
	        }
	    }
	}
	```
#### Third-party Frameworks {#third-party}
`flutter`, `react-native`, `unity` can use a similar delayed initialization method as native Android to adapt to app market privacy audits.

### How to Integrate SDK Without Using ft-plugin {#manual-set}
<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to implement code injection for automatic data collection. However, due to some compatibility issues, it may be impossible to use `ft-plugin`. Affected functionalities include **RUM** `Action`, `Resource`, and automatic capture of Java and Kotlin `println` **console logs**, as well as automatic upload of symbol files.

Currently, we have another integration solution for this situation:

* Application launch events need to be called before SDK initialization, refer to source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    // Needs to be called before SDK initialization
	    FTAutoTrack.startApp(null);
	    // Set SDK configuration
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	  //Application
	    override fun onCreate() {
	        super.onCreate()
		// Needs to be called before SDK initialization
	        FTAutoTrack.startApp(null)
	        // Set SDK configuration
	        setSDK(this)

	    }
	```

* Key events like button clicks need to be manually added at the trigger location, for example, Button onClick event, refer to source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* `OKhttp` integrates `Resource` and `Trace` through `addInterceptor` and `eventListener`, refer to the following example, source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* For other network frameworks, you need to manually implement using `FTRUMGlobalManager` methods such as `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. For specific implementation methods, refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).
```