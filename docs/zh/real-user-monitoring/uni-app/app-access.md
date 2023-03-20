# UniApp 应用接入
---

## 前置条件

- 安装 DataKit（[DataKit 安装文档](../../datakit/datakit-install.md)）

## 应用接入
当前 UniApp 版本支持 Android 和 iOS 平台。登录观测云控制台，进入「应用监测」页面，点击右上角「新建应用」，在新窗口输入「应用名称」，点击「创建」，然后相应接入的平台，即可开始配置。

![](../img/image_12.png)

![](../img/image_13.png)

## 安装

### 本地使用 {#local-plugin}

**源码地址**：[https://github.com/GuanceCloud/datakit-uniapp-native-plugin](https://github.com/GuanceCloud/datakit-uniapp-native-plugin)

**Demo 地址**：[https://github.com/GuanceCloud/datakit-uniapp-native-plugin/Hbuilder_Example](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example)


下载的 SDK 包结构说明

```text
|--datakit-uniapp-native-plugin
	|-- Hbuilder_Example				// GCUniPlugin 插件的示例工程
	    |-- nativeplugins          // 示例工程的本地插件文件夹
	        |-- GCUniPlugin           // ⭐️ GCUniPlugin 原生插件包 ⭐️
	            |-- android              // 存放 android 插件所需要的依赖库及资源文件
	            |-- ios                  // 存放 ios 插件所需要的依赖库及资源文件
	            |-- package.json         // 插件配置文件
	|-- UniPlugin-Android		    // 插件开发 Android 主工程 
	|-- UniPlugin-iOS					  // 插件开发 iOS 主工程 
```

将 **GCUniPlugin** 文件夹配置到您的 uni_app 项目的 “nativeplugins” 下，还需要在 manifest.json 文件的 “App原生插件配置” 项下点击“选择本地插件”，在列表中选择 GCUniPlugin 插件：

![img](../img/15.uniapp_intergration.png)

>注意：保存后，需要提交云端打包，（制作 **自定义基座** 也属于云端打包）后插件才会生效

参考：[HBuilderX中使用本地插件](https://nativesupport.dcloud.net.cn/NativePlugin/use/use_local_plugin.html#)、[自定义基座](https://uniapp.dcloud.net.cn/tutorial/run/run-app.html#customplayground)

### 市场插件方式
（未提供）

## SDK 初始化

### 基础配置 {#base-config}

```javascript
// 在 App.vue 配置
<script>
    var guanceModule = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
    export default {
        onLaunch: function() {
            console.log('App Launch')
            guanceModule.sdkConfig({
                'serverUrl': 'your severurl',
                'debug': true,
                'envType': 'common',
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

| 参数名称      | 参数类型 | 必须 | 参数说明                                                     |
| :------------ | :------- | :--- | ------------------------------------------------------------ |
| serverUrl     | string   | 是   | datakit 安装地址 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529。注意：安装 SDK 设备需能访问这地址                                               |
| debug         | boolean  | 否   | 设置是否允许打印 Debug 日志，默认`false`                            |
| datakitUUID   | string   | 否   | 请求`HTTP`请求头`X-Datakit-UUID` 数据采集端，如果用户不设置会自动配置 |
| envType       | string   | 否   | 环境字段： `prod`线上（默认）、`gray`灰度、`pre`预发、`common`日常、`local`本地 |
| service       | string   | 否   | 设置所属业务或服务的名称 默认：`df_rum_ios`、`df_rum_android` |
| globalContext | object   | 否   | 添加自定义标签                                               |
| offlinePakcage | boolean   | 否   | 仅 Android 支持，是否使用离线打包，默认为 `false`，详细说明见[Android 云打包与离线打包区别](#package)       |

### RUM 配置{#rum-config}

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
rum.setConfig({
        'androidAppId':'YOUR_ANDROID_APP_ID',
				'iOSAppId':'YOUR_IOS_APP_ID',
				'errorMonitorType':'all', // or 'errorMonitorType':['battery','memory']
				'deviceMonitorType':['cpu','memory']// or  'deviceMonitorType':'all'
			})
```

| 参数名称                 | 参数类型     | **必须** | **说明**                                                     |
| ------------------------ | ------------ | :------- | ------------------------------------------------------------ |
| androidAppId             | string       | 是       | appId，监测中申请                                            |
| iOSAppId                 | string       | 是       | appId，监测中申请                                            |
| samplerate               | number       | 否       | 采样率，（采集率的值范围为>= 0、<= 1，默认值为 1）           |
| enableNativeUserAction   | boolean      | 否       | 是否进行 `Native Action` 追踪，`Button` 点击事件，纯 `uni-app` 应用建议关闭，默认为 `false`，Android 云打包不支持 |
| enableNativeUserResource | boolean      | 否       | 是否进行 `Native Resource` 自动追踪，纯 `uni-app` 应用建议关闭，默认为 `false` ，Android 云打包不支持|
| enableNativeUserView     | boolean      | 否       | 是否进行 `Native View` 自动追踪，纯 `uni-app` 应用建议关闭，，默认为 `false` |
| errorMonitorType         | string/array | 否       | 错误监控补充类型：`all`、`battery`、 `memory`、 `cpu`        |
| deviceMonitorType        | string/array | 否       | 页面监控补充类型： `all` 、`battery`（仅Android支持)、 `memory`、`cpu`、`fps` |
| detectFrequency          | string       | 否       | 页面监控频率：`normal`(默认)、 `frequent`、`rare`            |
| globalContext            | object       | 否       | 自定义全局参数，特殊 key :`track_id`  (用于追踪功能)         |

### Log 配置{#log-config}

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.setConfig({
  'enableLinkRumData':true,
  'enableCustomLog':true,
  'discardStrategy':'discardOldest'
})
```

| 参数名称          | 参数类型      | 必须 | 参数说明                                                     |
| :---------------- | :------------ | :--- | :----------------------------------------------------------- |
| samplerate        | number        | 否   | 采样率                                                       |
| enableLinkRumData | boolean       | 否   | 是否与 RUM 关联                                              |
| enableCustomLog   | boolean       | 否   | 是否开启自定义日志                                           |
| discardStrategy   | string        | 否   | 日志丢弃策略：`discard`丢弃新数据（默认）、`discardOldest`丢弃旧数据 |
| logLevelFilters   | array<string> | 否   | 日志等级过滤，数组中需填写 **日志等级**：`info`提示、`warning`警告、`error`错误、`critical`、`ok`恢复 |
| globalContext     | object        | 否   | 自定义全局参数                                               |

### Trace 配置{#trace-config}

```javascript
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
tracer.setConfig({
				'traceType': 'ddTrace'
			})
```

| 参数名称              | 参数类型 | **必须** | 参数说明                                                     |
| --------------------- | -------- | -------- | ------------------------------------------------------------ |
| samplerate            | double   | 否       | 采样率，采集率的值范围为>= 0、<= 1，默认值为 1               |
| traceType             | string   | 否       | 链路类型：`ddTrace`（默认）、`zipkinMultiHeader`、`zipkinSingleHeader`、`traceparent`、`skywalking`、`jaeger` |
| enableLinkRUMData     | boolean  | 否       | 是否与 `RUM` 数据关联，默认`false`                           |
| enableNativeAutoTrace | boolean  | 否       | 是否开启原生网络自动追踪 iOS `NSURLSession` ,Android `OKhttp`，默认`false`, 纯 `uni-app` 应用建议关闭, Android 云打包不支持 |

## RUM 用户数据追踪

```javascript
var rum = uni.requireNativePlugin("GCUniPlugin-RUM");
```

### Action

#### API - startAction

添加 Action 事件

```javascript
rum.startAction({
					'actionName': 'action name',
					'actionType': 'action type'
				})
```

| 参数名称   | 参数类型 | **必须** | 参数说明         |
| ---------- | -------- | -------- | ---------------- |
| actionName | string   | 是       | 事件名称         |
| actionType | string   | 是       | 事件类型         |
| property   | object   | 否       | 事件上下文(可选) |

### View{#rumview}

* 自动采集

```javascript
// 自动采集，可参考 SDK 包内 GCUniPlugin 插件的示例工程
// step 1. 在 SDK 包内找到 GCWatchRouter.js、GCPageMixin.js 文件，添加到你的工程
// step 2. 在 App.vue 添加 Router 监控，如下：
<script>
	import WatchRouter from '@/GCWatchRouter.js'
	export default {
    mixins:[WatchRouter],
	}
</script>
// step 3. 在应用显示的第一个 page 页面添加 pageMixin 如下
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

* 手动采集

```dart
// 手动采集 View 的生命周期
// step 1（可选）
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

创建页面时长记录

| 参数名称 | 参数类型 | **必须** | 参数说明                     |
| -------- | -------- | -------- | ---------------------------- |
| viewName | string   | 是       | 页面名称                     |
| loadTime | number   | 是       | 页面加载时间(纳秒级别时间戳) |

#### API - startView {#startview}

进入页面

| 参数名称 | 参数类型 | **必须** | 参数说明         |
| -------- | -------- | -------- | ---------------- |
| viewName | string   | 是       | 页面名称         |
| property | object   | 否       | 事件上下文(可选) |

#### API - stopView

离开页面

| 参数名称 | 参数类型 | **必须** | 参数说明         |
| -------- | -------- | -------- | ---------------- |
| property | object   | 否       | 事件上下文(可选) |

### Error

* 自动采集

```javascript
/// 使用 uniapp 错误监听函数 发生脚本错误或 API 调用报错时触发
<script>
  var rum = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
	// 只能在App.vue里监听
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
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
				})
			}else if(err instanceof String){
				console.log('Error:', err);
				rum.addError({
					'message': err,
					'stack': err,
				})
			}
	}
