# 故障排查
## 编译故障排查
编译过程发生错误，需要首先检查编译环境

### 可运行编译环境 
#### ✅ 可运行环境 
* AGP `com.android.tools.build:gradle` 版本 `3.5.0` 以上
* gradle 版本 `5.4.0` 以上
* java 版本 `8.0` 以上
*  Android minSdkVersion 21

>  随着 Android Studio 版本更新，这部分版本兼容度也会发生变化，如果你有碰到编译环境符合以上条件，但是仍然遇到编译出错的问题，请联系我们的开发人员

#### ⚠️ 可兼容运行环境 
* AGP `com.android.tools.build:gradle` 版本 `3.0.1` 以上
* Gradle 版本 `4.8.1` 以上
* Java 版本 `8.0` 以上
* Android minSdkVersion 21

> 此环境 `ft-plugin` 无法使用，数据自动捕获的部分需要，手动接入完成。更多手动接入相关请参考[这里](app-access.md#manual-set)

### SDK 无法解析导入
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
发生以上错误是因为因为 maven 仓库没有正确设置，请参考这里的[配置](app-access.md##gradle-setting)


### 编译错误

* Desugaring  Error

```java
>Task :app:transformClassesWithStackFramesFixerForDebug
	Exception in thread "main" java.lang.IllegalStateException: Expected a load for Ljava/lang/String; to set up parameter 0 for com/ft/sdk/FTRUMGlobalManager$$Lambda$11 but got 95
		at com.google.common.base.Preconditions.checkState (Preconditions.java:756)
		at com.google.devtools.build. android.desugar.LambdaDesugaring$InvokedynamicRewriter .attemptAllocationBeforeArgumentLoadsLambdaDesugaring.java:535)
		at com.google.devtools.build.android.desugar.LambdaDesugaring$InvokedynamicRewriter.visitInvokeDynamicInsn
		(LambdaDesugaring.java: 420)
		at org.objectweb.asm.ClassReader.a(Unknown Source)
		at org.objectweb.asm.ClassReader.b(Unknown Source)
		at org.objectweb.asm.ClassReader.accept(Unknown Source)
		at org.objectweb.asm.ClassReader.accept(Unknown Source)
		at com.google.devtools.build. android.desugar. Desugar.desugarClassesInInput (Desugar.java:401) at com.google.devtools.build.android.desugar.Desugar.desugar0neInput(Desugar.java:326) at com.google.devtools.build.android.desugar. Desugar.desugar (Desugar.java:280) at com.google.devtools.build.android.desugar. Desugar.main (Desugar.java:584)
```
如果编译过程中出现以上错误，这个是由于 AGP`3.0.0`兼容性问题导致，这里 [issue](https://github.com/gradle/gradle/issues/2384) 说明了这个问题，可以提升 AGP`3.1.0`以上版本来解决这个问题，或者使用较新版本 SDK, 在`app/build.gradle`中升级版本即可。

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')//1.3.10 以上均可以
}
```


## SDK 初始化异常校验

查看 `Logcat`确认是否存在日志 `Level` 为 `Error` ，`Tag` 为 `[FT-SDK]` 前缀的日志 

```kotlin
14:46:04.825 [FT-SDK] com.demo E 请先安装SDK(在应用启动时调用 FTSdk.install(FTSDKConfig ftSdkConfig))
``` 

## 开启 Debug 调试
你可以通过以下配置，开启 SDK 的 debug 功能，开启之后，控制台 `LogCat` 会输出 SDK 调试日志，你可以过滤 `[FT-SDK]` 字符，定位到观测云 SDK 日志。

```kotlin
  val config = FTSDKConfig.setDebug(true);
  FTSdk.install(config)
```
>**建议 Release 版本发布时，关闭这个配置**

## SDK 正常运行但是没有数据
* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行

* 确认 SDK 上传地址`metricsUrl`[配置正确](app-access.md#base-setting)，并正确初始化。debug 模式下，可以下列日志来判断上传地址配置问题。

	```java
	//检查上传地址是否正确进入 SDK 配置
	11:15:38.137 [FT-SDK]FTHttpConfigManager com.demo D serverUrl:http://10.0.0.1:9529
	
	//以下是连接错误日志
	10:51:48.879 [FT-SDK]OkHttpEngine  com.demo E failed to connect to /10.0.0.1.166 (port 9529) from /10.0.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常
    10:51:48.880 [FT-SDK]SyncTaskManager com.demo E 同步数据失败-[code:2,response:failed to connect to /10.0.0.1 (port 9529) from /10.100.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常]
	
	//以下是正常同步日志
	10:51:48.996 [FT-SDK]NetProxy com.demo D HTTP-response:[code:200,response:]
    10:51:48.996 [FT-SDK]SyncTaskManager com.demo D **********************同步数据成功**********************
	
	```
* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

	![](../img/17.trouble_shooting_android_datakit_check.png)

## 数据丢失
### 丢失部份数据
* 如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据时，首先需要排除是否在 [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config) 设置了 `sampleRate <  1` 
* 排查上传数据设备网络与安装 datakit 设备网路与负载问题
* 确认正确调用 `FTSdk.shutDown `，这个方法会释放 SDK 数据处理对象，包括缓存的数据。

## 数据丢失某个字段信息
### 用户数据字段
* 确认正确调用[用户数据绑定方法](app-access.md#userdata-bind-and-unbind)。deubg 模式下，可以通过 log 来追踪这个问题。
	
	```java
	13:41:00.749 [FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> 你的数据操作 <-----
	
	13:41:10.749 [FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### 丢失自定义参数或数值发生错误
* 确认在正确的场景下调用，`FTRUMConfig.addGlobalContext`，`FTLoggerConfig.addGlobalContext `适合一个应用周期内不更变的场景，例如应用渠道商、应用不同 Flavor 属性等数据，如果需要根据动态场景，实时响应，需要使用手动调用 [RUM](app-access.md#rum-trace) 和 [Log](app-access.md#log)  接口。
* deubg 模式下，查看 `[FT-SDK]SyncTaskManager` 日志，可以通过这个日志，来验证自定义字段参数的正确性


## 日志开启 enableConsoleLog 发生卡顿问题
如果发生有可能原因是日志采集的数据过大。`FTLoggerConfig.enableConsoleLog`原理是抓取编译 `android.util.Log`，Java 与 Kotlin`println`，建议按需调整`FTLoggerConfig`[配置](app-access.md#log-config)下`sampleRate`,`logPrefix`,`logLevelFilters`参数来消除或缓解这个问题




