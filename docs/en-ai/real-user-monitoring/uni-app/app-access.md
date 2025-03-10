# UniApp Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [accessible from the public network and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current UniApp version supports Android and iOS platforms. Log in to the <<< custom_key.brand_name >>> console, go to the **User Analysis** page, click on the top-left **[Create](../index.md#create)**, and start creating a new application.

![](../img/image_13.png)

## Installation

### Local Plugin Usage {#local-plugin}

![](https://img.shields.io/badge/dynamic/json?label=plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/uni-app/version.json&link=https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin](https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Demo Address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin/Hbuilder_Example](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example)

Structure of the downloaded SDK package:

```text
|--datakit-uniapp-native-plugin
	|-- Hbuilder_Example				// GCUniPlugin plugin example project
	    |-- nativeplugins          // Example project's local plugin folder
	        |-- GCUniPlugin           // ⭐️ GCUniPlugin native plugin package ⭐️
	            |-- android              // Contains dependency libraries and resource files required for the Android plugin
	            |-- ios                  // Contains dependency libraries and resource files required for the iOS plugin
	            |-- package.json         // Plugin configuration file
	|-- UniPlugin-Android		    // Main project for Android plugin development 
	|-- UniPlugin-iOS					  // Main project for iOS plugin development 
```

Configure the **GCUniPlugin** folder under the "nativeplugins" directory of your uni_app project. Additionally, in the `manifest.json` file under the "App Native Plugin Configuration" section, click "Select Local Plugin", and choose the GCUniPlugin plugin from the list:

![img](../img/15.uniapp_intergration.png)

**Note**: After saving, you need to submit it for cloud packaging (creating a **custom base**) also falls under cloud packaging, after which the plugin will take effect.

> For more details, refer to: [Using Local Plugins in HBuilderX](https://nativesupport.dcloud.net.cn/NativePlugin/use/use_local_plugin.html#), [Custom Base](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground)

### Marketplace Plugin Method
(Not provided)

### Uni Mini Program SDK Installation {#unimp-install}

#### Development Debugging and WGT Publishing Usage {#unimp-use}

* When developing and debugging with the Uni mini program SDK, use the [Local Plugin](#local-plugin) method to integrate **GCUniPlugin**.

* When packaging the Uni mini program SDK into a wgt package for use by the host App, the host App needs to import the [dependencies of **GCUniPlugin**](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example/nativeplugins/GCUniPlugin) (including Native SDK libraries) and register the **GCUniPlugin Module**.

Operations required by the host App:

**iOS**

* Add the **GCUniPlugin** dependency library

    In the Xcode project, select the project name on the left side, then go to `TARGETS -> Build Phases -> Link Binary With Libraries`, click the “+” button, and in the pop-up window, click `Add Other -> Add Files...`. Open the `GCUniPlugin/ios/` dependency library directory, select `FTMobileSDK.xcframework` and `Guance_UniPlugin_App.xcframework` from the directory, and click the `open` button to add the dependency libraries to the project.

    When SDK Version < 0.2.0: In `TARGETS -> General -> Frameworks,Libaries,and Embedded Content`, find `FTMobileSDK.xcframework` and change the Embed method to `Embed & sign`.

* Register the **GCUniPlugin Module**:

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

* Add the **GCUniPlugin** dependency library

   * **Method One:** Place `ft-native-[version].aar`, `ft-sdk-[version].aar`, and `gc-uniplugin-[last-version].aar` from the `GCUniPlugin/android/` folder into the project’s `libs` folder, and modify the `build.gradle` file to add dependencies.
   * **Method Two:** Use the **Gradle Maven** remote repository method for configuration. Refer to UniAndroid-Plugin [project configuration](#plugin_gradle_setting) for this setup.

```Java
  dependencies {
      implementation files('libs/ft-native-[version].aar')
      implementation files('libs/ft-sdk-[version].aar')
      implementation files('libs/gc-uniplugin-[last-version].aar')
      implementation 'com.google.code.gson:gson:2.8.5'
  }   
```

* Register the **GCUniPlugin Module**:

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

* When adding the **GCUniPlugin** dependency library as described above, the Native SDK is already added to the host project, so you can directly call the Native SDK methods.

* SDK Initialization

    In mixed usage scenarios, only initialize the Native SDK within the host App; no additional initialization configuration is needed within the uni mini program, allowing direct calls to methods provided by the UniApp SDK.

    Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) for initializing the SDK within the host App.

    Note: Ensure that the host App completes SDK initialization before loading the uni mini program to ensure that the SDK is fully ready before calling any other SDK methods.

* **Additional Configuration for Android Integration:**

    Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect app launch events and network request data, as well as Android Native related events (page transitions, click events, Native network requests, WebView data).

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

| Parameter Name     | Parameter Type | Required | Description                                                     |
| :----------------- | :------------- | :------- | :-------------------------------------------------------------- |
| datakitUrl         | string         | Yes      | Datakit access URL, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), port defaults to 9529, the device installing the SDK must be able to access this address. **Note: Choose one between datakit and dataway configurations** |
| datawayUrl         | string         | Yes      | Public Dataway access URL, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), port defaults to 9528, the device installing the SDK must be able to access this address. **Note: Choose one between datakit and dataway configurations** |
| clientToken        | string         | Yes      | Authentication token, must be used with datawayUrl               |
| debug              | boolean        | No       | Set whether to allow printing Debug logs, default `false`        |
| env                | string         | No       | Environment, default `prod`, any single word, e.g., `test`       |
| service            | string         | No       | Set the business or service name, default: `df_rum_ios`, `df_rum_android` |
| globalContext      | object         | No       | Add custom tags                                                 |
| offlinePakcage     | boolean        | No       | Only supported on Android, whether to use offline packaging or uni mini program, default `false`, detailed explanation see [Android Cloud Packaging vs Offline Packaging Difference](#package) |
| autoSync           | boolean        | No       | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use [`flushSyncData`](#flushSyncData) method to manage data synchronization manually |
| syncPageSize       | number         | No       | Set the number of items per sync request. Range [5,). Larger numbers mean more computational resources used for data synchronization, default is 10 |
| syncSleepTime      | number         | No       | Set the interval time for synchronization. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | Recommended when coexisting with web data. This configuration handles compatibility issues with web data types storage. |
| compressIntakeRequests | boolean | No | Compress sync data, supported by SDK versions 0.2.0 and above |
| enableLimitWithDbSize | boolean | No | Enable using db to limit data size, default 100MB, unit Byte, larger databases increase disk pressure, default not enabled.<br>**Note:** When enabled, Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` become ineffective. Supported by SDK versions 0.2.0 and above |
| dbCacheLimit       | number         | No       | DB cache limit size. Range [30MB,), default 100MB, unit byte, supported by SDK versions 0.2.0 and above |
| dbDiscardStrategy  | string         | No       | Set the data discard rule in the database.<br>Discard strategy: `discard` discard new data (default), `discardOldest` discard old data. Supported by SDK versions 0.2.0 and above |

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

| Parameter Name                 | Parameter Type     | Required | Description                                                     |
| ------------------------------ | ------------------ | -------- | --------------------------------------------------------------- |
| androidAppId                   | string             | Yes      | appId, obtained during monitoring registration                  |
| iOSAppId                       | string             | Yes      | appId, obtained during monitoring registration                  |
| samplerate                     | number             | No       | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. Applies to all View, Action, LongTask, Error data within the same session_id |
| enableNativeUserAction         | boolean            | No       | Whether to track `Native Action`, such as `Button` click events, recommended to disable for pure `uni-app` applications, default `false`, not supported in Android cloud packaging |
| enableNativeUserResource       | boolean            | No       | Whether to automatically track `Native Resource`, default `false`, not supported in Android cloud packaging. Since uniapp network requests on iOS use system APIs, enabling this will collect all resource data on iOS, at which point please disable manual collection on iOS to prevent duplicate data collection. |
| enableNativeUserView           | boolean            | No       | Whether to automatically track `Native View`, recommended to disable for pure `uni-app` applications, default `false` |
| errorMonitorType               | string/array       | No       | Additional error monitoring types: `all`, `battery`, `memory`, `cpu` |
| deviceMonitorType              | string/array       | No       | Additional page monitoring types: `all`, `battery` (only supported on Android), `memory`, `cpu`, `fps` |
| detectFrequency                | string             | No       | Page monitoring frequency: `normal` (default), `frequent`, `rare` |
| globalContext                  | object             | No       | Custom global parameters, special key: `track_id` (used for tracking features) |
| enableResourceHostIP           | boolean            | No       | Whether to collect the IP address of the target domain. Scope: only affects default collection when `enableNativeUserResource` is true. iOS: supported on `>= iOS 13`. Android: Okhttp has an IP cache mechanism for the same domain, so only one instance is generated if the connected server IP does not change. |
| enableTrackNativeCrash         | boolean            | No       | Whether to collect `Native Error` |
| enableTrackNativeAppANR        | boolean            | No       | Whether to collect `Native ANR` |
| enableTrackNativeFreeze        | boolean            | No       | Whether to collect `Native Freeze` |
| nativeFreezeDurationMs         | number             | No       | Set the threshold for collecting `Native Freeze` delays, range [100,), unit milliseconds. iOS default 250ms, Android default 1000ms |
| rumDiscardStrategy             | string             | No       | Discard strategy: `discard` discard new data (default), `discardOldest` discard old data |
| rumCacheLimitCount             | number             | No       | Local cache maximum RUM item count limit [10_000,), default 100_000 |

### Log Configuration {#log-config}

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.setConfig({
  'enableLinkRumData':true,
  'enableCustomLog':true,
  'discardStrategy':'discardOldest'
})
```

| Parameter Name           | Parameter Type      | Required | Description                                                     |
| :----------------------- | :------------------ | -------- | :-------------------------------------------------------------- |
| samplerate               | number              | No       | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. |
| enableLinkRumData        | boolean             | No       | Whether to associate with RUM                                   |
| enableCustomLog          | boolean             | No       | Whether to enable custom logging                                |
| discardStrategy          | string              | No       | Log discard strategy: `discard` discard new data (default), `discardOldest` discard old data |
| logLevelFilters          | array<string>       | No       | Log level filter, array elements should be **log levels**: `info` info, `warning` warning, `error` error, `critical` critical, `ok` ok recovery |
| globalContext            | object              | No       | Custom global parameters                                        |
| logCacheLimitCount       | number              | No       | Local cache maximum log item count limit [1000,), larger logs mean more disk cache pressure, default 5000 |

### Trace Configuration {#trace-config}

```javascript
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
tracer.setConfig({
				'traceType': 'ddTrace'
			})
```

| Parameter Name              | Parameter Type | Required | Description                                                     |
| ---------------------------- | -------------- | -------- | ------------------------------------------------------------ |
| samplerate                  | number         | No       | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1.              |
| traceType                   | string         | No       | Trace type: `ddTrace` (default), `zipkinMultiHeader`, `zipkinSingleHeader`, `traceparent`, `skywalking`, `jaeger` |
| enableLinkRUMData           | boolean        | No       | Whether to associate with `RUM` data, default `false`                           |
| enableNativeAutoTrace       | boolean        | No       | Whether to enable automatic tracing for native network requests iOS `NSURLSession` ,Android `OKhttp`, default `false`, not supported in Android cloud packaging. Since uniapp network requests on iOS use system APIs, enabling this will automatically trace network requests initiated by iOS uniapp, at which point please disable manual tracing on iOS to prevent incorrect association of trace data with `RUM` data. |

## RUM User Data Tracking

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
```

### Action

#### API - startAction

Start a RUM Action.

RUM binds this Action to possible triggered Resource, Error, LongTask events. Avoid adding multiple times within 0.1 seconds. Only one Action can be associated with the same View at a time, and new Actions added while the previous Action has not ended will be discarded. Adding Actions using `addAction` does not affect each other.

```javascript
rum.startAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name | Parameter Type | Required | Description         |
| --------------- | -------------- | -------- | ------------------- |
| actionName     | string         | Yes      | Event name          |
| actionType     | string         | Yes      | Event type          |
| property       | object         | No       | Event context (optional) |

#### API - addAction

Add an Action event. This data cannot be associated with Error, Resource, LongTask data, and there is no discard logic.

```javascript
rum.addAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name | Parameter Type | Required | Description         |
| --------------- | -------------- | -------- | ------------------- |
| actionName     | string         | Yes      | Event name          |
| actionType     | string         | Yes      | Event type          |
| property       | object         | No       | Event context (optional) |

### View {#rumview}

* Automatic Collection

```javascript
// Automatic collection, refer to the example project within the SDK package for the GCUniPlugin plugin
// Step 1. Find GCWatchRouter.js and GCPageMixin.js files within the SDK package and add them to your project
// Step 2. Add Router monitoring in App.vue as follows:
<script>
	import WatchRouter from '@/GCWatchRouter.js'
	export default {
    mixins:[WatchRouter],
	}
</script>
// Step 3. Add pageMixin to the first displayed page as follows
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
// Step 1 (optional)
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

Record page creation duration

| Parameter Name | Parameter Type | Required | Description                     |
| --------------- | -------------- | -------- | ------------------------------- |
| viewName       | string         | Yes      | Page name                       |
| loadTime       | number         | Yes      | Page loading time (nanosecond timestamp) |

#### API - startView {#startview}

Enter the page

| Parameter Name | Parameter Type | Required | Description         |
| --------------- | -------------- | -------- | ------------------- |
| viewName       | string         | Yes      | Page name           |
| property       | object         | No       | Event context (optional) |

#### API - stopView

Leave the page

| Parameter Name | Parameter Type | Required | Description         |
| --------------- | -------------- | -------- | ------------------- |
| property       | object         | No       | Event context (optional) |

### Error

* Automatic Collection

```javascript
/// Use uniapp error listener function to trigger when script errors or API calls fail
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

| Parameter Name | Parameter Type | Required | Description                                   |
| :------------- | -------------- | -------- | ------------------------------------------ |
| message        | string         | Yes      | Error message                                   |
| stack          | string         | Yes      | Stack information                                   |
| state          | string         | No       | App running state (`unknown`, `startup`, `run`) |
| type           | string         | No       | Error type, default `uniapp_crash` |
| property       | object         | No       | Event context (optional)                           |

### Resource

The SDK provides a sample method `gc.request`. This method wraps the `uni.request` network request method, and you can directly replace `uni.request` with `gc.request` for network requests.

**Additional Parameter: `filterPlatform`**

* **Function**: The `filterPlatform` parameter specifies which platform resource data should not be collected.
* **Usage Scenario**: When the `enableNativeUserResource` feature is enabled, uniapp automatically collects network request data initiated through system APIs on iOS. To avoid duplicate data collection, you can shield manual data collection on iOS platforms by adding the `filterPlatform: ["ios"]` parameter when using `gc.request`.

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
	/// Filter platforms via the `filterPlatform` parameter. When `enableNativeUserResource` is enabled,
	/// since uniapp network requests on iOS use system APIs, all resource data on iOS can be collected together,
	/// so please shield manual collection on iOS to prevent duplicate data collection.
	/// Example:["ios"], iOS platform settings do not perform trace tracking and RUM collection.
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

| Parameter Name | Parameter Type | Required | Description         |
| :------------- | -------------- | -------- | ------------------- |
| key            | string         | Yes      | Unique request identifier     |
| property       | object         | No       | Event context (optional) |

#### API - stopResource

HTTP Request End

| Parameter Name | Parameter Type | Required | Description         |
| :------------- | -------------- | -------- | ------------------- |
| key            | string         | Yes      | Unique request identifier     |
| property       | object         | No       | Event context (optional) |

#### API - addResource

| Parameter Name | Parameter Type       | Required | Description     |
| :------------- | -------------------- | -------- | ------------ |
| key            | string               | Yes      | Unique request identifier |
| content        | content object       | Yes      | Related request data |

#### content object

| Prototype      | Parameter Type | Description       |
| -------------- | -------------- | ------------------ |
| url            | string         | Request URL       |
| httpMethod     | string         | HTTP method      |
| requestHeader  | object         | Request headers         |
| responseHeader | object         | Response headers         |
| responseBody   | string         | Response body       |
| resourceStatus | string         | Request status code |

## Logger Log Printing

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.logging({
					'content':`Log content`,
					'status':status
				})
```

### API - logging

| Parameter Name | Parameter Type | Required | Description                 |
| :------------- | -------------- | -------- | ------------------------ |
| content        | string         | Yes      | Log content, can be a JSON string |
| status         | string         | Yes      | Log level                 |
| property       | object         | No       | Event context (optional)         |

### Log Levels

| String   | Meaning |
| -------- | -------- |
| info     | Info     |
| warning  | Warning  |
| error    | Error    |
| critical | Critical |
| ok       | Recovery |

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

Get the request headers needed for tracing and add them to the HTTP request headers.

| Parameter Name | Parameter Type | Required | Description     |
| :------------- | -------------- | -------- | ------------ |
| key            | string         | Yes      | Unique request identifier |
| url            | string         | Yes      | Request URL     |

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

| Parameter Name  | Parameter Type | Required | Description       |
| :-------------- | -------------- | -------- | -------------- |
| userId          | string         | Yes      | User ID         |
| userName        | string         | No       | User name       |
| userEmail       | string         | No       | User email       |
| extra           | object         | No       | Additional user information |

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

Clear all unsent data.

## Active Data Synchronization {#flushSyncData}

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.flushSyncData()
```

### API - flushSyncData

When `guanceModule.sdkConfig` is configured as `true`, no additional operations are required, and the SDK will synchronize data automatically.

When `guanceModule.sdkConfig` is configured as `false`, you need to actively trigger the data synchronization method for data synchronization.

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

| Parameter Name | Parameter Type | Required | Description       |
| :------------- | -------------- | -------- | -------------- |
| None           | object         | Yes      | Custom global parameters |

### API - appendRUMGlobalContext

Add custom RUM global parameters. Applies to RUM data

| Parameter Name | Parameter Type | Required | Description            |
| :------------- | -------------- | -------- | ------------------- |
| None           | object         | Yes      | Custom global RUM parameters |

### API - appendLogGlobalContext

Add custom RUM and Log global parameters. Applies to Log data

| Parameter Name | Parameter Type | Required | Description            |
| :------------- | -------------- | -------- | ------------------- |
| None           | object         | Yes      | Custom global Log parameters |

## Common Issues

### Using the Main Project of the iOS Plugin UniPlugin-iOS

#### Download UniApp Offline Development SDK

Based on the version number of the uni-app development tool **HBuilderX**, download the [SDK package](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) required for developing plugins.

SDK Package Structure

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app offline packaging project
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and resources
```

Drag the dependency libraries and resource files **SDK** folder into the UniPlugin-iOS folder. After dragging, the directory structure should be as follows.

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and resources
```

For more details, refer to [iOS Plugin Development Environment Configuration](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#development-environment).

#### Project Configuration

1. Architectures Setting

Since Xcode 12's simulator supports the arm64 architecture, the framework provided by uni_app supports arm64 real devices and x86_64 simulators. Therefore,

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

### Using the Main Project of the Android Plugin UniPlugin-Android
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

Android cloud packaging and offline packaging use two different integration logics. The offline packaging integration method is the same as the <<< custom_key.brand_name >>> `Android SDK` integration method, using the `Android Studio Gradle Plugin` method. Cloud packaging cannot use the `Android Studio Gradle Plugin`, so some functionalities are implemented internally within the <<< custom_key.brand_name >>> `UniApp Native Plugin`. Therefore, the offline packaging version has more configurable options than the cloud packaging version. The `offlinePakcage` parameter in the SDK configuration [here](#base-setting) is used to distinguish between these two scenarios.

### Other
* [Android Privacy Review](../android/app-access.md#third-party)
* [Other iOS-related Information](../ios/app-access.md#FAQ)
* [Other Android-related Information](../android/app-access.md#FAQ)
* Native Symbol File Upload
	* [Android](../android/app-access.md#source_map)
	* [iOS](../ios/app-access.md#source_map)

## Common Issues

### Using the Main Project of the iOS Plugin UniPlugin-iOS

#### Download UniApp Offline Development SDK

Based on the version number of the uni-app development tool **HBuilderX**, download the [SDK package](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) required for developing plugins.

SDK Package Structure

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app offline packaging project
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and resources
```

Drag the dependency libraries and resource files **SDK** folder into the UniPlugin-iOS folder. After dragging, the directory structure should be as follows.

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and resources
```

For more details, refer to [iOS Plugin Development Environment Configuration](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#development-environment).

#### Project Configuration

1. Architectures Setting

Since Xcode 12's simulator supports the arm64 architecture, the framework provided by uni_app supports arm64 real devices and x86_64 simulators. Therefore,

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

### Using the Main Project of the Android Plugin UniPlugin-Android
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
		//--> Configure buildScript
		//	classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:xxxx'
```

### Differences Between Android Cloud Packaging and Offline Packaging {#package}

Android cloud packaging and offline packaging use two different integration methods. Offline packaging uses the same integration logic as the <<< custom_key.brand_name >>> `Android SDK`, which uses the `Android Studio Gradle Plugin` method. Cloud packaging does not support the `Android Studio Gradle Plugin`, so it relies on internal code implementations within the <<< custom_key.brand_name >>> `UniApp Native Plugin`. Therefore, the offline packaging version offers more configuration options compared to the cloud packaging version. The `offlinePakcage` parameter in the SDK configuration [here](#base-setting) is used to differentiate between the two scenarios.

### Others
* [Android Privacy Review](../android/app-access.md#third-party)
* [Other iOS-related Information](../ios/app-access.md#FAQ)
* [Other Android-related Information](../android/app-access.md#FAQ)
* Native Symbol File Upload
	* [Android](../android/app-access.md#source_map)
	* [iOS](../ios/app-access.md#source_map)

---

This concludes the translation of the provided content. If you need further assistance or have any specific sections you would like me to focus on, please let me know!