</script>
```

* 手动采集

```javascript
// 手动添加
rum.addError({
					'message': 'Error message',
					'stack': 'Error stack',
				})
```
#### API - addError

添加 Error 事件

| 参数名称 | 参数类型 | **必须** | 参数说明         |
| :------- | -------- | -------- | ---------------- |
| message  | string   | 是       | 错误信息         |
| stack    | string   | 是       | 堆栈信息         |
| property | object   | 否       | 事件上下文(可选) |

### Resource

```javascript
//示例使用 uni.request 进行网络请求，
      let key = Utils.getUUID();//可参考 example utils.js
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

HTTP 请求开始

| 参数名称 | 参数类型 | **必须** | 参数说明         |
| :------- | -------- | -------- | ---------------- |
| key      | string   | 是       | 请求唯一标识     |
| property | object   | 否       | 事件上下文(可选) |

#### API - stopResource

HTTP 请求结束

| 参数名称 | 参数类型 | **必须** | 参数说明         |
| :------- | -------- | -------- | ---------------- |
| key      | string   | 是       | 请求唯一标识     |
| property | object   | 否       | 事件上下文(可选) |

#### API - addResource

| 参数名称 | 参数类型       | **必须** | 参数说明     |
| :------- | -------------- | -------- | ------------ |
| key      | string         | 是       | 请求唯一标识 |
| content  | content object | 是       | 请求相关数据 |

