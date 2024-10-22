# Android 应用接入
---

???- quote "更新日志"

    === "ft-sdk"
		**1.6.1**
		```markdown
		1. 修复 RUM 单独调用自定义 startView，导致监控指标 FTMetricsMTR 线程未被回收的问题
		2. 支持通过 FTSdk.appendGlobalContext(globalContext)、FTSdk.appendRUMGlobalContext(globalContext)、
		 FTSdk.appendLogGlobalContext(globalContext)添加动态属性
		3. 支持通过 FTSdk.clearAllData() 清理未上报缓存数据
		4. SDK setSyncSleepTime 最大限制延长为 5000 ms
		```
		**1.6.0**
		```markdown
		1. 优化数据存储和同步性能
		（旧版本升级至 1.6.0 需要配置 FTSDKConfig.setNeedTransformOldCache 进行旧数据兼容同步）
		2. 修复在使用 ft-plugin 时，调用 Log.w(String,Throwable) 引发异常的问题
		```
		**1.5.2**：
        ``` markdown
		1. Error network_error 添加本地网络错误类型的提示，用于补充说明 Resource 数据中 resource_status=0 场景
		2. 修复 setEnableTrackAppCrash(false) 时 uncaughtException rethrow 传递问题
		```
		**1.5.1**：
        ``` markdown
		1. Java Crash 及 ANR 补充其他线程代码堆栈
		2. Java Crash，Native Crash，ANR 添加附加 logcat 配置功能
		3. 修复长 session 且无 action 更新场景下，频繁更新 session_id 的问题
		```
		**1.5.0**：
        ``` markdown
		1. RUM resource 网络请求添加 remote ip 地址解析功能
		2. 修复开启 RUM SampleRate 后，高并发网路请求引发的数组线程安全问题
		3. ConnectivityManager.registerDefaultNetworkCallback 方法容错优化
		4. 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
		5. 自动采集 Action click 中控件资源名 id 获取优化
		6. SDK config 配置读取异常问题容错优化
        ```
		**1.4.6**：
        ``` markdown
     	1. SDK 初始化容错优化
		2. 新增日志新增 Status.Debug 类型
		3. 控制台抓取日志等级对应关系调整： Log.i -> info，Log.d -> debug
		4. FTLogger 自定义日志支持自定义 status 字段
        ```
		**1.4.5**：
        ``` markdown
        1. 重复初始化兼容优化处理
		2. 优化 c/c++ 崩溃采集数据同步逻辑，避免在某些场景下意外中断退出，导致死锁
		3. 优化 startAction Property 属性写入逻辑，避免发生线程安全访问问题	
        ```
		**1.4.4**：
        ``` markdown
        1. 数据库链接容错保护
		2. 修正 setOnlySupportMainProcess true 时，子进程配置部份不起效问题
		3. 修正 RUM 不开启 View 采集, Crash 不会 rethrow 的问题
        ```
        **1.4.3**：
        ``` markdown
        1. 支持 Dataway 与 Datakit 的地址上传
        2. 支持发送 Action，View，Resource，LongTask，Error 类型的 RUM 数据。
          - View，Action 页面跳转，控件点击操作自动采集，需要使用 ft-plugin
          - Resource，自动采集，仅支持 Okhttp，并需要使用 ft-plugin
          - Error 中的 Native Crash 和 ANR 需要使用 ft-native
        3. 支持发送 Log 数据，控制台自动写入，需要使用 ft-plugin
        4. 链路 http header propagation，仅支持 Okhttp，并需要使用 ft-plugin
        5. 支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数。
        6. 支持 SDK 内部日志转化为文件
        ```
        [更多日志](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/CHANGELOG.md)

    === "ft-native"
		**1.1.1**：
        ``` markdown
		1. 添加 Native Crash 和 ANR 中 logcat 配置功能
		```
        **1.1.0**：
        ``` markdown
        1. 支持捕获 ANR Crash
        2. 支持捕获 C/C++ Native Crash
        3. 支持崩溃时采集应用运行状态
        4. 支持 ANR 和 Native Crash 触发回调用
        ```
        [更多日志](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-native/CHANGELOG.md)

    === "ft-plguin ( AGP >=7.4.2 )"
		**1.3.3**：
        ``` markdown
		1. 优化 native symbol so 自动获取上传，支持自定义指定 nativeLibPath
		```
		**1.3.2**：
        ``` markdown
		1. 支持 React Native WebView 事件自动捕获
		```
		**1.3.1**：
        ``` markdown
		1. 添加 asmVersion 配置功能，支持 asm7 - asm9，默认为 asm9
		2. 修复了 WebView 自定义方法在 ASM 写入后导致循环调用，从而无法加载 WebView 内容的问题
			(涉及方法 loadUrl、loadData、loadDataWithBaseURL、 postUrl)
		3. IgnoreAOP 支持在类中声明，进行整个类中的方法忽略
		4. 添加 ignorePackages 配置， 支持通过包路径配置对 ASM 进行忽略
		```
        **1.3.0**：
        ``` markdown
        1. 支持 datakit source map 自动上传，支持 native symbol 的上传
        2. 支持捕获 Application 冷热启动，Activity 页面跳转，View、ListView、Dialog、Tab 点击事件。
        3. 支持 Webview Js 监听方法的写入
        4. 支持 Okhttp Trace 和 Resource 数据自动写入
        5. 支持 Gradle 8.0,AGP 8.0 
        6. 支持 IgnoreAOP 忽略标记
        7. 支持兼容阿里云热修复框架
        ```
        [更多日志](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-plugin/CHANGELOG.md)
   
    === "ft-plugin-legacy ( AGP <=7.4.2 )"
		**1.1.8**：
        ``` markdown
		1. 支持 React Native WebView 事件自动捕获
		```
		**1.1.7**：
        ``` markdown
		1. 修复了 WebView 子类重写方法在 ASM 写入后导致循环调用，从而无法加载 WebView 内容的问题
			(涉及方法 loadUrl、loadData、loadDataWithBaseURL、 postUrl)
		2. IgnoreAOP 支持在类中声明，进行整个类中的方法忽略
		3. 添加 ignorePackages 配置， 支持通过包路径配置对 ASM 进行忽略
		```
        **1.1.6**：
        ``` markdown
        1. 支持 datakit source map 自动上传，支持 native symbol 的上传
        2. 支持捕获 Application 冷热启动，Activity 页面跳转，View、ListView、Dialog、Tab 点击事件。
        3. 支持 Webview Js 监听方法的写入
        4. 支持 Okhttp Trace 和 Resource 数据自动写入
        5. 支持 AGP 7.4.2 以下的版本
        6. 支持 IgnoreAOP 忽略标记
        7. 支持兼容阿里云热修复框架
        ```
        [更多日志](https://github.com/GuanceCloud/datakit-android/blob/plugin_legacy_support/ft-plugin/CHANGELOG.md)



观测云应用监测能够通过收集各个 Android 应用的指标数据，以可视化的方式分析各个 Android 应用端的性能。

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入 {#android-integration} 

登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。

- 观测云提供**公网 DataWay**直接接收 RUM 数据，无需安装 DataKit 采集器。配置 `site` 和 `clientToken` 参数即可。

![](../img/android_01.png)

- 观测云同时支持**本地环境部署**接收 RUM 数据，该方式需满足前置条件。

![](../img/6.rum_android_1.png)


## 安装 {#setup}

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/agent/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-native&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/native/version.json&link=https://github.com/GuanceCloud/datakit-android
) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/plugin/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-plugin-legacy&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/plugin_legacy/version.json&link=https://github.com/GuanceCloud/datakit-android)

**源码地址**：[https://github.com/GuanceCloud/datakit-android](https://github.com/GuanceCloud/datakit-android)

**Demo**：[https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/android/demo)

### Gradle 配置 {#gradle-setting}

在项目的根目录的 `build.gradle` 文件中添加 `SDK` 的远程仓库地址

=== "buildscript"

	```groovy
	buildscript {
	    //...
	    repositories {
	        //...
	        //添加 SDK 的远程仓库地址
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	    dependencies {
	        //...
	        //添加 Plugin 的插件，依赖 AGP 7.4.2 以上，Gradle 7.2.0 以上
	        classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin:[latest_version]'
	        // AGP 7.4.2 以下版本，请使用 ft-plugin-legacy 
	        //classpath 'com.cloudcare.ft.mobile.sdk.tracker.plugin:ft-plugin-legacy:[latest_version]'
	        
	    }
	}
	allprojects {
	    repositories {
	        //...
	        //添加 SDK 的远程仓库地址
	        maven {
	            url 'https://mvnrepo.jiagouyun.com/repository/maven-releases'
	        }
	    }
	}
	```

=== "plugins DSL"

	```groovy
	//setting.gradle
	
	pluginManagement {
	    repositories {
	        google()
	        mavenCentral()
	        gradlePluginPortal()
	        //添加 SDK 的远程仓库地址
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	dependencyResolutionManagement {
	    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
	    repositories {
	        google()
	        mavenCentral()
	        //添加 SDK 的远程仓库地址
	        maven {
	            url('https://mvnrepo.jiagouyun.com/repository/maven-releases')
	        }
	    }
	}
	
	//build.gradle
	
	plugins{
		//添加 Plugin 的插件，依赖 AGP 7.4.2 以上，Gradle 7.2.0 以上
		id 'com.cloudcare.ft.mobile.sdk.tracker.plugin' version '[lastest_version]' apply false
		// AGP 7.4.2 以下版本，请使用 ft-plugin-legacy 
		//id 'com.cloudcare.ft.mobile.sdk.tracker.plugin.legacy' version '[lastest_version]' apply false
	}
	
	```


在项目主模块 `app` 的 `build.gradle` 文件中添加 `SDK` 的依赖及 `Plugin` 的使用 和 Java 8 的支持

```groovy
dependencies {
    //添加 SDK 的依赖
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
    //捕获 native 层崩溃信息的依赖，需要配合 ft-sdk 使用不能单独使用
    implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-native:[latest_version]'
    //推荐使用这个版本，其他版本未做过充分兼容测试
    implementation 'com.google.code.gson:gson:2.8.5'

}
//应用插件
apply plugin: 'ft-plugin'
//配置插件使用参数
FTExt {
    //是否显示 Plugin 日志，默认为 false
    showLog = true
	
    //设置 ASM 版本，支持 asm7 - asm9，默认 asm9
    //asmVersion='asm7'

    //ASM 忽略路径配置，路径中 . 和 / 等效
    //ignorePackages=['com.ft','com/ft']

	// native so 指定路径，徐只要指定到 abi 文件的上层目录
	// |-stripped_native_libs
	// 		|-release
	// 			|-out
	//			|-lib
	//				|-arm64-v8a
	//				|-armeabi-v7a
	//				|-...
    //nativeLibPath='/build/intermediates/merged_native_libs/release/out/lib'
}
android{
	//...省略部分代码
	defaultConfig {
        //...省略部分代码
        ndk {
            //当使用 ft-native 捕获 native 层的崩溃信息时，应该根据应用适配的不同的平台
            //来选择支持的 abi 架构，目前 ft-native 中包含的 abi 架构有 'arm64-v8a',
            // 'armeabi-v7a', 'x86', 'x86_64'
            abiFilters 'armeabi-v7a'
        }
    }
    compileOptions {
        sourceCompatibility = 1.8
        targetCompatibility = 1.8
    }
}
```

> 最新的版本请看上方的 Agent 和 Plugin 的版本名

## Application 配置 {#application-setting}
理论上最佳初始化 SDK 的位置在 `Application` 的 `onCreate` 方法中，如果您的应用还没有创建 `Application`，您需要创建一个，并且在 `AndroidManifest.xml` 中 `Application` 中声明，示例请参考[这里](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/AndroidManifest.xml)。

```xml
<application 
       android:name="YourApplication"> 
</application> 
```

## SDK 初始化

### 基础配置 {#base-setting}
=== "Java"

	```java
	public class DemoApplication extends Application {

	    @Override
	    public void onCreate() {
			 //本地环境部署、Datakit 部署
	        FTSDKConfig config = FTSDKConfig.builder(datakitUrl);

			//使用公网 DataWay
			FTSDKConfig config = FTSDKConfig.builder(datawayUrl, clientToken);

	        FTSdk.install(config);
	        // ...
	    }
	}
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {
			//本地环境部署、Datakit 部署
			val config = FTSDKConfig.builder(datakitUrl)

			//使用公网 DataWay
			val config = FTSDKConfig.builder(datawayUrl, clientToken)

			FTSdk.install(config)
			//...
	    }
	}
    ```

| **方法名** | **类型** | **必须** | **含义** |
| --- | --- | --- | --- | 
| datakitUrl | String | 是 | Datakit 访问 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529，安装 SDK 设备需能访问这地址。**注意：datakit 和 dataway 配置两者二选一**|
| datawayUrl | String | 是 | 公网 Dataway 访问 URL 地址，例子：http://10.0.0.1:9528，端口默认 9528，安装 SDK 设备需能访问这地址。**注意：datakit 和 dataway 配置两者二选一** |
| clientToken | String | 是 | 认证 token，需要与 datawayUrl 同时配置  |
| setDebug | Boolean | 否 | 是否开启调试模式 。默认为 `false`，开启后方可打印 SDK 运行日志 |
| setEnv | EnvType | 否 | 设置采集环境, 默认为 `EnvType.PROD`， |
| setEnv | String | 否 | 设置采集环境，默认为 `prod`。**注意: String 或 EnvType 类型只需配置一个**|
| setOnlySupportMainProcess | Boolean | 否 | 是否只支持在主进程运行，默认为 `true` ，如果需要在其他进程中执行需要将该字段设置为 `false` |
| setEnableAccessAndroidID | Boolean | 否 | 开启获取 `Android ID`，默认为 `true`，设置为 `false`，则 `device_uuid` 字段数据将不进行采集,市场隐私审核相关[查看这里](#adpot-to-privacy-audits) |
| addGlobalContext | Dictionary | 否 | 添加 SDK 全局属性，添加规则请查阅[此处](#key-conflict) |
| setServiceName | String | 否 | 设置服务名，影响 Log 和 RUM 中 service 字段数据，默认为 `df_rum_android` |
| setAutoSync | Boolean | 否 | 是否开启自动同步，默认为 `true`。当为 false 时使用 `FTSdk.flushSyncData()` 自行管理数据同步 |  
| setSyncPageSize | enum | 否 | 设置同步请求条目数，`SyncPageSize.MINI` 5 条，`SyncPageSize.MEDIUM` 10 条，`SyncPageSize.LARGE` 50 条，默认 `SyncPageSize.MEDIUM`   |
| setCustomSyncPageSize | enum | 否 | 设置同步请求条目数，范围 [5,)，注意请求条目数越大，代表数据同步占用更大的计算资源，默认为 10   |
| setSyncSleepTime | Int | 否 | 设置同步间歇时间，范围 [0,5000]，默认不设置  |
| enableDataIntegerCompatible | void | 否 | 需要与 web 数据共存情况下，建议开启。此配置用于处理 web 数据类型存储兼容问题  |
| setNeedTransformOldCache | void | 否 |  是否需要兼容同步 1.6.0 以下的版本的旧缓存数据，默认为 false |

### RUM 配置 {#rum-config}

=== "Java"

	```java

	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .setRumAppId(RUM_APP_ID)
	            .setEnableTraceUserAction(true)
	            .setEnableTraceUserView(true)
	            .setEnableTraceUserResource(true)
	            .setSamplingRate(0.8f)
	            .setExtraMonitorTypeWithError(ErrorMonitorType.ALL.getValue())
	            .setDeviceMetricsMonitorType(DeviceMetricsMonitorType.ALL.getValue())
	            .setEnableTrackAppUIBlock(true)
	            .setEnableTrackAppCrash(true)
	            .setEnableTrackAppANR(true)
	);

	```

=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .setRumAppId(RUM_APP_ID)
	                .setEnableTraceUserAction(true)
	                .setEnableTraceUserView(true)
	                .setEnableTraceUserResource(true)
	                .setSamplingRate(0.8f)
	                .setExtraMonitorTypeWithError(ErrorMonitorType.ALL.getValue())
	                .setDeviceMetricsMonitorType(DeviceMetricsMonitorType.ALL.getValue())
	                .setEnableTrackAppUIBlock(true)
	                .setEnableTrackAppCrash(true)
	                .setEnableTrackAppANR(true)
	        )
	```


| **方法名** | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| setRumAppId | String | 是 | 设置`Rum AppId`。对应设置 RUM `appid`，才会开启`RUM`的采集功能，[获取 appid 方法](#android-integration) |
| setSamplingRate | Float | 否 | 设置采集率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据 |
| setEnableTrackAppCrash | Boolean | 否 | 是否上报 App 崩溃日志，默认为 `false`，开启后会在错误分析中显示错误堆栈数据。<br> [关于崩溃日志中混淆内容转换的问题](#retrace-log)。<br><br>1.5.1 以上版本，可以通过 `extraLogCatWithJavaCrash`、`extraLogCatWithNativeCrash` 设置在 Java Crash 和 Native Crash 是否显示 logcat|
| setExtraMonitorTypeWithError | Array| 否 | 设置辅助监控信息，添加附加监控数据到 `Rum` 崩溃数据中，`ErrorMonitorType.BATTERY` 为电池余量，`ErrorMonitorType.MEMORY` 为内存用量，`ErrorMonitorType.CPU` 为 CPU 占有率 |
| setDeviceMetricsMonitorType | Array | 否 | 设置 View 监控信息，在 View 周期中，添加监控数据，`DeviceMetricsMonitorType.BATTERY` 监控当前页的最高输出电流输出情况，`DeviceMetricsMonitorType.MEMORY` 监控当前应用使用内存情况，`DeviceMetricsMonitorType.CPU` 监控 CPU 跳动次数 ，`DeviceMetricsMonitorType.FPS` 监控屏幕帧率。监控周期，`DetectFrequency.DEFAULT` 500 毫秒，`DetectFrequency.FREQUENT` 100毫秒，`DetectFrequency.RARE` 1 秒 |
| setEnableTrackAppANR | Boolean | 否 | 是否开启 ANR 检测，默认为 `false`。<br><br>1.5.1 以上版本，可以通过 `extraLogCatWithANR` 设置 ANR 中是否显示 logcat |
| setEnableTrackAppUIBlock | Boolean | 否 | 是否开启 UI 卡顿检测，默认为 `false` |
| setEnableTraceUserAction | Boolean | 否 | 是否自动追踪用户操作，目前只支持用户启动和点击操作，默认为 `false` |
| setEnableTraceUserView | Boolean | 否 | 是否自动追踪用户页面操作，默认为 `false` |
| setEnableTraceUserResource | Boolean | 否 | 是否自动追动用户网络请求 ，仅支持 `Okhttp`，默认为 `false` |
| setEnableResourceHostIP | Boolean | 否 | 是否采集请求目标域名地址的 IP。作用域：只影响 `EnableTraceUserResource`  为 true 的默认采集。自定义 Resource 采集，需要使用 `FTResourceEventListener.FTFactory(true)` 来开启这个功能。另外，单个 Okhttp 对相同域名存在 IP 缓存机制，相同 `OkhttpClient`，在连接服务端 IP 不发生变化的前提下，只会生成一次|
| setResourceUrlHandler | callback| 否 | 设置需要过滤的 Resource 条件，默认不过滤 |
| setOkHttpEventListenerHandler | callback| 否 | ASM 设置全局 Okhttp EventListener，默认不设置 |
| addGlobalContext | Dictionary | 否 | 添加自定义标签，用于用户监测数据源区分，如果需要使用追踪功能，则参数 `key` 为 `track_id` ,`value` 为任意数值，添加规则注意事项请查阅[此处](#key-conflict) |

### Log 配置 {#log-config}

=== "Java"

	```java
	FTSdk.initLogWithConfig(new FTLoggerConfig()
	    //.setEnableConsoleLog(true,"log prefix")
	    .setEnableLinkRumData(true)
	    .setEnableCustomLog(true)
	    //.setLogLevelFilters(new Status[]{Status.CRITICAL, Status.ERROR})
	    .setSamplingRate(0.8f));

	```

=== "Kotlin"

	```kotlin
	   FTSdk.initLogWithConfig(
	            FTLoggerConfig()
	              //.setEnableConsoleLog(true,"log prefix")
	                .setEnableLinkRumData(true)
	                .setEnableCustomLog(true)
	              //.setLogLevelFilters(arrayOf(Status.CRITICAL,Status.ERROR))
	                .setSamplingRate(0.8f)
	        )
	```

| **方法名** | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| setSampleRate | Float | 否 | 设置采集率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。 |
| setEnableConsoleLog | Boolean | 否 | 是否上报控制台日志，日志等级对应关系<br>Log.v -> ok;<br>Log.i -> info;<br> Log.d -> debug;<br>Log.e -> error;<br>Log.w -> warning，<br> `prefix` 为控制前缀过滤参数，默认不设置过滤。注意：Android 控制台量是很大的，为了避免影响应用性能，减少不必要的资源浪费，建议使用 `prefix` 过滤出有价值的日志 |
| setEnableLinkRUMData | Boolean | 否 | 是否与 RUM 数据关联，默认为 `false` |
| setLogCacheDiscardStrategy| LogCacheDiscard | 否 | 设置频繁日志丢弃规则，默认为 `LogCacheDiscard.DISCARD`，`DISCARD` 为丢弃追加数据，`DISCARD_OLDEST` 丢弃老数据 |
| setEnableCustomLog | Boolean| 否 | 是否上传自定义日志，默认为 `false` |
| setLogLevelFilters | Array | 否 | 设置等级日志过滤，默认不设置 |
| addGlobalContext | Dictionary | 否 | 添加 log 全局属性，添加规则请查阅[此处](#key-conflict) |
| setLogCacheLimitCount | Int | 否 | 获取最大日志条目数量限制 [1000,)，日志越大，代表磁盘缓存压力越大，默认 5000   |

### Trace 配置 {#trace-config}

=== "Java"

	```java
	FTSdk.initTraceWithConfig(new FTTraceConfig()
	    .setSamplingRate(0.8f)
	    .setEnableAutoTrace(true)
	    .setEnableLinkRUMData(true));
	```

=== "Kotlin"

	```kotlin
	   FTSdk.initTraceWithConfig(
	            FTTraceConfig()
	                .setSamplingRate(0.8f)
	                .setEnableAutoTrace(true)
	                .setEnableLinkRUMData(true)
	        )
	```

| **方法名** | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| setSampleRate | Float | 否 | 设置采集率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。 |
| setTraceType | TraceType | 否 | 设置链路追踪的类型，默认为 `DDTrace`，目前支持 `Zipkin` , `Jaeger`, `DDTrace`，`Skywalking` (8.0+)，`TraceParent` (W3C)，如果接入 OpenTelemetry 选择对应链路类型时，请注意查阅支持类型及 agent 相关配置 |
| setEnableLinkRUMData | Boolean | 否 | 是否与 RUM 数据关联，默认为 `false` |
| setEnableAutoTrace | Boolean | 否 | 设置是否开启自动 http trace，目前只支持 OKhttp 的自动追踪，默认为 `false` |
| setEnableWebTrace | Boolean | 否 | 设置 webview 是否开启链路追踪，alpha 功能，有一部分场景可能会有部分 js 加载问题，默认为 `false` |

## RUM 用户数据追踪 {#rum-trace}

`FTRUMConfig` 配置 `enableTraceUserAction`, `enableTraceUserView`, `enableTraceUserResource` 来实现自动获取数据的效果或手动使用 `FTRUMGlobalManager` 来实现添加这些数据，示例如下：

### Action

#### 使用方法

=== "Java"

	```java
		/**
	     *  添加 action
	     *
	     * @param actionName action 名称
	     * @param actionType action 类型
	     */
	    public void startAction(String actionName, String actionType)


	    /**
	     * 添加 action
	     *
	     * @param actionName action 名称
	     * @param actionType action 类型
	     * @param property   附加属性参数
	     */
	    public void startAction(String actionName, String actionType, HashMap<String, Object> property)

	```

=== "Kotlin"

	```kotlin
		/**
	     *  添加 action
	     *
	     * @param actionName action 名称
	     * @param actionType action 类型
	     */
		fun startAction(actionName: String, actionType: String)


		/**
	     * 添加 action
	     *
	     * @param actionName action 名称
	     * @param actionType action 类型
	     * @param property   附加属性参数
	     */
	    fun startAction(actionName: String, actionType: String, property: HashMap<String, Any>)

	```

#### 代码示例

=== "Java"

	```java
	// 场景1
	FTRUMGlobalManager.get().startAction("login", "action_type");

	// 场景2: 动态参数
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().startAction("login", "action_type", map);
	```

=== "Kotlin"

	```kotlin

	// 场景1
	FTRUMGlobalManager.get().startAction("login", "action_type")

	// 场景2: 动态参数
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTRUMGlobalManager.get().startAction("login","action_type",map)

	```

### View

#### 使用方法

=== "Java"

	```java

	    /**
	     * view 起始
	     *
	     * @param viewName 当前页面名称
	     */
	    public void startView(String viewName)


	    /**
	     * view 起始
	     *
	     * @param viewName 当前页面名称
	     * @param property 附加属性参数
	     */
	    public void startView(String viewName, HashMap<String, Object> property)


	    /**
	     * view 结束
	     */
	    public void stopView()

	    /**
	     * view 结束
	     *
	     * @param property 附加属性参数
	     */
	    public void stopView(HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin

		/**
	     * view 起始
	     *
	     * @param viewName 当前页面名称
	     */
		fun startView(viewName: String)

		 /**
	     * view 起始
	     *
	     * @param viewName 当前页面名称
	     * @param property 附加属性参数
	     */

		fun startView(viewName: String, property: HashMap<String, Any>)

		 /**
	     * view 结束
	     */
		fun stopView()

		 /**
	     * view 结束
	     *
	     * @param property 附加属性参数
	     */
		fun stopView(property: HashMap<String, Any>)

	```

#### 代码示例

=== "Java"

	```java
	@Override
	protected void onResume() {
	    super.onResume();

	    // 场景 1
	    FTRUMGlobalManager.get().startView("Current Page Name");

	    // 场景 2: 动态参数
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key", "ft_value");
	    map.put("ft_key_will_change", "ft_value");
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}

	@Override
	protected void onPause() {
	    super.onPause();

	    // 场景 1
	    FTRUMGlobalManager.get().stopView();

	    // 场景 2 : 动态参数
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change 这个数值，会在 stopView 时候被修改为 ft_value_change
	    FTRUMGlobalManager.get().startView("Current Page Name", map);
	}
	```

=== "Kotlin"

	```kotlin
	override fun onResume() {
	     super.onResume()

	     // 场景 1
	     FTRUMGlobalManager.get().startView("Current Page Name")

	     // 场景 2: 动态参数
	     val map = HashMap<String, Any>()
	     map["ft_key"] = "ft_value"
	     map["ft_key_will_change"] = "ft_value"
	     FTRUMGlobalManager.get().startView("Current Page Name", map)

	}

	override fun onPause() {
	     super.onPause()

	     // 场景 1
	     FTRUMGlobalManager.get().stopView()


	     // 场景 2 : 动态参数
	     val map = HashMap<String, Any>()
	     map["ft_key_will_change"] = "ft_value_change" //ft_key_will_change 这个数值，会在 stopView 时候被修改为 ft_value_change
	     FTRUMGlobalManager.get().startView("Current Page Name", map)

	}
	```

### Error

#### 使用方法

=== "Java"

	```java
	    /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state)


	     /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType, AppState state)

	    /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
		 * @param property  附加属性
	     */
	    public void addError(String log, String message, ErrorType errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     */
	    public void addError(String log, String message, long dateline, ErrorType errorType,
	                         AppState state, HashMap<String, Object> property)

		
		/**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     */
	    public void addError(String log, String message, String errorType, AppState state)


	     /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     */
	    public void addError(String log, String message, long dateline, String errorType, AppState state)

	    /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param property  附加属性
	     */
	    public void addError(String log, String message, String errorType, AppState state, HashMap<String, Object> property)


	    /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     * @param property  附加属性
	     */
	    public void addError(String log, String message, long dateline, String errorType,
	                         AppState state, HashMap<String, Object> property)


	```

=== "Kotlin"

	```kotlin
		/**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState)

		 /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType, state: AppState)

		 /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param property  附加属性
	     */
		fun addError(log: String, message: String, errorType: ErrorType, state: AppState, property: HashMap<String, Any>)

		 /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     * @param property  附加属性
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: ErrorType,state: AppState, property: HashMap<String, Any>)


			/**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState)

		 /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String, state: AppState)

		 /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
		 * @param property  附加属性
	     */
		fun addError(log: String, message: String, errorType: String, state: AppState, property: HashMap<String, Any>)

		 /**
	     * 添加错误信息
	     *
	     * @param log       日志
	     * @param message   消息
	     * @param errorType 错误类型
	     * @param state     程序运行状态
	     * @param dateline  发生时间，纳秒
		 * @param property  附加属性
	     */
		fun addError(log: String, message: String, dateline: Long, errorType: String,state: AppState, property: HashMap<String, Any>)

	```

#### 代码示例

=== "Java"

	```java
	// 场景 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN);

	// 场景 2:延迟记录发生的错误，这里的时间一般为错误发生的时间
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000L, ErrorType.JAVA, AppState.RUN);

	// 场景 3：动态参数
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN, map);
	```

=== "Kotlin"

	```kotlin

	// 场景 1:
	FTRUMGlobalManager.get().addError("error log", "error msg", ErrorType.JAVA, AppState.RUN)

	// 场景 2:延迟记录发生的错误，这里的时间一般为错误发生的时间
	FTRUMGlobalManager.get().addError("error log", "error msg", 16789000000000000000, ErrorType.JAVA, AppState.RUN)

	// 场景 3：动态参数
	val map = HashMap<String, Any>()
	map["ft_key"] = "ft_value"
	FTRUMGlobalManager.get().addError("error log", "error msg",ErrorType.JAVA,AppState.RUN,map)

	```
### LongTask

#### 使用方法

=== "Java"

	```java
	    /**
	     * 添加长任务
	     *
	     * @param log      日志内容
	     * @param duration 持续时间，纳秒
	     */
	    public void addLongTask(String log, long duration)

	    /**
	     * 添加长任务
	     *
	     * @param log      日志内容
	     * @param duration 持续时间，纳秒
	     */
	    public void addLongTask(String log, long duration, HashMap<String, Object> property)

	```

=== "Kotlin"

	```kotlin
	    /**
	     * 添加长任务
	     *
	     * @param log      日志内容
	     * @param duration 持续时间，纳秒
	     */
		fun addLongTask(log: String, duration: Long)

		/**
	     * 添加长任务
	     *
	     * @param log      日志内容
	     * @param duration 持续时间，纳秒
	     */

		fun addLongTask(log: String, duration: Long, property: HashMap<String, Any>)

	```

#### 代码示例

=== "Java"

	```java
	// 场景 1
	FTRUMGlobalManager.get().addLongTask("error log", 1000000L);

	// 场景 2:动态参数
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTRUMGlobalManager.get().addLongTask("", 1000000L, map);
	```

=== "Kotlin"


	```kotlin

	// 场景 1
	FTRUMGlobalManager.get().addLongTask("error log",1000000L)

	// 场景 2:动态参数
	 val map = HashMap<String, Any>()
	 map["ft_key"] = "ft_value"
	 FTRUMGlobalManager.get().addLongTask("", 1000000L,map)

	```

### Resource

#### 使用方法

=== "Java"

	```java

	    /**
	     * resource 起始
	     *
	     * @param resourceId 资源 Id
	     */
	    public void startResource(String resourceId)

	    /**
	     * resource 起始
	     *
	     * @param resourceId 资源 Id
	     */
	    public void startResource(String resourceId, HashMap<String, Object> property)

	    /**
	     * resource 终止
	     *
	     * @param resourceId 资源 Id
	     */
	    public void stopResource(String resourceId)

	    /**
	     * resource 终止
	         *
	     * @param resourceId 资源 Id
	     * @param property   附加属性参数
	     */
	    public void stopResource(final String resourceId, HashMap<String, Object> property)


	    /**
	     * 设置网络传输内容
	     *
	     * @param resourceId
	     * @param params
	     * @param netStatusBean
	     */
	    public void addResource(String resourceId, ResourceParams params, NetStatusBean netStatusBean)

	```

=== "Kotlin"

	```kotlin

	/**
	 * resource 起始
	 *
	 * @param resourceId 资源 Id
	 */
	fun startResource(resourceId: String)

	/**
	 * resource 起始
	 *
	 * @param resourceId 资源 Id
	 */
	fun startResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * resource 终止
	 *
	 * @param resourceId 资源 Id
	 */
	fun stopResource(resourceId: String)

	/**
	 * resource 终止
	 *
	 * @param resourceId 资源 Id
	 * @param property   附加属性参数
	 */
	fun stopResource(resourceId: String, property: HashMap<String, Any>)

	/**
	 * 设置网络传输内容
	 *
	 * @param resourceId
	 * @param params
	 * @param netStatusBean
	 */
	fun addResource(resourceId: String, params: ResourceParams, netStatusBean: NetStatusBean)

	```

#### 代码示例

=== "Java"

	```java

	// 场景 1
	// 请求开始
	FTRUMGlobalManager.get().startResource("resourceId");

	//...

	// 请求结束
	FTRUMGlobalManager.get().stopResource("resourceId");

	// 最后，在请求结束之后，发送请求相关的数据指标
	ResourceParams params = new ResourceParams();
	params.setUrl("https://www.guance.com");
	params.setResponseContentType(response.header("Content-Type"));
	params.setResponseConnection(response.header("Connection"));
	params.setResponseContentEncoding(response.header("Content-Encoding"));
	params.setResponseHeader(response.headers().toString());
	params.setRequestHeader(request.headers().toString());
	params.setResourceStatus(response.code());
	params.setResourceMethod(request.method());

	NetStatusBean bean = new NetStatusBean();
	bean.setTcpStartTime(60000000);
	//...

	FTRUMGlobalManager.get().addResource("resourceId", params, bean);


	// 场景 2 ：动态参数使用
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	map.put("ft_key_will_change", "ft_value");

	FTRUMGlobalManager.get().startResource("resourceId",map);

	//...
	HashMap<String, Object> map = new HashMap<>()；
	map.put("ft_key_will_change", "ft_value_change"); //ft_key_will_change 这个数值，会在 stopResource 时候被修改为 ft_value_change
	FTRUMGlobalManager.get().stopResource(uuid,map);

	```

=== "Kotlin"

	```kotlin
	// 场景 1
	//请求开始
	FTRUMGlobalManager.get().startResource("resourceId")

	//请求结束
	FTRUMGlobalManager.get().stopResource("resourceId")

	//最后，在请求结束之后，发送请求相关的数据指标
	val params = ResourceParams()
	params.url = "https://www.guance.com"
	params.responseContentType = response.header("Content-Type")
	arams.responseConnection = response.header("Connection")
	params.responseContentEncoding = response.header("Content-Encoding")
	params.responseHeader = response.headers.toString()
	params.requestHeader = request.headers.toString()
	params.resourceStatus = response.code
	params.resourceMethod = request.method

	val bean = NetStatusBean()
	bean.tcpStartTime = 60000000
	//...
	FTRUMGlobalManager.get().addResource("resourceId",params,bean)

	// 场景 2 ：动态参数使用
	val map = hashMapOf<String, Any>(
	        "ft_key" to "ft_value",
	        "ft_key_will_change" to "ft_value"
	)
	FTRUMGlobalManager.get().startResource("resourceId", map)

	//...
	val map = hashMapOf<String, Any>(
	        "ft_key_will_change" to "ft_value_change"
	)
	// ft_key_will_change 这个数值，会在 stopResource 时候被修改为 ft_value_change

	FTRUMGlobalManager.get().stopResource(uuid, map)

	```

| **方法名** | **必须** | **含义** |**说明** |
| --- | --- | --- | --- |
| NetStatusBean.fetchStartTime | 否 | 请求开始时间 | |
| NetStatusBean.tcpStartTime | 否 | tcp 连接时间 |  |
| NetStatusBean.tcpEndTime | 否 | tcp 结束时间 |  |
| NetStatusBean.dnsStartTime | 否 | dns 开始时间 |  |
| NetStatusBean.dnsEndTime | 否 |  dns 结束时间 | |
| NetStatusBean.responseStartTime | 否 | 响应开始时间 |  |
| NetStatusBean.responseEndTime | 否 | 响应结束时间 |  |
| NetStatusBean.sslStartTime | 否 | ssl 开始时间 |  |
| NetStatusBean.sslEndTime | 否 |  ssl 结束时间 | |
| NetStatusBean.property| 否 |  附加属性 | |
| ResourceParams.url | 是 |  url 地址 | |
| ResourceParams.requestHeader | 否 | 请求头参数 |  |
| ResourceParams.responseHeader | 否 | 响应头参数 |  |
| ResourceParams.responseConnection | 否 |  响应  connection | |
| ResourceParams.responseContentType | 否 |  响应  ContentType | |
| ResourceParams.responseContentEncoding | 否 | 响应  ContentEncoding |  |
| ResourceParams.resourceMethod | 否 | 请求方法 |  GET,POST 等 |
| ResourceParams.responseBody | 否 |  返回 body 内容 | |
| ResourceParams.property| 否 | 附加属性 |  |

## Logger 日志打印 {#log} 
使用 `FTLogger` 进行日志输出
> 目前日志内容限制为 30 KB，字符超出部分会进行截断处理

### 使用方法

=== "Java"

	```java
	    /**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
	     */
	    public void logBackground(String content, Status status)

	    /**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
		 * @param property 附加属性
	     */
	    public void logBackground(String content, Status status, HashMap<String, Object> property)

		/**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
	     */
	    public void logBackground(String content, String status)

	    /**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
		 * @param property 附加属性
	     */
	    public void logBackground(String content, String status, HashMap<String, Object> property)


	    /**
	     * 将多条日志数据存入本地同步
	     *
	     * @param logDataList {@link LogData} 列表
	     */
	    public void logBackground(List<LogData> logDataList)


	```

=== "Kotlin"

	```kotlin

	    /**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
	     */
	    fun logBackground(content: String, status: Status)

	    /**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
	     * @param property 日志属性
	     */
	    fun logBackground(content: String, status: Status, property: HashMap<String, Any>)

		/**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
	     */
	    fun logBackground(content: String, status: String)

	    /**
	     * 将单条日志数据存入本地同步
	     *
	     * @param content 日志内容
	     * @param status  日志等级
	     * @param property 日志属性
	     */
	    fun logBackground(content: String, status: String, property: HashMap<String, Any>)

	    /**
	     * 将多条日志数据存入本地同步
	     *
	     * @param logDataList 日志数据列表
	     */
	    fun logBackground(logDataList: List<LogData>)

	```

#### 日志等级

| **方法名** | **含义** |
| --- | --- |
| Status.DEBUG | 调试 |
| Status.INFO | 提示 |
| Status.WARNING | 警告 |
| Status.ERROR | 错误 |
| Status.CRITICAL | 严重 |
| Status.OK | 恢复 |

### 代码示例


=== "Java"

	```java
	// 上传单个日志
	FTLogger.getInstance().logBackground("test", Status.INFO);

	// 传递参数到 HashMap
	HashMap<String, Object> map = new HashMap<>();
	map.put("ft_key", "ft_value");
	FTLogger.getInstance().logBackground("test", Status.INFO, map);

	// 批量上传日志
	List<LogData> logList = new ArrayList<>();
	logList.add(new LogData("test", Status.INFO));
	FTLogger.getInstance().logBackground(logList);
	```

=== "Kotlin"

	```kotlin
	//上传单个日志
	FTLogger.getInstance().logBackground("test", Status.INFO)

	//传递参数到 HashMap
	val map = HashMap<String,Any>()
	map["ft_key"]="ft_value"
	FTLogger.getInstance().logBackground("test", Status.INFO,map)

	//批量上传日志
	FTLogger.getInstance().logBackground(mutableListOf(LogData("test",Status.INFO)))
	```

## Tracer 网络链路追踪

`FTTraceConfig` 配置开启`enableAutoTrace`自动添加链路数据，或手动使用 `FTTraceManager` 在 Http 请求中 `Propagation Header`，示例如下：

=== "Java"

	```java
	String url = "https://www.guance.com";
	String uuid = "uuid";
	// 获取链路头参数
	Map<String, String> headers = FTTraceManager.get().getTraceHeader(uuid, url);

	OkHttpClient client = new OkHttpClient.Builder().addInterceptor(chain -> {
	    Request original = chain.request();
	    Request.Builder requestBuilder = original.newBuilder();
	    // 在请求中，添加链路头参数
	    for (String key : headers.keySet()) {
	        requestBuilder.header(key, headers.get(key));
	    }
	    Request request = requestBuilder.build();

	    Response response = chain.proceed(request);

	    if (response != null) {
	        Map<String, String> requestHeaderMap = new HashMap<>();
	        Map<String, String> responseHeaderMap = new HashMap<>();
	        for (Pair<String, String> header : response.request().headers()) {
	            requestHeaderMap.put(header.first, header.second);
	        }
	        for (Pair<String, String> header : response.headers()) {
	            responseHeaderMap.put(header.first, header.second);
	        }
	    }

	    return response;
	}).build();

	Request.Builder builder = new Request.Builder().url(url).method(RequestMethod.GET.name(), null);
	client.newCall(builder.build()).execute();
	```

=== "Kotlin"

	```kotlin
	val url = "https://www.guance.com"
	val uuid ="uuid"
	//获取链路头参数
	val headers = FTTraceManager.get().getTraceHeader(uuid, url)

	val client: OkHttpClient = OkHttpClient.Builder().addInterceptor { chain ->

	                    val original = chain.request()
	                    val requestBuilder = original.newBuilder()
	                    //在请求中，添加链路头参数
	                    for (key in headers.keys) {
	                        requestBuilder.header(key!!, headers[key]!!)
	                    }
	                    val request = requestBuilder.build()

	                    response = chain.proceed(request)

	                    if (response != null) {
	                        val requestHeaderMap = HashMap<String, String>()
	                        val responseHeaderMap = HashMap<String, String>()
	                        request.headers.forEach {
	                            requestHeaderMap[it.first] = it.second
	                        }
	                        response!!.headers.forEach {
	                            responseHeaderMap[it.first] = it.second

	                        }

	                    }

	                    response!!
	                }.build()

	 val builder: Request.Builder = Request.Builder().url(url).method(RequestMethod.GET.name, null)
	client.newCall(builder.build()).execute()
	```

## 通过 OKHttp Interceptor 自定义 Resource 和 TraceHeader {#okhttp_resource_trace_interceptor_custom}

 `FTRUMConfig`的`enableTraceUserResource` ，`FTTraceConfig`的 `enableAutoTrace` 配置，同时开启，优先加载自定义 `Interceptor` 配置
 >ft-sdk < 1.4.1，需要关闭 `FTRUMConfig`的`enableTraceUserResource` ，`FTTraceConfig`的 `enableAutoTrace`

=== "Java"

	```java
	 new OkHttpClient.Builder()
	        .addInterceptor(new FTTraceInterceptor(new FTTraceInterceptor.HeaderHandler() {
	               @Override
	               public HashMap<String, String> getTraceHeader(Request request) {
	                   HashMap<String, String> map = new HashMap<>();
	                   map.put("custom_header","custom_value");
	                   return map;
	              }
	        }))
           .addInterceptor(new FTResourceInterceptor(new FTResourceInterceptor.ContentHandlerHelper() {
               @Override
               public void onRequest(Request request, HashMap<String, Object> extraData) {
                   String contentType = request.header("Content-Type");
                   extraData.put("df_request_header", request.headers().toString());
                   if ("application/json".equals(contentType) ||
                           "application/x-www-form-urlencoded".equals(contentType) ||
                           "application/xml".equals(contentType)) {
                       extraData.put("df_request_body", request.body());
                
            
               @Override
               public void onResponse(Response response, HashMap<String, Object> extraData) throws IOException {
                   String contentType = response.header("Content-Type");
                   extraData.put("df_response_header", response.headers().toString());
                   if ("application/json".equals(contentType) ||
                           "application/xml".equals(contentType)) {
                       //copy 读取部分 body，避免大数据消费
                       ResponseBody body = response.peekBody(33554432);
                       extraData.put("df_response_body", body.string());
                   }
            
               @Override
               public void onException(Exception e, HashMap<String, Object> extraData)
               }
           }))
           .eventListenerFactory(new FTResourceEventListener.FTFactory())
           .build();
	```
	
=== "Kotlin"

	```kotlin
	OkHttpClient.Builder()
    .addInterceptor(FTTraceInterceptor(object : FTTraceInterceptor.HeaderHandler {
        override fun getTraceHeader(request: Request): HashMap<String, String> {
            val map = HashMap<String, String>()
            map["custom_header"] = "custom_value"
            return map
        }
    }))
    .addInterceptor(FTResourceInterceptor(object : FTResourceInterceptor.ContentHandlerHelper {
        override fun onRequest(request: Request, extraData: HashMap<String, Any>) {
            val contentType = request.header("Content-Type")
            extraData["df_request_header"] = request.headers().toString()
            if ("application/json" == contentType ||
                "application/x-www-form-urlencoded" == contentType ||
                "application/xml" == contentType) {
                extraData["df_request_body"] = request.body()
            }
        }

        override fun onResponse(response: Response, extraData: HashMap<String, Any>) {
            val contentType = response.header("Content-Type")
            extraData["df_response_header"] = response.headers().toString()
            if ("application/json" == contentType ||
                "application/xml" == contentType) {
                // 复制部分响应体以避免大数据消耗
                val body = response.peekBody(33554432)
                extraData["df_response_body"] = body.string()
            }
        }

        override fun onException(e: Exception, extraData: HashMap<String, Any>) {
            // 处理异常情况
        }
    }))
    .eventListenerFactory(FTResourceEventListener.FTFactory())
    .build()
	```

## 用户信息绑定与解绑 {#userdata-bind-and-unbind}
使用  `FTSdk` 进行用户的绑定和解绑 

### 使用方法

=== "Java"

	```java

	   /**
	     * 绑定用户信息
	     *
	     * @param id
	     */
	    public static void bindRumUserData(@NonNull String id)

	    /**
	     * 绑定用户信息
	     */
	    public static void bindRumUserData(@NonNull UserData data)
	```

=== "Kotlin"

	``` kotlin
	/**
	     * 绑定用户信息
	     *
	     * @param id 用户 ID
	     */
	    fun bindRumUserData(id: String) {
	        // TODO: implement bindRumUserData method
	    }

	    /**
	     * 绑定用户信息
	     *
	     * @param data 用户信息
	     */
	    fun bindRumUserData(data: UserData) {
	        // TODO: implement bindRumUserData method
	    }
	```


#### UserData
| **方法名** | **含义** | **必须** | **说明** |
| --- | --- | --- | --- |
| setId |  设置用户 ID | 否 | |
| setName | 设置用户名 | 否 | |
| setEmail | 设置邮箱 | 否 | |
| setExts | 设置用户扩展 | 否 | 添加规则请查阅[此处](#key-conflict)|

### 代码示例

=== "Java"

	```java
	// 可以在用户登录成功后调用此方法用来绑定用户信息
	FTSdk.bindRumUserData("001");

	UserData userData = new UserData();
	userData.setName("test.user");
	userData.setId("test.id");
	userData.setEmail("test@mail.com");
	Map<String, String> extMap = new HashMap<>();
	extMap.put("ft_key", "ft_value");
	userData.setExts(extMap);
	FTSdk.bindRumUserData(userData);

	// 可以在用户退出登录后调用此方法来解绑用户信息
	FTSdk.unbindRumUserData();

	```

=== "Kotlin"

	```kotlin
	//可以在用户登录成功后调用此方法用来绑定用户信息
	FTSdk.bindRumUserData("001")


	//绑定用户更多数据
	val userData = UserData()
	userData.name = "test.user"
	userData.id = "test.id"
	userData("test@mail.com")
	val extMap = HashMap<String, String>()
	extMap["ft_key"] = "ft_value"
	userData.setExts(extMap)
	FTSdk.bindRumUserData(userData)

	//可以在用户退出登录后调用此方法来解绑用户信息
	FTSdk.unbindRumUserData()
	```


## 关闭 SDK
使用  `FTSdk` 关闭  SDK 

### 使用方法
=== "Java"

	```java
	    /**
	     * 关闭 SDK 内正在运行对象
	     */
	    public static void shutDown()

	```

=== "Kotlin"


	``` kotlin
	    /**
	     * 关闭 SDK 内正在运行对象
	     */
	    fun shutDown()
	```

### 代码示例
    
=== "Java"

	```java
	//如果动态改变 SDK 配置，需要先关闭，以避免错误数据的产生
	FTSdk.shutDown();
	```

=== "Kotlin"

	```kotlin
	//如果动态改变 SDK 配置，需要先关闭，以避免错误数据的产生
	FTSdk.shutDown()
	```

## 清理 SDK 缓存数据
使用  `FTSdk` 清理未上报的缓存数据 

### 使用方法
=== "Java"

	```java
	    /**
		 * 清理未上报的缓存数据
		 */
	    public static void clearAllData()

	```

=== "Kotlin"


	``` kotlin
	     /**
		  * 清理未上报的缓存数据
		  */
	    fun clearAllData()
	```

### 代码示例
    
=== "Java"

	```java
	FTSdk.clearAllData();
	```

=== "Kotlin"

	```kotlin
	FTSdk.clearAllData()
	```

## 主动同步数据
使用 `FTSdk` 主动同步数据。
>FTSdk.setAutoSync(false) 时, 才需要自行进行数据同步

### 使用方法

=== "Java"

	```java
	   /**
	     * 主动数据同步
	     */
	    public static void flushSyncData()
	```

=== "Kotlin"

	```kotlin
	   /**
	     * 主动数据同步
	     */
	    fun flushSyncData()
	```

### 代码示例

=== "Java"

	```java
	FTSdk.flushSyncData()
	```

=== "Kotlin"

	```kotlin
	FTSdk.flushSyncData()
	```



## 动态开启和关闭获取 AndroidID
使用  `FTSdk` 设置是否在 SDK中获取 Android ID

### 使用方法

=== "Java"

	```java
	   /**
	     * 动态控制获取 Android ID
	     *
	     * @param enableAccessAndroidID 是为应用，否为不应用
	     */
	    public static void setEnableAccessAndroidID(boolean enableAccessAndroidID)
	```

=== "Kotlin"

	```kotlin
	   /**
	     * 动态控制获取 Android ID
	     *
	     * @param enableAccessAndroidID 是为应用，否为不应用
	     */
	    fun setEnableAccessAndroidID(enableAccessAndroidID:Boolean)
	```

### 代码示例

=== "Java"

	```java
	// 开启获取 Android ID
	FTSdk.setEnableAccessAndroidID(true);

	// 关闭获取 Android ID
	FTSdk.setEnableAccessAndroidID(false);
	```

=== "Kotlin"

	```kotlin
	//开启获取 Android ID
	FTSdk.setEnableAccessAndroidID(true)

	//关闭获取 Android ID
	FTSdk.setEnableAccessAndroidID(false)
	```

## 添加自定义标签

使用  `FTSdk` 在 SDK运行时，动态添加标签

### 使用方法

=== "Java"

	```java
	/**
	 * 动态设置全局 tag
	 * @param globalContext
	 */
	public static void appendGlobalContext(HashMap<String,Object> globalContext)

	/**
	 * 动态设置 RUM 全局 tag
	 * @param globalContext
	 */
	public static void appendRUMGlobalContext(HashMap<String,Object> globalContext)

	/**
	 * 动态设置 log 全局 tag
	 * @param globalContext
	 */
	public static void appendLogGlobalContext(HashMap<String,Object> globalContext)

	```

=== "Kotlin"

	```kotlin
	/**
	 * 动态设置全局 tag
	 * @param globalContext
	 */
	fun appendGlobalContext(globalContext: HashMap<String, Any>) 

	/**
	 * 动态设置 RUM 全局 tag
	 * @param globalContext
	 */
	fun appendRUMGlobalContext(globalContext: HashMap<String, Any>) 

	/**
	 * 动态设置 log 全局 tag
	 * @param globalContext
	 */
	fun appendLogGlobalContext(globalContext: HashMap<String, Any>)

	```

### 代码示例

=== "Java"

	```java
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("global_key", "global_value");
	FTSdk.appendGlobalContext(globalContext);

	HashMap<String, Object> rumGlobalContext = new HashMap<>();
	rumGlobalContext.put("rum_key", "rum_value");
	FTSdk.appendRUMGlobalContext(rumGlobalContext);

	HashMap<String, Object> logGlobalContext = new HashMap<>();
	logGlobalContext.put("log_key", "log_value");
	FTSdk.appendLogGlobalContext(logGlobalContext);
	```

=== "Kotlin"

	```kotlin
	val globalContext = hashMapOf<String, Any>(
		"global_key" to "global_value"
	)
	FTSdk.appendGlobalContext(globalContext)

	val rumGlobalContext = hashMapOf<String, Any>(
		"rum_key" to "rum_value"
	)
	FTSdk.appendRUMGlobalContext(rumGlobalContext)

	val logGlobalContext = hashMapOf<String, Any>(
		"log_key" to "log_value"
	)
	FTSdk.appendLogGlobalContext(logGlobalContext)
	```

## R8 / Proguard 混淆配置 {#r8_proguard}

```java
-dontwarn com.ft.sdk.**

### ft-sdk 库
-keep class com.ft.sdk.**{*;}

### ft-native 库
-keep class ftnative.*{*;}

### 防止 Action 获取时 action_name 中类名被混淆###
-keepnames class * extends android.view.View
-keepnames class * extends android.view.MenuItem
```

## 符号文件上传 {#source_map}
### plugin 上传
`ft-plugin` 版本需要 `1.3.0` 以上版本支持最新的符号文件上传规则，支持 `productFlavor` 多版本区分管理，plugin 会在 `gradle task assembleRelease` 之后执行上传符号文件，详细配置可以参考 [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/build.gradle#L59)

``` groovy
FTExt {
	//...
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    datakitUrl = 'https://datakit.url'
    datawayToken = 'dataway_token'
    appId = "appid_xxxxx"// appid
    env = 'common'

    prodFlavors { //prodFlavors 配置会覆盖外层设置
        prodTest {
            autoUploadMap = false
            autoUploadNativeDebugSymbol = false
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodTest"
            env = "gray"
        }
        prodPublish {
            autoUploadMap = true
            autoUploadNativeDebugSymbol = true
            datakitUrl = 'https://datakit.url'
    		datawayToken = 'dataway_token'
            appId = "appid_prodPublish"
            env = "prod"
        }
    }
}

```
### 手动上传
需要开发者将符号文件自行打包成 `zip` 文件，然后自行上传至 `datakit` ，推荐使用 `zip` 命令行进行打包，避免将一些系统隐藏文件打入 `zip` 包中，符号上传请参考 [sourcemap 上传](../../integrations/rum.md#sourcemap)

> Unity Native Symbol 文件请参考[官方文档](https://docs.unity3d.com/Manual/android-symbols.html#public-symbols)

## 权限配置说明

| **名称** | **必须** | **使用原因** |
| --- | --- | --- |
| `READ_PHONE_STATE` | 否 |用于获取手机的设备信息，便于精准分析数据信息，在 SDK 中影响手机蜂窝网络信息的获取 |

> 关于如何申请动态权限，具体详情参考 [Android Developer](https://developer.android.google.cn/training/permissions/requesting?hl=en)

## Plugin AOP 忽略 {#ingore_aop}
通过 Plugin AOP 覆盖方法中添加 `@IngoreAOP` 来忽略 ASM 插入

=== "Java"

	```java
	View.setOnClickListener(new View.OnClickListener() {
            @Override
            @IgnoreAOP
            public void onClick(View v) {

            }
        }
	```
	
=== "Kotlin"

	```kotlin
	View.setOnClickListener @IngoreAOP{

        }
	```

## WebView 数据监测
WebView 数据监测，需要在 WebView 访问页面集成[Web 监测 SDK](../web/app-access.md)

## 自定义标签使用示例 {#track}

### 编译配置方式

1. 在 `build.gradle` 中创建多个 `productFlavors` 来做区分区分标签

```groovy
android{
    //…
	productFlavors {
        prodTest {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Test Value\""
 			//…
        }
        prodPublish {
            buildConfigField "String", "CUSTOM_VALUE", "\"Custom Publish Value\""
 			//…
        }
    }
}
```

2. 在 `RUM` 配置中添加对应 `BuildConfig` 常量

=== "Java"

	```java
	FTSdk.initRUMWithConfig(
	        new FTRUMConfig()
	            .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	            //... 添加其他配置
	);

	```
=== "Kotlin"

	```kotlin
	FTSdk.initRUMWithConfig(
	            FTRUMConfig()
	                .addGlobalContext(CUSTOM_STATIC_TAG, BuildConfig.CUSTOM_VALUE)
	                //… 添加其他配置
	        )
	```
### 运行时读写文件方式

1. 通过存文件类型数据，例如 `SharedPreferences`，配置使用 `SDK`，在配置处添加获取标签数据的代码。

=== "Java"

	```java
	SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	String customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set");

	// 配置 RUM
	FTSdk.initRUMWithConfig(
	     new FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue)
	     //… 添加其他配置
	);
	```

=== "Kotlin"

	```kotlin
	val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	val customDynamicValue = sp.getString(CUSTOM_DYNAMIC_TAG, "not set")

	//配置 RUM
	FTSdk.initRUMWithConfig(
	     FTRUMConfig().addGlobalContext(CUSTOM_DYNAMIC_TAG, customDynamicValue!!)
	     //… 添加其他配置
	)
	```

2. 在任意处添加改变文件数据的方法。

=== "Java"

	```java
	public void setDynamicParams(Context context, String value) {
	    SharedPreferences sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE);
	    sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply();
	}
	```

=== "Kotlin"

	```kotlin
	fun setDynamicParams(context: Context, value: String) {
	            val sp = context.getSharedPreferences(SP_STORE_DATA, MODE_PRIVATE)
	            sp.edit().putString(CUSTOM_DYNAMIC_TAG, value).apply()

	        }
	```

3.最后重启应用，详细细节请见 [SDK Demo](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L88)

### SDK 运行时添加

 在 SDK 初始化完毕之后，使用`FTSdk.appendGlobalContext(globalContext)`、`FTSdk.appendRUMGlobalContext(globalContext)`、`FTSdk.appendLogGlobalContext(globalContext)`，可以动态添加标签，设置完毕，会立即生效。随后，RUM 或 Log 后续上报的数据会自动添加标签数据。这种使用方式适合延迟获取数据的场景，例如标签数据需要网络请求获取。

```java
//SDK 初始化伪代码，从网络获取到参数后，再进行标签设置

FTSdk.init() 

getInfoFromNet(info){
	HashMap<String, Object> globalContext = new HashMap<>();
	globalContext.put("delay_key", info.value);
	FTSdk.appendGlobalContext(globalContext)
}

```


## 常见问题 {#FAQ}
### 添加局变量避免冲突字段 {#key-conflict}

为了避免自定义字段与 SDK 数据冲突，建议标签命名添加 **项目缩写** 的前缀，例如 `df_tag_name`，项目中使用 `key` 值可[查询源码](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java)。SDK 全局变量中出现与 RUM、Log 相同变量时，RUM、Log 会覆盖 SDK 中的全局变量。

### SDK 兼容性

* [可运行环境](app-troubleshooting.md#runnable)
* [可兼容环境](app-troubleshooting.md#compatible) 

### 应对市场隐私审核 {#adpot-to-privacy-audits}
#### 隐私声明
[前往查看](https://docs.guance.com/agreements/app-sdk-privacy-policy/)
#### 方式 1: SDK AndroidID 配置
SDK 为更好关联相同用户数据，会使用 Android ID。如果需要在应用市场上架，需要通过如下方式对应市场隐私审核。

=== "Java"

	```java
	public class DemoApplication extends Application {
	    @Override
	    public void onCreate() {
	        // 在初始化设置时将 setEnableAccessAndroidID 设置为 false
	        FTSDKConfig config = new FTSDKConfig.Builder(DATAKIT_URL)
	                .setEnableAccessAndroidID(false)
	                .build();
	        FTSdk.install(config);

	        // ...
	    }
	}

	// 用户同意隐私协议后再开启
	FTSdk.setEnableAccessAndroidID(true);
	```

=== "Kotlin"

	```kotlin
	class DemoApplication : Application() {
	    override fun onCreate() {

	        //在初始化设置时将  setEnableAccessAndroidID 设置为 false
	        val config = FTSDKConfig
	            .builder(DATAKIT_URL)
	            . setEnableAccessAndroidID(false)

	        FTSdk.install(config)

	        //...
	    }
	}

	//用户同意隐私协议后再开启
	FTSdk.setEnableAccessAndroidID(true);
	```
#### 方式 2：延迟初始化 SDK
如果需要在应用中延迟加载 SDK，建议使用如下方式初始化。

=== "Java"

	```java
	// Application
	public class DemoApplication extends Application {
		@Override
		public void onCreate() {
		    //如果已经同意协议，在 Application 中初始化
			if(agreeProtocol){
				FTSdk.init(); //SDK 初始化伪代码
			}
		}
	}
	
	// 隐私声明  Activity 页面
	public class MainActivity extends Activity {
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			//未阅读隐私声明
			if ( notReadProtocol ) {
			    //隐私声明弹出弹窗
				showProtocolView();
	
			    //如果同意隐私声明
				if( agreeProtocol ){
					FTSdk.init(); //SDK 初始化伪代码
				}
			}
		}
	}
	```
	
=== "Kotlin"

	```kotlin
	// Application	
	class DemoApplication : Application() {
	    override fun onCreate() {
	        // 如果已经同意协议，在 Application 中初始化
	        if (agreeProtocol) {
	            FTSdk.init() //SDK 初始化伪代码
	        }
	    }
	}
	
	// 隐私声明 Activity 页面
	class MainActivity : Activity() {
	    override fun onCreate(savedInstanceState: Bundle?) {
	        // 未阅读隐私声明
	        if (notReadProtocol) {
	            // 隐私声明弹出弹窗
	            showProtocolView()
	
	            // 如果同意隐私声明
	            if (agreeProtocol) {
	                FTSdk.init() //SDK 初始化伪代码
	            }
	        }
	    }
	}
	```
#### 第三方框架 {#third-party}
`flutter`、`react-native`、`unity` 可以采用与以上原生 Android 相似延迟初始化方式，来应对应用市场隐私审核。

### 不使用 ft-plugin 情况下如何接入 SDK {#manual-set}
观测云使用的 Androig Grale Plugin Transformation 实现的代码注入，从而实现数据自动收集。但是由于一些兼容性问题，可能存在无法使用 `ft-plugin` 的问题。受影响包括 **RUM** `Action`，`Resource`，和 `android.util.Log` ，Java 与 Kotlin `println` **控制台日志自动抓取**，以及符号文件的自动上传。

目前针对这种情况，我们有另外一种集成方案，应对方案如下：

* Application 应用启动事件， 源码示例参考[DemoForManualSet.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoForManualSet.kt)

=== "Java"

	```java
	// Application
	@Override
	public void onCreate() {
	    super.onCreate();
	    //需要在 SDK 初始化前调用
	    FTAutoTrack.startApp(null);
	    //设置 SDK 配置
	    setSDK(this);
	}
	```

=== "Kotlin"

	```kotlin
	  //Application
	    override fun onCreate() {
	        super.onCreate()
		//需要在 SDK 初始化前调用
	        FTAutoTrack.startApp(null)
	        //设置 SDK 配置
	        setSDK(this)

	    }
	```

* 按键等事件需要在触发处自行添加，例如，Button onClick 事件为例，源码示例参考 [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt)：

=== "Java"

	```java
	view.setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	        FTRUMGlobalManager.get().startAction("[action button]", "click");
	    }
	});

	```

=== "Kotlin"

	```kotlin
		view.setOnClickListener{
			FTRUMGlobalManager.get().startAction("[action button]", "click")
		}
	```

* `OKhttp` 通过 `addInterceptor` ，`eventListener` 方式接入 `Resource`，`Trace`，示例如下，源码示例参考 [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt)：

=== "Java"

	```java
	OkHttpClient.Builder builder = new OkHttpClient.Builder()
	.addInterceptor(new FTTraceInterceptor())
	.addInterceptor(new FTResourceInterceptor())
	.eventListenerFactory(new FTResourceEventListener.FTFactory());
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true));
	OkHttpClient client = builder.build();
	```

=== "Kotlin"

	```kotlin
	val builder = OkHttpClient.Builder()
	.addInterceptor(FTTraceInterceptor())
	.addInterceptor(FTResourceInterceptor())
	.eventListenerFactory(FTResourceEventListener.FTFactory())
	//.eventListenerFactory(new FTResourceEventListener.FTFactory(true))
	val client = builder.build()
	```

* 其他网络框架需要自行实现使用 `FTRUMGlobalManager` 中 `startResource` ,`stopResource`,`addResource`, `FTTraceManager.getTraceHeader` 。具体实现方式，请参考源码示例 [ManualActivity.kt](https://github.com/GuanceDemo/guance-app-demo/blob/master/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/ManualActivity.kt)