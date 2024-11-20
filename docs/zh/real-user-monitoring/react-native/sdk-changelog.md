# 更新日志

## **0.3.6 (2024/11/06)**

* 适配 iOS SDK 1.5.5
  * 修复 `FTResourceMetricsModel` 中数组越界导致的崩溃问题
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
* 适配 Android SDK ft-sdk 1.6.1
  * 修复 RUM 单独调用自定义 startView，导致监控指标 FTMetricsMTR 线程未被回收的问题
  * 支持通过 FTSdk.appendGlobalContext(globalContext)、FTSdk.appendRUMGlobalContext(globalContext)、FTSdk.appendLogGlobalContext(globalContext)添加动态属性
  *	支持通过 FTSdk.clearAllData() 清理未上报缓存数据
  * SDK setSyncSleepTime 最大限制延长为 5000 ms
* 适配 iOS SDK 1.5.4
  * 添加全局、log、RUM globalContext 属性动态设置方式
  * 添加清除数据方法，支持删除所有尚未上传至服务器的数据
  * 调整同步间歇支持的最大时间间隔至 5000 毫秒

## **0.3.3 (2024/10/09)**

* 适配 iOS SDK 1.5.3
  * 修复 LongTask、Anr 采集时因属性修饰符使用错误而导致的内存访问错误崩溃
  * 使用内部警告日志替换 `FTSwizzler` 中方法签名验证断言
  * 优化采集数据的小数精度

## **0.3.2 (2024/08/28)**

* 修复 Android 配置 `FTMobileConfig.env` 无效问题

## **0.3.1 (2024/08/21)**

* 兼容修复 React 版本低于 16.14.0 时使用 `react/jsx-runtime` 报错
* Android 兼容 react native 0.63 低版本
* 修改过滤指向本地主机（localhost）URL 的正则表达式，增加匹配范围
* 适配 iOS SDK 1.5.2
  * 修复 Xcode 16 编译缺少 `#include <arm/_mcontext.h>` 头文件问题
  * 自动采集 RUM-Resource 时，过滤掉直接从本地缓存获取或获取类型未知的 Resource，防止采集重复
  * 修复 UITabBarController 子视图 loadingTime 计算逻辑
## **0.3.0 (2024/08/16)**

* 新增支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数
* RUM resource 网络请求添加 remote ip 地址解析功能
* 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
* 日志添加自定义 status 方法
* react-native 采集 action 方法修改，适配 React 17 无法从 React.createElement 拦截点击事件问题
* 在 Debug 场景下，RUM Resource 采集过滤掉指向本地主机（localhost）的热更新连接
* 修正 Android 底层 Double 适配问题

[更多日志](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)