#### content object

| prototype      | 参数说明       |
| -------------- | -------------- |
| url            | 请求 url       |
| httpMethod     | http 方法      |
| requestHeader  | 请求头         |
| responseHeader | 响应头         |
| responseBody   | 响应结果       |
| resourceStatus | 请求结果状态码 |

## Logger 日志打印 

```javascript
var logger = uni.requireNativePlugin("GCUniPlugin-Logger");
logger.logging({
					'content':`Log content`,
					'status':status
				})
```

#### API - logging

| 参数名称 | 参数类型 | **必须** | 参数说明                 |
| :------- | -------- | -------- | ------------------------ |
| content  | string   | 是       | 日志内容，可为json字符串 |
| status   | string   | 是       | 日志等级                 |
| property | object   | 否       | 事件上下文(可选)         |

### 日志等级

| 字符串   | **含义** |
| -------- | -------- |
| info     | 提示     |
| warning  | 警告     |
| error    | 错误     |
| critical | 严重     |
| ok       | 恢复     |

## Tracer 网络链路追踪

```javascript
//示例使用 uni.request 进行网络请求
var tracer = uni.requireNativePlugin("GCUniPlugin-Tracer");
let key = Utils.getUUID();//可参考 example utils.js
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

获取 trace 需要添加的请求头，获取后添加到 HTTP 请求的请求头中。

| 参数名称 | 参数类型 | **必须** | 参数说明     |
| :------- | -------- | -------- | ------------ |
| key      | string   | 是       | 请求唯一标识 |
| url      | string   | 是       | 请求 URL     |

返回值类型： object 

## 用户信息绑定与解绑

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

绑定用户信息

| 参数名称  | 参数类型 | **必须** | 参数说明       |
| :-------- | -------- | -------- | -------------- |
| userId    | string   | 是       | 用户Id         |
| userName  | string   | 否       | 用户名称       |
| userEmail | string   | 否       | 用户邮箱       |
| extra     | object   | 否       | 用户的额外信息 |

#### API - unbindRUMUserData

解绑当前用户


## 常见问题

### 插件开发 iOS 主工程 UniPlugin-iOS 使用

#### 下载 UniApp 离线开发 SDK

 根据 uni-app 开发工具 **HBuilderX** 的版本号，下载开发插件需要的 [SDK包](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) 

SDK 包结构说明

```text
|--iOSSDK	
	|-- HBuilder-Hello				// uni-app 离线打包工程
	|-- HBuilder-uniPluginDemo		// uni-app 插件开发主工程 （本文档需要使用的工程）
	|-- SDK							// 依赖库及依赖资源文件
