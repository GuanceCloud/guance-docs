# 更新日志
## 0.3.12 (2025/03/07)
* `FTMobileConfig.enableDataIntegerCompatible` 默认开启
* 适配 Android ft-sdk [1.6.9](../android/sdk-changelog.md/#ft-sdk-1-6-9)，iOS [1.5.12](../ios/sdk-changelog.md/#1-5-12)、[1.5.13](../ios/sdk-changelog.md/#1-5-13)、[1.5.14](../ios/sdk-changelog.md/#1-5-14)

## 0.3.11 (2025/02/05)

* 原生 与 React Native 混合开发 SDK 配置优化
    * 支持通过  `FTRumActionTracking.startTracking()` 方法，自动采集 React Native 控件点击事件， `FTRumErrorTracking.startTracking()` 方法，自动采集 React Native 错误日志
    * 开启 RUM Resource 自动采集时，新增方法 iOS 端 `FTReactNativeUtils.filterBlackResource(url)`、Android 端 `ReactNativeUtils.isReactNativeDevUrl(url)` 过滤开发环境中的 React Native 符号化请求及 Expo 日志请求，减少冗余数据
* 适配 iOS SDK [1.5.11](../ios/sdk-changelog.md/#1-5-11)

## **0.3.10 (2025/01/21)**

* 修改 iOS bridge 代码中引用 native SDK 头文件方式

*  新增 RUM 条目数量限制功能、支持通过 `FTRUMConfig.rumCacheLimitCount` 来限制 SDK 最大缓存条目数据限制，支持通过 `FTRUMConfig.rumDiscardStrategy` 设置来指定丢弃新数据或丢弃旧数据

* 新增支持通过 `FTMobileConfig.enableLimitWithDbSize` 限制总缓存大小功能，开启之后`FTLoggerConfig.logCacheLimitCount` 及 `FTRUMConfig.rumCacheLimitCount` 将失效，支持通过 `FTMobileConfig.dbDiscardStrategy` 设置 db 废弃策略，支持通过 `FTMobileConfig.dbCacheLimit` 设置 db 缓存限制大小

* 适配 iOS SDK [1.5.8](../ios/sdk-changelog.md/#1-5-8) 、[1.5.9](../ios/sdk-changelog.md/#1-5-9)、[1.5.10](../ios/sdk-changelog.md/#1-5-10)
* Android SDK ft-sdk [1.6.6](../android/sdk-changelog.md/#ft-sdk-1-6-6)、[1.6.7](../android/sdk-changelog.md/#ft-sdk-1-6-7)、[1.6.8](../android/sdk-changelog.md/#ft-sdk-1-6-8)

## **0.3.9 (2024/12/24)**

* 为提升 React Android 兼容性，更改 Android React Native Bridge 部分由 Kotlin 语言为 Java
* 适配 Android SDK ft-sdk [1.6.5](../android/sdk-changelog.md/#ft-sdk-1-6-5)

## **0.3.7 (2024/12/04)**

* 修正 Android RN 错误数据类型标注错误的问题
* 支持通过 `FTRUMConfig.nativeFreezeDurationMs` 设置卡顿检测阀值
* 支持使用 `FTMobileConfig.compressIntakeRequests` 对同步数据进行 `deflate` 压缩配置
* 适配 iOS SDK [1.5.6](../ios/sdk-changelog.md/#1-5-6) 、[1.5.7](../ios/sdk-changelog.md/#1-5-7)
* 适配 Android SDK ft-sdk [1.6.2](../android/sdk-changelog.md/#ft-sdk-1-6-2)、[1.6.3](../android/sdk-changelog.md/#ft-sdk-1-6-3)、[1.6.4](../android/sdk-changelog.md/#ft-sdk-1-6-4)

## **0.3.6 (2024/11/06)**

* 适配 iOS SDK [1.5.5](../ios/sdk-changelog.md/#1-5-5)

## **0.3.5 (2024/10/23)**

* 支持采集 Native Error、ANR、Freeze
* 修改 react-native 自动采集 error 的默认错误类型
* 对拥有 `onPress` 属性的组件，新增支持在开启 `enableAutoTrackUserAction` 后通过添加自定义属性 
  `ft-enable-track` 定义是否采集该组件的点击事件、通过 `ft-extra-property` 添加 Action 额外属性

## **0.3.4 (2024/10/19)**

* 支持全局动态添加 globalContext 属性
* 支持通过 `FTReactNativeRUM.addErrorWithType()` 自定错误类型
* 支持通过 `FTMobileReactNative.shutDown()` 关闭 SDK
* 支持通过 `FTMobileReactNative.clearAllData()` 清理未上报缓存数据
* 修复自动采集 react-native Error 时，参数 `stack` 与 `message` 赋值相反问题
* 适配 Android SDK ft-sdk [1.6.1](../android/sdk-changelog.md/#ft-sdk-1-6-1)
* 适配 iOS SDK [1.5.4](../ios/sdk-changelog.md/#1-5-4)

## **0.3.3 (2024/10/09)**

* 适配 iOS SDK [1.5.3](../ios/sdk-changelog.md/#1-5-3)

## **0.3.2 (2024/08/28)**

* 修复 Android 配置 `FTMobileConfig.env` 无效问题

## **0.3.1 (2024/08/21)**

* 兼容修复 React 版本低于 16.14.0 时使用 `react/jsx-runtime` 报错
* Android 兼容 react native 0.63 低版本
* 修改过滤指向本地主机（localhost）URL 的正则表达式，增加匹配范围
* 适配 iOS SDK [1.5.2](../ios/sdk-changelog.md/#1-5-2)
## **0.3.0 (2024/08/16)**

* 新增支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数
* RUM resource 网络请求添加 remote ip 地址解析功能
* 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
* 日志添加自定义 status 方法
* react-native 采集 action 方法修改，适配 React 17 无法从 React.createElement 拦截点击事件问题
* 在 Debug 场景下，RUM Resource 采集过滤掉指向本地主机（localhost）的热更新连接
* 修正 Android 底层 Double 适配问题

[更多日志](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)





