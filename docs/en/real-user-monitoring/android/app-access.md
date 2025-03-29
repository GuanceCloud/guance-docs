# Android Application Integration
---

By collecting metric data from Android applications, analyze application performance in a visualized manner.

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been activated, the prerequisites are automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit is configured to be [publicly accessible and the IP geographic information database is installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#android-integration} 

1. Navigate to **User Analysis > Create Application > Android**;
2. Enter the application name;
3. Input the application ID;
4. Choose the application integration method:

    - Public Network DataWay: Directly receives RUM data without installing the DataKit collector.
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.


## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=mini.sdk&color=green&query=$.android_mini_sdk&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/info.json&link=https://github.com/GuanceCloud/datakit-android) 

**Source Code Address**: [https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle Configuration {#gradle-setting}

* Add the `SDK` remote repository address in the root directory's `build.gradle` file of the project.

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
	        //Add Plugin dependency, AGP 7.4.2 or above, Gradle 7.2.0 or above
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // For AGP versions below 7.4.2, use ft-plugin-legacy 
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
		//Add Plugin dependency, AGP 7.4.2 or above, Gradle 7.2.0 or above
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		//For AGP versions below 7.4.2, use ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


* Add `SDK` dependencies and `Plugin` usage in the `app` main module's `build.gradle` file along with Java 8 support.

```groovy
dependencies {
    //Add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //Dependency for capturing native layer crash information, must be used together with ft-sdk, cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //It is recommended to use this version; other versions have not undergone sufficient compatibility testing
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

	// Specify native so path, only need to specify the upper directory of abi files
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
	//... omitted some code
	defaultConfig {
        //... omitted some code
        ndk {
            //When using ft-native to capture native layer crashes, choose supported abi architectures based on the app's platform compatibility.
            //Currently ft-native includes abi architectures such as 'arm64-v8a',
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

> The latest versions can be found above under ft-sdk, ft-plugin, and ft-native version names.

## Application Configuration {#application-setting}

In theory, the best place for SDK initialization is within the `Application`'s `onCreate` method. If your application hasn't yet created an `Application`, you need to create one and declare it in `AndroidManifest.xml`. Example reference [here](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml).

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
| datakitUrl | String | Yes | Datakit access URL address, example: http://10.0.0.1:9529, default port 9529, the device where the SDK is installed needs to access this address. **Note: datakit and dataway configurations select one of the two**|
| datawayUrl | String | Yes | Public Dataway access URL address, example: http://10.0.0.1:9528, default port 9528, the device where the SDK is installed needs to access this address. **Note: datakit and dataway configurations select one of the two** |
| clientToken | String | Yes | Authentication token, needs to be configured with datawayUrl |
| setDebug | Boolean | No | Whether to enable debug mode. Default is `false`, enabling will allow printing of SDK runtime logs |
| setEnv | EnvType | No | Set collection environment, default is `EnvType.PROD` |
| setEnv | String | No | Set collection environment, default is `prod`. **Note: Only configure one of String or EnvType types**|
| setOnlySupportMainProcess | Boolean | No | Whether to only run in the main process, default is `true`, if execution is needed in other processes, set this field to `false` |
| setEnableAccessAndroidID | Boolean | No | Enable obtaining `Android ID`, default is `true`, setting to `false` means that the `device_uuid` field data will not be collected, refer to market privacy reviews [view here](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | No | Add global attributes for SDK, see [here](#key-conflict) for addition rules |
| setServiceName | String | No | Set service name, affects Log and RUM service field data, default is `df_rum_android` |
| setAutoSync | Boolean | No | Whether to enable auto synchronization, default is `true`. When set to `false`, use `FTSdk.flushSyncData()` to manage data synchronization manually |  
| setSyncPageSize | Int | No | Set number of entries per sync request, `SyncPageSize.MINI` 5 entries, `SyncPageSize.MEDIUM` 10 entries, `SyncPageSize.LARGE` 50 entries, default `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | Enum | No | Set number of entries per sync request, range [5,), note larger entry counts mean more computational resources consumed, default is 10 **Note: Only configure one of setSyncPageSize and setCustomSyncPageSize**   |
| setSyncSleepTime | Int | No | Set sync interval time, range [0,5000], default not set  |
| enableDataIntegerCompatible | Void | No | Suggested to enable when coexisting with web data. This configuration handles web data type storage compatibility issues. Default enabled in version 1.6.9  |
| setNeedTransformOldCache | Boolean | No | Whether to transform old cache data from versions below ft-sdk 1.6.0, default is `false` |
| setCompressIntakeRequests | Boolean | No | Compress sync data, supported by ft-sdk 1.6.3 and above versions |
| enableLimitWithDbSize | Void | No | Enable limiting data size using db, default is 100MB, unit Byte, larger databases increase disk pressure, default is not enabled.<br>**Note:** After enabling, `FTLoggerConfig.setLogCacheLimitCount` and `FTRUMConfig.setRumCacheLimitCount` will become ineffective. Supported by ft-sdk 1.6.6 and above versions |

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
| setRumAppId | String | Yes | Sets `Rum AppId`. Corresponds to RUM `appid`, enables RUM collection functionality, [method to obtain appid](#android-integration) |
| setSamplingRate | Float | No | Set collection rate, value range [0,1], 0 indicates no collection, 1 indicates full collection, default value is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id |
| setEnableTrackAppCrash | Boolean | No | Whether to report App crash logs, default is `false`, enabling will display error stack data in error analysis.<br> [About converting obfuscated content in crash logs](#retrace-log).<br><br>ft-sdk 1.5.1 and above versions, can set whether to display logcat in Java Crash and Native Crash via `extraLogCatWithJavaCrash` and `extraLogCatWithNativeCrash` |
| setExtraMonitorTypeWithError | Array| No | Set auxiliary monitoring information, adds additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` is battery level, `ErrorMonitorType.MEMORY` is memory usage, `ErrorMonitorType.CPU` is CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Set View monitoring information, during the View cycle, add monitoring data, `DeviceMetricsMonitorType.BATTERY` monitors the highest output current for the current page, `DeviceMetricsMonitorType.MEMORY` monitors current application memory usage, `DeviceMetricsMonitorType.CPU` monitors CPU fluctuations, `DeviceMetricsMonitorType.FPS` monitors screen frame rate. Monitoring frequency, `DetectFrequency.DEFAULT` 500 milliseconds, `DetectFrequency.FREQUENT` 100 milliseconds, `DetectFrequency.RARE` 1 second |
| setEnableTrackAppANR | Boolean | No | Whether to enable ANR detection, default is `false`. <br><br>ft-sdk 1.5.1 and above versions, can set whether to display logcat in ANR via `extraLogCatWithANR` |
| setEnableTrackAppUIBlock | Boolean, long  | No | Whether to enable UI lag detection, default is `false`, ft-sdk 1.6.4 and above versions can control detection time range [100,) via `blockDurationMs`, unit milliseconds, default is 1 second |
| setEnableTraceUserAction | Boolean | No | Whether to automatically track user actions, currently only supports user start and click operations, default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page operations, default is `false` |
| setEnableTraceUserResource | Boolean | No | Whether to automatically trace user network requests, only supports `Okhttp`, default is `false` |
| setEnableResourceHostIP | Boolean | No | Whether to collect the IP address of the requested target domain. Affects only default collection when `EnableTraceUserResource` is true. For custom Resource collection, use `FTResourceEventListener.FTFactory(true)` to enable this feature. Additionally, Okhttp has an IP cache mechanism for the same domain, only one generation occurs when connected to the server IP does not change, given the same `OkhttpClient` |
| setResourceUrlHandler | Callback| No | Set conditions to filter Resources, default does not filter |
| setOkHttpEventListenerHandler | Callback| No | ASM sets global Okhttp EventListener, default not set |
| setOkHttpResourceContentHandler | Callback| No | ASM sets global `FTResourceInterceptor.ContentHandlerHelper`, default not set, ft-sdk 1.6.7 and above supports, [custom Resource](#okhttp_resource_trace_interceptor_custom) |
| addGlobalContext | Dictionary | No | Add custom labels, used for distinguishing user monitoring data sources. If tracking functionality is needed, parameter `key` is `track_id`, `value` is any value, see [here](#key-conflict) for addition rule notes |
| setRumCacheLimitCount | int | No | Local cache RUM limit count [10_000,), default is 100_000. ft-sdk 1.6.6 and above supports |
| setRumCacheDiscardStrategy | RUMCacheDiscard | No | Set discard rule for RUM data when reaching limit, default is `RUMCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards oldest data, ft-sdk 1.6.6 and above supports |

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
| setSamplingRate | Float | No | Set collection rate, value range [0,1], 0 indicates no collection, 1 indicates full collection, default value is 1. |
| setEnableConsoleLog | Boolean | No | Whether to report console logs, log level correspondence<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning, <br> `prefix` is the control prefix filtering parameter, default does not set filtering. Note: Android console volume is large, to avoid affecting application performance and reducing unnecessary resource waste, it is suggested to use `prefix` to filter out valuable logs |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableCustomLog | Boolean| No | Whether to upload custom logs, default is `false` |
| setLogLevelFilters | Array | No | Set log level filters, default not set |
| addGlobalContext | Dictionary | No | Add global attributes for logs, see [here](#key-conflict) for addition rules |
| setLogCacheLimitCount | Int | No | Local cache maximum log entry limit [1000,), larger logs represent greater disk cache pressure, default is 5000   |
| setLogCacheDiscardStrategy| LogCacheDiscard | No | Set log discard rule when reaching limit, default is `LogCacheDiscard.DISCARD`, `DISCARD` discards appended data, `DISCARD_OLDEST` discards oldest data |

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
| setSamplingRate | Float | No | Set collection rate, value range [0,1], 0 indicates no collection, 1 indicates full collection, default value is 1. |
| setTraceType | TraceType | No | Set trace type, default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if choosing corresponding trace type while integrating OpenTelemetry, please refer to supported types and agent related configurations |
| setEnableLinkRUMData | Boolean | No | Whether to link with RUM data, default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic http trace, currently only supports OKhttp's automatic tracing, default is `false` |
| setOkHttpTraceHeaderHandler | Callback| No | ASM sets global `FTTraceInterceptor.HeaderHandler`, default not set, ft-sdk 1.6.8 and above supports, example reference [custom Trace](#okhttp_resource_trace_interceptor_custom) |

## RUM User Data Tracking {#rum-trace}

Configure `FTRUMConfig` with `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` to achieve automatic data acquisition or manually use `FTRUMGlobalManager` to add these data, examples as follows:

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
		 * @param duration   Nanoseconds, duration
		 * @param property Extended attributes
		 */
		fun addAction(actionName: String, actionType: String, duration: Long, property: HashMap<String, Any>)

	```
> startAction internally has a timing algorithm, attempting to associate nearby occurring Resource, LongTask, Error data during calculations, with a 100 ms frequent trigger protection, suggesting use for user operation type data. If frequent calls are needed, use addAction, this data will not conflict with startAction and will not associate with current Resource, LongTask, Error data.


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
	     * view stop
	     */
	    public void stopView()

	    /**
	     * view stop
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
	     * view stop
	     */
		fun stopView()

		 /**
	     * view stop
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
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be modified to ft_value_change at stopView
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
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change this value will be modified to ft_value_change at stopView
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

	// Scene 2: Delayed recording of occurred errors, generally the time of error occurrence
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000L, ErrorType.JAVA, AppState.RUN);

	// Scene 3: Dynamic parameters
	HashMap<String, Object> map = new HashMap<>();
	map.put```java
("ft_key", "ft_value");
FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN, map);
```

=== "Kotlin"

```kotlin
// Scene 1:
FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN)

// Scene 2: Delayed recording of occurred errors, generally the time of error occurrence
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
     * resource stop
     *
     * @param resourceId Resource Id
     */
    public void stopResource(String resourceId)

    /**
     * resource stop
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
 * resource stop
 *
 * @param resourceId Resource Id
 */
fun stopResource(resourceId: String)

/**
 * resource stop
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

// Finally, after the request ends, send request-related data metrics
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
map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change this value will be modified to ft_value_change at stopResource
FTRUMGlobalManager.get().stopResource(uuid,map);
```

=== "Kotlin"

```kotlin
// Scene 1
//Request start
FTRUMGlobalManager.get().startResource("resourceId")

//Request end
FTRUMGlobalManager.get().stopResource("resourceId")

//Finally, after the request ends, send request-related data metrics
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
// ft_key_will_change this value will be modified to ft_value_change at stopResource

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
| ResourceParams.resourceMethod | No | Request method | GET, POST, etc. |
| ResourceParams.responseBody | No | Response body content | |
| ResourceParams.property| No | Additional attributes |  |

## Logger Log Printing {#log} 
Use `FTLogger` for custom log output, enabling requires `FTLoggerConfig.setEnableCustomLog(true)`
> Current log content is limited to 30 KB, exceeding characters will be truncated.

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
     * @param logDataList List of {@link LogData}
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
     * @param logDataList List of log data
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

## Tracer Network Trace

Configure `FTTraceConfig` to enable `enableAutoTrace` for automatic trace data addition or manually use `FTTraceManager` to propagate headers in HTTP requests, as shown below:

=== "Java"

```java
String url = "https://<<< custom_key.brand_main_domain >>>";
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
val url = "https://<<< custom_key.brand_main_domain >>>"
val uuid ="uuid"
//Get trace header parameters
val headers = FTTraceManager.get().getTraceHeader(uuid, url)

val client: OkHttpClient = OkHttpClient.Builder().addInterceptor { chain ->

                    val original = chain.request()
                    val requestBuilder = original.newBuilder()
                    //Add trace header parameters to the request
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

With `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace` configurations enabled, custom `Interceptor` configuration takes precedence.
> For ft-sdk versions < 1.4.1, `FTRUMConfig`'s `enableTraceUserResource` and `FTTraceConfig`'s `enableAutoTrace` must be disabled.
> ft-sdk versions > 1.6.7 support associating custom Trace Header with RUM data

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

				// Supported in version 1.6.7 and above
				 @Override
				 public String getSpanID() {
					return "span_id";
				 }
				// Supported in version 1.6.7 and above
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
                   //Copy part of the body to avoid consuming large data
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
            // Handle exception scenarios
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

```kotlin
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
| setExts | Set user extensions | No | Addition rules please refer to [here](#key-conflict)|

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


//Bind more user data
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

## Close SDK
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


```kotlin
    /**
     * Close running objects within the SDK
     */
    fun shutDown()
```

### Code Example
    
=== "Java"

```java
// If dynamically changing the SDK configuration, need to close first to avoid incorrect data generation
FTSdk.shutDown();
```

=== "Kotlin"

```kotlin
// If dynamically changing the SDK configuration, need to close first to avoid incorrect data generation
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


```kotlin
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
> `FTSdk.setAutoSync(false)` needs manual data synchronization

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

## Dynamically Enable or Disable AndroidID Acquisition
Use `FTSdk` to set whether to acquire Android ID within the SDK

### Usage Method

=== "Java"

```java
   /**
     * Dynamically control acquisition of Android ID
     *
     * @param enableAccessAndroidID True to apply, false otherwise
     */
    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
```

=== "Kotlin"

```kotlin
   /**
     * Dynamically control acquisition of Android ID
     *
     * @param enableAccessAndroidID True to apply, false otherwise
     */
    fun setEnableAccessAndroidID(enableAccessAndroidID:Boolean)
```

### Code Example

=== "Java"

```java
// Enable acquisition of Android ID
FTSdk.setEnableAccessAndroidID(true);

// Disable acquisition of Android ID
FTSdk.setEnableAccessAndroidID(false);
```

=== "Kotlin"

```kotlin
// Enable acquisition of Android ID
FTSdk.setEnableAccessAndroidID(true)

// Disable acquisition of Android ID
FTSdk.setEnableAccessAndroidID(false)
```

## Add Custom Tags

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

### Prevent Action name class obfuscation when getting Action
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## Symbol File Upload {#source_map}
### Plugin Upload (Only supports datakit【local deployment】)
The `ft-plugin` version needs to be `1.3.0` or higher to support the latest symbol file upload rules, supporting `productFlavor` multi-version management. The plugin executes symbol file upload after `gradle task assembleRelease`. Detailed configuration can be referenced from [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url' 	// datakit reporting address, generateSourceMapOnly=true does not require configuration
    datawayToken = 'dataway_token' 		// Space token, generateSourceMapOnly=true does not require configuration
    appId = "appid_xxxxx"				// App ID, generateSourceMapOnly=true does not require configuration
    env = 'common'						// Environment, generateSourceMapOnly=true does not require configuration
	generateSourceMapOnly = false // Only generate sourcemap, default is false, example path: /app/build/tmp/ft{flavor}SourceMapMerge-release.zip, ft-plugin:1.3.4 or higher supports

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
Use `plugin` with `generateSourceMapOnly = true`, execute `gradle task assembleRelease` to generate, or pack into a `zip` file manually, then upload to `datakit` or from <<< custom_key.brand_name >>> Studio, recommended to use `zip` command-line for packing to avoid including system hidden files into the `zip` package. Symbol upload reference [sourcemap upload](../sourcemap/set-sourcemap.md)

> Unity Native Symbol files please refer to [official documentation](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## Permission Configuration Explanation

| **Name** | **Required** | **Usage Reason** |
| --- | --- | --- |
| `READ_PHONE_STATE` | No | Used to obtain device information of the phone, facilitates precise data analysis, affects cellular network information acquisition in the SDK |

> For details on how to request dynamic permissions, refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP Ignore {#ingore_aop}
Add `@IngoreAOP` in methods covered by Plugin AOP to ignore ASM insertion

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
For WebView data monitoring, integrate [Web Monitoring SDK](../web/app-access.md) in the accessed page.

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

1. Use file-type data storage, such as `SharedPreferences`, configure `SDK` usage, add code to obtain tag data in the configuration section.

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

2. Add a method anywhere to change file data.

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

3. Restart the application finally, detailed steps can be seen in [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK Runtime Addition

After SDK initialization, use `FTSdk.appendGlobalContext(globalContext)`, `FTSdk.appendRUMGlobalContext(globalContext)`, `FTSdk.appendLogGlobalContext(globalContext)` to dynamically add tags. Once set, they take immediate effect. Subsequently, reported RUM or Log data will automatically include tag data. This usage method suits delayed data acquisition scenarios, such as tag data requiring network requests.

```java
//SDK Initialization pseudo-code, set tags after obtaining parameters from the network

FTSdk.init() 

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}
```

## Common Issues {#FAQ}
### Add Local Variables to Avoid Conflicts {#key-conflict}

To avoid conflicts between custom fields and SDK data, it's suggested to prefix tag names with **project abbreviations**, like `df_tag_name`. You can [check source code](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java) for keys used in the project. When global variables in SDK appear identical to RUM, Log variables, RUM, Log will override the global variables in the SDK.

### SDK Compatibility

* [Runnable Environment](app-troubleshooting.md#runnable)
* [Compatible Environment](app-troubleshooting.md#compatible) 

### Adapting to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](<<< homepage >>>/agreements/app-sdk-privacy-policy/)
#### Method 1: SDK AndroidID Configuration
The SDK uses Android ID to better associate data from the same user. If needed for app store listing, follow these steps to adapt to market privacy audits.

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
            .setEnableAccessAndroidID(false)

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
            FTSdk.init(); //SDK Initialization pseudo-code
        }
    }
}

// Privacy Declaration Activity Page
public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        //Not read privacy declaration
        if ( notReadProtocol ) {
            //Show privacy declaration popup
            showProtocolView();

            //If agree to privacy declaration
            if( agreeProtocol ){
                FTSdk.init(); //SDK Initialization pseudo-code
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
        //If already agreed to the protocol, initialize in Application
        if (agreeProtocol) {
            FTSdk.init() //SDK Initialization pseudo-code
        }
    }
}

// Privacy Declaration Activity Page
class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        //Not read privacy declaration
        if (notReadProtocol) {
            //Show privacy declaration popup
            showProtocolView()

            //If agree to privacy declaration
            if (agreeProtocol) {
                FTSdk.init() //SDK Initialization pseudo-code
            }
        }
    }
}
```
#### Third-Party Frameworks {#third-party}
For `flutter`, `react-native`, `unity`, similar delayed initialization approaches can be used to adapt to app store privacy audits.

### How to Integrate SDK Without Using ft-plugin {#manual-set}
<<< custom_key.brand_name >>> uses Android Gradle Plugin Transformation to achieve code injection for automatic data collection. However, due to some compatibility issues, there might be cases where `ft-plugin` cannot be used. Affected functionalities include **RUM** `Action`, `Resource`, and `android.util.Log`, Java and Kotlin `println` **console log auto-capture**, and automatic symbol file upload.

Currently, for such situations, we have an alternative integration solution as follows:

* Application launch events, reference source code example [DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo