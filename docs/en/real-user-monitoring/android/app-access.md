# Android App Integration
---

By collecting metrics data from Android apps, analyze app performance in a visualized way.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been enabled, the prerequisites are already configured and you can directly integrate the app.

- Install [DataKit](../../datakit/datakit-install.md);  
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit is configured to be [publicly accessible with an IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## App Integration {#android-integration} 

1. Go to **User Analysis > Create > Android**;
2. Input the app name;
3. Input the app ID;
4. Choose the integration method:

    - Public DataWay: Directly receives RUM data without needing to install the DataKit collector.  
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the remote repository address for `SDK` in the `build.gradle` file at the root directory of the project.

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //Add the remote repository address for SDK
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //Add Plugin dependency, requires AGP 7.4.2 or higher, Gradle 7.2.0 or higher
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP versions below 7.4.2, use ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //Add the remote repository address for SDK
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
	        //Add the remote repository address for SDK
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
	        //Add the remote repository address for SDK
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//Add Plugin dependency, requires AGP 7.4.2 or higher, Gradle 7.2.0 or higher
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		// For AGP versions below 7.4.2, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* Add `SDK` dependencies and `Plugin` usage, along with Java 8 support in the main module `app`'s `build.gradle` file.

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency to capture native layer crash information, must be used with ft-sdk and cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //Recommended version, other versions have not undergone sufficient compatibility testing
    implementation 'com.google.code.gson:gson:2.8.5'

}
//Apply plugin
apply plugin: 'ft-plugin'   //If using old version compatible ft-plugin-legacy, no change needed
//Configure plugin usage parameters
FTExt {
    //Whether to display Plugin logs, default is false
    showLog = true
	
    //Set ASM version, supports asm7 - asm9, default is asm9
    //asmVersion='asm7'

    //ASM ignore path configuration, paths with . and / are equivalent
    //ignorePackages=['com.ft','com/ft']

	//native so specified path, only need to specify the upper directory of the abi file
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
            //When using ft-native to capture native layer crash information, select supported abi architectures based on the application's platform
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

> The latest versions can be seen above in the ft-sdk, ft-plugin, and ft-native version names.

## Application Configuration {#application-setting}

Theoretically, the best place for SDK initialization is in the `Application`'s `onCreate` method. If your application does not yet have an `Application`, you need to create one and declare it in `AndroidManifest.xml`. Example reference [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

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
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, default port 9529, the device where the SDK is installed needs to access this address. **Note: choose either datakit or dataway configuration**|
| datawayUrl | String | Yes | Public Dataway access URL address, example: http://10.0.0.1:9528, default port 9528, the device where the SDK is installed needs to access this address. **Note: choose either datakit or dataway configuration** |
| clientToken | String | Yes | Authentication token, must be configured with datawayUrl  |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, enabling will allow printing of SDK runtime logs |
| setEnv | EnvType | No | Set collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set collection environment, default is `prod`. **Note: configure either String or EnvType type**|
| setOnlySupportMainProcess | Boolean | No | Whether to only run in the main process, default is `true` , if execution is needed in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable obtaining `Android ID`, default is `true`, setting to `false` will prevent collection of `device_uuid` data, market privacy review related[view here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add SDK global properties, refer to [here](#key-conflict) for addition rules |
| setServiceName | String | No | Set service name, affects `service` field data in Log and RUM, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable automatic synchronization, default is `true`. When set to `false`, use `FTSdk.flushSyncData()` to manage data synchronization manually |  
| setSyncPageSize | Int | No | Set the number of items per sync request, `SyncPageSize.MINI` 5 items, `SyncPageSize.MEDIUM` 10 items, `SyncPageSize.LARGE` 50 items, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set the number of items per sync request, range [5,), note that the larger the number of items, the more computational resources are required, default is 10 **Note: only configure one of setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set the inter-sync sleep time, range [0,5000], default is not set |
| enableDataIntegerCompatible | Void | No | It is recommended to enable when coexisting with web data. This configuration handles web data type storage compatibility issues. Version 1.6.9 enables this by default |
| setNeedTransformOldCache | Boolean | No | Whether to transform old cache data from versions below ft-sdk 1.6.0, default is `false` |
| setCompressIntakeRequests | Boolean | No | Compress sync data, ft-sdk versions 1.6.3 and above support this method |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default is 100MB, unit is Byte, larger databases increase disk pressure, default is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become ineffective. ft-sdk versions 1.6.6 and above support this method |

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
| setRumAppId | String | Yes | Set `Rum AppId`. Corresponds to setting RUM `appid`, which will enable RUM data collection, [get appid method](#android-integration) |
| setSamplingRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling will display error stack data in error analysis.<br> [Regarding deobfuscation of crash logs](#retrace-log).<br><br>ft-sdk 1.5.1 and above versions, can set whether logcat is displayed in Java Crash and Native Crash through `extraLogCatWithJavaCrash`, `extraLogCatWithNativeCrash` |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, add additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery level, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU usage |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, add monitoring data during the View lifecycle, `DeviceMetricsMonitorType.BATTERY` monitors the highest output current of the current page, `DeviceMetricsMonitorType.MEMORY` monitors the current application's memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU jumps, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring frequency, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`.<br><br>ft-sdk 1.5.1 and above versions, can set whether logcat is displayed in ANR through `extraLogCatWithANR` |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, ft-sdk 1.6.4 and above versions can control the detection time range [100,) in milliseconds, default is 1 second |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user actions, currently only supports user start and click operations, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically track user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Scope: Only affects default collection when `EnableTraceUserResource` is set to true. For custom Resource collection, use `FTResourceEventListener.FTFactory(true)` to enable this feature. Additionally, there is an IP cache mechanism for single Okhttp instances targeting the same domain; under the premise that the IP connection to the server does not change, only one instance will be generated |
| setResourceUrlHandler | Callback| No | Set filtering conditions for Resources, default is no filtering |
| setOkHttpEventListenerHandler | Callback| No | ASM sets global Okhttp EventListener, default is not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets global `FTResourceInterceptor.ContentHandlerHelper`, default is not set, ft-sdk 1.6.7 and above supports, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom tags, used to distinguish data sources for user monitoring. If tracking functionality is required, then parameter `key` should be `track_id` and `value` any numerical value. Refer to [here](#key-conflict) for notes on adding rules |
| setRumCacheLimitCount | int | No | Local cache limit count for RUM [10_000,), default is 100_000. ft-sdk 1.6.6 and above supports |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set discard rule for data when RUM reaches its limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards oldest data, ft-sdk 1.6.6 and above supports  |

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
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level correspondence<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning, <br> `prefix` is the filter parameter for the control prefix, default is no filter. Note: Android console volume is quite large, to avoid affecting application performance and reducing unnecessary resource waste, it is suggested to use `prefix` to filter out valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default is no filter |
| addGlobalContext | Dictionary | No | Add log global properties, refer to [here](#key-conflict) for addition rules |
| setLogCacheLimitCount | Int | No | Local cache maximum log entry limit [1000,), the larger the log, the greater the disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set the log discard rule when logs reach the limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards old data |

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
| setTraceType | TraceType | No | Set the type of trace, default is `DDTrace`, currently supports `Zipkin` , `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if choosing corresponding trace type when integrating OpenTelemetry, please consult supported types and agent configurations |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic HTTP trace, currently only supports OKhttp's automatic tracing, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets global `FTTraceInterceptor.HeaderHandler`, default is not set, ft-sdk 1.6.8 and above supports, refer to [custom Trace](#okhttp_resource_trace_interceptor_custom) for examples |

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
> startAction internally has a timing algorithm, during which it attempts to associate nearby occurring Resource, LongTask, Error data. There is a 100 ms frequent trigger protection, suggesting its use for user operation type data. If frequent calls are required, use addAction, this data will not conflict with startAction and will not associate with current Resource, LongTask, Error data.


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
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change This value will be changed to ft_value_change when stopView is called
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
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change This value will be changed to ft_value_change when stopView is called
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
	     * @param state     Program running status
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state)


	     /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType, AppState state)

	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
		 * @param property  Additional attributes
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
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
	     * @param state     Program running status
	     */
	    public void addError(String log, String message, String errorType, AppState state)


	     /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds
	     */
	    public void addError(String log, String message, long dateline, String errorType, AppState state)

	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param property  Additional attributes
	     */
	    public void addError(String log, String message, String errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
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
	     * @param state     Program running status
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param property  Additional attributes
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState, property: HashMap<String, Any>)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
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
	     * @param state     Program running status
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String, state: AppState)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
		 * @param property  Additional attributes
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState, property: HashMap<String, Any>)

		 /**
	     * Add error information
	     *
	     * @param log       Log
	     * @param message   Message
	     * @param errorType Error type
	     * @param state     Program running status
	     * @param dateline  Occurrence time, nanoseconds
		 * @param property  Additional attributes
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String,state: AppState, property: HashMap<String, Any>)

	```

#### Code Example

=== "Java"

	```java
	// Scenario 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// Scenario 2: Delayed recording of errors, this time generally refers to the time when the error occurred
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
	     */
	    public void startResource(String resourceId)

	    /**
	     * Resource start
	     *
	     * @param resourceId Resource Id
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * Resource termination
	     *
	     * @param resourceId Resource Id
	     */
	    public void stopResource(String resourceId)

	    /**
	     * Resource termination
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
	 * Resource termination
	 *
	 * @param resourceId Resource Id
	 */
	fun stopResource(resourceId: String)

	/**
	 * Resource termination
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
	// Request start
	FTRUMGlobalManager.get().startResource("resourceId");

	//...

	// Request end
	FTRUMGlobalManager.get().stopResource("resourceId");

	// Finally, after the request ends, send related data metrics for the request
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


	// Scenario 2 : Use dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change This value will be changed to ft_value_change when stopResource is called
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// Scenario 1
	//Request start
	FTRUMGlobalManager.get().startResource("resourceId")

	//Request end
	FTRUMGlobalManager.get().stopResource("resourceId")

	//Finally, after the request ends, send related data metrics for the request
	val params = ResourceParams()
	params.url = "https://<<< custom_key.brand_main_domain >>>"
	params.responseContentType = response.header("Content-Type")
	arams.responseConnection = response.header("Connection")
	params.responseContentEncoding = response.header("Content-Encoding")
	params.responseHeader = response.headers.toString()
	params.requestHeader = request.headers.toString()
	params.resourceStatus = response.code
	params.resourceMethod = request.method

	val bean = NetStatusBean()
	bean.tcpStartTime = 60000000
	//...
	FTRUMGlobalManager.get().addResource("resourceId",params,bean)

	// Scenario 2 : Use dynamic parameters
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)

	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change"
	)
	// ft_key_will_change This value will be changed to ft_value_change when stopResource is called

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
| ResourceParams.responseContentType | No | Response ContentType | |
| ResourceParams.responseContentEncoding | No | Response ContentEncoding |  |
| ResourceParams.resourceMethod | No | Request method | GET, POST etc. |
| ResourceParams.responseBody | No | Returned body content | |
| ResourceParams.property| No | Additional attributes |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, requires enabling `FTLoggerConfig.setEnableCustomLog(true)`
> Current log content limit is 30 KB, any characters exceeding this will be truncated.

### Usage Method

=== "Java"

	```java
	    /**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    public void logBackground(String content, Status status)

	    /**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
		 * @param property Additional attributes
	     */
	    public void logBackground(String content, Status status, HashMap<String, Object> property)

		/**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    public void logBackground(String content, String status)

	    /**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
		 * @param property Additional attributes
	     */
	    public void logBackground(String content, String status, HashMap<String, Object> property)


	    /**
	     * Store multiple log entries locally for synchronization
	     *
	     * @param logDataList {@link LogData} list
	     */
	    public void logBackground(List<LogData> logDataList)


	```

=== "Kotlin"

	```kotlin

	    /**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    fun logBackground(content: String, status: Status)

	    /**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log attributes
	     */
	    fun logBackground(content: String, status: Status, property: HashMap<String, Any>)

		/**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     */
	    fun logBackground(content: String, status: String)

	    /**
	     * Store a single log entry locally for synchronization
	     *
	     * @param content Log content
	     * @param status  Log level
	     * @param property Log attributes
	     */
	    fun logBackground(content: String, status: String, property: HashMap<String, Any>)

	    /**
	     * Store multiple log entries locally for synchronization
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

## Tracer Network Link Trace

Configure `FTTraceConfig` to enable `enableAutoTrace` automatically adding trace data, or manually use `FTTraceManager` in Http requests with `Propagation Header`, as shown below:

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

When both `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace` are enabled simultaneously, the custom `Interceptor` configuration has priority.
 > For ft-sdk versions < 1.4.1, need to disable `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace`.
 > For ft-sdk versions > 1.6.7, support associating custom Trace Headers with RUM data.

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
                       //copy part of body to avoid consuming large data
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
            // Handle exception case
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
| setExts | Set user extensions | No | Refer to [here](#key-conflict) for addition rules|

### Code Example

=== "Java"

	```java
	// Can call this method after successful user login to bind user information
	FTSdk.bindRumUserData("001");

	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);

	// Can call this method after user logout to unbind user information
	FTSdk.unbindRumUserData();

	```

=== "Kotlin"

	```kotlin
	//Can call this method after successful user login to bind user information
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

	//Can call this method after user logout to unbind user information
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
	// If dynamically changing SDK configuration, need to close first to prevent incorrect data generation
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	// If dynamically changing SDK configuration, need to close first to prevent incorrect data generation
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

## Synchronizing Data Actively
Use `FTSdk` to actively synchronize data.
> When `FTSdk.setAutoSync(false)`, manual data synchronization is required.

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



## Dynamically Enabling or Disabling AndroidID Acquisition
Use `FTSdk` to set whether to acquire Android ID in the SDK

### Usage Method

=== "Java"

	```java
	   /**
	     * Dynamically control acquisition of Android ID
	     *
	     * @param enableAccessAndroidID True to apply, false not to apply
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Dynamically control acquisition of Android ID
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

Use `FTSdk` to dynamically add tags during SDK runtime

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

### ft-sdk Library
-keep class com.ft.sdk.**{*;}

### ft-native Library
-keep class ftnative.*{*;}

### Prevent Action name from being obfuscated when getting action_name
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (Only supports datakit[local deployment])
The `ft-plugin` version needs `1.3.0` or higher to support the latest symbol file upload rules, supporting `productFlavor` multi-version management. The plugin will execute symbol file upload after `gradle task assembleRelease`. Detailed configurations can be referenced in [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, no need to configure when generateSourceMapOnly=true
    datawayToken = 'dataway_token' 		// space token, no need to configure when generateSourceMapOnly=true
    appId = "appid_xxxxx"				// appid, no need to configure when generateSourceMapOnly=true
    env = 'common'						// environment, no need to configure when generateSourceMapOnly=true
	generateSourceMapOnly = false //Generate sourcemap only, default is false, path example: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, ft-plugin:1.3.4 and above versions support

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
Use `plugin` with `generateSourceMapOnly = true` to generate through `gradle task assembleRelease` or package into a `zip` file manually, then upload to `datakit` or upload via <<< custom_key.brand_name >>> Studio, recommended to use `zip` command line to package to avoid including system hidden files in the `zip` package. Symbol upload reference [sourcemap upload](../sourcemap/set-sourcemap.md)

> Unity Native Symbol files refer to [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Description

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitates precise data analysis, affects the acquisition of cellular network information in SDK |

> For details on how to request dynamic permissions, refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

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
For WebView data monitoring, integrate the [Web Monitoring SDK](../web/app-access.md) on the accessed page.

## Custom Tag Usage Example {#track}

### Compilation Configuration Method

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
### Runtime Read/Write File Method

1. Through file type data storage, such as `SharedPreferences`, configure the use of `SDK`, add code to get tag data in the configuration location.

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

After the SDK is initialized, you can dynamically add tags using `FTSdk.appendGlobalContext(globalContext)`、`FTSdk.appendRUMGlobalContext(globalContext)`、`FTSdk.appendLogGlobalContext(globalContext)`. After setting, it takes effect immediately. Subsequent data reported by RUM or Log will automatically include tag data. This usage method is suitable for scenarios where tag data needs to be obtained with delay, such as when tag data requires network requests to obtain.

```java
//SDK Initialization pseudocode, set tags after obtaining parameters from the network

FTSdk.init() 

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}

```


## Common Issues {#FAQ}
### Adding Local Variables to Avoid Key Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix labels with **project abbreviation**, such as `df_tag_name`. Keys used in the project can be [queried in source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). When global variables in SDK appear identical to those in RUM, Log, RUM and Log will override the global variables in SDK.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
The SDK uses Android ID to better associate data from the same user. If you need to list your app on an app market, you can handle market privacy audits as follows.

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
#### Method 2: Delayed SDK Initialization
If you need to delay loading the SDK in your application, it is recommended to initialize it as follows.

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
	
	// Privacy Statement Activity Page
	public class MainActivity extends Activity