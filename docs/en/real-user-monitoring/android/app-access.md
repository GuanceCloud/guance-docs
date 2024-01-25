# Android Application Access
---

## Overview

Guance Real User Monitoring can analyze the performance of each Android application in a visual way by collecting the metrics data of each Android application.

## Precondition

- Installing [DataKit](../../datakit/datakit-install.md)；  
- Collector Configuration [RUM Coloctor](../../integrations/rum.md)；
- DataKit Configure[ for public access and install IP geolocation services.](../../datakit/datakit-tools-how-to.md#install-ipdb)

## Android Application Access {#android-integration} 

Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click **[Create](../index.md#create)** to select the application type to get access.

- Guance allows DataWay to directly receive RUM data over the public network, without the need to install the DataKit collector. Simply configure the `site` and `clientToken` parameters.

![](../img/android_01.png)

- Guance also supports receiving RUM data through local environment deployment. This method requires meeting certain prerequisites.
![](../img/6.rum_android_1.png)

## Installation {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android)

**Source Code**：[https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**：[https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)



### Gradle Configuration {#gradle-setting}

Add the remote repository address of `DataFlux SDK` to the `build.gradle` file in the root of the project

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	         //add SDK remote repo url
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //add Plugin dependency AGP 7.4.2 above，Gradle 7.2.0 above
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // AGP 7.4.2 below，using ft-plugin-legacy  
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	         //add SDK remote repo url
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
	         //add SDK remote repo url
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
	         //add SDK remote repo url
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//add Plugin dependency AGP 7.4.2 above，Gradle 7.2.0 above
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		// AGP 7.4.2 below，using ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


Add SDK dependencies and Plugin usage, and provide Java 8 support in the build.gradle file of the main module app of the project.

```groovy
dependencies {

    //add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    
    //native crash dependency, needs to be used with ft-sdk and cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    
    //Gson version recommend
    implementation 'com.google.code.gson:gson:2.8.5'

}
//add plugin setting 
apply plugin: 'ft-plugin'

//Configure Plugin Params
FTExt {
    //show plugin debug log
    showLog = true
}
android{
	//...
	defaultConfig {
        //...
        ndk {
            //When using ft-native ，need to set abi support for platforms
            // ft-native  abi contain 'arm64-v8a', 'armeabi-v7a', 'x86', 'x86_64'
            abiFilters 'armeabi-v7a'
        }
    }
    compileOptions {
        sourceCompatibility = 1.8
        targetCompatibility = 1.8
    }
}
```

> For the latest version, please see the version names of Agent and Plugin above


## SDK Initialization

### Basic Configuration {#base-setting}

=== "Java"

    ```java
    public class DemoApplication extends Application {

        @Override
        public void onCreate() {
            FTSDKConfig config = FTSDKConfig.builder(DATAKIT_URL)//Datakit Address
                    .setDebug(true);

            FTSdk.install(config);

            // ...
        }
    }
    ```

=== "Kotlin"

    ```kotlin
    class DemoApplication : Application() {
        override fun onCreate() {
            val config = FTSDKConfig
                .builder(DATAKIT_URL)//Datakit Address
                .setDebug(true);

            FTSdk.install(config)

            //...
        }
    }
    ```
The optimal location for initializing an SDK theoretically is in the `onCreate` method of the `Application` class. If your application hasn't created an `Application` class, you need to create one and declare it in the `Application` section of the `AndroidManifest.xml`. For an example, please refer to [this](https://github.com/GuanceCloud/datakit-android/blob/dev/demo/app/src/main/AndroidManifest.xml) example.

```xml
<application 
       android:name="YourApplication"> 
</application> 
```

| **Method Name** | **Type** | **Required** | **Meaning** |  **Attention** |
| ---  | --- | --- | --- | --- |
| datakitUrl |String| Yes | Datakit Address | The url of the Datakit address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed |
| datawayUrl | String | Yes | Dataway Address | The url of the Dataway address，example：http://10.0.0.1:9528，port 9528，Note: The installed SDK device must be able to access this address. Note: choose either DataKit or DataWay configuration, not both. |
| clientToken | String | Yes | Authentication token | It needs to be configured simultaneously with the datawayUrl |
| setDebug | Boolean | No |  Whether to turn on debug mode | Default is `false`, enable to print SDK run log |
| setEnv | EnvType|  No | Set the acquisition environment |Default is `EnvType.PROD` |
| setEnv | String | No | Set the acquisition environment | Default `prod` |
| setOnlySupportMainProcess |Boolean|  No | Does it only support running in the master process |Default is `true`, if you need to execute in other processes you need to set this field to `false` |
| setEnableAccessAndroidID |Boolean|  No | Enable to get `Android ID` | Default, is `true`, set to `false`, then `device_uuid` field data will not be collected, market privacy audit related [see here](#adpot-to-privacy-audits) |
| addGlobalContext| Dictionary |  No | Add SDK global properties |Adding rules can be found [here](#key-conflict) |
| setServiceName | String | No | Set Service Name | Impact the service field data in Log and RUM, which is set to `df_rum_android` by default.|

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

| **Method Name** | **Type** | **Required**| **Meaning**  | **Attention** |
| --- | --- | --- | --- | --- |
| setRumAppId | String | Yes | Set `Rum AppId`  | Corresponding to setting RUM `appid` to enable `RUM` collection, [get appid method](#android-integration) |
| setSampleRate | Float | No | Set Sample Rate | Sampling rate, with a range of [0,1], where 0 indicates no sampling and 1 indicates full sampling. The default value is 1. The scope covers all View, Action, LongTask, and Error data under the same session_id. |
| setEnableTrackAppCrash | Boolean  | No | Whether to report App crash logs |  Default is `false`, when enabled it will show the error stack data in the error analysis. <br/> [On the issue of obfuscated content conversion in the crash log](#retrace-log) |
| setExtraMonitorTypeWithError | Array | No |Set up auxiliary monitoring information |  Add additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery balance, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU occupancy |
| setDeviceMetricsMonitorType | Array | No | Setting View Monitoring Information | In the View cycle, add monitoring data, `DeviceMetricsMonitorType.BATTERY` to monitor the highest output current output of the current page, `DeviceMetricsMonitorType.MEMORY` to monitor the current application memory usage, ` CPU` monitors the number of CPU bounces, `DeviceMetricsMonitorType.FPS` monitors the screen frame rate |
| setEnableTrackAppANR | Boolean | No | Whether to turn on ANR detection | Default is `false` |
| setEnableTrackAppUIBlock | Boolean | No | Whether to enable UI lag detection | Default is `false` |
| setEnableTraceUserAction| Boolean | No |  Whether to automatically track user actions |Currently only user start and click operations are supported,  default is `false` |
| setEnableTraceUserView | Boolean | No | Whether to automatically track user page actions | Default is `false` |
| setEnableTraceUserResource| Boolean | No | Whether to automatically chase user network requests | Only `Okhttp` is supported, default is `false` |
| setResourceUrlHandler | callback | No | Configure Reousrce filter| Not filter default |
| setOkHttpEventListenerHandler | callback| No | Set global ASM Okhttp EventListener| Not set default |
| addGlobalContext | Dictionary | No | Add custom tags |  Add tag data for user monitoring data source distinction, if you need to use the tracking function, the parameter `key` is `track_id` ,`value` is any value, add rule notes please refer to [here](#key-conflict) |

#### Add Custom Tags {#track}

##### Static Use

1.Create multiple `productFlavors` in `build.gradle` to differentiate between tags

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

2.Add the corresponding `BuildConfig` constants to the `RUM` configuration

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... add other properties
	);
	
	```
	
=== "Kotlin"
	
	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… add other properties
	        )
	```

##### Dynamic Use

1.By storing file type data, such as `SharedPreferences`, configure the use of `SDK`, and add the code to get the tag data at the configuration.

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");
	
	// RUM Configure
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… add other properties
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")
	
	//RUM Configure
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… add other properties
	)
	```

2.Add a method to change the file data anywhere.


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

3.Finally restart the application, please see [SDK Demo](#setup) for more details.

### Log Configuration  {#log-config}

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

| **Method Name**  | **Type** | **Required** | **Meaning** | **Attention** |
| --- | --- | --- | --- | --- |
| setSampleRate | Float | No | Set acquisition rate  | The value of the acquisition rate ranges from >= 0, <= 1, and the default value is 1 |
| setEnableConsoleLog |Boolean| No | Whether to report console logs |  Log level correspondence<br>Log.v -> ok;<br>Log.i、Log.d -> info;<br>Log.e -> error;<br>Log.w -> warning，<br> `prefix` is the control prefix filter parameter, no filter is set by default |
| setEnableLinkRUMData |Boolean| No | Whether to associate with RUM data |  Default is `false` |
| setLogCacheDiscardStrategy | No |LogCacheDiscard| Set frequent log discard rules | Default is `LogCacheDiscard.DISCARD`, `DISCARD` to discard additional data, `DISCARD_OLDEST` to discard old data |
| setEnableCustomLog |Boolean| No | Whether to upload custom logs |  Default is `false` |
| setLogLevelFilters |Array| No | Set log level filtering |  Set level log filtering, no setting by default |
| addGlobalContext |Dictionary| No | Add log global property |  Adding rules can be found [here](#key-conflict) |

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

| **Method Name** | **Type**  | **Required** | **Meaning**  | **Attention** |
| --- | --- | --- | --- |--- |
| setSampleRate | Float  | No | Set sample rate | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。|
| setTraceType | TraceType | No | Set the type of tracing  | Default is `DDTrace`, currently support `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if you access OpenTelemetry to choose the corresponding trace type, please pay attention to check the supported types and agent-related configuration |
| setEnableLinkRUMData | Boolean | No | Whether to associate with RUM data  | Default is `false` |
| setEnableAutoTrace | Boolean | No | Set whether to enable automatic http trace | Currently only OKhttp auto-tracking is supported, the default is `false`. |
| setEnableWebTrace | Boolean | No | Set the webview to enable tracing or not  | alpha function, some scenarios may have partial js loading problems, default is `false` |


## RUM User Data Tracking {#rum-trace}

Configure enableTraceUserAction, enableTraceUserView, and enableTraceUserResource in FTRUMConfig to achieve the effect of automatically obtaining data, or manually use FTRUMGlobalManager to add this data. An example is shown below:

### Action

#### Method

=== "Java"

	```java
		/**
	     *  add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     */
	    public void startAction(String actionName, String actionType) 
	    
	    
	    /**
	     * add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     * @param property   extra property
	     */
	    public void startAction(String actionName, String actionType, HashMap<String, Object> property)
	
	```

=== "Kotlin"
	
	```kotlin
		/**
	     *  add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     */
		fun startAction(actionName: String, actionType: String)
		
		
		/**
	     * add action
	     *
	     * @param actionName action name
	     * @param actionType action type
	     * @param property   extra property
	     */
	    fun startAction(actionName: String, actionType: String, property: HashMap<String, Any>)
	
	```

#### Code Example

=== "Java"

	```java
	// Scene 1
	FTRUMGlobalManager.get().startAction("login", "action_type");
	
	// Secne 2:  extra property
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().startAction("login", "action_type", map);
	```

=== "Kotlin"

	```kotlin
	
	// Scene 1
	FTRUMGlobalManager.get().startAction("login", "action_type")
	
	// Secne 2:  extra property
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTRUMGlobalManager.get().startAction("login","action_type",map)
	
	```

### View

#### Method

=== "Java"

	```java
	
	    /**
	     * view start
	     *
	     * @param viewName Current View Name
	     */
	    public void startView(String viewName)
	    
	    
	    /**
	     * view start
	     *
	     * @param viewName Current View Name
	     * @param property Extra Property
	     */
	    public void startView(String viewName, HashMap<String, Object> property) 
	    
	    
	    /**
	     * view stop
	     */
	    public void stopView()
	    
	    /**
	     * view stop
	     *
	     * @param property  Extra Property
	     */
	    public void stopView(HashMap<String, Object> property)
	
	
	```

=== "Kotlin"

	```kotlin
	
		/**
	     * view start
	     *
	     * @param viewName Current View Name
	     */
		fun startView(viewName: String)
		
		 /**
	     * view start
	     *
	     * @param viewName Current View Name
	     * @param property Extra Property
	     */
		
		fun startView(viewName: String, property: HashMap<String, Any>)
		
		 /**
	     * view stop
	     */
		fun stopView()
		
		 /**
	     * view stop
	     *
	     * @param property Extra Property
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
	
	    // Scene 2: extra property
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
	
	    // Scene 2 : extra property
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key_will_change", "ft_value_change"); // ft_key_will_change will be changed to ft_value_change when stopResource is called.
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}
	```

=== "Kotlin"

	```kotlin
	override fun onResume() {
	     super.onResume()
	     
	     // Scene 1
	     FTRUMGlobalManager.get().startView("Current Page Name")
	     
	     // Scene 2: extra property
	     val map = HashMap<String, Any>()
	     map["ft_key"] = "ft_value"
	     map["ft_key_will_change"] = "ft_value"	
	     FTRUMGlobalManager.get().startView("Current Page Name", map)
	     
	}
	
	override fun onPause() {
	     super.onPause()
	     
	     // Scene 1
	     FTRUMGlobalManager.get().stopView()
	     
	     
	     // Scene 2 : extra property
	     val map = HashMap<String, Any>()
	     map["ft_key_will_change"] = "ft_value_change" // ft_key_will_change will be changed to ft_value_change when stopResource is called.
	     FTRUMGlobalManager.get().startView("Current Page Name", map)
	     
	}
	```

### Error

#### Method

=== "Java"

	```java
	    /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     */ 
	    public void addError(String log, String message, ErrorType errorType, AppState state)
	
	
	    /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     */
	public void addError(String log, String message, long dateline, ErrorType errorType, AppState state)
	
	    /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType
	     * @param state     application running state
	     * @param property
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state, HashMap<String, Object> property)
	
	
	    /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType,
	                         AppState state, HashMap<String, Object> property)
		
		/**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     */
	    public void addError(String log, String message, String errorType, AppState state)


	     /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     */
	    public void addError(String log, String message, long dateline, String errorType, AppState state)

	    /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param property  Extra Property
	     */
	    public void addError(String log, String message, String errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     * @param property  Extra Property
	     */
	    public void addError(String log, String message, long dateline, String errorType,
	                         AppState state, HashMap<String, Object> property)

	```

=== "Kotlin"

	```kotlin
		/**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState)
		 
		 /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     */ 
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType, state: AppState)
		
		 /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType
	     * @param state     application running state
	     * @param property  extra Property
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState, property: HashMap<String, Any>) 
		
		 /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType,state: AppState, property: HashMap<String, Any>)


			/**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState)

		 /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String, state: AppState)

		 /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param property  Extra Property
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState, property: HashMap<String, Any>)

		 /**
	     * add error data
	     *
	     * @param log       log content
	     * @param message   error message detail
	     * @param errorType 
	     * @param state     application running state
	     * @param dateline  Duration, in nanoseconds.
	     * @param property  Extra Property
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String,state: AppState, property: HashMap<String, Any>)

	```

#### Code Example

=== "Java"

	```java
	// Scene 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);
	
	// Scene 2:Delay recording the occurred error, typically until the time when the error occurred.
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000L, ErrorType.JAVA, AppState.RUN);
	
	// Scene 3：extra property
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN, map);
	```

=== "Kotlin"

	```kotlin
	
	// Scene 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN)
	
	// Scene 2:Delay recording the occurred error, typically until the time when the error occurred.
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000, ErrorType.JAVA, AppState.RUN)
	
	// Scene 3：extra property
	val map = HashMap<String, Any>()
	map["ft_key"] = "ft_value"
	FTRUMGlobalManager.get().addError("error log", "error msg",ErrorType.JAVA,AppState.RUN,map)
	
	```
	
### LongTask

#### Method

=== "Java"

	```java
	    /**
	     * add long task data
	     *
	     * @param log      log content
	     * @param duration Duration, in nanoseconds.
	     */
	    public void addLongTask(String log, long duration) 
	
	    /**
	     * add long task data
	     *
	     * @param log      log content
	     * @param duration Duration, in nanoseconds.
	     */
	    public void addLongTask(String log, long duration, HashMap<String, Object> property)
	
	```

=== "Kotlin"

	```kotlin
	    /**
	     * add long task data
	     *
	     * @param log      log content
	     * @param duration Duration, in nanoseconds.
	     */
		fun addLongTask(log: String, duration: Long) 
		
		/**
	     * add long task data
	     *
	     * @param log      log content
	     * @param duration Duration, in nanoseconds.
	     */
		
		fun addLongTask(log: String, duration: Long, property: HashMap<String, Any>)
	
	```

#### Code Example

=== "Java"

	```java
	// Scene 1 
	FTRUMGlobalManager.get().addLongTask("error log", 1000000L);
	
	// Scene 2:extra property
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addLongTask("", 1000000L, map);
	```

=== "Kotlin"


	```kotlin
	
	// Scene 1 
	FTRUMGlobalManager.get().addLongTask("error log",1000000L)
	
	// Scene 2:extra property
	 val map = HashMap<String, Any>()
	 map["ft_key"] = "ft_value"
	 FTRUMGlobalManager.get().addLongTask("", 1000000L,map)
	
	```

### Resource

#### Method

=== "Java"

	```java
	
	    /**
	     * resource start
	     *
	     * @param resourceId resource Id ，unique every request
	     */
	    public void startResource(String resourceId) 
	    
	    /**
	     * resource start
	     *
	     * @param resourceId resource Id ，unique every request
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property) 
	    
	    /**
	     * resource stop
	     *
	     * @param resourceId resource Id ，unique every request
	     */
	    public void stopResource(String resourceId)
	    
	    /**
	     * resource stop
	         *  
	     * @param resourceId resource Id ，unique every request
	     * @param property  extra property
	     */
	    public void stopResource(final String resourceId, HashMap<String, Object> property)
	    
	    
	    /**
	     * append network metrics and content data
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
	 * @param resourceId resource Id ，unique every request
	 */
	fun startResource(resourceId: String) {
	    // ...
	}
	
	/**
	 * resource start
	 *
	 * @param resourceId resource Id ，unique every request
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>) {
	    // ...
	}
	
	/**
	 * resource stop
	 *
	 * @param resourceId resource Id ，unique every request
	 */
	fun stopResource(resourceId: String) {
	    // ...
	}
	
	/**
	 * resource stop
	 *
	 * @param resourceId resource Id ，unique every request
	 * @param property  extra property
	 */
	fun stopResource(resourceId: String, property: HashMap<String, Any>) {
	    // ...
	}
	
	/**
	 * append network metrics and content data
	 *
	 * @param resourceId
	 * @param params
	 * @param netStatusBean
	 */
	fun addResource(resourceId: String, params: ResourceParams, netStatusBean: NetStatusBean) {
	    // ...
	}
	
	```

#### Code Example

=== "Java"

	```java
	
	// Scene 1
	// request start
	FTRUMGlobalManager.get().startResource("resourceId");
	
	//...
	
	// reqeust end
	FTRUMGlobalManager.get().stopResource("resourceId");
	
	//Finally, after the request ends, send request-related data metrics
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
	
	
	// Scene 2 ：Extra Property
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");
	
	FTRUMGlobalManager.get().startResource("resourceId",map);
	
	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); // ft_key_will_change will be changed to ft_value_change when stopResource is called.
	FTRUMGlobalManager.get().stopResource(uuid,map);
	
	```

=== "Kotlin"

	```kotlin
	// Scene 1
	//request start
	FTRUMGlobalManager.get().startResource("resourceId")
	
	//request end
	FTRUMGlobalManager.get().stopResource("resourceId")
	
	//Finally, after the request ends, send request-related data metrics
	val params = ResourceParams()
	params.url = "https://www.guance.com"
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
	
	// Scene 2 ：Extra Property
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)
	
	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change" 
	)
	// ft_key_will_change will be changed to ft_value_change when stopResource is called.
	
	FTRUMGlobalManager.get().stopResource(uuid, map)
	
	```

| **Method Name** | **Required** | **Meaning** |  **Description** |
| --- | --- | --- | --- |
| NetStatusBean.fetchStartTime | No | Request start time |  |
| NetStatusBean.tcpStartTime | No | tcp connection time  |  |
| NetStatusBean.tcpEndTime | No | tcp end time  |  |
| NetStatusBean.dnsStartTime | No | dns start time  |  |
| NetStatusBean.dnsEndTime | No | dns end time  |  |
| NetStatusBean.responseStartTime | No | Response start time  |  |
| NetStatusBean.responseEndTime | No | Response end time  |  |
| NetStatusBean.sslStartTime | No | ssl start time  |  |
| NetStatusBean.sslEndTime | No | ssl end time  |  |
| NetStatusBean.property| No | Extra Property  |  |
| ResourceParams.url | Yes | url address  |  |
| ResourceParams.requestHeader | No | Request header parameters  |  |
| ResourceParams.responseHeader | No | Response header parameters  |  |
| ResourceParams.responseConnection | No | Response Connection  |  |
| ResourceParams.responseContentType | No | Response ContentType  |  |
| ResourceParams.responseContentEncoding | No | Response ContentEncoding  |  |
| ResourceParams.resourceMethod | No | Request Method  | GET, POST, etc. |
| ResourceParams.responseBody | No | Return body content  |  |
| ResourceParams.property| No | Extra Property  |  |

## Logger Log Printing 
Using `FTLogger` print log

### Method

=== "Java"

	```java
	    /**
	     * store single log
	     *
	     * @param content log content
	     * @param status  log level
	     */
	    public void logBackground(String content, Status status)
	    
	    /**
	     *store single log
	     *
	     * @param content log content
	     * @param status  log level
	     */
	    public void logBackground(String content, Status status, HashMap<String, Object> property)
	    
	    
	    /**
	     * batch log
	     *
	     * @param logDataList {@link LogData} log list
	     */
	    public void logBackground(List<LogData> logDataList)
	    
	    
	```

=== "Kotlin"
	
	```kotlin
	
	    /**
	     *store single log
	     *
	     * @param content log content
	     * @param status  log level
	     */
	    fun logBackground(content: String, status: Status)
	    
	    /**
	     *store single log
	     *
	     * @param content log content
	     * @param status  log level
	     * @param property extra property
	     */
	    fun logBackground(content: String, status: Status, property: HashMap<String, Any>) 
	    
	    /**
	     * batch log
	     *
	     * @param logDataList log list
	     */
	    fun logBackground(logDataList: List<LogData>)
	
	```

#### log level

| **Constant**    | **Meaning**  |
|-----------------|--------------|
| Status.INFO     | info log     |
| Status.WARNING  | warning log  |
| Status.ERROR    | error log    |
| Status.CRITICAL | critical log |
| Status.OK       | recovery log |

### Code Example


=== "Java"
	
	```java
	// single log
	FTLogger.getInstance().logBackground("test", Status.INFO);
	
	// set extra property with HashMap
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTLogger.getInstance().logBackground("test", Status.INFO, map);
	
	// batch log
	List<LogData> logList = new ArrayList<>();
	logList.add(new LogData("test", Status.INFO));
	FTLogger.getInstance().logBackground(logList);
	```

=== "Kotlin"
	
	```kotlin
	//upload single log
	FTLogger.getInstance().logBackground("test", Status.INFO)
	
	//set extra property with HashMap
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTLogger.getInstance().logBackground("test", Status.INFO,map
	
	//batch log
	FTLogger.getInstance().logBackground(mutableListOf(LogData("test",Status.INFO)))
	```


## Tracer Network Trace Tracking

Configure FTTraceConfig to enable automatic addition of link data using enableAutoTrace, or manually use FTTraceManager to add Propagation Header in an HTTP request. An example is shown below:

=== "Java"

	```java
	String url = "https://www.guance.com";
	String uuid = "uuid";
	//get http header params
	Map<String, String> headers = FTTraceManager.get().getTraceHeader(uuid, url);
	
	OkHttpClient client = new OkHttpClient.Builder().addInterceptor(chain -> {
	    Request original = chain.request();
	    Request.Builder requestBuilder = original.newBuilder();
	        //add tracing headers
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
	//get http header params
	val headers = FTTraceManager.get().getTraceHeader(uuid, url)
	
	val client: OkHttpClient = OkHttpClient.Builder().addInterceptor { chain ->
	   
	                    val original = chain.request()
	                    val requestBuilder = original.newBuilder()
	                   
	                    //add tracing headers
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

 `FTRUMConfig`的`enableTraceUserResource` ，`FTTraceConfig`的 `enableAutoTrace` 配置，同时开启，优先加载自定义 `Interceptor` 配置
 >For ft-sdk versions earlier than 1.4.1, it is necessary to disable enableTraceUserResource in FTRUMConfig and enableAutoTrace in FTTraceConfig

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
                       // Copy and read only a portion of the body to avoid excessive consumption of large data.
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
                // Copy and read only a portion of the body to avoid excessive consumption of large data.
                val body = response.peekBody(33554432)
                extraData["df_response_body"] = body.string()
            }
        }

        override fun onException(e: Exception, extraData: HashMap<String, Any>) {

        }
    }))
    .eventListenerFactory(FTResourceEventListener.FTFactory())
    .build()
	```

## User Information Binding and Unbinding {#userdata-bind-and-unbind}
Using  `FTSdk` bind user data and unbind

### Method

=== "Java"

	```
	  
	   /**
	     * bind user infomation
	     *
	     * @param id
	     */
	    public static void bindRumUserData(@NonNull String id) 
	    
	    /**
	     * bind user infomation
	     */
	    public static void bindRumUserData(@NonNull UserData data)
	```

=== "Kotlin"

	``` kotlin
	/**
	     * bind user infomation
	     *
	     * @param id user ID
	     */
	    fun bindRumUserData(id: String) {
	        // TODO: implement bindRumUserData method
	    }
	    
	    /**
	     * bind user infomation
	     *
	     * @param data user infomation
	     */
	    fun bindRumUserData(data: UserData) {
	        // TODO: implement bindRumUserData method
	    }
	```
	

#### UserData
| **Method Name** | **Meaning**    | **Required** | **Description**                              |
|------------|----------------|--------------|----------------------------------------------|
| setId      | set user ID    | No           |                                              |
| setName    | set user name  | No           |                                              |
| setEmail   | set email      | No           |                                              |
| setExts    | set user extra | No           | More rules ，please view[Here](#key-conflict) |

### Code Example

=== "Java"

	```java
	// bind user info after log in
	FTSdk.bindRumUserData("001");
	
	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);
	
	//clear user data after log out
	FTSdk.unbindRumUserData();
	
	```

=== "Kotlin"

	```kotlin
	
	// bind user info after log in
	FTSdk.bindRumUserData("001")
	
	val userData = UserData()
	userData.name = "test.user"
	userData.id = "test.id"
	userData("test@mail.com")
	val extMap = HashMap<String, String>()
	extMap["ft_key"] = "ft_value"
	userData.setExts(extMap)
	            
	FTSdk.bindRumUserData(userData)
	
	//clear user data after log out
	FTSdk.unbindRumUserData()
	```

## Close SDK
Using `FTSdk`  to close SDK

### Method

=== "Java"

	```java
	     /**
	     * Close the running object inside the SDK
	     */
	    public static void shutDown()
	    
	```

=== "Kotlin"

	``` kotlin
	    /**
	     * Close the running object inside the SDK
	     */
	    fun shutDown()
	```

### Code Example

=== "Java"

	```java
	//If you dynamically change the SDK configuration, you need to close it first to avoid the generation of wrong data
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	//If you dynamically change the SDK configuration, you need to close it first to avoid the generation of wrong data
	FTSdk.shutDown()
	```

## Dynamically Turn On and Off to get AndroidID

Using `FTSdk` to set whether to get the Android ID in the SDK

### Method

=== "Java"

	```java
	   /**
	     * Close the running object inside the SDK
	     *
	     * @param enableAccessAndroidID 
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * Close the running object inside the SDK
	     *
	     * @param enableAccessAndroidID 
	     */
	    fun setEnableAccessAndroidID(enableAccessAndroidID:Boolean)
	```

### Code Example

=== "Java"

	```
	//enable access Android ID
	FTSdk.setEnableAccessAndroidID(true);
	
	//disable access Android ID
	FTSdk.setEnableAccessAndroidID(false);
	```

=== "Kotlin"

	```kotlin
	//enable access Android ID
	FTSdk.setEnableAccessAndroidID(true);
	
	//disable access Android ID
	FTSdk.setEnableAccessAndroidID(false);
	```

## R8 / Proguard Obfuscation Configuration

```c
-dontwarn com.ft.sdk.**

-keep class com.ft.sdk.**{*;}

-keep class ftnative.*{*;}

-keepnames class * extends android.view.View
```

## Symbol File Upload
### Plugin Upload
`ft-plugin` version needs to be `1.3.0` or higher to support symbol file upload, support `productFlavor` multi-version distinction management, plugin will execute upload symbol file after `gradle task assembleRelease`, detailed configuration can refer to [SDK Demo](#setup )

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url'
    datawayToken = 'dataway_token'
    appId = "appid_xxxxx"// appid
    env = 'common'

    prodFlavors { //prodFlavors override before
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
It is recommended to use the `zip` command line for packing, to avoid some system hidden files in the `zip` package, please refer to [sourcemap upload](. /... /datakit/rum.md#sourcemap)

## Permission Configuration Instructions

|**Name**| **Reasons for Use** |
| --- | --- |
| `READ_PHONE_STATE` | Used to obtain device information of cell phones for accurate analysis of data information |

> For details on how to apply dynamic permissions, please refer to [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)


## Plugin AOP Ingore {#ingore_aop}

Ignore ASM insertion by adding `@IngoreAOP` to Plugin AOP override method

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


## FAQ {#FAQ}
### Adding Bureau Variables to Avoid Conflicting Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended that the tag naming add the prefix of the project abbreviation, for example `df_tag_name`, and the `key` value can be used in the project [query source](https://github.com/DataFlux-cn/datakit-android/blob/dev/ft- sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). If the same variables as RUM and Log appear in the SDK global variables, RUM and Log will overwrite the global variables in the SDK.

### SDK Compatibility

* [Runnable](app-troubleshooting.md#runnable)
* [Compatible](app-troubleshooting.md#compatible) 

### Responding to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](https://docs.guance.com/agreements/app-sdk-privacy-policy/)

#### Method 1: SDK AndroidID Configuration
The SDK will use the Android ID for better association with the same user data, and if it needs to be on the app market, it needs to correspond to the market privacy audit in the following way.

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // application init setEnableAccessAndroidID to false
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);
	        
	        // ...
	    }
	}
	
	// set enable after user agree with privacy
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {
	    
	        //application init  setEnableAccessAndroidID to false
	        val config = FTSDKConfig
	            .builder(DATAKIT_URL)
	            . setEnableAccessAndroidID(false)
	
	        FTSdk.install(config)
	        
	        //...
	    }
	}
	
	// set enable after user agree with privacy
	FTSdk.setEnableAccessAndroidID(true);
	```

#### Method 2：Lazy initialization of the SDK
If you need to lazily load the SDK in your application, it is recommended to initialize it using the following approach.

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    //If the agreement to the terms has already been given, initialize it in the Application.
			if(agreeProtocol){
				FTSdk.init();
			}
		}
	}
	
	// Privacy Statement Activity Page
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			//Privacy Statement Not Read
			if ( notReadProtocol ) {
			    	// Show Privacy Policy 
				showProtocolView();
	
			    	//If agreed to the privacy statement
				if( agreeProtocol ){
					FTSdk.init();
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
	        // If the agreement to the terms has already been given, initialize it in the Application.
	        if (agreeProtocol) {
	            FTSdk.init()
	        }
	    }
	}
	
	// Privacy Statement Activity Page
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // Privacy Statement Not Read
	        if (notReadProtocol) {
	            // Show Privacy Policy
	            showProtocolView()
	
	            // If agreed to the privacy statement
	            if (agreeProtocol) {
	                FTSdk.init()
	            }
	        }
	    }
	}
	```

### ft-plugin not compatibility {#manual-set}
Guance uses code injection through `Android Gradle Plugin` Transformation to automatically collect data. However, in the event that `ft-plugin` cannot be used, this alternative integration approach can be used. The steps to implement the SDK manually are as follows:

* For the application startup event, add the following code to the onCreate() method of the `Application` class. Here is an example [DemoForManualSet.kt](https://github.com/GuanceCloud/datakit-android/tree/dev/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    
	    //before sdk config init
	    FTAutoTrack.startApp(null);
	    
	    //SDK configure
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	  	//Application
	    override fun onCreate() {
	        super.onCreate()
	        
		//before sdk config init
	        FTAutoTrack.startApp(null)
	        
	        //SDK configure
	        setSDK(this)
	 
	    }
	```

* For user events, such as button clicks, you will need to manually add tracking using `FTRUMGlobalManager`. For example, for a button click event, you can add the following code. Here is an example [ManualActivity.kt](https://github.com/GuanceCloud/datakit-android/tree/dev/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt)：

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

* For `OkHttp`, you can add tracking by using addInterceptor and eventListener to integrate Resource and Trace. Here is an example [ManualActivity.kt](https://github.com/GuanceCloud/datakit-android/tree/dev/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt)：

=== "Java"	

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	OkHttpClient client = builder.build();
	```
	
=== "Kotlin"
	
	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	val client = builder.build()
	```

* For other network frameworks, you will need to manually implement the use of `FTRUMGlobalManager` and its methods, including `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. For more information, please refer to the sample code in [ManualActivity.kt](https://github.com/GuanceCloud/datakit-android/tree/dev/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).