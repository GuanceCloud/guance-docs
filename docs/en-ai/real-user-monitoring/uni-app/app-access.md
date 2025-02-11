# UniApp Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current UniApp version supports Android and iOS platforms. Log in to the Guance console, go to the **User Analysis** page, click the top-left **[Create New Application](../index.md#create)**, and start creating a new application.

![](../img/image_13.png)

## Installation

### Local Usage {#local-plugin}

![](https://img.shields.io/badge/dynamic/json?label=plugin&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/uni-app/version.json&link=https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Source Code Repository**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin](https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Demo Repository**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin/Hbuilder_Example](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example)

Structure of the downloaded SDK package:

```text
|--datakit-uniapp-native-plugin
	|-- Hbuilder_Example				// GCUniPlugin plugin sample project
	    |-- nativeplugins          // Sample project's local plugins folder
	        |-- GCUniPlugin           // ⭐️ GCUniPlugin native plugin package ⭐️
	            |-- android              // Contains dependencies and resources for Android plugins
	            |-- ios                  // Contains dependencies and resources for iOS plugins
	            |-- package.json         // Plugin configuration file
	|-- UniPlugin-Android		    // Main project for developing Android plugins
	|-- UniPlugin-iOS					  // Main project for developing iOS plugins
```

Configure the **GCUniPlugin** folder under the "nativeplugins" directory of your uni_app project. Additionally, in the `manifest.json` file, under the "Native Plugin Configuration" section, click "Select Local Plugin," and choose the GCUniPlugin from the list:

![img](../img/15.uniapp_intergration.png)

**Note**: After saving, you need to submit it for cloud packaging (creating a **custom base**) also falls under cloud packaging). The plugin will only take effect after this step.

