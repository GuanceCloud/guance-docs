# Android Application Access
---

## Overview

Guance Real User Monitoring can analyze the performance of each Android application in a visual way by collecting the metrics data of each Android application.

## Precondition

- Installing DataKit ([DataKit Installation Documentation](... /... /datakit/datakit-install.md))

## Android Application Access {#android-integration} 

Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

- Application Name (required): The name of the application used to identify the current implementation of user access monitoring.
- Application ID (required): The unique identification of the application in the current workspace, which is used for SDK data collection and upload matching, and corresponds to the field: app_id after data entry. This field only supports English, numeric, underscore input, up to 48 characters.

![](../img/13.rum_access_2.png)

## Installation {#setup}

![](https://img.shields.io/maven-metadata/v?label=ft-sdk&metadataUrl=https%3A%2F%2Fmvnrepo.jiagouyun.com%2Frepository%2Fmaven-releases%2Fcom%2Fcloudcare%2Fft%2Fmobile%2Fsdk%2Ftracker%2Fagent%2Fft-sdk%2Fmaven-metadata.xml#crop=0&crop=0&crop=1&crop=1&id=qIyeD&originHeight=20&originWidth=138&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/maven-metadata/v?label=ft-native&metadataUrl=https%3A%2F%2Fmvnrepo.jiagouyun.com%2Frepository%2Fmaven-releases%2Fcom%2Fcloudcare%2Fft%2Fmobile%2Fsdk%2Ftracker%2Fagent%2Fft-native%2Fmaven-metadata.xml#crop=0&crop=0&crop=1&crop=1&id=mC9jW&originHeight=20&originWidth=152&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)![](https://img.shields.io/maven-metadata/v?label=ft-plugin&metadataUrl=https%3A%2F%2Fmvnrepo.jiagouyun.com%2Frepository%2Fmaven-releases%2Fcom%2Fcloudcare%2Fft%2Fmobile%2Fsdk%2Ftracker%2Fplugin%2Fft-plugin%2Fmaven-metadata.xml#crop=0&crop=0&crop=1&crop=1&id=RzYsx&originHeight=20&originWidth=152&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

**Demo**：[https://github.com/GuanceCloud/datakit-android/demo](https://github.com/GuanceCloud/datakit-android/tree/dev/demo)

**Source Code Address**：[https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

### Gradle Configuration {#gradle-setting}

Add the remote repository address of `DataFlux SDK` to the `build.gradle` file in the root of the project

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
        //add Plugin dependency
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:1.1.3-beta01'
    }
}
allprojects {
    repositories {
        //...
        // add SDK remote repo url
        maven {
            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
        }
    }
}
```

Add `SDK` dependencies and use of `Plugin` and Java 8 support to the `build.gradle` file of the main project module `app`.

```groovy
dependencies {

    //add SDK dependency
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.9-beta02'
    
    //native crash dependency, needs to be used with ft-sdk and cannot be used alone
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:1.0.0-alpha05'
    
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
            FTSDKConfig config = FTSDKConfig.builder(DATAKIT_URL)//Datakit install url
                    .setDebug(true)
                    .build();

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
                .builder(DATAKIT_URL)//Datakit install url
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

| **Method Name** | **Meaning** | **Required** | **Attention** |
| --- | --- | --- | --- |
| metricsUrl | Datakit installation address | Yes | The url of the datakit installation address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed |
| setXDataKitUUID | Set the identification ID of the data acquisition terminal | No | Default is random `uuid` |
| setDebug | Whether to turn on debug mode | No | Default is `false`, enable to print SDK run log |
| setEnv | Set the acquisition environment | No | Default is `EnvType.PROD` |
| setOnlySupportMainProcess | Does it only support running in the master process | No | Default is `true`, if you need to execute in other processes you need to set this field to `false` |
| setEnableAccessAndroidID | Enable to get `Android ID` | No | Default, is `true`, set to `false`, then `device_uuid` field data will not be collected, market privacy audit related [see here](#adpot-to-privacy-audits) |
| addGlobalContext | Add SDK global properties | No | Adding rules can be found [here](#key-conflict) |

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

| **Method Name** | **Meaning** | **Required** | **Attention** |
| --- | --- | --- | --- |
| setRumAppId | Set `Rum AppId` | Yes | Corresponding to setting RUM `appid` to enable `RUM` collection, [get appid method](#android-integration) |
| setEnableTrackAppCrash | Whether to report App crash logs | No | Default is `false`, when enabled it will show the error stack data in the error analysis. <br/> [On the issue of obfuscated content conversion in the crash log](#retrace-log) |
| setExtraMonitorTypeWithError | Set up auxiliary monitoring information | No | Add additional monitoring data to `Rum` crash data, `ErrorMonitorType.BATTERY` for battery balance, `ErrorMonitorType.MEMORY` for memory usage, `ErrorMonitorType.CPU` for CPU occupancy |
| setDeviceMetricsMonitorType | Setting View Monitoring Information | No | In the View cycle, add monitoring data, `DeviceMetricsMonitorType.BATTERY` to monitor the highest output current output of the current page, `DeviceMetricsMonitorType.MEMORY` to monitor the current application memory usage, ` CPU` monitors the number of CPU bounces, `DeviceMetricsMonitorType.FPS` monitors the screen frame rate |
| setEnableTrackAppANR | Whether to turn on ANR detection | No | Default is `false` |
| setEnableTrackAppUIBlock | Whether to enable UI lag detection | No | Default is `false` |
| setEnableTraceUserAction | Whether to automatically track user actions | No | Currently only user start and click operations are supported,  default is `false` |
| setEnableTraceUserView | Whether to automatically track user page actions | No | Default is `false` |
| setEnableTraceUserResource | Whether to automatically chase user network requests | No | Only `Okhttp` is supported, default is `false` |
| setResourceUrlHandler | Configure Reousrce filter| No | Not filter default |
| addGlobalContext | Add custom tags | No | Add tag data for user monitoring data source distinction, if you need to use the tracking function, the parameter `key` is `track_id` ,`value` is any value, add rule notes please refer to [here](#key-conflict) |

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
	    .setEnableConsoleLog(true)
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
	                .setEnableConsoleLog(true)
	              //.setEnableConsoleLog(true,"log prefix")
	                .setEnableLinkRumData(true)
	                .setEnableCustomLog(true)
	              //.setLogLevelFilters(arrayOf(Status.CRITICAL,Status.ERROR))
	                .setSamplingRate(0.8f)
	        )
	```

| **Method Name** | **Meaning** | **Required** | **Attention** |
| --- | --- | --- | --- |
| setServiceName | Set the service name | No | Default is `df_rum_android` |
| setSampleRate | Set acquisition rate | No | The value of the acquisition rate ranges from >= 0, <= 1, and the default value is 1 |
| setTraceConsoleLog | Whether to report console logs | No | Log level correspondence<br>Log.v -> ok;<br>Log.i、Log.d -> info;<br>Log.e -> error;<br>Log.w -> warning，<br> `prefix` is the control prefix filter parameter, no filter is set by default |
| setEnableLinkRUMData | Whether to associate with RUM data | No | Default is `false` |
| setLogCacheDiscardStrategy | Set frequent log discard rules | No | Default is `LogCacheDiscard.DISCARD`, `DISCARD` to discard additional data, `DISCARD_OLDEST` to discard old data |
| setEnableCustomLog | Whether to upload custom logs | No | Default is `false` |
| setLogLevelFilters | Set log level filtering | No | Set level log filtering, no setting by default |
| addGlobalContext | Add log global property | No | Adding rules can be found [here](#key-conflict) |

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

| **Method Name** | **Meaning** | **Required** | **Attention** |
| --- | --- | --- | --- |
| setSampleRate | Set sample rate | No | The value of the acquisition rate ranges from >= 0, <= 1, and the default value is 1 |
| setTraceType | Set the type of tracing | No | Default is `DDTrace`, currently support `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C), if you access OpenTelemetry to choose the corresponding trace type, please pay attention to check the supported types and agent-related configuration |
| setEnableLinkRUMData | Whether to associate with RUM data | No | Default is `false` |
| setEnableAutoTrace | Set whether to enable automatic http trace | No | Currently only OKhttp auto-tracking is supported, the default is `false`. |
| setEnableWebTrace | Set the webview to enable tracing or not | No | alpha function, some scenarios may have partial js loading problems, default is `false` |


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
	     * @param property
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

| **Method Name** | **Meaning** | **Required** | **Description** |
| --- | --- | --- | --- |
| NetStatusBean.fetchStartTime | Request start time | No |  |
| NetStatusBean.tcpStartTime | tcp connection time | No |  |
| NetStatusBean.tcpEndTime | tcp end time | No |  |
| NetStatusBean.dnsStartTime | dns start time | No |  |
| NetStatusBean.dnsEndTime | dns end time | No |  |
| NetStatusBean.responseStartTime | Response start time | No |  |
| NetStatusBean.responseEndTime | Response end time | No |  |
| NetStatusBean.sslStartTime | ssl start time | No |  |
| NetStatusBean.sslEndTime | ssl end time | No |  |
| ResourceParams.url | url address | Yes |  |
| ResourceParams.requestHeader | Request header parameters | No |  |
| ResourceParams.responseHeader | Response header parameters | No |  |
| ResourceParams.responseConnection | Response Connection | No |  |
| ResourceParams.responseContentType | Response ContentType | No |  |
| ResourceParams.responseContentEncoding | Response ContentEncoding | No |  |
| ResourceParams.resourceMethod | Request Method | No | GET, POST, etc. |
| ResourceParams.responseBody | Return body content | No |  |

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
| setId      | set user ID    | NO           |                                              |
| setName    | set user name  | NO           |                                              |
| setEmail   | set email      | NO           |                                              |
| setExts    | set user extra | NO           | More rules ，please view[Here](#key-conflict) |

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
`ft-plugin` version needs to be `1.1.2` or higher to support symbol file upload, support `productFlavor` multi-version distinction management, plugin will execute upload symbol file after `gradle task assembleRelease`, detailed configuration can refer to [SDK Demo](#setup )

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitDCAUrl = 'https://datakit.url:9531'//datakit isntall url，9531 defualt 
    appId = "appid_xxxxx"// appid
    env = 'common'

    prodFlavors { //prodFlavors override before
        prodTest {
            autoUploadMap = false
            autoUploadNativeDebugSymbol = false
            datakitDCAUrl = 'https://datakit.test.url:9531'
            appId = "appid_prodTest"
            env = "gray"
        }
        prodPublish {
            autoUploadMap = true
            autoUploadNativeDebugSymbol = true
            datakitDCAUrl = 'https://datakit.publish.url:9531'
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


## Frequently Asked Questions {#FAQ}
### Adding Bureau Variables to Avoid Conflicting Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended that the tag naming add the prefix of the project abbreviation, for example `df_tag_name`, and the `key` value can be used in the project [query source](https://github.com/DataFlux-cn/datakit-android/blob/dev/ft- sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java). If the same variables as RUM and Log appear in the SDK global variables, RUM and Log will overwrite the global variables in the SDK.

### Responding to Market Privacy Audits {#adpot-to-privacy-audits}
#### Privacy Statement
[Go to view](https://docs.guance.com/agreements/app-sdk-privacy-policy/)

#### SDK AndroidID Configuration
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
	OkHttpClient.Builder builder = new OkHttpClient.Builder();
	builder.addInterceptor(new FTTraceInterceptor());
	FTResourceInterceptor interceptor = new FTResourceInterceptor();
	builder.addInterceptor(interceptor);
	builder.eventListener(interceptor);
	OkHttpClient client = builder.build();
	```
=== "Kotlin"
	
	```kotlin
	val builder = OkHttpClient.Builder()
	builder.addInterceptor(FTTraceInterceptor())
	val interceptor = FTResourceInterceptor()
	builder.addInterceptor(interceptor)
	builder.eventListener(interceptor)
	val client = builder.build()
	```

* For other network frameworks, you will need to manually implement the use of `FTRUMGlobalManager` and its methods, including `startResource`, `stopResource`, `addResource`, and `FTTraceManager.getTraceHeader`. For more information, please refer to the sample code in [ManualActivity.kt](https://github.com/GuanceCloud/datakit-android/tree/dev/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt).