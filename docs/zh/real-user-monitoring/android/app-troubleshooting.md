# 故障排查
## 编译错误
编译过程发生错误，需要首先检查，编译环境

### 可运行编译环境 
#### 可运行环境 ✅
* AGP `com.android.tools.build:gradle` 版本 `3.5.0` 以上
* gradle 版本 `5.4.0` 以上
* java 版本 `8.0` 以上
*  Android minSdkVersion 21

>  随着 Android Studio 版本更新，这部分版本兼容度也会发生变化，如果你有碰到编译环境符合以上条件，但是仍然遇到编译出错的问题，请联系我们的开发人员

#### 可兼容运行环境 ⚠️
* AGP `com.android.tools.build:gradle` 版本 `3.0.1` 以上
* gradle 版本 `4.8.1` 以上
* java 版本 `8.0` 以上
* Android minSdkVersion 21

> 此环境 `ft-plugin` 无法使用，数据自动捕获的部分需要，手动接入完成。受影响包括 **RUM** `Action`，`Resource`，和 `android.util.Log` 控制台日志日志输出

#### Gradle Sync 错误


####  编译错误

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
如果编译过程出现这个问题，AGP 3.0.1 兼容性问题，可以提升 , 使用 `app/build.gradle` 升级版本即可。

```gradle
dependencies {
	implementation('com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:1.3.10.beta01')//1.3.10 以上均可以
}
```

## SDK 初始化异常校验

查看 `Logcat`确认是否存在日志 `Level` 为 `Error` ，`Tag` 为 `[FT-SDK]*` 前缀的日志 

```kotlin
14:46:04.825 [FT-SDK]  com.ft   E  请先安装SDK(在应用启动时调用FTSdk.install(FTSDKConfig ftSdkConfig))
``` 

## 开启 Debug 调试{#debug-mode}
你可以通过以下配置，开启 SDK 的 debug 功能，开启之后，控制台 ``LogCat`` 会输出 SDK 调试日志，你可以过滤 `[FT-SDK]` 字符，定位到观测云 SDK 日志。

```kotlin
  val config = FTSDKConfig.setDebug(true);
  FTSdk.install(config)
```
>**建议Relase 版本发布时，关闭这个配置**

## SDK 正常运行但是没有数据
* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行
* 对应工作空间是否
* [开启 Debug 调试](#debug-mode)之后，过滤字符 `[FT-SDK]`检查，SDK 配置 app_id 是否与创建 appid

## 开启日志后发生卡顿问题




