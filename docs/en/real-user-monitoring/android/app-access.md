# Android Application Integration
---

By collecting metrics data from Android applications, analyze application performance in a visualized manner.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been enabled, the prerequisites are automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);  
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit is configured to be [publicly accessible on the internet and the IP geographic information database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration} 

1. Go to **User Analysis > Create > Android**;
2. Input the application name;
3. Input the application ID;
4. Select the method of application integration:

    - Public DataWay: Directly receives RUM data without requiring the installation of the DataKit collector.  
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the `SDK` remote repository address in the `build.gradle` file at the root directory of the project

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //Add SDK's remote repository address
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //Add Plugin plugin, dependent on AGP 7.4.2 or higher, Gradle 7.2.0 or higher
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP versions below 7.4.2, use ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //Add SDK's remote repository address
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
	        //Add SDK's remote repository address
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
	        //Add SDK's remote repository address
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//Add Plugin plugin, dependent on AGP 7.4.2 or higher, Gradle 7.2.0 or higher
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		//For AGP versions below 7.4.2, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* Add `SDK` dependency and `Plugin` usage as well as Java 8 support in the `app` main module `build.gradle` file of the project

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency for capturing native layer crash information, must be used with ft-sdk, cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended to use this version, other versions have not undergone sufficient compatibility testing
    implementation 'com.google.code.gson:gson:2.8.5'

}
//Apply plugin
apply plugin: 'ft-plugin'   //If using an old version compatible with ft-plugin-legacy, no changes required
//Configure plugin usage parameters
FTExt {
    //Whether to display Plugin logs, default is false
    showLog = true
	
    //Set ASM version, supports asm7 - asm9, default is asm9
    //asmVersion='asm7'

    //ASM ignore path configuration, paths where . and / are equivalent
    //ignorePackages=['com.ft','com/ft']

	// native so specified path, just need to specify up to the abi file directory
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
	//... omitted part of code
	defaultConfig {
        //... omitted part of code
        ndk {
            //When using ft-native to capture native layer crash information, select supported abi architectures based on the platform adapted by the application
            //Currently included abi architectures in ft-native are 'arm64-v8a',
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

> The latest version can be seen above in the ft-sdk, ft-plugin, ft-native version names

## Application Configuration {#application-setting}

Theoretically, the best place to initialize the SDK is in the `Application`'s `onCreate` method. If your application has not yet created an `Application`, you need to create one and declare it in the `AndroidManifest.xml`. Refer to the example [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

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
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, default port 9529, the device installing the SDK needs to be able to access this address. **Note: Only choose one between datakit and dataway configurations**|
| datawayUrl | String | Yes | Public Dataway access URL address, example: http://10.0.0.1:9528, default port 9528, the device installing the SDK needs to be able to access this address. **Note: Only choose one between datakit and dataway configurations** |
| clientToken | String | Yes | Authentication token, must be configured simultaneously with datawayUrl  |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, enabling will allow printing of SDK runtime logs |
| setEnv | EnvType | No | Set collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set collection environment, default is `prod`. **Note: Only configure one type of String or EnvType**|
| setOnlySupportMainProcess | Boolean | No | Whether only to run in the main process, default is `true`, if execution is needed in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable obtaining `Android ID`, default is `true`, setting to `false` means that the `device_uuid` field data will not be collected, refer to market privacy review [here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add SDK global properties, rules for adding please check [here](#key-conflict) |
| setServiceName | String | No | Set service name, affects Log and RUM service fields data, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable automatic synchronization, default is `true`. When set to `false`, manage data synchronization using `FTSdk.flushSyncData()` |  
| setSyncPageSize | Int | No | Set sync request entries count, `SyncPageSize.MINI` 5 entries, `SyncPageSize.MEDIUM` 10 entries, `SyncPageSize.LARGE` 50 entries, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set sync request entries count, range [5,), note larger request entries mean greater computing resource consumption, default is 10 **Note: Only configure one between setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set sync interval time, range [0,5000], default not set  |
| enableDataIntegerCompatible | Void | No | It is recommended to enable when coexisting with web data. This configuration handles web data type storage compatibility issues. Version 1.6.9 defaults to enable  |
| setNeedTransformOldCache | Boolean | No | Whether to be compatible with old cache data below ft-sdk version 1.6.0, default is `false` |
| setCompressIntakeRequests | Boolean | No | Compress sync data, ft-sdk versions 1.6.3 and above support this method |
| enableLimitWithDbSize | Void | No | Enable using db to limit data size, default is 100MB, unit Byte, larger databases mean more disk pressure, default is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become invalid. ft-sdk versions 1.6.6 and above support this method |

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
| setRumAppId | String | Yes | Set `Rum AppId`. Corresponds to setting RUM `appid`, which will activate the RUM collection function, [method to obtain appid](#android-integration) |
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 indicates no collection, 1 indicates full collection, default is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling will display error stack data in error analysis.<br> [Regarding the conversion of obfuscated content in crash logs](#retrace-log).<br><br>ft-sdk 1.5.1 and above versions, through `extraLogCatWithJavaCrash` and `extraLogCatWithNativeCrash` settings, determine whether logcat should be displayed for Java Crash and Native Crash |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, add additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` is battery level, `ErrorMonitorType.MEMORY` is memory usage, `ErrorMonitorType.CPU` is CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, add monitoring data during the View lifecycle, `DeviceMetricsMonitorType.BATTERY` monitors the maximum output current of the current page, `DeviceMetricsMonitorType.MEMORY` monitors the current application memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU fluctuations, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring cycle, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>ft-sdk 1.5.1 and above versions, through `extraLogCatWithANR` settings, determine whether logcat should be displayed in ANR |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, ft-sdk 1.6.4 and above versions can control the detection time range [100,) via `blockDurationMs`, unit milliseconds, default is 1 second  |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user operations, currently only supports user startup and click operations, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically trace user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Scope: Only affects default collection when `EnableTraceUserResource` is true. Custom Resource collection requires using `FTResourceEventListener.FTFactory(true)` to enable this function. Additionally, a single Okhttp caches IP for the same domain, thus generating only once per connection with the server unless the IP changes |
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default is no filtering |
| setOkHttpEventListenerHandler | Callback| No | ASM sets global Okhttp EventListener, default is not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets global `FTResourceInterceptor.ContentHandlerHelper`, default is not set, ft-sdk 1.6.7 and above supports, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom labels, used for distinguishing data sources in user monitoring. If tracking functionality is needed, parameter `key` is `track_id`, `value` is any number, refer to [here](#key-conflict) for addition rule notes |
| setRumCacheLimitCount | int | No | Local cache RUM limit count [10_000,), default is 100_000. ft-sdk 1.6.6 and above supports |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set discard rules for RUM data exceeding the limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards oldest data, ft-sdk 1.6.6 and above supports |

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
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 indicates no collection, 1 indicates full collection, default is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level correspondence<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning, <br> `prefix` is the control prefix filter parameter, default does not set filtering. Note: Android console volume is large, to avoid affecting application performance and reducing unnecessary resource waste, it is suggested to use `prefix` to filter valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default is not set |
| addGlobalContext | Dictionary | No | Add log global attributes, rules for adding please check [here](#key-conflict) |
| setLogCacheLimitCount | Int | No | Local cache max log entry count restriction [1000,), larger logs indicate greater disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set log discard rules when reaching the limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data |

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
| setSamplingRate | Float | No | Set the sampling rate, value range [0,1], 0 indicates no collection, 1 indicates full collection, default is 1. |
| setTraceType | TraceType | No | Set the trace type, default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if selecting corresponding trace type when integrating OpenTelemetry, please refer to supported types and agent related configurations |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic http trace, currently only supports automatic tracing for OKhttp, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets global `FTTraceInterceptor.HeaderHandler`, default is not set, ft-sdk 1.6.8 and above supports, reference example [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

`FTRUMConfig` configures `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition effects or manually use `FTRUMGlobalManager` to add these data, examples as follows:

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
		 * @param property Extended attributes
		 */
		public void addAction(String actionName, String actionType, HashMap<String, Object> property)

		 /**
		 * Add Action, this type of data cannot be associated with Error, Resource, LongTask data
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration time
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
		 * @param property Extended attributes
		 */
		fun addAction(actionName: String, actionType: String, property: HashMap<String, Any>)

		/**
		 * Add Action
		 *
		 * @param actionName action name
		 * @param actionType action type
		 * @param duration   Nanoseconds, duration time
		 * @param property Extended attributes
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> startAction internally has an algorithm to calculate duration, trying to associate nearby occurring Resource, LongTask, Error data during calculation, protected against frequent triggers within 100 ms. It is recommended to use for user operation type data. If there is a need for frequent calls, use addAction, this data will not conflict with startAction and will not associate with current Resource, LongTask, Error data.


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
	     * view start
	     *
	     * @param viewName Current page name
	     */
	    public void startView(String viewName)


	    /**
	     * view start
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters
	     */
	    public void startView(String viewName, HashMap<String, Object> property)


	    /**
	     * view end
	     */
	    public void stopView()

	    /**
	     * view end
	     *
	     * @param property Additional attribute parameters
	     */
	    public void stopView(HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin

		/**
	     * view start
	     *
	     * @param viewName Current page name
	     */
		fun startView(viewName: String)

		 /**
	     * view start
	     *
	     * @param viewName Current page name
	     * @param property Additional attribute parameters
	     */

		fun startView(viewName: String, property: HashMap<String, Any>)

		 /**
	     * view end
	     */
		fun stopView()

		 /**
	     * view end
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
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scene 2: Delayed recording of occurred errors, this time generally refers to the time when the error occurred
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
	     * @param duration Duration time, nanoseconds
	     */
	    public void addLongTask(String log, long duration)

	    /**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration time, nanoseconds
	     */
	    public void addLongTask(String log, long duration, HashMap<String, Object> property)

	```

=== "Kotlin"

	```kotlin
	    /**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration time, nanoseconds
	     */
		fun addLongTask(log: String, duration: Long)

		/**
	     * Add long task
	     *
	     * @param log      Log content
	     * @param duration Duration time, nanoseconds
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
	     * resource start
	     *
	     * @param resourceId Resource Id
	     */
	    public void startResource(String resourceId)

	    /**
	     * resource start
	     *
	     * @param resourceId Resource Id
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * resource end
	     *
	     * @param resourceId Resource Id
	     */
	    public void stopResource(String resourceId)

	    /**
	     * resource end
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
	 * resource start
	 *
	 * @param resourceId Resource Id
	 */
	fun startResource(resourceId: String)

	/**
	 * resource start
	 *
	 * @param resourceId Resource Id
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * resource end
	 *
	 * @param resourceId Resource Id
	 */
	fun stopResource(resourceId: String)

	/**
	 * resource end
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
	// Request starts
	FTRUMGlobalManager.get().startResource("resourceId");

	//...

	// Request ends
	FTRUMGlobalManager.get().stopResource("resourceId");

	// Finally, after the request ends, send related data metrics
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


	// Scene 2 : Dynamic parameter usage
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be changed to ft_value_change when stopResource
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// Scene 1
	//Request starts
	FTRUMGlobalManager.get().startResource("resourceId")

	//Request ends
	FTRUMGlobalManager.get().stopResource("resourceId")

	//Finally, after the request ends, send related data metrics
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

	// Scene 2 : Dynamic parameter usage
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)

	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change"
	)
	// ft_key_will_change this value will be changed to ft_value_change when stopResource

	FTRUMGlobalManager.get().stopResource(uuid, map)

	```

| **Method Name** | **Required** | **Meaning** |**Explanation** |
| --- | --- | --- | --- |
| NetStatusBean.fetchStartTime | No | Request start time | |
| NetStatusBean.tcpStartTime | No | TCP connection time |  |
| NetStatusBean.tcpEndTime | No | TCP end time |  |
| NetStatusBean.dnsStartTime | No | DNS start time |  |
| NetStatusBean.dnsEndTime | No |  DNS end time | |
| NetStatusBean.responseStartTime | No | Response start time |  |
| NetStatusBean.responseEndTime | No | Response end time |  |
| NetStatusBean.sslStartTime | No | SSL start time |  |
| NetStatusBean.sslEndTime | No |  SSL end time | |
| NetStatusBean.property| No |  Additional attributes | |
| ResourceParams.url | Yes |  URL address | |
| ResourceParams.requestHeader | No | Request header parameters |  |
| ResourceParams.responseHeader | No | Response header parameters |  |
| ResourceParams.responseConnection | No |  Response  connection | |
| ResourceParams.responseContentType | No |  Response  ContentType | |
| ResourceParams.responseContentEncoding | No | Response  ContentEncoding |  |
| ResourceParams.resourceMethod | No | Request method |  GET,POST etc. |
| ResourceParams.responseBody | No |  Return body content | |
| ResourceParams.property| No | Additional attributes |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, need to enable `FTLoggerConfig.setEnableCustomLog(true)`
> Currently, log content is limited to 30 KB, exceeding characters will be truncated.

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
	     * @param logDataList {@link LogData} List
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
	//Upload a single log
	FTLogger.getInstance().logBackground("test", Status.INFO)

	//Pass parameters to HashMap
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTLogger.getInstance().logBackground("test", Status.INFO,map)

	//Batch upload logs
	FTLogger.getInstance().logBackground(mutableListOf(LogData("test",Status.INFO)))
	```

## Tracer Network Link Trace

`FTTraceConfig` configure to enable `enableAutoTrace` automatically adding trace data, or manually use `FTTraceManager` in Http requests for `Propagation Header`, example as follows:

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

 `FTRUMConfig`'s `enableTraceUserResource`, `FTTraceConfig`'s `enableAutoTrace` configuration, both enabled, priority loads custom `Interceptor` configuration,
 >ft-sdk < 1.4.1, need to disable `FTRUMConfig`'s `enableTraceUserResource`, `FTTraceConfig`'s `enableAutoTrace`.
 >ft-sdk > 1.6.7 supports custom Trace Header associated with RUM data

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

				 // 1.6.7 and above versions support
				  @Override
				  public String getSpanID() {
					return "span_id";
				 }
				// 1.6.7 and above versions support
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
                       //copy read part of body, avoid large data consumption
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
                // Copy part of the response body to avoid large data consumption
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

## User Information Binding and Unbinding {#userdata-bind-and-unbind}
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
| **Method Name** | **Meaning** | **Required** | **Explanation** |
| --- | --- | --- | --- |
| setId | Set user ID | No | |
| setName | Set username | No | |
| setEmail | Set email | No | |
| setExts | Set user extensions | No | Rules for addition please check [here](#key-conflict)|

### Code Example

=== "Java"

	```java
	// Can be called after successful user login to bind user information
	FTSdk.bindRumUserData("001");

	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);

	// Can be called after user logout to unbind user information
	FTSdk.unbindRumUserData();

	```

=== "Kotlin"

	```kotlin
	//Can be called after successful user login to bind user information
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

	//Can be called after user logout to unbind user information
	FTSdk.unbindRumUserData()
	```


## Close SDK
Use `FTSdk` to close the SDK 

### Usage Method
=== "Java"

	```java
	    /**
	     * Shut down running objects within SDK
	     */
	    public static void shutDown()

	```

=== "Kotlin"


	``` kotlin
	    /**
	     * Shut down running objects within SDK
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

## Actively Synchronize Data
Use `FTSdk` to actively synchronize data.
>When `FTSdk.setAutoSync(false)` is set, manual data synchronization is required

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



## Dynamically Enable and Disable AndroidID Acquisition
Use `FTSdk` to set whether to acquire Android ID in the SDK

### Usage Method

=== "Java"

	```java
	   /**
	     * Dynamically control acquisition of Android ID
	     *
	     * @param enableAccessAndroidID Yes to apply, no to not apply
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Dynamically control acquisition of Android ID
	     *
	     * @param enableAccessAndroidID Yes to apply, no to not apply
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

## Add Custom Labels

Use `FTSdk` to dynamically add labels during SDK runtime

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

### Prevent Action from getting action_name where class names are obfuscated
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (Only supported by datakit [local deployment])
`ft-plugin` version needs `1.3.0` or higher version to support the latest symbol file upload rules, supports `productFlavor` multi-version management, plugin executes symbol file upload after `gradle task assembleRelease`, detailed configuration can refer to [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, generateSourceMapOnly=true when not configured
    datawayToken = 'dataway_token' 		// Space token, generateSourceMapOnly=true when not configured
    appId = "appid_xxxxx"				// appid, generateSourceMapOnly=true when not configured
    env = 'common'						// Environment, generateSourceMapOnly=true when not configured
	generateSourceMapOnly = false //Generate sourcemap only, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, ft-plugin:1.3.4 and above versions support

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
Use `plugin` to enable `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or package into `zip` file manually, then upload to `datakit` or upload from <<< custom_key.brand_name >>> Studio, recommended to use `zip` command-line packaging to avoid including some system hidden files in the `zip` package, symbol upload reference [sourcemap upload](../sourcemap/set-sourcemap.md)

> Unity Native Symbol files please reference [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitating precise data analysis, affects cellular network information acquisition in the SDK |

> For details on how to request dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignoring {#ingore_aop}
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
WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) in the pages accessed by WebView

## Custom Label Usage Example {#track}

### Compilation Configuration Method

1. Create multiple `productFlavors` in `build.gradle` to distinguish label differences

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
### Runtime Read/Write File Method

1. Use file-type data storage, such as `SharedPreferences`, configure `SDK` usage, add code to obtain label data in the configuration location.

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

After SDK initialization is complete, using `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)`, custom labels can be dynamically added. After setting, it will take effect immediately. Subsequently, RUM or Log reported data will automatically add label data. This usage method is suitable for scenarios where label data needs to be obtained with network requests delayed.

```java
//SDK initialization pseudocode, set labels after obtaining parameters from the network

FTSdk.init() 

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}

```


## Common Issues {#FAQ}
### Add Local Variables to Avoid Field Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to add a project abbreviation prefix to tag names, for example `df_tag_name`, project `key` values can be [queried in source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When SDK global variables appear with the same variables in RUM and Log, RUM and Log will overwrite the global variables in the SDK.

### SDK Compatibility

* [Runnable environment](app-troubleshooting.md#runnable)
* [Compatible environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Reviews {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
The SDK better associates data from the same user by using Android ID. If you need to publish the application on an app market, you need to adapt to market privacy reviews through the following way.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // Set setEnableAccessAndroidID to false in initialization settings
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

	        //Set setEnableAccessAndroidID to false in initialization settings
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
If you need to delay loading the SDK in the application, it is recommended to initialize it in the following way.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    //If already agreed to the protocol, initialize in Application
			if(agreeProtocol){
				FTSdk.init(); //SDK initialization pseudocode
			}
		}
	}
	
	// Privacy Declaration Activity page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			//			//Not yet read the privacy statement
			if ( notReadProtocol ) {
			    //Show privacy statement popup
				showProtocolView();

			    //If agree to the privacy statement
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
	        // If already agreed to the protocol, initialize in Application
	        if (agreeProtocol) {
	            FTSdk.init() //SDK initialization pseudocode
	        }
	    }
	}
	
	// Privacy Declaration Activity page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Not yet read the privacy statement
	        if (notReadProtocol) {
	            // Show privacy statement popup
	            showProtocolView()

	            // If agree to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init() //SDK initialization pseudocode
	            }
	        }
	    }
	}
	```
#### Third-Party Frameworks {#third-party}
`flutter`, `react-native`, `uni-app`, `unity` can use a similar delayed initialization method as the native Android above to adapt to application market privacy reviews.

### How to Integrate SDK Without Using ft-plugin {#manual-set}
<<< custom_key.brand_name >>> uses Androig Grale Plugin Transformation to implement code injection, thereby achieving automatic data collection. However, due to some compatibility issues, it may not be possible to use `ft-plugin`. Affected includes **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic upload of symbol files.

Currently, for such situations, we have another integration solution. The response plan is as follows:

* Application startup events need to call before SDK initialization, refer to source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

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
		//Needs to be called before SDK initialization
	        FTAutoTrack.startApp(null)
	        //Set SDK configuration
	        setSDK(this)

	    }
	```

* Key events need to be added manually at the trigger location, for example, Button onClick event, refer to source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* `OKhttp` integrates `Resource` and `Trace` through `addInterceptor`, `eventListener`, as shown below, refer to source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt):

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

* Other network frameworks need to implement `FTRUMGlobalManager`'s `startResource`, `stopResource`, `addResource`, `FTTraceManager.getTraceHeader` manually. For specific implementation methods, please refer to the source code example [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).