# 故障排查

## SDK 初始化异常校验

**编译运行平台为 Android 时：**

查看 `Logcat`确认是否存在日志 `Level` 为 `Error` ，`Tag` 为 `[FT-SDK]*` 前缀的日志 

```kotlin
14:46:04.825 [FT-SDK]  com.ft   E  请先安装SDK(在应用启动时调用FTSdk.install(FTSDKConfig ftSdkConfig))
```

**编译运行平台为 iOS 时：**

在 Debug 环境，当您配置观测云 SDK 并首次运行该应用程序后，请在 Xcode 中检查您的调试器控制台，SDK 会使用断言检查多项配置的正确性并在配置错误时崩溃并输出相关警告。

eg：当配置 SDK 时，未设置  datakit metrics 写入地址，程序会崩溃，并在控制台输出警告⚠️。

```objective-c
*** Assertion failure in +[FTMobileAgent startWithConfigOptions:], FTMobileAgent.m:53
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '请设置 datakit metrics 写入地址'
```

## 开启 Debug 调试{#debug-mode}

你可以通过以下配置，开启 SDK 的 debug 功能。

```tsx
 let config: FTMobileConfig = {
    serverUrl: Config.SERVER_URL,
    debug: true
    };
 FTMobileReactNative.sdkConfig(config);
```

>**建议Relase 版本发布时，关闭这个配置**

**编译运行平台为 Android 时：**



**编译运行平台为 iOS 时：**

SDK 的调试日志是以  **[FTLog]** 作为前缀标识。

* 使用 xcode 运行，可以直接在 xcode 调试控制台查看 SDK 的调试日志。‘

* 使用终端命令运行 `yarn ios` 或者 `yarn react-native run-ios` 时，可以在 mac 上的 console.app 中查看 SDK 调试日志。

  console.app 使用：

  选中 `操作` 勾选 `包括简介信息`、`包括调试信息`。

  选中调试的设备，点击`开始`按钮，在右侧的搜索条件框内输入搜索条件 **[FTLog]** 。此时便可以查看 SDK 的调试日志了。

  ![console_app_use](../img/console_app_use.png)

## SDK 正常运行但是没有数据

* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行

* 确认 SDK 上传地址 `metricsUrl` [配置正确](app-access.md#base-setting)，并正确初始化。debug 模式下，可以下列日志来判断上传地址配置问题。

	**编译运行平台为 Android 时：**
	
	```java
	//检查上传地址是否正确进入 SDK 配置
	11:15:38.137 [FT-SDK]FTHttpConfigManager com.demo D serverUrl:http://10.0.0.1:9529
	
	//以下是连接错误日志
	10:51:48.879 [FT-SDK]OkHttpEngine  com.demo E failed to connect to /10.0.0.1.166 (port 9529) from /10.0.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常
	10:51:48.880 [FT-SDK]SyncTaskManager your.pack E 同步数据失败-[code:2,response:failed to connect to /10.0.0.1 (port 9529) from /10.100.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常]
	
	//以下是正常同步日志
	10:51:48.996 [FT-SDK]NetProxy com.demo D HTTP-response:[code:200,response:]
	10:51:48.996 [FT-SDK]SyncTaskManager your.pack  D  **********************同步数据成功**********************
	
	```
	
	**编译运行平台为 iOS 时：**
	
	```objective-c
	//以下是正常同步日志
	 [FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:] [line 143] 开始上报事件(本次上报事件数:2)
	  [FTLog][INFO] -[FTRequestLineBody getRequestBodyWithEventArray:] [line 149]  
	  Upload Datas Type:RUM
	  Line RequestDatas:
	  ...... datas ......
	  [FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:]_block_invoke [line 157] Upload Response statusCode : 200 
	```
	
	  在 1.3.10 版本之前并不会打印 `Upload Response statusCode : 200 ` ，可以查看控制台是否有错误日志，没有错误日志即上传成功。
	
	  错误日志:  `Network failure: ......` 或 `服务器异常 稍后再试 ...... `
	
* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

	![](../img/17.trouble_shooting_android_datakit_check.png)

## 数据丢失

### 丢失部份数据

* 如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据时，首先需要排除是否设置了在 [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config) 是否设置 `sampleRate <  1` ；

* 采集到 RUM 数据不全，没有 Resource 或 Action 数据？

  Resource 和 Action 数据是与 View 进行绑定的，需要确保有 `FTReactNativeRUM.startView` 操作，可参考 [RUM-View](app-access.md#rumview) 文档来实现 View 事件采集。 

* 排查上传数据设备网络与安装 datakit 设备网路与负载问题。











