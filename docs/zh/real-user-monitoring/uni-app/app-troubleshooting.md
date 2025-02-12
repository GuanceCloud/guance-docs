# 故障排查

## SDK 初始化异常校验

**编译运行平台为 Android 时：**

查看 `Logcat`确认是否存在日志 `Level` 为 `Error` ，`Tag` 为 `[FT-SDK]` 前缀的日志

```kotlin
14:46:04.825 [FT-SDK] com.demo E 请先安装SDK(在应用启动时调用FTSdk.install(FTSDKConfig ftSdkConfig))
```

**编译运行平台为 iOS 时：**

SDK 内部会使用**断言**检查多项配置的正确性，在配置错误时程序会崩溃并输出相关警告，但是默认情况下只在 Debug 环境生效，建议[使用离线打包工程制作自定义调试基座](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/ios.html#如何用离线打包工程制作自定义调试基座)，并设置 Release 环境时同样生效。

点击 `project` -> `target` -> `Build Settings` ，搜索框搜索 `ENABLE_NS_ASSERTIONS` ，将 Release 对应修改为 Yes。

![uniapp_ios_assert](../img/uniapp_ios_assert.png)

>**建议只在调试基座中配置**，正常的打包发行时使用默认配置。

如果没有进行上述配置，也可以 [开启 Debug 调试](#debug-mode) ，查看 「控制台」 中的调试日志，根据日志内容判断 SDK 是否初始化成功。

## 开启 Debug 调试 {#debug-mode}

您可以通过以下配置，开启 SDK 的 debug 功能。

```vue
	var ftMobileSDK = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  ftMobileSDK.sdkConfig({
				'serverUrl': SDKConst.SERVER_URL,
				'debug': true,
			});
```

> **建议版本发布时，关闭这个配置**

**编译运行平台为 Android 时：**

查看 `Logcat` `Tag` 为 `[FT-SDK]` 前缀的日志

**编译运行平台为 iOS 时：**

在 mac 上的 「控制台」中查看 SDK 调试日志。

「控制台」使用：

选中 `操作` 勾选 `包括简介信息`、`包括调试信息`。

选中调试的设备，点击`开始`按钮，在右侧的搜索条件框内输入搜索条件 **[FTLog]** 。此时便可以查看 SDK 的调试日志了。

![console_app_use](../img/console_app_use.png)

> [Android Logcat](../android/app-troubleshooting.md#log_sample) 和 [iOS Xcode Console](../ios/app-troubleshooting.md#log_sample) 日志示例

## SDK 正常运行但是没有数据

* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行

* 确认 SDK 上传地址 `serverUrl` [配置正确](app-access.md#base-setting)，并正确初始化。[debug 模式](#debug-mode)下, 查看 [Android Logcat](../android/app-troubleshooting.md#data_sync) 或 [iOS Xcode Console](../ios/app-troubleshooting.md#data_sync) 的同步日志。


* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

	![](../img/17.trouble_shooting_android_datakit_check.png)

## 数据丢失

### 丢失部份数据

* 如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据时，首先需要排除是否在 [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config) 设置了 `samplerate <  1` ；

* 采集到 RUM 数据不全，没有 Resource 或 Action 数据？

    Resource 和 Action 数据是与 View 进行绑定的，需要确保有  [- startView](app-access.md#startview) 操作，可参考 [RUM-View](app-access.md#rumview) 文档来实现 View 事件采集。 

* 排查上传数据设备网络与安装 datakit 设备网路与负载问题。

## 更多相关内容
* [Android 故障排查](../android/app-troubleshooting.md)
* [iOS 故障排查](../ios/app-troubleshooting.md)