```

将依赖库及依赖资源文件 **SDK** 文件夹拖到 UniPlugin-iOS 文件夹内，拖拽后目录结构应如下。

```
|-- UniPlugin-iOS
	|-- HBuilder-uniPluginDemo		// uni-app 插件开发主工程 （本文档需要使用的工程）
	|-- SDK							// 依赖库及依赖资源文件
```

 参考：[iOS插件开发环境配置](https://nativesupport.dcloud.net.cn/NativePlugin/course/ios.html#开发环境)

#### 工程配置

1. Architectures 设置

   因为 Xcode 12 提供的模拟器支持 arm64 架构，uni_app 提供的 framework 支持的是 arm64 的真机，x86_64 的模拟器。所以

   *  `Excluded Architectures` 设置 `Any iOS Simulator SDK` : `arm64`。

   * `Pods` 工程里所有 Target 设置 `Build Active Architecture only` 设置为 NO。

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

### 插件开发 Android 主工程 UniPlugin-Android 使用
#### 工程配置
详细依赖配置参见 [Demo](https://github.com/GuanceCloud/datakit-uniapp-native-plugin/tree/develop/Hbuilder_Example)

```
|-- UniPlugin-Android
	|-- app
		|--build.gradle
		//配置 ft-plugin
		
	|-- uniplugin_module
		|-- src
			|-- main
				|-- java
					|-- com.ft.sdk.uniapp
		|-- build.gradle 
		//	配置依赖 dependencies
		//implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:xxxx'
		//implementation 'com.google.code.gson:gson:xxxx'
		//implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:xxxx'
		
	|-- build.gradle
		//	配置 repo
		//	maven {
		//      	url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
		//	}
		//
		//	配置 buildScrpit
		//	classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:xxxx'

```

### Android 云打包与离线打包区别 {#package}
Android 云打包与离线打包使用了两种不同的集成逻辑。离线打包集成方式与观测云 `Android SDK` 集成方式相同，使用是 `Android Studio Gradle Plugin` 的方式，云打包无法使用 `Android Studio Gradle Plugin` ，所以只能通过观测云 `UniApp Native Plugin` 中内部代码实现部分功能。所以离线打包版本配置可选项要比云打包版本更多，SDK 配置中 `offlinePakcage`[参数](#base-config)就是为了区分两种情况。

### [iOS 相关](../ios/app-access.md#FAQ)

### [Android 相关](../android/app-access.md#FAQ)
