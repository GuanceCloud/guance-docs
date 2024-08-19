# 故障排查

## SDK 初始化异常校验

**编译运行平台为 Android 时：**

查看 `Logcat`确认是否存在日志 `Level` 为 `Error` ，`Tag` 为 `[FT-SDK]` 前缀的日志

```kotlin
14:46:04.825 [FT-SDK] com.demo E 请先安装SDK(在应用启动时调用FTSdk.install(FTSDKConfig ftSdkConfig))
```

**编译运行平台为 iOS 时：**

在 Debug 环境，当您配置观测云 SDK 并首次运行该应用程序后，请在 Xcode 中检查您的调试器控制台，SDK 会使用断言检查多项配置的正确性并在配置错误时崩溃并输出相关警告。

eg：当配置 SDK 时，未设置  datakit metrics 写入地址，程序会崩溃，并在控制台输出警告⚠️。

```objective-c
*** Assertion failure in +[FTMobileAgent startWithConfigOptions:], FTMobileAgent.m:53
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '请设置 datakit metrics 写入地址'
```

## 开启 Debug 调试 {#debug-mode}

您可以通过以下配置，开启 SDK 的 debug 功能。

```tsx
 let config: FTMobileConfig = {
    serverUrl: Config.SERVER_URL,
    debug: true
 };
 FTMobileReactNative.sdkConfig(config);
```

>**建议Release 版本发布时，关闭这个配置**

**编译运行平台为 Android 时：**
查看 `Logcat` `Tag` 为 `[FT-SDK]` 前缀的日志

**编译运行平台为 iOS 时：**

SDK 的调试日志是以  **[FTLog]** 作为前缀标识。

* 使用 xcode 运行，可以直接在 xcode 调试控制台查看 SDK 的调试日志。

* 使用终端命令运行 `yarn ios` 或者 `yarn react-native run-ios` 时，可以在 mac 上的「控制台」中查看 SDK 调试日志。

「控制台」使用：

  选中 `操作` 勾选 `包括简介信息`、`包括调试信息`。

  选中调试的设备，点击`开始`按钮，在右侧的搜索条件框内输入搜索条件 **[FTLog]** 。此时便可以查看 SDK 的调试日志了。

  ![console_app_use](../img/console_app_use.png)

> [Android Logcat](../android/app-troubleshooting.md#log_sample) 和 [iOS Xcode Console](../ios/app-troubleshooting.md#log_sample) 日志示例

## SDK 正常运行但是没有数据

* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行

* 确认 SDK 上传地址`datakitUrl` 或 `datawayUrl`[配置正确](app-access.md#base-setting)，并正确初始化。[debug 模式](#debug-mode)下, 查看 [Android Logcat](../android/app-troubleshooting.md#data_sync) 或 [iOS Xcode Console](../ios/app-troubleshooting.md#data_sync) 的同步日志。
	
* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

	![](../img/17.trouble_shooting_android_datakit_check.png)

## 数据丢失

### 丢失部份数据

* 如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据时，首先需要排除是否在 [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config) 设置了 `sampleRate <  1` ；

* 采集到 RUM 数据不全，没有 Resource 或 Action 数据？

    Resource 和 Action 数据是与 View 进行绑定的，需要确保有 `FTReactNativeRUM.startView` 操作，可参考 [RUM-View](app-access.md#rumview) 文档来实现 View 事件采集。 

* 排查上传数据设备网络与安装 datakit 设备网路与负载问题。


## 兼容问题
### react-native-navigation 运行兼容问题
####  ReactTextShadowNode.UNSET 找不到符号 
这是由于 react-native-navigation 版本兼容问题导致，相关 issue [查看这里](https://github.com/wix/react-native-navigation/issues/7881#issuecomment-2164213896)。通过更改或[下载](https://static.guance.com/ft-sdk-package/react_nagation_fix/ReactTypefaceUtils.java)替换 `ReactTypefaceUtils.java` 来修正这个问题。


## 更多相关内容
* [Android 故障排查](../android/app-troubleshooting.md)
* [iOS 故障排查](../ios/app-troubleshooting.md)