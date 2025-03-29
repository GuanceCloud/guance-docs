# UniApp Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites will be automatically configured for you. You can directly proceed with application integration.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [accessible from the public network and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

The current UniApp version supports Android and iOS platforms. Log in to the <<< custom_key.brand_name >>> console, go to the **Synthetic Tests** page, click the top-left **[Create]** to start creating a new application.

![](../img/image_13.png)

## Installation

### Local Usage {#local-plugin}

![](https://img.shields.io/badge/dynamic/json?label=plugin&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/uni-app/version.json&link=https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin](https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Demo Address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin/Hbuilder_Example](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/master/Hbuilder_Example)


SDK package structure description:

```text
|--datakit-uniapp-native-plugin
  |-- Hbuilder_Example		      // Example project for GCUniPlugin plugin
	  |-- nativeplugins		      // Folder for local plugins of the example project
		  |-- GCUniPlugin         // ⭐️ Native plugin package for GCUniPlugin ⭐️
		  |   |-- android         // Dependency libraries and resource files required by the android plugin
		  |   |-- ios             // Dependency libraries and resource files required by the ios plugin
		  |   |-- package.json    // Plugin configuration file
	  |-- GCPageMixin.js          // JS for automatic view capturing, GCPageMixin.js works together with GCWatchRouter.js
	  |-- GCWatchRouter.js        // JS for automatic view capturing, GCPageMixin.js works together with GCWatchRouter.js
	  |-- GCPageViewMixinOnly.js  // JS for automatic view capturing, GCPageViewMixinOnly.js works alone
	  |-- GCRequest.js            // JS for resources and traces, providing APM and network request monitoring capabilities
  |-- UniPlugin-Android           // Main project for developing Android plugins
  |-- UniPlugin-iOS               // Main project for developing iOS plugins
```

Place the **GCUniPlugin** folder under the "nativeplugins" directory of your uni_app project. You also need to select "Select Local Plugins" under the "Native Plugin Configuration" item in the manifest.json file and choose the GCUniPlugin plugin from the list:

![img](../img/15.uniapp_intergration.png)

**Note**: After saving, you need to submit it for cloud packaging (creating a **Custom Base** also falls under cloud packaging), for the plugin to take effect.

> For more details, refer to: [Using Local Plugins in HBuilderX](https://nativesupport.dcloud.net.cn/NativePlugin/use/use_local_plugin.html#), [Custom Base](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground)

### Market Plugin Method
(Not provided)

### uni Mini Program SDK Installation {#unimp-install}

#### Development Debugging and wgt Release Use {#unimp-use}

* When developing and debugging the uni mini program SDK, use the [Local Usage](#local-plugin) method to integrate **GCUniPlugin**.

* When packaging the uni mini program SDK into a wgt bundle for the host App, the host App needs to import the dependencies of [**GCUniPlugin**](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example/nativeplugins/GCUniPlugin) (including the Native SDK library) and register the **GCUniPlugin Module**.

Operations required by the host App:

**iOS**

* Add **GCUniPlugin** dependency libraries

    In the Xcode project, select the project name on the left, go to `TARGETS -> Build Phases -> Link Binary With Libaries`, click the "+" button, and in the pop-up window, click `Add Other -> Add Files...`. Then open the `GCUniPlugin/ios/` dependency library directory, select `FTMobileSDK.xcframework` and `Guance_UniPlugin_App.xcframework` from the directory, and click the `open` button to add the dependency libraries to the project.

    When SDK Version < 0.2.0: In `TARGETS -> General -> Frameworks,Libaries,and Embedded Content`, change the Embed method of `FTMobileSDK.xcframework` to `Embed & sign`.

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

* Add **GCUniPlugin** dependency libraries

   * **Method One:** Add `ft-native-[version].aar`, `ft-sdk-[version].aar`, `gc-uniplugin-[last-version].aar` from the `GCUniPlugin/android/` folder to the `libs` folder of your project, and modify the `build.gradle` file to add dependencies.
   * **Method Two:** Use the **Gradle Maven** remote repository method for configuration. Refer to the configuration method of UniAndroid-Plugin [project configuration](#plugin_gradle_setting).

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

#### Mixed Use of UniApp SDK and Native SDK {#unimp-mixup}

* The Native SDK has already been added to the host project during the operation of adding the **GCUniPlugin** dependency libraries, so the Native SDK methods can be called directly.

* SDK Initialization

    In mixed usage, only initialize the Native SDK within the host App; there is no need to perform initialization configurations again in the uni mini program. You can directly call the methods provided by the UniApp SDK.

    For the initial method of the SDK inside the host App, refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init).

    Note: Please complete the SDK initialization in the host App before loading the uni mini program to ensure that the SDK is fully ready before calling any other SDK methods.

* **Additional Android Configuration:**

    Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events, network request data, and Android Native related events (page transitions, click events, Native network requests, WebView data).

## SDK Initialization

### Basic Configuration {#base-setting}

```javascript
// Configure in App.vue
<script>
	var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
	export default {
		onLaunch: function() {
			guanceModule.sdkConfig({
				'datakitUrl': 'your datakitUrl',
				'debug': true,
				'env': 'common',
				'globalContext': {
					'custom_key': 'custom value'
				}
			})
		}
	}
</script>
<style>
</style>
```

| Parameter Name      | Parameter Type | Required | Parameter Description                                                     |
| :------------ | :------- | :--- | ------------------------------------------------------------ |
| datakitUrl | string   | Yes   | Datakit access URL, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, devices with the installed SDK must be able to access this address. **Note: Choose one between datakit and dataway configurations** |
| datawayUrl | string | Yes | Public Dataway access URL, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, devices with the installed SDK must be able to access this address. **Note: Choose one between datakit and dataway configurations** |
| clientToken | string | Yes | Authentication token, must be used together with datawayUrl |
| debug         | boolean  | No   | Set whether to allow printing of Debug logs, default `false`                            |
| env | string   | No   | Environment, default `prod`, any character, recommended to use a single word like `test` etc. |
| service       | string   | No   | Set the name of the business or service, default: `df_rum_ios`、`df_rum_android` |
| globalContext | object   | No   | Add custom tags                                               |
| offlinePakcage | boolean   | No   | Supported only on Android, whether to use offline packaging or uni mini program, default `false`, detailed explanation see [Difference Between Android Cloud Packaging and Offline Packaging](#package)       |
| autoSync | boolean | No | Whether to enable automatic synchronization. Default `YES`. When set to `NO`, use the [`flushSyncData`](#flushSyncData) method to manage data synchronization manually |
| syncPageSize | number | No | Set the number of entries for synchronization requests. Range [5,). Note: The larger the number of request entries, the more computing resources will be consumed for data synchronization, default is 10 |
| syncSleepTime | number | No | Set the intermittent time for synchronization. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | It is recommended to enable when coexisting with web data. This configuration handles web data type storage compatibility issues. Automatically enabled after version 0.2.1 |
| compressIntakeRequests | boolean | No | Compress synchronized data, supported by SDK versions 0.2.0 and above |
| enableLimitWithDbSize | boolean | No | Enable limiting data size using db, default 100MB, unit Byte, larger databases increase disk pressure, default not enabled.<br>**Note:** After enabling, the Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` will become invalid. Supported by SDK versions 0.2.0 and above |
| dbCacheLimit | number | No | DB cache size limit. Range [30MB,), default 100MB, unit byte, supported by SDK versions 0.2.0 and above |
| dbDiscardStrategy | string | No | Set the data discard rule in the database.<br>Discard strategy: `discard` discard new data (default), `discardOldest` discard old data. Supported by SDK versions 0.2.0 and above |

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
| ------------------------ | ------------ | :------- | ------------------------------------------------------------ |
| androidAppId             | string       | Yes       | App ID, applied for during monitoring                                            |
| iOSAppId                 | string       | Yes       | App ID, applied for during monitoring                                            |
| samplerate               | number       | No       | Sampling rate, range [0,1], 0 means no sampling, 1 means full sampling, default value is 1. Scope applies to all View, Action, LongTask, Error data under the same session_id        |
| enableNativeUserAction   | boolean      | No       | Whether to track `Native Action`, `Button` click events, pure `uni-app` applications are recommended to turn this off, default is `false`, Android cloud packaging does not support it |
| enableNativeUserResource | boolean      | No       | Whether to automatically track `Native Resource`, default is `false`, Android cloud packaging does not support it. Since the network requests in uniapp on iOS use system APIs, after enabling this, all resource data on iOS can be collected, at which point manual collection on iOS should be disabled to prevent duplicate data collection. |
| enableNativeUserView     | boolean      | No       | Whether to automatically track `Native View`, pure `uni-app` applications are recommended to turn this off, default is `false` |
| errorMonitorType         | string/array | No       | Additional error monitoring types: `all`, `battery`, `memory`, `cpu`        |
| deviceMonitorType        | string/array | No       | Additional page monitoring types: `all`, `battery` (only supported on Android), `memory`, `cpu`, `fps` |
| detectFrequency          | string       | No       | Page monitoring frequency: `normal` (default), `frequent`, `rare`            |
| globalContext            | object       | No       | Custom global parameters, special key: `track_id` (for tracking functionality)         |
| enableResourceHostIP | boolean | No | Whether to collect the IP address of the target domain of the request. Scope: Only affects the default collection when `enableNativeUserResource` is set to true. Supported on iOS >= iOS 13. On Android, Okhttp has an IP caching mechanism for the same domain, meaning only one instance will be generated per unique `OkhttpClient` if the server IP does not change. |
| enableTrackNativeCrash | boolean | No | Whether to collect `Native Error` |
| enableTrackNativeAppANR | boolean | No | Whether to collect `Native ANR` |
| enableTrackNativeFreeze | boolean | No | Whether to collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` delays, range [100,), unit milliseconds. Default is 250ms on iOS, 1000ms on Android |
| rumDiscardStrategy | string | No | Discard strategy: `discard` discards new data (default), `discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum number of cached RUM entries locally [10_000,), default is 100_000 |

### Log Configuration {#log-config}

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.setConfig({
  'enableLinkRumData':true,
  'enableCustomLog':true,
  'discardStrategy':'discardOldest'
})
```

| Parameter Name           | Parameter Type      | Required | Parameter Description                                                     |
| :----------------- | :------------ | :--- | :----------------------------------------------------------- |
| samplerate         | number        | No   | Sampling rate, range [0,1], 0 means no sampling, 1 means full sampling, default value is 1. |
| enableLinkRumData  | boolean       | No   | Whether to link with RUM                                              |
| enableCustomLog    | boolean       | No   | Whether to enable custom logs                                           |
| discardStrategy    | string        | No   | Log discard strategy: `discard` discards new data (default), `discardOldest` discards old data |
| logLevelFilters    | array<string> | No   | Log level filters, array must include **log levels**: `info` prompt, `warning` warning, `error` error, `critical`, `ok` recovery |
| globalContext      | object        | No   | Custom global parameters                                               |
| logCacheLimitCount | number        | No   | Maximum number of cached log entries locally [1000,), the larger the logs, the greater the disk cache pressure, default is 5000 |

### Trace Configuration {#trace-config}

```javascript
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
tracer.setConfig({
  'traceType': 'ddTrace'
})
```

| Parameter Name              | Parameter Type | Required | Parameter Description                                                     |
| --------------------- | -------- | -------- | ------------------------------------------------------------ |
| samplerate            | number   | No       | Sampling rate, range [0,1], 0 means no sampling, 1 means full sampling, default value is 1.              |
| traceType             | string   | No       | Trace type: `ddTrace` (default), `zipkinMultiHeader`, `zipkinSingleHeader`, `traceparent`, `skywalking`, `jaeger` |
| enableLinkRUMData     | boolean  | No       | Whether to link with `RUM` data, default `false`                           |
| enableNativeAutoTrace | boolean  | No       | Whether to enable native network automatic tracing iOS `NSURLSession` , Android `OKhttp`, default `false`, Android cloud packaging does not support it. Since the network requests in uniapp on iOS use system APIs, after enabling this, network requests initiated by iOS uniapp can be automatically traced, at which point manual chain tracing on iOS should be disabled to prevent incorrect association of chain and `RUM` data. |

## RUM User Data Tracking

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
```

### Action

#### API - startAction

Starts a RUM Action.

RUM binds possible triggered Resource, Error, LongTask events to this Action. Avoid multiple additions within 0.1 seconds, only one Action can be associated with the same View at the same time. New Actions will be discarded if the previous Action has not ended yet. Adding Actions via `addAction` method does not affect this.

```javascript
rum.startAction({
  'actionName': 'action name',
  'actionType': 'action type'
})
```

| Parameter Name   | Parameter Type | Required | Parameter Description         |
| ---------- | -------- | -------- | ---------------- |
| actionName | string   | Yes       | Event name         |
| actionType | string   | Yes       | Event type         |
| property   | object   | No       | Event context (optional) |

#### API - addAction

Adds an Action event. This kind of data cannot associate with Error, Resource, LongTask data and has no discard logic.

```javascript
rum.addAction({
  'actionName': 'action name',
  'actionType': 'action type'
})
```

| Parameter Name   | Parameter Type | Required | Parameter Description         |
| ---------- | -------- | ---- | ---------------- |
| actionName | string   | Yes   | Event name         |
| actionType | string   | Yes   | Event type         |
| property   | object   | No   | Event context (optional) |

### View {#rumview}

* Automatic Collection

**Method One:**
Only need to configure in `App.vue` and the first page the application enters. Refer to the example project `Hbuilder_Example/App.vue`, `Hbuilder_Example/pages/index/index.vue` within the SDK package's `GCUniPlugin` plugin.

```javascript
// step 1. Find GCWatchRouter.js, GCPageMixin.js files within the SDK package and add them to your project
// step 2. Add Router monitoring in App.vue as follows:
<script>
  import WatchRouter from '@/GCWatchRouter.js'
  export default {
	mixins:[WatchRouter], //<--- Notice
  }
</script>
// step 3. Add pageMixin to the first displayed page as follows
<script>
  import GCPageMixin from '../../GCPageMixin.js';
  export default {
	data() {
	  return {}
	},
	mixins:[GCPageMixin], //<--- Notice
  }
</script>
```

**Method Two:**
Apply to each page that needs monitoring, separate from `GCWatchRouter.js`. Refer to the example project `Hbuilder_Example/pages/rum/index.vue` within the SDK package's `GCUniPlugin` plugin.

```javascript
//Find GCPageViewMixinOnly.js within the SDK package and add it to your project
<script>
import { rumViewMixin } from '../../GCPageViewMixinOnly.js';
export default {
	data() {
		return {			
		}
	},
	mixins:[rumViewMixin], //<--- Notice
	methods: {}
}
</script>
```

* Manual Collection

```javascript
// Manually collect the lifecycle of Views
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

Record creation duration of pages

| Field | Type | Required | Description                      |
| -------- | -------- | -------- | ---------------------------- |
| viewName | string   | Yes       | Page name                     |
| loadTime | number   | Yes       | Page load time (nanosecond timestamp) |

#### API - startView {#startview}

Enter the page

| Field | Type | Required | Description          |
| -------- | -------- | -------- | ---------------- |
| viewName | string   | Yes       | Page name         |
| property | object   | No       | Event context (optional) |

#### API - stopView

Leave the page

| Field | Type | Required | Description          |
| -------- | -------- | -------- | ---------------- |
| property | object   | No       | Event context (optional) |

### Error

* Automatic Collection

```javascript
/// Use the uniapp error listening function, triggered when script errors or API calls fail
<script>
  var rum = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  var appState = 'startup';
  // Can only listen in App.vue
  export default {
	onShow: function() {
	  appState = 'run'
	},
	onError:function(err){   
	  if (err instanceof Error){
		rum.addError({
		  'message': err.message,
		  'stack': err.stack,
		  'state': appState,
		})
	  }else if(err instanceof String){
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

| Field | Type | Required | Description                                   |
| :------- | -------- | -------- | ------------------------------------------ |
| message  | string   | Yes       | Error information                                   |
| stack    | string   | Yes       | Stack information                                   |
| state    | string   | No       | App running status (`unknown`, `startup`, `run`) |
| type | string | No | Error type, default `uniapp_crash` |
| property | object   | No       | Event context (optional)                           |

### Resource {#resource}
* Automatic Collection

SDK provides the method `gc.request`, inheriting the `uni.request` network request method, which can replace `uni.request` for use.

**Replacement Method**
```diff
+ import gc from './GCRequest.js'; 
- uni.request({
+ gc.request({
  //...
});
```

**Usage Example**
```javascript
//Find GCRequest.js within the SDK package and add it to your project
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

| Extra Field | Type | Required | Description                                   |
| :------- | -------- | -------- | ------------------------------------------ |
| filterPlatform    |  array  | No       | When the `enableNativeUserResource` feature is enabled, uniapp on iOS automatically collects network request data through system APIs. To avoid duplicate data collection, you can add the parameter `filterPlatform: ["ios"]` when using `gc.request` to disable manual data collection on the iOS platform.                                 |

* Manual Collection

Call `startResource`, `stopResource`, `addResource` manually to implement, refer to the implementation method of [GCRequest.js](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/blob/master/Hbuilder_Example/GCRequest.js)


#### API - startResource

HTTP request starts

| Field | Type | Required | Description          |
| :------- | -------- | -------- | ---------------- |
| key      | string   | Yes       | Request unique identifier     |
| property | object   | No       | Event context (optional) |

#### API - stopResource

HTTP request ends

| Field | Type | Required | Description          |
| :------- | -------- | -------- | ---------------- |
| key      | string   | Yes       | Request unique identifier     |
| property | object   | No       | Event context (optional) |

#### API - addResource

| Parameter Name | Parameter Type       | Required | Parameter Description     |
| :------- | -------------- | -------- | ------------ |
| key      | string         | Yes       | Request unique identifier |
| content  | content object | Yes       | Request related data |

#### content object

| Prototype      | Parameter Type | Parameter Description       |
| -------------- | -------- | -------------- |
| url            | string   | Request url       |
| httpMethod     | string   | HTTP method      |
| requestHeader  | object   | Request headers         |
| responseHeader | object   | Response headers         |
| responseBody   | string   | Response result       |
| resourceStatus | string   | Request result status code |

## Logger Logging

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.logging({
  'content':`Log content`,
  'status':status
})
```

### API - logging

| Field | Type | Required | Description                  |
| :------- | -------- | -------- | ------------------------ |
| content  | string   | Yes       | Log content, can be json string |
| status   | string   | Yes       | Log level                 |
| property | object   | No       | Event context (optional)         |

### Log Levels

| String   | Meaning |
| -------- | -------- |
| info     | Prompt     |
| warning  | Warning     |
| error    | Error     |
| critical | Severe     |
| ok       | Recovery     |

## Tracer Network Chain Trace

* Automatic Collection

Use `gc.request` for request invocation, which automatically adds Propagation Header, refer to [Resource](#resource)

* Manual Collection

```javascript
//Example using uni.request for network request
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
let key = Utils.getUUID();//Refer to Hbuilder_Example/utils.js
var header = tracer.getTraceHeader({
	  'key': key,
	  'url': requestUrl,
})
uni.request({
		url: requestUrl,
		header: header,
		success() {

		},
		complete() {

		}
});
```

#### API - getTraceHeader

Get the request headers needed for trace, then add them to the HTTP request headers.

| Field | Type | Required | Description      |
| :------- | -------- | -------- | ------------ |
| key      | string   | Yes       | Request unique identifier |
| url      | string   | Yes       | Request URL     |

Return type: object 

## User Information Binding and Unbinding

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

| Field | Type | Required | Description        |
| :-------- | -------- | -------- | -------------- |
| userId    | string   | Yes       | User ID         |
| userName  | string   | No       | User name       |
| userEmail | string   | No       | User email       |
| extra     | object   | No       | Additional user information |

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

Clear all data that has not yet been uploaded to the server.

## Active Data Synchronization {#flushSyncData}

```javascript
var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
guanceModule.flushSyncData()
```

### API - flushSyncData

When configuring `guanceModule.sdkConfig` as `true`, no additional operations are required, the SDK will synchronize automatically.

When configuring `guanceModule.sdkConfig` as `false`, you need to actively trigger the data synchronization method to synchronize data.

## WebView Data Monitoring

WebView data monitoring requires integrating the [Web Monitoring SDK](../web/app-access.md) on the accessed page.
> Android supports only offline packaging and uni mini programs

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

Add custom global parameters. Applies to RUM, Log data

| Field | Type | Required | Description        |
| :------- | -------- | ---- | -------------- |
| None       | object   | Yes   | Custom global parameters |

### API - appendRUMGlobalContext

Add custom RUM global parameters. Applies to RUM data

| Field | Type | Required | Description             |
| :------- | -------- | ---- | ------------------- |
| None       | object   | Yes   | Custom global RUM parameters |

### API - appendLogGlobalContext

Add custom RUM, Log global parameters. Applies to Log data

| Field | Type | Required | Description             |
| :------- | -------- | ---- | ------------------- |
| None       | object   | Yes   | Custom global Log parameters |

## Common Issues

### Using the Main Project UniPlugin-iOS for Plugin Development

#### Download UniApp Offline Development SDK

According to the version number of the uni-app development tool **HBuilderX**, download the [SDK package](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) required for plugin development.

SDK package structure description

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app offline packaging project
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and dependent resource files
```

Drag the **SDK** folder containing the dependency libraries and dependent resource files to the UniPlugin-iOS folder. After dragging, the directory structure should look like this.

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// Main project for uni-app plugin development (the project used in this document)
	|-- SDK							// Dependency libraries and dependent resource files
```

For more details, refer to [iOS Plugin Development Environment Configuration](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#DevelopmentEnvironment).

#### Project Configuration

1.Architectures Setting

Since Xcode 12 provides simulators supporting arm64 architecture, the framework provided by uni_app supports real machines with arm64, and simulators with x86_64. Therefore,

Set `Excluded Architectures` for `Any iOS Simulator SDK`: `arm64`.

2.Other Linker Flags 

```
$(inherited) -ObjC -framework "FTMobileSDK" -framework "Guance_UniPlugin_App"
```

3.Framework Search Paths

```
$(inherited)
"${PODS_CONFIGURATION_BUILD_DIR}/FTMobileSDK"
"${PODS_CONFIGURATION_BUILD_DIR}/Guance-UniPlugin-App"
$(DEVELOPER_FRAMEWORKS_DIR)
$(PROJECT_DIR)/../SDK/libs
$(PROJECT_DIR)
```

### Using the Main Project UniPlugin-Android for Plugin Development 
#### Project Configuration {#plugin_gradle_setting}

> Detailed dependency configuration can be found in the [Demo](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example). For more Gradle extension parameter configurations, refer to [Android SDK](../android/app-access.md#gradle-setting)

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

### Difference Between Android Cloud Packaging and Offline Packaging {#package}

Android cloud packaging and offline packaging use two different integration logics. The offline packaging integration method is the same as the <<< custom_key.brand_name >>> `Android SDK` integration method, using the `Android Studio Gradle Plugin` method. Cloud packaging cannot use the `Android Studio Gradle Plugin`, so some functionalities are implemented internally through <<< custom_key.brand_name >>> `UniApp Native Plugin`. Therefore, the offline packaging version has more configurable options than the cloud packaging version. The `offlinePakcage` [parameter](#base-config) in the SDK configuration is used to distinguish between these two cases.

### Others
* [Android Privacy Review](../android/app-access.md#third-party)
* [Other iOS Related](../ios/app-access.md#FAQ)
* [Other Android Related](../android/app-access.md#FAQ)
* Native Symbol File Upload
	* [Android](../android/app-access.md#source_map)
	* [iOS](../ios/app-access.md#source_map)