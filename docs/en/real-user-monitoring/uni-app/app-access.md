# UniApp Application Access

---

## Precondition

- Install DataKit, see [DataKit installation doc](../../datakit/datakit-install.md).

## App Access
The current version of UniApp supports Android and iOS platforms.<br>
Log in to Guance studio, enter the **Application Monitoring** page, click **Create Application** in the upper right corner, enter **Application Name** in the new window, click **Create**, and then access the corresponding platform to start configuration.

![](../img/image_12.png)

![](../img/image_13.png)

## Installation

### Local Plugin {#local-plugin}

**Source address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin](https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Demo address**: [https://github.com/GuanceCloud/datakit-uniapp-native-plugin/Hbuilder_Example](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example)


Description of downloaded SDK package structure:

```text
|--datakit-uniapp-native-plugin
	|-- Hbuilder_Example				// Example project of GCUniPlugin plugin
	    |-- nativeplugins          // Local plug-in folder for the sample project
	        |-- GCUniPlugin           // ⭐️ GCUniPlugin native plug-in package ⭐️
	            |-- android              // Store dependency libraries and resource files required by android plug-ins
	            |-- ios                  // Store dependency libraries and resource files required by ios plug-ins
	            |-- package.json         // Plug-in configuration file
	|-- UniPlugin-Android		    // Plug-in development Android main project 
	|-- UniPlugin-iOS					  // Plug-in development iOS main project 
```

To configure the **GCUniPlugin** folder under "nativeplugins" in your uni_App project, click **Select Native Plugin** under **App Native Plugin Configuration** in the manifest.json file, and select the GCUniPlugin plug-in from the list:

![img](../img/15.uniapp_intergration.png)

>Note: After saving, you need to submit the plug-in to the cloud for packaging (making **custom base** also belongs to cloud packaging) before the plug-in would take effect.

See: [Using local plug-ins in HBuilderX](https://nativesupport.dcloud.net.cn/NativePlugin/use/use_local_plugin.html#) and [Custom base](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground).

### Market Plug-in Mode
None yet.

## SDK Initialization

### Basic Configuration {#base-config}

```javascript
// Configure in App.vue
<script>
    var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
    export default {
        onLaunch: function() {
            console.log('App Launch')
            guanceModule.sdkConfig({
                'serverUrl': 'your severurl',
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

| Parameter Name      | Parameter Type | Required | Parameter Description                                                     |
| :------------ | :------- | :--- | ------------------------------------------------------------ |
| serverUrl     | string   | Yes   |The url of the datakit installation address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed                                                  |
| debug         | boolean  | No   | Set whether to allow printing of Debug logs, default  `false`                            |
| env | string   | No   | Environment, defaulting to `prod`, any character is allowed, preferably a single word, such as test, etc. |
| service       | string   | No   | Set the name of the business or service to which it belongs by default: `df_rum_ios`, `df_rum_android` |
| globalContext | object   | No   | Add custom labels                                               |
| offlinePakcage | boolean   | No   | Only supported by Android, whether to use offline packaging, the default is `false`. For detailed Description, see [difference between Android cloud packaging and offline packaging](#package)       |

### RUM Configuration

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
rum.setConfig({
        'androidAppId':'YOUR_ANDROID_APP_ID',
				'iOSAppId':'YOUR_IOS_APP_ID',
				'errorMonitorType':'all', // or 'errorMonitorType':['battery','memory']
				'deviceMonitorType':['cpu','memory']// or  'deviceMonitorType':'all'
			})
```

| Parameter Name                 | Parameter Type     | **Required** | **Description**                                                     |
| ------------------------ | ------------ | :------- | ------------------------------------------------------------ |
| androidAppId             | string       | Yes       | appId, application under monitoring                                            |
| iOSAppId                 | string       | Yes       | appId, application under monitoring                                            |
| samplerate               | number       | No       | Sampling rate, (the value range of collection rate is more than yet less than 1, the default value is 1)           |
| enableNativeUserAction   | boolean      | No       | Whether to carry out `Native Action` tracking, `Button` click event, pure `uni-app` application is recommended to close, default is `false`, Android cloud packaging is not supported |
| enableNativeUserResource | boolean      | No       | Whether to carry out `Native Resource` automatic tracking, pure `uni-app` application is recommended to be closed, and the default is `false`, which is not supported by Android cloud packaging|
| enableNativeUserView     | boolean      | No       | Whether to do `Native View` auto-tracking, pure `uni-app` application recommended to turn off, default to `false` |
| errorMonitorType         | string/array | No       | Error monitoring supplement type: `all`, `battery`, `memory`, `cpu`        |
| deviceMonitorType        | string/array | No       | Page monitoring supplement types: `all`, `battery`(Android only), `memory`, `cpu`, `fps` |
| detectFrequency          | string       | No       | Page monitoring frequency: `normal` (default), `frequent`, `rare`            |
| globalContext            | object       | No       | Custom global parameter, special key: `track_id`(for tracing function)         |

### Log Configuration

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.setConfig({
  'enableLinkRumData':true,
  'enableCustomLog':true,
  'discardStrategy':'discardOldest'
})
```

| Parameter Name          | Parameter Type      | Required | Parameter Description                                                     |
| :---------------- | :------------ | :--- | :----------------------------------------------------------- |
| samplerate        | number        | No   | Sampling rate                                                       |
| enableLinkRumData | boolean       | No   | Whether associate with RUM                                              |
| enableCustomLog   | boolean       | No   | Whether to turn on custom logging                                           |
| discardStrategy   | string        | No   | Log discarding policy: `discard` discards new data (default), `discardOlest` discards old data |
| logLevelFilters   | array<string> | No   | Log level filter, fill in the array **log level**: `info` hint, `warning`, ` error `, `critical`, `ok` recovery |
| globalContext     | object        | No   | Custom global parameters                                               |

### Trace Configuration

```javascript
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
tracer.setConfig({
				'traceType': 'ddTrace'
			})
```

| Parameter Name              | Parameter Type | **Required** | Description                                                     |
| --------------------- | -------- | -------- | ------------------------------------------------------------ |
| samplerate            | double   | No       | Sampling rate, the value range of acquisition rate is more than 0 but less than 1, and the default value is 1              |
| traceType             | string   | No       | Link type: `ddTrace`(default)`zipkinMultiHeader`, `zipkinSingleHeader`, `traceparent`,`skywalking` and `jaeger` |
| enableLinkRUMData     | boolean  | No       | Whether it is associated with `RUM` data, default `false`                           |
| enableNativeAutoTrace | boolean  | No       | Whether to turn on native network automatic tracking iOS `NSURLSession`, Android `OKhttp`, default `false`, pure `uni-app` application is recommended to turn off, Android cloud packaging is not supported
 |

## RUM User Data Tracking

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
```

### Action

#### API - startAction

Add Action event:

```javascript
rum.startAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| Parameter Name   | Parameter Type | **Required** | Parameter Description         |
| ---------- | -------- | -------- | ---------------- |
| actionName | string   | Yes       | Event name         |
| actionType | string   | Yes       | Event type         |
| property   | object   | No       | Event context(optional) |

### View

* Automatic collection

```javascript
// Automatic collection, please refer to the example project of GCUniPlugin plug-in in SDK package
// step 1. Find the GCWatchRouter.js, GCPageMixin.js file in the SDK package and add it to your project
// step 2. Add Router monitoring to App.vue, as follows:
<script>
	import WatchRouter from '@/GCWatchRouter.js'
	export default {
    mixins:[WatchRouter],
	}
</script>
// step 3. Add pageMixin to the first page displayed by the application as follows:
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

* Manual collection

```dart
// Manually collect the life cycle of View
// step 1(optional)
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

Create a page duration record:

| Parameter Name | Parameter Type | **Required** | Parameter Description                     |
| -------- | -------- | -------- | ---------------------------- |
| viewName | string   | Yes       | Page name                     |
| loadTime | number   | Yes       | Page load time (nanosecond timestamp) |

#### API - startView 

Enter the page:

| Parameter Name | Parameter Type | **Required** | Parameter Description         |
| -------- | -------- | -------- | ---------------- |
| viewName | string   | Yes       | Page name          |
| property | object   | No       | Event context(optional) |

#### API - stopView

Leave the page:

| Parameter Name | Parameter Type | **Required** | Parameter Description         |
| -------- | -------- | -------- | ---------------- |
| property | object   | No       | Event context(optional) |

### Error

* Automatic collection

```javascript
/// Triggered when a script error or an API call error occurs using the uniapp error listener function
<script>
  var rum = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  var appState = 'startup';
	// only listen in App.vue
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

* Manual collection

```javascript
// Manual adding
rum.addError({
					'message': 'Error message',
					'stack': 'Error stack',
				})
```
#### API - addError

Add Error events:

| Parameter Name | Parameter Type | **Required** | Parameter Description         |
| :------- | -------- | -------- | ---------------- |
| message  | string   | Yes       | Error message         |
| stack    | string   | Yes       | Stack information         |
| state | string | No | App running state (`unknown`、`startup`、`run`) |
| property | object   | No       | Event context(optional) |

### Resource

```javascript
//The example uses uni.request for network requests,
      let key = Utils.getUUID();//See example utils.js
      // 1. startResource
			rum.startResource({
        'key':key
      });
			var responseHeader;
			var responseBody;
			var resourceStatus;
			uni.request({
				url: requestUrl,
				method: method,
				header: header,
				success: (res) => {
					responseHeader = res.responseHeader;
					responseBody = res.data;
					resourceStatus = res.statusCode;
				},
				fail: (err) =>{
					responseBody = err.message;
				},
				complete() {
          // 2. stopResource
					rum.stopResource({
            'key':key
          })
          // 3. addResource
					rum.addResource({
						'key': key,
						'content': {
							'url': requestUrl,
							'httpMethod': method,
							'requestHeader': header,
							'responseHeader': responseHeader,
							'responseBody': responseBody,
							'resourceStatus': resourceStatus,
						}
					})
				}
			});	
```

#### API - startResource

HTTP request starts:

| Parameter Name | Parameter Type | **Required** | Parameter Description         |
| :------- | -------- | -------- | ---------------- |
| key      | string   | Yes       | Request unique identity     |
| property | object   | No       | Event context(optional) |

#### API - stopResource

HTTP request ends:

| Parameter Name | Parameter Type | **Required** | Parameter Description         |
| :------- | -------- | -------- | ---------------- |
| key      | string   | Yes       | Request unique identity     |
| property | object   | No       | Event context(optional) |

#### API - addResource

| Parameter Name | Parameter Type       | **Required** | Parameter Description     |
| :------- | -------------- | -------- | ------------ |
| key      | string         | Yes       | Request unique identity |
| content  | content object | Yes       | Request related data |

#### Content Object

| prototype      | Parameter Type | Parameter Description       |
| -------------- | -------------- | -------------- |
| url            | string | Request url       |
| httpMethod     | string | http method      |
| requestHeader  | object | Request head         |
| responseHeader | object | Response head         |
| responseBody   | string | Response result       |
| resourceStatus | string | Request result status code |

## Logger Log Printing 

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.logging({
					'content':`Log content`,
					'status':status
				})
```

#### API - logging

| Parameter Name | Parameter Type | **Required** | Parameter Description                 |
| :------- | -------- | -------- | ------------------------ |
| content  | string   | Yes       | Log property, which can be a json string |
| status   | string   | Yes       | Log level                 |
| property | object   | No       | Event context(optional)         |

### Log Level

| String   |
 -------- |
| info     |
| warning  |
| error    | 
| critical | 
| ok       | 

## Tracer Network Link Tracing

```javascript
//The example uses uni.request for network requests
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
let key = Utils.getUUID();//See example utils.js
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

Get the request header that trace needs to add, and then adds it to the request header of HTTP request.

| Parameter Name | Parameter Type | **Required** | Parameter Description     |
| :------- | -------- | -------- | ------------ |
| key      | string   | Yes       | Request unique identity |
| url      | string   | Yes       | Request URL     |

Return value type: object 

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

#### API - bindRUMUserData

Bind user information.

| Parameter Name  | Parameter Type | **Required** | Parameter Description       |
| :-------- | -------- | -------- | -------------- |
| userId    | string   | Yes       | User Id         |
| userName  | string   | No       | User name       |
| userEmail | string   | No       | User mailbox       |
| extra     | object   | No       | User extra info |

#### API - unbindRUMUserData

Unbing the current user.


## FAQ

### Plug-in Develop iOS Main Project & UniPlugin-iOS Use

#### Download UniApp & Offline Development of SDK

 According to the version number of the uni-app development tool **HBuilderX**, download the [SDK package](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) needed to develop the plug-in. 

SDK Package Structure Description

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app off-line packing engineering
	|-- HBuilder-uniPluginDemo		// uni-app plug-in development master project (the project required for this document)
	|-- SDK							// Dependent libraries and dependent resource files
```

Drag the dependent libraries and dependent resource files **SDK** folder into the UniPlugin-iOS folder. The directory structure should be as follows.

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// uni-app plug-in development master project (the project required for this document)
	|-- SDK							// Dependent libraries and dependent resource files
```

 See: [IOS plug-in development environment configuration](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#开发环境).

#### Project Configuration

1.Architectures settings

As the simulator provided by Xcode 12 supports the arm64 architecture, the framework provided by uni_app supports the real machine of arm64 and the simulator of x86_64. So:

`Excluded Architectures` sets `Any iOS Simulator SDK`: `arm64`.

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

### Plug-in Development Android Main Project UniPlugin-Android Use

#### Project Configuration
See [Demo](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example) for detailed dependency configuration.

```
|-- UniPlugin-Android
	|-- app
		|--build.gradle
		//Configure ft-plugin
		
	|-- uniplugin_module
		|-- src
			|-- main
				|-- java
					|-- com.ft.sdk.uniapp
		|-- build.gradle 
		//	Configure dependencies
		//implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:xxxx'
		//implementation 'com.google.code.gson:gson:xxxx'
		//implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:xxxx'
		
	|-- build.gradle
		//	Configure repo
		//	maven {
		//      	url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
		//	}
		//
		//	Configure buildScrpit
		//	classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:xxxx'

```

### Difference between Android Cloud Packaging and Offline Packaging {#package}

Android cloud packaging and offline packaging use two different integration logic. The offline packaging integration method is the same as Guance `Android SDK` integration method, which uses `Android Studio Gradle Plugin`. Cloud packaging cannot use `Android Studio Gradle Plugin`, so some functions can only be realized through the internal code in Guance `UniApp Native Plugin`. Therefore, the offline package version has more configuration options than the cloud package version, and the `offlinePackage` [parameter](#base-config) in the SDK configuration is designed to distinguish between the two situations.

### [About iOS](../ios/app-access.md#FAQ)

### [About Android](../android/app-access.md#FAQ)
