# UniApp Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [accessible from the public network and install the IP geographic information database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current UniApp version supports Android and iOS platforms. Log in to the <<< custom_key.brand_name >>> console, enter the **User Analysis** page, click the top-left **[Create](../index.md#create)** to start creating a new application.

![](../img/image_13.png)

## Installation

### Local Usage {#local-plugin}

![](https://img.shields.io/badge/dynamic/json?label=plugin&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/uni-app/version.json&link=https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin](https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Demo Address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin/Hbuilder_Example](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example)

Structure of the downloaded SDK package:

```text
|--datakit-uniapp-native-plugin
	|-- Hbuilder_Example				// GCUniPlugin plugin sample project
	    |-- nativeplugins          // Sample project's local plugin folder
	        |-- GCUniPlugin           // ⭐️ GCUniPlugin native plugin package ⭐️
	            |-- android              // Contains dependency libraries and resource files required by the Android plugin
	            |-- ios                  // Contains dependency libraries and resource files required by the iOS plugin
	            |-- package.json         // Plugin configuration file
	|-- UniPlugin-Android		    // Main Android project for plugin development
	|-- UniPlugin-iOS					  // Main iOS project for plugin development
```

Configure the **GCUniPlugin** folder under the "nativeplugins" directory of your uni_app project, and in the manifest.json file under the "App Native Plugin Configuration" item, click "Select Local Plugin", and choose the GCUniPlugin plugin from the list:

![img](../img/15.uniapp_intergration.png)

**Note**: After saving, you need to submit it for cloud packaging (creating a **custom base** also belongs to cloud packaging) for the plugin to take effect.

> For more details, refer to: [Using Local Plugins in HBuilderX](https://nativesupport.dcloud.net.cn/NativePlugin/use/use_local_plugin.html#), [Custom Base](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground)

### Market Plugin Method
(Not provided)

### uni Mini Program SDK Installation {#unimp-install}

#### Development Debugging and wgt Publishing Usage {#unimp-use}

* When developing and debugging the uni mini program SDK, use the [Local Usage](#local-plugin) method to integrate **GCUniPlugin**.

* When making the uni mini program SDK into a wgt package for the host App to use, the host App needs to import the [**GCUniPlugin** dependency libraries](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example/nativeplugins/GCUniPlugin) (including Native SDK libraries) and register the **GCUniPlugin Module**.

Host App requires the following operations:

 **iOS**

* Add **GCUniPlugin** dependency library

  In the Xcode project's left directory, select the project name, go to `TARGETS -> Build Phases -> Link Binary With Libraries`, click the “+” button, in the pop-up window click `Add Other -> Add Files...`, then open the `GCUniPlugin/ios/` dependency library directory, select `FTMobileSDK.xcframework` and `Guance_UniPlugin_App.xcframework` from the directory, and click the `open` button to add the dependency libraries to the project.

  When SDK Version < 0.2.0: In `TARGETS -> General -> Frameworks,Libraries,and Embedded Content`, find `FTMobileSDK.xcframework` and change the Embed method to `Embed & sign`.

* Register **GCUniPlugin Module**:

```objective-c
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ....
      // Register GCUniPlugin module
    [WXSDKEngine registerModule:@"GCUniPlugin-MobileAgent" withClass:NSClassFromString(@"FTMobileUniModule")];
    [WXSDKEngine registerModule:@"GCUniPlugin-RUM" withClass:NSClassFromString(@"FTRUMModule")];
    [WXSDKEngine registerModule:@"GCUniPlugin-Logger" withClass:NSClassFromString(@"FTLogModule")];
    [WXSDKEngine registerModule:@"GCUniPlugin-Tracer" withClass:NSClassFromString(@"FTTracerModule")];  
      return YES;
    }
```

 **Android**

* Add **GCUniPlugin** dependency library

   * **Method One:** Add `ft-native-[version].aar`, `ft-sdk-[version].aar`, `gc-uniplugin-[last-version].aar` from the `GCUniPlugin/android/` folder to the project's `libs` folder, modify the `build.gradle` file to add dependencies.
   * **Method Two:** Use the **Gradle Maven** remote repository method for configuration. Refer to the UniAndroid-Plugin [project configuration](#plugin_gradle_setting) for this method.

```Java
  dependencies {
      implementation files('libs/ft-native-[version].aar')
      implementation files('libs/ft-sdk-[version].aar')
      implementation files('libs/gc-uniplugin-[last-version].aar')
      implementation 'com.google.code.gson:gson:2.8.5'
  }   
```

* Register **GCUniPlugin Module**:

```java
  public class App extends Application {
      @Override
      public void onCreate() {
          super.onCreate();
          try {
            // Register GCUniPlugin module
              WXSDKEngine.registerModule("GCUniPlugin-Logger", FTLogModule.class);
              WXSDKEngine.registerModule("GCUniPlugin-RUM", FTRUMModule.class);
              WXSDKEngine.registerModule("GCUniPlugin-Tracer", FTTracerModule.class);
              WXSDKEngine.registerModule("GCUniPlugin-MobileAgent", FTSDKUniModule.class);
          } catch (Exception e) {
              e.printStackTrace();
          }
          ......
      }
  }
```

#### Mixed Usage of UniApp SDK and Native SDK {#unimp-mixup}

* The above steps for adding **GCUniPlugin** dependency libraries already include adding the Native SDK to the host project, so you can directly call Native SDK methods.

* SDK Initialization

  When using mixed mode, only initialize the Native SDK within the host App; there is no need to perform initialization configuration in the uni mini program. You can directly call methods provided by the UniApp SDK.

  Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) for the initial methods of the host App's SDK.

  Note: Ensure that the host App completes SDK initialization before loading the uni mini program to ensure that the SDK is fully ready before calling any other SDK methods.

* **Additional Configuration for Android Integration:**

  Configure the Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and network request data, as well as Android Native related events (page transitions, click events, Native network requests, WebView data).

## SDK Initialization

### Basic Configuration {#base-setting}

```javascript
// Configure in App.vue
<script>
    var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
    export default {
        onLaunch: function() {
            console.log('App Launch')
            guanceModule.sdkConfig({
                'datakitUrl': 'your datakitUrl',
                'debug': true,
                'env': 'common',
                'globalContext': {
                    'custom_key': 'custom value'
                }
            })
        },
        onShow: function() {
            console.log('App Show')
        },
        onHide: function() {
            console.log('App Hide')
        }
    }
</script>
<style>
</style>
```

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------ | :------- | :--- | :-------------------------------------------------- |
| datakitUrl | string | Yes | Datakit access URL, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, the device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| datawayUrl | string | Yes | Public Dataway access URL, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, the device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | string | Yes | Authentication token, must be used together with datawayUrl |
| debug | boolean | No | Set whether to allow printing of Debug logs, default `false` |
| env | string | No | Environment, default `prod`, any character, recommended to use a single word, such as `test` |
| service | string | No | Set the name of the business or service, default: `df_rum_ios`, `df_rum_android` |
| globalContext | object | No | Add custom tags |
| offlinePakcage | boolean | No | Only supported by Android, whether to use offline packaging or uni mini program, default `false`, see [Difference between Android Cloud Packaging and Offline Packaging](#package) for detailed explanation |
| autoSync | boolean | No | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use [`flushSyncData`](#flushSyncData) method to manage data synchronization manually |
| syncPageSize | number | No | Set the number of entries per sync request. Range [5,), larger numbers mean more computational resources are used for data synchronization, default 10 |
| syncSleepTime | number | No | Set the interval between syncs. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | Recommended to enable when coexisting with web data. This configuration handles compatibility issues with web data types. |
| compressIntakeRequests | boolean | No | Compress sync data, supported by SDK version 0.2.0 and above |
| enableLimitWithDbSize | boolean | No | Enable limiting data size using db, default 100MB, unit Byte. Larger databases increase disk pressure, default not enabled. **Note:** Enabling this will make the `logCacheLimitCount` and `rumCacheLimitCount` configurations ineffective. Supported by SDK version 0.2.0 and above |
| dbCacheLimit | number | No | DB cache limit size. Range [30MB,), default 100MB, unit byte, supported by SDK version 0.2.0 and above |
| dbDiscardStrategy | string | No | Set the data discard rule in the database.<br>Discard strategy: `discard` (default) discards new data, `discardOldest` discards old data. Supported by SDK version 0.2.0 and above |

### RUM Configuration {#rum-config}

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
rum.setConfig({
        'androidAppId':'YOUR_ANDROID_APP_ID',
        'iOSAppId':'YOUR_IOS_APP_ID',
        'errorMonitorType':'all', // or 'errorMonitorType':['battery','memory']
        'deviceMonitorType':['cpu','memory']// or  'deviceMonitorType':'all'
    })
```

| Parameter Name | Parameter Type | Required | Description |
| -------------- | ------------ | -------- | ----------------------------------------------------------- |
| androidAppId | string | Yes | App ID, applied during monitoring |
| iOSAppId | string | Yes | App ID, applied during monitoring |
| samplerate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. Applies to all View, Action, LongTask, Error data under the same session_id |
| enableNativeUserAction | boolean | No | Whether to track `Native Action`, such as `Button` click events, recommended to disable for pure `uni-app` applications, default `false`, not supported by Android cloud packaging |
| enableNativeUserResource | boolean | No | Whether to automatically track `Native Resource`, default `false`, not supported by Android cloud packaging. Since uniapp network requests on iOS use system APIs, enabling this allows all resource data on iOS to be collected. At this time, please disable manual collection on the iOS side to prevent duplicate data collection. |
| enableNativeUserView | boolean | No | Whether to automatically track `Native View`, recommended to disable for pure `uni-app` applications, default `false` |
| errorMonitorType | string/array | No | Additional error monitoring types: `all`, `battery`, `memory`, `cpu` |
| deviceMonitorType | string/array | No | Additional page monitoring types: `all`, `battery` (only supported by Android), `memory`, `cpu`, `fps` |
| detectFrequency | string | No | Page monitoring frequency: `normal` (default), `frequent`, `rare` |
| globalContext | object | No | Custom global parameters, special key: `track_id` (for tracking features) |
| enableResourceHostIP | boolean | No | Whether to collect the IP address of the target domain. Scope: Only affects default collection when `enableNativeUserResource` is `true`. Supported on iOS >= iOS 13. On Android, Okhttp has an IP caching mechanism for the same domain, and under the same `OkhttpClient`, the IP does not change, resulting in only one generation. |
| enableTrackNativeCrash | boolean | No | Whether to collect `Native Error` |
| enableTrackNativeAppANR | boolean | No | Whether to collect `Native ANR` |
| enableTrackNativeFreeze | boolean | No | Whether to collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` lag, range [100,), unit milliseconds. Default 250ms on iOS, 1000ms on Android |
| rumDiscardStrategy | string | No | Discard strategy: `discard` (default) discards new data, `discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum number of local cached RUM entries [10_000,), default 100_000 |

### Log Configuration {#log-config}

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.setConfig({
  'enableLinkRumData':true,
  'enableCustomLog':true,
  'discardStrategy':'discardOldest'
})
```

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | :------------- | :------- | :-------------------- |
| samplerate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. |
| enableLinkRumData | boolean | No | Whether to link with RUM data |
| enableCustomLog | boolean | No | Whether to enable custom logging |
| discardStrategy | string | No | Log discard strategy: `discard` (default) discards new data, `discardOldest` discards old data |
| logLevelFilters | array<string> | No | Log level filters, array should contain **log levels**: `info` (information), `warning` (warning), `error` (error), `critical` (critical), `ok` (recovered) |
| globalContext | object | No | Custom global parameters |
| logCacheLimitCount | number | No | Maximum number of locally cached log entries [1000,), larger values mean more disk cache pressure, default 5000 |

### Trace Configuration {#trace-config}

```javascript
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
tracer.setConfig({
				'traceType': 'ddTrace'
			})
```

| Parameter Name | Parameter Type | Required | Parameter Description |
| -------------- | ------------ | -------- | ---------------------------------------------- |
| samplerate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. |
| traceType | string | No | Trace type: `ddTrace` (default), `zipkinMultiHeader`, `zipkinSingleHeader`, `traceparent`, `skywalking`, `jaeger` |
| enableLinkRUMData | boolean | No | Whether to link with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Whether to enable native network auto tracing for iOS `NSURLSession` and Android `OKhttp`, default `false`, not supported by Android cloud packaging. Since uniapp network requests on iOS use system APIs, enabling this allows automatic tracing of network requests initiated by iOS end uniapp, at this time, please disable manual tracing on the iOS side to prevent incorrect association of traces with `RUM` data. |

## RUM User Data Tracking

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
```

### Action

#### API - startAction

Starts a RUM Action.

RUM binds this Action to possible triggered Resource, Error, LongTask events. Avoid multiple additions within 0.1 seconds. Only one Action can be associated with the same View at the same time. New Actions added while the previous Action has not ended will be discarded. Adding Actions using `addAction` does not affect this.

```javascript
rum.startAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name | Parameter Type | Required | Parameter Description |
| -------------- | ------------ | -------- | --------------------- |
| actionName | string | Yes | Event name |
| actionType | string | Yes | Event type |
| property | object | No | Event context (optional) |

#### API - addAction

Adds an Action event. This type of data cannot be associated with Error, Resource, LongTask data, and has no discard logic.

```javascript
rum.addAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name | Parameter Type | Required | Parameter Description |
| -------------- | ------------ | -------- | --------------------- |
| actionName | string | Yes | Event name |
| actionType | string | Yes | Event type |
| property | object | No | Event context (optional) |

### View {#rumview}

* Automatic Collection

```javascript
// Automatic collection, refer to the sample project in the SDK package's GCUniPlugin plugin
// step 1. Find GCWatchRouter.js and GCPageMixin.js files in the SDK package and add them to your project
// step 2. Add Router monitoring in App.vue as follows:
<script>
	import WatchRouter from '@/GCWatchRouter.js'
	export default {
    mixins:[WatchRouter],
	}
</script>
// step 3. Add pageMixin to the first displayed page as follows
<script>
	import GCPageMixin from '../../GCPageMixin.js';
	export default {
		data() {
			return {}
		},
		mixins:[GCPageMixin],
	}
</script>
```

* Manual Collection

```dart
// Manually collect the lifecycle of the View
// step 1 (optional)
rum.onCreateView({
					'viewName': 'Current Page Name',
					'loadTime': 100000000,
				})
// step 2
rum.startView('Current Page Name')
// step 3  
rum.stopView()         
```

#### API - onCreateView

Records page creation duration

| Parameter Name | Parameter Type | Required | Parameter Description |
| -------------- | ------------ | -------- | ---------------------- |
| viewName | string | Yes | Page name |
| loadTime | number | Yes | Page loading time (nanosecond timestamp) |

#### API - startView {#startview}

Entering a page

| Parameter Name | Parameter Type | Required | Parameter Description |
| -------------- | ------------ | -------- | --------------------- |
| viewName | string | Yes | Page name |
| property | object | No | Event context (optional) |

#### API - stopView

Leaving a page

| Parameter Name | Parameter Type | Required | Parameter Description |
| -------------- | ------------ | -------- | --------------------- |
| property | object | No | Event context (optional) |

### Error

* Automatic Collection

```javascript
/// Using uniapp error listening function triggers when script errors or API calls fail
<script>
  var rum = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  var appState = 'startup';
	// Can only listen in App.vue
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
      appState = 'run'
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
    onError:function(err){   
			if (err instanceof Error){
				console.log('Error name:', err.name);
				console.log('Error message:', err.message);
				console.log('Error stack:',err.stack);
				rum.addError({
					'message': err.message,
					'stack': err.stack,
          'state': appState,
				})
			}else if(err instanceof String){
				console.log('Error:', err);
				rum.addError({
					'message': err,
					'stack': err,
          'state': appState,
				})
			}
	}
</script>
```

* Manual Collection

```javascript
// Manually add
rum.addError({
					'message': 'Error message',
					'stack': 'Error stack',
				})
```
#### API - addError

Add an Error event

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | ------------------------------------ |
| message | string | Yes | Error message |
| stack | string | Yes | Stack trace |
| state | string | No | App running state (`unknown`, `startup`, `run`) |
| type | string | No | Error type, default `uniapp_crash` |
| property | object | No | Event context (optional) |

### Resource

The SDK provides a sample method `gc.request`. This method wraps the `uni.request` network request method, allowing you to replace the `uni.request` method with `gc.request` for network requests.

**Extra Parameter: `filterPlatform`**

* **Function**: The `filterPlatform` parameter specifies which platform resource data should not be collected.
* **Use Case**: When `enableNativeUserResource` is enabled, uniapp on iOS automatically collects network request data through system APIs. To avoid duplicate data collection, you can add the `filterPlatform: ["ios"]` parameter when using `gc.request` to shield manual data collection on the iOS platform.

**Implementation of `gc.request`**

```javascript
// GCRequest.js
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
// Get platform information
const platform = uni.getSystemInfoSync().platform;
export default {
    getUUID() {
    	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    		var r = Math.random() * 16 | 0,
    			v = c == 'x' ? r : (r & 0x3 | 0x8);
    		return v.toString(16);
    	});
    },
    isEmpty(value) {
	    return value === null || value === undefined;
	},
	/// Filter platforms using the `filterPlatform` parameter. When `enableNativeUserResource` is enabled,
	/// since uniapp network requests on iOS use system APIs, all resource data on iOS can be collected,
	/// at this time, please shield manual collection on the iOS side in uniapp to prevent duplicate data collection.
	/// Example: ["ios"], iOS settings do not perform trace tracking and RUM collection.
    request(options){ 
		let key = this.getUUID();
		var filter;
		if(this.isEmpty(options.filterPlatform)){
			filter = false
		}else{
	        filter = options.filterPlatform.includes(platform);
		}
		var traceHeader = {}
		if(filter == false){
		  // Associate trace with RUM
		  var traceHeader = tracer.getTraceHeader({
		  	'key': key,
		  	'url': options.url,
		  })
		}
		traceHeader = Object.assign({},traceHeader, options.header)
		rum.startResource({
			'key':key,
		});
		var responseHeader;
		var responseBody;
		var resourceStatus;
		return uni.request({
			url: options.url,
			method: options.method,
			header: traceHeader,
			data:options.data,
			timeout:options.timeout,
			success: (res) => {
				if(!filter){
				  responseHeader = res.header;
				  responseBody = res.data;
				  resourceStatus = res.statusCode;
				}
				if(this.isEmpty(options.success)){
					options.success(res);
				}
			},
			fail:(err) => {
				if(!filter){
				  responseBody = err.errMsg;
				}
				if(this.isEmpty(options.fail)){
					options.fail(err);
				}
			},
			complete() {
				if(!filter){
				  rum.stopResource({
				  	'key':key,
				  })
				  rum.addResource({
				  	'key': key,
				  	'content': {
				  		'url': options.url,
				  		'httpMethod': options.method,
				  		'requestHeader': traceHeader,
				  		'responseHeader': responseHeader,
				  		'responseBody': responseBody,
				  		'resourceStatus': resourceStatus,
				  	}
				  })
				}
				if(this.isEmpty(options.complete)){
					options.complete();
				}
			}
		});
	}
} 
```

**Usage Example**

```javascript
import gc from './GCRequest.js';
gc.request({
				url: requestUrl,
				method: method,
				header: header,
				filterPlatform:["ios"],
				timeout:30000,
				success(res)  {
					console.log('success:' + JSON.stringify(res))
				},
				fail(err) {
					console.log('fail:' + JSON.stringify(err))
				},
				complete() {
					console.log('complete:' + JSON.stringify(err))
				}
			});
```

#### API - startResource

HTTP Request Start

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| key | string | Yes | Unique request identifier |
| property | object | No | Event context (optional) |

#### API - stopResource

HTTP Request End

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| key | string | Yes | Unique request identifier |
| property | object | No | Event context (optional) |

#### API - addResource

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| key | string | Yes | Unique request identifier |
| content | content object | Yes | Request-related data |

#### content object

| Prototype | Parameter Type | Parameter Description |
| --------- | ------------ | -------------------- |
| url | string | Request URL |
| httpMethod | string | HTTP method |
| requestHeader | object | Request headers |
| responseHeader | object | Response headers |
| responseBody | string | Response body |
| resourceStatus | string | Request status code |

## Logger Logging

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.logging({
					'content':`Log content`,
					'status':status
				})
```

### API - logging

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| content | string | Yes | Log content, can be a JSON string |
| status | string | Yes | Log level |
| property | object | No | Event context (optional) |

### Log Levels

| String | Meaning |
| ------ | ------- |
| info | Information |
| warning | Warning |
| error | Error |
| critical | Critical |
| ok | Recovery |

## Tracer Network Trace

```javascript
// Example using uni.request for network requests
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
let key = Utils.getUUID();// Refer to example utils.js
var header = tracer.getTraceHeader({
					'key': key,
					'url': requestUrl,
				})
uni.request({
          url: requestUrl,
          header: header,
          success() {
            console.log('success');
          },
          complete() {
            console.log('complete');
          }
        });
```

#### API - getTraceHeader

Get the request headers needed for trace, and add them to the HTTP request headers.

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| key | string | Yes | Unique request identifier |
| url | string | Yes | Request URL |

Return Value Type: object 

## Binding and Unbinding User Information

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");

guanceModule.bindRUMUserData({
				'userId':'Test userId',
				'userName':'Test name',
				'userEmail':'test@123.com',
				'extra':{
					'age':'20'
				}
			})
  
guanceModule.unbindRUMUserData()
```

### API - bindRUMUserData

Bind user information:

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| userId | string | Yes | User ID |
| userName | string | No | User name |
| userEmail | string | No | User email |
| extra | object | No | Extra user information |

### API - unbindRUMUserData

Unbind the current user.

## Closing the SDK

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.shutDown()
```
### API - shutDown

Close the SDK.

## Clearing SDK Cache Data
```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.clearAllData()
```

### API - clearAllData

Clear all data that has not been uploaded to the server.

## Actively Synchronizing Data {#flushSyncData}

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.flushSyncData()
```

### API - flushSyncData

When configuring `guanceModule.sdkConfig` as `true`, no additional actions are needed, and the SDK will synchronize automatically.

When configuring `guanceModule.sdkConfig` as `false`, you need to trigger the data synchronization method actively for data synchronization.

## Adding Custom Tags {#user-global-context}

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
ftMobileSDK.appendGlobalContext({
				  'ft_global_key':'ft_global_value'
			  })
ftMobileSDK.appendRUMGlobalContext({
				  'ft_global_rum_key':'ft_global_rum_value'
  			  })
ftMobileSDK.appendLogGlobalContext({
				  'ft_global_log_key':'ft_global_log_value'
		     })  			  
```

### API - appendGlobalContext

Add custom global parameters. Applies to RUM and Log data

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| None | object | Yes | Custom global parameters |

### API - appendRUMGlobalContext

Add custom RUM global parameters. Applies to RUM data

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| None | object | Yes | Custom global RUM parameters |

### API - appendLogGlobalContext

Add custom RUM and Log global parameters. Applies to Log data

| Parameter Name | Parameter Type | Required | Parameter Description |
| :------------- | ------------ | -------- | -------------------- |
| None | object | Yes | Custom global Log parameters |

## Common Issues

### Using the Main Project for Plugin Development on iOS: UniPlugin-iOS

#### Download UniApp Offline Development SDK

Based on the version number of the uni-app development tool **HBuilderX**, download the [SDK package](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) required for the plugin development.

SDK Package Structure Explanation

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app offline packaging project
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and resource files
```

Drag the dependency libraries and resource files **SDK** folder into the UniPlugin-iOS folder. After dragging, the directory structure should be as follows.

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and resource files
```

For more details, refer to [iOS Plugin Development Environment Configuration](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#开发环境).

#### Project Configuration

1. Architectures Setting

Since Xcode 12 provides simulators supporting the arm64 architecture, the framework provided by uni_app supports arm64 for real devices and x86_64 for simulators. So,

Set `Excluded Architectures` to `Any iOS Simulator SDK`: `arm64`.

2. Other Linker Flags

```
$(inherited) -ObjC -framework "FTMobileSDK" -framework "Guance_UniPlugin_App"
```

3. Framework Search Paths

```
$(inherited)
"${PODS_CONFIGURATION_BUILD_DIR}/FTMobileSDK"
"${PODS_CONFIGURATION_BUILD_DIR}/Guance-UniPlugin-App"
$(DEVELOPER_FRAMEWORKS_DIR)
$(PROJECT_DIR)/../SDK/libs
$(PROJECT_DIR)
```

### Using the Main Project for Plugin Development on Android: UniPlugin-Android

#### Project Configuration {#plugin_gradle_setting}

> Detailed dependency configuration can be found in the [Demo](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example). More Gradle extension parameter configurations can be found in [Android SDK](../android/app-access.md#gradle-setting)

```
|-- UniPlugin-Android
	|-- app
		|--build.gradle
		// ---> Configure ft-plugin
		// apply:'ft-plugin'
		
	|-- uniplugin_module
		|-- src
			|-- main
				|-- java
					|-- com.ft.sdk.uniapp
		|-- build.gradle 
		//---> Configure dependencies
		//implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:xxxx'
		//implementation 'com.google.code.gson:gson:xxxx'
		//implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:xxxx'
		
	|-- build.gradle
		//---> Configure repo
		//	maven {
		//      	url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
		//	}
		//
		//--> Configure buildScrpit
		//	classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:xxxx'

```

### Differences Between Android Cloud Packaging and Offline Packaging {#package}

Android cloud packaging and offline packaging use two different integration logics. The offline packaging integration method is similar to the <<< custom_key.brand_name >>> `Android SDK` integration method, using the `Android Studio Gradle Plugin` approach. Cloud packaging cannot use the `Android Studio Gradle Plugin`, so it can only implement some functionalities through internal code in the <<< custom_key.brand_name >>> `UniApp Native Plugin`. Therefore, the offline packaging version has more configurable options than the cloud packaging version. The `offlinePakcage` [parameter](#base-config) in the SDK configuration is to distinguish between these two cases.

### Others
* [Android Privacy Review](../android/app-access.md#third-party)
* [Other Related for iOS](../ios/app-access.md#FAQ)
* [Other Related for Android](../android/app-access.md#FAQ)
* Native Symbol File Upload
	* [Android](../android/app-access.md#source_map)
	* [iOS](../ios/app-access.md#source_map)