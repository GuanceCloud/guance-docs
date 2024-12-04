# 更新日志
---
<div class="grid cards" markdown>
- [__ft-sdk__](#ft-sdk)
- [__ft-plugin__](#ft-plugin)
- [__ft-native__](#ft-native)  
- [__ft-plugin-legacy__](#ft-plugin-legacy)  
</div>

## **ft-sdk** {#ft-sdk}
### **1.6.3 (2024/11/18)** {#ft-sdk-1-6-3}
1. 优化自定义 `addAction` 在高频率调用时的性能表现
2. 支持使用  `FTSDKConfig.setCompressIntakeRequests` 对同步数据进行 `deflate` 压缩配置
### **1.6.2 (2024/10/24)** {#ft-sdk-1-6-2}
1. RUM 新增 `addAction` 方法，支持 property 扩展属性与频繁连续数据上报
### **1.6.1 (2024/10/18)** {#ft-sdk-1-6-1}
1. 修复 RUM 单独调用自定义 `startView`，导致监控指标 `FTMetricsMTR` 线程未被回收的问题
2. 支持通过 `FTSdk.appendGlobalContext(globalContext)`、`FTSdk.appendRUMGlobalContext(globalContext)`、
    `FTSdk.appendLogGlobalContext(globalContext)`添加动态属性
3. 支持通过 `FTSdk.clearAllData()` 清理未上报缓存数据
4. SDK `setSyncSleepTime` 最大限制延长为 5000 ms
### **1.6.0 (2024/08/18)** {#ft-sdk-1-6-0}
1. 优化数据存储和同步性能
（旧版本升级至 1.6.0 需要配置 `FTSDKConfig.setNeedTransformOldCache` 进行旧数据兼容同步）
2. 修复在使用 ft-plugin 时，调用 `Log.w(String,Throwable)` 引发异常的问题
### **1.5.2 (2024/07/10)** {#ft-sdk-1-5-2}
1. Error network_error 添加本地网络错误类型的提示，用于补充说明 Resource 数据中 resource_status=0 场景
2. 修复 `setEnableTrackAppCrash(false)` 时 uncaughtException rethrow 传递问题
### **1.5.1 (2024/06/19)** {#ft-sdk-1-5-1}
1. Java Crash 及 ANR 补充其他线程代码堆栈
2. Java Crash，Native Crash，ANR 添加附加 logcat 配置功能
3. 修复长 session 且无 action 更新场景下，频繁更新 session_id 的问题
### **1.5.0 (2024/06/03)** {#ft-sdk-1-5-0}
1. RUM resource 网络请求添加 remote ip 地址解析功能
2. 修复开启 RUM SampleRate 后，高并发网路请求引发的数组线程安全问题
3. `ConnectivityManager.registerDefaultNetworkCallback` 方法容错优化
4. 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
5. 自动采集 Action click 中控件资源名 id 获取优化
6. SDK config 配置读取异常问题容错优化
### **1.4.6 (2024/05/15)** {#ft-sdk-1-4-6}
1. SDK 初始化容错优化
2. 新增日志新增 Status.Debug 类型
3. 控制台抓取日志等级对应关系调整： `Log.i` -> `info`，`Log.d` -> `debug`
4. FTLogger 自定义日志支持自定义 status 字段
### **1.4.5 (2024/04/26)** {#ft-sdk-1-4-5}
1. 重复初始化兼容优化处理
2. 优化 c/c++ 崩溃采集数据同步逻辑，避免在某些场景下意外中断退出，导致死锁
3. 优化 startAction Property 属性写入逻辑，避免发生线程安全访问问题	
### **1.4.4 (2024/04/01)** {#ft-sdk-1-4-4}
1. 数据库链接容错保护
2. 修正 `setOnlySupportMainProcess` true 时，子进程配置部份不起效问题
3. 修正 RUM 不开启 View 采集, Crash 不会 rethrow 的问题
### **1.4.3 (2024/03/22)** {#ft-sdk-1-4-3}
1. 支持 Dataway 与 Datakit 的地址上传
2. 支持发送 Action，View，Resource，LongTask，Error 类型的 RUM 数据。
    - View，Action 页面跳转，控件点击操作自动采集，需要使用 ft-plugin
    - Resource，自动采集，仅支持 Okhttp，并需要使用 ft-plugin
    - Error 中的 Native Crash 和 ANR 需要使用 ft-native
3. 支持发送 Log 数据，控制台自动写入，需要使用 ft-plugin
4. 链路 http header propagation，仅支持 Okhttp，并需要使用 ft-plugin
5. 支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数。
6. 支持 SDK 内部日志转化为文件

[更多日志](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/CHANGELOG.md)

## **ft-native** {#ft-native}
### **1.1.1 (2024/06/22)** {#ft-native-1-1-1}
1. 添加 Native Crash 和 ANR 中 logcat 配置功能
### **1.1.0 (2024/03/22)** {#ft-native-1-1-0}
1. 支持捕获 ANR Crash
2. 支持捕获 C/C++ Native Crash
3. 支持崩溃时采集应用运行状态
4. 支持 ANR 和 Native Crash 触发回调用

[更多日志](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-native/CHANGELOG.md)

## **ft-plguin ( AGP >=7.4.2 )** {#ft-plugin}
### **1.3.3 (2024/09/04)**：
1. 优化 native symbol so 自动获取上传，支持自定义指定 nativeLibPath
### **1.3.2 (2024/08/13)**：
1. 支持 React Native WebView 事件自动捕获
### **1.3.1 (2024/07/04)**：
1. 添加 asmVersion 配置功能，支持 asm7 - asm9，默认为 asm9
2. 修复了 WebView 自定义方法在 ASM 写入后导致循环调用，从而无法加载 WebView 内容的问题
    (涉及方法 `loadUrl`、`loadData`、`loadDataWithBaseURL`、 `postUrl`)
3. IgnoreAOP 支持在类中声明，进行整个类中的方法忽略
4. 添加 `ignorePackages` 配置， 支持通过包路径配置对 ASM 进行忽略
### **1.3.0 (2024/03/22)**：
1. 支持 datakit source map 自动上传，支持 native symbol 的上传
2. 支持捕获 Application 冷热启动，Activity 页面跳转，View、ListView、Dialog、Tab 点击事件。
3. 支持 Webview Js 监听方法的写入
4. 支持 Okhttp Trace 和 Resource 数据自动写入
5. 支持 Gradle 8.0,AGP 8.0 
6. 支持 IgnoreAOP 忽略标记
7. 支持兼容阿里云热修复框架

[更多日志](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-plugin/CHANGELOG.md)
   
## **ft-plugin-legacy ( AGP <=7.4.2 )** {#ft-plugin-legacy}
### **1.1.8 (2024/08/13)**：
1. 支持 React Native WebView 事件自动捕获
### **1.1.7 (2024/07/04)**：
1. 修复了 WebView 子类重写方法在 ASM 写入后导致循环调用，从而无法加载 WebView 内容的问题
    (涉及方法 `loadUrl`、`loadData`、`loadDataWithBaseURL`、 `postUrl`)
2. IgnoreAOP 支持在类中声明，进行整个类中的方法忽略
3. 添加 `ignorePackages` 配置， 支持通过包路径配置对 ASM 进行忽略
### **1.1.6 (2024/03/22)**：
1. 支持 datakit source map 自动上传，支持 native symbol 的上传
2. 支持捕获 Application 冷热启动，Activity 页面跳转，View、ListView、Dialog、Tab 点击事件。
3. 支持 Webview Js 监听方法的写入
4. 支持 Okhttp Trace 和 Resource 数据自动写入
5. 支持 AGP 7.4.2 以下的版本
6. 支持 IgnoreAOP 忽略标记
7. 支持兼容阿里云热修复框架

[更多日志](https://github.com/GuanceCloud/datakit-android/blob/plugin_legacy_support/ft-plugin/CHANGELOG.md)