> For more details, refer to: [Using Local Plugins in HBuilderX](https://nativesupport.dcloud.net.cn/NativePlugin/use/use_local_plugin.html#), [Custom Base](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground)

### Market Plugin Method
(Not provided)

### uni Mini Program SDK Installation {#unimp-install}

#### Development Debugging and WGT Publishing Usage {#unimp-use}

* During development and debugging of the uni mini program SDK, use the [Local Usage](#local-plugin) method to integrate **GCUniPlugin**.

* When packaging the uni mini program SDK into a wgt package for use by the host App, the host App needs to import the [dependencies of **GCUniPlugin**](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example/nativeplugins/GCUniPlugin) (including Native SDK libraries) and register the **GCUniPlugin Module**.

Required operations for the host App:

 **iOS**

* Add **GCUniPlugin** dependencies

    In the Xcode project, select the project name on the left side. Under `TARGETS -> Build Phases -> Link Binary With Libraries`, click the “+” button. In the pop-up window, click `Add Other -> Add Files...`, then open the `GCUniPlugin/ios/` dependency directory, select the `FTMobileSDK.xcframework` and `Guance_UniPlugin_App.xcframework` directories, and click the `open` button to add the dependencies to the project.

    When SDK Version < 0.2.0: In `TARGETS -> General -> Frameworks,Libaries,and Embedded Content`, find `FTMobileSDK.xcframework` and change the Embed method to `Embed & sign`.

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

* Add **GCUniPlugin** dependencies

   * **Method One:** Place the files `ft-native-[version].aar`, `ft-sdk-[version].aar`, and `gc-uniplugin-[last-version].aar` from the `GCUniPlugin/android/` folder into the project’s `libs` folder and modify the `build.gradle` file to add the dependencies.
   * **Method Two:** Use the **Gradle Maven** remote repository configuration. Refer to the Gradle settings for UniAndroid-Plugin [project configuration](#plugin_gradle_setting).

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

* When adding the **GCUniPlugin** dependencies as described above, the Native SDK is already added to the host project, so you can directly call the Native SDK methods.

* SDK Initialization

    In mixed usage scenarios, initialize the Native SDK only within the host App. No additional initialization is required within the uni mini program; you can directly call the methods provided by the UniApp SDK.

    Refer to the initialization configurations for the host App SDK: [iOS SDK Initialization](../ios/app-access.md#init), [Android SDK Initialization](../android/app-access.md#init).

    Note: Ensure that the host App completes SDK initialization before loading the uni mini program to ensure the SDK is fully ready before any other SDK methods are called.

* **Additional Configuration for Android Integration:**

    Configure the Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect app launch events and network request data, as well as Android Native events (page transitions, click events, Native network requests, WebView data).

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

| Parameter Name | Type | Required | Description |
| :------------ | :------- | :--- | :-------------------------- |
| datakitUrl | string | Yes | DataKit access URL, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529. The device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration.** |
| datawayUrl | string | Yes | Public Dataway access URL, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528. The device with the installed SDK must be able to access this address. **Note: Choose either datakit or dataway configuration.** |
| clientToken | string | Yes | Authentication token, must be used with datawayUrl |
| debug | boolean | No | Whether to enable debug logs, default `false` |
| env | string | No | Environment, default `prod`, any character, suggest using a single word like `test` |
| service | string | No | Set the business or service name, defaults: `df_rum_ios`, `df_rum_android` |
| globalContext | object | No | Add custom tags |
| offlinePakcage | boolean | No | Android support only, whether to use offline packaging or uni mini program, default `false`. Detailed explanation see [Android Cloud Packaging vs Offline Packaging Difference](#package) |
| autoSync | boolean | No | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use [`flushSyncData`](#flushSyncData) to manage data synchronization manually |
| syncPageSize | number | No | Set the number of items per sync request. Range [5,). Larger numbers mean more computational resources used for data synchronization, default is 10 |
| syncSleepTime | number | No | Set the interval between syncs. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | Recommended to enable when coexisting with web data. This setting handles web data type storage compatibility issues |
| compressIntakeRequests | boolean | No | Compress sync data, supported by SDK versions 0.2.0 and above |
| enableLimitWithDbSize | boolean | No | Enable DB cache size limit functionality.<br>**Note:** Enabling this makes the `logCacheLimitCount` and `rumCacheLimitCount` settings ineffective. Supported by SDK versions 0.2.0 and above |
| dbCacheLimit | number | No | DB cache size limit. Range [30MB,), default 100MB, unit byte. Supported by SDK versions 0.2.0 and above |
| dbDiscardStrategy | string | No | Set the database discard rule.<br>Discard strategy: `discard` (default, discards new data), `discardOldest` (discards old data). Supported by SDK versions 0.2.0 and above |

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

| Parameter Name | Type | Required | Description |
| ------------------------ | ------------ | :------- | :------------------------------------------------ |
| androidAppId | string | Yes | App ID, obtained during monitoring setup |
| iOSAppId | string | Yes | App ID, obtained during monitoring setup |
| samplerate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. Scope: all View, Action, LongTask, Error data within the same session_id |
| enableNativeUserAction | boolean | No | Whether to track `Native Action` such as `Button` clicks, suggested to disable for pure `uni-app` applications, default `false`, not supported by Android cloud packaging |
| enableNativeUserResource | boolean | No | Whether to perform automatic tracking of `Native Resource`, default `false`, not supported by Android cloud packaging. Since uniapp uses system APIs for network requests on iOS, enabling this will collect all resource data on iOS. Manually collecting data on iOS should be disabled to prevent duplicate data collection. |
| enableNativeUserView | boolean | No | Whether to perform automatic tracking of `Native View`, suggested to disable for pure `uni-app` applications, default `false` |
| errorMonitorType | string/array | No | Additional error monitoring types: `all`, `battery`, `memory`, `cpu` |
| deviceMonitorType | string/array | No | Additional device monitoring types: `all`, `battery` (only supported on Android), `memory`, `cpu`, `fps` |
| detectFrequency | string | No | Monitoring frequency: `normal` (default), `frequent`, `rare` |
| globalContext | object | No | Custom global parameters, special key: `track_id` (for tracking features) |
| enableResourceHostIP | boolean | No | Whether to collect the IP address of the target domain. Only affects default collection when `enableNativeUserResource` is true. Supported on iOS >= iOS 13. On Android, a single Okhttp caches IP addresses for the same domain, so only one instance is generated if the IP does not change. |
| enableTrackNativeCrash | boolean | No | Whether to collect `Native Error` |
| enableTrackNativeAppANR | boolean | No | Whether to collect `Native ANR` |
| enableTrackNativeFreeze | boolean | No | Whether to collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` lag, range [100,), unit milliseconds. Default on iOS is 250ms, on Android is 1000ms |
| rumDiscardStrategy | string | No | Discard strategy: `discard` (default, discards new data), `discardOldest` (discards old data) |
| rumCacheLimitCount | number | No | Maximum number of cached RUM entries [10000,), default 100,000 |

### Log Configuration {#log-config}

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.setConfig({
  'enableLinkRumData':true,
  'enableCustomLog':true,
  'discardStrategy':'discardOldest'
})
```

| Parameter Name | Type | Required | Description |
| :----------------- | :------------ | :--- | :----------------------------------------------------------- |
| samplerate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. |
| enableLinkRumData | boolean | No | Whether to associate with RUM data |
| enableCustomLog | boolean | No | Whether to enable custom logging |
| discardStrategy | string | No | Log discard strategy: `discard` (default, discards new data), `discardOldest` (discards old data) |
| logLevelFilters | array<string> | No | Log level filters, array values: `info` (information), `warning` (warning), `error` (error), `critical` (critical), `ok` (recovered) |
| globalContext | object | No | Custom global parameters |
| logCacheLimitCount | number | No | Maximum number of locally cached log entries [1000,), larger numbers increase disk cache pressure, default 5000 |

### Trace Configuration {#trace-config}

```javascript
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
tracer.setConfig({
				'traceType': 'ddTrace'
			})
```

| Parameter Name | Type | Required | Description |
| --------------------- | -------- | -------- | ------------------------------------------------------------ |
| samplerate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. |
| traceType | string | No | Trace type: `ddTrace` (default), `zipkinMultiHeader`, `zipkinSingleHeader`, `traceparent`, `skywalking`, `jaeger` |
| enableLinkRUMData | boolean | No | Whether to associate with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Whether to enable automatic native network tracing for iOS `NSURLSession` and Android `OKhttp`, default `false`, not supported by Android cloud packaging. Since uniapp uses system APIs for network requests on iOS, enabling this will automatically track network requests initiated by iOS uniapp. Manually tracking should be disabled on iOS to prevent incorrect association of trace data with `RUM` data. |

## RUM User Data Tracking

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
```

### Action

#### API - startAction

Starts a RUM Action.

RUM binds this Action to potential Resource, Error, and LongTask events. Avoid multiple additions within 0.1 seconds. Only one Action can be associated with the same View at a time. New Actions added while the previous one has not ended will be discarded. This method does not affect Actions added via `addAction`.

```javascript
rum.startAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name | Type | Required | Description |
| ---------- | -------- | -------- | ---------------- |
| actionName | string | Yes | Event name |
| actionType | string | Yes | Event type |
| property | object | No | Event context (optional) |

#### API - addAction

Adds an Action event. This data cannot be associated with Error, Resource, or LongTask data and has no discard logic.

```javascript
rum.addAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name | Type | Required | Description |
| ---------- | -------- | ---- | ---------------- |
| actionName | string | Yes | Event name |
| actionType | string | Yes | Event type |
| property | object | No | Event context (optional) |

### View {#rumview}

* Automatic Collection

```javascript
// Automatic collection, refer to the example project within the SDK package for the GCUniPlugin plugin
// Step 1. Find GCWatchRouter.js and GCPageMixin.js in the SDK package and add them to your project
// Step 2. Add Router monitoring in App.vue as follows:
<script>
	import WatchRouter from '@/GCWatchRouter.js'
	export default {
    mixins:[WatchRouter],
	}
</script>
// Step 3. Add pageMixin in the first displayed page as follows
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
// Manually collect View lifecycle
// Step 1 (Optional)
rum.onCreateView({
					'viewName': 'Current Page Name',
					'loadTime': 100000000,
				})
// Step 2
rum.startView('Current Page Name')
// Step 3  
rum.stopView()         
```

#### API - onCreateView

Record page load time

| Parameter Name | Type | Required | Description |
| -------- | -------- | -------- | ---------------------------- |
| viewName | string | Yes | Page name |
| loadTime | number | Yes | Page load time (nanosecond timestamp) |

#### API - startView {#startview}

Enter page

| Parameter Name | Type | Required | Description |
| -------- | -------- | -------- | ---------------- |
| viewName | string | Yes | Page name |
| property | object | No | Event context (optional) |

#### API - stopView

Leave page

| Parameter Name | Type | Required | Description |
| -------- | -------- | -------- | ---------------- |
| property | object | No | Event context (optional) |

### Error

* Automatic Collection

```javascript
/// Use uniapp error listener functions triggered when script errors or API calls fail
<script>
  var rum = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  var appState = 'startup';
	// Only listen in App.vue
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

| Parameter Name | Type | Required | Description |
| :------- | -------- | -------- | ------------------------------------------ |
| message | string | Yes | Error message |
| stack | string | Yes | Stack trace |
| state | string | No | App running state (`unknown`, `startup`, `run`) |
| type | string | No | Error type, default `uniapp_crash` |
| property | object | No | Event context (optional) |

### Resource

The SDK provides a sample method `gc.request`. This method wraps the `uni.request` network request method, allowing you to replace `uni.request` with `gc.request` for network requests.

**Additional Parameter: `filterPlatform`**

* **Function**: The `filterPlatform` parameter specifies which platform resource data should not be collected.
* **Usage Scenario**: When enabling `enableNativeUserResource`, uniapp automatically collects network request data through system APIs on iOS. To avoid duplicate data collection, you can add `filterPlatform: ["ios"]` to shield manual data collection on iOS when using `gc.request`.

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
	/// Filter platforms using filterPlatform parameter. When `enableNativeUserResource` is enabled,
	/// since uniapp uses system APIs for network requests on iOS, all resource data on iOS can be collected.
	/// At this point, shield manual data collection on iOS to prevent duplicate data collection.
	/// Example:["ios"], do not perform trace tracking or RUM collection on iOS.
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
				if(filter){
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

HTTP request start

| Parameter Name | Type | Required | Description |
| :------- | -------- | -------- | ---------------- |
| key | string | Yes | Unique request identifier |
| property | object | No | Event context (optional) |

#### API - stopResource

HTTP request end

| Parameter Name | Type | Required | Description |
| :------- | -------- | -------- | ---------------- |
| key | string | Yes | Unique request identifier |
| property | object | No | Event context (optional) |

#### API - addResource

| Parameter Name | Type | Required | Description |
| :------- | -------------- | -------- | ------------ |
| key | string | Yes | Unique request identifier |
| content | content object | Yes | Request-related data |

#### content object

| Prototype | Type | Description |
| -------------- | -------- | -------------- |
| url | string | Request URL |
| httpMethod | string | HTTP method |
| requestHeader | object | Request headers |
| responseHeader | object | Response headers |
| responseBody | string | Response body |
| resourceStatus | string | Request status code |

## Logger Log Printing

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.logging({
					'content':`Log content`,
					'status':status
				})
```

### API - logging

| Parameter Name | Type | Required | Description |
| :------- | -------- | -------- | ------------------------ |
| content | string | Yes | Log content, can be a JSON string |
| status | string | Yes | Log level |
| property | object | No | Event context (optional) |

### Log Levels

| String | Meaning |
| -------- | -------- |
| info | Information |
| warning | Warning |
| error | Error |
| critical | Critical |
| ok | Recovery |

## Tracer Network Trace

```javascript
// Example using uni.request for network requests
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
let key = Utils.getUUID(); // Refer to example utils.js
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

Get the request headers needed for trace, which should be added to the HTTP request headers.

| Parameter Name | Type | Required | Description |
| :------- | -------- | -------- | ------------ |
| key | string | Yes | Unique request identifier |
| url | string | Yes | Request URL |

Return type: object

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

| Parameter Name | Type | Required | Description |
| :-------- | -------- | -------- | -------------- |
| userId | string | Yes | User ID |
| userName | string | No | User name |
| userEmail | string | No | User email |
| extra | object | No | Additional user information |

### API - unbindRUMUserData

Unbind the current user.

## Closing the SDK

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.shutDown()
```

### API - shutDown

Shut down the SDK.

## Clearing SDK Cache Data

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.clearAllData()
```

### API - clearAllData

Clear all unsent data.

## Synchronizing Data Proactively {#flushSyncData}

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.flushSyncData()
```

### API - flushSyncData

When `guanceModule.sdkConfig` is set to `true`, no additional actions are needed; the SDK will automatically synchronize data.

When `guanceModule.sdkConfig` is set to `false`, you need to proactively trigger the data synchronization method to synchronize data.

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

Add custom global parameters. Applies to RUM and Log data.

| Parameter Name | Type | Required | Description |
| :------- | -------- | ---- | -------------- |
| None | object | Yes | Custom global parameters |

### API - appendRUMGlobalContext

Add custom RUM global parameters. Applies to RUM data.

| Parameter Name | Type | Required | Description |
| :------- | -------- | ---- | ------------------- |
| None | object | Yes | Custom global RUM parameters |

### API - appendLogGlobalContext

Add custom Log global parameters. Applies to Log data.

| Parameter Name | Type | Required | Description |
| :------- | -------- | ---- | ------------------- |
| None | object | Yes | Custom global Log parameters |

## Common Issues

### Using the iOS Main Project UniPlugin-iOS for Plugin Development

#### Download the UniApp Offline Development SDK

Based on the version of the uni-app development tool **HBuilderX**, download the necessary [SDK package](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) for plugin development.

SDK Package Structure:

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app offline packaging project
	|-- HBuilder-uniPluginDemo		// Main project for developing uni-app plugins (required for this document)
	|-- SDK							// Dependency libraries and resources
```

Drag the dependency libraries and resource files **SDK** folder into the UniPlugin-iOS folder. After dragging, the directory structure should look like this:

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// Main project for developing uni-app plugins (required for this document)
	|-- SDK							// Dependency libraries and resources
```

For more details, refer to [iOS Plugin Development Environment Setup](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#开发环境).

#### Project Configuration

1. Architectures Setting

Since Xcode 12 provides arm64 architecture support for simulators, the framework provided by uni_app supports arm64 for real devices and x86_64 for simulators. Therefore,

Set `Excluded Architectures` for `Any iOS Simulator SDK`: `arm64`.

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

### Using the Android Main Project UniPlugin-Android for Plugin Development

#### Project Configuration {#plugin_gradle_setting}

> For detailed dependency configurations, refer to the [Demo](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example). For more Gradle extension parameter configurations, refer to [Android SDK](../android/app-access.md#gradle-setting)

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

Android cloud packaging and offline packaging use two different integration logics. Offline packaging integrates similarly to the Guance `Android SDK`, using the `Android Studio Gradle Plugin` method. Cloud packaging cannot use the `Android Studio Gradle Plugin`, so some functionalities are implemented internally within the `UniApp Native Plugin`. Therefore, offline packaging has more configuration options compared to cloud packaging. The `offlinePakcage` [parameter](#base-config) in the SDK configuration is used to distinguish between these two scenarios.

### Others
* [Android Privacy Review](../android/app-access.md#third-party)
* [Other iOS Related](../ios/app-access.md#FAQ)
* [Other Android Related](../android/app-access.md#FAQ)
* Native Symbol File Upload
	* [Android](../android/app-access.md#source_map)
	* [iOS](../ios/app-access.md#source_map)