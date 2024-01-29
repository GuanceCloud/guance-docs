# 故障排查

## 编译故障排查

编译过程发生错误，需要首先检查编译环境。

### 可运行编译环境 
#### ✅ 可运行环境 {#runnable}

* AGP `com.android.tools.build:gradle` 版本 `3.5.0` 以上
* gradle 版本 `5.4.0` 以上
* java 版本 `8.0` 以上
* Android minSdkVersion 21

**注意**：随着 Android Studio 版本更新，这部分版本兼容度也会发生变化，如果您有碰到编译环境符合以上条件，但是仍然遇到编译出错的问题，请联系我们的开发人员。
 
#### ⚠️ 可兼容运行环境 {#compatible}
* AGP `com.android.tools.build:gradle` 版本 `3.0.1` 以上
* Gradle 版本 `4.8.1` 以上
* Java 版本 `8.0` 以上
* Android minSdkVersion 21

> 此环境 `ft-plugin` 无法使用，数据自动捕获的部分需要，手动接入完成。更多手动接入相关，可参考 [这里](app-access.md#manual-set)。

### SDK 无法解析导入
![](../img/17.trouble_shooting_android_gradle_error_1.png)
![](../img/17.trouble_shooting_android_gradle_error_2.png)
发生以上错误是因为因为 maven 仓库没有正确设置，请参考这里的[配置](app-access.md#gradle-setting)。


### 编译错误

#### Desugaring Error

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
如果编译过程中出现以上错误，这个是由于 AGP `3.0.0` 兼容性问题导致，这里 [issue](https://github.com/gradle/gradle/issues/2384) 说明了这个问题，可以提升 AGP `3.1.0` 以上版本来解决这个问题，或者使用较新版本 SDK, 在`app/build.gradle`中升级版本即可。

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')//1.3.10 以上均可以
}

```

####  API 'android.registerTransform' is obsolete {#transform_deprecated}

`AGP 7.0` 中 `Transform` 已标记为 `Deprecated`，并在 `AGP 8.0` 中已弃用。 `ft-plugin:1.2.0` 已经完成适配，请升级相应版本，修复这个错误。 具体说明请见[集成配置](app-access.md#gradle-setting) 

####  AndroidComponentsExtension ClassNotFoundException {#android_cts_ext_no_fd}

`AndroidComponentsExtension` 是 AGP `7.4.2` 支持的方法，低于这个版本的编译环境，就会产生这个错误，可以使用 `ft-plugin-legacy` 版本，修复这个错误。具体说明请见[集成配置](app-access.md#gradle-setting) 

![](../img/17.trouble_shooting_android_gradle_error_3.png)

#### java.lang.IllegalArgumentException:  {#android_illegal_argument_exception}

* Invalid opcode 169

如果在使用 `ft_plugin_legacy` 发生了这个错误，这个是 `asm-commons:7.0` 版本的 bug，原始 issue 在[这里](https://gitlab.ow2.org/asm/asm/-/issues/317873),  通过在 plugin 配置中依赖 `org.ow2.asm:asm-commons:7.2` 以上的版本，解决这个问题。通过 ` ./gradlew buildEnvironment` 可以确认真实 `asm-commons` 使用版本。

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
        // 添加依赖
        classpath 'org.ow2.asm:asm-commons:7.2' 
    }
}
```

* org.ow2.asm:asm 版本低于 7.0

目前 plugin 版本仅支持使用  `org.ow2.asm:asm7.x` 以上版本的 build 环境，通过 ` ./gradlew buildEnvironment` 可以查询 build 环境，来确认这个问题。这个问题可以通过强行依赖 7.x 以上的版本来修复这个问题，建议使用 7.2 以上的版本。

```groovy
buildscript {
	dependencies {
        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[version]'
         // 添加依赖
        classpath 'org.ow2.asm:asm:7.2'
        classpath 'org.ow2.asm:asm-commons:7.2'
    }
}
```


## SDK 初始化异常校验

查看 `Logcat`确认是否存在日志 `Level` 为 `Error` ，`Tag` 为 `[FT-SDK]` 前缀的日志 

```kotlin
[FT-SDK] com.demo E 请先安装SDK(在应用启动时调用 FTSdk.install(FTSDKConfig ftSdkConfig))
``` 

## 开启 Debug 调试
您可以通过以下配置，开启 SDK 的 debug 功能，开启之后，控制台 `LogCat` 会输出 SDK 调试日志，您可以过滤 `[FT-SDK]` 字符，定位到观测云 SDK 日志。

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
	[FT-SDK]FTHttpConfigManager com.demo D serverUrl ==>
                                    	Datakit Url:http://10.0.0.1:9529
	//以下是连接错误日志
	[FT-SDK]SyncTaskManager com.demo   E  Network not available Stop poll
   
    [FT-SDK]SyncTaskManager com.demo   E 1:Sync Fail-[code:10003,response:failed to connect to /10.0.0.1 (port 9529) from /10.0.2.16 (port 47968) after 10000ms,检查本地网络连接是否正常]
	
	//以下是正常同步日志
	[FT-SDK]SyncTaskManager com.demo   D  Sync Success-[code:200,response:]
    [FT-SDK]SyncTaskManager com.demo   D  <<<******************* Sync Poll Finish *******************
	
	```
	
* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

	![](../img/17.trouble_shooting_android_datakit_check.png)
	
## 数据丢失
### 丢失部份数据
* 如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据时，首先需要排除是否在 [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config) 设置了 `sampleRate <  1` 
* 排查上传数据设备网络与安装 datakit 设备网路与负载问题
* 确认正确调用 `FTSdk.shutDown `，这个方法会释放 SDK 数据处理对象，包括缓存的数据。

### Resource 数据丢失 {#resource_missing}
#### OkHttpClient.build() 在 SDK 初始化之前
Plugin AOP ASM 写入是在 `OkHttpClient.build()` 调用时自动写入 `FTTraceInterceptor` ,`FTResourceInterceptor`,`FTResourceEventListener.FTFactory`，如果在 SDK 初始化之前，会导致加载空配置，因而丢失 Resource 相关数据。

#### 使用 Interceptor 或 EventListener 对数据进行了二次处理 
Plugin AOP ASM 插入之后，会在原工程代码基础上，会在 `OkHttpClient.Builder()` 加入 `addInterceptor`，分别加入 `FTTraceInterceptor` 和 `FTResourceInterceptor`,其中会使用 http 请求中 body contentLength 参与唯一 id 计算，`Resource` 数据各个阶段数据通过这个 id 进行上下文串联，所以如果集成方在使用 `Okhttp` 时，也加入 `addInterceptor` 并对数据进行二次处理使其发生大小改变，从而导致 id 各阶段计算不一致，导致数据丢失。

**处理方式：**

* **ft-sdk < 1.4.1**

	通过 [自定义](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72) `addInterceptor` 位置顺序，让 SDK 方法第一时间去计算 id，可以解决这个问题。为了避免重复设置，自定义方式需要关闭 `FTRUMConfig`的`enableTraceUserResource` ，`FTTraceConfig`的 `enableAutoTrace` 配置。

* **ft-sdk >= 1.4.1** 

	SDK 自行适配兼容这个问题

## 数据丢失某个字段信息
### 用户数据字段
* 确认正确调用[用户数据绑定方法](app-access.md#userdata-bind-and-unbind)。deubg 模式下，可以通过 log 来追踪这个问题。
	
	```java
	[FT-SDK]FTRUMConfigManager com.demo D  bindUserData xxxx
	
	///---> 您的数据操作 <-----
	
	[FT-SDK]FTRUMConfigManager com.demo D unbindUserData
	```
	
### 丢失自定义参数或数值发生错误
* 确认在正确的场景下调用，`FTRUMConfig.addGlobalContext`，`FTLoggerConfig.addGlobalContext `适合一个应用周期内不更变的场景，例如应用渠道商、应用不同 Flavor 属性等数据，如果需要根据动态场景，实时响应，需要使用手动调用 [RUM](app-access.md#rum-trace) 和 [Log](app-access.md#log)  接口。
* deubg 模式下，查看 `[FT-SDK]SyncTaskManager` 日志，可以通过这个日志，来验证自定义字段参数的正确性

## 日志开启 enableConsoleLog 发生卡顿问题
如果发生有可能原因是日志采集的数据过大。`FTLoggerConfig.enableConsoleLog`原理是抓取编译 `android.util.Log`，Java 与 Kotlin`println`，建议按需调整`FTLoggerConfig`[配置](app-access.md#log-config)下`sampleRate`,`logPrefix`,`logLevelFilters`参数来消除或缓解这个问题

## Okhttp EventListener 集成 SDK 后失效
Plugin AOP ASM 插入之后，会在原工程代码基础上，会在 `OkHttpClient.Builder()` 加入 `eventListenerFactory` ，这会覆盖原来的 `eventListener` 或 `eventListenerFactory`。

**处理方式：**

* **ft-sdk < 1.4.1**

	关闭自动 Plugin AOP 自动设置 `FTRUMConfig setEnableTraceUserResource(false)`，同时自定义一个 [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) 并继承 `FTResourceEventListener.FTFactory`，使用[自定义](https://github.com/GuanceDemo/guance-app-demo/blob/a57679eb287ba961f6607ca47048312e91635492/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt#L72)方式进行接入。

* **ft-sdk >= 1.4.1**

	自定义一个 [CustomEventListenerFactory](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/custom/okhttp/CustomEventListenerFactory.kt) 并继承 `FTResourceEventListener.FTFactory`，通过设置 `FTRUMConfig.setOkHttpEventListenerHandler` 对 ASM 写入的 `eventListenerFactory` 进行自定义。